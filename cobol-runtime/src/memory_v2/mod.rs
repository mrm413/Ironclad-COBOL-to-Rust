//! # `memory_v2` — central-buffer backed runtime facade.
//!
//! Thin, index-based adapter over [`ironclad_central_buffer::IroncladMemory`]
//! + [`ironclad_central_buffer::OffsetMap`]. Exposed only when the
//! `central-buffer` Cargo feature is enabled (default OFF in Phase 4).
//!
//! ## Design
//!
//! * One [`CobolRecordV2`] owns both an `IroncladMemory` *and* an
//!   `OffsetMap` — a single self-contained value the rest of the
//!   runtime (and, in Phase 5, the transpiler) can pass around
//!   without threading two references.
//! * Every public entry point takes a [`FieldIdx`] — a newtype over
//!   `u32` — never a raw `usize`. This eliminates a whole category
//!   of "did you pass an offset or a field id?" bugs.
//! * Generated code in Phase 5 emits one `const FIELD_X: FieldIdx = FieldIdx::new(…);`
//!   per COBOL field and calls `record.set_display_idx(FIELD_X, "…")`
//!   etc. — no HashMap lookup, no string hashing.
//! * The facade does **not** hide the central buffer: `memory()`,
//!   `memory_mut()`, and `map()` accessors let advanced call sites
//!   reach into the underlying crate when they need to.
//!
//! ## Submodule layout
//!
//! | Submodule  | Concern                                                |
//! |------------|--------------------------------------------------------|
//! | [`numeric`] | `i64` / `i128` / `f64` numeric read + write           |
//! | [`display`] | ASCII-display string get + set (numeric + alpha)      |
//! | [`edited`]  | Edited-numeric / edited-alpha format + parse          |
//! | [`moves`]   | `cobol_move_idx` (full 9×kind matrix incl. edited↔edited) |
//! | [`init`]    | `initialize_idx` per-kind defaults                    |
//! | [`pointer`] | USAGE POINTER / BASED / PIC L helpers                 |
//! | [`odo`]     | `resolve_offset_idx` / `odo_live_*` pass-throughs     |
//!
//! Each submodule contributes an `impl CobolRecordV2 { … }` block —
//! so `record.set_i64_idx(…)` works regardless of which file the
//! method happens to live in.

use ironclad_central_buffer::{
    FieldEntry, FieldIdx, FieldKind, FieldMeta, IroncladMemory, OffsetMap,
};

pub mod compat;
pub mod display;
pub mod edited;
pub mod init;
pub mod moves;
pub mod numeric;
pub mod odo;
pub mod pointer;

// Re-export the two newtypes / public vocabulary so downstream crates
// (and, eventually, generated code) can `use cobol_runtime::memory_v2::{
// CobolRecordV2, FieldIdx };` without pulling `ironclad_central_buffer`
// directly.
pub use ironclad_central_buffer::FieldIdx as FieldIdxReExport;

/// A COBOL record backed by the central-buffer memory model.
///
/// Owns one flat `Vec<u8>` of storage plus the descriptive
/// [`OffsetMap`] that the transpiler (Phase 5) will emit as static
/// data. Every method is O(1) in the number of fields — there is no
/// hash-lookup on the hot path.
///
/// # Invariants
/// * `self.map.entries` must contain an entry for every `FieldIdx`
///   passed to any `*_idx` method. Out-of-range indices panic.
/// * `self.mem.len()` ≥ `self.map.required_buffer_size()`. The
///   constructors enforce this.
pub struct CobolRecordV2 {
    mem: IroncladMemory,
    map: OffsetMap,
}

impl CobolRecordV2 {
    /// Build a record whose central buffer is sized to fit every
    /// field in `map` and pre-filled with ASCII spaces (the COBOL
    /// default for alphanumeric WORKING-STORAGE).
    ///
    /// Equivalent to `new_with_size(map, map.required_buffer_size())`.
    pub fn new(map: OffsetMap) -> Self {
        let size = map.required_buffer_size();
        Self::new_with_size(map, size)
    }

    /// Build a record with an explicit buffer size. Useful when the
    /// transpiler has already computed a padded size for a FILE
    /// SECTION record or similar.
    ///
    /// # Panics
    /// Panics if `size < map.required_buffer_size()`.
    pub fn new_with_size(map: OffsetMap, size: usize) -> Self {
        assert!(
            size >= map.required_buffer_size(),
            "CobolRecordV2::new_with_size: requested size {} is smaller than \
             required {} for this OffsetMap",
            size,
            map.required_buffer_size(),
        );
        Self {
            mem: IroncladMemory::new_spaces(size),
            map,
        }
    }

    /// Build a record whose central buffer is zero-filled rather than
    /// space-filled. Matches `IroncladMemory::new` semantics — use
    /// this when generated code wants numeric DEFAULT IS ZEROS.
    pub fn new_zeroed(map: OffsetMap) -> Self {
        let size = map.required_buffer_size();
        Self {
            mem: IroncladMemory::new(size),
            map,
        }
    }

    /// Total bytes owned by the underlying central buffer.
    #[inline]
    pub fn size(&self) -> usize { self.mem.len() }

    /// Borrow the offset map (for diagnostics / tests).
    #[inline]
    pub fn map(&self) -> &OffsetMap { &self.map }

    /// Borrow the central buffer for read-only advanced access.
    #[inline]
    pub fn memory(&self) -> &IroncladMemory { &self.mem }

    /// Mutably borrow the central buffer for advanced access.
    #[inline]
    pub fn memory_mut(&mut self) -> &mut IroncladMemory { &mut self.mem }

    // ── Basic per-field helpers (common to every submodule) ───────────────

    /// Borrow the raw `FieldMeta` for `idx`. Panics if out of range.
    #[inline]
    pub fn meta(&self, idx: FieldIdx) -> &FieldMeta {
        &self.map.entries[idx.as_usize()].meta
    }

    /// Borrow the full `FieldEntry` (meta + cobol_name).
    #[inline]
    pub fn entry(&self, idx: FieldIdx) -> &FieldEntry {
        &self.map.entries[idx.as_usize()]
    }

    /// COBOL name of field `idx` (from the static field table).
    #[inline]
    pub fn cobol_name(&self, idx: FieldIdx) -> &'static str {
        self.map.entries[idx.as_usize()].cobol_name
    }

    /// Declared physical length in bytes of field `idx`. For L-var
    /// fields this is the maximum (declared) capacity — use
    /// [`Self::lvar_len_idx`] for the live logical length.
    #[inline]
    pub fn field_size_idx(&self, idx: FieldIdx) -> usize {
        self.meta(idx).len
    }

    /// Kind of the field at `idx`.
    #[inline]
    pub fn field_kind_idx(&self, idx: FieldIdx) -> FieldKind {
        self.meta(idx).kind
    }

    /// REDEFINES partner lookup. Returns the target field that `idx`
    /// redefines, or `None` if `idx` does not redefine anything.
    pub fn redefines_target_idx(&self, idx: FieldIdx) -> Option<FieldIdx> {
        self.map
            .redefines_target(idx.as_usize())
            .map(|t| FieldIdx::new(t as u32))
    }

    // ── Raw byte access ───────────────────────────────────────────────────

    /// Zero-copy read of the raw bytes of field `idx` (declared length).
    ///
    /// For L-var fields this returns the full declared capacity; use
    /// [`Self::read_lvar_alpha_idx`] for just the logical-length bytes.
    pub fn get_bytes_idx(&self, idx: FieldIdx) -> &[u8] {
        self.mem.read_alphanumeric(self.meta(idx))
    }

    /// Write bytes into an alphanumeric / edited-alpha / L-var field.
    /// Truncates to the declared length; space-pads any remainder.
    ///
    /// For numeric kinds this delegates to [`Self::set_display_idx`]
    /// after UTF-8 decoding the bytes, so callers get consistent
    /// COBOL move-to-numeric semantics regardless of entry point.
    pub fn set_bytes_idx(&mut self, idx: FieldIdx, data: &[u8]) {
        let meta = self.meta(idx).clone();
        match meta.kind {
            FieldKind::Alphanumeric | FieldKind::EditedAlpha { .. } => {
                self.mem.write_alphanumeric(&meta, data);
            }
            FieldKind::LvarAlphanumeric { .. } => {
                self.mem.write_lvar_alpha(&self.map, idx.as_usize(), data);
            }
            FieldKind::Pointer => {
                // Canonical 8-byte little-endian image — same rule as
                // IroncladMemory::write_numeric_i128 on Pointer.
                let mut buf = [0u8; 8];
                let copy = data.len().min(8);
                buf[..copy].copy_from_slice(&data[..copy]);
                self.mem.set_data(meta.offset, &buf);
            }
            _ => {
                // Numeric / edited-numeric — go through the display
                // path so the bytes are validated and normalised.
                let s = String::from_utf8_lossy(data);
                self.set_display_idx(idx, &s);
            }
        }
    }

    // ── Reference modification (COBOL `field(start:length)`) ─────────────

    /// 1-based reference-modification read (COBOL `field(start:length)`).
    pub fn get_refmod_idx(
        &self,
        idx: FieldIdx,
        start1: usize,
        length: usize,
    ) -> &[u8] {
        self.mem.refmod_read(self.meta(idx), start1, length)
    }

    /// 1-based reference-modification write.
    pub fn set_refmod_idx(
        &mut self,
        idx: FieldIdx,
        start1: usize,
        length: usize,
        data: &[u8],
    ) {
        let meta = self.meta(idx).clone();
        self.mem.refmod_write(&meta, start1, length, data);
    }

    /// `MOVE ALL "pattern" TO field` — fill the declared length of
    /// `idx` with a repeating byte pattern.
    pub fn fill_field_idx(&mut self, idx: FieldIdx, pattern: &[u8]) {
        let meta = self.meta(idx).clone();
        self.mem.fill_pattern(&meta, pattern);
    }

    /// Write `data` into field `idx`, zero-padding any unused trailing
    /// bytes. Used for binary / `ALL X"00"` figurative constants
    /// where the COBOL default space-pad is wrong. Mirrors legacy
    /// `CobolRecord::set_bytes_null_padded`.
    pub fn set_bytes_null_padded_idx(&mut self, idx: FieldIdx, data: &[u8]) {
        let meta = self.meta(idx).clone();
        let off = meta.offset;
        let len = meta.len;
        // Zero the slot, then overlay the source bytes.
        let zeroes = vec![0u8; len];
        self.mem.set_data(off, &zeroes);
        let copy_len = data.len().min(len);
        if copy_len > 0 {
            self.mem.set_data(off, &data[..copy_len]);
        }
    }

    /// Raw byte copy into `idx` with no space-fill or type coercion.
    /// Used by `FUNCTION CONVERT-TO-*` intrinsics to preserve byte
    /// images across calls. Mirrors legacy
    /// `CobolRecord::restore_raw_bytes`.
    pub fn restore_raw_bytes_idx(&mut self, idx: FieldIdx, data: &[u8]) {
        let meta = self.meta(idx).clone();
        let copy_len = data.len().min(meta.len);
        if copy_len > 0 {
            self.mem.set_data(meta.offset, &data[..copy_len]);
        }
    }

    /// Logical length of field `idx`.
    ///
    /// For `LvarAlphanumeric` fields returns the live logical length
    /// recorded via [`Self::lvar_set_len_idx`] / implied by
    /// [`Self::write_lvar_alpha_idx`]. For all other kinds returns
    /// the declared byte width. Mirrors legacy
    /// `CobolRecord::length_of`.
    pub fn length_of_idx(&self, idx: FieldIdx) -> usize {
        match self.meta(idx).kind {
            FieldKind::LvarAlphanumeric { .. } => self.lvar_len_idx(idx),
            _ => self.field_size_idx(idx),
        }
    }

    /// Implementation of the COBOL intrinsic `FUNCTION LENGTH`. For
    /// Phase 5 this has the same semantics as [`Self::length_of_idx`];
    /// a later phase may diverge for group-level variants. Mirrors
    /// legacy `CobolRecord::function_length_of`.
    pub fn function_length_of_idx(&self, idx: FieldIdx) -> usize {
        self.length_of_idx(idx)
    }
}
