// field_ops/display_fmt.rs — COBOL DISPLAY, read_as_decimal, write_decimal

use rust_decimal::Decimal as RDecimal;
use rust_decimal::prelude::{ToPrimitive, FromPrimitive};
use crate::field::{FieldType, CobolRecord};
use super::conversion::{
    parse_display_numeric_i128, unpack_bcd_i64, unpack_comp6_i128,
    write_display_numeric_i128_ext, pack_bcd, pack_comp6,
};

// ── Unified DISPLAY ──────────────────────────────────────────────────

/// COBOL DISPLAY: format and output fields.
pub fn cobol_display(record: &CobolRecord, fields: &[&str], no_advancing: bool) {
    let mut output = String::new();
    for name in fields {
        output.push_str(&record.get_display(name));
    }
    if no_advancing {
        print!("{}", output);
    } else {
        println!("{}", output);
    }
    use std::io::Write;
    std::io::stdout().flush().ok();
}

// ── Decimal Precision Helpers ────────────────────────────────────────

/// Read a field value as rust_decimal::Decimal for full precision arithmetic.
/// Returns exact value with proper scale — no f64 precision loss.
pub fn read_as_decimal(record: &CobolRecord, name: &str) -> RDecimal {
    let idx = match record.idx(name) { Some(i) => i, None => return RDecimal::ZERO };
    let f = &record.fields[idx];
    let bytes = &record.data[f.offset..f.offset + f.size];

    let result = match f.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            let raw = parse_display_numeric_i128(bytes, f.is_signed);
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Packed => {
            let raw = unpack_bcd_i64(bytes, f.is_signed) as i128;
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Comp6 => {
            let raw = unpack_comp6_i128(bytes);
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Binary8 => {
            let raw = if f.is_signed {
                bytes.first().map_or(0i128, |&b| b as i8 as i128)
            } else {
                bytes.first().map_or(0i128, |&b| b as i128)
            };
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Binary16 => {
            let raw = i16::from_be_bytes(bytes.try_into().unwrap_or([0; 2])) as i128;
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Binary32 => {
            let raw = i32::from_be_bytes(bytes.try_into().unwrap_or([0; 4])) as i128;
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Binary64 => {
            // Use unsigned read for unsigned fields to avoid overflow
            let raw: i128 = if f.is_signed {
                i64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            } else {
                u64::from_be_bytes(bytes.try_into().unwrap_or([0; 8])) as i128
            };
            RDecimal::from_i128_with_scale(raw, f.pic_scale as u32)
        }
        FieldType::Float32 => {
            let val = f32::from_be_bytes(bytes.try_into().unwrap_or([0; 4]));
            RDecimal::from_f64(val as f64).unwrap_or(RDecimal::ZERO)
        }
        FieldType::Float64 => {
            let val = f64::from_be_bytes(bytes.try_into().unwrap_or([0; 8]));
            RDecimal::from_f64(val).unwrap_or(RDecimal::ZERO)
        }
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            // Parse stored string representation to Decimal (may lose precision beyond 28 digits)
            let s = String::from_utf8_lossy(bytes);
            let trimmed = s.trim_end_matches('\0').trim().to_string();
            trimmed.parse::<RDecimal>().unwrap_or(RDecimal::ZERO)
        }
        FieldType::AlphaNumeric => {
            let s = String::from_utf8_lossy(bytes).trim().to_string();
            s.parse::<RDecimal>().unwrap_or(RDecimal::ZERO)
        }
        _ => RDecimal::ZERO,
    };
    // Apply PIC P scaling factor (same logic as get_f64)
    if f.p_factor < 0 {
        // Trailing P (999PPP): multiply by 10^|p_factor| to get actual COBOL value
        let factor = RDecimal::from(10i64.pow((-f.p_factor) as u32));
        result * factor
    } else if f.p_factor > 0 {
        // Leading P (VPPP999): divide by 10^p_factor
        let factor = RDecimal::from(10i64.pow(f.p_factor as u32));
        result / factor
    } else {
        result
    }
}

/// Write a rust_decimal::Decimal value into a field with proper scaling.
/// If `rounded` is true, uses rescale (banker's rounding); otherwise truncates.
pub fn write_decimal(record: &mut CobolRecord, name: &str, val: RDecimal, rounded: bool) {
    let idx = match record.idx(name) { Some(i) => i, None => return };
    let f = record.fields[idx].clone();
    let target_scale = f.pic_scale as u32;

    // Apply inverse PIC P scaling before storage (same logic as set_f64)
    let val = if f.p_factor < 0 {
        // Trailing P (999PPP): stored = value / 10^|p_factor|
        let factor = RDecimal::from(10i64.pow((-f.p_factor) as u32));
        val / factor
    } else if f.p_factor > 0 {
        // Leading P (VPPP999): stored = value * 10^p_factor
        let factor = RDecimal::from(10i64.pow(f.p_factor as u32));
        val * factor
    } else {
        val
    };

    let mantissa: i128 = if rounded {
        let mut rescaled = val;
        rescaled.rescale(target_scale);
        rescaled.mantissa()
    } else {
        // Truncate: manually scale without rounding
        let current_scale = val.scale();
        let m = val.mantissa();
        if current_scale <= target_scale {
            let factor = 10i128.pow(target_scale - current_scale);
            m * factor
        } else {
            let factor = 10i128.pow(current_scale - target_scale);
            if m >= 0 { m / factor } else { -((-m) / factor) }
        }
    };

    // For unsigned fields, take absolute value (COBOL drops sign for unsigned fields)
    let mantissa = if !f.is_signed && mantissa < 0 { mantissa.abs() } else { mantissa };
    // Truncate mantissa to pic_digits (COBOL truncates leftmost digits on overflow)
    let mantissa = if f.pic_digits > 0 && f.pic_digits < 38 {
        let modulus = 10i128.pow(f.pic_digits as u32);
        let sign = if mantissa < 0 { -1i128 } else { 1i128 };
        (mantissa.abs() % modulus) * sign
    } else {
        mantissa
    };

    let dest = &mut record.data[f.offset..f.offset + f.size];

    match f.field_type {
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            write_display_numeric_i128_ext(dest, mantissa, f.pic_digits, f.is_signed, f.sign_leading, f.sign_separate);
        }
        FieldType::Binary8 => dest.copy_from_slice(&[(mantissa as u8)]),
        FieldType::Binary16 => dest.copy_from_slice(&(mantissa as i16).to_be_bytes()),
        FieldType::Binary32 => dest.copy_from_slice(&(mantissa as i32).to_be_bytes()),
        FieldType::Binary64 => {
            // For unsigned fields, use u64 to avoid overflow when value > i64::MAX
            if !f.is_signed && mantissa >= 0 {
                dest.copy_from_slice(&(mantissa as u64).to_be_bytes());
            } else {
                dest.copy_from_slice(&(mantissa as i64).to_be_bytes());
            }
        }
        FieldType::Packed => pack_bcd(dest, mantissa, f.is_signed),
        FieldType::Comp6 => pack_comp6(dest, mantissa.abs()),
        FieldType::Float32 => {
            let fval = val.to_f64().unwrap_or(0.0) as f32;
            dest.copy_from_slice(&fval.to_be_bytes());
        }
        FieldType::Float64 => {
            let fval = val.to_f64().unwrap_or(0.0);
            dest.copy_from_slice(&fval.to_be_bytes());
        }
        FieldType::FloatDecimal16 | FieldType::FloatDecimal34 => {
            // Store as string representation
            let s = format!("{}", val);
            dest.fill(0);
            let bytes = s.as_bytes();
            let len = bytes.len().min(f.size);
            dest[..len].copy_from_slice(&bytes[..len]);
        }
        FieldType::AlphaNumeric | FieldType::Group => {
            let s = val.to_string();
            dest.fill(0x20);
            let bytes = s.as_bytes();
            let len = bytes.len().min(f.size);
            dest[..len].copy_from_slice(&bytes[..len]);
        }
        _ => {}
    }
}
