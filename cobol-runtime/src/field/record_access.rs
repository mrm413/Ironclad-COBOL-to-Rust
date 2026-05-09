use rust_decimal::Decimal as RDecimal;
use rust_decimal::prelude::FromPrimitive;

use super::*;

impl CobolRecord {
    /// Get a field's raw bytes
    pub fn get_bytes(&self, name: &str) -> &[u8] {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return &[] };
        let leaf_size = self.leaf_resolve_size.take();
        let size = leaf_size.unwrap_or(self.fields[idx].size);
        &self.data[actual_offset..actual_offset + size]
    }

    /// Set a field's raw bytes (with COBOL padding/truncation rules)
    pub fn set_bytes(&mut self, name: &str, value: &[u8]) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let leaf_size = self.leaf_resolve_size.take();
        let mut f = self.fields[idx].clone();
        f.offset = actual_offset;
        if let Some(ls) = leaf_size {
            f.size = ls;
        } else if !name.contains('(') {
            // Only ODO-limit for plain group references (e.g. "PLINE-TEXT"),
            // NOT for subscripted element access (e.g. "L1-2(2,1)") where
            // GnuCOBOL writes to the physical offset regardless of counter.
            if let Some(meta) = self.odo.get(idx) {
                if meta.own_odo.is_some() {
                    if let Some(odo_size) = self.odo_adjusted_size_by_idx(idx) {
                        f.size = odo_size;
                    }
                }
            }
        }

        match f.field_type {
            FieldType::EditedAlpha(ref pattern) => {
                // Apply alphanumeric edit pattern (0/B// insertion)
                let src_str = String::from_utf8_lossy(value).to_string();
                let formatted = crate::edited_numeric::format_alphanumeric_edited(&src_str, pattern);
                let dest = &mut self.data[f.offset..f.offset + f.size];
                dest.fill(0x20);
                let bytes = formatted.as_bytes();
                let len = bytes.len().min(f.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            FieldType::EditedNumeric(_) => {
                // Parse source bytes as numeric and delegate to set_f64 for proper formatting
                let s = String::from_utf8_lossy(value).trim().to_string();
                let val = s.parse::<f64>().unwrap_or(0.0);
                drop(f);
                self.set_f64(name, val);
            }
            FieldType::AlphaNumeric => {
                // L-var: only write to the active logical portion; bytes beyond lvar_len are untouched.
                let write_size = if let Some(lvar_len) = self.get_lvar_len(name) {
                    lvar_len.min(f.size)
                } else {
                    f.size
                };
                let dest = &mut self.data[f.offset..f.offset + write_size];
                dest.fill(0x20);
                let len = value.len().min(write_size);
                dest[..len].copy_from_slice(&value[..len]);
            }
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                let dest = &mut self.data[f.offset..f.offset + f.size];
                // Right-justify, zero-pad
                dest.fill(b'0');
                let len = value.len().min(f.size);
                let start = f.size - len;
                dest[start..].copy_from_slice(&value[..len]);
            }
            _ => {
                let dest = &mut self.data[f.offset..f.offset + f.size];
                let len = value.len().min(f.size);
                dest[..len].copy_from_slice(&value[..len]);
            }
        }
    }

    /// Resolve a field name to `(offset, size)` — a convenience wrapper
    /// over [`Self::resolve_field`] that returns the live byte size
    /// instead of the descriptor index.
    pub fn field_offset_len(&self, name: &str) -> Option<(usize, usize)> {
        let (idx, off) = self.resolve_field(name)?;
        let leaf = self.leaf_resolve_size.take();
        let size = leaf.unwrap_or(self.fields[idx].size);
        Some((off, size))
    }

    /// Read raw bytes directly from the record's flat storage at `offset`.
    /// Used by EXTFH to dereference FCD-FILENAME-ADDRESS / FCD-RECORD-ADDRESS
    /// pointer targets. Returns an empty slice if out-of-bounds.
    pub fn get_bytes_raw_offset(&self, offset: usize, len: usize) -> &[u8] {
        if offset >= self.data.len() {
            return &[];
        }
        let end = (offset + len).min(self.data.len());
        &self.data[offset..end]
    }

    /// Write raw bytes directly into the record's flat storage at `offset`.
    pub fn set_bytes_raw_offset(&mut self, offset: usize, data: &[u8]) {
        if offset >= self.data.len() {
            return;
        }
        let n = data.len().min(self.data.len() - offset);
        self.data[offset..offset + n].copy_from_slice(&data[..n]);
    }

    /// Set field bytes with null (0x00) padding — used for HP COBOL octal literal assignment
    pub fn set_bytes_null_padded(&mut self, name: &str, value: &[u8]) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let f = &self.fields[idx];
        let size = f.size;
        let dest = &mut self.data[actual_offset..actual_offset + size];
        dest.fill(0x00);
        let len = value.len().min(size);
        dest[..len].copy_from_slice(&value[..len]);
    }

    /// Restore raw bytes into a field without any COBOL formatting — used for
    /// save/restore around recursive UDF calls.
    pub fn restore_raw_bytes(&mut self, name: &str, value: &[u8]) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let f = &self.fields[idx];
        let size = f.size;
        let dest = &mut self.data[actual_offset..actual_offset + size];
        let len = value.len().min(size);
        dest[..len].copy_from_slice(&value[..len]);
    }

    /// Fill a field with a repeating byte pattern (for ALL "x" figurative constant)
    pub fn fill_bytes(&mut self, name: &str, pattern: &[u8]) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let f = &self.fields[idx];
        let size = f.size;
        let dest = &mut self.data[actual_offset..actual_offset + size];
        if pattern.is_empty() { dest.fill(0x20); return; }
        for i in 0..size {
            dest[i] = pattern[i % pattern.len()];
        }
    }

    /// Get field as display string (formatted for output)
    pub fn get_display(&self, name: &str) -> String {
        let upper = name.to_uppercase();
        // Out-of-bounds single subscript on an OCCURS field: GnuCOBOL with
        // default (NOSSRANGE) compilation reads zero-initialized memory and
        // emits NUL bytes for DISPLAY of out-of-range elements. Match that
        // behavior here so DISPLAY X(0) / DISPLAY X(N+1) produce NUL bytes
        // (which the parity normalizer treats as empty), instead of either
        // an empty string (visible newline-only line) or random bytes from
        // an adjacent field.
        if let Some(paren) = upper.find('(') {
            let close = upper.find(')').unwrap_or(upper.len());
            let inner = &upper[paren + 1..close];
            if !inner.contains(',') {
                if let Ok(sub) = inner.parse::<i64>() {
                    let base = &upper[..paren];
                    let base_key = format!("{}(1)", base);
                    if let Some(&base_idx) = self.field_index.get(&base_key) {
                        let bf = &self.fields[base_idx];
                        let max_occurs: i64 = if bf.size > 0 {
                            if let Some(&grp_idx) = self.field_index.get(base) {
                                (self.fields[grp_idx].size / bf.size) as i64
                            } else {
                                i64::MAX
                            }
                        } else {
                            i64::MAX
                        };
                        if sub < 1 || sub > max_occurs {
                            if bounds_check_enabled() {
                                use std::io::Write;
                                let _ = std::io::stdout().flush();
                                let _ = writeln!(
                                    std::io::stderr(),
                                    "libcob: subscript out of bounds: {}({})",
                                    base, sub
                                );
                                std::process::exit(1);
                            }
                            // Bounds check OFF: GnuCOBOL reads raw memory at the
                            // computed offset (which may overlap an adjacent field).
                            // E.g. for `Y PIC X OCCURS 5` followed by `Z PIC X`,
                            // Y(6) reads Z's byte.
                            //
                            // CAVEAT: ODO (OCCURS DEPENDING ON) arrays do NOT do
                            // this — past the static upper bound, GnuCOBOL returns
                            // NUL because the next byte may belong to a separate
                            // 01-level field, not the same parent group. Detect
                            // ODO by checking the array group's odo registry entry.
                            let array_idx = self.field_index.get(base).copied();
                            let is_odo = array_idx
                                .and_then(|i| self.odo.get(i))
                                .map_or(false, |meta| meta.own_odo.is_some());
                            if is_odo {
                                return "\0".repeat(bf.size);
                            }
                            let offset = bf.offset as i64 + (sub - 1) * bf.size as i64;
                            if offset >= 0 {
                                let offset = offset as usize;
                                let end = (offset + bf.size).min(self.data.len());
                                if offset < self.data.len() {
                                    let bytes = &self.data[offset..end];
                                    return String::from_utf8_lossy(bytes).to_string();
                                }
                            }
                            return "\0".repeat(bf.size);
                        }
                    }
                }
            }
        }
        // Use resolve_field for unified ODO handling (including nested ODO)
        let (idx, actual_offset) = match self.resolve_field(name) {
            Some(pair) => pair,
            None => {
                // Subscript overflow/underflow: Y(6) when only Y(1)-Y(5) exist,
                // or Y(0)/Y(-1) for negative/zero subscripts
                if let Some(paren) = upper.find('(') {
                    let close = upper.find(')').unwrap_or(upper.len());
                    let base = &upper[..paren];
                    if let Ok(sub) = upper[paren+1..close].parse::<i64>() {
                        // SSRANGE: abort on out-of-bounds subscript
                        if bounds_check_enabled() {
                            use std::io::Write;
                            let _ = std::io::stdout().flush();
                            let _ = writeln!(std::io::stderr(), "libcob: subscript out of bounds: {}({})", base, sub);
                            std::process::exit(1);
                        }
                        // NOSSRANGE: compute offset from base(1) descriptor and read raw bytes
                        let base_key = format!("{}(1)", base);
                        if let Some(&base_idx) = self.field_index.get(&base_key) {
                            let bf = &self.fields[base_idx];
                            let offset = bf.offset as i64 + (sub - 1) * bf.size as i64;
                            if offset >= 0 {
                                let offset = offset as usize;
                                let end = (offset + bf.size).min(self.data.len());
                                if offset < self.data.len() {
                                    let bytes = &self.data[offset..end];
                                    return String::from_utf8_lossy(bytes).to_string();
                                }
                            }
                        }
                    }
                }
                // Field not found — return empty string instead of panicking
                return String::new();
            }
        };
        let f = &self.fields[idx];

        // ODO SLIDE: for groups containing ODO arrays, COBOL DISPLAY shows only
        // the active (slid) byte range. Writes to ODO arrays already use slid
        // offsets via odo_adjusted_offset, so the bytes between `offset` and
        // `offset+slid_size` are already laid out contiguously and correctly —
        // no per-array compaction is needed (and would in fact double-shift).
        // We rely on the standard `actual_size = odo_adjusted_size(...)` path
        // below to clamp the read to the slid size.
        let _ = f.field_type; // (intentional: no special-case here)

        let actual_size = if let Some(meta) = self.odo.get(idx) {
            if meta.own_odo.is_some() || !meta.size_slides.is_empty() {
                self.odo_adjusted_size(name)
            } else {
                f.size
            }
        } else {
            f.size
        };
        // L-var: truncate output to current logical length
        let actual_size = if let Some(curr_len) = self.get_lvar_len(name) {
            curr_len
        } else {
            actual_size
        };
        let end = (actual_offset + actual_size).min(self.data.len());
        let bytes = &self.data[actual_offset..end];

        // BLANK WHEN ZERO: return spaces if the numeric value is zero
        if f.blank_when_zero {
            let is_zero = match &f.field_type {
                FieldType::NumericDisplay | FieldType::SignedDisplay => {
                    parse_display_numeric_i128(bytes, f.is_signed) == 0
                }
                FieldType::Binary8 => bytes.first().map_or(true, |&b| b == 0),
                FieldType::Binary16 => i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) == 0,
                FieldType::Binary32 => i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) == 0,
                FieldType::Binary64 => i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) == 0,
                _ => false,
            };
            if is_zero {
                return " ".repeat(f.size);
            }
        }

        // POINTER fields display as hex. GnuCOBOL's display width matches the
        // host cobc's pointer width: chocolatey GnuCOBOL 3.2 on Windows is a
        // 32-bit build (8 hex digits); Linux distributions ship 64-bit cobc
        // (16 hex digits). Match the platform convention so v2 Windows goldens
        // and Linux Docker goldens both validate against the same transpiler
        // output. Override via env var IRONCLAD_PTR_WIDTH=4 or =8 at runtime.
        if f.is_pointer {
            let width = if let Ok(w) = std::env::var("IRONCLAD_PTR_WIDTH") {
                match w.as_str() {
                    "4" | "32" => 4usize,
                    "8" | "64" => 8usize,
                    _ => default_pointer_hex_bytes(),
                }
            } else {
                default_pointer_hex_bytes()
            };
            if width == 4 {
                // Take low 4 bytes; little-endian coerce
                let mut buf = [0u8; 4];
                let take = bytes.len().min(4);
                buf[..take].copy_from_slice(&bytes[..take]);
                let val = u32::from_le_bytes(buf);
                return format!("0x{:08x}", val);
            } else {
                let mut buf = [0u8; 8];
                let take = bytes.len().min(8);
                buf[..take].copy_from_slice(&bytes[..take]);
                let val = u64::from_le_bytes(buf);
                return format!("0x{:016x}", val);
            }
        }

        let display = match &f.field_type {
            FieldType::AlphaNumeric => {
                // Treat bytes as Latin-1 (ISO 8859-1): each byte maps to U+00xx
                bytes.iter().map(|&b| b as char).collect::<String>()
            }
            FieldType::NumericDisplay => {
                let val = parse_display_numeric_i128(bytes, false);
                let int_digits = (f.pic_digits.saturating_sub(f.pic_scale)) as usize;
                let dec_digits = f.pic_scale as usize;
                format_i128_display(val, int_digits, dec_digits, false)
            }
            FieldType::SignedDisplay => {
                let val = parse_display_numeric_i128(bytes, true);
                let int_digits = (f.pic_digits.saturating_sub(f.pic_scale)) as usize;
                let dec_digits = f.pic_scale as usize;
                if f.sign_separate {
                    // SIGN IS ... SEPARATE CHARACTER:
                    // Bytes are stored as raw unsigned digits + separate sign byte.
                    // Elementary DISPLAY: emits the implicit decimal point per
                    // GnuCOBOL convention (e.g. PIC SV9(18) = ".999...999-").
                    // Group DISPLAY: reads raw bytes via Group field_type — no
                    // decimal point — which is the correct concat behavior.
                    let negative = val < 0;
                    let abs = val.unsigned_abs();
                    let sign_char = if negative { "-" } else { "+" };
                    let digit_str = if dec_digits > 0 {
                        let divisor = 10u128.pow(dec_digits as u32);
                        let ip = abs / divisor;
                        let dp = abs % divisor;
                        if int_digits == 0 {
                            format!(".{:0>wd$}", dp, wd = dec_digits)
                        } else {
                            format!("{:0>wi$}.{:0>wd$}", ip, dp, wi = int_digits, wd = dec_digits)
                        }
                    } else {
                        format!("{:0>w$}", abs, w = int_digits)
                    };
                    if f.sign_leading {
                        format!("{}{}", sign_char, digit_str)
                    } else {
                        format!("{}{}", digit_str, sign_char)
                    }
                } else {
                    format_i128_display(val, int_digits, dec_digits, true)
                }
            }
            FieldType::Packed => {
                unpack_bcd(bytes, f.pic_scale, f.pic_digits, f.is_signed)
            }
            FieldType::Comp6 => {
                unpack_comp6(bytes, f.pic_scale, f.pic_digits)
            }
            FieldType::Binary8 => {
                let val = if f.is_signed {
                    bytes.first().map_or(0i64, |&b| b as i8 as i64)
                } else {
                    bytes.first().map_or(0i64, |&b| b as i64)
                };
                format_with_scale(val, f.pic_scale, f.pic_digits, f.is_signed)
            }
            FieldType::Binary16 => {
                let val = if f.is_signed {
                    i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                } else {
                    u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                };
                format_with_scale(val, f.pic_scale, f.pic_digits, f.is_signed)
            }
            FieldType::Binary32 => {
                // COMP-X PIC X(3) yields a 3-byte field typed as Binary32.
                // try_into() rejects non-4-byte slices, so widen by left-zero
                // padding so the read still produces a sensible value.
                let mut buf = [0u8; 4];
                let n = bytes.len().min(4);
                buf[4 - n..].copy_from_slice(&bytes[..n]);
                let val = if f.is_signed {
                    i32::from_be_bytes(buf) as i64
                } else {
                    u32::from_be_bytes(buf) as i64
                };
                format_with_scale(val, f.pic_scale, f.pic_digits, f.is_signed)
            }
            FieldType::Binary64 => {
                // Use i128 to avoid overflow for unsigned u64 values > i64::MAX
                let val128: i128 = if f.is_signed {
                    i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else {
                    u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                };
                format_with_scale_i128(val128, f.pic_scale, f.pic_digits, f.is_signed)
            }
            FieldType::Float32 => {
                let val = f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4]));
                format_float_display(val as f64, 8)
            }
            FieldType::Float64 => {
                let val = f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8]));
                format_float_display(val, 16)
            }
            FieldType::FloatDecimal16 => {
                // Read from out-of-band fd_string_values first (full DBig precision);
                // fall back to bytes for legacy / unset fields.
                let stored: String = self.fd_string_values
                    .get(&(idx, actual_offset))
                    .cloned()
                    .unwrap_or_else(|| {
                        let s = String::from_utf8_lossy(bytes);
                        s.trim_end_matches('\0').trim().to_string()
                    });
                if stored.is_empty() || stored == "0" { return "0".to_string(); }
                crate::float_decimal::format_fd16_display(&stored)
            }
            FieldType::FloatDecimal34 => {
                let stored: String = self.fd_string_values
                    .get(&(idx, actual_offset))
                    .cloned()
                    .unwrap_or_else(|| {
                        let s = String::from_utf8_lossy(bytes);
                        s.trim_end_matches('\0').trim().to_string()
                    });
                if stored.is_empty() || stored == "0" { return "0".to_string(); }
                crate::format_fd34_display(&stored)
            }
            FieldType::EditedNumeric(ref pattern) => {
                format_edited_from_bytes(bytes, pattern, f.pic_scale)
            }
            FieldType::EditedAlpha(_) | FieldType::Group => {
                // Treat bytes as Latin-1 (ISO 8859-1): each byte maps to U+00xx
                bytes.iter().map(|&b| b as char).collect::<String>()
            }
        };
        // Apply PIC P display adjustment — only for DISPLAY/Packed types.
        // Binary types (COMP-5) already have p_factor baked into the stored value via set_f64,
        // so their format_with_scale output is already correct without P zeros.
        if f.p_factor != 0 && matches!(f.field_type,
            FieldType::NumericDisplay | FieldType::SignedDisplay | FieldType::Packed | FieldType::Comp6) {
            if f.p_factor < 0 {
                // Trailing P (999PPP): append zeros
                let zeros = "0".repeat((-f.p_factor) as usize);
                format!("{}{}", display, zeros)
            } else {
                // Leading P (VPPP999): prepend "." and P zeros before the decimal digits
                // The display may be "0.128" or ".128" or "+0.128" — extract pure decimal digits
                let pure_digits = if let Some(dot_pos) = display.find('.') {
                    &display[dot_pos + 1..]
                } else {
                    display.trim_start_matches(|c: char| c == '+' || c == '-' || c == '0')
                };
                let zeros = "0".repeat(f.p_factor as usize);
                format!(".{}{}", zeros, pure_digits)
            }
        } else {
            display
        }
    }

    /// Get the unsigned absolute PIC digit display for alphanumeric comparison.
    /// GnuCOBOL's cob_cmp_alnum strips the sign from numeric DISPLAY fields
    /// and converts BINARY/PACKED fields to their PIC digit representation
    /// (no sign, no decimal point) before doing byte-level comparison.
    /// This matches that behavior for mixed numeric-vs-alphanumeric comparisons.
    pub fn get_display_unsigned(&self, name: &str) -> String {
        let (idx, actual_offset) = match self.resolve_field(name) {
            Some(pair) => pair,
            None => return String::new(),
        };
        let f = &self.fields[idx];
        // For numeric types we always use the full physical byte range
        let bytes = &self.data[actual_offset..actual_offset + f.size];
        match &f.field_type {
            FieldType::AlphaNumeric | FieldType::EditedAlpha(_) | FieldType::Group => {
                // L-var: truncate to current logical length (same as get_display)
                let actual_size = if let Some(curr_len) = self.get_lvar_len(name) {
                    curr_len
                } else {
                    f.size
                };
                let end = (actual_offset + actual_size).min(self.data.len());
                // Treat bytes as Latin-1 (ISO 8859-1): each byte maps to U+00xx
                self.data[actual_offset..end].iter().map(|&b| b as char).collect::<String>()
            }
            FieldType::NumericDisplay => {
                // Already unsigned — strip overpunch just in case
                let val = parse_display_numeric_i128(bytes, false);
                let int_digits = f.pic_digits.saturating_sub(f.pic_scale) as usize;
                let dec_digits = f.pic_scale as usize;
                // No decimal point: just concatenate integer + fraction digits
                let total = int_digits + dec_digits;
                format!("{:0>w$}", val.unsigned_abs(), w = total)
            }
            FieldType::SignedDisplay => {
                // Strip sign: use absolute value, output as pure digits
                let val = parse_display_numeric_i128(bytes, true);
                let int_digits = f.pic_digits.saturating_sub(f.pic_scale) as usize;
                let dec_digits = f.pic_scale as usize;
                let total = int_digits + dec_digits;
                format!("{:0>w$}", val.unsigned_abs(), w = total)
            }
            FieldType::Binary8 => {
                let raw = if f.is_signed {
                    (bytes.first().map_or(0i64, |&b| b as i8 as i64)).unsigned_abs()
                } else {
                    bytes.first().map_or(0u64, |&b| b as u64)
                };
                let d = f.pic_digits.max(1) as u32;
                let modulus = 10u64.pow(d);
                let truncated = raw % modulus;
                format!("{:0>w$}", truncated, w = d as usize)
            }
            FieldType::Binary16 => {
                let raw = if f.is_signed {
                    (i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64).unsigned_abs()
                } else {
                    u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as u64
                };
                let d = f.pic_digits.max(1) as u32;
                let modulus = 10u64.pow(d);
                let truncated = raw % modulus;
                format!("{:0>w$}", truncated, w = d as usize)
            }
            FieldType::Binary32 => {
                let raw = if f.is_signed {
                    (i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64).unsigned_abs()
                } else {
                    u32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as u64
                };
                let d = f.pic_digits.max(1) as u32;
                let modulus = 10u64.pow(d);
                let truncated = raw % modulus;
                format!("{:0>w$}", truncated, w = d as usize)
            }
            FieldType::Binary64 => {
                let raw = if f.is_signed {
                    (i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8]))).unsigned_abs() as u128
                } else {
                    u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as u128
                };
                let d = f.pic_digits.max(1) as u32;
                let modulus = 10u128.pow(d);
                let truncated = raw % modulus;
                format!("{:0>w$}", truncated, w = d as usize)
            }
            FieldType::Packed => {
                let val = unpack_bcd_i128(bytes, f.is_signed);
                let total = f.pic_digits.max(1) as usize;
                format!("{:0>w$}", val.unsigned_abs(), w = total)
            }
            FieldType::Comp6 => {
                // COMP-6 is unsigned packed; use regular display
                self.get_display(name)
            }
            _ => {
                // Float, edited, etc. — fall back to regular display
                self.get_display(name)
            }
        }
    }

    /// Get raw field bytes as string (no formatting — for EXAMINE/INSPECT on raw storage).
    /// For numeric display fields, returns the actual stored bytes including overpunch encoding.
    pub fn get_raw_string(&self, name: &str) -> String {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = &self.fields[idx];
        let bytes = &self.data[f.offset..f.offset + f.size];
        String::from_utf8_lossy(bytes).to_string()
    }

    /// Set raw bytes from string (direct byte copy — for EXAMINE/INSPECT writeback).
    /// Preserves sign encoding naturally since overpunched bytes are copied unchanged.
    pub fn set_raw_string(&mut self, name: &str, value: &str) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();
        let dest = &mut self.data[f.offset..f.offset + f.size];
        let vb = value.as_bytes();
        let len = vb.len().min(f.size);
        dest[..len].copy_from_slice(&vb[..len]);
    }

    /// Get field as i64 (for arithmetic)
    pub fn get_i64(&self, name: &str) -> i64 {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return Default::default() };
        let f = &self.fields[idx];
        let bytes = &self.data[actual_offset..actual_offset + f.size];

        match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                parse_display_numeric(bytes, f.is_signed)
            }
            FieldType::Binary8 => {
                let raw = if f.is_signed {
                    bytes.first().map_or(0i64, |&b| b as i8 as i64)
                } else {
                    bytes.first().map_or(0i64, |&b| b as i64)
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    (raw.abs() % modulus) * sign
                } else { raw }
            }
            FieldType::Binary16 => {
                let raw = if f.is_signed {
                    i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                } else {
                    u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    (raw.abs() % modulus) * sign
                } else { raw }
            }
            FieldType::Binary32 => {
                let raw = if f.is_signed {
                    i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64
                } else {
                    u32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    (raw.abs() % modulus) * sign
                } else { raw }
            }
            FieldType::Binary64 => {
                // POINTER fields use LE encoding; regular Binary64 uses BE
                let raw128: i128 = if f.is_pointer {
                    u64::from_le_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else if f.is_signed {
                    i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else {
                    u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                };
                if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if raw128 < 0 { -1i128 } else { 1i128 };
                    ((raw128.abs() % modulus) * sign) as i64
                } else { raw128 as i64 }
            }
            FieldType::Packed => unpack_bcd_i64(bytes, f.is_signed),
            FieldType::Comp6 => unpack_comp6_i64(bytes),
            FieldType::Float32 => f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64,
            FieldType::Float64 => f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i64,
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                let s = String::from_utf8_lossy(bytes);
                s.trim_end_matches('\0').trim().parse::<f64>().unwrap_or(0.0) as i64
            }
            FieldType::AlphaNumeric => {
                String::from_utf8_lossy(bytes).trim().parse().unwrap_or(0)
            }
            _ => 0,
        }
    }

    /// Set field from i64 (for arithmetic results)
    pub fn set_i64(&mut self, name: &str, value: i64) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return Default::default() };
        let f = self.fields[idx].clone();
        let dest = &mut self.data[actual_offset..actual_offset + f.size];

        match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                write_display_numeric_ext(dest, value, f.pic_digits, f.is_signed, f.sign_leading, f.sign_separate);
            }
            FieldType::Binary8 => dest.copy_from_slice(&[(value as u8)]),
            FieldType::Binary16 => dest.copy_from_slice(&(value as i16).to_be_bytes()),
            FieldType::Binary32 => dest.copy_from_slice(&(value as i32).to_be_bytes()),
            FieldType::Binary64 => {
                // POINTER fields use LE encoding; regular Binary64 uses BE
                if f.is_pointer {
                    dest.copy_from_slice(&(value as u64).to_le_bytes());
                } else {
                    dest.copy_from_slice(&value.to_be_bytes());
                }
            }
            FieldType::Packed => pack_bcd(dest, value as i128, f.is_signed),
            FieldType::Comp6 => pack_comp6(dest, value as i128),
            FieldType::Float32 => dest.copy_from_slice(&(value as f32).to_be_bytes()),
            FieldType::Float64 => dest.copy_from_slice(&(value as f64).to_be_bytes()),
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                let s = format!("{}", value);
                dest.fill(0);
                let bytes = s.as_bytes();
                let len = bytes.len().min(f.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            _ => {}
        }
    }

    /// Get field as f64 (for COMPUTE and decimal arithmetic)
    pub fn get_f64(&self, name: &str) -> f64 {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return Default::default() };
        let f = &self.fields[idx];
        let bytes = &self.data[actual_offset..actual_offset + f.size];
        let result = match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                // Use i128 to avoid overflow for > 18-digit fields
                let raw = parse_display_numeric_i128(bytes, f.is_signed);
                if f.pic_scale > 0 {
                    raw as f64 / 10f64.powi(f.pic_scale as i32)
                } else {
                    raw as f64
                }
            }
            FieldType::Binary8 => {
                let mut raw = if f.is_signed {
                    bytes.first().map_or(0i64, |&b| b as i8 as i64)
                } else {
                    bytes.first().map_or(0i64, |&b| b as i64)
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    raw = (raw.abs() % modulus) * sign;
                }
                let fval = raw as f64;
                if f.pic_scale > 0 { fval / 10f64.powi(f.pic_scale as i32) } else { fval }
            }
            FieldType::Binary16 => {
                let mut raw = if f.is_signed {
                    i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                } else {
                    u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    raw = (raw.abs() % modulus) * sign;
                }
                let fval = raw as f64;
                if f.pic_scale > 0 { fval / 10f64.powi(f.pic_scale as i32) } else { fval }
            }
            FieldType::Binary32 => {
                // Pad to 4 bytes for non-standard sizes (PIC X(3) COMP-X is
                // typed Binary32 but only stores 3 bytes).
                let mut buf = [0u8; 4];
                let n = bytes.len().min(4);
                buf[4 - n..].copy_from_slice(&bytes[..n]);
                let mut raw = if f.is_signed {
                    i32::from_be_bytes(buf) as i64
                } else {
                    u32::from_be_bytes(buf) as i64
                };
                if f.pic_digits > 0 {
                    let modulus = 10i64.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i64 } else { 1i64 };
                    raw = (raw.abs() % modulus) * sign;
                }
                let fval = raw as f64;
                if f.pic_scale > 0 { fval / 10f64.powi(f.pic_scale as i32) } else { fval }
            }
            FieldType::Binary64 => {
                // POINTER fields use LE encoding; regular Binary64 uses BE
                let mut raw: i128 = if f.is_pointer {
                    u64::from_le_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else if f.is_signed {
                    i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else {
                    u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                };
                if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if raw < 0 { -1i128 } else { 1i128 };
                    raw = (raw.abs() % modulus) * sign;
                }
                let fval = raw as f64;
                if f.pic_scale > 0 { fval / 10f64.powi(f.pic_scale as i32) } else { fval }
            }
            FieldType::Packed => {
                let raw = unpack_bcd_i64(bytes, f.is_signed) as f64;
                if f.pic_scale > 0 { raw / 10f64.powi(f.pic_scale as i32) } else { raw }
            }
            FieldType::Comp6 => {
                let raw = unpack_comp6_i128(bytes) as f64;
                if f.pic_scale > 0 { raw / 10f64.powi(f.pic_scale as i32) } else { raw }
            }
            FieldType::Float32 => {
                let v = f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4]));
                // Use exact f32-to-f64 promotion (bit-preserving).
                // The previous string roundtrip (`format!("{}", v).parse::<f64>()`)
                // introduced tiny errors that accumulated across iterative
                // COMPUTE loops (e.g., CMP1 = CMP1 * 10 repeated 6500 times),
                // causing the final value to diverge from GnuCOBOL.
                v as f64
            }
            FieldType::Float64 => f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])),
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                // Parse stored string representation to f64
                let s = String::from_utf8_lossy(bytes);
                let trimmed = s.trim_end_matches('\0').trim().to_string();
                trimmed.parse::<f64>().unwrap_or(0.0)
            }
            FieldType::AlphaNumeric => {
                String::from_utf8_lossy(bytes).trim().parse().unwrap_or(0.0)
            }
            FieldType::EditedNumeric(ref pat) => {
                // Parse numeric value from edited display bytes using de-edit
                let s = String::from_utf8_lossy(bytes).to_string();
                let decimal_comma = pat.starts_with('~');
                let eff_pat = if decimal_comma { &pat[1..] } else { pat.as_str() };
                let mut val = de_edit_to_f64_ex(&s, decimal_comma);
                // COBOL de-editing: PIC '+' and PIC 'DB' lose sign; PIC '-' and PIC 'CR' preserve it
                let pat_upper = eff_pat.to_uppercase();
                let loses_sign = pat_upper.starts_with('+') || pat_upper.ends_with("DB");
                if loses_sign { val = val.abs(); }
                // Handle implied decimal 'V': divide by 10^(decimal digits after V)
                if let Some(v_idx) = pat_upper.find('V') {
                    // Count only digit positions after V, not trailing sign characters.
                    // Strip CR/DB suffix, then count only up to any trailing single +/-
                    let after_v = pat_upper[v_idx+1..].trim_end_matches("CR").trim_end_matches("DB");
                    let after_v = after_v.trim_end_matches(|c: char| c == '+' || c == '-');
                    let v_dec = after_v.chars()
                        .filter(|c| matches!(c, '9' | 'Z' | '*'))
                        .count();
                    if v_dec > 0 { val /= 10f64.powi(v_dec as i32); }
                }
                val
            }
            FieldType::EditedAlpha(_) => {
                // Parse numeric value from edited display bytes:
                // Strip all non-digit/sign chars, then parse
                let s = String::from_utf8_lossy(bytes);
                let mut negative = false;
                let mut digits = String::new();
                let mut has_dot = false;
                for ch in s.chars() {
                    match ch {
                        '-' => negative = true,
                        '+' => {}
                        '0'..='9' => digits.push(ch),
                        '.' => { digits.push('.'); has_dot = true; }
                        _ => {}
                    }
                }
                // Handle CR/DB as negative indicators
                if s.contains("CR") || s.contains("DB") {
                    negative = true;
                }
                if digits.is_empty() { return 0.0; }
                let val: f64 = digits.parse().unwrap_or(0.0);
                let val = if negative { -val } else { val };
                // Apply pic_scale if no decimal point was present in the edited string
                if !has_dot && f.pic_scale > 0 {
                    val / 10f64.powi(f.pic_scale as i32)
                } else {
                    val
                }
            }
            _ => 0.0,
        };
        // Apply PIC P scaling factor
        if f.p_factor != 0 {
            if f.p_factor < 0 {
                // Trailing P (999PPP): multiply stored value by 10^|p_factor|
                result * 10f64.powi((-f.p_factor) as i32)
            } else {
                // Leading P (VPPP999): divide by additional 10^p_factor
                result / 10f64.powi(f.p_factor as i32)
            }
        } else {
            result
        }
    }

    /// GnuCOBOL "fast-compare" for same-type DISPLAY numeric fields.
    /// When both fields are DISPLAY numeric with the same sign and same scale,
    /// GnuCOBOL compares raw bytes (memcmp). This means space-filled fields
    /// (0x20...) compare as LESS THAN zero-filled fields (0x30...).
    /// Falls back to numeric comparison for mismatched types.
    pub fn cmp_same_numeric_display(&self, a_name: &str, b_name: &str) -> i64 {
        let (ai, a_off) = match self.resolve_field(a_name) { Some(v) => v, None => return 0 };
        let (bi, b_off) = match self.resolve_field(b_name) { Some(v) => v, None => return 0 };
        let af = &self.fields[ai];
        let bf = &self.fields[bi];
        let a_is_display = matches!(af.field_type, FieldType::NumericDisplay | FieldType::SignedDisplay);
        let b_is_display = matches!(bf.field_type, FieldType::NumericDisplay | FieldType::SignedDisplay);
        if a_is_display && b_is_display && af.is_signed == bf.is_signed && af.size == bf.size && af.pic_scale == bf.pic_scale {
            let a_bytes = &self.data[a_off..a_off + af.size];
            let b_bytes = &self.data[b_off..b_off + bf.size];
            return match a_bytes.cmp(b_bytes) {
                std::cmp::Ordering::Less => -1,
                std::cmp::Ordering::Equal => 0,
                std::cmp::Ordering::Greater => 1,
            };
        }
        // When both sides have a decimal scale (PIC ...V9...), use exact Decimal
        // comparison to avoid f64 precision quirks at the OVERLIMIT boundary.
        if (a_is_display || matches!(af.field_type, FieldType::Packed | FieldType::Comp6))
            && (b_is_display || matches!(bf.field_type, FieldType::Packed | FieldType::Comp6))
            && (af.pic_scale > 0 || bf.pic_scale > 0)
        {
            let av = crate::field_ops::read_as_decimal(self, a_name);
            let bv = crate::field_ops::read_as_decimal(self, b_name);
            return match av.cmp(&bv) {
                std::cmp::Ordering::Less => -1,
                std::cmp::Ordering::Equal => 0,
                std::cmp::Ordering::Greater => 1,
            };
        }
        // Different types or sizes with no scale: use numeric f64 comparison
        let av = self.get_f64(a_name);
        let bv = self.get_f64(b_name);
        if av < bv { -1 } else if av > bv { 1 } else { 0 }
    }

    /// Read field value as i128 — direct grid pointer access with NO f64 precision loss.
    /// This is the integer arithmetic path: reads raw bytes from the flat grid at the field's
    /// offset, interprets as integer, applies COMP pic_digits truncation.
    /// Use for COMPUTE/ADD/SUBTRACT/MULTIPLY/DIVIDE on binary integer fields.
    pub fn get_i128(&self, name: &str) -> i128 {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return 0 };
        let f = &self.fields[idx];
        let bytes = &self.data[actual_offset..actual_offset + f.size];
        let raw: i128 = match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                parse_display_numeric_i128(bytes, f.is_signed)
            }
            FieldType::Binary8 => {
                if f.is_signed {
                    bytes.first().map_or(0i128, |&b| b as i8 as i128)
                } else {
                    bytes.first().map_or(0i128, |&b| b as i128)
                }
            }
            FieldType::Binary16 => {
                if f.is_signed {
                    i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i128
                } else {
                    u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i128
                }
            }
            FieldType::Binary32 => {
                if f.is_signed {
                    i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128
                } else {
                    u32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128
                }
            }
            FieldType::Binary64 => {
                if f.is_signed {
                    i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                } else {
                    u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
                }
            }
            FieldType::Packed => {
                unpack_bcd_i64(bytes, f.is_signed) as i128
            }
            FieldType::Comp6 => {
                unpack_comp6_i128(bytes)
            }
            FieldType::Float32 => f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128,
            FieldType::Float64 => f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128,
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                let s = String::from_utf8_lossy(bytes);
                s.trim_end_matches('\0').trim().parse::<f64>().unwrap_or(0.0) as i128
            }
            FieldType::AlphaNumeric | FieldType::Group => {
                String::from_utf8_lossy(bytes).trim().parse::<i128>().unwrap_or(0)
            }
            _ => 0,
        };
        // Apply COMP pic_digits truncation (binary-truncate semantics)
        if f.pic_digits > 0 {
            let modulus = 10i128.pow(f.pic_digits as u32);
            let sign = if raw < 0 { -1i128 } else { 1i128 };
            (raw.abs() % modulus) * sign
        } else {
            raw
        }
    }

    /// Write i128 value directly to the byte grid — no f64 intermediate, no precision loss.
    /// Applies COMP pic_digits truncation and writes raw bytes at field offset.
    pub fn set_i128(&mut self, name: &str, value: i128) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let mut f = self.fields[idx].clone();
        f.offset = actual_offset;

        // Apply pic_digits truncation (COMP binary-truncate)
        let mantissa = if f.pic_digits > 0 {
            let modulus = 10i128.pow(f.pic_digits as u32);
            let sign = if value < 0 { -1i128 } else { 1i128 };
            (value.abs() % modulus) * sign
        } else {
            value
        };
        // Unsigned fields: drop sign
        let mantissa = if !f.is_signed && mantissa < 0 { mantissa.abs() } else { mantissa };

        let dest = &mut self.data[f.offset..f.offset + f.size];
        match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                write_display_numeric_i128_ext(dest, mantissa, f.pic_digits, f.is_signed, f.sign_leading, f.sign_separate);
            }
            FieldType::Binary8 => {
                dest.copy_from_slice(&[(mantissa as u8)]);
            }
            FieldType::Binary16 => {
                dest.copy_from_slice(&(mantissa as i16).to_be_bytes());
            }
            FieldType::Binary32 => {
                dest.copy_from_slice(&(mantissa as i32).to_be_bytes());
            }
            FieldType::Binary64 => {
                if !f.is_signed && mantissa >= 0 {
                    dest.copy_from_slice(&(mantissa as u64).to_be_bytes());
                } else {
                    dest.copy_from_slice(&(mantissa as i64).to_be_bytes());
                }
            }
            FieldType::Packed => {
                pack_bcd(dest, mantissa, f.is_signed);
            }
            FieldType::Comp6 => {
                pack_comp6(dest, mantissa.abs());
            }
            FieldType::Float32 => {
                dest.copy_from_slice(&(mantissa as f32).to_be_bytes());
            }
            FieldType::Float64 => {
                dest.copy_from_slice(&(mantissa as f64).to_be_bytes());
            }
            FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                let s = format!("{}", mantissa);
                dest.fill(0);
                let bytes = s.as_bytes();
                let len = bytes.len().min(f.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            _ => {}
        }
    }

    /// Set field from f64 (for COMPUTE and decimal arithmetic results)
    /// Automatically scales to match field's pic_scale
    pub fn set_f64(&mut self, name: &str, value: f64) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return Default::default() };
        let mut f = self.fields[idx].clone();
        f.offset = actual_offset;

        // Float types: store directly without decimal conversion
        if matches!(f.field_type, FieldType::Float32) {
            let dest = &mut self.data[f.offset..f.offset + f.size];
            dest.copy_from_slice(&(value as f32).to_be_bytes());
            return;
        }
        if matches!(f.field_type, FieldType::Float64) {
            let dest = &mut self.data[f.offset..f.offset + f.size];
            dest.copy_from_slice(&value.to_be_bytes());
            return;
        }
        if matches!(f.field_type, FieldType::FloatDecimal16 | FieldType::FloatDecimal34) {
            // Store as string representation of f64 value. Lossy beyond ~17
            // digits, but for set_f64 callers (MOVE literal, INITIALIZE) the
            // f64 itself is the limiting factor. For full-precision stores
            // (arithmetic results), use set_fd16_str/set_fd34_str directly.
            let s = if value == 0.0 { "0".to_string() } else { format!("{}", value) };
            self.fd_string_values.insert((idx, f.offset), s.clone());
            let dest = &mut self.data[f.offset..f.offset + f.size];
            dest.fill(0);
            let bytes = s.as_bytes();
            let len = bytes.len().min(f.size);
            dest[..len].copy_from_slice(&bytes[..len]);
            return;
        }

        // Apply PIC P scaling: convert COBOL value to storage value
        let value = if f.p_factor < 0 {
            // Trailing P (999PPP): stored = value / 10^|p_factor|
            value / 10f64.powi((-f.p_factor) as i32)
        } else if f.p_factor > 0 {
            // Leading P (VPPP999): stored = value * 10^p_factor
            value * 10f64.powi(f.p_factor as i32)
        } else {
            value
        };

        // All other types: use Decimal for precise scaling (avoids f64 rounding artifacts)
        // rust_decimal has a 96-bit mantissa (~28 significant digits).
        // When pic_scale > 18, the total digits needed can exceed 28, causing
        // rescale() to silently truncate the most-significant digits.
        // In that case, fall back to f64 arithmetic which preserves ~15-16 digits.
        let mantissa = if f.pic_scale > 18 {
            let scaled = value * 10f64.powi(f.pic_scale as i32);
            scaled as i128
        } else {
            // Use truncation (not rounding) to match COBOL default arithmetic.
            // rescale() rounds, so we manually truncate via integer division.
            let dec_val = RDecimal::from_f64(value).unwrap_or(RDecimal::ZERO);
            let current_scale = dec_val.scale();
            let m = dec_val.mantissa();
            let target_scale = f.pic_scale as u32;
            if current_scale <= target_scale {
                let factor = 10i128.pow(target_scale - current_scale);
                m * factor
            } else {
                let factor = 10i128.pow(current_scale - target_scale);
                if m >= 0 { m / factor } else { -((-m) / factor) }
            }
        };

        // Unsigned fields: drop sign (COBOL stores absolute value in unsigned fields)
        let mantissa = if !f.is_signed && mantissa < 0 { mantissa.abs() } else { mantissa };
        let dest = &mut self.data[f.offset..f.offset + f.size];
        match f.field_type {
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                write_display_numeric_i128_ext(dest, mantissa, f.pic_digits, f.is_signed, f.sign_leading, f.sign_separate);
            }
            FieldType::Binary8 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&[(trunc as u8)]);
            }
            FieldType::Binary16 => {
                // Binary truncation: truncate to pic_digits (COBOL -fbinary-truncate)
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&(trunc as i16).to_be_bytes());
            }
            FieldType::Binary32 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&(trunc as i32).to_be_bytes());
            }
            FieldType::Binary64 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                // POINTER fields use LE encoding; regular Binary64 uses BE
                if f.is_pointer {
                    dest.copy_from_slice(&(trunc as u64).to_le_bytes());
                } else if !f.is_signed && trunc >= 0 {
                    dest.copy_from_slice(&(trunc as u64).to_be_bytes());
                } else {
                    dest.copy_from_slice(&(trunc as i64).to_be_bytes());
                }
            }
            FieldType::Packed => {
                // Truncate to pic_digits for packed too
                let modulus = 10i128.pow(f.pic_digits as u32);
                let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                let trunc = (mantissa.abs() % modulus) * sign;
                pack_bcd(dest, trunc, f.is_signed);
            }
            FieldType::Comp6 => {
                let modulus = 10i128.pow(f.pic_digits as u32);
                let trunc = mantissa.abs() % modulus;
                pack_comp6(dest, trunc);
            }
            FieldType::AlphaNumeric | FieldType::Group => {
                let s = if f.pic_scale > 0 {
                    let abs = mantissa.unsigned_abs();
                    let factor = 10u128.pow(f.pic_scale as u32);
                    let int_part = abs / factor;
                    let dec_part = abs % factor;
                    let sign = if mantissa < 0 { "-" } else { "" };
                    format!("{}{}.{:0>width$}", sign, int_part, dec_part, width = f.pic_scale as usize)
                } else {
                    format!("{}", mantissa)
                };
                dest.fill(0x20);
                let bytes = s.as_bytes();
                let len = bytes.len().min(f.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            FieldType::EditedNumeric(ref pattern) => {
                // Truncate to the pattern's decimal places before formatting.
                // Count decimal digits in pattern (digit positions after decimal separator).
                // With '~' prefix (DECIMAL-POINT IS COMMA), ',' is the decimal separator.
                // Strip custom currency prefix forms:
                //   @X@<rest>            single-char custom currency
                //   @X=<string>@<rest>   multi-char currency (with PICTURE SYMBOL)
                let dc = pattern.starts_with('~');
                let mut eff_pat = if dc { &pattern[1..] } else { pattern.as_str() };
                if let Some(rest) = eff_pat.strip_prefix('@') {
                    if let Some(eq_idx) = rest.find('=') {
                        if let Some(at_idx) = rest[eq_idx+1..].find('@') {
                            // Skip past the closing '@' of the multi-char form
                            let consumed = 1 + eq_idx + 1 + at_idx + 1;
                            eff_pat = &eff_pat[consumed..];
                        }
                    } else if rest.len() >= 2 && rest.as_bytes()[1] == b'@' {
                        eff_pat = &eff_pat[3..];
                    }
                }
                // Strip implied-decimal V from the digit-counting view: digits after
                // V/'.'/',' (in dc mode) all count as decimal positions for truncation.
                let dec_sep = if dc { ',' } else { '.' };
                let dp = eff_pat.find(dec_sep).or_else(|| eff_pat.find(|c: char| c == 'V' || c == 'v'));
                let n_dec = dp.map_or(0, |p| {
                    eff_pat[p+1..].chars().filter(|c| matches!(c, '9'|'Z'|'*'|'+'|'-'|'$')).count()
                });
                let trunc_value = if n_dec > 0 {
                    let factor = 10f64.powi(n_dec as i32);
                    (value * factor).trunc() / factor
                } else {
                    value.trunc()
                };
                let formatted = format_edited_from_f64(trunc_value, pattern, &f);
                dest.fill(0x20);
                let bytes = formatted.as_bytes();
                let len = bytes.len().min(f.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
            _ => {}
        }
    }

    /// Store a precise decimal string (e.g. "1.80750052110824343510150043852321026")
    /// into a field WITHOUT f64 precision loss. For HighPrecision intrinsics → Packed/Display.
    pub fn set_decimal_str(&mut self, name: &str, s: &str) {
        let idx = match self.idx(name) { Some(i) => i, None => return Default::default() };
        let f = self.fields[idx].clone();

        // Parse the decimal string into an i128 mantissa at the field's pic_scale
        let trimmed = s.trim();
        let negative = trimmed.starts_with('-');
        let abs_s = trimmed.trim_start_matches('-');
        let (int_part, frac_part) = if let Some(dot) = abs_s.find('.') {
            (&abs_s[..dot], &abs_s[dot + 1..])
        } else {
            (abs_s, "")
        };

        let scale = f.pic_scale as usize;
        let mantissa_str = if frac_part.len() >= scale {
            format!("{}{}", int_part, &frac_part[..scale])
        } else {
            format!("{}{}{}", int_part, frac_part, "0".repeat(scale - frac_part.len()))
        };

        let mantissa: i128 = mantissa_str.parse().unwrap_or(0);
        let mantissa = if negative { -mantissa } else { mantissa };

        let dest = &mut self.data[f.offset..f.offset + f.size];
        match f.field_type {
            FieldType::Packed => pack_bcd(dest, mantissa, f.is_signed),
            FieldType::Comp6 => pack_comp6(dest, mantissa.abs()),
            FieldType::NumericDisplay | FieldType::SignedDisplay => {
                write_display_numeric_i128_ext(dest, mantissa, f.pic_digits, f.is_signed, f.sign_leading, f.sign_separate);
            }
            FieldType::Binary8 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&[(trunc as u8)]);
            }
            FieldType::Binary16 => {
                // Truncate mantissa to fit PIC digits, then store as i16
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&(trunc as i16).to_be_bytes());
            }
            FieldType::Binary32 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                dest.copy_from_slice(&(trunc as i32).to_be_bytes());
            }
            FieldType::Binary64 => {
                let trunc = if f.pic_digits > 0 {
                    let modulus = 10i128.pow(f.pic_digits as u32);
                    let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                    (mantissa.abs() % modulus) * sign
                } else { mantissa };
                if !f.is_signed && trunc >= 0 {
                    dest.copy_from_slice(&(trunc as u64).to_be_bytes());
                } else {
                    dest.copy_from_slice(&(trunc as i64).to_be_bytes());
                }
            }
            _ => {
                // Fallback for other types: parse as f64
                // For Float fields, GnuCOBOL stores the literal via libcob's
                // mpz/mpf path which truncates toward zero (mpz_get_d semantics).
                // Round-to-nearest f64 parsing can give a value 1 ULP further from
                // zero than GnuCOBOL's stored value. Match by truncating toward zero.
                let val: f64 = trimmed.parse().unwrap_or(0.0);
                let val = if matches!(f.field_type, FieldType::Float32 | FieldType::Float64)
                    && val != 0.0 && val.is_finite()
                {
                    f64_truncate_toward_zero(val, trimmed)
                } else {
                    val
                };
                drop(dest);
                self.set_f64(name, val);
            }
        }
    }

    /// Get the raw string representation of a FLOAT-DECIMAL-34 field.
    /// Reads from the out-of-band fd_string_values map first (full DBig precision);
    /// falls back to bytes for legacy programs that wrote into the buffer directly.
    pub fn get_fd34_str(&self, name: &str) -> String {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return "0".into() };
        if let Some(s) = self.fd_string_values.get(&(idx, actual_offset)) {
            return if s.is_empty() { "0".to_string() } else { s.clone() };
        }
        let f = &self.fields[idx];
        let bytes = &self.data[actual_offset..actual_offset + f.size];
        let s = String::from_utf8_lossy(bytes);
        let trimmed = s.trim_end_matches('\0').trim();
        if trimmed.is_empty() { "0".to_string() } else { trimmed.to_string() }
    }

    /// Set a FLOAT-DECIMAL-34 field from a string representation.
    /// Stores the canonical value in the out-of-band fd_string_values map for
    /// full IEEE 754 decimal128 exponent range (the COBOL-spec 16-byte slot
    /// is far too small to hold "9.9999999999999999999999999999999999E+6111"
    /// as a string). Also writes a truncated copy into the byte buffer for
    /// any legacy code paths or REDEFINES overlays that read raw bytes.
    pub fn set_fd34_str(&mut self, name: &str, value: &str) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let f = &self.fields[idx];
        // Out-of-band canonical store
        self.fd_string_values.insert((idx, actual_offset), value.to_string());
        // Best-effort byte-buffer copy (truncated)
        let dest = &mut self.data[actual_offset..actual_offset + f.size];
        dest.fill(0);
        let bytes = value.as_bytes();
        let len = bytes.len().min(f.size);
        dest[..len].copy_from_slice(&bytes[..len]);
    }

    /// Get a FLOAT-DECIMAL-16 field as a string. See get_fd34_str for storage notes.
    pub fn get_fd16_str(&self, name: &str) -> String {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return "0".into() };
        if let Some(s) = self.fd_string_values.get(&(idx, actual_offset)) {
            return if s.is_empty() { "0".to_string() } else { s.clone() };
        }
        let f = &self.fields[idx];
        let bytes = &self.data[actual_offset..actual_offset + f.size];
        let s = String::from_utf8_lossy(bytes);
        let trimmed = s.trim_end_matches('\0').trim();
        if trimmed.is_empty() { "0".to_string() } else { trimmed.to_string() }
    }

    /// Set a FLOAT-DECIMAL-16 field from a string representation.
    /// See set_fd34_str for storage notes.
    pub fn set_fd16_str(&mut self, name: &str, value: &str) {
        let (idx, actual_offset) = match self.resolve_field(name) { Some(v) => v, None => return };
        let f = &self.fields[idx];
        self.fd_string_values.insert((idx, actual_offset), value.to_string());
        let dest = &mut self.data[actual_offset..actual_offset + f.size];
        dest.fill(0);
        let bytes = value.as_bytes();
        let len = bytes.len().min(f.size);
        dest[..len].copy_from_slice(&bytes[..len]);
    }
}

/// Truncate `val` toward zero so it matches GnuCOBOL's libcob/GMP `mpz_get_d`
/// behavior when storing a literal into a Float field.
///
/// Return the platform-default POINTER hex display width in bytes.
/// On Windows hosts: 4 bytes (8 hex digits) — matches the chocolatey 32-bit
/// GnuCOBOL 3.2 we generate v2 corpus goldens against. On other hosts (Linux,
/// macOS): 8 bytes (16 hex digits) — matches Linux 64-bit cobc.
fn default_pointer_hex_bytes() -> usize {
    #[cfg(target_os = "windows")]
    { 4 }
    #[cfg(not(target_os = "windows"))]
    { 8 }
}

/// IEEE-754 round-to-nearest can produce a value 1 ULP further from zero than
/// the exact decimal `literal` would round to under truncation. This helper
/// detects that case (by formatting `val` to high precision and lexically
/// comparing the implied exact decimal against `literal`) and adjusts `val`
/// downward (toward zero) by 1 ULP.
fn f64_truncate_toward_zero(val: f64, literal: &str) -> f64 {
    let cmp = compare_f64_to_literal_abs(val, literal);
    if cmp > 0 {
        // |val| > |literal|: move val one ULP toward zero
        let bits = val.to_bits();
        let new_bits = if val > 0.0 { bits - 1 } else { bits - 1 };
        f64::from_bits(new_bits)
    } else {
        val
    }
}

/// Compare |val| (an f64) to |literal| (a decimal numeric string, possibly in
/// scientific notation). Returns 1 if |val| > |literal|, -1 if <, 0 if equal.
fn compare_f64_to_literal_abs(val: f64, literal: &str) -> i32 {
    // Normalize literal: strip sign, split into mantissa digits + exponent.
    let lit = literal.trim();
    let lit = lit.trim_start_matches(|c: char| c == '+' || c == '-');
    let (lit_mant_part, lit_exp) = match lit.find(|c: char| c == 'E' || c == 'e') {
        Some(i) => {
            let mant = &lit[..i];
            let exp_str = &lit[i + 1..];
            let exp_str = exp_str.trim_start_matches('+');
            let exp: i32 = exp_str.parse().unwrap_or(0);
            (mant, exp)
        }
        None => (lit, 0i32),
    };
    let lit_norm = normalize_decimal_to_sci(lit_mant_part, lit_exp);

    // Format f64 absolute value with 17 sig digits in scientific notation
    let abs = val.abs();
    let formatted = format!("{:.17E}", abs);
    let val_norm = match formatted.find(|c: char| c == 'E' || c == 'e') {
        Some(i) => {
            let mant = &formatted[..i];
            let exp_str = &formatted[i + 1..];
            let exp_str = exp_str.trim_start_matches('+');
            let exp: i32 = exp_str.parse().unwrap_or(0);
            normalize_decimal_to_sci(mant, exp)
        }
        None => normalize_decimal_to_sci(&formatted, 0),
    };

    // Compare exponents first
    if val_norm.0 != lit_norm.0 {
        return if val_norm.0 > lit_norm.0 { 1 } else { -1 };
    }
    // Same exponent: compare digit strings (left-aligned, pad with '0')
    let max_len = val_norm.1.len().max(lit_norm.1.len());
    let val_digits: String = val_norm.1.chars().chain(std::iter::repeat('0')).take(max_len).collect();
    let lit_digits: String = lit_norm.1.chars().chain(std::iter::repeat('0')).take(max_len).collect();
    if val_digits > lit_digits { 1 } else if val_digits < lit_digits { -1 } else { 0 }
}

/// Normalize a positive decimal mantissa string (possibly with '.') and a
/// base-10 exponent into (sci_exponent, digit_string) where digit_string has
/// no leading zeros and represents `digit_string * 10^(sci_exponent - len + 1)`
/// (i.e. first digit is in the 10^sci_exponent place).
fn normalize_decimal_to_sci(mant: &str, exp: i32) -> (i32, String) {
    let mant = mant.trim();
    let (int_part, frac_part) = match mant.find('.') {
        Some(i) => (&mant[..i], &mant[i + 1..]),
        None => (mant, ""),
    };
    let mut digits: String = int_part.chars().chain(frac_part.chars())
        .filter(|c| c.is_ascii_digit()).collect();
    // Initial exponent of the leading digit
    let mut lead_exp = (int_part.len() as i32) - 1 + exp;
    // Strip leading zeros and adjust exponent
    while digits.starts_with('0') && digits.len() > 1 {
        digits.remove(0);
        lead_exp -= 1;
    }
    // Strip trailing zeros (not needed for comparison since we pad)
    while digits.len() > 1 && digits.ends_with('0') {
        digits.pop();
    }
    if digits.is_empty() || digits == "0" {
        return (0, "0".to_string());
    }
    (lead_exp, digits)
}
