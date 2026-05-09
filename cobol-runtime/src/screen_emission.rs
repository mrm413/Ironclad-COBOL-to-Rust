//! Screen emission strategy abstraction (nwsys Phases 1-3).
//!
//! All bytes destined for the physical terminal flow through a single
//! `EmissionStyle` impl held in the global `EMITTER` slot. The default is
//! `StdoutEmitter`, which writes directly to stdout — bit-for-bit equivalent
//! to the previous `print!` + `stdout().flush()` calls.
//!
//! `GnuCobolLegacyEmitter` parses incoming ANSI bytes into a `ShadowBuffer`
//! and re-emits with libcob/ncurses-style cursor-dance — used for SCREEN
//! SECTION programs to match the GnuCOBOL byte-stream pattern that
//! parity-test goldens were captured from.
//!
//! `Mainframe3270Emitter` translates the same ShadowBuffer state into IBM
//! 3270 SBA/SF orders + EBCDIC text — for true mainframe parity.
//!
//! Swap with `install_emitter()`. See checkpoints/nwsys/ for the full
//! battle plan.

use std::io::Write;
use std::sync::Mutex;

/// Pluggable byte-stream sink for screen output. Each impl decides how
/// (or whether) to buffer, batch, translate, or chunk the bytes the COBOL
/// runtime hands it.
///
/// Two API surfaces exist on this trait:
///
/// 1. **Byte-level (`emit` / `flush`)** — the legacy path used by
///    `screen_track_emit`. Pre-encoded ANSI bytes go through `emit`.
///    Buffering emitters parse them via `AnsiParser`; eager emitters
///    forward to stdout.
///
/// 2. **Operation-level (`op_write_at` / `op_position` / `op_erase_*` /
///    `op_flush`)** — Phase 4 Slice 5 surface. Callers hand the emitter a
///    `&mut ShadowBuffer` plus a high-level operation; each emitter is
///    solely responsible for translating the op into its own byte stream
///    (consolidated-row ANSI for `StdoutEmitter`, libcob pattern for
///    `GnuCobolLegacyEmitter`, 3270 SBA/SF for `Mainframe3270Emitter`).
///    No more shared pre-encoded bytes; no more ANSI-back-parse cascade.
///
/// During the transition, default impls of the operation-level methods
/// fall back to the byte-level path so existing callers keep working.
pub trait EmissionStyle: Send {
    // ── Byte-level (legacy) ──────────────────────────────────────────
    /// Write raw bytes to the output. Implementations may buffer.
    fn emit(&mut self, bytes: &[u8]);

    /// Force any buffered bytes to the physical sink.
    fn flush(&mut self);

    // ── Operation-level (Slice 5) ─────────────────────────────────────
    //
    // All ops take `buffer` as the canonical state. The emitter mutates
    // the buffer to reflect the operation; on `op_flush`, it produces
    // bytes consistent with that state in its own dialect.
    //
    // Default impls mutate the buffer AND emit equivalent ANSI through
    // `emit()` so existing byte-level emitters keep working unchanged.
    // Emitters that want to suppress eager emission (e.g.
    // `GnuCobolLegacyEmitter`) override these to mutate the buffer only.

    /// Write `text` at (row, col) — both 1-indexed. `sgr` is an
    /// SGR parameter string (no `ESC[...m` framing) or empty for default.
    fn op_write_at(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16, text: &str, sgr: &str) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        let mut wr = r;
        let mut wc = c0;
        for ch in text.chars() {
            if wc >= SHADOW_COLS {
                wr += 1;
                wc = 0;
                if wr >= SHADOW_ROWS { break; }
            }
            buffer.write_char(wr, wc, ch, sgr);
            wc += 1;
        }
        // Default behavior: also forward the equivalent ANSI byte
        // sequence through `emit` so byte-level emitters stay in sync.
        let mut bytes = format!("\x1b[{};{}H", row.max(1), col.max(1)).into_bytes();
        if !sgr.is_empty() {
            bytes.extend_from_slice(b"\x1b[");
            bytes.extend_from_slice(sgr.as_bytes());
            bytes.push(b'm');
        }
        bytes.extend_from_slice(text.as_bytes());
        if !sgr.is_empty() {
            bytes.extend_from_slice(b"\x1b[m");
        }
        self.emit(&bytes);
    }

    /// Move the logical cursor without writing. Buffer is updated; bytes
    /// emitted iff the active emitter chooses to.
    fn op_position(&mut self, row: u16, col: u16) {
        let bytes = format!("\x1b[{};{}H", row.max(1), col.max(1)).into_bytes();
        self.emit(&bytes);
    }

    /// Clear cells from (row, col) to end of row.
    fn op_erase_eol(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS {
                buffer.write_char(r, c, ' ', "");
            }
        }
        let bytes = format!("\x1b[{};{}H\x1b[K", row.max(1), col.max(1)).into_bytes();
        self.emit(&bytes);
    }

    /// Clear cells from (row, col) to end of screen.
    fn op_erase_eos(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
            for rr in (r + 1)..SHADOW_ROWS {
                for c in 0..SHADOW_COLS { buffer.write_char(rr, c, ' ', ""); }
            }
        }
        let bytes = format!("\x1b[{};{}H\x1b[J", row.max(1), col.max(1)).into_bytes();
        self.emit(&bytes);
    }

    /// Render any buffered state. Default impl just calls `flush()`. The
    /// `buffer` argument lets emitters that need pixel-perfect state
    /// (e.g. `GnuCobolLegacyEmitter::render_diff`) walk it directly.
    fn op_flush(&mut self, _buffer: &mut ShadowBuffer) {
        self.flush();
    }
}

/// Default emitter: write directly to stdout. Reproduces the previous
/// `print!` + `stdout().flush()` semantics exactly. Updates the
/// chunk-alignment counter (`screen::add_emit_count`) so chunk padding
/// in `screen_align_for_emit` stays accurate. Buffering emitters skip
/// this counter — they don't need pyte chunk alignment because they
/// emit their entire payload in one flush.
pub struct StdoutEmitter;

impl EmissionStyle for StdoutEmitter {
    fn emit(&mut self, bytes: &[u8]) {
        let stdout = std::io::stdout();
        let mut handle = stdout.lock();
        let _ = handle.write_all(bytes);
        let _ = handle.flush();
        crate::screen::add_emit_count(bytes.len());
    }

    fn flush(&mut self) {
        let _ = std::io::stdout().flush();
    }
}

/// Global emitter slot. Initialized to `StdoutEmitter` on first access.
/// Replaceable at runtime via `install_emitter`.
static EMITTER: Mutex<Option<Box<dyn EmissionStyle>>> = Mutex::new(None);

/// Install a new emitter. The previous emitter is dropped (its buffered
/// bytes — if any — are gone). Call early in program startup.
pub fn install_emitter(e: Box<dyn EmissionStyle>) {
    let mut guard = EMITTER.lock().unwrap();
    *guard = Some(e);
}

/// Internal: emit `bytes` through the active emitter. If no emitter has been
/// installed, install the default `StdoutEmitter` and use it.
pub(crate) fn emit_bytes(bytes: &[u8]) -> usize {
    let mut guard = EMITTER.lock().unwrap();
    if guard.is_none() {
        *guard = Some(Box::new(StdoutEmitter));
    }
    guard.as_mut().unwrap().emit(bytes);
    bytes.len()
}

/// Internal: flush the active emitter.
pub(crate) fn emit_flush() {
    let mut guard = EMITTER.lock().unwrap();
    if let Some(emitter) = guard.as_mut() {
        emitter.flush();
    }
}

/// Run `f` with mutable access to the active emitter. Installs the
/// default `StdoutEmitter` on first call. Used by Slice 5 caller paths
/// that need to dispatch op-level methods. Lock-acquisition order:
/// callers that need both SHADOW and EMITTER must always acquire SHADOW
/// first, then call this — see `screen::with_shadow_and_emitter`.
pub fn with_emitter_locked<F, R>(f: F) -> R
where
    F: FnOnce(&mut dyn EmissionStyle) -> R,
{
    let mut guard = EMITTER.lock().unwrap();
    if guard.is_none() {
        *guard = Some(Box::new(StdoutEmitter));
    }
    f(&mut **guard.as_mut().unwrap())
}

// ── ShadowBuffer ──────────────────────────────────────────────────────

pub const SHADOW_ROWS: usize = 25;
pub const SHADOW_COLS: usize = 80;

#[derive(Clone)]
pub struct ShadowBuffer {
    pub cells: [[char; SHADOW_COLS]; SHADOW_ROWS],
    pub sgr: Vec<Vec<String>>,
    pub dirty: [[bool; SHADOW_COLS]; SHADOW_ROWS],
    pub cursor: (u16, u16), // (row, col), 1-indexed
}

impl ShadowBuffer {
    pub fn new() -> Self {
        Self {
            cells: [[' '; SHADOW_COLS]; SHADOW_ROWS],
            sgr: vec![vec![String::new(); SHADOW_COLS]; SHADOW_ROWS],
            dirty: [[false; SHADOW_COLS]; SHADOW_ROWS],
            cursor: (1, 1),
        }
    }

    pub fn write_char(&mut self, row: usize, col: usize, ch: char, sgr: &str) {
        if row < SHADOW_ROWS && col < SHADOW_COLS {
            self.cells[row][col] = ch;
            self.sgr[row][col] = sgr.to_string();
            // Always mark dirty on write — this lets emitters distinguish
            // field-touched cells (including internal spaces, e.g. word
            // gaps inside a literal field) from never-touched cells (e.g.
            // gaps BETWEEN fields). Per-field run detection in
            // GnuCobolLegacyEmitter::render_diff depends on this.
            self.dirty[row][col] = true;
        }
    }

    pub fn clear_dirty(&mut self) {
        for row in self.dirty.iter_mut() {
            for cell in row.iter_mut() { *cell = false; }
        }
    }

    pub fn row_dirty(&self, row: usize) -> bool {
        if row >= SHADOW_ROWS { return false; }
        self.dirty[row].iter().any(|&d| d)
    }
}

impl Default for ShadowBuffer {
    fn default() -> Self { Self::new() }
}

// ── ANSI parser ───────────────────────────────────────────────────────
//
// Parses a stream of ANSI-encoded bytes from screen.rs back into
// ShadowBuffer cell mutations. Used by GnuCobolLegacyEmitter and
// Mainframe3270Emitter, both of which re-encode in their own format.
//
// Recognises a focused subset:
//   ESC [ R ; C H        — cursor position (CUP)
//   ESC [ <n>m           — SGR (Select Graphic Rendition); accumulated
//                          into `current_sgr`
//   ESC [ 2 J            — clear screen
//   ESC [ K              — erase to end of line
//   ESC [ 2 K            — erase entire line
//   ESC [ J              — erase to end of screen
//   ESC 7 / ESC 8        — save / restore cursor
//   plain text           — written at cursor with current_sgr
//
// Anything else (DCS, OSC, mode toggles like \x1b[?25h) is consumed
// silently. This is intentional: our emit stream only uses the
// subset above; we don't need a full VT100/220 emulator.

pub struct AnsiParser {
    pub cursor: (usize, usize),       // (row, col), 0-indexed
    pub saved_cursor: (usize, usize),
    pub current_sgr: String,
    /// Rows in the order they first received a write since the last
    /// `reset_emit_order()`. Used by GnuCobolLegacyEmitter to emit rows
    /// in their write order, matching libcob/ncurses behavior where rows
    /// hit the wire in the order COBOL declared the fields.
    pub emit_order: Vec<usize>,
}

impl AnsiParser {
    pub fn new() -> Self {
        Self {
            cursor: (0, 0),
            saved_cursor: (0, 0),
            current_sgr: String::new(),
            emit_order: Vec::new(),
        }
    }

    pub fn reset_emit_order(&mut self) {
        self.emit_order.clear();
    }

    fn note_write(&mut self, row: usize) {
        if !self.emit_order.contains(&row) {
            self.emit_order.push(row);
        }
    }

    /// Feed bytes into the parser, mutating `buffer`. Returns nothing —
    /// the buffer is the side-effect.
    pub fn feed(&mut self, bytes: &[u8], buffer: &mut ShadowBuffer) {
        let mut i = 0;
        while i < bytes.len() {
            let b = bytes[i];
            if b == 0x1b {
                // ESC sequence
                if i + 1 >= bytes.len() { break; }
                let next = bytes[i + 1];
                if next == b'[' {
                    // CSI — find terminator (alpha, '~', etc.)
                    let mut j = i + 2;
                    while j < bytes.len() && !is_csi_terminator(bytes[j]) {
                        j += 1;
                    }
                    if j >= bytes.len() { break; }
                    let term = bytes[j];
                    let params = &bytes[i + 2..j];
                    self.handle_csi(term, params, buffer);
                    i = j + 1;
                } else if next == b'7' {
                    self.saved_cursor = self.cursor;
                    i += 2;
                } else if next == b'8' {
                    self.cursor = self.saved_cursor;
                    i += 2;
                } else if next == b']' {
                    // OSC — skip to BEL (0x07) or ESC \ (ST)
                    let mut j = i + 2;
                    while j < bytes.len() && bytes[j] != 0x07 {
                        if bytes[j] == 0x1b && j + 1 < bytes.len() && bytes[j + 1] == b'\\' {
                            j += 2;
                            break;
                        }
                        j += 1;
                    }
                    if j < bytes.len() && bytes[j] == 0x07 { j += 1; }
                    i = j;
                } else {
                    // Unknown 2-byte ESC — skip
                    i += 2;
                }
            } else if b >= 0x20 && b != 0x7f {
                // Printable — write at cursor, advance
                let (r, c) = self.cursor;
                let ch = b as char;
                buffer.write_char(r, c, ch, &self.current_sgr);
                self.note_write(r);
                if c + 1 < SHADOW_COLS {
                    self.cursor = (r, c + 1);
                } else if r + 1 < SHADOW_ROWS {
                    self.cursor = (r + 1, 0);
                }
                i += 1;
            } else if b == b'\r' {
                self.cursor.1 = 0;
                i += 1;
            } else if b == b'\n' {
                if self.cursor.0 + 1 < SHADOW_ROWS {
                    self.cursor.0 += 1;
                }
                self.cursor.1 = 0;
                i += 1;
            } else if b == 0x08 {
                // backspace
                if self.cursor.1 > 0 { self.cursor.1 -= 1; }
                i += 1;
            } else if b == 0x07 {
                // BEL — ignore for buffer purposes
                i += 1;
            } else {
                // Other control chars — write literally (X'02' etc., shown
                // as ^B by terminals; for our buffer purposes we record
                // the raw char and let the renderer decide how to display)
                let (r, c) = self.cursor;
                buffer.write_char(r, c, b as char, &self.current_sgr);
                self.note_write(r);
                if c + 1 < SHADOW_COLS {
                    self.cursor = (r, c + 1);
                }
                i += 1;
            }
        }
    }

    fn handle_csi(&mut self, term: u8, params: &[u8], buffer: &mut ShadowBuffer) {
        let pstr = std::str::from_utf8(params).unwrap_or("");
        match term {
            b'H' | b'f' => {
                // Cursor position: ESC[R;CH (1-indexed) — default 1,1
                let mut parts = pstr.split(';');
                let r = parts.next().and_then(|s| s.parse::<usize>().ok()).unwrap_or(1);
                let c = parts.next().and_then(|s| s.parse::<usize>().ok()).unwrap_or(1);
                self.cursor = (r.saturating_sub(1), c.saturating_sub(1));
            }
            b'm' => {
                // SGR — accumulate; "0" or empty = reset
                if pstr.is_empty() || pstr == "0" {
                    self.current_sgr.clear();
                } else {
                    self.current_sgr = pstr.to_string();
                }
            }
            b'J' => {
                // Erase: 0=cursor to end of screen, 1=start to cursor, 2=all
                let mode = pstr.parse::<u32>().unwrap_or(0);
                let (r, c) = self.cursor;
                match mode {
                    0 => { erase_from(buffer, r, c); }
                    2 => { erase_all(buffer); self.cursor = (0, 0); }
                    _ => {}
                }
            }
            b'K' => {
                // Erase line: 0=cursor to EOL, 1=start to cursor, 2=all
                let mode = pstr.parse::<u32>().unwrap_or(0);
                let (r, c) = self.cursor;
                if r < SHADOW_ROWS {
                    let range: Box<dyn Iterator<Item = usize>> = match mode {
                        0 => Box::new(c..SHADOW_COLS),
                        1 => Box::new(0..=c.min(SHADOW_COLS - 1)),
                        2 => Box::new(0..SHADOW_COLS),
                        _ => Box::new(std::iter::empty()),
                    };
                    for cc in range {
                        buffer.write_char(r, cc, ' ', "");
                    }
                }
            }
            b'A' | b'B' | b'C' | b'D' => {
                // Cursor up/down/forward/back
                let n = pstr.parse::<usize>().unwrap_or(1).max(1);
                let (r, c) = self.cursor;
                self.cursor = match term {
                    b'A' => (r.saturating_sub(n), c),
                    b'B' => ((r + n).min(SHADOW_ROWS - 1), c),
                    b'C' => (r, (c + n).min(SHADOW_COLS - 1)),
                    b'D' => (r, c.saturating_sub(n)),
                    _ => self.cursor,
                };
            }
            _ => {
                // Unknown CSI — ignore
            }
        }
    }
}

fn is_csi_terminator(b: u8) -> bool {
    (b'@'..=b'~').contains(&b)
}

fn erase_from(buffer: &mut ShadowBuffer, row: usize, col: usize) {
    if row < SHADOW_ROWS {
        for c in col..SHADOW_COLS { buffer.write_char(row, c, ' ', ""); }
    }
    for r in (row + 1)..SHADOW_ROWS {
        for c in 0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
    }
}

fn erase_all(buffer: &mut ShadowBuffer) {
    for r in 0..SHADOW_ROWS {
        for c in 0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
    }
}

// ── GnuCobolLegacyEmitter ─────────────────────────────────────────────
//
// Re-emits the buffered screen state in libcob/ncurses-style:
//   - Per-row positioned write with `\e7` save / `\e8` restore dance
//   - SGR resets between rows
//   - Trailing position-to-end-of-content + save-cursor
//
// This pattern was captured from real GnuCOBOL output (see
// checkpoints/nwsys/traces/gnucobol_011.raw). The byte structure produced
// here matches what pyte's chunk-replay sees from libcob, so goldens
// captured from GnuCOBOL chunk-align with our output.
//
// IMPORTANT: This emitter is *write-buffering* — `emit()` accumulates
// bytes (parsed into the shadow), `flush()` produces the libcob-style
// output. The runtime needs to call `flush()` at "refresh points":
// before ACCEPT, before program exit. The `screen_emission::emit_flush()`
// helper provides that hook.

pub struct GnuCobolLegacyEmitter {
    parser: AnsiParser,
    pending: ShadowBuffer,
    last_emitted: ShadowBuffer,
    /// Order in which rows were first written this cycle. Used so
    /// render_diff emits in the same order COBOL/libcob would (rows
    /// touched first emit first), matching the byte-stream pattern that
    /// determines pyte's chunk-by-chunk peak detection.
    emit_order: Vec<usize>,
    sink: Box<dyn EmissionStyle>,
}

impl GnuCobolLegacyEmitter {
    pub fn new() -> Self {
        Self {
            parser: AnsiParser::new(),
            pending: ShadowBuffer::new(),
            last_emitted: ShadowBuffer::new(),
            emit_order: Vec::new(),
            sink: Box::new(StdoutEmitter),
        }
    }

    /// Use a custom sink (for testing / chained emitters).
    pub fn with_sink(sink: Box<dyn EmissionStyle>) -> Self {
        Self {
            parser: AnsiParser::new(),
            pending: ShadowBuffer::new(),
            last_emitted: ShadowBuffer::new(),
            emit_order: Vec::new(),
            sink,
        }
    }

    /// Compute the libcob-style byte stream for the current pending state
    /// relative to `last_emitted`. Walks DIRTY cells (those touched by a
    /// field write), groups them into contiguous runs, and emits each run
    /// as a SEPARATE positioned write with libcob's cursor-dance pattern.
    ///
    /// Dirty-run grouping (rather than non-space grouping) is what
    /// distinguishes field boundaries from word boundaries: the spaces
    /// between words inside a field are dirty (the field wrote them), but
    /// the spaces BETWEEN fields are not dirty. So a row with literal
    /// "Enter ... below." (40 chars at cols 1-40, all dirty) followed by
    /// success-field "Y" at col 42 (1 char dirty) yields TWO runs —
    /// matching libcob's per-field emission, which is what the goldens
    /// were captured from.
    fn render_diff(&self) -> Vec<u8> {
        Self::render_libcob_pattern(&self.pending, Some(&self.parser.emit_order))
    }

    /// Buffer-direct version of `render_diff`: walks the dirty cells of
    /// `buffer` (passed in by the caller via `op_flush`) and emits the
    /// libcob save/restore pattern for each contiguous dirty run. Used
    /// by the Slice 5 `op_*` path which bypasses `AnsiParser`.
    fn render_libcob_pattern(buffer: &ShadowBuffer, emit_order: Option<&[usize]>) -> Vec<u8> {
        use std::fmt::Write as _;
        let mut out = Vec::with_capacity(2048);
        // Emit rows in the order they were first written. For the byte-level
        // path, AnsiParser tracked `emit_order` during feed. For the
        // buffer-direct (op_*) path, no order tracking is available — fall
        // back to natural row order (0..N), which matches consolidated emit.
        let mut order: Vec<usize> = emit_order.map(|s| s.to_vec()).unwrap_or_default();
        for r in 0..SHADOW_ROWS {
            if buffer.row_dirty(r) && !order.contains(&r) {
                order.push(r);
            }
        }
        for &r in &order {
            if !buffer.row_dirty(r) { continue; }
            let mut c = 0usize;
            while c < SHADOW_COLS {
                while c < SHADOW_COLS && !buffer.dirty[r][c] { c += 1; }
                if c >= SHADOW_COLS { break; }
                let start = c;
                while c < SHADOW_COLS && buffer.dirty[r][c] { c += 1; }
                let end_excl = c;
                // libcob pattern (from gnucobol_011.raw trace):
                //   \e[R;startH \e[0m <content> \e8 \e[R;end+1H \e7
                let mut buf = String::new();
                let _ = write!(buf, "\x1b[{};{}H\x1b[0m", r + 1, start + 1);
                for cc in start..end_excl {
                    buf.push(buffer.cells[r][cc]);
                }
                let _ = write!(buf, "\x1b8\x1b[{};{}H\x1b7", r + 1, end_excl + 1);
                out.extend_from_slice(buf.as_bytes());
            }
        }
        out
    }
}

impl Default for GnuCobolLegacyEmitter {
    fn default() -> Self { Self::new() }
}

impl EmissionStyle for GnuCobolLegacyEmitter {
    fn emit(&mut self, bytes: &[u8]) {
        // Parse into pending buffer. Don't emit yet — flush() will
        // produce the libcob-style output.
        self.parser.feed(bytes, &mut self.pending);
    }

    fn flush(&mut self) {
        let payload = self.render_diff();
        if !payload.is_empty() {
            self.sink.emit(&payload);
            // Update last_emitted = pending snapshot
            self.last_emitted = self.pending.clone();
            self.pending.clear_dirty();
            // Reset emit_order so the next flush cycle tracks fresh writes.
            self.parser.reset_emit_order();
        }
        self.sink.flush();
    }

    // ── Slice 5 op_* overrides ───────────────────────────────────────
    //
    // Buffer-direct path: callers mutate the EXTERNAL buffer (passed in
    // by `op_*`) and the emitter renders libcob bytes from it on
    // `op_flush`. Skips `AnsiParser` and `self.pending` entirely. Use
    // this path when the caller already maintains a canonical buffer
    // (e.g. the SHADOW global in screen.rs) — it avoids parsing bytes
    // back into a buffer that's about to be re-rendered as bytes.
    fn op_write_at(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16, text: &str, sgr: &str) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        let mut wr = r;
        let mut wc = c0;
        for ch in text.chars() {
            if wc >= SHADOW_COLS {
                wr += 1;
                wc = 0;
                if wr >= SHADOW_ROWS { break; }
            }
            buffer.write_char(wr, wc, ch, sgr);
            wc += 1;
        }
    }

    fn op_position(&mut self, row: u16, col: u16) {
        // Cursor position is informational for libcob — render_diff
        // generates the cursor escapes itself. No-op.
        let _ = (row, col);
    }

    fn op_erase_eol(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
        }
    }

    fn op_erase_eos(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
            for rr in (r + 1)..SHADOW_ROWS {
                for c in 0..SHADOW_COLS { buffer.write_char(rr, c, ' ', ""); }
            }
        }
    }

    fn op_flush(&mut self, buffer: &mut ShadowBuffer) {
        // Render libcob pattern from the EXTERNAL buffer's dirty cells.
        let payload = Self::render_libcob_pattern(buffer, None);
        if !payload.is_empty() {
            self.sink.emit(&payload);
            self.last_emitted = buffer.clone();
            buffer.clear_dirty();
        }
        self.sink.flush();
    }
}

// ── Mainframe3270Emitter ──────────────────────────────────────────────
//
// Translates ShadowBuffer state into IBM 3270 data-stream orders:
//   F5 (Erase/Write) + WCC + (SBA + EBCDIC text)*
//
// Validates the EmissionStyle abstraction with a wholly different
// protocol. See checkpoints/nwsys/PHASE_3_INVESTIGATION.md.

pub struct Mainframe3270Emitter {
    parser: AnsiParser,
    pending: ShadowBuffer,
    sink: Box<dyn EmissionStyle>,
}

impl Mainframe3270Emitter {
    pub fn new() -> Self {
        Self {
            parser: AnsiParser::new(),
            pending: ShadowBuffer::new(),
            sink: Box::new(StdoutEmitter),
        }
    }

    pub fn with_sink(sink: Box<dyn EmissionStyle>) -> Self {
        Self {
            parser: AnsiParser::new(),
            pending: ShadowBuffer::new(),
            sink,
        }
    }

    /// Encode the pending shadow buffer as a 3270 Write command.
    pub fn render_3270(&self) -> Vec<u8> {
        Self::render_3270_pattern(&self.pending)
    }

    /// Buffer-direct version of `render_3270`: encodes the given buffer
    /// (regardless of source — internal pending or external SHADOW) as a
    /// 3270 Write command. Used by the Slice 5 `op_flush` path.
    pub fn render_3270_pattern(buffer: &ShadowBuffer) -> Vec<u8> {
        let mut out = Vec::with_capacity(1024);
        // Erase/Write command + WCC (Reset MDT, Keyboard restore)
        out.push(0xF5);          // Erase/Write
        out.push(0xC3);          // WCC: reset, restore keyboard
        // Walk non-space cells; for each contiguous run, emit SBA + EBCDIC text.
        let mut r = 0usize;
        while r < SHADOW_ROWS {
            let mut c = 0usize;
            while c < SHADOW_COLS {
                while c < SHADOW_COLS && buffer.cells[r][c] == ' ' { c += 1; }
                if c >= SHADOW_COLS { break; }
                let start = c;
                while c < SHADOW_COLS && buffer.cells[r][c] != ' ' { c += 1; }
                let end_excl = c;
                let addr = (r * SHADOW_COLS + start) as u16;
                out.push(0x11);
                let (hi, lo) = encode_3270_address(addr);
                out.push(hi);
                out.push(lo);
                out.push(0x1D);
                out.push(0x60);
                for cc in start..end_excl {
                    out.push(ascii_to_ebcdic(buffer.cells[r][cc]));
                }
            }
            r += 1;
        }
        out.push(0x13); // IC (Insert Cursor) at origin — placeholder
        out
    }
}

impl Default for Mainframe3270Emitter {
    fn default() -> Self { Self::new() }
}

impl EmissionStyle for Mainframe3270Emitter {
    fn emit(&mut self, bytes: &[u8]) {
        self.parser.feed(bytes, &mut self.pending);
    }

    fn flush(&mut self) {
        let payload = self.render_3270();
        if !payload.is_empty() {
            self.sink.emit(&payload);
        }
        self.sink.flush();
    }

    // ── Slice 5 op_* overrides — buffer-direct path ─────────────────
    fn op_write_at(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16, text: &str, sgr: &str) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        let mut wr = r;
        let mut wc = c0;
        for ch in text.chars() {
            if wc >= SHADOW_COLS {
                wr += 1;
                wc = 0;
                if wr >= SHADOW_ROWS { break; }
            }
            buffer.write_char(wr, wc, ch, sgr);
            wc += 1;
        }
    }

    fn op_position(&mut self, _row: u16, _col: u16) {
        // 3270 emits IC (Insert Cursor) at flush time — runtime cursor moves
        // don't generate orders.
    }

    fn op_erase_eol(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
        }
    }

    fn op_erase_eos(&mut self, buffer: &mut ShadowBuffer, row: u16, col: u16) {
        let r = (row as usize).saturating_sub(1);
        let c0 = (col as usize).saturating_sub(1);
        if r < SHADOW_ROWS {
            for c in c0..SHADOW_COLS { buffer.write_char(r, c, ' ', ""); }
            for rr in (r + 1)..SHADOW_ROWS {
                for c in 0..SHADOW_COLS { buffer.write_char(rr, c, ' ', ""); }
            }
        }
    }

    fn op_flush(&mut self, buffer: &mut ShadowBuffer) {
        // Encode the EXTERNAL buffer state as a 3270 Write command.
        // Always emits (3270 is a frame protocol — even an empty frame is
        // a valid Erase/Write); but skip the sink if nothing's there.
        let payload = Self::render_3270_pattern(buffer);
        if !payload.is_empty() {
            self.sink.emit(&payload);
            buffer.clear_dirty();
        }
        self.sink.flush();
    }
}

/// 3270 12-bit buffer address encoding. Each 6-bit nibble maps via the
/// 6-bit-per-byte table (`0x40..=0xFE` skipping certain codes).
fn encode_3270_address(addr: u16) -> (u8, u8) {
    // Standard 3270 6-bit table for the 12-bit address's high+low halves.
    // Table maps 0..=63 to specific bytes per IBM 3270 spec.
    const T: [u8; 64] = [
        0x40, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7,
        0xC8, 0xC9, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
        0x50, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7,
        0xD8, 0xD9, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
        0x60, 0x61, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
        0xE8, 0xE9, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
        0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,
        0xF8, 0xF9, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
    ];
    let hi = T[((addr >> 6) & 0x3F) as usize];
    let lo = T[(addr & 0x3F) as usize];
    (hi, lo)
}

/// Minimal ASCII → EBCDIC for printable chars. Falls back to space for
/// characters outside the basic Latin range.
fn ascii_to_ebcdic(ch: char) -> u8 {
    let a = ch as u32;
    if a > 0x7f { return 0x40; } // EBCDIC space
    // Use the runtime's EBCDIC table.
    crate::ebcdic::ascii_to_ebcdic(a as u8)
}
