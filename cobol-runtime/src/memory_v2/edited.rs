//! Edited-numeric / edited-alpha read + write by [`FieldIdx`].
//!
//! All three entry points delegate to the underlying central-buffer
//! helpers (`write_edited`, `read_edited`, `read_edited_alpha`,
//! `write_edited_alpha`) — the v2 facade simply adds the `FieldIdx`
//! newtype on the way in and centralises the display-string parsing
//! used by `MOVE "12.34" TO edited`.

use ironclad_central_buffer::{FieldIdx, FieldKind};

use super::CobolRecordV2;
use super::display::parse_to_scaled_i128;

impl CobolRecordV2 {
    /// Read the formatted (as-stored) bytes of an edited field and
    /// return them as a `String`.
    ///
    /// For `EditedNumeric` this yields the final formatted image
    /// ("-1,234.56"), *not* the underlying `i128` — callers that
    /// need the numeric value should use [`Self::get_i128_idx`]
    /// (which parses the formatted bytes via `parse_edited`).
    ///
    /// # Panics
    /// Panics if `idx` is not an edited kind.
    pub fn get_edited_display_idx(&self, idx: FieldIdx) -> String {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { .. } | FieldKind::EditedAlpha { .. } => {
                self.mem.read_display(self.meta(idx))
            }
            other => panic!(
                "get_edited_display_idx: field {:?} is {:?}, not edited",
                idx, other
            ),
        }
    }

    /// Format `value` through the field's edit pattern and write it
    /// into the buffer. `value` must be pre-scaled for
    /// `EditedNumeric` (pass 1234 for "12.34" with scale=2).
    ///
    /// For `EditedAlpha` the value is stringified via absolute-value
    /// decimal and fed through `format_edited_alpha` — matches the
    /// COBOL `MOVE numeric TO edited-alpha` rule.
    ///
    /// # Panics
    /// Panics if `idx` is not an edited kind.
    pub fn set_edited_from_i128_idx(&mut self, idx: FieldIdx, value: i128) {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { .. } | FieldKind::EditedAlpha { .. } => {
                self.mem.write_edited(&self.map, idx.as_usize(), value);
            }
            other => panic!(
                "set_edited_from_i128_idx: field {:?} is {:?}, not edited",
                idx, other
            ),
        }
    }

    /// Parse a display-format string and write it through the
    /// field's edit pattern. Handles both `EditedNumeric` (goes
    /// through `parse_to_scaled_i128`) and `EditedAlpha` (raw bytes
    /// go to `write_edited_alpha`).
    ///
    /// # Panics
    /// Panics if `idx` is not an edited kind.
    pub fn set_edited_from_display_idx(&mut self, idx: FieldIdx, value: &str) {
        match self.meta(idx).kind {
            FieldKind::EditedNumeric { scale, .. } => {
                let scaled = parse_to_scaled_i128(value, scale);
                self.mem
                    .write_edited(&self.map, idx.as_usize(), scaled);
            }
            FieldKind::EditedAlpha { .. } => {
                self.mem.write_edited_alpha(
                    &self.map,
                    idx.as_usize(),
                    value.as_bytes(),
                );
            }
            other => panic!(
                "set_edited_from_display_idx: field {:?} is {:?}, not edited",
                idx, other
            ),
        }
    }
}
