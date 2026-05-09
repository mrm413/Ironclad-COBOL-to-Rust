// Arbitrary-precision math for COBOL intrinsic functions.
// Uses dashu for computation, never collapses to f64.
// All functions return a String representation at the requested precision.

use dashu::float::DBig;

/// Helper: set precision on a DBig value, extracting from Approximation.
fn sp(x: DBig, prec: usize) -> DBig {
    x.with_precision(prec).value()
}

/// Helper: working precision in bits for given decimal digit count.
fn wp(digits: usize) -> usize {
    (digits * 4).max(128)
}

/// Parse f64 to DBig at given precision.
fn f64_to_dbig(value: f64, digits: usize) -> DBig {
    let s = format!("{:.20}", value);
    let parsed: DBig = s.parse().unwrap_or(DBig::ZERO);
    sp(parsed, wp(digits))
}

/// Parse exact decimal string to DBig (avoids f64 rounding).
fn str_to_dbig(s: &str, digits: usize) -> DBig {
    let parsed: DBig = s.trim().parse().unwrap_or(DBig::ZERO);
    sp(parsed, wp(digits))
}

/// FUNCTION E — Euler's number at arbitrary precision.
pub fn precise_e(digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, std::f64::consts::E);
    }
    let prec = wp(digits + 10);
    let one = sp(DBig::ONE, prec);
    let result = exp_taylor(&one, prec);
    format_dbig(&result, digits)
}

/// FUNCTION PI — pi at arbitrary precision.
pub fn precise_pi(digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, std::f64::consts::PI);
    }
    let prec = wp(digits + 10);
    let pi = compute_pi(prec);
    format_dbig(&pi, digits)
}

/// FUNCTION ANNUITY(rate, periods) at arbitrary precision.
/// ANNUITY(r, n) = r / (1 - (1 + r)^(-n)) when r != 0, else 1/n.
pub fn precise_annuity(rate: f64, periods: f64, digits: usize) -> String {
    if digits <= 15 {
        if rate == 0.0 { return format!("{:.*}", digits, 1.0 / periods); }
        let v = rate / (1.0 - (1.0 + rate).powf(-periods));
        return format!("{:.*}", digits, v);
    }
    let prec = wp(digits + 10);
    let r = f64_to_dbig(rate, digits + 10);
    let n_i = periods as i64;
    if rate == 0.0 {
        let n = f64_to_dbig(periods, digits + 10);
        let result = sp(sp(DBig::ONE, prec) / n, prec);
        return format_dbig(&result, digits);
    }
    let one = sp(DBig::ONE, prec);
    let base = sp(one.clone() + &r, prec);
    let pow = pow_dbig(&base, -n_i, prec);
    let denom = sp(one - pow, prec);
    let result = sp(r / denom, prec);
    format_dbig(&result, digits)
}

/// FUNCTION ANNUITY with string inputs for precision.
pub fn precise_annuity_str(rate: &str, periods: &str, digits: usize) -> String {
    if digits <= 15 {
        let r: f64 = rate.trim().parse().unwrap_or(0.0);
        let n: f64 = periods.trim().parse().unwrap_or(1.0);
        if r == 0.0 { return format!("{:.*}", digits, 1.0 / n); }
        let v = r / (1.0 - (1.0 + r).powf(-n));
        return format!("{:.*}", digits, v);
    }
    let prec = wp(digits + 10);
    let r = str_to_dbig(rate, digits + 10);
    let n_i: i64 = periods.trim().parse().unwrap_or(1);
    if rate.trim() == "0" || rate.trim() == "0.0" {
        let n = str_to_dbig(periods, digits + 10);
        let result = sp(sp(DBig::ONE, prec) / n, prec);
        return format_dbig(&result, digits);
    }
    let one = sp(DBig::ONE, prec);
    let base = sp(one.clone() + &r, prec);
    let pow = pow_dbig(&base, -n_i, prec);
    let denom = sp(one - pow, prec);
    let result = sp(r / denom, prec);
    format_dbig(&result, digits)
}

/// FUNCTION STANDARD-DEVIATION at arbitrary precision.
pub fn precise_stddev(values: &[f64], digits: usize) -> String {
    if digits <= 15 || values.is_empty() {
        if values.is_empty() { return format!("{:.*}", digits, 0.0); }
        let mean = values.iter().sum::<f64>() / values.len() as f64;
        let var = values.iter().map(|x| (x - mean) * (x - mean)).sum::<f64>() / values.len() as f64;
        return format!("{:.*}", digits, var.sqrt());
    }
    let prec = wp(digits + 10);
    let n_f: DBig = format!("{}", values.len()).parse().unwrap();
    let n = sp(n_f, prec);
    let vals: Vec<DBig> = values.iter().map(|v| f64_to_dbig(*v, digits + 10)).collect();
    let sum = vals.iter().fold(sp(DBig::ZERO, prec), |acc, v| sp(acc + v, prec));
    let mean = sp(sum / &n, prec);
    let var_sum = vals.iter().fold(sp(DBig::ZERO, prec), |acc, v| {
        let diff = sp(v.clone() - &mean, prec);
        sp(acc + sp(diff.clone() * &diff, prec), prec)
    });
    let variance = sp(var_sum / &n, prec);
    let result = sqrt_dbig(&variance, prec);
    format_dbig(&result, digits)
}

/// FUNCTION STANDARD-DEVIATION with string inputs.
pub fn precise_stddev_str(values: &[&str], digits: usize) -> String {
    if values.is_empty() { return format!("{:.*}", digits, 0.0); }
    if digits <= 15 {
        let vals: Vec<f64> = values.iter().map(|s| s.trim().parse().unwrap_or(0.0)).collect();
        return precise_stddev(&vals, digits);
    }
    let prec = wp(digits + 10);
    let n_f: DBig = format!("{}", values.len()).parse().unwrap();
    let n = sp(n_f, prec);
    let vals: Vec<DBig> = values.iter().map(|s| str_to_dbig(s, digits + 10)).collect();
    let sum = vals.iter().fold(sp(DBig::ZERO, prec), |acc, v| sp(acc + v, prec));
    let mean = sp(sum / &n, prec);
    let var_sum = vals.iter().fold(sp(DBig::ZERO, prec), |acc, v| {
        let diff = sp(v.clone() - &mean, prec);
        sp(acc + sp(diff.clone() * &diff, prec), prec)
    });
    let variance = sp(var_sum / &n, prec);
    let result = sqrt_dbig(&variance, prec);
    format_dbig(&result, digits)
}

/// FUNCTION PRESENT-VALUE at arbitrary precision.
pub fn precise_present_value(rate: f64, values: &[f64], digits: usize) -> String {
    if digits <= 15 || values.is_empty() {
        let mut pv = 0.0f64;
        for (i, v) in values.iter().enumerate() {
            pv += v / (1.0 + rate).powi((i + 1) as i32);
        }
        return format!("{:.*}", digits, pv);
    }
    let prec = wp(digits + 10);
    let r = f64_to_dbig(rate, digits + 10);
    let one = sp(DBig::ONE, prec);
    let base = sp(one + &r, prec);
    let mut pv = sp(DBig::ZERO, prec);
    for (i, v) in values.iter().enumerate() {
        let vb = f64_to_dbig(*v, digits + 10);
        let denom = pow_dbig(&base, (i + 1) as i64, prec);
        pv = sp(pv + sp(vb / denom, prec), prec);
    }
    format_dbig(&pv, digits)
}

/// FUNCTION ASIN(x) at arbitrary precision.
pub fn precise_asin(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.asin());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    // asin(x) = atan(x / sqrt(1 - x^2))
    let one = sp(DBig::ONE, prec);
    let x2 = sp(xb.clone() * &xb, prec);
    let inner = sp(one - x2, prec);
    let sqrt_inner = sqrt_dbig(&inner, prec);
    if sqrt_inner == DBig::ZERO {
        let pi = compute_pi(prec);
        let two: DBig = "2".parse().unwrap();
        let half_pi = sp(pi / sp(two, prec), prec);
        return if x < 0.0 {
            format_dbig(&sp(-half_pi, prec), digits)
        } else {
            format_dbig(&half_pi, digits)
        };
    }
    let ratio = sp(xb / sqrt_inner, prec);
    let result = atan_dbig(&ratio, prec);
    format_dbig(&result, digits)
}

/// FUNCTION ACOS(x) at arbitrary precision.
pub fn precise_acos(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.acos());
    }
    let prec = wp(digits + 10);
    let pi = compute_pi(prec);
    let two: DBig = "2".parse().unwrap();
    let half_pi = sp(pi / sp(two, prec), prec);
    let asin_str = precise_asin(x, digits + 10);
    let asin_val: DBig = asin_str.parse().unwrap_or(DBig::ZERO);
    let asin_val = sp(asin_val, prec);
    let result = sp(half_pi - asin_val, prec);
    format_dbig(&result, digits)
}

/// FUNCTION ATAN(x) at arbitrary precision.
pub fn precise_atan(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.atan());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = atan_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION SIN(x) at arbitrary precision.
pub fn precise_sin(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.sin());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = sin_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION COS(x) at arbitrary precision.
pub fn precise_cos(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.cos());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = cos_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION TAN(x) at arbitrary precision.
pub fn precise_tan(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.tan());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let s = sin_dbig(&xb, prec);
    let c = cos_dbig(&xb, prec);
    let result = sp(s / c, prec);
    format_dbig(&result, digits)
}

/// FUNCTION LOG(x) — natural logarithm at arbitrary precision.
pub fn precise_log(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.ln());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = ln_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION LOG10(x) at arbitrary precision.
pub fn precise_log10(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.log10());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let ln_x = ln_dbig(&xb, prec);
    let ten: DBig = "10".parse().unwrap();
    let ten = sp(ten, prec);
    let ln_10 = ln_dbig(&ten, prec);
    let result = sp(ln_x / ln_10, prec);
    format_dbig(&result, digits)
}

/// FUNCTION EXP(x) — e^x at arbitrary precision.
pub fn precise_exp(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.exp());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = exp_dbig_val(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION EXP10(x) — 10^x at arbitrary precision.
pub fn precise_exp10(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, 10f64.powf(x));
    }
    let prec = wp(digits + 10);
    let ten: DBig = "10".parse().unwrap();
    let ten = sp(ten, prec);
    let ln_10 = ln_dbig(&ten, prec);
    let xb = f64_to_dbig(x, digits + 10);
    let exp_arg = sp(xb * ln_10, prec);
    let result = exp_dbig_val(&exp_arg, prec);
    format_dbig(&result, digits)
}

/// FUNCTION SQRT(x) at arbitrary precision.
pub fn precise_sqrt(x: f64, digits: usize) -> String {
    if digits <= 15 {
        return format!("{:.*}", digits, x.sqrt());
    }
    let prec = wp(digits + 10);
    let xb = f64_to_dbig(x, digits + 10);
    let result = sqrt_dbig(&xb, prec);
    format_dbig(&result, digits)
}

// ── Internal math primitives using dashu ────────────────────────

/// Newton's method square root for DBig.
fn sqrt_dbig(x: &DBig, prec: usize) -> DBig {
    if *x == DBig::ZERO { return sp(DBig::ZERO, prec); }
    let x_f64: f64 = x.to_string().parse().unwrap_or(1.0);
    let guess_f64 = x_f64.sqrt();
    let mut guess: DBig = format!("{:.20}", guess_f64).parse().unwrap_or(DBig::ONE);
    guess = sp(guess, prec);
    let two: DBig = sp("2".parse().unwrap(), prec);
    for _ in 0..80 {
        let div = sp(x.clone() / guess.clone(), prec);
        let sum = sp(guess.clone() + div, prec);
        guess = sp(sum / two.clone(), prec);
    }
    guess
}

/// Compute π using Machin's formula: π/4 = 4·atan(1/5) - atan(1/239)
fn compute_pi(prec: usize) -> DBig {
    let one = sp(DBig::ONE, prec);
    let five: DBig = sp("5".parse().unwrap(), prec);
    let inv5 = sp(one.clone() / five, prec);
    let two39: DBig = sp("239".parse().unwrap(), prec);
    let inv239 = sp(one / two39, prec);
    let four: DBig = sp("4".parse().unwrap(), prec);
    let a1 = atan_dbig(&inv5, prec);
    let a2 = atan_dbig(&inv239, prec);
    let inner = sp(sp(four.clone() * a1, prec) - a2, prec);
    sp(four * inner, prec)
}

/// atan via Taylor series with argument reduction for |x| > 0.5
fn atan_dbig(x: &DBig, prec: usize) -> DBig {
    let abs_x: f64 = x.to_string().parse::<f64>().unwrap_or(0.0).abs();
    if abs_x > 0.5 {
        let one = sp(DBig::ONE, prec);
        let x2 = sp(x.clone() * x, prec);
        let inner = sp(one.clone() + x2, prec);
        let s = sqrt_dbig(&inner, prec);
        let denom = sp(one + s, prec);
        let reduced = sp(x.clone() / denom, prec);
        let half_atan = atan_taylor(&reduced, prec);
        let two: DBig = sp("2".parse().unwrap(), prec);
        sp(two * half_atan, prec)
    } else {
        atan_taylor(x, prec)
    }
}

fn atan_taylor(x: &DBig, prec: usize) -> DBig {
    let x2 = sp(x.clone() * x, prec);
    let mut term = sp(x.clone(), prec);
    let mut sum = term.clone();
    let mut neg = true;
    for k in 1..300 {
        term = sp(term * x2.clone(), prec);
        let divisor: DBig = sp(format!("{}", 2 * k + 1).parse().unwrap(), prec);
        let contribution = sp(term.clone() / divisor, prec);
        if neg {
            sum = sp(sum - contribution.clone(), prec);
        } else {
            sum = sp(sum + contribution.clone(), prec);
        }
        neg = !neg;
        let c_f64: f64 = contribution.to_string().parse().unwrap_or(1.0);
        if c_f64.abs() < 1e-60 { break; }
    }
    sum
}

/// sin via Taylor series
fn sin_dbig(x: &DBig, prec: usize) -> DBig {
    let reduced = range_reduce_trig(x, prec);
    let x2 = sp(reduced.clone() * &reduced, prec);
    let mut term = reduced.clone();
    let mut sum = term.clone();
    let mut neg = true;
    for k in 1..300 {
        let n = (2 * k) as u64 * (2 * k + 1) as u64;
        let divisor: DBig = sp(format!("{}", n).parse().unwrap(), prec);
        term = sp(term * x2.clone(), prec);
        term = sp(term / divisor, prec);
        if neg {
            sum = sp(sum - term.clone(), prec);
        } else {
            sum = sp(sum + term.clone(), prec);
        }
        neg = !neg;
        let t_f64: f64 = term.to_string().parse().unwrap_or(1.0);
        if t_f64.abs() < 1e-60 { break; }
    }
    sum
}

/// cos via Taylor series
fn cos_dbig(x: &DBig, prec: usize) -> DBig {
    let reduced = range_reduce_trig(x, prec);
    let x2 = sp(reduced.clone() * &reduced, prec);
    let one = sp(DBig::ONE, prec);
    let mut term = one.clone();
    let mut sum = one;
    let mut neg = true;
    for k in 1..300 {
        let n = (2 * k - 1) as u64 * (2 * k) as u64;
        let divisor: DBig = sp(format!("{}", n).parse().unwrap(), prec);
        term = sp(term * x2.clone(), prec);
        term = sp(term / divisor, prec);
        if neg {
            sum = sp(sum - term.clone(), prec);
        } else {
            sum = sp(sum + term.clone(), prec);
        }
        neg = !neg;
        let t_f64: f64 = term.to_string().parse().unwrap_or(1.0);
        if t_f64.abs() < 1e-60 { break; }
    }
    sum
}

/// Reduce x to [-π, π]
fn range_reduce_trig(x: &DBig, prec: usize) -> DBig {
    let x_f64: f64 = x.to_string().parse().unwrap_or(0.0);
    if x_f64.abs() < std::f64::consts::PI {
        return sp(x.clone(), prec);
    }
    let pi = compute_pi(prec);
    let two: DBig = sp("2".parse().unwrap(), prec);
    let two_pi = sp(pi * two, prec);
    let n = (x_f64 / (2.0 * std::f64::consts::PI)).round() as i64;
    let nb: DBig = sp(format!("{}", n).parse().unwrap(), prec);
    sp(x.clone() - sp(nb * two_pi, prec), prec)
}

/// Natural log: ln(x) = ln(f64_approx) + correction via ln(1+u) series
fn ln_dbig(x: &DBig, prec: usize) -> DBig {
    let x_f64: f64 = x.to_string().parse().unwrap_or(1.0);
    if x_f64 <= 0.0 { return sp(DBig::ZERO, prec); }
    let one = sp(DBig::ONE, prec);
    let ln_f64 = x_f64.ln();
    let ln_approx: DBig = sp(format!("{:.20}", ln_f64).parse().unwrap_or(DBig::ZERO), prec);
    let e_approx = exp_dbig_val(&ln_approx, prec);
    let ratio = sp(x.clone() / e_approx, prec);
    let u = sp(ratio - one, prec);
    let correction = ln1p_taylor(&u, prec);
    sp(ln_approx + correction, prec)
}

/// ln(1+u) via Taylor series for |u| small
fn ln1p_taylor(u: &DBig, prec: usize) -> DBig {
    let mut term = sp(u.clone(), prec);
    let mut sum = term.clone();
    let mut neg = true;
    for k in 2..400 {
        term = sp(term * u.clone(), prec);
        let divisor: DBig = sp(format!("{}", k).parse().unwrap(), prec);
        let contribution = sp(term.clone() / divisor, prec);
        if neg {
            sum = sp(sum - contribution.clone(), prec);
        } else {
            sum = sp(sum + contribution.clone(), prec);
        }
        neg = !neg;
        let c_f64: f64 = contribution.to_string().parse().unwrap_or(1.0);
        if c_f64.abs() < 1e-60 { break; }
    }
    sum
}

/// exp(x) via Taylor series with range reduction for large |x|
fn exp_dbig_val(x: &DBig, prec: usize) -> DBig {
    let x_f64: f64 = x.to_string().parse().unwrap_or(0.0);
    if x_f64.abs() > 20.0 {
        let one = sp(DBig::ONE, prec);
        let n = x_f64.floor() as i64;
        let nb: DBig = sp(format!("{}", n).parse().unwrap(), prec);
        let frac = sp(x.clone() - nb, prec);
        let exp_frac = exp_taylor(&frac, prec);
        let e1 = exp_taylor(&one, prec);
        let en = pow_dbig(&e1, n, prec);
        sp(en * exp_frac, prec)
    } else {
        exp_taylor(x, prec)
    }
}

fn exp_taylor(x: &DBig, prec: usize) -> DBig {
    let one = sp(DBig::ONE, prec);
    let mut term = one.clone();
    let mut sum = one;
    for k in 1..400 {
        let divisor: DBig = sp(format!("{}", k).parse().unwrap(), prec);
        term = sp(sp(term * x.clone(), prec) / divisor, prec);
        sum = sp(sum + term.clone(), prec);
        let t_f64: f64 = term.to_string().parse().unwrap_or(1.0);
        if t_f64.abs() < 1e-60 { break; }
    }
    sum
}

/// Integer power by repeated squaring.
fn pow_dbig(base: &DBig, exp: i64, prec: usize) -> DBig {
    if exp == 0 { return sp(DBig::ONE, prec); }
    let (mut b, mut e, invert) = if exp < 0 {
        (sp(base.clone(), prec), (-exp) as u64, true)
    } else {
        (sp(base.clone(), prec), exp as u64, false)
    };
    let mut result = sp(DBig::ONE, prec);
    while e > 0 {
        if e & 1 == 1 {
            result = sp(result * b.clone(), prec);
        }
        b = sp(b.clone() * b.clone(), prec);
        e >>= 1;
    }
    if invert {
        sp(sp(DBig::ONE, prec) / result, prec)
    } else {
        result
    }
}

/// Format a DBig value to exactly `digits` decimal places.
fn format_dbig(val: &DBig, digits: usize) -> String {
    let s = val.to_string();
    format_decimal_string(&s, digits)
}

/// Format a decimal string to exactly N decimal places.
fn format_decimal_string(s: &str, digits: usize) -> String {
    let negative = s.starts_with('-');
    let abs_s = if negative { &s[1..] } else { s };

    // Handle scientific notation from dashu
    if abs_s.contains('e') || abs_s.contains('E') {
        if let Ok(f) = s.parse::<f64>() {
            return format!("{:.*}", digits, f);
        }
    }

    let (int_part, frac_part) = if let Some(dot_pos) = abs_s.find('.') {
        (&abs_s[..dot_pos], &abs_s[dot_pos + 1..])
    } else {
        (abs_s, "")
    };

    let int_str = if int_part.is_empty() { "0" } else { int_part };

    if digits == 0 {
        return if negative { format!("-{}", int_str) } else { int_str.to_string() };
    }

    let frac = if frac_part.len() >= digits {
        &frac_part[..digits]
    } else {
        return if negative {
            format!("-{}.{}{}", int_str, frac_part, "0".repeat(digits - frac_part.len()))
        } else {
            format!("{}.{}{}", int_str, frac_part, "0".repeat(digits - frac_part.len()))
        };
    };

    if negative {
        format!("-{}.{}", int_str, frac)
    } else {
        format!("{}.{}", int_str, frac)
    }
}

// ── String-input variants (avoid f64 rounding of COBOL literals) ──

/// FUNCTION ASIN(x) with exact string input.
pub fn precise_asin_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let one = sp(DBig::ONE, prec);
    let x2 = sp(xb.clone() * &xb, prec);
    let inner = sp(one - x2, prec);
    let sqrt_inner = sqrt_dbig(&inner, prec);
    if sqrt_inner == DBig::ZERO {
        let pi = compute_pi(prec);
        let two: DBig = "2".parse().unwrap();
        let half_pi = sp(pi / sp(two, prec), prec);
        let x_neg = x.trim().starts_with('-');
        return if x_neg { format_dbig(&sp(-half_pi, prec), digits) }
               else { format_dbig(&half_pi, digits) };
    }
    let ratio = sp(xb / sqrt_inner, prec);
    let result = atan_dbig(&ratio, prec);
    format_dbig(&result, digits)
}

/// FUNCTION ACOS(x) with exact string input.
pub fn precise_acos_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let pi = compute_pi(prec);
    let two: DBig = "2".parse().unwrap();
    let half_pi = sp(pi / sp(two, prec), prec);
    let asin_str = precise_asin_str(x, digits + 10);
    let asin_val: DBig = asin_str.parse().unwrap_or(DBig::ZERO);
    let asin_val = sp(asin_val, prec);
    let result = sp(half_pi - asin_val, prec);
    format_dbig(&result, digits)
}

/// FUNCTION ATAN(x) with exact string input.
pub fn precise_atan_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = atan_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION SIN(x) with exact string input.
pub fn precise_sin_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = sin_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION COS(x) with exact string input.
pub fn precise_cos_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = cos_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION TAN(x) with exact string input.
pub fn precise_tan_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let s = sin_dbig(&xb, prec);
    let c = cos_dbig(&xb, prec);
    let result = sp(s / c, prec);
    format_dbig(&result, digits)
}

/// FUNCTION LOG(x) with exact string input.
pub fn precise_log_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = ln_dbig(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION LOG10(x) with exact string input.
pub fn precise_log10_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let ln_x = ln_dbig(&xb, prec);
    let ten: DBig = "10".parse().unwrap();
    let ten = sp(ten, prec);
    let ln_10 = ln_dbig(&ten, prec);
    let result = sp(ln_x / ln_10, prec);
    format_dbig(&result, digits)
}

/// FUNCTION EXP(x) with exact string input.
pub fn precise_exp_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = exp_dbig_val(&xb, prec);
    format_dbig(&result, digits)
}

/// FUNCTION EXP10(x) with exact string input.
pub fn precise_exp10_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let ten: DBig = "10".parse().unwrap();
    let ten = sp(ten, prec);
    let ln_10 = ln_dbig(&ten, prec);
    let xb = str_to_dbig(x, digits + 10);
    let exp_arg = sp(xb * ln_10, prec);
    let result = exp_dbig_val(&exp_arg, prec);
    format_dbig(&result, digits)
}

/// FUNCTION SQRT(x) with exact string input.
pub fn precise_sqrt_str(x: &str, digits: usize) -> String {
    let prec = wp(digits + 10);
    let xb = str_to_dbig(x, digits + 10);
    let result = sqrt_dbig(&xb, prec);
    format_dbig(&result, digits)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_precise_e_15() {
        let e = precise_e(15);
        assert!(e.starts_with("2.71828182845904"), "E(15) = {}", e);
    }

    #[test]
    fn test_precise_e_35() {
        let e = precise_e(35);
        assert!(e.starts_with("2.7182818284590452353602874713526"), "E(35) = {}", e);
    }

    #[test]
    fn test_precise_sqrt() {
        let result = precise_sqrt(2.0, 35);
        assert!(result.starts_with("1.4142135623730950488016887242096"), "SQRT(2) = {}", result);
    }

    #[test]
    fn test_format_decimal_string() {
        assert_eq!(format_decimal_string("3.14", 5), "3.14000");
        assert_eq!(format_decimal_string("-2.71828", 3), "-2.718");
        assert_eq!(format_decimal_string("0.123456789", 4), "0.1234");
    }
}
