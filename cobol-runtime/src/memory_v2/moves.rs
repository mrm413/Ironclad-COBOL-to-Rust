//! `cobol_move_idx` — the full 9×kind move matrix with edited↔edited.
//!
//! The underlying [`ironclad_central_buffer::IroncladMemory::move_cobol`]
//! panics on any pair involving `EditedNumeric` (the pattern lives in
//! the `OffsetMap`, not the meta). This module owns the `OffsetMap`
//! and so can handle every edited combination cleanly:
//!
//! | src\\dst | EditedNum | EditedAlpha | Alphanumeric | Numeric | Pointer | L-var |
//! |----------|-----------|-------------|--------------|---------|---------|-------|
//! | EditedNum    | parse→format | parse→digits | parse→format | parse→i128 | parse→u64 | parse→digits |
//! | EditedAlpha  | digits→format| strip→format | strip→copy   | strip→i128 | strip→u64 | strip→copy  |
//! | (rest)       | ————— delegated to IroncladMemory::move_cobol ————— |
//!
//! The "edited-to-edited" row was explicitly deferred in the Phase 2
//! checkpoint ("map-aware MOVE-to-edited still requires the OffsetMap
//! plumbing done in Phase 4"). This implementation closes that gap.

use ironclad_central_buffer::{FieldIdx, FieldKind};

use super::CobolRecordV2;

impl CobolRecordV2 {
    /// COBOL `MOVE src TO dst` — handles every `FieldKind` pair.
    ///
    /// Semantics:
    /// * Numeric → numeric uses the scale-preserving `i128` pipeline.
    /// * Alphanumeric ↔ alphanumeric / edited-alpha / L-var is byte-
    ///   level copy with space-pad truncation.
    /// * Any pair touching `EditedNumeric` parses the source into a
    ///   scaled `i128`, then formats through the destination pattern.
    /// * Source `EditedAlpha` has its insertion characters stripped
    ///   via `parse_edited_alpha` before being re-emitted or moved.
    pub fn cobol_move_idx(&mut self, src: FieldIdx, dst: FieldIdx) {
        let src_kind = self.meta(src).kind;
        let dst_kind = self.meta(dst).kind;

        match (src_kind, dst_kind) {
            // ── Edited source ──────────────────────────────────────────
            (FieldKind::EditedNumeric { .. }, _) => {
                self.move_from_edited_numeric(src, dst);
            }
            (FieldKind::EditedAlpha { .. }, _) => {
                self.move_from_edited_alpha(src, dst);
            }
            // ── Non-edited source but edited destination ───────────────
            (_, FieldKind::EditedNumeric { .. }) => {
                // Parse source → scaled i128 → write_edited.
                let value = self.mem.read_numeric_i128(self.meta(src));
                let src_scale = scale_of(src_kind);
                let dst_scale = match dst_kind {
                    FieldKind::EditedNumeric { scale, .. } => scale,
                    _ => 0,
                };
                let rescaled = rescale_i128(value, src_scale, dst_scale);
                self.mem
                    .write_edited(&self.map, dst.as_usize(), rescaled);
            }
            (_, FieldKind::EditedAlpha { .. }) => {
                // Use the raw bytes of src (for alpha) or the digit
                // string (for numeric).
                let digits: Vec<u8> = if is_alpha_like(src_kind) {
                    self.alpha_source_bytes(src)
                } else {
                    let v = self.mem.read_numeric_i128(self.meta(src));
                    v.unsigned_abs().to_string().into_bytes()
                };
                self.mem
                    .write_edited_alpha(&self.map, dst.as_usize(), &digits);
            }
            // ── Plain path — let IroncladMemory handle the rest. ───────
            _ => {
                let src_meta = self.meta(src).clone();
                let dst_meta = self.meta(dst).clone();
                self.mem.move_cobol(&src_meta, &dst_meta);
            }
        }
    }

    // ── Dispatch: source = EditedNumeric ───────────────────────────────────

    fn move_from_edited_numeric(&mut self, src: FieldIdx, dst: FieldIdx) {
        let src_scale = match self.meta(src).kind {
            FieldKind::EditedNumeric { scale, .. } => scale,
            _ => 0,
        };
        let value = self.mem.read_edited(&self.map, src.as_usize());
        let dst_kind = self.meta(dst).kind;
        match dst_kind {
            FieldKind::EditedNumeric { scale: dst_scale, .. } => {
                let rescaled = rescale_i128(value, src_scale, dst_scale);
                self.mem
                    .write_edited(&self.map, dst.as_usize(), rescaled);
            }
            FieldKind::EditedAlpha { .. } => {
                // Bridge via absolute-value digits.
                let digits = value.unsigned_abs().to_string().into_bytes();
                self.mem
                    .write_edited_alpha(&self.map, dst.as_usize(), &digits);
            }
            FieldKind::Alphanumeric | FieldKind::LvarAlphanumeric { .. } => {
                // Copy the formatted bytes verbatim (matches legacy
                // MOVE edited-numeric TO X(n) which takes the
                // formatted image, including sign/currency).
                let src_bytes = self.mem.read_alphanumeric(self.meta(src)).to_vec();
                self.write_alpha_from_bytes(dst, &src_bytes);
            }
            FieldKind::Pointer => {
                let target = value as u64;
                let dst_off = self.meta(dst).offset;
                self.mem.set_data(dst_off, &target.to_le_bytes());
            }
            _ => {
                // Any other numeric destination — rescale and write.
                let dst_scale = scale_of(dst_kind);
                let rescaled = rescale_i128(value, src_scale, dst_scale);
                let dst_meta = self.meta(dst).clone();
                self.mem.write_numeric_i128(&dst_meta, rescaled);
            }
        }
    }

    // ── Dispatch: source = EditedAlpha ─────────────────────────────────────

    fn move_from_edited_alpha(&mut self, src: FieldIdx, dst: FieldIdx) {
        // Stripped source bytes (insertion chars removed).
        let raw = self.mem.read_edited_alpha(&self.map, src.as_usize());
        let dst_kind = self.meta(dst).kind;
        match dst_kind {
            FieldKind::EditedAlpha { .. } => {
                self.mem
                    .write_edited_alpha(&self.map, dst.as_usize(), &raw);
            }
            FieldKind::EditedNumeric { scale, .. } => {
                // Interpret stripped bytes as numeric digits, scale
                // up to destination scale.
                let v = digits_to_i128(&raw);
                let rescaled = rescale_i128(v, 0, scale);
                self.mem
                    .write_edited(&self.map, dst.as_usize(), rescaled);
            }
            FieldKind::Alphanumeric | FieldKind::LvarAlphanumeric { .. } => {
                self.write_alpha_from_bytes(dst, &raw);
            }
            FieldKind::Pointer => {
                let v = digits_to_i128(&raw) as u64;
                let dst_off = self.meta(dst).offset;
                self.mem.set_data(dst_off, &v.to_le_bytes());
            }
            _ => {
                // Numeric destination — stripped digits → i128 → write.
                let v = digits_to_i128(&raw);
                let dst_scale = scale_of(dst_kind);
                let rescaled = rescale_i128(v, 0, dst_scale);
                let dst_meta = self.meta(dst).clone();
                self.mem.write_numeric_i128(&dst_meta, rescaled);
            }
        }
    }

    // ── Small shared helpers ───────────────────────────────────────────────

    /// Read bytes of an alphanumeric-family source for MOVE. Honours
    /// L-var logical length; takes the declared bytes otherwise.
    fn alpha_source_bytes(&self, src: FieldIdx) -> Vec<u8> {
        match self.meta(src).kind {
            FieldKind::LvarAlphanumeric { .. } => {
                self.mem.read_lvar_alpha(&self.map, src.as_usize())
            }
            _ => self.mem.read_alphanumeric(self.meta(src)).to_vec(),
        }
    }

    /// Write bytes into an alphanumeric / L-var destination with the
    /// correct length policy for its kind.
    fn write_alpha_from_bytes(&mut self, dst: FieldIdx, bytes: &[u8]) {
        match self.meta(dst).kind {
            FieldKind::LvarAlphanumeric { .. } => {
                self.mem
                    .write_lvar_alpha(&self.map, dst.as_usize(), bytes);
            }
            _ => {
                let meta = self.meta(dst).clone();
                self.mem.write_alphanumeric(&meta, bytes);
            }
        }
    }
}

// ── Module-private helpers (no `self`) ─────────────────────────────────────

fn scale_of(kind: FieldKind) -> i8 {
    match kind {
        FieldKind::NumericDisplay { scale }
        | FieldKind::SignedDisplay { scale, .. }
        | FieldKind::SignSeparate { scale, .. }
        | FieldKind::Comp3 { scale, .. }
        | FieldKind::Comp6 { scale } => scale,
        FieldKind::EditedNumeric { scale, .. } => scale,
        _ => 0,
    }
}

fn is_alpha_like(kind: FieldKind) -> bool {
    matches!(
        kind,
        FieldKind::Alphanumeric
            | FieldKind::EditedAlpha { .. }
            | FieldKind::LvarAlphanumeric { .. }
    )
}

/// Adjust a scaled `i128` value when moving between two fixed-point
/// fields with different scales. Rounds toward zero on scale-down
/// (matches COBOL ROUNDED off / truncation semantics).
fn rescale_i128(value: i128, src_scale: i8, dst_scale: i8) -> i128 {
    let diff = dst_scale as i32 - src_scale as i32;
    match diff.cmp(&0) {
        std::cmp::Ordering::Equal => value,
        std::cmp::Ordering::Greater => {
            value.saturating_mul(10_i128.pow(diff as u32))
        }
        std::cmp::Ordering::Less => {
            let denom = 10_i128.pow((-diff) as u32);
            value / denom
        }
    }
}

/// Parse a byte slice of ASCII digits into an `i128`. Non-digit
/// bytes are skipped. Overflow is saturated.
fn digits_to_i128(bytes: &[u8]) -> i128 {
    let mut v: i128 = 0;
    let mut negative = false;
    for b in bytes {
        match *b {
            b'-' => negative = true,
            b'+' => {}
            c if c.is_ascii_digit() => {
                v = v
                    .saturating_mul(10)
                    .saturating_add((c - b'0') as i128);
            }
            _ => {}
        }
    }
    if negative { -v } else { v }
}
