//! POINTER / BASED / PIC-L pass-through wrappers.
//!
//! All of these call directly into the corresponding
//! [`ironclad_central_buffer::IroncladMemory`] helper; the only job
//! of this module is to speak [`FieldIdx`] instead of `usize` at the
//! API surface and to borrow `self.map` for the caller.

use ironclad_central_buffer::FieldIdx;

use super::CobolRecordV2;

impl CobolRecordV2 {
    // ── USAGE POINTER ──────────────────────────────────────────────────

    /// `SET ptr TO ADDRESS OF target`.
    pub fn set_address_of_idx(&mut self, ptr: FieldIdx, target: FieldIdx) {
        self.mem
            .set_address_of(&self.map, ptr.as_usize(), target.as_usize());
    }

    /// `SET ptr TO NULL`.
    pub fn set_pointer_null_idx(&mut self, ptr: FieldIdx) {
        self.mem.set_pointer_null(&self.map, ptr.as_usize());
    }

    /// Read the live target byte offset of a pointer. `None` = NULL.
    pub fn get_pointer_target_idx(&self, ptr: FieldIdx) -> Option<usize> {
        self.mem.get_pointer_target(&self.map, ptr.as_usize())
    }

    /// `SET ptr UP BY delta` — wrapping pointer arithmetic.
    pub fn pointer_offset_by_idx(&mut self, ptr: FieldIdx, delta: i64) {
        self.mem
            .pointer_offset_by(&self.map, ptr.as_usize(), delta);
    }

    // ── USAGE BASED ────────────────────────────────────────────────────

    /// `ALLOCATE bytes CHARACTERS RETURNING BASED-idx` — attach a
    /// zero-initialised heap buffer of `bytes` length to field `idx`.
    pub fn allocate_based_idx(&mut self, idx: FieldIdx, bytes: usize) {
        self.mem.allocate_based(idx.as_usize(), bytes);
    }

    /// `FREE BASED-idx`. Idempotent on unallocated fields.
    pub fn free_based_idx(&mut self, idx: FieldIdx) {
        self.mem.free_based(idx.as_usize());
    }

    /// Read-only borrow of a BASED allocation.
    pub fn based_slice_idx(&self, idx: FieldIdx) -> Option<&[u8]> {
        self.mem.based_slice(idx.as_usize())
    }

    /// Mutable borrow of a BASED allocation.
    pub fn based_slice_mut_idx(&mut self, idx: FieldIdx) -> Option<&mut [u8]> {
        self.mem.based_slice_mut(idx.as_usize())
    }

    /// `true` if `idx` currently owns a BASED allocation.
    pub fn is_based_allocated_idx(&self, idx: FieldIdx) -> bool {
        self.mem.based_slice(idx.as_usize()).is_some()
    }

    // ── PIC L (DEPENDING ON) ───────────────────────────────────────────

    /// Explicitly set the logical length of an L-var field.
    pub fn lvar_set_len_idx(&mut self, idx: FieldIdx, n: usize) {
        self.mem.lvar_set_len(idx.as_usize(), n);
    }

    /// Live logical length of an L-var field (defaults to declared
    /// `max_len` when nothing has been written yet).
    pub fn lvar_len_idx(&self, idx: FieldIdx) -> usize {
        self.mem.lvar_len(&self.map, idx.as_usize())
    }

    /// Write raw bytes into an L-var field, recording the new logical
    /// length.
    pub fn write_lvar_alpha_idx(&mut self, idx: FieldIdx, src: &[u8]) {
        self.mem
            .write_lvar_alpha(&self.map, idx.as_usize(), src);
    }

    /// Read exactly `lvar_len_idx` bytes of an L-var field.
    pub fn read_lvar_alpha_idx(&self, idx: FieldIdx) -> Vec<u8> {
        self.mem.read_lvar_alpha(&self.map, idx.as_usize())
    }

    // ── Raw address for LINKAGE SECTION ─────────────────────────────────
    //
    // These helpers back the name-based `address_of` / `set_address_of`
    // family used by the compat adapter. They write and read the raw
    // address into/out of the 8-byte storage region at the field's
    // static offset without gating on `FieldKind`, so LINKAGE
    // alphanumeric fields can hold an address the same way a POINTER
    // field does.

    /// Write a raw byte offset into the 8 bytes starting at the field's
    /// declared `offset`. Does **not** inspect `FieldKind`. Mirrors
    /// the raw-offset arm of legacy `CobolRecord::set_address_of`.
    pub fn set_address_raw_idx(&mut self, idx: FieldIdx, raw_offset: usize) {
        let off = self.meta(idx).offset;
        self.mem.set_data(off, &(raw_offset as u64).to_le_bytes());
    }

    /// Read the raw address associated with `idx`.
    ///
    /// Resolution order:
    /// 1. For `Pointer` fields, consult the side table via
    ///    [`ironclad_central_buffer::IroncladMemory::get_pointer_target`].
    /// 2. Otherwise, decode the 8-byte LE image at the field's static
    ///    offset. An all-zero image means "never written" and we fall
    ///    back to the field's declared offset.
    pub fn address_raw_idx(&self, idx: FieldIdx) -> usize {
        let meta = self.meta(idx);
        if meta.kind == ironclad_central_buffer::FieldKind::Pointer {
            if let Some(t) = self.mem.get_pointer_target(&self.map, idx.as_usize()) {
                return t;
            }
            return meta.offset;
        }
        // Non-pointer fields: decode the raw 8-byte LE image.
        let bytes = self.mem.get_data(meta.offset, 8.min(meta.len));
        if bytes.len() == 8 {
            let mut buf = [0u8; 8];
            buf.copy_from_slice(bytes);
            let raw = u64::from_le_bytes(buf) as usize;
            if raw != 0 {
                return raw;
            }
        }
        meta.offset
    }

    /// 1-based "pointer value" form of [`Self::address_raw_idx`]. The
    /// COBOL `ADDRESS OF` comparator treats 0 as NULL, so we add 1 on
    /// the valid path. Mirrors legacy `CobolRecord::address_of_ptr`.
    pub fn address_raw_ptr_idx(&self, idx: FieldIdx) -> usize {
        let addr = self.address_raw_idx(idx);
        if addr == usize::MAX { 0 } else { addr + 1 }
    }

    /// Adjust the raw address of `idx` by `delta` bytes. Reads the
    /// current value via [`Self::address_raw_idx`] and writes back via
    /// [`Self::set_address_raw_idx`]. Mirrors legacy
    /// `CobolRecord::adjust_address_of`.
    pub fn adjust_address_raw_idx(&mut self, idx: FieldIdx, delta: i64) {
        let current = self.address_raw_idx(idx);
        let new_offset = (current as i64 + delta).max(0) as usize;
        self.set_address_raw_idx(idx, new_offset);
    }
}
