//! OCCURS DEPENDING ON pass-through wrappers.
//!
//! The central buffer already owns the full ODO resolution machinery
//! (see `ironclad_central_buffer::odo`). The v2 facade just adds
//! `FieldIdx` typing and borrows `self.map` internally.

use ironclad_central_buffer::{FieldIdx, OdoArray};

use super::CobolRecordV2;

impl CobolRecordV2 {
    /// Live byte offset of `idx`, folding in every `OdoSlide` that
    /// applies to it. For non-sliding fields this is just the static
    /// `meta.offset`.
    pub fn resolve_offset_idx(&self, idx: FieldIdx) -> usize {
        self.mem.resolve_offset(&self.map, idx.as_usize())
    }

    /// Live logical length (in bytes) of a named ODO array. Takes
    /// the raw index into [`ironclad_central_buffer::OffsetMap::odo_arrays`]
    /// — the transpiler emits one `const ODO_<NAME>: usize = N;`
    /// per array in Phase 5.
    pub fn odo_live_bytes(&self, odo_array_index: usize) -> usize {
        let odo: &OdoArray = &self.map().odo_arrays[odo_array_index];
        self.mem.odo_live_bytes(self.map(), odo)
    }

    /// Live size of the ODO array whose first element sits at field
    /// `idx`. Falls back to the static declared length if no ODO is
    /// registered at that offset.
    pub fn odo_live_size_idx(&self, idx: FieldIdx) -> usize {
        self.mem.odo_live_size(&self.map, idx.as_usize())
    }

    /// Live counter value of the DEPENDING ON counter for
    /// `odo_array_index`. Thin convenience wrapper — the counter is
    /// just a regular numeric field accessible via
    /// [`Self::get_i128_idx`], but this spelling makes ODO-aware
    /// generated code more obvious.
    pub fn odo_counter(&self, odo_array_index: usize) -> i128 {
        let odo = &self.map().odo_arrays[odo_array_index];
        let counter_meta = &self.map().entries[odo.counter_idx].meta;
        self.mem.read_numeric_i128(counter_meta)
    }
}
