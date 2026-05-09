// field_ops/move_op.rs — COBOL MOVE operation and internal helpers

use rust_decimal::Decimal as RDecimal;
use rust_decimal::prelude::{ToPrimitive, FromPrimitive};
use crate::field::{FieldDescriptor, FieldType, CobolRecord};
use crate::edited_numeric::format_alphanumeric_edited;
use super::conversion::{
    parse_display_numeric, parse_display_numeric_i128,
    write_display_numeric_ext, write_display_numeric_i128_ext,
    unpack_bcd_i64, pack_bcd, unpack_comp6_i64, pack_comp6,
    format_edited_from_f64,
};

pub fn cobol_move(record: &mut CobolRecord, src_name: &str, dst_name: &str) {
    cobol_move_impl(record, src_name, dst_name, false);
}

/// MOVE CORRESPONDING variant: uses physical field sizes, ignores L-var logical length.
pub fn cobol_move_physical(record: &mut CobolRecord, src_name: &str, dst_name: &str) {
    cobol_move_impl(record, src_name, dst_name, true);
}

fn cobol_move_impl(record: &mut CobolRecord, src_name: &str, dst_name: &str, physical: bool) {
    let (src_idx, src_off) = match record.resolve_field(src_name) {
        Some(v) => v,
        None => return,
    };
    let src_leaf_size = record.leaf_resolve_size.take();
    let (dst_idx, dst_off) = match record.resolve_field(dst_name) {
        Some(v) => v,
        None => return,
    };
    let dst_leaf_size = record.leaf_resolve_size.take();
    // ODO-aware sizes: use dynamic size when field is/contains an ODO array
    let src_odo_size = record.odo_adjusted_size_by_idx(src_idx);
    let dst_odo_size = record.odo_adjusted_size_by_idx(dst_idx);
    let mut src_desc = record.fields[src_idx].clone();
    src_desc.offset = src_off;
    if let Some(ls) = src_leaf_size { src_desc.size = ls; }
    else if let Some(os) = src_odo_size { src_desc.size = os; }
    // L-var source: logical length overrides physical — only that many bytes are "live"
    // Exception: physical=true (MOVE CORRESPONDING) always uses physical size
    if !physical {
        if let Some(lvar_len) = record.get_lvar_len(src_name) {
            src_desc.size = lvar_len.min(src_desc.size);
        }
    }
    let mut dst_desc = record.fields[dst_idx].clone();
    dst_desc.offset = dst_off;
    if let Some(ls) = dst_leaf_size { dst_desc.size = ls; }
    else if let Some(os) = dst_odo_size { dst_desc.size = os; }
    // L-var destination: only write to the active logical portion; bytes beyond lvar_len are untouched.
    // Exception: physical=true (MOVE CORRESPONDING) always uses physical size.
    if !physical {
        if let Some(lvar_len) = record.get_lvar_len(dst_name) {
            dst_desc.size = lvar_len.min(dst_desc.size);
        }
    }

    // Get source value as bytes
    let src_bytes = record.data[src_desc.offset..src_desc.offset + src_desc.size].to_vec();

    match (&src_desc.field_type, &dst_desc.field_type) {
        // Alpha -> Alpha: justify according to JUSTIFIED clause, space-pad/truncate
        (FieldType::AlphaNumeric, FieldType::AlphaNumeric)
        | (FieldType::EditedAlpha(_), FieldType::AlphaNumeric) => {
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            if dst_desc.justified_right {
                // JUSTIFIED RIGHT: right-align data, pad with spaces on left.
                // If source is longer than dest, truncate from the LEFT.
                if src_desc.size <= dst_desc.size {
                    let start = dst_desc.size - src_desc.size;
                    dest[start..].copy_from_slice(&src_bytes[..src_desc.size]);
                } else {
                    // Truncate leftmost bytes
                    let skip = src_desc.size - dst_desc.size;
                    dest.copy_from_slice(&src_bytes[skip..]);
                }
            } else {
                let len = src_desc.size.min(dst_desc.size);
                dest[..len].copy_from_slice(&src_bytes[..len]);
            }
        }

        // Any -> EditedAlpha: format through alphanumeric edit pattern (0/B// insertion)
        (_, FieldType::EditedAlpha(ref pattern)) => {
            // Extract source text — if numeric, format as display string first
            let src_text = match &src_desc.field_type {
                FieldType::NumericDisplay | FieldType::SignedDisplay => {
                    // Format numeric display as raw digit string
                    let val = extract_numeric(&src_bytes, &src_desc);
                    format_numeric_for_alpha(val, &src_desc)
                }
                FieldType::Binary8 | FieldType::Binary16 | FieldType::Binary32 | FieldType::Binary64 => {
                    let val = extract_numeric(&src_bytes, &src_desc);
                    format_numeric_for_alpha(val, &src_desc)
                }
                _ => {
                    // Alpha source: use raw bytes as string
                    String::from_utf8_lossy(&src_bytes).to_string()
                }
            };
            let formatted = format_alphanumeric_edited(&src_text, pattern);
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            let bytes = formatted.as_bytes();
            let len = bytes.len().min(dst_desc.size);
            dest[..len].copy_from_slice(&bytes[..len]);
        }

        // AlphaNumeric -> EditedAlpha already handled above
        // EditedAlpha -> EditedAlpha: format source display through dest pattern
        // (This is covered by the catch-all above since EditedAlpha is not AlphaNumeric)

        // Float32 -> Float32 or Float64 -> Float64: direct byte copy (preserves full range
        // including extreme values that overflow RDecimal's 96-bit mantissa)
        (FieldType::Float32, FieldType::Float32) => {
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.copy_from_slice(&src_bytes[..4.min(src_bytes.len())]);
        }
        (FieldType::Float64, FieldType::Float64) => {
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.copy_from_slice(&src_bytes[..8.min(src_bytes.len())]);
        }
        // Float32 -> Float64: clean through decimal to strip f32 artifacts,
        // matching GnuCOBOL's decimal-intermediate move semantics
        (FieldType::Float32, FieldType::Float64) => {
            let v = f32::from_be_bytes(src_bytes[..4].try_into().unwrap_or([0; 4]));
            let clean: f64 = format!("{}", v).parse().unwrap_or(v as f64);
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.copy_from_slice(&clean.to_be_bytes());
        }
        // Float64 -> Float32: truncate to f32 precision
        (FieldType::Float64, FieldType::Float32) => {
            let v = f64::from_be_bytes(src_bytes[..8].try_into().unwrap_or([0; 8]));
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.copy_from_slice(&(v as f32).to_be_bytes());
        }

        // Float -> Numeric or Numeric -> Float: use Decimal intermediate to preserve
        // fractional values. The i128 path below truncates floats to integers.
        (src_t, dst_t) if is_numeric(src_t) && is_numeric(dst_t)
            && (matches!(src_t, FieldType::Float32 | FieldType::Float64 | FieldType::FloatDecimal16 | FieldType::FloatDecimal34)
                || matches!(dst_t, FieldType::Float32 | FieldType::Float64 | FieldType::FloatDecimal16 | FieldType::FloatDecimal34)) =>
        {
            // Special case: FD16/FD34 -> FD16/FD34 direct string copy.
            // Read from out-of-band fd_string_values first (full DBig precision);
            // fall back to bytes for legacy / unset fields. Copy to both the
            // out-of-band store AND the byte buffer (truncated) on the dest side.
            if matches!(src_desc.field_type, FieldType::FloatDecimal16 | FieldType::FloatDecimal34)
                && matches!(dst_desc.field_type, FieldType::FloatDecimal16 | FieldType::FloatDecimal34) {
                let src_str = record.fd_string_values
                    .get(&(src_idx, src_off))
                    .cloned()
                    .unwrap_or_else(|| {
                        let s = String::from_utf8_lossy(&src_bytes);
                        s.trim_end_matches('\0').trim().to_string()
                    });
                record.fd_string_values.insert((dst_idx, dst_off), src_str.clone());
                let dest = &mut record.data[dst_off..dst_off + dst_desc.size];
                dest.fill(0);
                let bytes = src_str.as_bytes();
                let len = bytes.len().min(dst_desc.size);
                dest[..len].copy_from_slice(&bytes[..len]);
                return;
            }
            let dst_is_float = matches!(dst_desc.field_type,
                FieldType::Float32 | FieldType::Float64
                | FieldType::FloatDecimal16 | FieldType::FloatDecimal34);
            let src_val = match src_desc.field_type {
                FieldType::Float32 => {
                    let v = f32::from_be_bytes(src_bytes[..4].try_into().unwrap_or([0; 4]));
                    if dst_is_float {
                        // Float -> Float: use the shortest decimal representation
                        // to preserve decimal-rounded MOVE semantics
                        // (e.g. 11.55f32 -> 11.55f64, not 11.550000190734863).
                        let s = format!("{}", v);
                        s.parse::<RDecimal>().unwrap_or_else(|_|
                            RDecimal::from_f64(v as f64).unwrap_or(RDecimal::ZERO)
                        )
                    } else {
                        // Float -> non-float numeric: preserve full binary precision
                        // so int truncation matches GnuCOBOL (e.g. f32(5.4312345E12)
                        // is actually 5,431,234,498,304 -> last 4 digits = 8304).
                        RDecimal::from_f64(v as f64).unwrap_or(RDecimal::ZERO)
                    }
                }
                FieldType::Float64 => {
                    let v = f64::from_be_bytes(src_bytes[..8].try_into().unwrap_or([0; 8]));
                    if dst_is_float {
                        let s = format!("{}", v);
                        s.parse::<RDecimal>().unwrap_or_else(|_|
                            RDecimal::from_f64(v).unwrap_or(RDecimal::ZERO)
                        )
                    } else {
                        RDecimal::from_f64(v).unwrap_or(RDecimal::ZERO)
                    }
                }
                FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                    // Prefer out-of-band fd_string_values (full DBig precision);
                    // fall back to bytes for legacy / unset fields.
                    let stored = record.fd_string_values
                        .get(&(src_idx, src_off))
                        .cloned()
                        .unwrap_or_else(|| {
                            let s = String::from_utf8_lossy(&src_bytes);
                            s.trim_end_matches('\0').trim().to_string()
                        });
                    stored.parse::<RDecimal>().unwrap_or(RDecimal::ZERO)
                }
                _ => {
                    // Non-float numeric source: extract via i128 then convert to Decimal
                    let raw = extract_numeric_i128(&src_bytes, &src_desc);
                    RDecimal::from_i128_with_scale(raw, src_desc.pic_scale as u32)
                }
            };
            // Store into destination using write_decimal logic (handles float/non-float dest)
            // Borrow data slice in a sub-scope so subsequent record.fd_string_values
            // mutation doesn't conflict with the dest borrow.
            match dst_desc.field_type {
                FieldType::Float32 => {
                    let fval = src_val.to_f64().unwrap_or(0.0) as f32;
                    let dest = &mut record.data[dst_off..dst_off + dst_desc.size];
                    dest.copy_from_slice(&fval.to_be_bytes());
                }
                FieldType::Float64 => {
                    let fval = src_val.to_f64().unwrap_or(0.0);
                    let dest = &mut record.data[dst_off..dst_off + dst_desc.size];
                    dest.copy_from_slice(&fval.to_be_bytes());
                }
                FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
                    // Store full-precision string in fd_string_values (no f64
                    // round-trip — keep the RDecimal's exact decimal repr).
                    let s = if src_val == RDecimal::ZERO { "0".to_string() } else { format!("{}", src_val) };
                    record.fd_string_values.insert((dst_idx, dst_off), s.clone());
                    let dest = &mut record.data[dst_off..dst_off + dst_desc.size];
                    dest.fill(0);
                    let bytes = s.as_bytes();
                    let len = bytes.len().min(dst_desc.size);
                    dest[..len].copy_from_slice(&bytes[..len]);
                }
                _ => {
                    // Float source -> non-float numeric dest: scale and store as i128
                    let target_scale = dst_desc.pic_scale as u32;
                    let mantissa = {
                        let current_scale = src_val.scale();
                        let m = src_val.mantissa();
                        if current_scale <= target_scale {
                            let factor = 10i128.pow(target_scale - current_scale);
                            m * factor
                        } else {
                            let factor = 10i128.pow(current_scale - target_scale);
                            if m >= 0 { m / factor } else { -((-m) / factor) }
                        }
                    };
                    // Unsigned destination: take absolute value
                    let mantissa = if !dst_desc.is_signed && mantissa < 0 { mantissa.abs() } else { mantissa };
                    // Truncate to destination pic_digits
                    let mantissa = if dst_desc.pic_digits > 0 && dst_desc.pic_digits < 38 {
                        let modulus = 10i128.pow(dst_desc.pic_digits as u32);
                        let sign = if mantissa < 0 { -1i128 } else { 1i128 };
                        (mantissa.abs() % modulus) * sign
                    } else {
                        mantissa
                    };
                    let dest = &mut record.data[dst_off..dst_off + dst_desc.size];
                    store_numeric_i128(dest, mantissa, &dst_desc);
                }
            }
        }

        // Numeric -> Numeric: extract value, rescale, store
        // Use i128 to handle large values (up to 38 digits) without precision loss.
        // Use effective total scale (pic_scale + leading P positions) for correct rescaling.
        (src_t, dst_t) if is_numeric(src_t) && is_numeric(dst_t) => {
            let mut val = extract_numeric_i128(&src_bytes, &src_desc);
            // Trailing P: multiply to get actual COBOL integer value
            if src_desc.p_factor < 0 {
                val = val.saturating_mul(10i128.pow((-src_desc.p_factor) as u32));
            }
            // Compute effective total scales (leading P adds decimal positions)
            let src_total_scale = if src_desc.p_factor > 0 {
                src_desc.pic_scale + src_desc.p_factor as u8
            } else {
                src_desc.pic_scale
            };
            let dst_total_scale = if dst_desc.p_factor > 0 {
                dst_desc.pic_scale + dst_desc.p_factor as u8
            } else {
                dst_desc.pic_scale
            };
            // Rescale using total effective scales
            let scaled = rescale_i128(val, src_total_scale, dst_total_scale);
            // Trailing P destination: divide to get storage mantissa
            let store_val = if dst_desc.p_factor < 0 {
                scaled / 10i128.pow((-dst_desc.p_factor) as u32)
            } else {
                scaled
            };
            // Unsigned destination: take absolute value (COBOL drops sign for unsigned fields)
            let store_val = if !dst_desc.is_signed && store_val < 0 {
                store_val.abs()
            } else {
                store_val
            };
            // Truncate to destination pic_digits (COBOL truncates leftmost digits on overflow)
            let store_val = if dst_desc.pic_digits > 0 && dst_desc.pic_digits < 38 {
                let modulus = 10i128.pow(dst_desc.pic_digits as u32);
                let sign = if store_val < 0 { -1i128 } else { 1i128 };
                (store_val.abs() % modulus) * sign
            } else {
                store_val
            };
            store_numeric_i128(
                &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size],
                store_val,
                &dst_desc,
            );
        }

        // Alpha -> Numeric: parse string as number, store
        (FieldType::AlphaNumeric, dst_t) if is_numeric(dst_t) => {
            let s = String::from_utf8_lossy(&src_bytes).trim().to_string();
            let mut val = s.parse::<i64>().unwrap_or(0);
            // Reverse-apply destination p_factor for storage
            if dst_desc.p_factor < 0 {
                val /= 10i64.pow((-dst_desc.p_factor) as u32);
            } else if dst_desc.p_factor > 0 {
                val = val.saturating_mul(10i64.pow(dst_desc.p_factor as u32));
            }
            store_numeric(
                &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size],
                val,
                &dst_desc,
            );
        }

        // Numeric -> Alpha: format number, justify into alpha field
        (src_t, FieldType::AlphaNumeric) if is_numeric(src_t) => {
            let mut val = extract_numeric(&src_bytes, &src_desc);
            // Apply source p_factor to get actual COBOL value
            if src_desc.p_factor < 0 {
                val = val.saturating_mul(10i64.pow((-src_desc.p_factor) as u32));
            } else if src_desc.p_factor > 0 {
                val /= 10i64.pow(src_desc.p_factor as u32);
            }
            let formatted = format_numeric_for_alpha(val, &src_desc);
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            let bytes = formatted.as_bytes();
            if dst_desc.justified_right {
                // JUSTIFIED RIGHT: right-align, truncate from the LEFT if too long
                if bytes.len() <= dst_desc.size {
                    let start = dst_desc.size - bytes.len();
                    dest[start..].copy_from_slice(bytes);
                } else {
                    let skip = bytes.len() - dst_desc.size;
                    dest.copy_from_slice(&bytes[skip..]);
                }
            } else {
                let len = bytes.len().min(dst_desc.size);
                dest[..len].copy_from_slice(&bytes[..len]);
            }
        }

        // Edited -> Numeric: de-edit (extract numeric value from formatted string)
        (FieldType::EditedNumeric(ref pat), dst_t) if is_numeric(dst_t) => {
            let s = String::from_utf8_lossy(&src_bytes).to_string();
            let decimal_comma = pat.starts_with('~');
            let mut eff_pat = if decimal_comma { &pat[1..] } else { pat.as_str() };
            // Strip custom currency prefix @X@
            if eff_pat.starts_with('@') && eff_pat.len() >= 3 && eff_pat.as_bytes()[2] == b'@' {
                eff_pat = &eff_pat[3..];
            }
            let mut val = de_edit_to_f64_ex(&s, decimal_comma);
            // COBOL de-editing: PIC '+' and PIC 'DB' patterns lose sign during de-edit.
            // Only PIC '-' and PIC 'CR' preserve the sign.
            let pat_upper = eff_pat.to_uppercase();
            let loses_sign = pat_upper.starts_with('+') || pat_upper.ends_with("DB");
            if loses_sign {
                val = val.abs();
            }
            // Handle implied decimal 'V' in edit pattern: the de-edited integer
            // includes decimal digits, so divide by 10^(number of V-decimal positions).
            if let Some(v_idx) = pat_upper.find('V') {
                // Count only digit positions after V, excluding trailing sign chars and CR/DB
                let after_v = pat_upper[v_idx+1..].trim_end_matches("CR").trim_end_matches("DB");
                let after_v = after_v.trim_end_matches(|c: char| c == '+' || c == '-');
                let v_dec_digits = after_v.chars()
                    .filter(|c| matches!(c, '9' | 'Z' | '*'))
                    .count();
                if v_dec_digits > 0 {
                    val /= 10f64.powi(v_dec_digits as i32);
                }
            }
            // Reverse-apply destination p_factor
            if dst_desc.p_factor < 0 {
                val /= 10f64.powi((-dst_desc.p_factor) as i32);
            } else if dst_desc.p_factor > 0 {
                val *= 10f64.powi(dst_desc.p_factor as i32);
            }
            let scaled = (val * 10f64.powi(dst_desc.pic_scale as i32)).round() as i64;
            store_numeric(
                &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size],
                scaled,
                &dst_desc,
            );
        }

        // Edited -> Alpha: copy display representation
        (FieldType::EditedNumeric(_), FieldType::AlphaNumeric) => {
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            if dst_desc.justified_right {
                if src_desc.size <= dst_desc.size {
                    let start = dst_desc.size - src_desc.size;
                    dest[start..].copy_from_slice(&src_bytes[..src_desc.size]);
                } else {
                    let skip = src_desc.size - dst_desc.size;
                    dest.copy_from_slice(&src_bytes[skip..]);
                }
            } else {
                let len = src_desc.size.min(dst_desc.size);
                dest[..len].copy_from_slice(&src_bytes[..len]);
            }
        }

        // Numeric -> Edited: format through edit pattern
        (src_t, FieldType::EditedNumeric(ref pattern)) if is_numeric(src_t) => {
            // For float sources, use f64 to preserve decimal
            let fval = match src_t {
                FieldType::Float32 => {
                    f32::from_be_bytes(src_bytes.try_into().unwrap_or([0; 4])) as f64
                }
                FieldType::Float64 => {
                    f64::from_be_bytes(src_bytes.try_into().unwrap_or([0; 8]))
                }
                _ => {
                    let mut val = extract_numeric(&src_bytes, &src_desc);
                    // Apply source p_factor to get actual COBOL value
                    if src_desc.p_factor < 0 {
                        val = val.saturating_mul(10i64.pow((-src_desc.p_factor) as u32));
                    } else if src_desc.p_factor > 0 {
                        val /= 10i64.pow(src_desc.p_factor as u32);
                    }
                    if src_desc.pic_scale > 0 {
                        val as f64 / 10f64.powi(src_desc.pic_scale as i32)
                    } else {
                        val as f64
                    }
                }
            };
            let formatted = format_edited_from_f64(fval, pattern, &dst_desc);
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            let bytes = formatted.as_bytes();
            let len = bytes.len().min(dst_desc.size);
            dest[..len].copy_from_slice(&bytes[..len]);
        }

        // Fallback: byte copy with padding
        _ => {
            let dest = &mut record.data[dst_desc.offset..dst_desc.offset + dst_desc.size];
            dest.fill(0x20);
            let len = src_desc.size.min(dst_desc.size);
            dest[..len].copy_from_slice(&src_bytes[..len]);
        }
    }
}

// ── Helper Functions ─────────────────────────────────────────────────

/// De-edit: extract numeric value from an edited display string.
/// Strips all non-numeric characters except '.', '-', '+'.
/// Handles CR/DB suffixes as negative indicators.
pub(crate) fn de_edit_to_f64(s: &str) -> f64 {
    de_edit_to_f64_ex(s, false)
}

/// De-edit with decimal_comma support.
/// When decimal_comma is true, ',' is the decimal point and '.' is thousands separator.
pub(crate) fn de_edit_to_f64_ex(s: &str, decimal_comma: bool) -> f64 {
    let s = s.trim();
    let mut negative = false;
    let mut cleaned = String::new();
    let upper = s.to_uppercase();

    // Check for CR or DB suffix (credit/debit = negative)
    let s_check = if upper.ends_with("CR") || upper.ends_with("DB") {
        negative = true;
        &s[..s.len() - 2]
    } else {
        s
    };

    if decimal_comma {
        // DECIMAL-POINT IS COMMA: ',' = decimal point, '.' = thousands separator
        for ch in s_check.chars() {
            match ch {
                '0'..='9' => cleaned.push(ch),
                ',' => cleaned.push('.'), // comma is decimal point -> convert to '.'
                '-' => { negative = true; }
                '+' => {}
                '.' => {} // period is thousands separator, skip
                _ => {} // skip edit chars ($, *, B, /, etc.)
            }
        }
    } else {
        for ch in s_check.chars() {
            match ch {
                '0'..='9' | '.' => cleaned.push(ch),
                '-' => { negative = true; }
                '+' => {}
                ',' => {} // thousands separator, skip
                _ => {} // skip edit chars ($, *, B, /, etc.)
            }
        }
    }

    if cleaned.is_empty() {
        return 0.0;
    }

    let val = cleaned.parse::<f64>().unwrap_or(0.0);
    if negative { -val } else { val }
}

pub(crate) fn is_numeric(ft: &FieldType) -> bool {
    matches!(
        ft,
        FieldType::NumericDisplay
            | FieldType::SignedDisplay
            | FieldType::Binary8
            | FieldType::Binary16
            | FieldType::Binary32
            | FieldType::Binary64
            | FieldType::Packed
            | FieldType::Comp6
            | FieldType::Float32
            | FieldType::Float64
            | FieldType::FloatDecimal16
            | FieldType::FloatDecimal34
    )
}

/// Extract numeric value as i64 from raw bytes based on field descriptor.
pub(crate) fn extract_numeric(bytes: &[u8], desc: &FieldDescriptor) -> i64 {
    match desc.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            parse_display_numeric(bytes, desc.is_signed)
        }
        FieldType::Binary8 => {
            let raw = if desc.is_signed {
                bytes.first().map_or(0i64, |&b| b as i8 as i64)
            } else {
                bytes.first().map_or(0i64, |&b| b as i64)
            };
            if desc.pic_digits > 0 {
                let modulus = 10i64.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i64 } else { 1i64 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary16 => {
            let raw = if desc.is_signed {
                i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
            } else {
                u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i64
            };
            if desc.pic_digits > 0 {
                let modulus = 10i64.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i64 } else { 1i64 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary32 => {
            let raw = if desc.is_signed {
                i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64
            } else {
                u32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64
            };
            if desc.pic_digits > 0 {
                let modulus = 10i64.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i64 } else { 1i64 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary64 => {
            // Use i128 to avoid overflow for unsigned u64 values > i64::MAX
            let raw128: i128 = if desc.is_signed {
                i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            } else {
                u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            };
            if desc.pic_digits > 0 {
                let modulus = 10i128.pow(desc.pic_digits as u32);
                let sign = if raw128 < 0 { -1i128 } else { 1i128 };
                ((raw128.abs() % modulus) * sign) as i64
            } else { raw128 as i64 }
        }
        FieldType::Packed => unpack_bcd_i64(bytes, desc.is_signed),
        FieldType::Comp6 => unpack_comp6_i64(bytes),
        FieldType::Float32 => f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i64,
        FieldType::Float64 => f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i64,
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            let s = String::from_utf8_lossy(bytes);
            let trimmed = s.trim_end_matches('\0').trim();
            trimmed.parse::<f64>().unwrap_or(0.0) as i64
        }
        _ => 0,
    }
}

/// Store numeric value into raw bytes based on field descriptor.
pub(crate) fn store_numeric(dest: &mut [u8], value: i64, desc: &FieldDescriptor) {
    match desc.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            write_display_numeric_ext(dest, value, desc.pic_digits, desc.is_signed, desc.sign_leading, desc.sign_separate);
        }
        FieldType::Binary8 => dest.copy_from_slice(&[(value as u8)]),
        FieldType::Binary16 => dest.copy_from_slice(&(value as i16).to_be_bytes()),
        FieldType::Binary32 => dest.copy_from_slice(&(value as i32).to_be_bytes()),
        FieldType::Binary64 => dest.copy_from_slice(&value.to_be_bytes()),
        FieldType::Packed => pack_bcd(dest, value as i128, desc.is_signed),
        FieldType::Comp6 => pack_comp6(dest, value.abs() as i128),
        FieldType::Float32 => dest.copy_from_slice(&(value as f32).to_be_bytes()),
        FieldType::Float64 => dest.copy_from_slice(&(value as f64).to_be_bytes()),
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            let s = if value == 0 { "0".to_string() } else { format!("{}", value) };
            dest.fill(0);
            let bytes = s.as_bytes();
            let len = bytes.len().min(dest.len());
            dest[..len].copy_from_slice(&bytes[..len]);
        }
        _ => {}
    }
}

/// Extract numeric value as i128 from raw bytes — handles values > 18 digits.
pub(crate) fn extract_numeric_i128(bytes: &[u8], desc: &FieldDescriptor) -> i128 {
    match desc.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            parse_display_numeric_i128(bytes, desc.is_signed)
        }
        FieldType::Binary8 => {
            let raw = if desc.is_signed {
                bytes.first().map_or(0i128, |&b| b as i8 as i128)
            } else {
                bytes.first().map_or(0i128, |&b| b as i128)
            };
            if desc.pic_digits > 0 {
                let modulus = 10i128.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i128 } else { 1i128 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary16 => {
            let raw = if desc.is_signed {
                i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i128
            } else {
                u16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i128
            };
            if desc.pic_digits > 0 {
                let modulus = 10i128.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i128 } else { 1i128 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary32 => {
            let raw = if desc.is_signed {
                i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128
            } else {
                u32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128
            };
            if desc.pic_digits > 0 {
                let modulus = 10i128.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i128 } else { 1i128 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Binary64 => {
            let raw: i128 = if desc.is_signed {
                i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            } else {
                u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            };
            if desc.pic_digits > 0 {
                let modulus = 10i128.pow(desc.pic_digits as u32);
                let sign = if raw < 0 { -1i128 } else { 1i128 };
                (raw.abs() % modulus) * sign
            } else { raw }
        }
        FieldType::Packed => super::conversion::unpack_bcd_i128(bytes, desc.is_signed),
        FieldType::Comp6 => super::conversion::unpack_comp6_i128(bytes),
        FieldType::Float32 => f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128,
        FieldType::Float64 => f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128,
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            let s = String::from_utf8_lossy(bytes);
            let trimmed = s.trim_end_matches('\0').trim();
            trimmed.parse::<f64>().unwrap_or(0.0) as i128
        }
        _ => 0,
    }
}

/// Store numeric value (i128) into raw bytes based on field descriptor.
pub(crate) fn store_numeric_i128(dest: &mut [u8], value: i128, desc: &FieldDescriptor) {
    match desc.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            write_display_numeric_i128_ext(dest, value, desc.pic_digits, desc.is_signed, desc.sign_leading, desc.sign_separate);
        }
        FieldType::Binary8 => dest.copy_from_slice(&[(value as u8)]),
        FieldType::Binary16 => dest.copy_from_slice(&(value as i16).to_be_bytes()),
        FieldType::Binary32 => dest.copy_from_slice(&(value as i32).to_be_bytes()),
        FieldType::Binary64 => {
            if !desc.is_signed && value >= 0 {
                dest.copy_from_slice(&(value as u64).to_be_bytes());
            } else {
                dest.copy_from_slice(&(value as i64).to_be_bytes());
            }
        }
        FieldType::Packed => pack_bcd(dest, value, desc.is_signed),
        FieldType::Comp6 => pack_comp6(dest, value.abs()),
        FieldType::Float32 => dest.copy_from_slice(&(value as f32).to_be_bytes()),
        FieldType::Float64 => dest.copy_from_slice(&(value as f64).to_be_bytes()),
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            let s = if value == 0 { "0".to_string() } else { format!("{}", value) };
            dest.fill(0);
            let bytes = s.as_bytes();
            let len = bytes.len().min(dest.len());
            dest[..len].copy_from_slice(&bytes[..len]);
        }
        _ => {}
    }
}

/// Rescale an i128 numeric value from one decimal scale to another.
pub(crate) fn rescale_i128(value: i128, src_scale: u8, dst_scale: u8) -> i128 {
    if src_scale == dst_scale {
        return value;
    }
    if dst_scale > src_scale {
        let factor = 10i128.pow((dst_scale - src_scale) as u32);
        value.saturating_mul(factor)
    } else {
        let factor = 10i128.pow((src_scale - dst_scale) as u32);
        // COBOL truncation (not rounding by default)
        if value >= 0 { value / factor } else { -((-value) / factor) }
    }
}

/// Rescale a numeric value from one decimal scale to another.
/// E.g., value=12345 with src_scale=2 (123.45) to dst_scale=4 -> 1234500
pub(crate) fn rescale(value: i64, src_scale: u8, dst_scale: u8) -> i64 {
    if src_scale == dst_scale {
        return value;
    }
    if dst_scale > src_scale {
        let factor = 10i64.pow((dst_scale - src_scale) as u32);
        value.saturating_mul(factor)
    } else {
        let factor = 10i64.pow((src_scale - dst_scale) as u32);
        // COBOL truncation (not rounding by default)
        value / factor
    }
}

/// Format a numeric value for display in an alphanumeric field.
pub(crate) fn format_numeric_for_alpha(value: i64, desc: &FieldDescriptor) -> String {
    // COBOL MOVE numeric to alpha: format as zero-padded display string.
    // Sign is NOT included — MOVE to alpha gives unsigned zero-padded result.
    // Implied decimal (V) does NOT produce a period — digits only.
    // Trailing P positions (p_factor < 0) add extra display digits for the implied zeros.
    let abs_val = value.unsigned_abs();
    // For COMP-5 (native binary), pic_digits is the binary capacity (e.g. 5 for 16-bit).
    // Use pic_clause_digits (the original PIC width) for MOVE-to-alpha formatting.
    let base_digits = if desc.pic_clause_digits > 0 { desc.pic_clause_digits } else { desc.pic_digits };
    let mut digits = base_digits.max(1) as usize;
    if desc.p_factor < 0 {
        digits += (-desc.p_factor) as usize;
    }
    format!("{:0>width$}", abs_val, width = digits)
}
