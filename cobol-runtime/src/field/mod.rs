// field.rs — Unified field descriptor and record storage for Lazarus v2
//
// Every COBOL field gets described by ONE struct at transpile time.
// The runtime operates on flat byte arrays using these descriptors.

use std::collections::HashMap;

// Re-export from split submodules so `use cobol_runtime::field::*;` still works
pub use crate::field_ops::*;
pub use crate::field_system::*;

mod record_access;
mod record_ops;

// ── Field Descriptor ─────────────────────────────────────────────────

#[derive(Clone, Debug)]
pub struct FieldDescriptor {
    pub name: String,
    pub offset: usize,        // byte offset within record
    pub size: usize,           // total byte size
    pub field_type: FieldType,
    pub pic_scale: u8,         // decimal places (V99 = 2)
    pub pic_digits: u8,        // total digit positions
    pub is_signed: bool,
    pub justified_right: bool,
    pub blank_when_zero: bool,
    pub p_factor: i8,          // PIC P scaling: >0 = leading P (P99→fractional), <0 = trailing P (9PP→multiply)
    pub sign_leading: bool,    // SIGN IS LEADING — sign in first byte (vs trailing default)
    pub sign_separate: bool,   // SIGN IS ... SEPARATE CHARACTER — sign is a separate +/- byte
    pub is_pointer: bool,      // USAGE POINTER — display as 0xNNNNNNNN hex format
    pub pic_clause_digits: u8,  // Original PIC clause digit count (before COMP-5 capacity expansion)
                                // 0 = same as pic_digits (non-COMP-5 fields)
}

#[derive(Clone, Debug, PartialEq)]
pub enum FieldType {
    // Alphanumeric — array of chars, space-padded
    AlphaNumeric,              // PIC X(n) -> [u8; size], padded with 0x20

    // Display numeric — array of ASCII digit chars
    NumericDisplay,            // PIC 9(n) -> [u8; size], each byte is b'0'..b'9'
    SignedDisplay,             // PIC S9(n) -> same + sign in last byte or separate

    // Binary/COMP — native integers
    Binary8,                   // COMP-X PIC X -> u8  (1-byte unsigned binary)
    Binary16,                  // COMP PIC 9(1-4) -> i16
    Binary32,                  // COMP PIC 9(5-9) -> i32
    Binary64,                  // COMP PIC 9(10-18) -> i64

    // Packed decimal — BCD array
    Packed,                    // COMP-3 -> [u8; (digits+2)/2], two digits per byte

    // Unsigned packed decimal — BCD array with NO sign nibble
    Comp6,                     // COMP-6 -> [u8; ceil(digits/2)], two digits per byte, no sign

    // Floating point
    Float32,                   // COMP-1 -> f32
    Float64,                   // COMP-2 -> f64
    FloatDecimal16,            // FLOAT-DECIMAL-16 -> stored as String in 34 bytes, 16 sig digits
    FloatDecimal34,            // FLOAT-DECIMAL-34 -> stored as String in 50 bytes, 34 sig digits via DBig

    // Edited — format template + digit array
    EditedNumeric(String),     // PIC pattern string e.g. "$$,$$9.99"
    EditedAlpha(String),       // PIC pattern string e.g. "XX/XX/XX"

    // Group — no data of its own, just children
    Group,
}

impl FieldDescriptor {
    /// HIGHEST-ALGEBRAIC: return the maximum value this field can hold as a string.
    pub fn highest_algebraic(&self) -> String {
        match &self.field_type {
            FieldType::Float32 => return format!("{}", f32::MAX),
            FieldType::Float64 => return format!("{}", f64::MAX),
            FieldType::FloatDecimal16 => return format!("{}", f64::MAX),
            FieldType::FloatDecimal34 => return format!("{}", f64::MAX),
            FieldType::EditedNumeric(pat) => {
                // Count digit positions (9, Z, *, $) and decimal places from pattern
                let (int_nines, dec_nines) = Self::count_edit_digit_positions(pat);
                let total = int_nines + dec_nines;
                if total == 0 { return "0".into(); }
                let max_val = 10u128.pow(total as u32) - 1;
                if dec_nines > 0 {
                    let div = 10u128.pow(dec_nines as u32);
                    format!("{}.{:0>width$}", max_val / div, max_val % div, width = dec_nines)
                } else {
                    max_val.to_string()
                }
            }
            FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 => {
                // Binary fields: max is constrained by byte size, not pic_digits
                let pic_max = if self.pic_digits > 0 { 10u128.pow(self.pic_digits as u32) - 1 } else { u128::MAX };
                let bin_max: u128 = match self.size {
                    1 => if self.is_signed { 127 } else { 255 },
                    2 => if self.is_signed { 32767 } else { 65535 },
                    4 => if self.is_signed { 2147483647 } else { 4294967295 },
                    8 => if self.is_signed { 9223372036854775807 } else { u64::MAX as u128 },
                    _ => pic_max,
                };
                let max_val = pic_max.min(bin_max);
                if self.pic_scale > 0 {
                    let div = 10u128.pow(self.pic_scale as u32);
                    format!("{}.{:0>width$}", max_val / div, max_val % div, width = self.pic_scale as usize)
                } else {
                    max_val.to_string()
                }
            }
            _ => {
                // Use pic_digits and pic_scale
                if self.pic_digits == 0 { return "0".into(); }
                let max_val = 10u128.pow(self.pic_digits as u32) - 1;
                if self.pic_scale > 0 {
                    let div = 10u128.pow(self.pic_scale as u32);
                    format!("{}.{:0>width$}", max_val / div, max_val % div, width = self.pic_scale as usize)
                } else {
                    max_val.to_string()
                }
            }
        }
    }

    /// LOWEST-ALGEBRAIC: return the minimum value this field can hold as a string.
    pub fn lowest_algebraic(&self) -> String {
        match &self.field_type {
            FieldType::Float32 => return format!("{}", f32::MIN),
            FieldType::Float64 => return format!("{}", f64::MIN),
            FieldType::FloatDecimal16 => return format!("{}", f64::MIN),
            FieldType::FloatDecimal34 => return format!("{}", f64::MIN),
            FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 => {
                if !self.is_signed { return "0".into(); }
                // Signed binary: min value is -(max+1) for two's complement
                let bin_min: i128 = match self.size {
                    1 => -128,
                    2 => -32768,
                    4 => -2147483648,
                    8 => -9223372036854775808,
                    _ => {
                        let h: i128 = self.highest_algebraic().parse().unwrap_or(0);
                        -h
                    }
                };
                let pic_max = if self.pic_digits > 0 { 10i128.pow(self.pic_digits as u32) - 1 } else { i128::MAX };
                let effective = bin_min.max(-pic_max);
                format!("{}", effective)
            }
            _ => {
                if self.is_signed {
                    format!("-{}", self.highest_algebraic())
                } else {
                    "0".into()
                }
            }
        }
    }

    /// Count digit positions in an edited numeric pattern.
    /// Returns (integer_digits, decimal_digits).
    fn count_edit_digit_positions(pattern: &str) -> (usize, usize) {
        // Strip trailing edit markers: B, CR, DB (case-insensitive)
        let upper = pattern.to_uppercase();
        let work = upper.trim_end_matches("CR").trim_end_matches("DB");

        let chars: Vec<char> = work.chars().collect();
        let dot_pos = chars.iter().position(|c| *c == '.' || *c == 'V');
        let mut int_count = 0usize;
        let mut dec_count = 0usize;
        for (i, ch) in chars.iter().enumerate() {
            let is_digit_pos = matches!(ch, '9' | 'Z' | '*');
            if is_digit_pos {
                if let Some(dp) = dot_pos {
                    if i > dp { dec_count += 1; } else { int_count += 1; }
                } else {
                    int_count += 1;
                }
            }
        }
        // Handle floating symbols: $, +, - — each occurrence beyond the first is a digit position
        for sym in &['$', '+', '-'] {
            let count = chars.iter().filter(|c| *c == sym).count();
            if count > 1 {
                // Floating: all but the first are digit positions
                // They appear before the dot
                int_count += count - 1;
            }
            // Single $ is fixed insertion — not a digit position
        }
        (int_count, dec_count)
    }
}

// ── CobolRecord — Unified Field Storage ──────────────────────────────

#[cfg_attr(
    feature = "central-buffer",
    deprecated(note = "prefer cobol_runtime::memory_v2::CobolRecordV2 (Phase 5+ codegen)")
)]
pub struct CobolRecord {
    pub data: Vec<u8>,                        // flat byte storage
    pub fields: Vec<FieldDescriptor>,         // field map
    pub field_index: HashMap<String, usize>,  // name -> index into fields
    pub based_allocated: std::collections::HashSet<String>,  // BASED items currently allocated
    pub odo: crate::odo_slide::OdoRegistry,   // OCCURS DEPENDING ON dynamic offset registry
    pub leaf_children: HashMap<String, LeafChildInfo>,  // non-OCCURS children within OCCURS parents
    /// When resolve_field uses leaf_children, this is set to Some(leaf_size).
    /// Callers like cobol_move should check and clear this to override the descriptor's size.
    pub leaf_resolve_size: std::cell::Cell<Option<usize>>,
    /// Dynamic base offsets for LINKAGE/pointer-based fields (SET ADDRESS OF).
    /// Maps field index → current base offset in data[].
    pub pointer_bases: HashMap<usize, usize>,
    /// L-var registry: field_name (upper) → (len_field_name, max_len)
    /// For PIC LX/LA fields with DEPENDING ON — logical length is controlled at runtime.
    pub lvar_registry: HashMap<String, (String, usize)>,
    /// Out-of-band string storage for FLOAT-DECIMAL-16 / FLOAT-DECIMAL-34 fields.
    /// Keyed by (field_idx, actual_offset) so OCCURS subscripts that resolve to
    /// distinct offsets get distinct entries. The COBOL-spec 8/16-byte slot in
    /// `data` is too small to hold the full IEEE 754 decimal exponent range
    /// (decimal64 max ≈ 9.999E+369, decimal128 max ≈ 9.999E+6144), so the raw
    /// bytes are reserved for layout/REDEFINES compat while the real value
    /// lives here as a normalized DBig-format decimal string.
    pub fd_string_values: HashMap<(usize, usize), String>,
}

/// Metadata for a leaf field (no OCCURS of its own) inside an OCCURS parent.
/// Allows resolve_field to map TSTY-7(1,1,1) → TSTY-6(1,1) + stride.
#[derive(Debug, Clone)]
pub struct LeafChildInfo {
    pub parent_base: String,     // parent descriptor base name, e.g., "TSTY-6"
    pub offset_in_parent: usize, // offset of this child within one parent element
    pub leaf_size: usize,        // size of this leaf field
}

impl CobolRecord {
    pub fn new(total_size: usize, fields: Vec<FieldDescriptor>) -> Self {
        let mut index = HashMap::new();
        for (i, f) in fields.iter().enumerate() {
            index.insert(f.name.to_uppercase(), i);
        }
        let mut data = vec![0x20u8; total_size]; // space-fill like COBOL INITIALIZE
        // Properly initialize binary/numeric fields with zeros
        for f in &fields {
            match f.field_type {
                FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 |
                FieldType::Float32 | FieldType::Float64 |
                FieldType::Packed | FieldType::Comp6 => {
                    let end = (f.offset + f.size).min(data.len());
                    for b in &mut data[f.offset..end] { *b = 0x00; }
                }
                FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                    // Store as zero-padded ASCII string "0"
                    let end = (f.offset + f.size).min(data.len());
                    for b in &mut data[f.offset..end] { *b = 0x00; }
                    if f.offset < data.len() { data[f.offset] = b'0'; }
                }
                FieldType::NumericDisplay | FieldType::SignedDisplay => {
                    let end = (f.offset + f.size).min(data.len());
                    for b in &mut data[f.offset..end] { *b = b'0'; }
                }
                _ => {}
            }
        }
        let mut rec = Self { data, fields, field_index: index, based_allocated: std::collections::HashSet::new(), odo: crate::odo_slide::OdoRegistry::new(), leaf_children: HashMap::new(), leaf_resolve_size: std::cell::Cell::new(None), pointer_bases: HashMap::new(), lvar_registry: HashMap::new(), fd_string_values: HashMap::new() };
        // Initialize EditedNumeric fields with zero-formatted display
        let edited_fields: Vec<String> = rec.fields.iter()
            .filter_map(|f| match &f.field_type {
                FieldType::EditedNumeric(_) => Some(f.name.clone()),
                _ => None,
            })
            .collect();
        for name in &edited_fields {
            rec.set_f64(name, 0.0);
        }
        rec
    }

    /// Graceful field index lookup — returns None for unknown fields instead of panicking.
    #[inline]
    pub fn idx(&self, name: &str) -> Option<usize> {
        self.field_index.get(&name.to_uppercase()).copied()
    }

    /// Register a leaf field (no OCCURS) that lives inside an OCCURS parent.
    /// E.g., TSTY-7 PIC X inside TSTY-6 OCCURS 1-3: register_leaf_child("TSTY-7", "TSTY-6", 0, 1)
    /// Enables resolve_field to map TSTY-7(IX,IY,IZ) → TSTY-6(IX,IY) + (IZ-1)*1
    pub fn register_leaf_child(&mut self, child_name: &str, parent_name: &str, offset: usize, size: usize) {
        self.leaf_children.insert(child_name.to_uppercase(), LeafChildInfo {
            parent_base: parent_name.to_uppercase(),
            offset_in_parent: offset,
            leaf_size: size,
        });
    }

    /// Find the end offset of the enclosing 01-level group for a given field index.
    /// Scans backwards to find the first Group field that contains this field,
    /// then returns its end offset (offset + size). If no enclosing group is found,
    /// returns the field's own end offset.
    fn find_group_end(&self, field_idx: usize) -> usize {
        let f = &self.fields[field_idx];
        let f_offset = f.offset;
        let f_end = f.offset + f.size;
        // Search backwards for an enclosing Group that contains this field
        for i in (0..field_idx).rev() {
            let g = &self.fields[i];
            if g.field_type == FieldType::Group {
                let g_end = g.offset + g.size;
                if g.offset <= f_offset && g_end >= f_end && g.size > f.size {
                    // This group encloses our field — use its boundary
                    return g_end;
                }
            }
        }
        // No enclosing group found — this is a standalone 01-level item
        f_end
    }

    /// Resolve a field name (including subscripted names like "X(3)") to (descriptor_index, actual_offset).
    /// If the exact name is found, returns its index and offset.
    /// If not found but it's a subscripted name like "X(N)", falls back to "X(1)" and computes offset.
    /// Supports negative and zero subscripts (GnuCOBOL allows out-of-bounds access in NOSSRANGE mode).
    /// Applies ODO slide adjustments when the field has OCCURS DEPENDING ON dependencies.
    pub fn resolve_field(&self, name: &str) -> Option<(usize, usize)> {
        // Clear any previous leaf size override
        self.leaf_resolve_size.set(None);
        let upper = name.to_uppercase();
        // Direct lookup — exact name match
        if let Some(&i) = self.field_index.get(&upper) {
            // Check for nested ODO: "CHARS(2,1)" → dynamic offset based on counters.
            // Only use this path when:
            //   1. Exactly 2 subscripts (matching the 2-level NestedOdoInfo)
            //   2. The field has NO standard ODO metadata (slides, stride, intra).
            //      If it does have ODO metadata, the standard odo_adjusted_offset
            //      path handles it correctly (including inter-occurrence slides
            //      from parent fixed-OCCURS groups).
            if let Some(paren) = upper.find('(') {
                let inner = &upper[paren+1..upper.len().saturating_sub(1)];
                if inner.contains(',') {
                    let base = &upper[..paren];
                    // Only use nested path if the field has no standard ODO metadata
                    let has_standard_odo = self.odo.get(i).map_or(false, |m| {
                        !m.slides.is_empty() || !m.inner_stride_slides.is_empty()
                            || m.intra_element_slide.is_some()
                    });
                    if !has_standard_odo {
                        if let Some(nested) = self.odo.nested_fields.get(base) {
                            let subs: Vec<i64> = inner.split(',')
                                .filter_map(|s| s.trim().parse::<i64>().ok())
                                .collect();
                            if subs.len() == 2 {
                                let outer_sub = subs[0].max(1) as usize;
                                let inner_sub = subs[1].max(1) as usize;
                                let inner_count = self.odo_counter_value(&nested.inner_counter)
                                    .min(nested.inner_max);
                                let dynamic_row_size = inner_count * nested.leaf_size;
                                let offset = nested.odo_abs_offset
                                    + (outer_sub - 1) * dynamic_row_size
                                    + (inner_sub - 1) * nested.leaf_size;
                                if offset + nested.leaf_size <= self.data.len() {
                                    return Some((i, offset));
                                }
                            }
                        }
                    }
                }
            }
            let base_offset = if let Some(&dynamic) = self.pointer_bases.get(&i) {
                if dynamic == usize::MAX { self.fields[i].offset } else { dynamic }
            } else {
                self.fields[i].offset
            };
            let offset = self.odo_adjusted_offset(i, base_offset);
            return Some((i, offset));
        }
        // Multi-subscript fallback: "L1-3-2(1,5,1)" → find "L1-3-2(1,5)" + element stride
        // Descriptors use N subscripts (for N OCCURS parents), but COBOL code uses N+1
        // (adding the occurrence of the field itself). Strip the last subscript and
        // use it as an element index on the found descriptor.
        if let Some(paren) = upper.find('(') {
            let close = upper.find(')').unwrap_or(upper.len());
            let subs_str = &upper[paren+1..close];
            let base = &upper[..paren];

            // Parse all subscripts
            let subs: Vec<i64> = subs_str.split(',')
                .filter_map(|s| s.trim().parse::<i64>().ok())
                .collect();

            if subs.len() >= 2 {
                // Try progressively stripping the last subscript
                // E.g., "L1-3-2(1,5,1)" → try "L1-3-2(1,5)" with extra_sub=1
                //        "L1-2(2,1)"    → try "L1-2(2)" with extra_sub=1
                for strip in 1..subs.len() {
                    let kept = &subs[..subs.len() - strip];
                    let extra_subs = &subs[subs.len() - strip..];
                    let kept_str = kept.iter().map(|s| s.to_string()).collect::<Vec<_>>().join(",");
                    let key = format!("{}({})", base, kept_str);
                    if let Some(&idx) = self.field_index.get(&key) {
                        let bf = &self.fields[idx];
                        let base_off = self.odo_adjusted_offset(idx, bf.offset);
                        // Apply each extra subscript as an element stride
                        let mut offset = base_off as i64;
                        let elem_size = bf.size as i64;
                        // The first extra subscript strides over elements of this descriptor
                        offset += (extra_subs[0] - 1) * elem_size;
                        // Remaining extra subs: not common, but handle gracefully
                        // (would need child element sizes — rare case)
                        if offset >= 0 && (offset as usize) + (bf.size) <= self.data.len() {
                            return Some((idx, offset as usize));
                        }
                    }
                }
            }

            // Single subscript fallback: X(N) → look up X(1) and compute offset
            if subs.len() == 1 {
                let sub = subs[0];
                let base_key = format!("{}(1)", base);
                if let Some(&base_idx) = self.field_index.get(&base_key) {
                    let bf = &self.fields[base_idx];
                    // Compute max OCCURS from group size / element size (e.g., Y has size 5, Y(1) has size 1 → max 5)
                    let max_occurs: i64 = if bf.size > 0 {
                        if let Some(&grp_idx) = self.field_index.get(base) {
                            (self.fields[grp_idx].size / bf.size) as i64
                        } else { i64::MAX }
                    } else { i64::MAX };
                    // Bounds check: subscript must be 1..=max_occurs
                    if sub < 1 || sub > max_occurs {
                        if crate::field_system::bounds_check_enabled() {
                            use std::io::Write;
                            let _ = std::io::stdout().flush();
                            let _ = writeln!(std::io::stderr(), "libcob: subscript out of bounds: {}({})", base, sub);
                            std::process::exit(1);
                        }
                        // NOSSRANGE: allow raw access (fall through to offset computation)
                    }
                    let base_off = self.odo_adjusted_offset(base_idx, bf.offset);
                    let offset = base_off as i64 + (sub - 1) * bf.size as i64;
                    if offset >= 0 && (offset as usize) + bf.size <= self.data.len() {
                        return Some((base_idx, offset as usize));
                    }
                }
                // Also try base name without subscript (OCCURS 1 case)
                if let Some(&base_idx) = self.field_index.get(base) {
                    let bf = &self.fields[base_idx];
                    let base_off = self.odo_adjusted_offset(base_idx, bf.offset);
                    let offset = base_off as i64 + (sub - 1) * bf.size as i64;
                    if offset >= 0 && (offset as usize) + bf.size <= self.data.len() {
                        return Some((base_idx, offset as usize));
                    }
                }
            }

            // Leaf child fallback: field has no descriptors but is a child of an OCCURS field.
            // E.g., TSTY-7(1,1,1) → TSTY-6(1,1) + (1-1)*1
            let subs: Vec<i64> = upper[paren+1..close].split(',')
                .filter_map(|s| s.trim().parse::<i64>().ok())
                .collect();
            if subs.len() >= 2 {
                if let Some(leaf) = self.leaf_children.get(base) {
                    let parent_subs = &subs[..subs.len()-1];
                    let child_sub = *subs.last().unwrap();
                    let parent_key = if parent_subs.len() == 1 {
                        format!("{}({})", leaf.parent_base, parent_subs[0])
                    } else {
                        format!("{}({})", leaf.parent_base,
                            parent_subs.iter().map(|s| s.to_string()).collect::<Vec<_>>().join(","))
                    };
                    if let Some(&idx) = self.field_index.get(&parent_key) {
                        let off = self.odo_adjusted_offset(idx, self.fields[idx].offset);
                        let final_off = off + leaf.offset_in_parent
                            + (child_sub.max(1) as usize - 1) * leaf.leaf_size;
                        if final_off + leaf.leaf_size <= self.data.len() {
                            // Signal the leaf size so callers (cobol_move, set_bytes) use
                            // the actual leaf element size, not the parent group's size.
                            self.leaf_resolve_size.set(Some(leaf.leaf_size));
                            return Some((idx, final_off));
                        }
                    }
                }
            }
        }
        None
    }

    /// Compute the ODO-adjusted offset for a field.
    /// If the field has no ODO dependencies, returns the static offset unchanged.
    /// ODO counter fields are read at their STATIC offsets to avoid recursion.
    #[inline]
    fn odo_adjusted_offset(&self, field_idx: usize, static_offset: usize) -> usize {
        if let Some(meta) = self.odo.get(field_idx) {
            let mut total_slide: usize = 0;
            // Standard offset slides (from ODO arrays before this field)
            if !meta.slides.is_empty() {
                total_slide += crate::odo_slide::compute_slide(&meta.slides, &|counter_name| {
                    self.odo_counter_value(counter_name)
                });
            }
            // Inner stride slides: per-element stride compression within parent ODO
            if !meta.inner_stride_slides.is_empty() {
                total_slide += crate::odo_slide::compute_inner_stride(&meta.inner_stride_slides, &|counter_name| {
                    self.odo_counter_value(counter_name)
                });
            }
            // Intra-element offset slide: compression from inner ODOs within the same element
            if let Some(ref intra) = meta.intra_element_slide {
                total_slide += crate::odo_slide::compute_intra_element_slide(intra, &|counter_name| {
                    self.odo_counter_value(counter_name)
                });
            }
            if total_slide > 0 {
                let result = static_offset.saturating_sub(total_slide);
                return result;
            }
            static_offset
        } else {
            static_offset
        }
    }

    /// Compute the ODO-adjusted size for a field.
    /// If the field IS an ODO array, returns counter_value * element_size.
    /// If the field is a Group CONTAINING ODO arrays, uses size_slides.
    /// Otherwise returns the static size.
    pub fn odo_adjusted_size(&self, name: &str) -> usize {
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            if let Some(meta) = self.odo.get(idx) {
                // Case 1: field IS an ODO array
                if let Some(ref own) = meta.own_odo {
                    return crate::odo_slide::compute_odo_size(own, &|counter_name| {
                        self.odo_counter_value(counter_name)
                    });
                }
                // Case 2: Group containing ODO arrays — use size_slides
                if !meta.size_slides.is_empty() {
                    let fd = &self.fields[idx];
                    let slide = crate::odo_slide::compute_slide(&meta.size_slides, &|counter_name| {
                        self.odo_counter_value(counter_name)
                    });
                    return fd.size.saturating_sub(slide);
                }
            }
            self.fields[idx].size
        } else {
            0
        }
    }

    /// ODO-aware size by field index — returns Some(dynamic_size) if ODO
    /// metadata exists, None otherwise (caller falls back to static size).
    pub fn odo_adjusted_size_by_idx(&self, idx: usize) -> Option<usize> {
        if let Some(meta) = self.odo.get(idx) {
            if let Some(ref own) = meta.own_odo {
                return Some(crate::odo_slide::compute_odo_size(own, &|counter_name| {
                    self.odo_counter_value(counter_name)
                }));
            }
            if !meta.size_slides.is_empty() {
                let fd = &self.fields[idx];
                let slide = crate::odo_slide::compute_slide(&meta.size_slides, &|counter_name| {
                    self.odo_counter_value(counter_name)
                });
                return Some(fd.size.saturating_sub(slide));
            }
        }
        None
    }

    /// Build the "slid" byte view for a group containing ODO arrays.
    /// In COBOL, displaying a group with OCCURS DEPENDING ON shows only
    /// the active elements, with subsequent fields sliding up.
    /// Our runtime stores fields at STATIC max offsets, so we must build
    /// the compacted byte sequence by skipping unused ODO portions.
    ///
    /// Returns None if the field has no ODO size_slides (caller falls back
    /// to contiguous read). Returns Some(bytes) with the compacted view.
    pub fn build_odo_slid_bytes(&self, group_idx: usize) -> Option<Vec<u8>> {
        let meta = self.odo.get(group_idx)?;
        if meta.size_slides.is_empty() {
            return None;
        }
        let grp = &self.fields[group_idx];
        let grp_start = grp.offset;
        let grp_end = grp.offset + grp.size;

        // Collect all ODO arrays within this group's static range.
        // Each ODO array: (static_start, static_max_size, dynamic_size)
        let mut odo_regions: Vec<(usize, usize, usize)> = Vec::new();
        let get_counter = |counter_name: &str| -> usize {
            self.odo_counter_value(counter_name)
        };
        for (fidx, fmeta) in &self.odo.field_meta {
            if let Some(ref own) = fmeta.own_odo {
                let fd = &self.fields[*fidx];
                // Only include ODO arrays physically within this group
                if fd.offset >= grp_start && fd.offset + fd.size <= grp_end {
                    let dyn_size = crate::odo_slide::compute_odo_size(own, &get_counter);
                    odo_regions.push((fd.offset, fd.size, dyn_size));
                }
            }
        }
        if odo_regions.is_empty() {
            return None;
        }
        // Sort by static offset
        odo_regions.sort_by_key(|r| r.0);
        // Deduplicate overlapping/identical regions (e.g., group and its child
        // array at the same offset both marked own_odo)
        odo_regions.dedup_by(|b, a| a.0 == b.0 && a.1 == b.1);

        // Build compacted bytes
        let mut result = Vec::new();
        let mut cursor = grp_start;
        for (odo_start, odo_max_size, odo_dyn_size) in &odo_regions {
            // Copy fixed bytes before this ODO array
            if cursor < *odo_start {
                let end = (*odo_start).min(self.data.len());
                let start = cursor.min(self.data.len());
                result.extend_from_slice(&self.data[start..end]);
            }
            // Copy only the active portion of the ODO array
            let active_end = (*odo_start + *odo_dyn_size).min(self.data.len());
            let start = (*odo_start).min(self.data.len());
            result.extend_from_slice(&self.data[start..active_end]);
            // Skip the unused portion
            cursor = *odo_start + *odo_max_size;
        }
        // Copy any remaining fixed bytes after the last ODO array
        if cursor < grp_end {
            let end = grp_end.min(self.data.len());
            let start = cursor.min(self.data.len());
            result.extend_from_slice(&self.data[start..end]);
        }
        Some(result)
    }

    /// Read an ODO counter field's value at its STATIC offset.
    /// Counter fields are always simple numeric fields at fixed positions,
    /// so we never apply ODO adjustments to them (avoids infinite recursion).
    fn odo_counter_value(&self, counter_name: &str) -> usize {
        let upper = counter_name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            let fd = &self.fields[idx];
            let off = fd.offset; // always static — counter fields don't slide
            if off + fd.size > self.data.len() { return 0; }
            match fd.field_type {
                FieldType::NumericDisplay | FieldType::SignedDisplay => {
                    let bytes = &self.data[off..off + fd.size];
                    // Parse ASCII digits, ignoring sign bytes and non-digit chars
                    let mut val: usize = 0;
                    let mut has_digit = false;
                    for &b in bytes {
                        if b >= b'0' && b <= b'9' {
                            val = val * 10 + (b - b'0') as usize;
                            has_digit = true;
                        }
                    }
                    if has_digit { val } else { 0 }
                }
                FieldType::Binary8 => {
                    if fd.size >= 1 {
                        self.data[off] as usize
                    } else { 0 }
                }
                FieldType::Binary16 => {
                    if fd.size >= 2 {
                        let arr = [self.data[off], self.data[off + 1]];
                        i16::from_be_bytes(arr).unsigned_abs() as usize
                    } else { 0 }
                }
                FieldType::Binary32 => {
                    if fd.size >= 4 {
                        let arr = [self.data[off], self.data[off+1], self.data[off+2], self.data[off+3]];
                        i32::from_be_bytes(arr).unsigned_abs() as usize
                    } else { 0 }
                }
                FieldType::Binary64 => {
                    if fd.size >= 8 {
                        let arr = [self.data[off], self.data[off+1], self.data[off+2], self.data[off+3],
                                   self.data[off+4], self.data[off+5], self.data[off+6], self.data[off+7]];
                        i64::from_be_bytes(arr).unsigned_abs() as usize
                    } else { 0 }
                }
                FieldType::Packed => {
                    crate::field_ops::unpack_bcd_i64(&self.data[off..off + fd.size], fd.is_signed).unsigned_abs() as usize
                }
                FieldType::Comp6 => {
                    crate::field_ops::unpack_bcd_i64(&self.data[off..off + fd.size], false).unsigned_abs() as usize
                }
                FieldType::Float32 => {
                    if off + 4 <= self.data.len() {
                        let b: [u8; 4] = self.data[off..off+4].try_into().unwrap_or([0;4]);
                        f32::from_be_bytes(b).max(0.0) as usize
                    } else { 0 }
                }
                FieldType::Float64 => {
                    if off + 8 <= self.data.len() {
                        let b: [u8; 8] = self.data[off..off+8].try_into().unwrap_or([0;8]);
                        f64::from_be_bytes(b).max(0.0) as usize
                    } else { 0 }
                }
                FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                    // Parse stored string representation
                    let end = (off + fd.size).min(self.data.len());
                    let s = String::from_utf8_lossy(&self.data[off..end]);
                    let trimmed = s.trim_end_matches('\0').trim();
                    trimmed.parse::<f64>().unwrap_or(0.0).max(0.0) as usize
                }
                _ => 0,
            }
        } else {
            0
        }
    }

    /// Apply ODO descriptors — the COBOL→Rust transfer type.
    /// Scans all FieldDescriptors by offset, automatically resolving which
    /// fields are ODO arrays, which are offset-slid, and which are size-slid.
    /// No name matching — works correctly with dedup'd names.
    pub fn apply_odo(&mut self, descriptors: &[crate::odo_slide::OdoDescriptor]) {
        self.odo.apply(descriptors, &self.fields);
    }

    /// Legacy name-based register (kept for backward compatibility)
    pub fn register_odo(&mut self, field_name: &str,
                        slides: Vec<crate::odo_slide::OdoSlideSource>,
                        own_odo: Option<crate::odo_slide::OdoOwnInfo>) {
        let upper = field_name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            self.odo.register(idx, slides, own_odo);
        }
    }
}
