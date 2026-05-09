// float_decimal.rs — FLOAT-DECIMAL-16 and FLOAT-DECIMAL-34 support
//
// FLOAT-DECIMAL-16: IEEE 754 decimal64, 16 significant digits.
//   Stored as string representation in 34 bytes (ASCII, null-padded).
//   Arithmetic performed via dashu::float::DBig for 16-digit precision.
//   Quantum exponent range: [-398, 369]. (Max value ~ 9.999E+384)
//
// FLOAT-DECIMAL-34: IEEE 754 decimal128, 34 significant digits.
//   Stored as string representation in 50 bytes (ASCII, null-padded).
//   Arithmetic performed via dashu::float::DBig for full 34-digit precision.
//   Quantum exponent range: [-6176, 6111]. (Max value ~ 9.999E+6144)

use dashu::float::DBig;

/// Working precision in bits for a given decimal digit count.
fn wp(digits: usize) -> usize {
    (digits * 4).max(128)
}

/// Set precision on a DBig value.
fn sp(x: DBig, prec: usize) -> DBig {
    x.with_precision(prec).value()
}

/// Format a FLOAT-DECIMAL-16 stored string for DISPLAY output.
/// Uses DBig to maintain 16-digit precision.
/// Produces GnuCOBOL-compatible %g-style output with 16 significant digits.
pub fn format_fd16_display(stored: &str) -> String {
    if stored.is_empty() || stored == "0" { return "0".to_string(); }

    let parsed: DBig = match stored.parse() {
        Ok(v) => v,
        Err(_) => return "0".to_string(),
    };
    let val = sp(parsed, wp(20));
    format_dbig_g(&val, 16)
}

/// Format a FLOAT-DECIMAL-34 stored string for DISPLAY output.
/// Uses DBig to maintain 34-digit precision.
/// Produces GnuCOBOL-compatible %g-style output with 34 significant digits.
pub fn format_fd34_display(stored: &str) -> String {
    if stored.is_empty() || stored == "0" { return "0".to_string(); }

    // Parse through DBig for full precision
    let parsed: DBig = match stored.parse() {
        Ok(v) => v,
        Err(_) => return "0".to_string(),
    };
    let val = sp(parsed, wp(40));

    // Format with 34 significant digits, then strip trailing zeros (%g style)
    format_dbig_g(&val, 34)
}

/// Format a DBig value in %g style with the given number of significant digits.
fn format_dbig_g(val: &DBig, sig_digits: usize) -> String {
    if *val == DBig::ZERO { return "0".to_string(); }

    // Get string representation with enough precision
    let s = format!("{}", val);

    // Parse the string to determine components
    let negative = s.starts_with('-');
    let abs_s = if negative { &s[1..] } else { &s };

    // Handle scientific notation from dashu output
    let (mantissa_str, exp_str) = if let Some(e_pos) = abs_s.to_uppercase().find('E') {
        (&abs_s[..e_pos], Some(&abs_s[e_pos+1..]))
    } else {
        (abs_s, None)
    };

    let base_exp: i64 = exp_str.and_then(|e| e.parse().ok()).unwrap_or(0);

    // Get all significant digits
    let (int_part, frac_part) = if let Some(dot) = mantissa_str.find('.') {
        (&mantissa_str[..dot], &mantissa_str[dot+1..])
    } else {
        (mantissa_str, "")
    };

    // Combine all digits
    let all_digits: String = format!("{}{}", int_part, frac_part);
    let all_digits = all_digits.trim_start_matches('0');
    if all_digits.is_empty() { return "0".to_string(); }

    // Compute actual exponent (base-10)
    let int_len = int_part.trim_start_matches('0').len();
    let actual_exp = if int_len > 0 {
        base_exp + (int_len as i64 - 1)
    } else {
        // Leading zeros in fraction
        let leading_zeros = frac_part.len() - frac_part.trim_start_matches('0').len();
        base_exp - (leading_zeros as i64 + 1)
    };

    // Truncate to sig_digits
    let sig_str = if all_digits.len() > sig_digits {
        &all_digits[..sig_digits]
    } else {
        all_digits
    };

    // Strip trailing zeros from significant digits
    let sig_trimmed = sig_str.trim_end_matches('0');
    let sig_trimmed = if sig_trimmed.is_empty() { "0" } else { sig_trimmed };

    let sign = if negative { "-" } else { "" };

    // Use %g conventions: fixed if exp in [-4, sig_digits), else scientific
    if actual_exp >= -4 && actual_exp < sig_digits as i64 {
        // Fixed-point notation
        let exp_i = actual_exp as i32;
        if exp_i >= 0 {
            let int_digits_count = (exp_i + 1) as usize;
            if int_digits_count >= sig_trimmed.len() {
                // All digits are in integer part, possibly followed by zeros
                let zeros_needed = int_digits_count - sig_trimmed.len();
                format!("{}{}{}", sign, sig_trimmed, "0".repeat(zeros_needed))
            } else {
                let int_part = &sig_trimmed[..int_digits_count];
                let frac_part = sig_trimmed[int_digits_count..].trim_end_matches('0');
                if frac_part.is_empty() {
                    format!("{}{}", sign, int_part)
                } else {
                    format!("{}{}.{}", sign, int_part, frac_part)
                }
            }
        } else {
            // exp_i < 0: 0.000...digits
            let leading_zeros = (-exp_i - 1) as usize;
            let frac = format!("{}{}", "0".repeat(leading_zeros), sig_trimmed);
            let frac_trimmed = frac.trim_end_matches('0');
            format!("{}0.{}", sign, frac_trimmed)
        }
    } else {
        // GnuCOBOL coefficient-exponent notation for FLOAT-DECIMAL:
        // Express as {integer_coeff}E{exponent} where coeff has no trailing zeros
        // and coeff * 10^exponent = the value.
        // sig_trimmed has trailing zeros already stripped.
        // actual_exp is the exponent of the leading digit (i.e., value = 0.{sig_trimmed} * 10^(actual_exp+1))
        // We want: sig_trimmed * 10^(actual_exp - sig_trimmed.len() + 1) = value
        let coeff_exp = actual_exp - (sig_trimmed.len() as i64) + 1;
        if coeff_exp == 0 {
            format!("{}{}", sign, sig_trimmed)
        } else {
            format!("{}{}E{}", sign, sig_trimmed, coeff_exp)
        }
    }
}

/// Perform a COMPUTE operation on FLOAT-DECIMAL-34 values.
/// `expr_str` is a pre-formatted decimal string result from DBig arithmetic.
/// Stores the result into the named field using full string precision.
pub fn fd34_compute(record: &mut crate::field::CobolRecord, name: &str, value_str: &str) {
    record.set_fd34_str(name, value_str);
}

/// Convert an f64 to a FLOAT-DECIMAL-34 string representation.
/// Used when COMPUTE assigns literal values to FD34 fields.
pub fn fd34_from_f64(val: f64) -> String {
    if val == 0.0 { return "0".to_string(); }
    // Use DBig to get the exact decimal representation of the f64
    let s = format!("{:.20}", val);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    let result = sp(parsed, wp(40));
    format!("{}", result)
}

/// Check if a FLOAT-DECIMAL-16 (decimal64) value would overflow.
/// decimal64 max exponent = 384 (max value ~ 9.999...E+384).
/// Now checks via f64 approximation — overflow at infinity/NaN, which
/// covers the f64 range.  For the string-based path, use fd16_is_overflow_str.
pub fn fd16_is_overflow(val: f64) -> bool {
    val.is_infinite() || val.is_nan()
}

/// Check if a FLOAT-DECIMAL-16 string value would overflow decimal64.
/// decimal64 quantum exponent range: [-398, 369].
/// Overflow occurs when the quantum exponent (for the stripped coefficient)
/// exceeds 369. The quantum exponent = normalized_exp - (coeff_digits - 1).
pub fn fd16_is_overflow_str(val_str: &str) -> bool {
    fd_check_overflow_underflow(val_str, 369, -398).0
}

/// Check if a FLOAT-DECIMAL-16 (decimal64) value would underflow.
/// decimal64 min subnormal = ~1E-398.
/// Returns true if the non-zero value underflows to zero.
pub fn fd16_is_underflow(val: f64) -> bool {
    val == 0.0
}

/// Check if a FLOAT-DECIMAL-16 string value would underflow decimal64.
/// decimal64 quantum exponent range: [-398, 369].
/// Underflow occurs when the quantum exponent < -398.
pub fn fd16_is_underflow_str(val_str: &str) -> bool {
    fd_check_overflow_underflow(val_str, 369, -398).1
}

/// Check if a FLOAT-DECIMAL-34 (decimal128) value string would overflow.
/// decimal128 quantum exponent range: [-6176, 6111].
/// Overflow occurs when the quantum exponent exceeds 6111.
pub fn fd34_is_overflow(val_str: &str) -> bool {
    fd_check_overflow_underflow(val_str, 6111, -6176).0
}

/// Check if a FLOAT-DECIMAL-34 (decimal128) value would underflow.
/// decimal128 quantum exponent range: [-6176, 6111].
/// Underflow occurs when the quantum exponent < -6176.
pub fn fd34_is_underflow(val_str: &str) -> bool {
    fd_check_overflow_underflow(val_str, 6111, -6176).1
}

/// Compute quantum exponent from a dashu-formatted decimal string and check
/// overflow/underflow against the given quantum exponent bounds.
/// Returns (is_overflow, is_underflow).
///
/// The quantum exponent is the exponent of the least-significant digit.
/// For a value like 9.9e+370, the significant digits are "99", normalized exp is 370,
/// so quantum_exp = 370 - 2 + 1 = 369.
fn fd_check_overflow_underflow(val_str: &str, max_quantum: i64, min_quantum: i64) -> (bool, bool) {
    if val_str.is_empty() || val_str == "0" { return (false, false); }

    let upper = val_str.to_uppercase();
    if upper.contains("INF") || upper.contains("NAN") { return (true, false); }

    // Parse the string to extract significant digits and normalized exponent
    let abs_s = val_str.trim_start_matches('-');

    // Separate mantissa and exponent parts
    let (mantissa_str, base_exp) = if let Some(e_pos) = abs_s.to_lowercase().find('e') {
        let m = &abs_s[..e_pos];
        let e: i64 = abs_s[e_pos+1..].parse().unwrap_or(0);
        (m, e)
    } else {
        (abs_s, 0i64)
    };

    // Extract integer and fractional parts
    let (int_part, frac_part) = if let Some(dot) = mantissa_str.find('.') {
        (&mantissa_str[..dot], &mantissa_str[dot+1..])
    } else {
        (mantissa_str, "")
    };

    // Combine all digits and strip leading zeros
    let all_digits_raw = format!("{}{}", int_part, frac_part);
    let all_digits = all_digits_raw.trim_start_matches('0');
    if all_digits.is_empty() { return (false, false); }

    // Strip trailing zeros to get the coefficient
    let coeff = all_digits.trim_end_matches('0');
    if coeff.is_empty() { return (false, false); }

    // Compute normalized exponent (exponent of the leading significant digit)
    let int_trimmed = int_part.trim_start_matches('0');
    let normalized_exp = if !int_trimmed.is_empty() {
        base_exp + (int_trimmed.len() as i64 - 1)
    } else {
        // Value < 1: count leading zeros in fraction
        let leading_frac_zeros = frac_part.len() - frac_part.trim_start_matches('0').len();
        base_exp - (leading_frac_zeros as i64 + 1)
    };

    // Quantum exponent = normalized_exp - (number of coefficient digits - 1)
    let quantum_exp = normalized_exp - (coeff.len() as i64 - 1);

    let is_overflow = quantum_exp > max_quantum;
    let is_underflow = quantum_exp < min_quantum;
    (is_overflow, is_underflow)
}

// ── String-based DBig arithmetic API ──────────────────────────────
// These functions provide DBig arithmetic without requiring the generated
// code to directly reference the `dashu` crate.  Values are passed as
// decimal strings; 140-bit working precision is used throughout.

const FD34_PREC: usize = 140;

/// Parse a decimal string to a DBig-precision string representation.
/// Handles plain decimals ("2.1") and returns the normalized string.
pub fn fd34_parse(s: &str) -> String {
    if s.is_empty() || s == "0" || s == "0.0" { return "0".to_string(); }
    let parsed: DBig = match s.parse() {
        Ok(v) => v,
        Err(_) => return "0".to_string(),
    };
    let val = sp(parsed, FD34_PREC);
    format!("{}", val)
}

/// Add two FD34 string values.
pub fn fd34_add(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD34_PREC) + sp(bv, FD34_PREC), FD34_PREC);
    format!("{}", r)
}

/// Subtract two FD34 string values (a - b).
pub fn fd34_sub(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD34_PREC) - sp(bv, FD34_PREC), FD34_PREC);
    format!("{}", r)
}

/// Multiply two FD34 string values.
pub fn fd34_mul(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD34_PREC) * sp(bv, FD34_PREC), FD34_PREC);
    format!("{}", r)
}

/// Divide two FD34 string values (a / b).
pub fn fd34_div(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    if bv == DBig::ZERO { return "0".to_string(); }
    let r = sp(sp(av, FD34_PREC) / sp(bv, FD34_PREC), FD34_PREC);
    format!("{}", r)
}

/// Raise an FD34 string value to a power (via f64 fallback).
pub fn fd34_pow(base: &str, exp: &str) -> String {
    let bv: f64 = base.parse().unwrap_or(0.0);
    let ev: f64 = exp.parse().unwrap_or(0.0);
    let result = bv.powf(ev);
    let s = format!("{:.20}", result);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    let val = sp(parsed, FD34_PREC);
    format!("{}", val)
}

/// Convert an FD34 string value to f64 (for non-FD34 targets in mixed COMPUTE).
pub fn fd34_to_f64(s: &str) -> f64 {
    s.parse::<f64>().unwrap_or(0.0)
}

/// Read an FD34 field value from a CobolRecord as a string.
pub fn fd34_read(record: &crate::field::CobolRecord, name: &str) -> String {
    record.get_fd34_str(name)
}

/// Convert an f64 value to an FD34 string for use in FD34 arithmetic.
pub fn fd34_from_f64_str(val: f64) -> String {
    if val == 0.0 { return "0".to_string(); }
    let s = format!("{:.20}", val);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    let val = sp(parsed, FD34_PREC);
    format!("{}", val)
}

// ── FLOAT-DECIMAL-16 String-based API ─────────────────────────────
// FD16 uses the same string storage approach as FD34, but with
// 16-digit precision and decimal64 overflow/underflow limits.

const FD16_PREC: usize = 80; // ~20 decimal digits working precision for 16-digit type

/// Perform a COMPUTE operation on FLOAT-DECIMAL-16 values.
pub fn fd16_compute(record: &mut crate::field::CobolRecord, name: &str, value_str: &str) {
    record.set_fd16_str(name, value_str);
}

/// Parse a decimal string for FD16 precision.
pub fn fd16_parse(s: &str) -> String {
    if s.is_empty() || s == "0" || s == "0.0" { return "0".to_string(); }
    let parsed: DBig = match s.parse() {
        Ok(v) => v,
        Err(_) => return "0".to_string(),
    };
    let val = sp(parsed, FD16_PREC);
    format!("{}", val)
}

/// Add two FD16 string values.
pub fn fd16_add(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD16_PREC) + sp(bv, FD16_PREC), FD16_PREC);
    format!("{}", r)
}

/// Subtract two FD16 string values (a - b).
pub fn fd16_sub(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD16_PREC) - sp(bv, FD16_PREC), FD16_PREC);
    format!("{}", r)
}

/// Multiply two FD16 string values.
pub fn fd16_mul(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    let r = sp(sp(av, FD16_PREC) * sp(bv, FD16_PREC), FD16_PREC);
    format!("{}", r)
}

/// Divide two FD16 string values (a / b).
pub fn fd16_div(a: &str, b: &str) -> String {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    if bv == DBig::ZERO { return "0".to_string(); }
    let r = sp(sp(av, FD16_PREC) / sp(bv, FD16_PREC), FD16_PREC);
    format!("{}", r)
}

/// Raise an FD16 string value to a power (via f64 fallback).
pub fn fd16_pow(base: &str, exp: &str) -> String {
    let bv: f64 = base.parse().unwrap_or(0.0);
    let ev: f64 = exp.parse().unwrap_or(0.0);
    let result = bv.powf(ev);
    let s = format!("{:.20}", result);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    let val = sp(parsed, FD16_PREC);
    format!("{}", val)
}

/// Convert an FD16 string value to f64.
pub fn fd16_to_f64(s: &str) -> f64 {
    s.parse::<f64>().unwrap_or(0.0)
}

/// Read an FD16 field value from a CobolRecord as a string.
pub fn fd16_read(record: &crate::field::CobolRecord, name: &str) -> String {
    record.get_fd16_str(name)
}

/// Convert an f64 value to an FD16 string.
pub fn fd16_from_f64_str(val: f64) -> String {
    if val == 0.0 { return "0".to_string(); }
    let s = format!("{:.20}", val);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    let val = sp(parsed, FD16_PREC);
    format!("{}", val)
}

/// Compare two FLOAT-DECIMAL string values.
/// Returns -1 if a < b, 0 if a == b, 1 if a > b.
/// Uses DBig for arbitrary-precision comparison (handles values beyond f64 range).
pub fn fd_cmp(a: &str, b: &str) -> i32 {
    let av: DBig = a.parse().unwrap_or(DBig::ZERO);
    let bv: DBig = b.parse().unwrap_or(DBig::ZERO);
    match av.partial_cmp(&bv) {
        Some(std::cmp::Ordering::Less) => -1,
        Some(std::cmp::Ordering::Greater) => 1,
        Some(std::cmp::Ordering::Equal) => 0,
        None => 0, // NaN-like: treat as equal for safety
    }
}
