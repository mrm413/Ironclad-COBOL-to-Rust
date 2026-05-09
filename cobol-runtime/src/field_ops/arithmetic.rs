// field_ops/arithmetic.rs — COBOL arithmetic operations

use rust_decimal::Decimal as RDecimal;
use crate::field::{FieldType, CobolRecord};
use super::display_fmt::{read_as_decimal, write_decimal};

// ── Unified Arithmetic ───────────────────────────────────────────────

#[derive(Clone, Debug, PartialEq)]
pub enum ArithOp {
    Add,
    Subtract,
    Multiply,
    Divide,
}

/// COBOL arithmetic: operate on fields, store result.
/// Returns true if a size error occurred.
/// Uses rust_decimal::Decimal for full precision (no f64 rounding artifacts).
pub fn cobol_arithmetic(
    record: &mut CobolRecord,
    op: ArithOp,
    operands: &[&str],
    target: &str,
    giving: Option<&str>,
    rounded: bool,
    _on_size_error: bool,
) -> bool {
    let target_val = read_as_decimal(record, target);
    let values: Vec<RDecimal> = operands.iter()
        .map(|name| read_as_decimal(record, name))
        .collect();

    let dest_name = giving.unwrap_or(target);
    let dest_idx = match record.idx(dest_name) { Some(i) => i, None => return false };
    let dest_desc = record.fields[dest_idx].clone();

    let result = match op {
        ArithOp::Add => {
            let sum = values.iter().fold(RDecimal::ZERO, |a, &b| a + b);
            target_val + sum
        }
        ArithOp::Subtract => {
            let sum = values.iter().fold(RDecimal::ZERO, |a, &b| a + b);
            target_val - sum
        }
        ArithOp::Multiply => values.iter().fold(target_val, |acc, &v| acc * v),
        ArithOp::Divide => {
            if values.is_empty() || values[0].is_zero() {
                return true; // size error: division by zero
            }
            target_val / values[0]
        }
    };

    // Check for size error (overflow for the destination field)
    let max_dec = match dest_desc.field_type {
        FieldType::Binary8 => RDecimal::from(u8::MAX),
        FieldType::Binary16 => RDecimal::from(i16::MAX),
        FieldType::Binary32 => RDecimal::from(i32::MAX),
        FieldType::Binary64 => RDecimal::from(i64::MAX),
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            let digits = dest_desc.pic_digits as u32;
            RDecimal::from(10i64.saturating_pow(digits) - 1)
        }
        _ => RDecimal::from(i64::MAX),
    };
    if result.abs() > max_dec {
        return true; // size error
    }

    write_decimal(record, dest_name, result, rounded);
    false
}
