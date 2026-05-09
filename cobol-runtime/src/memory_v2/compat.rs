//! Name-based adapter for [`CobolRecordV2`].
//!
//! Every method here mirrors a same-named method on the legacy
//! `CobolRecord`: it resolves the COBOL field `name` to a
//! [`FieldIdx`] via
//! [`ironclad_central_buffer::OffsetMap::resolve_or_panic`] and then
//! delegates to the corresponding `*_idx` method.
//!
//! This adapter is what makes the Phase 6 alias flip
//! (`pub use memory_v2::CobolRecordV2 as CobolRecord;`) a one-line
//! change: once generated code is repointed at `CobolRecordV2`, all
//! name-based `record.get_display("X")` style calls compile
//! unchanged.
//!
//! # Correctness
//! * All lookups are case-insensitive (the `OffsetMap::name_to_idx`
//!   table stores upper-cased names).
//! * An unknown field name panics with Levenshtein-based "did you
//!   mean" suggestions. This is deliberate — it indicates a
//!   transpiler bug, which should fail loudly.

use ironclad_central_buffer::{FieldKind, InnerOdoCounter as CbInnerOdoCounter, OdoArray, OdoSlide};
use rust_decimal::Decimal as RDecimal;

use super::CobolRecordV2;
use crate::odo_slide::OdoDescriptor;

/// Convert the compat-layer (string-keyed) `InnerOdoCounter` tree into
/// the central-buffer (index-keyed) equivalent. Returns an empty `Vec`
/// for any counter whose field name is not in the map (defensive — the
/// transpiler should always emit consistent names).
fn convert_inner_counters(
    counters: &[crate::odo_slide::InnerOdoCounter],
    map: &ironclad_central_buffer::OffsetMap,
) -> Vec<CbInnerOdoCounter> {
    counters
        .iter()
        .filter_map(|c| {
            let counter_idx = map.resolve(&c.counter)?.as_usize();
            let inner = convert_inner_counters(&c.inner, map);
            Some(CbInnerOdoCounter {
                counter_idx,
                max_occurs: c.max_occurs,
                elem_size: c.elem_size,
                inner,
                offset_within_elem: c.offset_within_elem,
            })
        })
        .collect()
}

impl CobolRecordV2 {
    // ── Display / alphanumeric ───────────────────────────────────────────

    /// Return field `name` as a COBOL display string. Mirrors legacy
    /// `CobolRecord::get_display`.
    pub fn get_display(&self, name: &str) -> String {
        self.get_display_idx(self.map.resolve_or_panic(name))
    }

    /// Return field `name` as an unsigned digit-only display string.
    /// Mirrors legacy `CobolRecord::get_display_unsigned`.
    pub fn get_display_unsigned(&self, name: &str) -> String {
        self.get_display_unsigned_idx(self.map.resolve_or_panic(name))
    }

    /// Write raw bytes into field `name`. Mirrors legacy
    /// `CobolRecord::set_bytes`.
    pub fn set_bytes(&mut self, name: &str, data: &[u8]) {
        let idx = self.map.resolve_or_panic(name);
        self.set_bytes_idx(idx, data);
    }

    /// Zero-copy borrow of the raw bytes of field `name`. Mirrors
    /// legacy `CobolRecord::get_bytes`.
    pub fn get_bytes(&self, name: &str) -> &[u8] {
        self.get_bytes_idx(self.map.resolve_or_panic(name))
    }

    /// Write `data` into field `name`, zero-padding the remainder.
    /// Mirrors legacy `CobolRecord::set_bytes_null_padded`.
    pub fn set_bytes_null_padded(&mut self, name: &str, data: &[u8]) {
        let idx = self.map.resolve_or_panic(name);
        self.set_bytes_null_padded_idx(idx, data);
    }

    /// Restore raw bytes into field `name` without space-fill or
    /// type-conversion. Mirrors legacy
    /// `CobolRecord::restore_raw_bytes`.
    pub fn restore_raw_bytes(&mut self, name: &str, data: &[u8]) {
        let idx = self.map.resolve_or_panic(name);
        self.restore_raw_bytes_idx(idx, data);
    }

    /// 1-based reference-modification read. Mirrors legacy
    /// `CobolRecord::get_refmod`.
    pub fn get_refmod(&self, name: &str, start: usize, length: usize) -> String {
        let idx = self.map.resolve_or_panic(name);
        let bytes = self.get_refmod_idx(idx, start, length);
        String::from_utf8_lossy(bytes).into_owned()
    }

    /// 1-based reference-modification write. Mirrors legacy
    /// `CobolRecord::set_refmod`.
    pub fn set_refmod(&mut self, name: &str, start: usize, length: usize, data: &[u8]) {
        let idx = self.map.resolve_or_panic(name);
        self.set_refmod_idx(idx, start, length, data);
    }

    /// Fill field `name` with a single repeated byte. Mirrors legacy
    /// `CobolRecord::fill_field`.
    pub fn fill_field(&mut self, name: &str, byte: u8) {
        let idx = self.map.resolve_or_panic(name);
        self.fill_field_idx(idx, &[byte]);
    }

    /// Fill field `name` with a repeating byte pattern. Mirrors
    /// legacy `CobolRecord::fill_field_pattern`.
    pub fn fill_field_pattern(&mut self, name: &str, pattern: &[u8]) {
        let idx = self.map.resolve_or_panic(name);
        self.fill_field_idx(idx, pattern);
    }

    // ── Numeric ──────────────────────────────────────────────────────────

    /// Read field `name` as `i64`. Mirrors `CobolRecord::get_i64`.
    pub fn get_i64(&self, name: &str) -> i64 {
        self.get_i64_idx(self.map.resolve_or_panic(name))
    }

    /// Write `value` into field `name` as `i64`. Mirrors
    /// `CobolRecord::set_i64`.
    pub fn set_i64(&mut self, name: &str, value: i64) {
        let idx = self.map.resolve_or_panic(name);
        self.set_i64_idx(idx, value);
    }

    /// Read field `name` as `i128`. Mirrors `CobolRecord::get_i128`.
    pub fn get_i128(&self, name: &str) -> i128 {
        self.get_i128_idx(self.map.resolve_or_panic(name))
    }

    /// Write `value` into field `name` as `i128`. Mirrors
    /// `CobolRecord::set_i128`.
    pub fn set_i128(&mut self, name: &str, value: i128) {
        let idx = self.map.resolve_or_panic(name);
        self.set_i128_idx(idx, value);
    }

    /// Read field `name` as `f64`. Mirrors `CobolRecord::get_f64`.
    pub fn get_f64(&self, name: &str) -> f64 {
        self.get_f64_idx(self.map.resolve_or_panic(name))
    }

    /// Write `value` into field `name` as `f64`. Mirrors
    /// `CobolRecord::set_f64`.
    pub fn set_f64(&mut self, name: &str, value: f64) {
        let idx = self.map.resolve_or_panic(name);
        self.set_f64_idx(idx, value);
    }

    /// Rounded `COMPUTE` store (see
    /// [`CobolRecordV2::set_f64_rounded_idx`] for mode values).
    /// Mirrors `CobolRecord::set_f64_rounded`.
    pub fn set_f64_rounded(&mut self, name: &str, value: f64, mode: u8) {
        let idx = self.map.resolve_or_panic(name);
        self.set_f64_rounded_idx(idx, value, mode);
    }

    /// Read field `name` as [`rust_decimal::Decimal`]. Mirrors
    /// `CobolRecord::get_decimal`.
    pub fn get_decimal(&self, name: &str) -> RDecimal {
        self.get_decimal_idx(self.map.resolve_or_panic(name))
    }

    /// Write `val` into field `name`. Mirrors
    /// `CobolRecord::set_decimal`.
    pub fn set_decimal(&mut self, name: &str, val: RDecimal) {
        let idx = self.map.resolve_or_panic(name);
        self.set_decimal_idx(idx, val);
    }

    /// Parse `s` as a decimal literal and write into field `name`.
    /// Mirrors `CobolRecord::set_decimal_str`.
    pub fn set_decimal_str(&mut self, name: &str, s: &str) {
        let idx = self.map.resolve_or_panic(name);
        self.set_decimal_str_idx(idx, s);
    }

    // ── Structural ───────────────────────────────────────────────────────

    /// COBOL `MOVE src TO dst`. Mirrors `CobolRecord::cobol_move`.
    pub fn cobol_move(&mut self, src: &str, dst: &str) {
        let s = self.map.resolve_or_panic(src);
        let d = self.map.resolve_or_panic(dst);
        self.cobol_move_idx(s, d);
    }

    /// `INITIALIZE name`. Mirrors `CobolRecord::initialize`.
    pub fn initialize(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        self.initialize_idx(idx);
    }

    /// Logical length of field `name`. Mirrors
    /// `CobolRecord::length_of`.
    pub fn length_of(&self, name: &str) -> usize {
        self.length_of_idx(self.map.resolve_or_panic(name))
    }

    /// `FUNCTION LENGTH OF name`. Mirrors
    /// `CobolRecord::function_length_of`.
    pub fn function_length_of(&self, name: &str) -> usize {
        self.function_length_of_idx(self.map.resolve_or_panic(name))
    }

    /// Return `Some((offset, size))` for field `name`, or `None`.
    /// Mirrors `CobolRecord::resolve_field`.
    pub fn resolve_field(&self, name: &str) -> Option<(usize, usize)> {
        let idx = self.map.resolve(name)?;
        let meta = self.meta(idx);
        Some((meta.offset, meta.len))
    }

    /// Alias for [`Self::resolve_field`] — matches the V1 helper name
    /// used by shared runtime modules.
    pub fn field_offset_len(&self, name: &str) -> Option<(usize, usize)> {
        self.resolve_field(name)
    }

    /// Live logical size (in bytes) of the ODO array whose DEPENDING
    /// ON counter is `name`. Mirrors
    /// `CobolRecord::odo_adjusted_size`.
    pub fn odo_adjusted_size(&self, name: &str) -> usize {
        self.odo_live_size_idx(self.map.resolve_or_panic(name))
    }

    // ── ODO setup ────────────────────────────────────────────────────────

    /// Convert a set of legacy [`OdoDescriptor`] values into central-
    /// buffer [`OdoArray`] / [`OdoSlide`] entries and splice them into
    /// `self.map`.
    ///
    /// For each descriptor the adapter:
    /// 1. Resolves `counter_field` to a `FieldIdx` via
    ///    [`ironclad_central_buffer::OffsetMap::resolve`]; descriptors
    ///    whose counter field is absent are skipped (the legacy
    ///    runtime has the same defensive behaviour).
    /// 2. Appends a new [`OdoArray`] to `self.map.odo_arrays`.
    /// 3. If `creates_slides` is set, adds an [`OdoSlide`] entry for
    ///    every field whose static offset starts **at or after** the
    ///    end of the max-sized ODO region (those are the fields that
    ///    slide back when the array compresses).
    pub fn apply_odo(&mut self, descriptors: &[OdoDescriptor]) {
        for d in descriptors {
            let counter_idx = match self.map.resolve(&d.counter_field) {
                Some(idx) => idx.as_usize(),
                None => continue,
            };
            let inner = convert_inner_counters(&d.inner_counters, &self.map);
            let odo_idx = self.map.odo_arrays.len();
            self.map.odo_arrays.push(OdoArray {
                base_offset: d.odo_offset_rel,
                elem_stride: d.element_size,
                max_occurs: d.max_occurs,
                counter_idx,
                inner,
            });
            if d.creates_slides {
                let odo_end = d.odo_offset_rel + d.odo_size_max;
                // Snapshot offsets first to avoid borrowing `entries`
                // while pushing into `odo_slides`.
                let sliders: Vec<(usize, usize)> = self
                    .map
                    .entries
                    .iter()
                    .enumerate()
                    .filter_map(|(i, e)| {
                        if e.meta.offset >= odo_end { Some((i, e.meta.offset)) } else { None }
                    })
                    .collect();
                for (field_idx, static_tail_offset) in sliders {
                    self.map.odo_slides.push(OdoSlide {
                        field_idx,
                        anchor_odo: odo_idx,
                        static_tail_offset,
                    });
                }
            }
        }
    }

    /// Register a group's leaf child relationship.
    ///
    /// The central-buffer [`OffsetMap`] already stores absolute
    /// offsets for every field — including every leaf child of every
    /// group — at construction time. The runtime has no parallel
    /// dynamic lookup to populate, so this method is intentionally a
    /// no-op. It exists solely so generated code calling
    /// `record.register_leaf_child(...)` compiles unchanged. Mirrors
    /// `CobolRecord::register_leaf_child`.
    #[inline(always)]
    pub fn register_leaf_child(
        &mut self,
        _child_name: &str,
        _parent_name: &str,
        _offset_in_parent: usize,
        _size: usize,
    ) {
        // Intentional no-op: offsets are pre-computed in `OffsetMap`.
    }

    /// Register a PIC L (DEPENDING ON) field and its length-counter
    /// field. Primes the logical length to `max_len` so that reads
    /// before any write return the declared capacity — matching the
    /// legacy `IroncladMemory::lvar_len` fallback. Mirrors
    /// `CobolRecord::register_lvar`.
    pub fn register_lvar(&mut self, lvar_name: &str, _len_field: &str, max_len: usize) {
        if let Some(idx) = self.map.resolve(lvar_name) {
            self.lvar_set_len_idx(idx, max_len);
        }
    }

    // ── Pointer / ADDRESS OF ─────────────────────────────────────────────

    /// `SET ADDRESS OF name TO raw_offset`. Mirrors
    /// `CobolRecord::set_address_of`.
    pub fn set_address_of(&mut self, name: &str, raw_offset: usize) {
        let idx = self.map.resolve_or_panic(name);
        self.set_address_raw_idx(idx, raw_offset);
    }

    /// Adjust the address of `name` by `delta` bytes. Mirrors
    /// `CobolRecord::adjust_address_of`.
    pub fn adjust_address_of(&mut self, name: &str, delta: i64) {
        let idx = self.map.resolve_or_panic(name);
        self.adjust_address_raw_idx(idx, delta);
    }

    /// Current raw byte address of field `name`. Mirrors
    /// `CobolRecord::address_of`.
    pub fn address_of(&self, name: &str) -> usize {
        self.address_raw_idx(self.map.resolve_or_panic(name))
    }

    /// 1-based pointer-form address of field `name` (0 = NULL).
    /// Mirrors `CobolRecord::address_of_ptr`.
    pub fn address_of_ptr(&self, name: &str) -> usize {
        self.address_raw_ptr_idx(self.map.resolve_or_panic(name))
    }

    /// `SET name TO NULL`. Delegates to the pointer-null helper for
    /// `Pointer` fields and writes the `usize::MAX` sentinel into the
    /// raw-address slot for everything else. Mirrors
    /// `CobolRecord::set_pointer_null`.
    pub fn set_pointer_null(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        match self.meta(idx).kind {
            FieldKind::Pointer => self.set_pointer_null_idx(idx),
            _ => self.set_address_raw_idx(idx, usize::MAX),
        }
    }

    /// `true` iff field `name` currently owns a BASED allocation.
    /// Mirrors `CobolRecord::is_based_allocated`.
    pub fn is_based_allocated(&self, name: &str) -> bool {
        self.is_based_allocated_idx(self.map.resolve_or_panic(name))
    }

    /// Returns `true` if a field named `name` is registered in the
    /// underlying [`ironclad_central_buffer::OffsetMap`]. Used by
    /// EXTFH to probe for the optional FCD sub-fields produced by
    /// `copy xfhfcd3.`.
    pub fn has_field(&self, name: &str) -> bool {
        self.map.resolve(name).is_some()
    }

    /// Read raw bytes from the central buffer at a given byte offset.
    /// Used by EXTFH to dereference filename/record address pointers.
    pub fn get_bytes_raw_offset(&self, offset: usize, len: usize) -> &[u8] {
        self.mem.get_data(offset, len)
    }

    /// Write raw bytes to the central buffer at a given byte offset.
    pub fn set_bytes_raw_offset(&mut self, offset: usize, data: &[u8]) {
        self.mem.set_data(offset, data);
    }

    // ── V7 Phase 1b port: legacy CobolRecord compat ──────────────────────
    //
    // These methods mirror the legacy `field::CobolRecord` API, resolving
    // the COBOL name through `OffsetMap::resolve_or_panic` and then using
    // either an existing `*_idx` method or raw `IroncladMemory`
    // (`set_data`/`get_data`) access. They are required for the
    // Phase 1 backend flip — generated code calls them by name and the
    // alias `cobol_runtime::CobolRecord = CobolRecordV2` must not lose
    // any hot-path surface.

    /// `INITIALIZE field` (per-kind defaults). Mirrors legacy
    /// `CobolRecord::initialize_field`. For leaf fields this is
    /// equivalent to [`Self::initialize`] / [`Self::initialize_idx`];
    /// group handling lives in generated code as a sequence of leaf
    /// initializations (the transpiler lowers `INITIALIZE group` to
    /// per-child calls).
    pub fn initialize_field(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        self.initialize_idx(idx);
    }

    /// `INITIALIZE field` using full physical size regardless of any
    /// L-var logical length. Mirrors legacy
    /// `CobolRecord::initialize_field_physical`.
    pub fn initialize_field_physical(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        self.initialize_physical_idx(idx);
    }

    /// `IS NUMERIC` check against raw bytes. Mirrors legacy
    /// `CobolRecord::is_field_numeric`.
    pub fn is_field_numeric(&self, name: &str) -> bool {
        let idx = self.map.resolve_or_panic(name);
        self.is_numeric_idx(idx)
    }

    /// Allocate a BASED item's storage (reuses the field's declared
    /// length). Mirrors legacy `CobolRecord::allocate_based`.
    pub fn allocate_based(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        let bytes = self.meta(idx).len;
        self.allocate_based_idx(idx, bytes);
    }

    /// Mark a BASED item as freed (NULL address). Mirrors legacy
    /// `CobolRecord::free_based`.
    pub fn free_based(&mut self, name: &str) {
        let idx = self.map.resolve_or_panic(name);
        self.free_based_idx(idx);
    }

    /// Get the raw declared-size byte image of a field as a `Vec<u8>`.
    /// Mirrors legacy `CobolRecord::get_raw_bytes`.
    ///
    /// Unknown fields return an empty vec (legacy parity — the legacy
    /// impl uses `if let Some(fd) = self.get_field(name)`).
    pub fn get_raw_bytes(&self, name: &str) -> Vec<u8> {
        match self.map.resolve(name) {
            Some(idx) => {
                let m = self.meta(idx);
                self.mem.get_data(m.offset, m.len).to_vec()
            }
            None => Vec::new(),
        }
    }

    /// Set raw bytes into a field: space-fill the whole slot first,
    /// then overlay `min(value.len, field.len)` bytes. Mirrors legacy
    /// `CobolRecord::set_raw_bytes`.
    pub fn set_raw_bytes(&mut self, name: &str, value: &[u8]) {
        let idx = match self.map.resolve(name) {
            Some(i) => i,
            None => return,
        };
        let m = self.meta(idx).clone();
        // Space-fill the full slot first.
        let blanks = vec![b' '; m.len];
        self.mem.set_data(m.offset, &blanks);
        // Overlay the supplied bytes.
        let copy_len = value.len().min(m.len);
        if copy_len > 0 {
            self.mem.set_data(m.offset, &value[..copy_len]);
        }
    }

    /// Get the raw declared-size bytes of a field as a lossy UTF-8
    /// string. Mirrors legacy `CobolRecord::get_raw_string`.
    pub fn get_raw_string(&self, name: &str) -> String {
        match self.map.resolve(name) {
            Some(idx) => {
                let m = self.meta(idx);
                String::from_utf8_lossy(self.mem.get_data(m.offset, m.len))
                    .into_owned()
            }
            None => String::new(),
        }
    }

    /// Set raw bytes from a string — direct byte copy with NO
    /// space-fill (preserves overpunch for EXAMINE/INSPECT writeback).
    /// Mirrors legacy `CobolRecord::set_raw_string`.
    pub fn set_raw_string(&mut self, name: &str, value: &str) {
        let idx = match self.map.resolve(name) {
            Some(i) => i,
            None => return,
        };
        let m = self.meta(idx).clone();
        let vb = value.as_bytes();
        let copy_len = vb.len().min(m.len);
        if copy_len > 0 {
            self.mem.set_data(m.offset, &vb[..copy_len]);
        }
    }

    /// Fill a field with a repeating pattern. Empty pattern
    /// space-fills. Mirrors legacy `CobolRecord::fill_bytes`.
    pub fn fill_bytes(&mut self, name: &str, pattern: &[u8]) {
        if pattern.is_empty() {
            self.fill_field(name, b' ');
        } else {
            self.fill_field_pattern(name, pattern);
        }
    }

    /// CONTENT-LENGTH at a 1-based pointer offset into the central
    /// buffer: scan forward from `offset` until a NUL byte, return
    /// the run length. `offset == 0` is the NULL pointer and returns
    /// 0. Mirrors legacy `CobolRecord::content_length_at_offset`.
    pub fn content_length_at_offset(&self, offset: usize) -> usize {
        if offset == 0 { return 0; }
        let start = offset - 1;
        let storage = self.mem.storage_slice();
        if start >= storage.len() { return 0; }
        for i in start..storage.len() {
            if storage[i] == 0 {
                return i - start;
            }
        }
        storage.len() - start
    }

    /// CONTENT-OF at a 1-based pointer offset: extract bytes starting
    /// at `offset`, stopping at NUL (or after `max_len` if supplied).
    /// `offset == 0` is the NULL pointer and returns an empty string.
    /// Mirrors legacy `CobolRecord::content_of_at_offset`.
    pub fn content_of_at_offset(&self, offset: usize, max_len: Option<usize>) -> String {
        if offset == 0 { return String::new(); }
        let start = offset - 1;
        let storage = self.mem.storage_slice();
        if start >= storage.len() { return String::new(); }
        let end = match max_len {
            Some(len) => (start + len).min(storage.len()),
            None => {
                let mut e = start;
                while e < storage.len() && storage[e] != 0 {
                    e += 1;
                }
                e
            }
        };
        String::from_utf8_lossy(&storage[start..end]).into_owned()
    }

    /// Compare two same-type numeric-display fields byte-by-byte
    /// (GnuCOBOL memcmp semantics: space-filled fields compare less
    /// than zero-filled fields). Falls back to numeric `f64` compare
    /// for mismatched kinds/sizes/scales. Mirrors legacy
    /// `CobolRecord::cmp_same_numeric_display`.
    pub fn cmp_same_numeric_display(&self, a_name: &str, b_name: &str) -> i64 {
        let ai = match self.map.resolve(a_name) { Some(i) => i, None => return 0 };
        let bi = match self.map.resolve(b_name) { Some(i) => i, None => return 0 };
        let am = self.meta(ai);
        let bm = self.meta(bi);
        // Same numeric-display kind (both NumericDisplay{scale}, or
        // both SignedDisplay{scale}) AND same length → raw memcmp.
        let same_display_kind = match (am.kind, bm.kind) {
            (FieldKind::NumericDisplay { scale: sa }, FieldKind::NumericDisplay { scale: sb }) => sa == sb,
            (FieldKind::SignedDisplay   { scale: sa, leading: la }, FieldKind::SignedDisplay   { scale: sb, leading: lb }) => sa == sb && la == lb,
            (FieldKind::SignSeparate    { scale: sa, leading: la }, FieldKind::SignSeparate    { scale: sb, leading: lb }) => sa == sb && la == lb,
            _ => false,
        };
        if same_display_kind && am.len == bm.len {
            let a_bytes = self.mem.get_data(am.offset, am.len);
            let b_bytes = self.mem.get_data(bm.offset, bm.len);
            return match a_bytes.cmp(b_bytes) {
                std::cmp::Ordering::Less    => -1,
                std::cmp::Ordering::Equal   =>  0,
                std::cmp::Ordering::Greater =>  1,
            };
        }
        // Fall back to numeric compare.
        let av = self.get_f64_idx(ai);
        let bv = self.get_f64_idx(bi);
        if av < bv { -1 } else if av > bv { 1 } else { 0 }
    }

    // ── Field descriptor shim ─────────────────────────────────────────────
    //
    // Generated code reads `.size` and `.offset` from the legacy
    // `FieldDescriptor` returned by `get_field(name).map(...)`. V2's
    // `FieldMeta` uses `.len` (not `.size`) so we return a shim type
    // with the legacy field names. This keeps 71 generated call sites
    // compiling without a codegen change. Shim is deleted in Phase 1d
    // when codegen is flipped to the `_idx` API.

    /// Legacy-compatible field descriptor view with the two fields
    /// (`.size`, `.offset`) that generated code actually reads.
    pub fn get_field(&self, name: &str) -> Option<FieldDescriptorShim> {
        self.map.resolve(name).map(|idx| {
            let m = self.meta(idx);
            FieldDescriptorShim { size: m.len, offset: m.offset }
        })
    }

    // ── CBL_*/C$* system routine helpers ──────────────────────────────────
    //
    // These are byte-level bitwise / case / justify operations. All
    // use the read-modify-write pattern over `IroncladMemory::get_data`
    // / `set_data`. The allocation overhead is fine — these methods
    // are cold-path (≤ 35 call sites each across the parity corpus).

    /// CBL_OR: `dst[i] |= src[i]` for `len` bytes.
    pub fn cbl_or(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| d | s);
    }
    /// CBL_AND: `dst[i] &= src[i]` for `len` bytes.
    pub fn cbl_and(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| d & s);
    }
    /// CBL_XOR: `dst[i] ^= src[i]` for `len` bytes.
    pub fn cbl_xor(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| d ^ s);
    }
    /// CBL_NOR: `dst[i] = !(dst[i] | src[i])` for `len` bytes.
    pub fn cbl_nor(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| !(d | s));
    }
    /// CBL_NIMP: `dst[i] = src[i] & !dst[i]` for `len` bytes.
    pub fn cbl_nimp(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| s & !d);
    }
    /// CBL_IMP (material implication): `dst[i] = !src[i] | dst[i]` for `len` bytes.
    pub fn cbl_imp(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| !s | d);
    }
    /// CBL_EQ: `dst[i] = !(dst[i] ^ src[i])` for `len` bytes.
    pub fn cbl_eq(&mut self, src: &str, dst: &str, len: usize) {
        self.cbl_binop(src, dst, len, |d, s| !(d ^ s));
    }
    /// CBL_NOT: `dst[i] = !dst[i]` for `len` bytes (in-place).
    pub fn cbl_not(&mut self, dst: &str, len: usize) {
        let di = match self.map.resolve(dst) { Some(i) => i, None => return };
        let dm = self.meta(di).clone();
        let n = len.min(dm.len);
        if n == 0 { return; }
        let mut buf = self.mem.get_data(dm.offset, n).to_vec();
        for b in buf.iter_mut() { *b = !*b; }
        self.mem.set_data(dm.offset, &buf);
    }

    /// Shared implementation for the two-operand CBL_* bitwise ops.
    #[inline]
    fn cbl_binop<F: Fn(u8, u8) -> u8>(&mut self, src: &str, dst: &str, len: usize, op: F) {
        let si = match self.map.resolve(src) { Some(i) => i, None => return };
        let di = match self.map.resolve(dst) { Some(i) => i, None => return };
        let sm = self.meta(si).clone();
        let dm = self.meta(di).clone();
        let n = len.min(sm.len).min(dm.len);
        if n == 0 { return; }
        let src_bytes = self.mem.get_data(sm.offset, n).to_vec();
        let mut dst_bytes = self.mem.get_data(dm.offset, n).to_vec();
        for i in 0..n {
            dst_bytes[i] = op(dst_bytes[i], src_bytes[i]);
        }
        self.mem.set_data(dm.offset, &dst_bytes);
    }

    /// C$TOUPPER: uppercase `len` bytes in-place.
    pub fn c_toupper(&mut self, field: &str, len: usize) {
        let fi = match self.map.resolve(field) { Some(i) => i, None => return };
        let fm = self.meta(fi).clone();
        let n = len.min(fm.len);
        if n == 0 { return; }
        let mut buf = self.mem.get_data(fm.offset, n).to_vec();
        for b in buf.iter_mut() {
            if *b >= b'a' && *b <= b'z' { *b -= 32; }
        }
        self.mem.set_data(fm.offset, &buf);
    }

    /// C$TOLOWER: lowercase `len` bytes in-place.
    pub fn c_tolower(&mut self, field: &str, len: usize) {
        let fi = match self.map.resolve(field) { Some(i) => i, None => return };
        let fm = self.meta(fi).clone();
        let n = len.min(fm.len);
        if n == 0 { return; }
        let mut buf = self.mem.get_data(fm.offset, n).to_vec();
        for b in buf.iter_mut() {
            if *b >= b'A' && *b <= b'Z' { *b += 32; }
        }
        self.mem.set_data(fm.offset, &buf);
    }

    /// C$JUSTIFY: "L" = left-justify, else right-justify (default). Pads with spaces.
    pub fn c_justify(&mut self, field: &str, direction: &str) {
        let fi = match self.map.resolve(field) { Some(i) => i, None => return };
        let fm = self.meta(fi).clone();
        if fm.len == 0 { return; }
        let bytes = self.mem.get_data(fm.offset, fm.len).to_vec();
        let s = String::from_utf8_lossy(&bytes);
        let trimmed = s.trim();
        let justified = if direction.eq_ignore_ascii_case("L") {
            format!("{:<width$}", trimmed, width = fm.len)
        } else {
            format!("{:>width$}", trimmed, width = fm.len)
        };
        let jbytes = justified.as_bytes();
        let n = jbytes.len().min(fm.len);
        self.mem.set_data(fm.offset, &jbytes[..n]);
    }

    /// C$PRINTABLE: replace non-printable bytes with `'.'`.
    pub fn c_printable(&mut self, field: &str) {
        let fi = match self.map.resolve(field) { Some(i) => i, None => return };
        let fm = self.meta(fi).clone();
        if fm.len == 0 { return; }
        let mut buf = self.mem.get_data(fm.offset, fm.len).to_vec();
        for b in buf.iter_mut() {
            if *b < 0x20 || *b > 0x7E { *b = b'.'; }
        }
        self.mem.set_data(fm.offset, &buf);
    }

    // ── Table sort (raw offset API) ───────────────────────────────────────

    /// Sort `count` elements of `element_size` bytes each, starting at
    /// absolute byte `table_offset` in the central buffer, by the
    /// supplied `(key_offset_within_element, key_size, ascending)` keys.
    /// Uses ASCII byte order. Mirrors legacy `CobolRecord::sort_table`.
    pub fn sort_table(
        &mut self,
        table_offset: usize,
        element_size: usize,
        count: usize,
        keys: &[(usize, usize, bool)],
    ) {
        self.sort_table_collation(table_offset, element_size, count, keys, false);
    }

    /// As [`Self::sort_table`] but compares keys in EBCDIC collation.
    /// Mirrors legacy `CobolRecord::sort_table_ebcdic`.
    pub fn sort_table_ebcdic(
        &mut self,
        table_offset: usize,
        element_size: usize,
        count: usize,
        keys: &[(usize, usize, bool)],
    ) {
        self.sort_table_collation(table_offset, element_size, count, keys, true);
    }

    fn sort_table_collation(
        &mut self,
        table_offset: usize,
        element_size: usize,
        count: usize,
        keys: &[(usize, usize, bool)],
        ebcdic: bool,
    ) {
        if count <= 1 || element_size == 0 { return; }
        // Snapshot the table so we can index freely without borrowing
        // self.mem during the sort comparator.
        let total = count * element_size;
        let snapshot = self.mem.get_data(table_offset, total).to_vec();
        let mut indices: Vec<usize> = (0..count).collect();
        indices.sort_by(|&a, &b| {
            for &(key_off, key_sz, ascending) in keys {
                let sa = a * element_size + key_off;
                let sb = b * element_size + key_off;
                let ka = &snapshot[sa..sa + key_sz];
                let kb = &snapshot[sb..sb + key_sz];
                let cmp = if ebcdic {
                    use crate::ebcdic::A2E;
                    ka.iter().zip(kb.iter())
                        .map(|(&x, &y)| A2E[x as usize].cmp(&A2E[y as usize]))
                        .find(|&c| c != std::cmp::Ordering::Equal)
                        .unwrap_or(std::cmp::Ordering::Equal)
                } else {
                    ka.cmp(kb)
                };
                if cmp != std::cmp::Ordering::Equal {
                    return if ascending { cmp } else { cmp.reverse() };
                }
            }
            std::cmp::Ordering::Equal
        });
        let mut rearranged = vec![0u8; total];
        for (new_idx, &old_idx) in indices.iter().enumerate() {
            let src = old_idx * element_size;
            let dst = new_idx * element_size;
            rearranged[dst..dst + element_size]
                .copy_from_slice(&snapshot[src..src + element_size]);
        }
        self.mem.set_data(table_offset, &rearranged);
    }

    // ── INSPECT CONVERTING family ─────────────────────────────────────────
    //
    // *** Phase 1b limitation — overpunch sign recovery is NOT yet
    //     wired through V2. ***
    //
    // The legacy `inspect_*` methods inspect `FieldDescriptor::is_signed`
    // / `sign_separate` / `sign_leading` to decode/re-encode GnuCOBOL
    // overpunch sign bytes (`J..R` / `p..y` / `{` / `}`) around the
    // conversion. `FieldMeta::kind = SignedDisplay { scale }` in the
    // central buffer does not yet carry those flags, so V2 ports here
    // operate on raw bytes without sign recovery. Known impact:
    //   * INSPECT CONVERTING on a SignedDisplay field whose last byte
    //     is an overpunch glyph may corrupt the sign.
    // Phase 1c task: extend `FieldMeta` (or add a side-table in
    // `OffsetMap`) with `sign_separate` / `sign_leading` so these
    // methods can apply the same decode → convert → re-encode flow as
    // legacy. Until then, `inspect_strip_sign` returns `None`
    // (safe: callers skip sign handling) and `inspect_restore_sign`
    // is a no-op.

    /// INSPECT … CONVERTING from TO. Mirrors legacy
    /// `CobolRecord::inspect_converting`. See module note re:
    /// overpunch sign recovery.
    pub fn inspect_converting(&mut self, name: &str, from: &str, to: &str) {
        self.inspect_converting_ba(name, from, to, None, None);
    }

    /// INSPECT … CONVERTING with optional BEFORE / AFTER INITIAL.
    pub fn inspect_converting_ba(
        &mut self,
        name: &str,
        from: &str,
        to: &str,
        before: Option<&str>,
        after: Option<&str>,
    ) {
        let idx = match self.map.resolve(name) { Some(i) => i, None => return };
        let m = self.meta(idx).clone();
        if m.len == 0 { return; }
        let mut buf = self.mem.get_data(m.offset, m.len).to_vec();
        crate::string_ops::inspect_converting(
            &mut buf,
            from.as_bytes(),
            to.as_bytes(),
            before.map(|s| s.as_bytes()),
            after.map(|s| s.as_bytes()),
        );
        self.mem.set_data(m.offset, &buf);
    }

    /// INSPECT … CONVERTING using named ALPHABET tables.
    pub fn inspect_converting_alphabet(
        &mut self,
        name: &str,
        from_alphabet: &str,
        to_alphabet: &str,
    ) {
        self.inspect_converting_alphabet_ba(name, from_alphabet, to_alphabet, None, None);
    }

    /// INSPECT … CONVERTING with ALPHABETs and optional BEFORE/AFTER.
    pub fn inspect_converting_alphabet_ba(
        &mut self,
        name: &str,
        from_alphabet: &str,
        to_alphabet: &str,
        before: Option<&str>,
        after: Option<&str>,
    ) {
        let idx = match self.map.resolve(name) { Some(i) => i, None => return };
        let m = self.meta(idx).clone();
        if m.len == 0 { return; }
        let mut buf = self.mem.get_data(m.offset, m.len).to_vec();
        crate::string_ops::inspect_converting_alphabet(
            &mut buf,
            from_alphabet,
            to_alphabet,
            before.map(|s| s.as_bytes()),
            after.map(|s| s.as_bytes()),
        );
        self.mem.set_data(m.offset, &buf);
    }

    /// Strip overpunch sign prior to INSPECT — **V2 fallback returns
    /// `None`** (see module note). Callers treat `None` as "no sign
    /// handling needed" which is safe for non-overpunch fields.
    pub fn inspect_strip_sign(&mut self, _name: &str) -> Option<(usize, bool)> {
        None
    }

    /// Restore overpunch sign after INSPECT — **V2 fallback is a
    /// no-op** (see module note).
    pub fn inspect_restore_sign(&mut self, _name: &str, _sign_pos: usize, _negative: bool) {
        // No-op until Phase 1c extends FieldMeta with sign flags.
    }

    /// Get display image used by INSPECT. V2 falls back to
    /// `get_display` — the overpunch-preserving path is a Phase 1c
    /// follow-up.
    pub fn get_inspect_display(&self, name: &str) -> String {
        self.get_display(name)
    }

    /// Write raw bytes from an INSPECT result. V2 falls back to
    /// `set_bytes` — overpunch re-encoding is a Phase 1c follow-up.
    pub fn set_inspect_bytes(&mut self, name: &str, value: &[u8]) {
        self.set_bytes(name, value);
    }

    // ── Phase 1c: codegen-facing helpers to remove direct struct-field access ──

    /// Fill `[field.offset + start_1based - 1 .. +len]` with `byte`, clamped to
    /// field end.  Backs `INITIALIZE fld(s:l)` refmod codegen without touching
    /// `record.data` directly.  Silently no-ops for unknown / zero-len fields.
    pub fn fill_bytes_range(&mut self, name: &str, start_1based: usize, len: usize, byte: u8) {
        let idx = match self.map.resolve(name) { Some(i) => i, None => return };
        if start_1based == 0 || len == 0 { return; }
        let m = self.meta(idx).clone();
        let base = m.offset + start_1based - 1;
        let end = (base + len).min(m.offset + m.len);
        if end <= base { return; }
        let filler: Vec<u8> = vec![byte; end - base];
        self.mem.set_data(base, &filler);
    }

    /// Append `bytes` + NUL to a scratch region, return 1-based pointer to the
    /// start of `bytes` (0 = failure / not-supported).  Used by COB_GETENV
    /// emit.  V2 has a fixed-size central buffer so it can't grow the
    /// allocation — returns 0 for now, which COB_GETENV surface semantics
    /// treat as "env var not found".  A scratch-region extension is tracked
    /// for Phase 2+.
    pub fn append_scratch_nul(&mut self, _bytes: &[u8]) -> usize {
        0
    }
}

/// Legacy field-descriptor compatibility shim. Returned by
/// [`CobolRecordV2::get_field`] so that generated code's
/// `record.get_field(name).map_or(0, |f| f.size)` pattern compiles
/// unchanged. Deleted in Phase 1d when codegen emits `_idx` calls.
#[derive(Debug, Clone, Copy)]
pub struct FieldDescriptorShim {
    pub size:   usize,
    pub offset: usize,
}
