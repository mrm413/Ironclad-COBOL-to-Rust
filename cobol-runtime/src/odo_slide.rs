// odo_slide.rs — OCCURS DEPENDING ON: COBOL-to-Rust transfer type
//
// COBOL's OCCURS DEPENDING ON (ODO) creates variable-length arrays.
// Fields following an ODO array "slide" — their actual offset depends
// on the runtime value of the ODO counter.
//
// This module provides `OdoDescriptor` — a Rust transfer type that maps
// COBOL's ODO semantics directly. The transpiler emits one OdoDescriptor
// per ODO array (static offsets + counter name), and the runtime
// automatically resolves which FieldDescriptors are affected using
// offset-range matching — no name matching, no dedup issues.
//
// The flow:
//   1. Transpiler emits OdoDescriptor { static_start, static_end, counter, max, elem }
//   2. CobolRecord::apply_odo() scans all FieldDescriptors by offset
//   3. Fields AT the ODO range → own_odo (dynamic size)
//   4. Fields AFTER the ODO range → offset slides
//   5. Groups CONTAINING the ODO range → size slides
//
// This is the Rust grid that mirrors COBOL's grid exactly.

use std::collections::HashMap;

// ── Transfer Type: COBOL ODO → Rust ────────────────────────────────

/// COBOL-to-Rust transfer type for one ODO array.
/// The transpiler knows the COBOL structure — this captures it.
/// Offsets are RELATIVE to the 01-level record start.
/// The runtime resolves absolute buffer positions from the FieldDescriptors.
#[derive(Clone, Debug)]
pub struct OdoDescriptor {
    /// Name of the 01-level record containing this ODO array (e.g., "G-1")
    pub record_name: String,
    /// Offset of ODO array from record start (TypedField.offset)
    pub odo_offset_rel: usize,
    /// Max size of the ODO array (max_occurs * element_size)
    pub odo_size_max: usize,
    /// Name of the DEPENDING ON counter field (uppercase)
    pub counter_field: String,
    /// Maximum OCCURS value
    pub max_occurs: usize,
    /// Byte size of one array element (at MAX — includes max of all inner ODOs)
    pub element_size: usize,
    /// Whether this ODO creates offset/size slides for other fields.
    /// False for sibling ODOs that are not the last at their level —
    /// GnuCOBOL keeps sibling ODO arrays at STATIC positions, only the
    /// last sibling truncates the parent group's size.
    pub creates_slides: bool,
    /// All inner ODO arrays within each element of THIS array.
    /// Each one contributes to element size compression recursively.
    /// Empty = leaf ODO (element_size is fully fixed).
    pub inner_counters: Vec<InnerOdoCounter>,
    /// If this ODO is inside repeating parents (fixed OCCURS or outer ODO),
    /// repeat classification for each parent occurrence. Cartesian product
    /// for multiple nesting levels. Each entry: (num_occurs, element_max_size).
    pub parent_occurs: Vec<(usize, usize)>,
}

/// Recursive inner ODO counter — one per inner OCCURS DEPENDING ON
/// within a parent ODO element. Can nest arbitrarily deep.
/// This is the spreadsheet cell: COBOL says "this sub-array shrinks",
/// Rust says "I know, here's the matching formula".
#[derive(Clone, Debug)]
pub struct InnerOdoCounter {
    /// Name of the DEPENDING ON counter field
    pub counter: String,
    /// Maximum OCCURS value for this inner ODO
    pub max_occurs: usize,
    /// Byte size of one element at this level (max, including any deeper inner ODOs)
    pub elem_size: usize,
    /// Deeper inner ODOs within each element of THIS inner array
    pub inner: Vec<InnerOdoCounter>,
    /// Where this inner ODO starts within its parent element (relative to element start).
    /// Used for intra-element offset slides: fields AFTER this inner ODO within
    /// the same parent element need to slide back when this ODO compresses.
    pub offset_within_elem: usize,
}

impl InnerOdoCounter {
    /// Compute actual total bytes used by this inner ODO and all its children,
    /// given current counter values. Recursive — matches COBOL's dynamic sizing.
    pub fn actual_total(&self, get_counter: &dyn Fn(&str) -> usize) -> usize {
        let count = get_counter(&self.counter).min(self.max_occurs);
        if self.inner.is_empty() {
            // Leaf: simple count * element
            count * self.elem_size
        } else {
            // Has deeper inner ODOs — each element has fixed + dynamic parts
            let actual_elem = self.actual_elem_size(get_counter);
            count * actual_elem
        }
    }

    /// Compute actual element size (with inner ODOs compressed).
    pub fn actual_elem_size(&self, get_counter: &dyn Fn(&str) -> usize) -> usize {
        if self.inner.is_empty() {
            return self.elem_size;
        }
        // fixed_part = elem_size - sum(each inner's max_total)
        // actual_elem = fixed_part + sum(each inner's actual_total)
        let inner_max_sum: usize = self.inner.iter().map(|i| i.max_total()).sum();
        let inner_actual_sum: usize = self.inner.iter().map(|i| i.actual_total(get_counter)).sum();
        let fixed = self.elem_size.saturating_sub(inner_max_sum);
        fixed + inner_actual_sum
    }

    /// Max total bytes (all elements at max, all inner at max). Static.
    pub fn max_total(&self) -> usize {
        self.max_occurs * self.elem_size
    }

    /// Per-element slide = elem_max - actual_elem for stride compression.
    pub fn elem_slide(&self, get_counter: &dyn Fn(&str) -> usize) -> usize {
        self.elem_size.saturating_sub(self.actual_elem_size(get_counter))
    }
}

// ── Internal metadata per field ────────────────────────────────────

/// One ODO array that causes fields after it to slide
#[derive(Clone, Debug)]
pub struct OdoSlideSource {
    pub counter_field: String,
    pub max_occurs: usize,
    pub element_size: usize,
    /// All inner ODO counters within each element (recursive)
    pub inner_counters: Vec<InnerOdoCounter>,
}

/// Per-element stride compression within an ODO array that has inner ODOs.
/// When parent element contains inner ODOs, each element shrinks. Fields at
/// element N get an extra slide of (N-1) * total_inner_compression.
#[derive(Clone, Debug)]
pub struct InnerStrideSlide {
    pub element_index: usize,   // 0-based: element N → index N-1
    /// All inner ODO counters that compress the parent element
    pub inner_counters: Vec<InnerOdoCounter>,
}

/// Intra-element offset slide: for fields WITHIN an ODO element that come
/// AFTER an inner ODO. When the inner ODO compresses, this field's offset
/// shifts back. Works recursively for nested inner ODOs.
#[derive(Clone, Debug)]
pub struct IntraElementSlideInfo {
    /// This field's offset within the parent ODO element
    pub offset_within_elem: usize,
    /// Inner ODO counters of the parent ODO element (with their positions)
    pub inner_counters: Vec<InnerOdoCounter>,
}

/// ODO metadata attached to a single FieldDescriptor
#[derive(Clone, Debug)]
pub struct OdoFieldMeta {
    /// ODO arrays that slide this field's OFFSET (field comes AFTER the ODO range)
    pub slides: Vec<OdoSlideSource>,
    /// ODO arrays that shrink this field's SIZE (field CONTAINS the ODO range — groups only)
    pub size_slides: Vec<OdoSlideSource>,
    /// If this field IS an ODO array, its own sizing info
    pub own_odo: Option<OdoOwnInfo>,
    /// Per-element stride compression from parent ODO with inner ODO
    pub inner_stride_slides: Vec<InnerStrideSlide>,
    /// Intra-element offset slide from inner ODOs within the same parent element
    pub intra_element_slide: Option<IntraElementSlideInfo>,
}

/// Info for a field that IS itself an ODO array
#[derive(Clone, Debug)]
pub struct OdoOwnInfo {
    pub counter_field: String,
    pub max_occurs: usize,
    pub element_size: usize,
    /// All inner ODO counters within each element (recursive)
    pub inner_counters: Vec<InnerOdoCounter>,
}

/// Info for nested ODO fields (multi-subscripted like CHARS(i,j))
/// Enables dynamic offset computation at runtime based on ODO counters.
#[derive(Clone, Debug)]
pub struct NestedOdoInfo {
    pub record_abs_offset: usize,   // absolute offset of the 01-level record
    pub odo_abs_offset: usize,      // absolute offset where the outer ODO array starts
    pub outer_counter: String,      // DEPENDING ON counter for outer dimension
    pub outer_max: usize,           // max OCCURS for outer dimension
    pub outer_static_elem: usize,   // static element size of outer dimension
    pub inner_counter: String,      // DEPENDING ON counter for inner dimension
    pub inner_max: usize,           // max OCCURS for inner dimension
    pub leaf_size: usize,           // byte size of one leaf element
}

// ── Registry ───────────────────────────────────────────────────────

/// Registry of all ODO relationships in a CobolRecord.
/// Keyed by field index for O(1) lookup at runtime.
#[derive(Clone, Debug, Default)]
pub struct OdoRegistry {
    pub field_meta: HashMap<usize, OdoFieldMeta>,
    /// Nested ODO subscript patterns: base_field_name (e.g., "CHARS") → NestedOdoInfo
    /// For multi-subscripted fields like CHARS(i,j), enables dynamic offset resolution.
    pub nested_fields: HashMap<String, NestedOdoInfo>,
}

impl OdoRegistry {
    pub fn new() -> Self {
        Self { field_meta: HashMap::new(), nested_fields: HashMap::new() }
    }

    /// The matching game: COBOL grid → Rust grid.
    /// Each OdoDescriptor says "ODO array at this position in this record."
    /// We find the record in the Rust grid (FieldDescriptors), compute absolute
    /// positions, then classify every cell: own_odo, offset slide, or size slide.
    /// No name matching — pure position matching between the two grids.
    ///
    /// When parent_occurs is set, the ODO repeats for each occurrence of the
    /// parent fixed-OCCURS group — we apply the classification at each offset.
    pub fn apply(&mut self, descriptors: &[OdoDescriptor], fields: &[crate::field::FieldDescriptor]) {
        for desc in descriptors {
            // Step 1: Find the record in our Rust grid — get its absolute position
            let record_name_upper = desc.record_name.to_uppercase();
            let (record_abs, record_size) = match fields.iter().find(|f| f.name == record_name_upper) {
                Some(f) => (f.offset, f.size),
                None => continue, // record not found in grid
            };
            let record_end = record_abs + record_size;

            // Determine iteration offsets: Cartesian product of all parent occurs levels.
            // Each parent level multiplies the iterations. For empty parent_occurs, just [0].
            let iterations: Vec<usize> = if desc.parent_occurs.is_empty() {
                vec![0]
            } else {
                let mut offsets = vec![0usize];
                for &(num_occurs, elem_size) in &desc.parent_occurs {
                    let mut new_offsets = Vec::new();
                    for &base in &offsets {
                        for i in 0..num_occurs {
                            new_offsets.push(base + i * elem_size);
                        }
                    }
                    offsets = new_offsets;
                }
                offsets
            };

            let slide_src = OdoSlideSource {
                counter_field: desc.counter_field.clone(),
                max_occurs: desc.max_occurs,
                element_size: desc.element_size,
                inner_counters: desc.inner_counters.clone(),
            };

            for &parent_offset in &iterations {
                // Step 2: Translate COBOL relative position → Rust absolute position
                let odo_abs_start = record_abs + parent_offset + desc.odo_offset_rel;
                let odo_abs_end = odo_abs_start + desc.odo_size_max;

                // Step 3: Scan every cell in the Rust grid — the matching game
                for (idx, fd) in fields.iter().enumerate() {
                    // Only match cells within this record's range
                    if fd.offset < record_abs || fd.offset + fd.size > record_end {
                        continue;
                    }

                    let fd_end = fd.offset + fd.size;

                    // Match 1: Cell IS the ODO array (same start, same max size)
                    // This ALWAYS applies — every ODO array knows its own dynamic size
                    if fd.offset == odo_abs_start && fd.size == desc.odo_size_max {
                        let entry = self.field_meta.entry(idx).or_insert_with(|| OdoFieldMeta {
                            slides: Vec::new(), size_slides: Vec::new(), own_odo: None, inner_stride_slides: Vec::new(), intra_element_slide: None,
                        });
                        entry.own_odo = Some(OdoOwnInfo {
                            counter_field: desc.counter_field.clone(),
                            max_occurs: desc.max_occurs,
                            element_size: desc.element_size,
                            inner_counters: desc.inner_counters.clone(),
                        });
                        continue;
                    }

                    // Match 2 & 3 only apply if this ODO creates slides.
                    if !desc.creates_slides {
                        continue;
                    }

                    // Match 2: Cell comes AFTER the ODO array → its offset slides
                    if fd.offset >= odo_abs_end {
                        let entry = self.field_meta.entry(idx).or_insert_with(|| OdoFieldMeta {
                            slides: Vec::new(), size_slides: Vec::new(), own_odo: None, inner_stride_slides: Vec::new(), intra_element_slide: None,
                        });
                        entry.slides.push(slide_src.clone());
                        continue;
                    }

                    // Match 3: Group cell CONTAINS the ODO range → its size shrinks
                    if fd.field_type == crate::field::FieldType::Group
                        && fd.offset <= odo_abs_start
                        && fd_end >= odo_abs_end
                        && fd.size > desc.odo_size_max
                    {
                        let entry = self.field_meta.entry(idx).or_insert_with(|| OdoFieldMeta {
                            slides: Vec::new(), size_slides: Vec::new(), own_odo: None, inner_stride_slides: Vec::new(), intra_element_slide: None,
                        });
                        entry.size_slides.push(slide_src.clone());
                    }
                }
            }

            // Step 5: Inner stride slides + intra-element slides — for ODO arrays
            // with inner_counters.
            if !desc.inner_counters.is_empty() {
                for &parent_offset in &iterations {
                    let odo_abs_start = record_abs + parent_offset + desc.odo_offset_rel;
                    let odo_abs_end = odo_abs_start + desc.odo_size_max;

                    for (idx, fd) in fields.iter().enumerate() {
                        if fd.offset < odo_abs_start || fd.offset >= odo_abs_end { continue; }
                        let element_index = (fd.offset - odo_abs_start) / desc.element_size;
                        let offset_within_elem = (fd.offset - odo_abs_start) % desc.element_size;

                        let entry = self.field_meta.entry(idx).or_insert_with(|| OdoFieldMeta {
                            slides: Vec::new(), size_slides: Vec::new(), own_odo: None, inner_stride_slides: Vec::new(), intra_element_slide: None,
                        });

                        // Element-to-element stride compression (element 2+)
                        if element_index > 0 {
                            entry.inner_stride_slides.push(InnerStrideSlide {
                                element_index,
                                inner_counters: desc.inner_counters.clone(),
                            });
                        }

                        // Intra-element offset slide: fields within an element
                        // that come after inner ODOs get compressed.
                        // Only set if not already set (first ODO to claim wins).
                        if entry.intra_element_slide.is_none() && desc.creates_slides {
                            entry.intra_element_slide = Some(IntraElementSlideInfo {
                                offset_within_elem,
                                inner_counters: desc.inner_counters.clone(),
                            });
                        }
                    }
                }
            }

            // Step 4: For nested ODO with exactly one simple inner counter,
            // register multi-subscript fields for dynamic subscript resolution.
            let first_odo_abs_start = record_abs + desc.odo_offset_rel;
            let first_odo_abs_end = first_odo_abs_start + desc.odo_size_max;
            if desc.inner_counters.len() == 1 && desc.inner_counters[0].inner.is_empty() {
                let ic = &desc.inner_counters[0];
                let mut base_names_seen = std::collections::HashSet::new();
                for fd in fields.iter() {
                    if fd.offset < first_odo_abs_start || fd.offset >= first_odo_abs_end { continue; }
                    if let Some(paren) = fd.name.find('(') {
                        let inner = &fd.name[paren+1..fd.name.len().saturating_sub(1)];
                        if inner.contains(',') {
                            let base = &fd.name[..paren];
                            if !base_names_seen.contains(base) {
                                base_names_seen.insert(base.to_string());
                                self.nested_fields.insert(base.to_string(), NestedOdoInfo {
                                    record_abs_offset: record_abs,
                                    odo_abs_offset: first_odo_abs_start,
                                    outer_counter: desc.counter_field.clone(),
                                    outer_max: desc.max_occurs,
                                    outer_static_elem: desc.element_size,
                                    inner_counter: ic.counter.clone(),
                                    inner_max: ic.max_occurs,
                                    leaf_size: ic.elem_size,
                                });
                            }
                        }
                    }
                }
            }
        }
    }

    /// Legacy name-based registration (kept for compatibility)
    pub fn register(&mut self, field_idx: usize, slides: Vec<OdoSlideSource>, own_odo: Option<OdoOwnInfo>) {
        self.field_meta.insert(field_idx, OdoFieldMeta { slides, size_slides: Vec::new(), own_odo, inner_stride_slides: Vec::new(), intra_element_slide: None });
    }

    #[inline]
    pub fn has_odo(&self) -> bool {
        !self.field_meta.is_empty()
    }

    #[inline]
    pub fn get(&self, field_idx: usize) -> Option<&OdoFieldMeta> {
        self.field_meta.get(&field_idx)
    }
}

// ── Computation helpers ────────────────────────────────────────────

/// Compute offset slide: how many bytes to SUBTRACT from static offset.
/// Uses recursive InnerOdoCounter for deep nesting support.
pub fn compute_slide(slides: &[OdoSlideSource], counter_values: &dyn Fn(&str) -> usize) -> usize {
    let mut total = 0usize;
    for src in slides {
        let outer_count = counter_values(&src.counter_field).min(src.max_occurs);
        if src.inner_counters.is_empty() {
            // Simple: no inner ODO
            total += (src.max_occurs - outer_count) * src.element_size;
        } else {
            // Recursive: element has inner ODOs that compress it
            let inner_max_sum: usize = src.inner_counters.iter().map(|i| i.max_total()).sum();
            let inner_actual_sum: usize = src.inner_counters.iter().map(|i| i.actual_total(counter_values)).sum();
            let fixed_part = src.element_size.saturating_sub(inner_max_sum);
            let actual_elem = fixed_part + inner_actual_sum;
            let max_total = src.max_occurs * src.element_size;
            let actual_total = outer_count * actual_elem;
            total += max_total.saturating_sub(actual_total);
        }
    }
    total
}

/// Compute inner stride slide: per-element compression from inner ODOs.
pub fn compute_inner_stride(slides: &[InnerStrideSlide], counter_values: &dyn Fn(&str) -> usize) -> usize {
    let mut total = 0usize;
    for iss in slides {
        // Total per-element compression from all inner ODOs
        let elem_compression: usize = iss.inner_counters.iter().map(|ic| {
            ic.max_total().saturating_sub(ic.actual_total(counter_values))
        }).sum();
        total += iss.element_index * elem_compression;
    }
    total
}

/// Compute dynamic size of an ODO array: current_count * actual_element_size.
pub fn compute_odo_size(own: &OdoOwnInfo, counter_values: &dyn Fn(&str) -> usize) -> usize {
    let current = counter_values(&own.counter_field).min(own.max_occurs);
    if own.inner_counters.is_empty() {
        current * own.element_size
    } else {
        let inner_max_sum: usize = own.inner_counters.iter().map(|i| i.max_total()).sum();
        let inner_actual_sum: usize = own.inner_counters.iter().map(|i| i.actual_total(counter_values)).sum();
        let fixed_part = own.element_size.saturating_sub(inner_max_sum);
        let actual_elem = fixed_part + inner_actual_sum;
        current * actual_elem
    }
}

/// Compute intra-element offset slide: recursive descent through inner ODO hierarchy.
/// For a field at `offset_within_elem` within a parent ODO element, compute how many
/// bytes to subtract due to inner ODOs compressing before this field.
///
/// Handles three cases at each level:
/// 1. Field is AFTER an inner ODO → slide by (max - actual)
/// 2. Field is WITHIN an inner ODO → compute stride for inner element + recurse deeper
/// 3. Field is BEFORE an inner ODO → no slide from that inner
pub fn compute_intra_element_slide(
    info: &IntraElementSlideInfo,
    counter_values: &dyn Fn(&str) -> usize,
) -> usize {
    compute_intra_element_slide_recursive(info.offset_within_elem, &info.inner_counters, counter_values)
}

fn compute_intra_element_slide_recursive(
    offset_within_elem: usize,
    inner_counters: &[InnerOdoCounter],
    counter_values: &dyn Fn(&str) -> usize,
) -> usize {
    let mut slide = 0usize;
    for ic in inner_counters {
        let ic_end = ic.offset_within_elem + ic.max_total();
        if offset_within_elem >= ic_end {
            // Case 1: Field is AFTER this inner ODO → slide by compression
            slide += ic.max_total().saturating_sub(ic.actual_total(counter_values));
        } else if offset_within_elem >= ic.offset_within_elem {
            // Case 2: Field is WITHIN this inner ODO
            let pos_within = offset_within_elem - ic.offset_within_elem;
            let elem_idx = pos_within / ic.elem_size;
            if elem_idx > 0 && !ic.inner.is_empty() {
                // Stride compression between inner elements
                let per_elem_compression: usize = ic.inner.iter().map(|i| {
                    i.max_total().saturating_sub(i.actual_total(counter_values))
                }).sum();
                slide += elem_idx * per_elem_compression;
            }
            // Recurse into inner's inner counters
            if !ic.inner.is_empty() {
                let offset_within_inner_elem = pos_within % ic.elem_size;
                slide += compute_intra_element_slide_recursive(
                    offset_within_inner_elem, &ic.inner, counter_values
                );
            }
        }
        // Case 3: offset < ic.offset_within_elem → field is BEFORE this inner, no slide
    }
    slide
}

// ── Tests ──────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use crate::field::{FieldDescriptor, FieldType};

    fn make_fd(name: &str, offset: usize, size: usize, ft: FieldType) -> FieldDescriptor {
        FieldDescriptor {
            name: name.into(), offset, size, field_type: ft,
            pic_scale: 0, pic_digits: 0, is_signed: false,
            justified_right: false, blank_when_zero: false,
            p_factor: 0, sign_leading: false, sign_separate: false,
            is_pointer: false, pic_clause_digits: 0,
        }
    }

    #[test]
    fn test_simple_slide() {
        let slides = vec![OdoSlideSource {
            counter_field: "CNT".into(), max_occurs: 5, element_size: 1, inner_counters: vec![],
        }];
        assert_eq!(compute_slide(&slides, &|_| 3), 2); // (5-3)*1
    }

    #[test]
    fn test_multiple_slides() {
        let slides = vec![
            OdoSlideSource { counter_field: "I".into(), max_occurs: 3, element_size: 1, inner_counters: vec![] },
            OdoSlideSource { counter_field: "I".into(), max_occurs: 3, element_size: 1, inner_counters: vec![] },
        ];
        assert_eq!(compute_slide(&slides, &|_| 2), 2); // 2 * (3-2)*1
    }

    #[test]
    fn test_apply_ext010_pattern() {
        let fields = vec![
            make_fd("I",      0,  1, FieldType::NumericDisplay),
            make_fd("G-1",    1,  9, FieldType::Group),
            make_fd("G-2",    1,  3, FieldType::Group),
            make_fd("X",      1,  3, FieldType::Group),
            make_fd("X(1)",   1,  1, FieldType::AlphaNumeric),
            make_fd("X(2)",   2,  1, FieldType::AlphaNumeric),
            make_fd("X(3)",   3,  1, FieldType::AlphaNumeric),
            make_fd("G-3",    4,  6, FieldType::Group),
            make_fd("G-4",    4,  3, FieldType::Group),
            make_fd("X__2",   4,  3, FieldType::Group),
            make_fd("X(1)__2",4,  1, FieldType::AlphaNumeric),
            make_fd("X(2)__2",5,  1, FieldType::AlphaNumeric),
            make_fd("X(3)__2",6,  1, FieldType::AlphaNumeric),
            make_fd("G-5",    7,  3, FieldType::Group),
            make_fd("X__3",   7,  3, FieldType::Group),
            make_fd("X(1)__3",7,  1, FieldType::AlphaNumeric),
            make_fd("X(2)__3",8,  1, FieldType::AlphaNumeric),
            make_fd("X(3)__3",9,  1, FieldType::AlphaNumeric),
        ];

        let descriptors = vec![
            OdoDescriptor { record_name: "G-1".into(), odo_offset_rel: 0, odo_size_max: 3, counter_field: "I".into(), max_occurs: 3, element_size: 1, creates_slides: true, inner_counters: vec![], parent_occurs: vec![] },
            OdoDescriptor { record_name: "G-1".into(), odo_offset_rel: 3, odo_size_max: 3, counter_field: "I".into(), max_occurs: 3, element_size: 1, creates_slides: true, inner_counters: vec![], parent_occurs: vec![] },
            OdoDescriptor { record_name: "G-1".into(), odo_offset_rel: 6, odo_size_max: 3, counter_field: "I".into(), max_occurs: 3, element_size: 1, creates_slides: true, inner_counters: vec![], parent_occurs: vec![] },
        ];

        let mut reg = OdoRegistry::new();
        reg.apply(&descriptors, &fields);

        // X (idx 3): should be own_odo — it IS the first ODO array
        let x = reg.get(3).unwrap();
        assert!(x.own_odo.is_some(), "X should be own_odo");
        assert!(x.slides.is_empty());

        // G-3 (idx 7): should have 1 offset slide (comes after first ODO)
        let g3 = reg.get(7).unwrap();
        assert_eq!(g3.slides.len(), 1, "G-3 should have 1 offset slide");

        // G-5 (idx 13): should have 2 offset slides (comes after first + second ODO)
        let g5 = reg.get(13).unwrap();
        assert_eq!(g5.slides.len(), 2, "G-5 should have 2 offset slides");

        // G-1 (idx 1): should have 3 size_slides, NO offset slides
        let g1 = reg.get(1).unwrap();
        assert!(g1.slides.is_empty(), "G-1 should NOT get offset slides");
        assert_eq!(g1.size_slides.len(), 3, "G-1 should have 3 size_slides");

        // G-2 (idx 2): same offset+size as ODO array — gets own_odo too (correct behavior)
        let g2 = reg.get(2).unwrap();
        assert!(g2.own_odo.is_some(), "G-2 should get own_odo (same cell as ODO array)");
    }
}
