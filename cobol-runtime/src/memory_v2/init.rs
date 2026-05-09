//! `initialize_idx` — per-kind default values.
//!
//! Matches COBOL `INITIALIZE field` semantics:
//!
//! | Kind                  | Default                                       |
//! |-----------------------|-----------------------------------------------|
//! | Alphanumeric          | space-fill                                    |
//! | EditedAlpha           | space-fill (insertion chars get overwritten)  |
//! | LvarAlphanumeric      | space-fill declared capacity, forget logical length |
//! | Numeric (all kinds)   | zero through the `i128` write pipeline        |
//! | EditedNumeric         | formatted zero via the pattern table          |
//! | Pointer               | NULL (side-table entry dropped, 8 zero bytes) |

use ironclad_central_buffer::FieldKind;

use super::CobolRecordV2;

impl CobolRecordV2 {
    /// Reset field `idx` to its type-appropriate default.
    pub fn initialize_idx(&mut self, idx: ironclad_central_buffer::FieldIdx) {
        let meta_kind = self.meta(idx).kind;
        match meta_kind {
            FieldKind::EditedNumeric { .. } => {
                // Format a zero through the pattern table.
                self.mem.write_edited(&self.map, idx.as_usize(), 0);
            }
            FieldKind::Pointer => {
                // Drop any live side-table entry; zero the 8 bytes.
                self.mem.set_pointer_null(&self.map, idx.as_usize());
            }
            FieldKind::LvarAlphanumeric { .. } => {
                // Space-fill the declared capacity and clear the
                // logical-length override.
                let meta = self.meta(idx).clone();
                self.mem.initialize(&meta);
                // initialize() leaves the length map untouched — but
                // for "INITIALIZE" we want the post-init L-var to
                // report max_len (i.e. "unset"), which is the default
                // for absent entries. Writing `max_len` explicitly
                // keeps any existing entry coherent.
                if let FieldKind::LvarAlphanumeric { max_len } = meta_kind {
                    self.mem
                        .lvar_set_len(idx.as_usize(), max_len as usize);
                }
            }
            _ => {
                // Alphanumeric / EditedAlpha / all numeric kinds are
                // handled uniformly by IroncladMemory::initialize.
                let meta = self.meta(idx).clone();
                self.mem.initialize(&meta);
            }
        }
    }

    /// Convenience for `INITIALIZE ... REPLACING ALPHANUMERIC BY SPACES`
    /// — explicitly forces a space-fill regardless of kind. Numeric
    /// fields get ASCII `'0'` fills through the same space code.
    ///
    /// Kept distinct from [`Self::initialize_idx`] so the transpiler
    /// can target the COBOL 2002 `REPLACING` semantics without
    /// special-casing in codegen.
    pub fn initialize_physical_idx(
        &mut self,
        idx: ironclad_central_buffer::FieldIdx,
    ) {
        let meta = self.meta(idx).clone();
        // Space-fill the physical bytes regardless of kind — this is
        // the "raw" INITIALIZE variant used by MOVE SPACES on a
        // group item.
        let bytes = vec![b' '; meta.len];
        self.mem.set_data(meta.offset, &bytes);
    }
}
