//! Display (ASCII string) get/set by [`FieldIdx`].
//!
//! `get_display_idx` returns the field as a COBOL-style ASCII
//! string. `set_display_idx` parses a string and writes it using the
//! right pipeline for the field's kind.

use ironclad_central_buffer::{FieldIdx, FieldKind};

use super::CobolRecordV2;

impl CobolRecordV2 {
    /// Return the field's display image as a `String`.
    ///
    /// Behaviour by kind:
    /// * Alphanumeric / EditedAlpha — raw bytes lossy-decoded as UTF-8.
    /// * L-var — the *logical* length bytes only.
    /// * DisplayNumeric / SignedDisplay — the stored ASCII digits
    ///   (including sign character for SignedDisplay).
    /// * Binary / COMP-3 / COMP-6 / Float — decimal image of the i128
    ///   value, scale-adjusted for fixed-point kinds (matches legacy
    ///   `CobolRecord::get_display`).
    /// * EditedNumeric / EditedAlpha — the formatted bytes as stored.
    /// * Pointer — the target offset as a decimal integer, or
    ///   `"NULL"` when the pointer image is all-zero.
    pub fn get_display_idx(&self, idx: FieldIdx) -> String {
        let meta = self.meta(idx);
        match meta.kind {
            FieldKind::Alphanumeric | FieldKind::EditedAlpha { .. } => {
                self.mem.read_display(meta)
            }
            FieldKind::LvarAlphanumeric { .. } => {
                let bytes = self.mem.read_lvar_alpha(&self.map, idx.as_usize());
                String::from_utf8_lossy(&bytes).into_owned()
            }
            FieldKind::NumericDisplay { .. }
            | FieldKind::SignedDisplay { .. }
            | FieldKind::SignSeparate { .. } => {
                // Bytes in the central buffer are already the COBOL
                // display image — cheaper than re-formatting.
                self.mem.read_display(meta)
            }
            FieldKind::EditedNumeric { .. } => {
                // Formatted bytes are the display image.
                self.mem.read_display(meta)
            }
            FieldKind::Pointer => {
                match self.mem.get_pointer_target(&self.map, idx.as_usize()) {
                    Some(off) => off.to_string(),
                    None => "NULL".to_string(),
                }
            }
            FieldKind::Binary { .. }
            | FieldKind::Comp3 { .. }
            | FieldKind::Comp6 { .. }
            | FieldKind::Float32
            | FieldKind::Float64 => {
                // Format via the scale-aware read path.
                format_numeric_as_display(self, idx)
            }
        }
    }

    /// Return the unsigned display image — strips any leading `-` or
    /// `+` from SignedDisplay and yields the absolute value for the
    /// numeric kinds. Used by the legacy transpiler where COBOL
    /// moves an S9 value into an unsigned 9 edited target.
    pub fn get_display_unsigned_idx(&self, idx: FieldIdx) -> String {
        let s = self.get_display_idx(idx);
        let trimmed = s.trim();
        if let Some(stripped) = trimmed.strip_prefix('-') {
            stripped.to_string()
        } else if let Some(stripped) = trimmed.strip_prefix('+') {
            stripped.to_string()
        } else {
            trimmed.to_string()
        }
    }

    /// Parse `s` as a decimal literal (e.g. `"123.45"`, `"-0.5"`) and
    /// write it into field `idx`. Delegates to
    /// [`Self::set_display_idx`], which owns the numeric parse
    /// pipeline. Mirrors legacy `CobolRecord::set_decimal_str`.
    pub fn set_decimal_str_idx(&mut self, idx: FieldIdx, s: &str) {
        self.set_display_idx(idx, s);
    }
}
impl CobolRecordV2 {
    /// Write a display-format string into field `idx`.
    ///
    /// Alphanumeric / edited-alpha / L-var → raw bytes (space-padded
    /// or logical-length recorded as appropriate).
    ///
    /// Numeric kinds → parse the string into an `i128` scaled by the
    /// field's `scale` and go through `write_numeric_i128`.
    ///
    /// Edited-numeric → parse via the same helper, then reformat via
    /// `write_edited`.
    pub fn set_display_idx(&mut self, idx: FieldIdx, value: &str) {
        let kind = self.meta(idx).kind;
        match kind {
            FieldKind::Alphanumeric | FieldKind::EditedAlpha { .. } => {
                let meta = self.meta(idx).clone();
                self.mem.write_alphanumeric(&meta, value.as_bytes());
            }
            FieldKind::LvarAlphanumeric { .. } => {
                self.mem
                    .write_lvar_alpha(&self.map, idx.as_usize(), value.as_bytes());
            }
            FieldKind::Pointer => {
                // Accept either "NULL" or a decimal integer target
                // offset. Keeps set_display symmetric with
                // get_display for diagnostics / INITIALIZE scripts.
                let v = value.trim();
                if v.eq_ignore_ascii_case("NULL") || v.is_empty() {
                    self.mem.set_pointer_null(&self.map, idx.as_usize());
                } else if let Ok(target) = v.parse::<u64>() {
                    // Write the 8-byte LE image directly so the side-
                    // table stays in sync with get_pointer_target's
                    // byte-image fallback (no resolve_offset needed).
                    let offset = self.meta(idx).offset;
                    self.mem.set_data(offset, &target.to_le_bytes());
                } else {
                    panic!(
                        "set_display_idx on Pointer field expects \"NULL\" or a \
                         decimal target offset, got: {value:?}"
                    );
                }
            }
            _ => {
                // Numeric / edited-numeric — centralise parsing.
                let scale = scale_of(kind);
                let scaled = parse_to_scaled_i128(value, scale);
                if matches!(kind, FieldKind::EditedNumeric { .. }) {
                    self.mem
                        .write_edited(&self.map, idx.as_usize(), scaled);
                } else {
                    let meta = self.meta(idx).clone();
                    self.mem.write_numeric_i128(&meta, scaled);
                }
            }
        }
    }
}

// ── Private helpers ──────────────────────────────────────────────────────

/// Extract the COBOL decimal scale from any numeric `FieldKind`.
/// Returns 0 for kinds without a scale concept (Binary, Float, etc.).
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

/// Format a numeric field (Binary / COMP-3 / COMP-6 / Float) as a
/// human-readable decimal string respecting the field's scale.
fn format_numeric_as_display(rec: &CobolRecordV2, idx: FieldIdx) -> String {
    let meta = rec.meta(idx);
    let kind = meta.kind;
    match kind {
        FieldKind::Float32 | FieldKind::Float64 => {
            // Use the native f64 formatter — tests that compare raw
            // floats use `read_f64` directly, so this path only
            // matters for log/trace output.
            let v = rec.memory().read_f64(meta);
            format!("{v}")
        }
        _ => {
            let v = rec.memory().read_numeric_i128(meta);
            let scale = scale_of(kind);
            format_scaled_i128(v, scale)
        }
    }
}

/// Turn an `i128` + scale into its canonical decimal string
/// ("-0.25" style). Shared by display formatting and move pipelines.
fn format_scaled_i128(value: i128, scale: i8) -> String {
    if scale <= 0 {
        return value.to_string();
    }
    let scale = scale as usize;
    let negative = value < 0;
    let abs = value.unsigned_abs();
    let mut digits = abs.to_string();
    while digits.len() <= scale {
        digits.insert(0, '0');
    }
    let point = digits.len() - scale;
    digits.insert(point, '.');
    if negative { format!("-{digits}") } else { digits }
}

/// Parse a display string into a scaled `i128`. Accepts leading
/// sign, optional decimal point, trailing sign, and spaces. Extra
/// fractional digits beyond `scale` are truncated (matching legacy
/// COBOL MOVE semantics); missing fractional digits are padded with
/// implicit zeros.
pub(crate) fn parse_to_scaled_i128(text: &str, scale: i8) -> i128 {
    let trimmed = text.trim();
    if trimmed.is_empty() {
        return 0;
    }

    // Detect sign.
    let (sign, body): (i128, &str) = if let Some(rest) = trimmed.strip_prefix('-') {
        (-1, rest)
    } else if let Some(rest) = trimmed.strip_prefix('+') {
        (1, rest)
    } else if let Some(rest) = trimmed.strip_suffix('-') {
        (-1, rest)
    } else if let Some(rest) = trimmed.strip_suffix('+') {
        (1, rest)
    } else {
        (1, trimmed)
    };

    // Split integer / fractional at decimal point.
    let (int_part, frac_part) = match body.split_once('.') {
        Some((a, b)) => (a, b),
        None => (body, ""),
    };

    let clean_int: String = int_part.chars().filter(|c| c.is_ascii_digit()).collect();
    let clean_frac: String = frac_part.chars().filter(|c| c.is_ascii_digit()).collect();

    let int_value: i128 = if clean_int.is_empty() {
        0
    } else {
        clean_int.parse().unwrap_or(0)
    };

    let scale_u = scale.max(0) as usize;
    let mut frac = clean_frac;
    if frac.len() > scale_u {
        frac.truncate(scale_u);
    } else {
        while frac.len() < scale_u {
            frac.push('0');
        }
    }
    let frac_value: i128 = if frac.is_empty() {
        0
    } else {
        frac.parse().unwrap_or(0)
    };

    let multiplier = 10_i128.pow(scale_u as u32);
    sign * (int_value.saturating_mul(multiplier).saturating_add(frac_value))
}
