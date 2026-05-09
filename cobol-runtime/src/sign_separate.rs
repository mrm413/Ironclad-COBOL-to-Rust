// Helpers for COBOL SIGN IS LEADING/TRAILING SEPARATE CHARACTER fields.
//
// These are *not* numeric-edited PIC rules. For sign-separate DISPLAY numeric
// fields, COBOL preserves a distinct sign character (+/-) in a separate
// storage position.

/// Format a sign-separate field from an already-scaled absolute integer value.
///
/// * `abs_value` is the absolute, already-scaled value (no sign).
/// * `negative` controls the sign character (including negative zero).
/// * `digits` is the number of digit characters (excluding the separate sign).
/// * `leading` chooses sign position.
pub fn format_sign_separate_i64(abs_value: impl Into<i128>, negative: bool, digits: usize, leading: bool) -> String {
    let abs_value: i128 = abs_value.into();
    let sign = if negative { '-' } else { '+' };
    if digits == 0 {
        return sign.to_string();
    }

    // Keep only the rightmost `digits` decimal digits.
    let modulus: u128 = 10u128.saturating_pow(digits as u32);
    let mut v: u128 = (abs_value as u128) % modulus;

    // Left-pad with zeros to `digits`.
    let digits_str = format!("{:0width$}", v, width = digits);

    if leading {
        format!("{}{}", sign, digits_str)
    } else {
        format!("{}{}", digits_str, sign)
    }
}

/// Convenience: accept a signed scaled integer value and derive the sign.
pub fn format_sign_separate_scaled(value: impl Into<i128>, digits: usize, leading: bool) -> String {
    let value: i128 = value.into();
    format_sign_separate_i64(value.unsigned_abs() as i128, value < 0, digits, leading)
}
