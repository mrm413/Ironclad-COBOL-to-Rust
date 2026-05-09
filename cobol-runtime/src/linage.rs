// linage.rs — LINAGE (page-based output) runtime support for COBOL file I/O.
//
// LINAGE defines a logical page layout for a sequential output file:
//   LINAGE IS n LINES           — body area (writable lines per page)
//   WITH FOOTING AT f           — footing trigger line (within body)
//   LINES AT TOP t              — blank lines before body on each page
//   LINES AT BOTTOM b           — blank lines after body on each page
//
// The LINAGE-COUNTER special register tracks the current line within the body
// area (1-based). When a WRITE causes the counter to exceed the body size,
// the runtime auto-advances to the next page (emitting blank lines for the
// bottom margin and top margin) and resets LINAGE-COUNTER to 1.
//
// The END-OF-PAGE condition fires when the counter reaches or passes the
// footing line after a WRITE.

use std::collections::HashMap;
use std::cell::RefCell;
use crate::CobolFile;
use crate::FileStatus;

/// Per-file LINAGE state, stored alongside the CobolFile handle.
#[derive(Debug, Clone)]
pub struct LinageState {
    /// Body area: number of writable lines per page
    pub body_lines: usize,
    /// Footing trigger line (1-based, within body). 0 = no footing.
    pub footing_at: usize,
    /// Blank lines at top of each page (before body)
    pub lines_at_top: usize,
    /// Blank lines at bottom of each page (after body)
    pub lines_at_bottom: usize,
    /// Current line position within the body area (1-based).
    /// Starts at 1 on OPEN OUTPUT and after each page eject.
    pub current_line: usize,
    /// Whether the file has been initialized (first write emits top margin)
    pub initialized: bool,
}

impl LinageState {
    pub fn new(body: usize, footing: usize, top: usize, bottom: usize) -> Self {
        LinageState {
            body_lines: body,
            footing_at: footing,
            lines_at_top: top,
            lines_at_bottom: bottom,
            current_line: 1,
            initialized: false,
        }
    }

    /// Total physical lines per page (top margin + body + bottom margin).
    pub fn page_size(&self) -> usize {
        self.lines_at_top + self.body_lines + self.lines_at_bottom
    }
}

/// Result of a LINAGE-aware write: whether END-OF-PAGE was triggered.
pub struct LinageWriteResult {
    pub end_of_page: bool,
    pub linage_counter: usize,
}

// ── Global LINAGE state registry ──────────────────────────────────────
// Generated code calls linage_get_state() to obtain a mutable reference
// to the LinageState for a given file key. The state is initialized on
// first access with the LINAGE parameters from the FD clause.

thread_local! {
    static LINAGE_REGISTRY: RefCell<HashMap<String, LinageState>> = RefCell::new(HashMap::new());
}

/// Get or create the LinageState for a file.  Returns (end_of_page, linage_counter)
/// after performing a LINAGE-aware write.
///
/// This is the primary entry point for generated code. It handles the
/// thread-local registry internally so callers need only pass parameters.
pub fn linage_do_write(
    fh: &mut CobolFile,
    file_key: &str,
    body: usize, footing: usize, top: usize, bottom: usize,
    line_data: &str,
    advance_lines: usize,
) -> Result<LinageWriteResult, FileStatus> {
    LINAGE_REGISTRY.with(|reg| {
        let mut map = reg.borrow_mut();
        let state = map.entry(file_key.to_string())
            .or_insert_with(|| LinageState::new(body, footing, top, bottom));
        linage_write(fh, state, line_data, advance_lines)
    })
}

/// Perform a LINAGE-aware WRITE AFTER ADVANCING PAGE.
pub fn linage_do_write_page(
    fh: &mut CobolFile,
    file_key: &str,
    body: usize, footing: usize, top: usize, bottom: usize,
    line_data: &str,
) -> Result<LinageWriteResult, FileStatus> {
    LINAGE_REGISTRY.with(|reg| {
        let mut map = reg.borrow_mut();
        let state = map.entry(file_key.to_string())
            .or_insert_with(|| LinageState::new(body, footing, top, bottom));
        linage_write_page(fh, state, line_data)
    })
}

/// Reset LINAGE state for a file (called on CLOSE).
pub fn linage_reset(file_key: &str) {
    LINAGE_REGISTRY.with(|reg| {
        reg.borrow_mut().remove(file_key);
    });
}

// ── Core write functions ──────────────────────────────────────────────

/// Write a line to a LINAGE file, handling page overflow and margins.
///
/// `advance_lines`: number of lines to advance BEFORE the write (AFTER ADVANCING n).
///   For the default write (no ADVANCING clause), advance_lines = 1.
///   For AFTER ADVANCING PAGE, the caller should call `linage_write_page` instead.
///
/// Returns Ok(LinageWriteResult) with the new LINAGE-COUNTER value and whether
/// END-OF-PAGE was triggered.
pub fn linage_write(
    fh: &mut CobolFile,
    state: &mut LinageState,
    line_data: &str,
    advance_lines: usize,
) -> Result<LinageWriteResult, FileStatus> {
    // First write: emit top-of-page margin
    if !state.initialized {
        for _ in 0..state.lines_at_top {
            fh.write_line("")?;
        }
        state.initialized = true;
        state.current_line = 1;
    }

    // Advance lines before the actual write
    // Each advance increments the current line; if we overflow, eject page
    for _ in 0..advance_lines.saturating_sub(1) {
        if state.current_line > state.body_lines {
            // Page overflow: emit bottom margin + top margin for new page
            eject_page(fh, state)?;
        }
        fh.write_line("")?;
        state.current_line += 1;
    }

    // Check if current position already overflows
    if state.current_line > state.body_lines {
        eject_page(fh, state)?;
    }

    // Write the actual data line
    fh.write_line(line_data)?;
    let wrote_at = state.current_line;
    state.current_line += 1;

    // Determine if END-OF-PAGE condition is triggered:
    // EOP fires when the line just written is at or past the footing line
    let eop = if state.footing_at > 0 {
        wrote_at >= state.footing_at
    } else {
        // No footing: EOP fires when body area is full
        state.current_line > state.body_lines
    };

    Ok(LinageWriteResult {
        end_of_page: eop,
        linage_counter: state.current_line.min(state.body_lines + 1),
    })
}

/// Write with AFTER ADVANCING PAGE: eject to new page, then write at line 1.
pub fn linage_write_page(
    fh: &mut CobolFile,
    state: &mut LinageState,
    line_data: &str,
) -> Result<LinageWriteResult, FileStatus> {
    if !state.initialized {
        // First write: just emit top margin
        for _ in 0..state.lines_at_top {
            fh.write_line("")?;
        }
        state.initialized = true;
        state.current_line = 1;
    } else {
        // Eject the current page
        eject_page(fh, state)?;
    }

    // Write the data at line 1 of the new page
    fh.write_line(line_data)?;
    state.current_line = 2; // next line is 2

    Ok(LinageWriteResult {
        end_of_page: false,
        linage_counter: state.current_line,
    })
}

/// Emit blank lines to fill the rest of the body + bottom margin + top margin,
/// resetting the state to line 1 of a new page.
fn eject_page(fh: &mut CobolFile, state: &mut LinageState) -> Result<(), FileStatus> {
    // Fill remaining body lines
    while state.current_line <= state.body_lines {
        fh.write_line("")?;
        state.current_line += 1;
    }
    // Bottom margin
    for _ in 0..state.lines_at_bottom {
        fh.write_line("")?;
    }
    // Top margin for the new page
    for _ in 0..state.lines_at_top {
        fh.write_line("")?;
    }
    state.current_line = 1;
    Ok(())
}
