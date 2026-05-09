use rust_decimal::Decimal as RDecimal;

use super::*;

impl CobolRecord {
    /// COMPUTE with rounding mode: round value at field's pic_scale before storing.
    /// mode: 0=truncation, 1=away-from-zero, 2=nearest-away-from-zero, 3=nearest-even,
    ///       4=nearest-toward-zero, 5=toward-greater(ceil), 6=toward-lesser(floor)
    pub fn set_f64_rounded(&mut self, name: &str, value: f64, mode: u8) {
        let idx = match self.resolve_field(name).map(|(i,_)| i) { Some(i) => i, None => return Default::default() };
        // Float types: rounding is meaningless — store the full float value directly
        if matches!(self.fields[idx].field_type, FieldType::Float32 | FieldType::Float64 | FieldType::FloatDecimal16 | FieldType::FloatDecimal34) {
            self.set_f64(name, value);
            return;
        }
        let scale = self.fields[idx].pic_scale as u32;
        let factor = 10f64.powi(scale as i32);
        let scaled = value * factor;
        let rounded = match mode {
            0 => scaled.trunc(),                                           // Truncation
            1 => if scaled >= 0.0 { scaled.ceil() } else { scaled.floor() }, // Away from zero
            2 => scaled.round(),                                           // Nearest away from zero
            3 => {                                                         // Nearest even (banker's)
                let r = scaled.round();
                if (scaled - scaled.floor() - 0.5).abs() < 1e-10 {
                    if r as i64 % 2 != 0 { r - r.signum() } else { r }
                } else { r }
            }
            4 => {                                                         // Nearest toward zero
                let r = scaled.round();
                if (scaled - scaled.floor() - 0.5).abs() < 1e-10 {
                    scaled.trunc()
                } else { r }
            }
            5 => scaled.ceil(),                                            // Toward greater
            6 => scaled.floor(),                                           // Toward lesser
            _ => scaled.round(),
        };
        self.set_f64(name, rounded / factor);
    }

    /// Sort an OCCURS table in place.
    /// `table_offset` = byte offset of the table in `self.data`
    /// `element_size` = size in bytes of each occurrence
    /// `count` = number of occurrences
    /// `keys` = slice of (byte_offset_within_element, key_size, ascending)
    pub fn sort_table(&mut self, table_offset: usize, element_size: usize, count: usize,
                      keys: &[(usize, usize, bool)]) {
        self.sort_table_collation(table_offset, element_size, count, keys, false);
    }

    pub fn sort_table_ebcdic(&mut self, table_offset: usize, element_size: usize, count: usize,
                      keys: &[(usize, usize, bool)]) {
        self.sort_table_collation(table_offset, element_size, count, keys, true);
    }

    fn sort_table_collation(&mut self, table_offset: usize, element_size: usize, count: usize,
                      keys: &[(usize, usize, bool)], ebcdic: bool) {
        if count <= 1 || element_size == 0 { return; }
        let mut indices: Vec<usize> = (0..count).collect();
        indices.sort_by(|&a, &b| {
            for &(key_off, key_sz, ascending) in keys {
                let sa = table_offset + a * element_size + key_off;
                let sb = table_offset + b * element_size + key_off;
                let ka = &self.data[sa..sa + key_sz];
                let kb = &self.data[sb..sb + key_sz];
                let cmp = if ebcdic {
                    // Compare using EBCDIC collation: convert ASCII bytes to EBCDIC order
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
        let mut temp = vec![0u8; count * element_size];
        for (new_idx, &old_idx) in indices.iter().enumerate() {
            let src = table_offset + old_idx * element_size;
            let dst = new_idx * element_size;
            temp[dst..dst + element_size].copy_from_slice(&self.data[src..src + element_size]);
        }
        self.data[table_offset..table_offset + count * element_size].copy_from_slice(&temp);
    }

    /// Look up a field descriptor by name
    pub fn get_field(&self, name: &str) -> Option<&FieldDescriptor> {
        self.field_index.get(&name.to_uppercase()).map(|&idx| &self.fields[idx])
    }

    /// Get raw bytes for a field (offset..offset+size) as a Vec.
    /// For groups with ODO SLIDE, returns only the active (slid) byte range —
    /// writes to ODO arrays already land at slid offsets, so the bytes between
    /// `offset` and `offset+slid_size` are contiguous and correct.
    pub fn get_raw_bytes(&self, name: &str) -> Vec<u8> {
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            let fd = &self.fields[idx];
            let mut size = fd.size;
            if fd.field_type == crate::field::FieldType::Group {
                if let Some(meta) = self.odo.get(idx) {
                    if meta.own_odo.is_some() || !meta.size_slides.is_empty() {
                        if let Some(adj) = self.odo_adjusted_size_by_idx(idx) {
                            size = adj;
                        }
                    }
                }
            }
            let end = (fd.offset + size).min(self.data.len());
            self.data[fd.offset..end].to_vec()
        } else {
            vec![]
        }
    }

    /// Set raw bytes for a field, writing exactly min(value.len, field.size) bytes
    pub fn set_raw_bytes(&mut self, name: &str, value: &[u8]) {
        if let Some(&idx) = self.field_index.get(&name.to_uppercase()) {
            let f = &self.fields[idx];
            let offset = f.offset;
            let size = f.size;
            let copy_len = value.len().min(size);
            // Space-fill first, then copy
            self.data[offset..offset + size].fill(b' ');
            self.data[offset..offset + copy_len].copy_from_slice(&value[..copy_len]);
        }
    }

    /// Check if a field name exists in this record
    pub fn has_field(&self, name: &str) -> bool {
        self.field_index.contains_key(&name.to_uppercase())
    }

    /// Write `value` starting at absolute byte `offset`, copying min(value.len, size).
    /// Used to initialize unnamed FILLER fields that share the same descriptor name —
    /// when COBOL has multiple `05 FILLER VALUE 'xxx'` items, each must land at its
    /// own absolute offset, not a deduped descriptor name. Silently clipped to data
    /// buffer bounds.
    pub fn set_bytes_at_offset(&mut self, offset: usize, size: usize, value: &[u8]) {
        let end = (offset + size).min(self.data.len());
        if end <= offset { return; }
        let avail = end - offset;
        let copy_len = value.len().min(avail);
        self.data[offset..offset + avail].fill(b' ');
        if copy_len > 0 {
            self.data[offset..offset + copy_len].copy_from_slice(&value[..copy_len]);
        }
    }

    // ── Phase 1c: codegen-facing helpers (backend-parity with CobolRecordV2) ──

    /// Fill `[field.offset + start_1based - 1 .. +len]` with `byte`, clamped to
    /// field end and to the underlying data buffer.  Backs `INITIALIZE fld(s:l)`
    /// refmod codegen without exposing `record.data` to generated code.
    /// Silently no-ops for unknown or zero-length fields.
    pub fn fill_bytes_range(&mut self, name: &str, start_1based: usize, len: usize, byte: u8) {
        let idx = match self.field_index.get(&name.to_uppercase()) { Some(&i) => i, None => return };
        if start_1based == 0 || len == 0 { return; }
        let f = &self.fields[idx];
        let base = f.offset + start_1based - 1;
        let end = (base + len).min(f.offset + f.size).min(self.data.len());
        if end <= base { return; }
        for b in &mut self.data[base..end] { *b = byte; }
    }

    /// Append `bytes` + trailing NUL to the record's flat storage, return the
    /// 1-based offset where `bytes` starts (compatible with COB_GETENV pointer
    /// semantics).  Returns 0 if `bytes` is empty.  This grows the record's
    /// `data` buffer — legacy-only semantics; V2 returns 0 (=NULL).
    pub fn append_scratch_nul(&mut self, bytes: &[u8]) -> usize {
        if bytes.is_empty() { return 0; }
        let ptr = self.data.len() + 1;
        self.data.extend_from_slice(bytes);
        self.data.push(0);
        ptr
    }

    // ── POINTER / ADDRESS OF support ─────────────────────────────────
    // Convention: pointer_bases stores 0-based byte offsets.
    // usize::MAX is the sentinel for NULL (no address assigned).
    // POINTER fields store 1-based values (0 = NULL, offset+1 = valid).

    /// SET ADDRESS OF field TO offset (0-based) — makes a LINKAGE field point to
    /// a specific byte offset in the flat data array.
    /// Also writes the offset as LE u64 into the field's byte storage so that
    /// raw-byte readers (e.g. EXTFH) can see the pointer value.
    pub fn set_address_of(&mut self, name: &str, offset: usize) {
        // usize::MAX from address_of means "source field unknown" — leave the
        // target's existing pointer_base alone. This guards SET ADDRESS OF X
        // TO ADDRESS OF FH--FCD-style cobc special-names that we don't model
        // as real fields (would otherwise wipe the target's native offset).
        // For explicit NULL, callers use set_address_null instead.
        if offset == usize::MAX { return; }
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            self.pointer_bases.insert(idx, offset);
            // Write LE u64 into byte storage for raw-byte readers (EXTFH etc.)
            // Only for actual POINTER fields; otherwise we'd corrupt the data the
            // pointer is being aimed at when the field is later read via refmod.
            let f = &self.fields[idx];
            if f.is_pointer {
                let start = f.offset;
                let end = start + f.size.min(8);
                if end <= self.data.len() && f.size >= 8 {
                    self.data[start..end].copy_from_slice(&(offset as u64).to_le_bytes());
                }
            }
            // Propagate the pointer redirect to every sub-field whose own
            // descriptor offset lies within this group's [offset, offset+size)
            // range. Pre-computing sub-field bases here lets normal field
            // reads (get_display / get_f64 / get_refmod) honor the parent's
            // SET ADDRESS — required for FCD/KEY-COMP-style "set parent
            // pointer, then read sub-fields" patterns common in EXTFH tests.
            // Skip when redirecting to NULL (handled by set_address_null).
            // Skip propagation when the destination is meaningless
            // (offset 0 = uninitialized FH--FCD-style special-name address)
            // to avoid clobbering pre-populated FCD field reads.
            if !f.is_pointer && offset != usize::MAX && offset != 0 {
                let parent_off = f.offset;
                let parent_end = parent_off + f.size;
                let mut subs: Vec<(usize, usize)> = Vec::new();
                for (sub_idx, sf) in self.fields.iter().enumerate() {
                    if sub_idx == idx { continue; }
                    if sf.offset >= parent_off && sf.offset + sf.size <= parent_end {
                        subs.push((sub_idx, sf.offset - parent_off));
                    }
                }
                for (sub_idx, rel) in subs {
                    self.pointer_bases.insert(sub_idx, offset + rel);
                }
            }
        }
    }

    /// SET ADDRESS OF field TO NULL — marks the field as having no valid address.
    pub fn set_address_null(&mut self, name: &str) {
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            self.pointer_bases.insert(idx, usize::MAX);
            // Write zero (NULL) into byte storage
            let f = &self.fields[idx];
            let start = f.offset;
            let end = start + f.size.min(8);
            if end <= self.data.len() && f.size >= 8 {
                self.data[start..end].fill(0);
            }
        }
    }

    /// SET ADDRESS OF target from a POINTER field's 1-based value.
    /// If ptr_val == 0 (NULL), sets address to NULL.
    /// If ptr_val > 0, converts to 0-based offset (ptr_val - 1).
    pub fn set_address_from_pointer(&mut self, name: &str, ptr_val: i64) {
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            if ptr_val > 0 {
                let offset = (ptr_val - 1) as usize;
                self.pointer_bases.insert(idx, offset);
                // Write LE u64 into byte storage
                let f = &self.fields[idx];
                let start = f.offset;
                let end = start + f.size.min(8);
                if end <= self.data.len() && f.size >= 8 {
                    self.data[start..end].copy_from_slice(&(offset as u64).to_le_bytes());
                }
            } else {
                self.pointer_bases.insert(idx, usize::MAX);
                let f = &self.fields[idx];
                let start = f.offset;
                let end = start + f.size.min(8);
                if end <= self.data.len() && f.size >= 8 {
                    self.data[start..end].fill(0);
                }
            }
        }
    }

    /// Get the current address (0-based byte offset) of a field.
    /// Returns the dynamic base if set, or static descriptor offset.
    /// Returns usize::MAX if field address is NULL or the field is unknown
    /// (e.g. cobc special-name like FH--FCD that we don't synthesize).
    /// Returns 0 if the parameter was marked as OMITTED.
    pub fn address_of(&self, name: &str) -> usize {
        let upper = name.to_uppercase();
        // Check if parameter was passed as OMITTED
        if crate::field_system::is_param_omitted(&upper) {
            return 0;
        }
        if let Some(&idx) = self.field_index.get(&upper) {
            if let Some(&dynamic) = self.pointer_bases.get(&idx) {
                return dynamic; // may be usize::MAX for NULL
            }
            return self.fields[idx].offset;
        }
        // Unknown field — return MAX sentinel so set_address_of knows to
        // leave the target alone (instead of redirecting to offset 0).
        usize::MAX
    }

    /// Get the 1-based pointer value for ADDRESS OF (for comparison with POINTER fields).
    /// Returns 0 if field address is NULL. Returns offset+1 otherwise.
    /// Returns 0 if the parameter was marked as OMITTED.
    pub fn address_of_ptr(&self, name: &str) -> usize {
        let upper = name.to_uppercase();
        // Check if parameter was passed as OMITTED
        if crate::field_system::is_param_omitted(&upper) {
            return 0;
        }
        if let Some(&idx) = self.field_index.get(&upper) {
            if let Some(&dynamic) = self.pointer_bases.get(&idx) {
                if dynamic == usize::MAX { return 0; } // NULL
                return dynamic + 1; // 0-based → 1-based
            }
            return self.fields[idx].offset + 1; // static, 1-based
        }
        0
    }

    /// SET ADDRESS OF field UP/DOWN BY delta — adjusts the dynamic base offset.
    pub fn adjust_address_of(&mut self, name: &str, delta: i64) {
        let upper = name.to_uppercase();
        if let Some(&idx) = self.field_index.get(&upper) {
            let current = self.pointer_bases.get(&idx)
                .copied()
                .unwrap_or(self.fields[idx].offset);
            // If NULL, start from static offset
            let base = if current == usize::MAX { self.fields[idx].offset } else { current };
            let new_offset = (base as i64 + delta).max(0) as usize;
            self.pointer_bases.insert(idx, new_offset);
        }
    }

    /// Register an L-var field: field_name (upper) → (len_field_name, max_len)
    /// Called during program initialization for each PIC LX/LA DEPENDING ON field.
    pub fn register_lvar(&mut self, field_name: &str, len_field: &str, max_len: usize) {
        self.lvar_registry.insert(field_name.to_uppercase(), (len_field.to_uppercase(), max_len));
    }

    /// Get the current logical length of an L-var field (clamped to [0, max_len]).
    pub fn get_lvar_len(&self, field_name: &str) -> Option<usize> {
        let key = field_name.to_uppercase();
        let (ref len_field, max_len) = *self.lvar_registry.get(&key)?;
        let curr = self.get_i64(len_field).max(0) as usize;
        Some(curr.min(max_len))
    }

    /// Fill a field with a specific byte value
    pub fn fill_field(&mut self, name: &str, byte: u8) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        // L-var: fill only the current logical length (leave bytes beyond curr unchanged)
        if let Some(curr_len) = self.get_lvar_len(name) {
            self.data[f.offset..f.offset + curr_len].fill(byte);
            return;
        }
        // Only ODO-limit for own_odo fields (the ODO array itself)
        let size = if self.odo.get(idx).map_or(false, |m| m.own_odo.is_some()) {
            self.odo_adjusted_size_by_idx(idx).unwrap_or(f.size)
        } else {
            f.size
        };
        self.data[f.offset..f.offset + size].fill(byte);
    }

    /// Fill a range of bytes relative to a named field's offset.
    pub fn fill_field_range(&mut self, name: &str, rel_offset: usize, len: usize, byte: u8) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = &self.fields[idx];
        let start = f.offset + rel_offset;
        let end = (start + len).min(self.data.len());
        if start < self.data.len() {
            self.data[start..end].fill(byte);
        }
    }

    /// Write specific bytes into a range relative to a named field's offset.
    pub fn fill_field_range_bytes(&mut self, name: &str, rel_offset: usize, bytes: &[u8]) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = &self.fields[idx];
        let start = f.offset + rel_offset;
        let end = (start + bytes.len()).min(self.data.len());
        if start < self.data.len() {
            let len = end - start;
            self.data[start..end].copy_from_slice(&bytes[..len]);
        }
    }

    /// Initialize a field: SPACES for alpha, ZEROS for numeric.
    /// For group fields, recursively initializes each child based on its type.
    pub fn initialize_field(&mut self, name: &str) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        match f.field_type {
            FieldType::Group => {
                // First fill with spaces (default for alpha parts)
                self.data[f.offset..f.offset + f.size].fill(0x20);
                // Then set numeric children to zeros
                let fields_copy = self.fields.clone();
                for child in &fields_copy {
                    if child.name != f.name
                        && child.offset >= f.offset
                        && child.offset + child.size <= f.offset + f.size
                    {
                        match &child.field_type {
                            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                                let end = (child.offset + child.size).min(self.data.len());
                                self.data[child.offset..end].fill(b'0');
                                // SIGN SEPARATE: set sign char to '+' (LEADING at first
                                // byte, TRAILING at last). Required for INITIALIZE on
                                // groups containing OCCURS of PIC S9 SIGN SEPARATE.
                                if child.sign_separate && child.size > 0 {
                                    let sign_pos = if child.sign_leading {
                                        child.offset
                                    } else {
                                        child.offset + child.size - 1
                                    };
                                    if sign_pos < self.data.len() {
                                        self.data[sign_pos] = b'+';
                                    }
                                }
                            }
                            FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 |
                            FieldType::Float32 | FieldType::Float64 |
                            FieldType::Packed | FieldType::Comp6 => {
                                let end = (child.offset + child.size).min(self.data.len());
                                self.data[child.offset..end].fill(0x00);
                            }
                            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                                let end = (child.offset + child.size).min(self.data.len());
                                self.data[child.offset..end].fill(0x00);
                                if child.offset < self.data.len() {
                                    self.data[child.offset] = b'0';
                                }
                            }
                            FieldType::EditedNumeric(ref pattern) => {
                                let formatted = format_edited_from_f64(0.0, pattern, child);
                                let end = (child.offset + child.size).min(self.data.len());
                                let dest = &mut self.data[child.offset..end];
                                dest.fill(0x20);
                                let bytes = formatted.as_bytes();
                                let len = bytes.len().min(dest.len());
                                dest[..len].copy_from_slice(&bytes[..len]);
                            }
                            _ => {}
                        }
                    }
                }
            }
            FieldType::AlphaNumeric | FieldType::EditedAlpha(_) => {
                // L-var: only initialize the current logical length; leave bytes beyond curr_len unchanged
                let fill_len = self.get_lvar_len(&f.name).unwrap_or(f.size);
                self.data[f.offset..f.offset + fill_len].fill(0x20);
            }
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                self.data[f.offset..f.offset + f.size].fill(b'0');
                // SIGN SEPARATE: set the sign character to '+' for the
                // initial zero value. LEADING places the sign at byte 0,
                // TRAILING at the last byte. Without this, an INITIALIZE on
                // a PIC S9 SIGN LEADING SEPARATE leaves "00" instead of "+0".
                if f.sign_separate && f.size > 0 {
                    let sign_pos = if f.sign_leading {
                        f.offset
                    } else {
                        f.offset + f.size - 1
                    };
                    if sign_pos < self.data.len() {
                        self.data[sign_pos] = b'+';
                    }
                }
            }
            FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 |
            FieldType::Float32 | FieldType::Float64 |
            FieldType::Packed | FieldType::Comp6 => {
                self.data[f.offset..f.offset + f.size].fill(0x00);
            }
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                self.data[f.offset..f.offset + f.size].fill(0x00);
                self.data[f.offset] = b'0';
            }
            FieldType::EditedNumeric(ref pattern) => {
                let formatted = format_edited_from_f64(0.0, pattern, &f);
                let dest = &mut self.data[f.offset..f.offset + f.size];
                dest.fill(0x20);
                let bytes = formatted.as_bytes();
                let len = bytes.len().min(dest.len());
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            _ => {
                self.data[f.offset..f.offset + f.size].fill(0x20);
            }
        }
    }

    /// Initialize a field to its default value using full PHYSICAL size (ignores L-var logical length).
    /// Used when initializing a PIC L field as part of a GROUP INITIALIZE.
    pub fn initialize_field_physical(&mut self, name: &str) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        match f.field_type {
            FieldType::AlphaNumeric | FieldType::EditedAlpha(_) => {
                // Use physical size regardless of L-var logical length
                self.data[f.offset..f.offset + f.size].fill(0x20);
            }
            _ => {
                // For non-alpha, physical init is same as logical init
                self.initialize_field(name);
            }
        }
    }

    /// Get field as rust_decimal::Decimal for precise arithmetic.
    pub fn get_decimal(&self, name: &str) -> RDecimal {
        read_as_decimal(self, name)
    }

    /// Set field from rust_decimal::Decimal (truncates extra decimal places).
    pub fn set_decimal(&mut self, name: &str, val: RDecimal) {
        write_decimal(self, name, val, false);
    }

    /// Set field from rust_decimal::Decimal with rounding.
    pub fn set_decimal_rounded(&mut self, name: &str, val: RDecimal) {
        write_decimal(self, name, val, true);
    }

    /// Fill a field by repeating a pattern (for ALL "x")
    pub fn fill_field_pattern(&mut self, name: &str, pattern: &[u8]) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return Default::default() };
        let f = &self.fields[idx];
        let size = f.size;
        if pattern.is_empty() { return; }
        for i in 0..size {
            self.data[actual_offset + i] = pattern[i % pattern.len()];
        }
    }

    /// Set bytes into a substring of a field (reference modification)
    /// start is 1-based (COBOL convention), length is byte count
    pub fn set_refmod(&mut self, name: &str, start: usize, length: usize, value: &[u8]) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        let offset = f.offset + start - 1;
        // ODO-aware: use dynamic size when available
        let field_size = self.odo_adjusted_size_by_idx(idx).unwrap_or(f.size);
        // usize::MAX sentinel means "to end of field" (no length specified in COBOL ref-mod)
        let effective_len = if length == usize::MAX { field_size.saturating_sub(start - 1) } else { length };
        if effective_len == 0 { return; }
        let end = (offset + effective_len).min(self.data.len());
        if offset >= self.data.len() { return; }
        let len = end - offset;
        let dest = &mut self.data[offset..end];
        let copy_len = value.len().min(len);
        dest[..copy_len].copy_from_slice(&value[..copy_len]);
        // Space-pad remainder
        for i in copy_len..len {
            dest[i] = 0x20;
        }
    }

    /// Get the size (in bytes) of a field
    pub fn field_size(&self, name: &str) -> usize {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        self.fields[idx].size
    }

    /// LENGTH OF — returns element size for OCCURS fields, total size otherwise
    pub fn length_of(&self, name: &str) -> usize {
        // For OCCURS fields, LENGTH OF returns the per-element size
        let elem_name = format!("{}(1)", name);
        if let Some(i) = self.idx(&elem_name) {
            return self.fields[i].size;
        }
        // Fall back to total field size — ODO-aware if metadata exists
        let idx = match self.idx(name) { Some(i) => i, None => return 0 };
        if let Some(dyn_size) = self.odo_adjusted_size_by_idx(idx) {
            return dyn_size;
        }
        self.fields[idx].size
    }

    /// FUNCTION LENGTH(x) — returns the current logical length for L-var (PIC L) fields,
    /// and the physical size for all other fields.
    pub fn function_length_of(&self, name: &str) -> usize {
        if let Some(curr_len) = self.get_lvar_len(name) {
            return curr_len;
        }
        self.length_of(name)
    }

    // ── POINTER support ──────────────────────────────────────────────

    /// CONTENT-LENGTH at a pointer offset: scan record bytes from offset until null byte.
    /// Offset is 1-based (0 = NULL pointer → returns 0).
    pub fn content_length_at_offset(&self, offset: usize) -> usize {
        if offset == 0 { return 0; }
        let start = offset - 1; // convert 1-based to 0-based
        if start >= self.data.len() { return 0; }
        // Scan for first null byte from start position
        for i in start..self.data.len() {
            if self.data[i] == 0 {
                return i - start;
            }
        }
        // No null found — return remaining length
        self.data.len() - start
    }

    /// CONTENT-OF at a pointer offset: extract string bytes from offset until null (or max_len).
    /// Offset is 1-based (0 = NULL pointer → returns empty).
    pub fn content_of_at_offset(&self, offset: usize, max_len: Option<usize>) -> String {
        if offset == 0 { return String::new(); }
        let start = offset - 1; // convert 1-based to 0-based
        if start >= self.data.len() { return String::new(); }
        let end = match max_len {
            Some(len) => (start + len).min(self.data.len()),
            None => {
                // Scan for null byte
                let mut e = start;
                while e < self.data.len() && self.data[e] != 0 {
                    e += 1;
                }
                e
            }
        };
        String::from_utf8_lossy(&self.data[start..end]).to_string()
    }

    // ── External byte allocation (FCD filenames, etc.) ────────────
    /// Append `bytes` to the record's data buffer and return the 0-based
    /// offset where they were written. Used for FCD-FILENAME-ADDRESS and
    /// similar cases where COBOL code expects a stable pointer to a string.
    /// We extend the flat record's data Vec to act as an inline arena —
    /// existing field offsets stay valid because they're indices, not refs.
    /// Callers add 1 to the returned offset to fit the 1-based pointer
    /// convention used by SET ADDRESS / pointer_bases.
    pub fn allocate_extern_bytes(&mut self, bytes: &[u8]) -> usize {
        let off = self.data.len();
        self.data.extend_from_slice(bytes);
        off
    }

    // ── BASED item allocation tracking ─────────────────────────────
    /// Mark a BASED item as allocated.
    pub fn allocate_based(&mut self, name: &str) {
        self.based_allocated.insert(name.to_uppercase());
        // Initialize the field's memory (zero alphanumeric, zero numeric)
        if let Some(i) = self.idx(name) {
            let f = &self.fields[i];
            let off = f.offset;
            let sz = f.size;
            match f.field_type {
                FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 |
                FieldType::Float32 | FieldType::Float64 |
                FieldType::Packed | FieldType::Comp6 => {
                    for b in &mut self.data[off..off+sz] { *b = 0x00; }
                }
                FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                    for b in &mut self.data[off..off+sz] { *b = 0x00; }
                    self.data[off] = b'0';
                }
                FieldType::NumericDisplay | FieldType::SignedDisplay => {
                    for b in &mut self.data[off..off+sz] { *b = b'0'; }
                }
                _ => {
                    for b in &mut self.data[off..off+sz] { *b = b' '; }
                }
            }
        }
    }

    /// Mark a BASED item as freed (NULL address).
    pub fn free_based(&mut self, name: &str) {
        self.based_allocated.remove(&name.to_uppercase());
        // Zero out the memory
        if let Some(i) = self.idx(name) {
            let f = &self.fields[i];
            let off = f.offset;
            let sz = f.size;
            for b in &mut self.data[off..off+sz] { *b = 0x00; }
        }
    }

    /// Check if a BASED item is currently allocated (has non-NULL address).
    pub fn is_based_allocated(&self, name: &str) -> bool {
        self.based_allocated.contains(&name.to_uppercase())
    }

    /// COBOL IS NUMERIC check — validates raw bytes against field type.
    /// For COMP-6: all nibbles must be 0-9 (no sign nibble).
    /// For Packed (COMP-3): all digit nibbles must be 0-9, sign nibble must be valid (0x0A-0x0F).
    /// For numeric display: all bytes must be digit characters (0x30-0x39), with optional sign.
    /// For groups/alphanumeric: check if display string parses as a number.
    pub fn is_field_numeric(&self, name: &str) -> bool {
        let idx = match self.idx(name) { Some(i) => i, None => return false };
        let f = &self.fields[idx];
        let bytes = &self.data[f.offset..f.offset + f.size];

        match f.field_type {
            FieldType::Comp6 => {
                // All nibbles must be valid BCD digits (0-9)
                for &b in bytes {
                    if (b >> 4) > 9 || (b & 0x0F) > 9 {
                        return false;
                    }
                }
                true
            }
            FieldType::Packed => {
                if bytes.is_empty() { return false; }
                // All nibbles except last must be 0-9
                for &b in &bytes[..bytes.len() - 1] {
                    if (b >> 4) > 9 || (b & 0x0F) > 9 {
                        return false;
                    }
                }
                // Last byte: high nibble = digit (0-9), low nibble = sign
                let last = bytes[bytes.len() - 1];
                if (last >> 4) > 9 { return false; }
                let sign_nibble = last & 0x0F;
                if f.is_signed {
                    // Signed packed: only 0x0C (positive) and 0x0D (negative) are valid
                    if sign_nibble != 0x0C && sign_nibble != 0x0D { return false; }
                } else {
                    // Unsigned packed: only 0x0F is valid
                    if sign_nibble != 0x0F { return false; }
                }
                true
            }
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                // Each byte should be an ASCII digit or sign character
                let s = self.get_display(name);
                s.trim().parse::<f64>().is_ok()
            }
            FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64
            | FieldType::Float32 | FieldType::Float64
            | FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                // Binary/float fields are always numeric
                true
            }
            _ => {
                // Groups, alphanumeric, edited: check display string
                let s = self.get_display(name);
                s.trim().parse::<f64>().is_ok()
            }
        }
    }

    // ── System routine helpers (CBL_*, C$*) ────────────────────────
    /// Get raw byte slice for a field
    pub fn field_bytes(&self, name: &str) -> &[u8] {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = &self.fields[idx];
        &self.data[f.offset..f.offset + f.size]
    }
    /// Get mutable byte slice for a field
    pub fn field_bytes_mut(&mut self, name: &str) -> &mut [u8] {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        &mut self.data[f.offset..f.offset + f.size]
    }
    /// CBL_OR: dest[i] |= src[i] for len bytes
    pub fn cbl_or(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] |= self.data[sf.offset + i];
        }
    }
    /// CBL_AND: dest[i] &= src[i] for len bytes
    pub fn cbl_and(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] &= self.data[sf.offset + i];
        }
    }
    /// CBL_XOR: dest[i] ^= src[i] for len bytes
    pub fn cbl_xor(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] ^= self.data[sf.offset + i];
        }
    }
    /// CBL_NOT: dest[i] = !dest[i] for len bytes
    pub fn cbl_not(&mut self, dst: &str, len: usize) {
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let df = self.fields[di].clone();
        let n = len.min(df.size);
        for i in 0..n {
            self.data[df.offset + i] = !self.data[df.offset + i];
        }
    }
    /// CBL_NOR: dest[i] = !(dest[i] | src[i]) for len bytes
    pub fn cbl_nor(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] = !(self.data[df.offset + i] | self.data[sf.offset + i]);
        }
    }
    /// CBL_NIMP: dest[i] = src[i] & !dest[i] for len bytes
    pub fn cbl_nimp(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] = self.data[sf.offset + i] & !self.data[df.offset + i];
        }
    }
    /// CBL_IMP: dest[i] = !src[i] | dest[i] for len bytes (material implication)
    pub fn cbl_imp(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] = !self.data[sf.offset + i] | self.data[df.offset + i];
        }
    }
    /// CBL_EQ: dest[i] = !(dest[i] ^ src[i]) for len bytes
    pub fn cbl_eq(&mut self, src: &str, dst: &str, len: usize) {
        let si = match self.idx(src) { Some(i) => i, None => return Default::default() };
        let di = match self.idx(dst) { Some(i) => i, None => return Default::default() };
        let sf = self.fields[si].clone();
        let df = self.fields[di].clone();
        let n = len.min(sf.size).min(df.size);
        for i in 0..n {
            self.data[df.offset + i] = !(self.data[df.offset + i] ^ self.data[sf.offset + i]);
        }
    }
    /// C$TOUPPER: uppercase len bytes in-place
    pub fn c_toupper(&mut self, field: &str, len: usize) {
        let fi = match self.idx(field) { Some(i) => i, None => return Default::default() };
        let fd = self.fields[fi].clone();
        let n = len.min(fd.size);
        for i in 0..n {
            let b = self.data[fd.offset + i];
            if b >= b'a' && b <= b'z' { self.data[fd.offset + i] = b - 32; }
        }
    }
    /// C$TOLOWER: lowercase len bytes in-place
    pub fn c_tolower(&mut self, field: &str, len: usize) {
        let fi = match self.idx(field) { Some(i) => i, None => return Default::default() };
        let fd = self.fields[fi].clone();
        let n = len.min(fd.size);
        for i in 0..n {
            let b = self.data[fd.offset + i];
            if b >= b'A' && b <= b'Z' { self.data[fd.offset + i] = b + 32; }
        }
    }
    /// C$JUSTIFY: justify field content ("L" = left, "R" or default = right)
    pub fn c_justify(&mut self, field: &str, direction: &str) {
        let fi = match self.idx(field) { Some(i) => i, None => return Default::default() };
        let fd = self.fields[fi].clone();
        let bytes = self.data[fd.offset..fd.offset + fd.size].to_vec();
        let s = String::from_utf8_lossy(&bytes);
        let trimmed = s.trim();
        let justified = if direction.eq_ignore_ascii_case("L") {
            format!("{:<width$}", trimmed, width = fd.size)
        } else {
            format!("{:>width$}", trimmed, width = fd.size)
        };
        let jbytes = justified.as_bytes();
        let n = jbytes.len().min(fd.size);
        self.data[fd.offset..fd.offset + n].copy_from_slice(&jbytes[..n]);
    }
    /// C$PRINTABLE: replace non-printable bytes with '.'
    pub fn c_printable(&mut self, field: &str) {
        let fi = match self.idx(field) { Some(i) => i, None => return Default::default() };
        let fd = self.fields[fi].clone();
        for i in 0..fd.size {
            let b = self.data[fd.offset + i];
            if b < 0x20 || b > 0x7E { self.data[fd.offset + i] = b'.'; }
        }
    }

    /// Get bytes from a substring of a field (reference modification)
    /// start is 1-based (COBOL convention)
    pub fn get_refmod(&self, name: &str, start: usize, length: usize) -> String {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = &self.fields[idx];
        // COBOL positions are 1-based; start=0 is underflow → return null bytes
        if start == 0 {
            let actual_len = if length == usize::MAX { f.size } else { length };
            return "\0".repeat(actual_len);
        }
        // Honor any dynamic pointer base set via SET ADDRESS OF.
        let base = self.pointer_bases.get(&idx)
            .copied()
            .filter(|&b| b != usize::MAX)
            .unwrap_or(f.offset);
        let offset = base + start - 1;
        let field_size = self.odo_adjusted_size_by_idx(idx).unwrap_or(f.size);
        let field_end = base + field_size;
        if offset >= self.data.len() { return String::new(); }
        // usize::MAX sentinel means "to end of field" (no length specified in COBOL ref-mod)
        // length=0 means actual zero length (variable evaluated to 0)
        if length == 0 { return String::new(); }
        // Find the enclosing 01-level group boundary.
        // Fields within a group can cross sub-field boundaries via ref-mod;
        // separate 01-level items cannot.
        // (group_end is descriptor-relative; only meaningful when no dynamic base.)
        let group_end = if self.pointer_bases.contains_key(&idx) {
            field_end
        } else {
            self.find_group_end(idx)
        };
        let actual_len = if length == usize::MAX {
            // No length specified: go to end of field
            field_end.saturating_sub(offset)
        } else {
            // Explicit length: allow access up to the 01-level group boundary
            length.min(group_end.saturating_sub(offset))
        };
        let end = (offset + actual_len).min(self.data.len());
        let bytes = &self.data[offset..end];
        String::from_utf8_lossy(bytes).to_string()
    }

    /// INSPECT CONVERTING: translate bytes from→to
    pub fn inspect_converting(&mut self, name: &str, from: &str, to: &str) {
        self.inspect_converting_ba(name, from, to, None, None);
    }

    pub fn inspect_converting_ba(&mut self, name: &str, from: &str, to: &str, before: Option<&str>, after: Option<&str>) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        let slice = &mut self.data[f.offset..f.offset + f.size];

        // For SignedDisplay fields with embedded sign (overpunch), temporarily
        // decode the sign byte to its digit equivalent, perform the conversion,
        // then re-apply the sign encoding. This matches GnuCOBOL behavior where
        // INSPECT operates on the logical digit representation.
        if matches!(f.field_type, FieldType::SignedDisplay) && f.is_signed && !f.sign_separate && !slice.is_empty() {
            let sign_pos = if f.sign_leading { 0 } else { slice.len() - 1 };
            let sign_byte = slice[sign_pos];
            // Decode overpunch to (digit, is_negative)
            let (digit, is_negative) = match sign_byte {
                b'0'..=b'9' => (sign_byte, false),
                b'{' => (b'0', false),
                b'A'..=b'I' => (sign_byte - b'A' + b'1', false),
                b'}' => (b'0', true),
                b'J'..=b'R' => (sign_byte - b'J' + b'1', true),
                b'p' => (b'0', true),
                b'q'..=b'y' => (sign_byte - b'q' + b'1', true),
                _ => (sign_byte, false),
            };
            // Temporarily set the sign byte to the plain digit
            slice[sign_pos] = digit;
            // Perform the conversion
            crate::string_ops::inspect_converting(
                slice,
                from.as_bytes(),
                to.as_bytes(),
                before.map(|s| s.as_bytes()),
                after.map(|s| s.as_bytes()),
            );
            // Re-apply the sign encoding to the (possibly changed) digit
            if is_negative {
                let d = slice[sign_pos];
                if d >= b'0' && d <= b'9' {
                    slice[sign_pos] = b'p' + (d - b'0');
                }
            }
        } else {
            crate::string_ops::inspect_converting(
                slice,
                from.as_bytes(),
                to.as_bytes(),
                before.map(|s| s.as_bytes()),
                after.map(|s| s.as_bytes()),
            );
        }
    }

    /// Strip sign encoding from a SignedDisplay field for INSPECT operations.
    /// Returns Some((sign_pos, is_negative)) if the field is SignedDisplay with
    /// embedded overpunch, None otherwise. After calling this, the raw bytes
    /// contain plain ASCII digits; call inspect_restore_sign() to re-encode.
    pub fn inspect_strip_sign(&mut self, name: &str) -> Option<(usize, bool)> {
        let idx = match self.idx(name) { Some(i) => i, None => return None };
        let f = &self.fields[idx];
        if !matches!(f.field_type, FieldType::SignedDisplay) || !f.is_signed || f.sign_separate {
            return None;
        }
        let offset = f.offset;
        let size = f.size;
        if size == 0 { return None; }
        let sign_pos = if f.sign_leading { 0 } else { size - 1 };
        let sign_byte = self.data[offset + sign_pos];
        let (digit, is_negative) = match sign_byte {
            b'0'..=b'9' => (sign_byte, false),
            b'{' => (b'0', false),
            b'A'..=b'I' => (sign_byte - b'A' + b'1', false),
            b'}' => (b'0', true),
            b'J'..=b'R' => (sign_byte - b'J' + b'1', true),
            b'p' => (b'0', true),
            b'q'..=b'y' => (sign_byte - b'q' + b'1', true),
            _ => (sign_byte, false),
        };
        self.data[offset + sign_pos] = digit;
        Some((sign_pos, is_negative))
    }

    /// Restore sign encoding after INSPECT operations.
    /// Re-encodes the digit at sign_pos with GnuCOBOL ASCII overpunch.
    pub fn inspect_restore_sign(&mut self, name: &str, sign_pos: usize, negative: bool) {
        let idx = match self.idx(name) { Some(i) => i, None => return };
        let f = &self.fields[idx];
        let offset = f.offset;
        if negative {
            let d = self.data[offset + sign_pos];
            if d >= b'0' && d <= b'9' {
                self.data[offset + sign_pos] = b'p' + (d - b'0');
            }
        }
    }

    /// Get display string for INSPECT operations on the target field.
    /// For SignedDisplay with overpunch, returns the raw bytes as a string
    /// (caller must call inspect_strip_sign first to get plain digits).
    /// For other types, returns the normal get_display.
    pub fn get_inspect_display(&self, name: &str) -> String {
        let upper = name.to_uppercase();
        let idx = match self.field_index.get(&upper) {
            Some(&i) => i,
            None => return String::new(),
        };
        let f = &self.fields[idx];
        // For SignedDisplay with embedded sign, return raw bytes as string
        // (assumes inspect_strip_sign was called to decode overpunch)
        if matches!(f.field_type, FieldType::SignedDisplay) && f.is_signed && !f.sign_separate {
            let bytes = &self.data[f.offset..f.offset + f.size];
            return String::from_utf8_lossy(bytes).to_string();
        }
        self.get_display(name)
    }

    /// Set field from INSPECT result for SignedDisplay with embedded sign.
    /// Writes raw digit bytes back (caller must call inspect_restore_sign after).
    pub fn set_inspect_bytes(&mut self, name: &str, value: &[u8]) {
        let idx = match self.idx(name) { Some(i) => i, None => return };
        let f = &self.fields[idx];
        // For SignedDisplay with embedded sign, write directly to raw bytes
        if matches!(f.field_type, FieldType::SignedDisplay) && f.is_signed && !f.sign_separate {
            let dest = &mut self.data[f.offset..f.offset + f.size];
            // Right-justify, zero-pad — same as digit write
            dest.fill(b'0');
            let len = value.len().min(f.size);
            let start = f.size - len;
            dest[start..].copy_from_slice(&value[..len]);
            return;
        }
        self.set_bytes(name, value);
    }

    /// INSPECT CONVERTING with ALPHABET names (e.g., CONVERTING EBCDIC TO ASCII)
    pub fn inspect_converting_alphabet(&mut self, name: &str, from_alphabet: &str, to_alphabet: &str) {
        let idx = match self.idx(name) { Some(i) => i, None => return };
        let f = self.fields[idx].clone();
        let slice = &mut self.data[f.offset..f.offset + f.size];
        crate::string_ops::inspect_converting_alphabet(slice, from_alphabet, to_alphabet, None, None);
    }

    /// INSPECT CONVERTING with ALPHABET names and BEFORE/AFTER INITIAL
    pub fn inspect_converting_alphabet_ba(&mut self, name: &str, from_alphabet: &str, to_alphabet: &str, before: Option<&str>, after: Option<&str>) {
        let idx = match self.idx(name) { Some(i) => i, None => return };
        let f = self.fields[idx].clone();
        let slice = &mut self.data[f.offset..f.offset + f.size];
        crate::string_ops::inspect_converting_alphabet(slice, from_alphabet, to_alphabet, before.map(|s| s.as_bytes()), after.map(|s| s.as_bytes()));
    }
}
