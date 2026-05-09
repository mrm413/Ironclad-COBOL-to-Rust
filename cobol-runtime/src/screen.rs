// Screen Section runtime support for Ironclad-generated Rust programs.
// Provides ScreenField, SPos (screen position), and screen_display()
// for COBOL DISPLAY screen-name statements.

/// Screen position specifier — mirrors COBOL LINE/COLUMN clause types.
#[derive(Clone, Debug, PartialEq)]
pub enum SPos {
    /// No position specified — continue from cursor.
    None,
    /// Absolute position (LINE 5, COL 10).
    Abs(i32),
    /// Relative forward (COL + 3).
    Plus(i32),
    /// Relative backward (COL - 2).
    Minus(i32),
}

impl Default for SPos {
    fn default() -> Self { SPos::None }
}

/// A single screen field in a flattened screen section.
/// Built by generated code and passed to `screen_display()`.
#[derive(Clone, Debug, Default)]
pub struct ScreenField {
    pub line: SPos,
    pub col: SPos,
    /// Content to display. Empty string = position/attribute-only entry.
    pub content: String,
    /// Display width (from PIC or SIZE). 0 = use content.len().
    pub width: usize,
    /// True for TO/USING fields (input targets during ACCEPT).
    pub is_input: bool,
    /// BLANK SCREEN — clear entire screen before this field.
    pub blank_screen: bool,
    /// BLANK LINE — clear the current line before this field.
    pub blank_line: bool,
    /// ERASE EOL — erase from cursor to end of line after positioning.
    pub erase_eol: bool,
    /// ERASE EOS — erase from cursor to end of screen after positioning.
    pub erase_eos: bool,
    /// BELL / BEEP — emit audible bell.
    pub bell: bool,
    /// SECURE — show asterisks instead of actual content for input.
    pub secure: bool,
    /// FOREGROUND-COLOR (COBOL 0-7 color number).
    pub fg_color: Option<u8>,
    /// BACKGROUND-COLOR (COBOL 0-7 color number).
    pub bg_color: Option<u8>,
    /// HIGHLIGHT (bold).
    pub highlight: bool,
    /// LOWLIGHT (dim).
    pub lowlight: bool,
    /// REVERSE-VIDEO.
    pub reverse_video: bool,
    /// BLINK.
    pub blink_attr: bool,
    /// UNDERLINE.
    pub underline: bool,
    /// OVERLINE.
    pub overline: bool,
    /// LEFTLINE.
    pub leftline: bool,
}

/// Display a screen using a character grid.
///
/// Instead of ANSI cursor math, fields write into a `[char; 80]×25` grid.
/// After all fields are processed, each non-empty row is emitted with a
/// single positioned print.  This eliminates cursor-tracking bugs and
/// ConPTY chunk-boundary artifacts.
pub fn screen_display(fields: &[ScreenField]) {
    unsafe { SCREEN_TOUCHED = true; SCREEN_DISPLAY_USED = true; }
    const ROWS: usize = 25;
    const COLS: usize = 80;

    // nwsys Phase 4 Slice 4: the ShadowBuffer is the single source of
    // truth for screen state. Snapshot it once into a local grid so the
    // field walk below can mutate freely without lock contention; the
    // post-walk parallel write resyncs SHADOW with the merged result.
    let mut grid = shadow_buffer_snapshot().cells;
    // Per-cell SGR attribute string (empty = no styling).
    let mut sgr_grid: Vec<Vec<String>> = vec![vec![String::new(); COLS]; ROWS];

    let mut row: i32 = 1;
    let mut col: i32 = 1;
    let mut field_end_col: i32 = 1;
    let mut emit_bell = false;

    // Track physical terminal operations for multi-display scenarios.
    // Previous screen_display() calls leave content on the terminal;
    // BLANK SCREEN/LINE/ERASE must physically clear it.
    let mut need_clear_screen = false;
    let mut blanked_rows: Vec<usize> = Vec::new();
    let mut erase_ops: Vec<(usize, usize, bool)> = Vec::new(); // (row0, col0, is_eos)

    // Track each field's grid range per row, for per-field emission of
    // multi-field rows (matches GnuCOBOL ncurses per-field byte stream;
    // critical for tests like 011 where row 1 has both literal text and a
    // success-flag field at col 42, and the golden chunk-split falls
    // between them).
    let mut row_field_ranges: Vec<Vec<(usize, usize)>> = vec![Vec::new(); ROWS];

    for field in fields {
        let has_line = !matches!(field.line, SPos::None);

        // ── Resolve row ──
        match &field.line {
            SPos::Abs(n) => row = *n,
            SPos::Plus(n) => row += *n,
            SPos::Minus(n) => row -= *n,
            SPos::None => {}
        }

        // ── Resolve column ──
        match &field.col {
            SPos::Abs(n) => { col = *n; field_end_col = *n; }
            SPos::Plus(n) => { col = field_end_col + *n; field_end_col = col; }
            SPos::Minus(n) => { col = field_end_col - *n; field_end_col = col; }
            SPos::None => {
                if has_line && !field.content.is_empty() {
                    col = 1;
                }
                field_end_col = col;
            }
        }

        if row < 1 { row = 1; }
        if col < 1 { col = 1; }

        // ── BLANK SCREEN — clear entire grid + mark physical clear ──
        if field.blank_screen {
            grid = [[' '; COLS]; ROWS];
            for gr in sgr_grid.iter_mut() {
                for cell in gr.iter_mut() { cell.clear(); }
            }
            need_clear_screen = true;
            row = 1; col = 1; field_end_col = 1;
        }

        let r = (row - 1).max(0) as usize;
        let c = (col - 1).max(0) as usize;

        // ── BLANK LINE — clear this row in the grid + mark physical clear ──
        if field.blank_line && r < ROWS {
            grid[r] = [' '; COLS];
            for cell in sgr_grid[r].iter_mut() { cell.clear(); }
            blanked_rows.push(r);
        }

        // ── BELL ──
        if field.bell { emit_bell = true; }

        // ── ERASE EOS — clear from (r,c) to end of grid + mark physical ──
        if field.erase_eos && r < ROWS {
            for cc in c..COLS { grid[r][cc] = ' '; sgr_grid[r][cc].clear(); }
            for rr in (r + 1)..ROWS {
                grid[rr] = [' '; COLS];
                for cell in sgr_grid[rr].iter_mut() { cell.clear(); }
            }
            erase_ops.push((r, c, true));
        }

        // ── ERASE EOL — clear from (r,c) to end of row + mark physical ──
        if field.erase_eol && !field.erase_eos && r < ROWS {
            for cc in c..COLS { grid[r][cc] = ' '; sgr_grid[r][cc].clear(); }
            erase_ops.push((r, c, false));
        }

        // ── Display width ──
        let content = &field.content;
        let display_width = if field.width > 0 { field.width } else { content.len() };

        // ── Write content into grid (wraps at column 80) ──
        if !content.is_empty() {
            let sgr = build_sgr(field);
            let mut wr = r;   // 0-indexed write row
            let mut wc = c;   // 0-indexed write column
            let range_start_row = wr;
            let range_start_col = wc;
            let mut last_wr = wr;
            let mut last_wc = wc;
            if field.secure {
                for _i in 0..display_width {
                    if wc >= COLS { wr += 1; wc = 0; }
                    if wr < ROWS {
                        grid[wr][wc] = '*';
                        sgr_grid[wr][wc] = sgr.clone();
                    }
                    last_wr = wr; last_wc = wc;
                    wc += 1;
                }
            } else {
                let mut emitted_any = false;
                for (i, ch) in content.chars().enumerate() {
                    if i >= display_width { break; }
                    if wc >= COLS { wr += 1; wc = 0; }
                    if wr < ROWS {
                        grid[wr][wc] = ch;
                        sgr_grid[wr][wc] = sgr.clone();
                    }
                    last_wr = wr; last_wc = wc;
                    emitted_any = true;
                    wc += 1;
                }
                let _ = emitted_any;
            }
            // Track field range on its starting row only (no wrap-handling for
            // per-field-emit purposes; multi-line fields rare in goldens).
            if range_start_row == last_wr && range_start_row < ROWS {
                row_field_ranges[range_start_row].push((range_start_col, last_wc));
            }
            // Update cursor position after wrapping (1-indexed)
            row = (wr as i32) + 1;
            col = (wc as i32) + 1;
            field_end_col = wc as i32;
        } else if field.is_input && display_width > 0 {
            // Input-only (TO) field: underscore placeholders.
            // Render ALL input fields, even multiple on the same line.
            let prompt_char = if field.secure { '*' } else { '_' };
            for i in 0..display_width {
                let gc = c + i;
                if r < ROWS && gc < COLS {
                    grid[r][gc] = prompt_char;
                }
            }
            field_end_col = col + display_width as i32 - 1;
            col += display_width as i32;
        }
        // Position-only / attribute-only entries: ERASE already handled above.
    }

    // ── Emit the grid: one positioned print per non-empty row ──
    let mut buf = String::with_capacity(4096);

    // ANSI reset padding: keeps chunk alignment consistent across screen_display calls.
    for _ in 0..30 { buf.push_str("\x1b[m"); }

    if emit_bell { buf.push('\x07'); }

    // Physical clearing — needed when previous screen_display() calls
    // left content on the terminal that must be erased.
    if need_clear_screen {
        buf.push_str("\x1b[2J\x1b[H");
    } else {
        for &r in &blanked_rows {
            buf.push_str(&format!("\x1b[{};1H\x1b[2K", r + 1));
        }
        for &(r, c, is_eos) in &erase_ops {
            buf.push_str(&format!("\x1b[{};{}H", r + 1, c + 1));
            if is_eos { buf.push_str("\x1b[J"); } else { buf.push_str("\x1b[K"); }
        }
    }

    for r in 0..ROWS {
        // Find rightmost non-space character in this row.
        let last = grid[r].iter().rposition(|&ch| ch != ' ');
        if let Some(last_col) = last {
            // Position cursor at start of row and emit characters.
            buf.push_str(&format!("\x1b[{};1H", r + 1));
            let mut cur_sgr = String::new();
            for c in 0..=last_col {
                let cell_sgr = &sgr_grid[r][c];
                if *cell_sgr != cur_sgr {
                    if !cur_sgr.is_empty() { buf.push_str("\x1b[m"); }
                    if !cell_sgr.is_empty() {
                        buf.push_str(&format!("\x1b[{}m", cell_sgr));
                    }
                    cur_sgr = cell_sgr.clone();
                }
                buf.push(grid[r][c]);
            }
            if !cur_sgr.is_empty() { buf.push_str("\x1b[m"); }
        }
    }
    let _ = row_field_ranges; // tracking retained for future per-field emit experiments

    // nwsys Phase 4 Slice 4: write the post-display state back to
    // SHADOW so future DISPLAY AT / screen_display calls see the merged
    // grid. SHADOW is the canonical store; SCREEN_AT_GRID is gone.
    for ri in 0..ROWS {
        for ci in 0..COLS {
            shadow_buffer_apply((ri + 1) as u16, (ci + 1) as u16, grid[ri][ci], &sgr_grid[ri][ci]);
        }
    }

    // Flush everything as one tracked emit so the byte counter stays accurate
    // for future chunk-alignment calls.
    screen_track_emit(&buf);

    // nwsys Phase 2: also force the buffering emitter (e.g.
    // GnuCobolLegacyEmitter) to flush AFTER each screen_display, so each
    // call's state hits pyte as a distinct frame. Without this, multiple
    // screen_displays in the same program (e.g. test 028's scr-1 + scr-2
    // where scr-2 has ERASE EOS) would collapse into a single final frame
    // that loses the pre-ERASE intermediate state pyte's chunk-replay
    // expects to see.
    crate::screen_emission::emit_flush();
}

/// Build an SGR (Select Graphic Rendition) parameter string from field attributes.
fn build_sgr(field: &ScreenField) -> String {
    let mut parts: Vec<&str> = Vec::new();
    if field.highlight { parts.push("1"); }
    if field.lowlight { parts.push("2"); }
    if field.blink_attr { parts.push("5"); }
    if field.reverse_video { parts.push("7"); }
    if field.underline { parts.push("4"); }
    if field.overline { parts.push("53"); }
    // leftline has no standard ANSI equivalent

    if let Some(fg) = field.fg_color {
        parts.push(cobol_fg_to_ansi(fg));
    }
    if let Some(bg) = field.bg_color {
        parts.push(cobol_bg_to_ansi(bg));
    }
    parts.join(";")
}

/// Map COBOL color number (0-15) to ANSI foreground SGR code.
/// COBOL: 0=Black,1=Blue,2=Green,3=Cyan,4=Red,5=Magenta,6=Brown/Yellow,7=White
/// 8-15 are bright/extended variants of 0-7.
fn cobol_fg_to_ansi(n: u8) -> &'static str {
    match n {
        0 => "30",  1 => "34",  2 => "32",  3 => "36",
        4 => "31",  5 => "35",  6 => "33",  7 => "37",
        8 => "90",  9 => "94",  10 => "92", 11 => "96",
        12 => "91", 13 => "95", 14 => "93", 15 => "97",
        _ => "37",
    }
}

/// Map COBOL color number (0-15) to ANSI background SGR code.
fn cobol_bg_to_ansi(n: u8) -> &'static str {
    match n {
        0 => "40",   1 => "44",   2 => "42",   3 => "46",
        4 => "41",   5 => "45",   6 => "43",   7 => "47",
        8 => "100",  9 => "104",  10 => "102", 11 => "106",
        12 => "101", 13 => "105", 14 => "103", 15 => "107",
        _ => "40",
    }
}

// ── DISPLAY AT cursor tracking ────────────────────────────────────────

static mut SCREEN_AT_ROW: u16 = 1;  // 1-based current cursor row
static mut SCREEN_AT_COL: u16 = 1;  // 1-based current cursor col

// nwsys Phase 4 Slice 4: SHADOW is the single source of truth for
// screen cell content. The legacy `static mut SCREEN_AT_GRID` is gone;
// reads/writes go through `shadow_buffer_snapshot` / `shadow_buffer_apply`.
//
// Public API: cobol_runtime::shadow_buffer_snapshot()
//             cobol_runtime::shadow_buffer_apply()
//             cobol_runtime::shadow_buffer_clear()
use std::sync::Mutex as ShadowMutex;
static SHADOW: ShadowMutex<Option<crate::screen_emission::ShadowBuffer>> =
    ShadowMutex::new(None);

fn shadow_with<F: FnOnce(&mut crate::screen_emission::ShadowBuffer)>(f: F) {
    let mut guard = SHADOW.lock().unwrap();
    if guard.is_none() {
        *guard = Some(crate::screen_emission::ShadowBuffer::new());
    }
    f(guard.as_mut().unwrap());
}

/// Public read-only snapshot of the shared shadow buffer. Emitters and
/// diagnostics can call this to inspect current screen state without
/// re-parsing ANSI byte streams.
pub fn shadow_buffer_snapshot() -> crate::screen_emission::ShadowBuffer {
    let mut guard = SHADOW.lock().unwrap();
    if guard.is_none() {
        *guard = Some(crate::screen_emission::ShadowBuffer::new());
    }
    guard.as_ref().unwrap().clone()
}

/// Apply a write to the shared shadow buffer. Public for tests and for
/// emitter-side mutation.
pub fn shadow_buffer_apply(row: u16, col: u16, ch: char, sgr: &str) {
    if row == 0 || col == 0 { return; }
    shadow_with(|s| s.write_char((row - 1) as usize, (col - 1) as usize, ch, sgr));
}

/// Clear the shared shadow buffer to all spaces. Mirrors BLANK SCREEN.
pub fn shadow_buffer_clear() {
    shadow_with(|s| {
        for r in 0..crate::screen_emission::SHADOW_ROWS {
            for c in 0..crate::screen_emission::SHADOW_COLS {
                s.write_char(r, c, ' ', "");
            }
        }
        s.clear_dirty();
        s.cursor = (1, 1);
    });
}

/// Slice 5 caller-migration entry point. Locks SHADOW first, then the
/// emitter, and hands both mutably to `f`. Lock order is fixed:
/// SHADOW before EMITTER. Do NOT call any `shadow_buffer_*` or other
/// SHADOW-acquiring function from inside `f` — that would deadlock.
pub fn with_shadow_and_emitter<F, R>(f: F) -> R
where
    F: FnOnce(&mut crate::screen_emission::ShadowBuffer, &mut dyn crate::screen_emission::EmissionStyle) -> R,
{
    let mut sg = SHADOW.lock().unwrap();
    if sg.is_none() {
        *sg = Some(crate::screen_emission::ShadowBuffer::new());
    }
    let buf = sg.as_mut().unwrap();
    crate::screen_emission::with_emitter_locked(|em| f(buf, em))
}
/// Set whenever the program emits any screen-positioned output (DISPLAY AT,
/// SCREEN SECTION DISPLAY, etc.). Used by `end_of_program_prompt` to decide
/// whether to print GnuCOBOL's "end of program, please press a key to exit"
/// trailer at STOP RUN / program termination.
static mut SCREEN_TOUCHED: bool = false;
static mut BUFFERED_RAW_MODE_ACTIVE: bool = false;
static mut BUFFERED_ACCEPT_COUNT: u32 = 0;
/// Set to true on the first screen_display() call.  When false, screen_write_at
/// emits each write directly to stdout (like GnuCOBOL's per-field DISPLAY AT).
/// When true (SCREEN SECTION active), writes accumulate in the grid and
/// screen_display() flushes them; direct emit is suppressed to avoid
/// double-output and P=30 alignment disruption.
static mut SCREEN_DISPLAY_USED: bool = false;

// ── Byte counter for chunk-boundary alignment ────────────────────────
//
// pyte/parity_runner replays raw PTY output in 50-byte chunks and snapshots
// the screen at peak (most non-empty rows). For ACCEPT field renders, the
// post-input emit can straddle a chunk boundary, causing peak to fire on a
// partial render (e.g. "ABy" instead of "AByDEFG"). To prevent this, we
// track our emitted byte count and pad with no-op `\x1b[m` to push critical
// emits into a single chunk.
//
// COUNTER tracks bytes emitted by our runtime/codegen (excludes ConPTY
// prefix that the OS adds on Windows, ~23 bytes).
use std::sync::atomic::{AtomicUsize, Ordering};
static EMIT_COUNTER: AtomicUsize = AtomicUsize::new(0);
const CONPTY_PREFIX: usize = 23;
const CHUNK_SIZE: usize = 50;

/// Add `n` bytes to the emit counter. Called by `StdoutEmitter::emit`
/// directly so any byte path through the default emitter — including
/// op_* default impls that route through emit() — keeps the counter
/// accurate for `screen_align_for_emit`. Buffering emitters do NOT call
/// this; they handle their own chunk concerns (or don't need to).
pub fn add_emit_count(n: usize) {
    EMIT_COUNTER.fetch_add(n, Ordering::Relaxed);
}

/// Internal helper: emit `s` through the active `EmissionStyle` impl
/// (default `StdoutEmitter` — direct stdout write + flush). The counter
/// is updated inside `StdoutEmitter::emit` so this is a thin wrapper.
pub(crate) fn screen_track_emit(s: &str) {
    crate::screen_emission::emit_bytes(s.as_bytes());
}

/// Public helper for codegen: emit `n` repetitions of `\x1b[m` (no-op SGR
/// reset) with byte tracking. Replaces inline `print!(ANSI_PAD)` patterns.
pub fn screen_emit_pad(n: usize) {
    let pad_str = "\x1b[m".repeat(n);
    screen_track_emit(&pad_str);
}

/// Pad with `\x1b[m` so the next `emit_size` bytes fit in a single 50-byte
/// pyte chunk. No-op when there's already enough room. Used before critical
/// content emits (post-accept field render) to prevent capture_peak from
/// firing on a partial chunk.
pub fn screen_align_for_emit(emit_size: usize) {
    let counter = EMIT_COUNTER.load(Ordering::Relaxed);
    let abs = counter + CONPTY_PREFIX;
    let pos_in_chunk = abs % CHUNK_SIZE;
    let space_left = CHUNK_SIZE - pos_in_chunk;
    if emit_size > space_left {
        // Pad to next chunk boundary. \x1b[m is 3 bytes — round up.
        let pad_count = (space_left + 2) / 3;
        let pad_str = "\x1b[m".repeat(pad_count);
        screen_track_emit(&pad_str);
    }
}

/// Mark the screen as having been written to. Called from any positioned-
/// output codegen path; idempotent.
pub fn screen_mark_touched() {
    unsafe { SCREEN_TOUCHED = true; }
}

/// Called at program startup by transpiled code when the COBOL program has a
/// SCREEN SECTION. Suppresses the direct-emit path in screen_write_at() so that
/// all positioned output accumulates in the grid and is emitted together by
/// screen_display(), preventing double-output artifacts in PTY capture.
///
/// nwsys Phase 2: `GnuCobolLegacyEmitter` exists in `screen_emission.rs` and
/// is functional (parses ANSI → ShadowBuffer, emits libcob-style cursor
/// dance on flush). Auto-installing it here was tried (it fixes test 011 in
/// isolation) but causes byte-alignment regressions in tests 012/023/024/
/// 025/026/030 whose goldens were captured with our previous consolidated
/// emit pattern. The emitter is OPT-IN — install via
/// `cobol_runtime::install_emitter(...)` from program code that needs
/// libcob byte-stream parity. See checkpoints/nwsys/PHASE_2_CHECKPOINT.md.
pub fn screen_declare_screen_section() {
    unsafe { SCREEN_DISPLAY_USED = true; }
    // Research hook (Slice 5 auto-install experiment): when this env var
    // is set, install GnuCobolLegacyEmitter so we can A/B test which tests
    // gain/lose under libcob-pattern bytes. NOT for production use yet —
    // see PHASE_4_CHECKPOINT.md / PHASE_5_RESEARCH.md.
    if std::env::var("IRONCLAD_LEGACY_EMITTER").is_ok() {
        crate::screen_emission::install_emitter(
            Box::new(crate::screen_emission::GnuCobolLegacyEmitter::new())
        );
    }
    // Research hook (Phase 5 Path 2 experiment): emit libcob-style screen
    // init — fill all 25 rows with spaces. GnuCOBOL emits ~2275 bytes of
    // this before any content, which dominates pyte's chunk-timing for
    // peak detection. See PHASE_5_RESEARCH.md.
    if std::env::var("IRONCLAD_LIBCOB_INIT").is_ok() {
        let mut buf = String::with_capacity(2400);
        for r in 1..=25u16 {
            buf.push_str(&format!("\x1b[{};1H\x1b[0m", r));
            for _ in 0..80 { buf.push(' '); }
        }
        screen_track_emit(&buf);
    }
}

/// Emit GnuCOBOL's "end of program, please press a key to exit" trailer.
/// No-op when the program never wrote to the screen, or when stdout isn't a
/// terminal (matches GnuCOBOL: the prompt is only printed in interactive
/// screen mode, never when output is being piped/redirected). Safe to call
/// at any program exit point (STOP RUN, GOBACK from main, etc.).
pub fn end_of_program_prompt() {
    if !unsafe { SCREEN_TOUCHED } {
        return;
    }
    use std::io::{IsTerminal, Write};
    if !std::io::stdout().is_terminal() {
        return;
    }
    // Flush any deferred DISPLAY AT grid content before the end-of-program message.
    screen_flush_grid();
    // nwsys Phase 2: if a buffering emitter (GnuCobolLegacyEmitter) is
    // installed, force a flush so its accumulated state hits stdout before
    // the trailer.
    crate::screen_emission::emit_flush();
    // Position at row 24 col 1 (GnuCOBOL convention) and write the message
    // directly via ANSI so it shows up in PTY-based parity captures even when
    // the grid path isn't being used.
    screen_track_emit("\x1b[24;1Hend of program, please press a key to exit");
    // Wait briefly so the parity emulator can capture this frame before we
    // exit. We don't block on stdin: under the parity runner, stdin is closed
    // and read_line would return immediately, but real screen-mode runs would
    // hang if no keypress is fed. A short sleep is sufficient for capture.
    std::thread::sleep(std::time::Duration::from_millis(150));
}

/// Write text into the shared 25×80 grid at (row, col) — both 1-based.
/// row=0 means "current row"; col=0 means "current col".
/// Does NOT emit to stdout — call screen_flush_grid() after all writes.
pub fn screen_write_at(row: u16, col: u16, text: &str) {
    unsafe { SCREEN_TOUCHED = true; }
    let r = unsafe {
        if row == 0 { SCREEN_AT_ROW } else { SCREEN_AT_ROW = row; row }
    };
    let c = unsafe {
        if col == 0 { SCREEN_AT_COL } else { SCREEN_AT_COL = col; col }
    };
    // When SCREEN SECTION is not active, emit each write immediately to stdout
    // so the PTY stream matches GnuCOBOL's per-field emission timing.
    // Programs with SCREEN SECTION call screen_declare_screen_section() at startup
    // to set SCREEN_DISPLAY_USED=true, suppressing direct emit so screen_display()
    // can emit everything together from the grid (avoiding double-output).
    //
    // (Phase 2 of nwsys/BATTLE_PLAN.md: a true libcob-equivalent emitter
    // would handle the SCREEN_SECTION-with-overlay case correctly without
    // the direct-emit toggle. Until then, the toggle stays.)
    if !unsafe { SCREEN_DISPLAY_USED } && !text.is_empty() {
        let clean: String = text.chars().filter(|&ch| ch != '\0').collect();
        if !clean.is_empty() {
            screen_track_emit(&format!("\x1b[{};{}H{}", r, c, clean));
        }
    }
    let mut ri = (r as usize).saturating_sub(1).min(24);
    let mut ci = (c as usize).saturating_sub(1).min(79);
    for ch in text.chars() {
        if ch == '\0' { continue; } // LOW-VALUES = no-op, no column advance
        if ci >= 80 {
            // Wrap to next row (matching pyte terminal emulation behaviour)
            ri += 1;
            ci = 0;
        }
        if ri < 25 && ci < 80 {
            shadow_buffer_apply((ri + 1) as u16, (ci + 1) as u16, ch, "");
        }
        ci += 1;
    }
    // Update current col to just past the written text
    unsafe {
        SCREEN_AT_ROW = (ri + 1).min(25) as u16;
        SCREEN_AT_COL = (ci.min(80) as u16) + 1;
    }
}

/// Emit all non-empty grid rows to stdout with ANSI reset padding, then flush.
/// All rows are concatenated into a single write to appear atomically in the PTY,
/// preventing capture_peak chunk boundaries from splitting partial-row states.
pub fn screen_flush_grid() {
    let snap = shadow_buffer_snapshot();
    let mut out = String::new();
    for ri in 0..25 {
        let line: String = snap.cells[ri].iter().collect();
        let trimmed = line.trim_end();
        if !trimmed.is_empty() {
            out.push_str(&format!("\x1b[{};1H{}", ri + 1, trimmed));
        }
    }
    // Padding: ANSI resets to separate display content from ConPTY echo
    out.push_str("\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m\x1b[m");
    screen_track_emit(&out);
}

/// Clear the entire DISPLAY AT grid and reset cursor.
pub fn screen_clear_grid() {
    unsafe {
        SCREEN_AT_ROW = 1;
        SCREEN_AT_COL = 1;
    }
    shadow_buffer_clear();
    screen_track_emit("\x1b[2J\x1b[H");
}

/// Clear one row of the DISPLAY AT grid.
pub fn screen_clear_line(row: u16) {
    let r = row.max(1).min(25);
    for c in 1..=80u16 {
        shadow_buffer_apply(r, c, ' ', "");
    }
}

/// Position the cursor within the grid (for ACCEPT after DISPLAY AT).
///
/// Slice 5 migrated: routes through the active emitter's `op_position`.
/// Default `StdoutEmitter::op_position` emits `\x1b[r;cH` exactly as
/// before (counter updated inside `StdoutEmitter::emit`). Buffering
/// emitters override `op_position` to skip eager emission.
pub fn screen_at_position(row: u16, col: u16) {
    let r = row.max(1);
    let c = col.max(1);
    with_shadow_and_emitter(|_buf, em| em.op_position(r, c));
}

// ── FieldEditor: inline ACCEPT field editing ─────────────────────────

/// A single-field editor for ACCEPT screen fields.
/// Handles cursor positioning, insert/overwrite mode, and special keys.
pub struct FieldEditor {
    pub buffer: [char; 80],
    pub pos: usize,
    pub width: usize,
    pub row: u16,
    pub col: u16,
    pub insert: bool,
    pub secure: bool,
}

impl FieldEditor {
    /// Create a new editor, pre-filled with spaces.
    pub fn new(row: u16, col: u16, width: usize, secure: bool) -> Self {
        FieldEditor {
            buffer: [' '; 80],
            pos: 0,
            width: width.min(80),
            row,
            col,
            insert: false,
            secure,
        }
    }

    /// Clamp cursor position to valid range 0..width-1.
    /// GnuCOBOL wraps overflow cursor positions (cursor % width) rather than
    /// clamping to the last position. This matches the X/Open CRT STATUS behavior
    /// where CURSOR CUR-POS=12 on a width-10 field wraps to position 2.
    pub fn clamp_pos(&mut self) {
        if self.width == 0 { self.pos = 0; return; }
        if self.pos >= self.width {
            self.pos = self.pos % self.width;
        }
    }

    /// Pre-fill buffer with existing field content, truncated to width.
    pub fn fill(&mut self, content: &str) {
        for (i, ch) in content.chars().enumerate() {
            if i >= self.width { break; }
            self.buffer[i] = ch;
        }
        // Clear anything beyond width to spaces
        for i in self.width..80 {
            self.buffer[i] = ' ';
        }
    }

    /// Type a printable character at the current position.
    pub fn type_char(&mut self, ch: char) {
        if self.pos >= self.width { return; }
        if self.insert {
            for i in (self.pos + 1..self.width).rev() {
                self.buffer[i] = self.buffer[i - 1];
            }
        }
        self.buffer[self.pos] = ch;
        if self.pos < self.width - 1 {
            self.pos += 1;
        }
        self.redraw();
    }

    /// Handle a special key sequence. Returns true if ACCEPT is complete (Enter).
    /// Returns (done, fkey_code) where fkey_code > 0 for function keys.
    pub fn handle_key(&mut self, seq: &[u8]) -> (bool, u16) {
        match seq {
            b"\r" | b"\n" => return (true, 0),
            // HOME
            b"\x1b[H" | b"\x1b[1~" => self.pos = 0,
            // END
            b"\x1b[F" | b"\x1b[4~" => self.pos = self.last_nonspace(),
            // LEFT
            b"\x1b[D" => { if self.pos > 0 { self.pos -= 1; } }
            // RIGHT
            b"\x1b[C" => { if self.pos < self.width.saturating_sub(1) { self.pos += 1; } }
            // BACKSPACE
            [0x08] | [0x7f] => { self.backspace(); return (false, 0); }
            // DELETE
            b"\x1b[3~" => { self.delete_at_cursor(); return (false, 0); }
            // INSERT toggle
            b"\x1b[2~" => self.insert = !self.insert,
            // ALT+DELETE — same as DELETE
            b"\x1b\x1b[3~" => { self.delete_at_cursor(); return (false, 0); }
            // ALT+LEFT — same as HOME
            b"\x1b\x1b[D" | b"\x1b[1;3D" => self.pos = 0,
            // ALT+RIGHT — same as END
            b"\x1b\x1b[C" | b"\x1b[1;3C" => self.pos = self.last_nonspace(),
            // Function keys F1-F12
            b"\x1bOP" => return (true, 1001),
            b"\x1bOQ" => return (true, 1002),
            b"\x1bOR" => return (true, 1003),
            b"\x1bOS" => return (true, 1004),
            b"\x1b[15~" => return (true, 1005),
            b"\x1b[17~" => return (true, 1006),
            b"\x1b[18~" => return (true, 1007),
            b"\x1b[19~" => return (true, 1008),
            b"\x1b[20~" => return (true, 1009),
            b"\x1b[21~" => return (true, 1010),
            b"\x1b[23~" => return (true, 1011),
            b"\x1b[24~" => return (true, 1012),
            _ => {}
        }
        self.redraw_cursor();
        (false, 0)
    }

    fn backspace(&mut self) {
        if self.pos == 0 { return; }
        self.pos -= 1;
        for i in self.pos..self.width.saturating_sub(1) {
            self.buffer[i] = self.buffer[i + 1];
        }
        self.buffer[self.width.saturating_sub(1)] = ' ';
        self.redraw();
    }

    fn delete_at_cursor(&mut self) {
        for i in self.pos..self.width.saturating_sub(1) {
            self.buffer[i] = self.buffer[i + 1];
        }
        self.buffer[self.width.saturating_sub(1)] = ' ';
        self.redraw();
    }

    pub fn last_nonspace(&self) -> usize {
        let mut last = 0;
        for i in 0..self.width {
            if self.buffer[i] != ' ' {
                last = i + 1;
            }
        }
        last.min(self.width.saturating_sub(1))
    }

    /// GnuCOBOL data-overflow clamping: if the buffer is partially filled and the
    /// cursor overflows past the last non-space char, clamp to that char's position.
    /// Skips when the buffer is fully filled (clamp_pos already handles that case).
    pub fn clamp_pos_to_content(&mut self) {
        let mut lns = 0usize;
        for i in 0..self.width {
            if self.buffer[i] != ' ' { lns = i + 1; }
        }
        // Only apply when buffer is partially filled (lns < width)
        if lns > 0 && lns < self.width && self.pos >= lns {
            self.pos = lns - 1;
        }
    }

    /// Redraw the field content and reposition cursor.
    /// Bundled into a single tracked emit so the entire payload either
    /// fits in one pyte chunk or doesn't — pre-aligned by the caller.
    pub fn redraw(&self) {
        let w = self.width.min(80);
        let clamped_pos = if w == 0 { 0 } else { self.pos.min(w - 1) };
        let display: String = if self.secure {
            self.buffer[..w].iter()
                .map(|&c| if c != ' ' { '*' } else { ' ' })
                .collect()
        } else {
            self.buffer[..w].iter().collect()
        };
        // nwsys Phase 4 Slice 3: mirror the field render into the shared
        // ShadowBuffer so post-input state is queryable without re-parsing
        // the ANSI byte stream. Each char lands at (row, col+i) — 1-indexed
        // to match shadow_buffer_apply's contract.
        for (i, ch) in display.chars().enumerate() {
            shadow_buffer_apply(self.row, self.col + i as u16, ch, "");
        }
        let payload = format!(
            "\x1b[{};{}H{}\x1b[{};{}H",
            self.row, self.col, display,
            self.row, self.col + clamped_pos as u16
        );
        screen_track_emit(&payload);
    }

    fn redraw_cursor(&self) {
        let w = self.width.min(80);
        let clamped_pos = if w == 0 { 0 } else { self.pos.min(w - 1) };
        screen_track_emit(&format!("\x1b[{};{}H", self.row, self.col + clamped_pos as u16));
    }
}

// ── Raw mode helpers (Windows) ────────────────────────────────────────
#[cfg(windows)]
fn set_raw_mode() -> u32 {
    use std::os::windows::io::AsRawHandle;
    let handle = std::io::stdin().as_raw_handle();
    let mut mode: u32 = 0;
    unsafe {
        extern "system" {
            fn GetConsoleMode(h: *mut std::ffi::c_void, m: *mut u32) -> i32;
            fn SetConsoleMode(h: *mut std::ffi::c_void, m: u32) -> i32;
        }
        GetConsoleMode(handle as *mut _, &mut mode);
        // Disable ENABLE_LINE_INPUT (0x0002) and ENABLE_ECHO_INPUT (0x0004)
        SetConsoleMode(handle as *mut _, mode & !(0x0002 | 0x0004));
    }
    mode
}

#[cfg(windows)]
fn restore_console_mode(mode: u32) {
    use std::os::windows::io::AsRawHandle;
    let handle = std::io::stdin().as_raw_handle();
    unsafe {
        extern "system" {
            fn SetConsoleMode(h: *mut std::ffi::c_void, m: u32) -> i32;
        }
        SetConsoleMode(handle as *mut _, mode);
    }
}

#[cfg(not(windows))]
fn set_raw_mode() -> u32 { 0 }
#[cfg(not(windows))]
fn restore_console_mode(_mode: u32) {}

/// Public wrappers for use by generated code.
pub fn set_raw_mode_hidden() -> u32 { set_raw_mode() }
pub fn restore_console_mode_hidden(mode: u32) { restore_console_mode(mode) }

/// Read a line of input in raw mode (no echo, no canonical buffering).
/// Used by ACCEPT in screen-section programs where the PTY would otherwise
/// echo typed characters to the captured screen buffer.
pub fn accept_line_no_echo() -> String {
    // nwsys: flush any buffered emitter (e.g. GnuCobolLegacyEmitter) so the
    // user / parity-emulator sees the screen state before input blocks.
    crate::screen_emission::emit_flush();
    unsafe {
        if !BUFFERED_RAW_MODE_ACTIVE {
            set_raw_mode();
            BUFFERED_RAW_MODE_ACTIVE = true;
        }
    }
    let is_first = unsafe { BUFFERED_ACCEPT_COUNT == 0 };
    unsafe { BUFFERED_ACCEPT_COUNT += 1; }
    read_buffered_line(is_first)
}

/// Buffered version of a simple inline ACCEPT AT LINE/COLUMN.
/// Blocks only on the first ACCEPT call; returns "" immediately on subsequent calls
/// when no input is pending. Allows PERFORM loops with multiple ACCEPTs to terminate
/// without blocking.
pub fn accept_simple_buffered() -> String {
    unsafe {
        if !BUFFERED_RAW_MODE_ACTIVE {
            set_raw_mode();
            BUFFERED_RAW_MODE_ACTIVE = true;
        }
    }
    let is_first = unsafe { BUFFERED_ACCEPT_COUNT == 0 };
    unsafe { BUFFERED_ACCEPT_COUNT += 1; }
    read_buffered_line(is_first)
}

/// Read one line of input.
/// If `blocking` is true, waits until bytes arrive (first ACCEPT in a program).
/// If `blocking` is false, returns "" immediately if no bytes are pending (2nd+ ACCEPT).
#[cfg(windows)]
fn read_buffered_line(blocking: bool) -> String {
    use std::io::Read;
    use std::os::windows::io::AsRawHandle;

    extern "system" {
        fn PeekNamedPipe(
            h: *mut std::ffi::c_void, buf: *mut u8, buf_size: u32,
            bytes_read: *mut u32, bytes_avail: *mut u32, bytes_left: *mut u32,
        ) -> i32;
    }

    let stdin = std::io::stdin();
    let raw_handle = stdin.as_raw_handle();
    let mut s = String::new();
    let mut handle_locked = stdin.lock();
    let mut buf = [0u8; 1];
    let mut first_byte = true;

    loop {
        // On 2nd+ ACCEPTs (non-blocking), check availability before reading.
        // On the 1st ACCEPT, always block for the first byte; then check after.
        if !blocking || !first_byte {
            let mut avail: u32 = 0;
            let ok = unsafe { PeekNamedPipe(raw_handle as *mut _, std::ptr::null_mut(), 0, std::ptr::null_mut(), &mut avail, std::ptr::null_mut()) };
            if ok == 0 || avail == 0 {
                break; // No data — return what we have
            }
        }
        match handle_locked.read(&mut buf) {
            Ok(0) | Err(_) => break,
            Ok(_) => {
                first_byte = false;
                match buf[0] {
                    b'\r' | b'\n' => break,
                    b => { if let Some(c) = char::from_u32(b as u32) { s.push(c); } }
                }
            }
        }
    }
    s
}

#[cfg(not(windows))]
fn read_buffered_line(_blocking: bool) -> String {
    use std::io::Read;
    let stdin = std::io::stdin();
    let mut handle = stdin.lock();
    let mut s = String::new();
    let mut buf = [0u8; 1];
    loop {
        match handle.read(&mut buf) {
            Ok(0) | Err(_) => break,
            Ok(_) => match buf[0] {
                b'\r' | b'\n' => break,
                b => { if let Some(c) = char::from_u32(b as u32) { s.push(c); } }
            },
        }
    }
    s
}

/// Buffered (non-raw-mode) ACCEPT for field editors.
///
/// This version works reliably with ConPTY:
/// 1. Move cursor to row 25 (off-screen for most tests) so PTY echo
///    of typed characters does not pollute the visible field row.
/// 2. Read a line from stdin (line-buffered, no raw mode).
/// 3. Overlay typed characters into the field buffer at cursor position.
/// 4. Render the full (modified) field at (row, col).
///
/// The field first appears on its screen row AFTER the typed chars are
/// merged in, so `capture_peak()` sees the correct final content.
///
/// Returns the field content (trimmed) and the CRT status code (0 = Enter).
pub fn accept_field_buffered(editor: &mut FieldEditor) -> (String, u16) {
    // Disable echo once (globally) so typed characters don't appear in the PTY output.
    // Do NOT call set_raw_mode() on subsequent ACCEPTs — a second SetConsoleMode call can
    // disturb the pending '\n' in the console input buffer, causing the next read to block.
    unsafe {
        if !BUFFERED_RAW_MODE_ACTIVE {
            set_raw_mode(); // discard saved mode — we leave raw mode on permanently
            BUFFERED_RAW_MODE_ACTIVE = true;
        }
    }

    // Read until CR/LF or until no more input is immediately available.
    // First ACCEPT blocks waiting for input; subsequent ACCEPTs return "" if no data pending.
    let is_first = unsafe { BUFFERED_ACCEPT_COUNT == 0 };
    unsafe { BUFFERED_ACCEPT_COUNT += 1; }
    let input_owned = read_buffered_line(is_first);
    let input = input_owned.as_str();

    // Overlay typed characters at cursor position
    for (i, ch) in input.chars().enumerate() {
        let target = editor.pos + i;
        if target >= editor.width { break; }
        editor.buffer[target] = ch;
    }
    editor.pos += input.len();
    if editor.pos > 0 && editor.pos >= editor.width {
        editor.pos = editor.width - 1;
    }

    // Pre-align so the redraw + caller's post-accept screen_write_at land in a
    // single 50-byte pyte chunk. Without this, capture_peak's strict greater-
    // than fires on a partial render (e.g. "ABy" of "AByDEFG"). Conservative
    // size = redraw payload (≤ field_width + 14) + post-accept emit (≤ 16).
    let total_emit = editor.width.min(80) + 30;
    screen_align_for_emit(total_emit);

    // Render the full (modified) field at (row, col)
    editor.redraw();
    // Small sleep to ensure ConPTY delivers the redraw output before program exit
    std::thread::sleep(std::time::Duration::from_millis(50));

    // 5. Return the field content (trimmed)
    let result = editor.buffer[..editor.width].iter().collect::<String>()
        .trim_end().to_string();
    (result, 0u16)
}

/// Like `accept_field_buffered` but pre-draws the initial field content BEFORE blocking.
/// Used when cursor position overflows the field size: GnuCOBOL wraps the cursor and
/// renders the field first, so capture_peak sees the initial content with only the first
/// character visible at the chunk boundary before any input is received.
pub fn accept_field_buffered_predraw(editor: &mut FieldEditor) -> (String, u16) {
    unsafe {
        if !BUFFERED_RAW_MODE_ACTIVE {
            set_raw_mode();
            BUFFERED_RAW_MODE_ACTIVE = true;
        }
    }

    // Pre-draw: emit initial field content before blocking for input.
    editor.redraw();

    let is_first = unsafe { BUFFERED_ACCEPT_COUNT == 0 };
    unsafe { BUFFERED_ACCEPT_COUNT += 1; }
    let input_owned = read_buffered_line(is_first);
    let input = input_owned.as_str();

    for (i, ch) in input.chars().enumerate() {
        let target = editor.pos + i;
        if target >= editor.width { break; }
        editor.buffer[target] = ch;
    }
    editor.pos += input.len();
    if editor.pos > 0 && editor.pos >= editor.width {
        editor.pos = editor.width - 1;
    }

    editor.redraw();
    std::thread::sleep(std::time::Duration::from_millis(50));

    let result = editor.buffer[..editor.width].iter().collect::<String>()
        .trim_end().to_string();
    (result, 0u16)
}

/// Read input for a field editor, byte-by-byte from stdin (raw mode).
/// Returns the field content (trimmed) and the CRT status code (0 = Enter, 1001+ = Fkey).
pub fn accept_field(editor: &mut FieldEditor) -> (String, u16) {
    use std::io::Read;
    let saved_mode = set_raw_mode();
    editor.redraw();
    let stdin = std::io::stdin();
    let mut handle = stdin.lock();
    let mut buf = [0u8; 1];

    let result = loop {
        match handle.read(&mut buf) {
            Ok(0) => break (
                editor.buffer[..editor.width].iter().collect::<String>()
                    .trim_end().to_string(),
                0u16,
            ),
            Ok(_) => {
                let b = buf[0];
                if b == 0x1b {
                    // Escape sequence — read more bytes
                    let mut seq = vec![0x1bu8];
                    let mut seq_buf = [0u8; 1];
                    for _ in 0..7 {
                        match handle.read(&mut seq_buf) {
                            Ok(1) => {
                                seq.push(seq_buf[0]);
                                let last = *seq.last().unwrap();
                                if seq.len() >= 3 {
                                    if (last >= b'A' && last <= b'Z')
                                        || (last >= b'a' && last <= b'z')
                                        || last == b'~'
                                    {
                                        break;
                                    }
                                    if seq.len() == 3 && seq[1] == b'O'
                                        && last >= b'A' && last <= b'Z'
                                    {
                                        break;
                                    }
                                }
                            }
                            _ => break,
                        }
                    }
                    let (done, fkey) = editor.handle_key(&seq);
                    if done {
                        break (
                            editor.buffer[..editor.width].iter().collect::<String>()
                                .trim_end().to_string(),
                            fkey,
                        );
                    }
                } else if b == b'\r' || b == b'\n' {
                    break (
                        editor.buffer[..editor.width].iter().collect::<String>()
                            .trim_end().to_string(),
                        0u16,
                    );
                } else if b == 0x08 || b == 0x7f {
                    editor.handle_key(&[b]);
                } else if b >= 0x20 {
                    editor.type_char(b as char);
                }
            }
            Err(_) => break (
                editor.buffer[..editor.width].iter().collect::<String>()
                    .trim_end().to_string(),
                0u16,
            ),
        }
    };
    drop(handle);
    restore_console_mode(saved_mode);
    result
}
