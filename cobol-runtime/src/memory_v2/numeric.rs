//! Numeric read/write by [`FieldIdx`].
//!
//! All six entry points share a single pipeline: the value goes
//! through `IroncladMemory::read_numeric_i128` / `write_numeric_i128`
//! (scale-aware for display/COMP-3/COMP-6 and i128-accurate for
//! Binary) with a float detour only for COMP-1 / COMP-2.
//!
//! Scale handling: the field's `scale` is encoded inside
//! [`ironclad_central_buffer::FieldKind`] for every numeric kind the
//! central buffer understands (`NumericDisplay`, `SignedDisplay`,
//! `Comp3`, `Comp6`). `i64`/`i128` writers pass the value through as
//! an already-scaled integer — matching how the legacy runtime's
//! `set_i128` works.

use ironclad_central_buffer::{FieldIdx, FieldKind};

use super::CobolRecordV2;

impl CobolRecordV2 {
    /// Read field `idx` as `i64`. For scaled numeric fields the
    /// returned value is the raw (pre-scaled) integer image — same
    /// semantics as the legacy `CobolRecord::get_i64`.
    pub fn get_i64_idx(&self, idx: FieldIdx) -> i64 {
        let v128 = self.get_i128_idx(idx);
        // Saturating clamp keeps the generated code panic-free when
        // a value is moved through an i64 temporary; COBOL itself
        // does not mandate bitwise wrap on move.
        if v128 > i64::MAX as i128 {
            i64::MAX
        } else if v128 < i64::MIN as i128 {
            i64::MIN
        } else {
            v128 as i64
        }
    }

    /// Write field `idx` from an `i64` raw (pre-scaled) integer value.
    pub fn set_i64_idx(&mut self, idx: FieldIdx, value: i64) {
        self.set_i128_idx(idx, value as i128);
    }

    /// Read field `idx` as `i128` (raw, pre-scaled).
    ///
    /// Routes `EditedNumeric` through
    /// [`ironclad_central_buffer::IroncladMemory::read_edited`] so
    /// the pattern is available; all other numeric kinds go through
    /// `read_numeric_i128`.
    pub fn get_i128_idx(&self, idx: FieldIdx) -> i128 {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { .. } | FieldKind::EditedAlpha { .. } => {
                self.mem.read_edited(&self.map, idx.as_usize())
            }
            _ => self.mem.read_numeric_i128(self.meta(idx)),
        }
    }

    /// Write field `idx` from an `i128` raw (pre-scaled) integer value.
    ///
    /// `EditedNumeric` / `EditedAlpha` go through
    /// [`ironclad_central_buffer::IroncladMemory::write_edited`] so
    /// the pattern is consulted.
    pub fn set_i128_idx(&mut self, idx: FieldIdx, value: i128) {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { .. } | FieldKind::EditedAlpha { .. } => {
                self.mem.write_edited(&self.map, idx.as_usize(), value);
            }
            _ => {
                let meta = self.meta(idx).clone();
                self.mem.write_numeric_i128(&meta, value);
            }
        }
    }

    /// Read field `idx` as `f64`, scale-adjusted. For `PIC 9(4)V99`
    /// the stored integer 12345 becomes 123.45.
    ///
    /// `EditedNumeric` / `EditedAlpha` are routed through the
    /// pattern-aware `read_edited` path and rescaled from the field's
    /// implicit decimal scale.
    pub fn get_f64_idx(&self, idx: FieldIdx) -> f64 {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { scale, .. } => {
                let v = self.mem.read_edited(&self.map, idx.as_usize());
                let divisor = 10_f64.powi(scale as i32);
                v as f64 / divisor
            }
            FieldKind::EditedAlpha { .. } => {
                self.mem.read_edited(&self.map, idx.as_usize()) as f64
            }
            _ => self.mem.read_f64(self.meta(idx)),
        }
    }

    /// Write `value` into field `idx`, scale-adjusting for fixed-
    /// point numeric fields (the inverse of [`Self::get_f64_idx`]).
    pub fn set_f64_idx(&mut self, idx: FieldIdx, value: f64) {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { scale, .. } => {
                let multiplier = 10_f64.powi(scale as i32);
                let scaled = (value * multiplier).round() as i128;
                self.mem.write_edited(&self.map, idx.as_usize(), scaled);
            }
            FieldKind::EditedAlpha { .. } => {
                let scaled = value.round() as i128;
                self.mem.write_edited(&self.map, idx.as_usize(), scaled);
            }
            _ => {
                let meta = self.meta(idx).clone();
                self.mem.write_f64(&meta, value);
            }
        }
    }

    /// Classification helper: `true` iff `idx` holds a numeric kind
    /// that the i128 pipeline understands directly. Edited-numeric
    /// is considered numeric here; EditedAlpha and Alphanumeric are
    /// not.
    pub fn is_numeric_idx(&self, idx: FieldIdx) -> bool {
        matches!(
            self.meta(idx).kind,
            FieldKind::NumericDisplay { .. }
                | FieldKind::SignedDisplay { .. }
                | FieldKind::Binary { .. }
                | FieldKind::Comp3 { .. }
                | FieldKind::Comp6 { .. }
                | FieldKind::Float32
                | FieldKind::Float64
                | FieldKind::EditedNumeric { .. }
        )
    }

    /// Read field `idx` as a [`rust_decimal::Decimal`]. The field's
    /// declared scale (from its [`FieldKind`]) becomes the returned
    /// `Decimal`'s scale, so `PIC 9(4)V99` values round-trip as
    /// `nnnn.nn`. Mirrors legacy `CobolRecord::get_decimal`.
    pub fn get_decimal_idx(&self, idx: FieldIdx) -> rust_decimal::Decimal {
        let scale = scale_for_decimal(self.meta(idx).kind);
        let raw = self.get_i128_idx(idx);
        rust_decimal::Decimal::from_i128_with_scale(raw, scale)
    }

    /// Write `val` into field `idx` as a [`rust_decimal::Decimal`].
    /// Rescales `val` to the field's declared scale before storing as
    /// `i128`. Mirrors legacy `CobolRecord::set_decimal`.
    pub fn set_decimal_idx(&mut self, idx: FieldIdx, val: rust_decimal::Decimal) {
        let field_scale = scale_for_decimal(self.meta(idx).kind);
        let mut v = val;
        v.rescale(field_scale);
        self.set_i128_idx(idx, v.mantissa());
    }

    /// `COMPUTE … ROUNDED MODE` — round `value` to the field's scale
    /// using `mode`, then store.
    ///
    /// `mode` values (matching legacy `CobolRecord::set_f64_rounded`):
    /// * 0 – truncation (toward zero)
    /// * 1 – away from zero
    /// * 2 – nearest, ties away from zero
    /// * 3 – nearest, banker's (ties to even)
    /// * 4 – nearest, ties toward zero
    /// * 5 – toward +∞ (ceiling)
    /// * 6 – toward −∞ (floor)
    /// any other value falls back to nearest-even.
    ///
    /// Float storage kinds (`COMP-1` / `COMP-2`) always store the full
    /// precision value, so `mode` is ignored there.
    pub fn set_f64_rounded_idx(&mut self, idx: FieldIdx, value: f64, mode: u8) {
        let kind = self.meta(idx).kind;
        if matches!(kind, FieldKind::Float32 | FieldKind::Float64) {
            self.set_f64_idx(idx, value);
            return;
        }
        let scale = scale_for_decimal(kind);
        let factor = 10f64.powi(scale as i32);
        let scaled = value * factor;
        let fractional = scaled - scaled.trunc();
        let is_half = (fractional.abs() - 0.5).abs() < 1e-10;
        let rounded = match mode {
            0 => scaled.trunc(),
            1 => if scaled >= 0.0 { scaled.ceil() } else { scaled.floor() },
            2 => scaled.round(),
            3 => {
                if is_half {
                    let r = scaled.round();
                    if (r as i128) % 2 != 0 { r - scaled.signum() } else { r }
                } else {
                    scaled.round()
                }
            }
            4 => if is_half { scaled.trunc() } else { scaled.round() },
            5 => scaled.ceil(),
            6 => scaled.floor(),
            _ => scaled.round(),
        };
        self.set_f64_idx(idx, rounded / factor);
    }
}

/// Extract the COBOL decimal scale from any numeric `FieldKind` as a
/// `u32` (never negative). Kinds without scale return 0.
fn scale_for_decimal(kind: FieldKind) -> u32 {
    match kind {
        FieldKind::NumericDisplay { scale }
        | FieldKind::SignedDisplay { scale, .. }
        | FieldKind::SignSeparate { scale, .. }
        | FieldKind::Comp3 { scale, .. }
        | FieldKind::Comp6 { scale }
        | FieldKind::EditedNumeric { scale, .. } => scale.max(0) as u32,
        _ => 0,
    }
}
