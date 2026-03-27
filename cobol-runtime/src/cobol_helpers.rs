// cobol_helpers.rs — Shared helper functions for Ironclad-generated Rust programs.
//
// These functions implement COBOL intrinsic functions, reference modification,
// INSPECT, and other runtime operations. They live here so generated programs
// can `use cobol_runtime::cobol_helpers::*;` instead of duplicating code.

use crate::Decimal;

/// FUNCTION CURRENT-DATE -> "YYYYMMDDHHMMSScc+HHMM" (21 chars)
pub fn cobol_fn_current_date() -> String {
    let now = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs();
    let secs = now as i64;
    let days = secs / 86400;
    let day_secs = (secs % 86400) as u32;
    let hh = day_secs / 3600;
    let mm = (day_secs % 3600) / 60;
    let ss = day_secs % 60;
    let (y, m, d) = epoch_days_to_ymd(days + 719468);
    format!("{:04}{:02}{:02}{:02}{:02}{:02}00+0000", y, m, d, hh, mm, ss)
}

fn epoch_days_to_ymd(z: i64) -> (i64, u32, u32) {
    let era = if z >= 0 { z } else { z - 146096 } / 146097;
    let doe = (z - era * 146097) as u32;
    let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
    let y = yoe as i64 + era * 400;
    let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
    let mp = (5 * doy + 2) / 153;
    let d = doy - (153 * mp + 2) / 5 + 1;
    let m = if mp < 10 { mp + 3 } else { mp - 9 };
    let y = if m <= 2 { y + 1 } else { y };
    (y, m, d)
}

/// FUNCTION UPPER-CASE
pub fn cobol_fn_upper_case(s: &str) -> String { s.to_uppercase() }

/// FUNCTION LOWER-CASE
pub fn cobol_fn_lower_case(s: &str) -> String { s.to_lowercase() }

/// FUNCTION TRIM
pub fn cobol_fn_trim(s: &str) -> String { s.trim().to_string() }

/// FUNCTION LENGTH
pub fn cobol_fn_length(s: &str) -> i64 { s.len() as i64 }

/// FUNCTION REVERSE
pub fn cobol_fn_reverse(s: &str) -> String { s.chars().rev().collect() }

/// FUNCTION MOD
pub fn cobol_fn_mod(a: &str, b: &str) -> String {
    let va: i64 = a.trim().parse().unwrap_or(0);
    let vb: i64 = b.trim().parse().unwrap_or(1);
    format!("{}", if vb == 0 { 0 } else { ((va % vb) + vb) % vb })
}

/// FUNCTION NUMVAL-C
pub fn cobol_fn_numval_c(s: &str) -> Decimal {
    let cleaned: String = s.chars().filter(|c| c.is_ascii_digit() || *c == '.' || *c == '-').collect();
    cleaned.parse::<f64>().map(Decimal::from).unwrap_or_default()
}

/// FUNCTION TEST-NUMVAL-C (returns 0 if valid, position of error otherwise)
pub fn cobol_fn_test_numval_c(s: &str) -> i64 {
    let trimmed = s.trim();
    if trimmed.is_empty() { return 1; }
    let cleaned: String = trimmed.chars().filter(|c| *c != ',' && *c != '$' && *c != ' ').collect();
    match cleaned.parse::<f64>() {
        Ok(_) => 0,
        Err(_) => 1,
    }
}

/// FUNCTION NUMVAL
pub fn cobol_fn_numval(s: &str) -> Decimal {
    let trimmed = s.trim();
    trimmed.parse::<f64>().map(Decimal::from).unwrap_or_default()
}

/// FUNCTION TEST-NUMVAL (returns 0 if valid)
pub fn cobol_fn_test_numval(s: &str) -> i64 {
    let trimmed = s.trim();
    if trimmed.is_empty() { return 1; }
    match trimmed.parse::<f64>() {
        Ok(_) => 0,
        Err(_) => 1,
    }
}

/// FUNCTION INTEGER-OF-DATE(YYYYMMDD) -> integer day count
pub fn cobol_fn_integer_of_date(s: &str) -> String {
    let yyyymmdd: i64 = s.trim().parse().unwrap_or(0);
    let y = yyyymmdd / 10000;
    let m = (yyyymmdd % 10000) / 100;
    let d = yyyymmdd % 100;
    let a = (14 - m) / 12;
    let y2 = y + 4800 - a;
    let m2 = m + 12 * a - 3;
    format!("{}", d + (153 * m2 + 2) / 5 + 365 * y2 + y2 / 4 - y2 / 100 + y2 / 400 - 32045)
}

/// FUNCTION INTEGER(x) -> truncate toward zero
pub fn cobol_fn_integer(x: &str) -> String {
    let v: f64 = x.trim().parse().unwrap_or(0.0);
    format!("{}", v as i64)
}

/// FUNCTION DATE-OF-INTEGER(n) -> YYYYMMDD
pub fn cobol_fn_date_of_integer(s: &str) -> String {
    let n: i64 = s.trim().parse().unwrap_or(0);
    let a = n + 32044;
    let b = (4 * a + 3) / 146097;
    let c = a - (146097 * b) / 4;
    let d = (4 * c + 3) / 1461;
    let e = c - (1461 * d) / 4;
    let m = (5 * e + 2) / 153;
    let day = e - (153 * m + 2) / 5 + 1;
    let month = m + 3 - 12 * (m / 10);
    let year = 100 * b + d - 4800 + m / 10;
    format!("{}", year * 10000 + month * 100 + day)
}

/// FUNCTION WHEN-COMPILED -> "YYYYMMDDHHMMSScc"
pub fn cobol_fn_when_compiled() -> String {
    let cd = cobol_fn_current_date();
    cd[..16].to_string()
}

/// COBOL format helper for STRING verb
pub fn cobol_fmt(val: &dyn std::fmt::Display) -> String { format!("{}", val) }

/// Reference modification: s(start:length), 1-based
pub fn cobol_refmod(s: &str, start: usize, length: usize) -> String {
    if start == 0 || start > s.len() { return String::new(); }
    let begin = start - 1;
    let end = (begin + length).min(s.len());
    s[begin..end].to_string()
}

/// INSPECT CONVERTING — returns new string with character translation
pub fn cobol_inspect_converting(s: &str, from: &str, to: &str) -> String {
    let from_chars: Vec<char> = from.chars().collect();
    let to_chars: Vec<char> = to.chars().collect();
    let mut result = String::with_capacity(s.len());
    for ch in s.chars() {
        if let Some(pos) = from_chars.iter().position(|&c| c == ch) {
            if pos < to_chars.len() {
                result.push(to_chars[pos]);
            } else {
                result.push(ch);
            }
        } else {
            result.push(ch);
        }
    }
    result
}

/// INSPECT TALLYING (count occurrences)
pub fn cobol_inspect_tallying_count(s: &str) -> i32 {
    s.len() as i32
}

/// FUNCTION FORMATTED-DATETIME — accepts 2-5 &str args (variadic-safe)
pub fn cobol_fn_formatted_datetime(fmt: &str, date_s: &str, time_s: &str, offset_s: &str, sys_offset_s: &str) -> String {
    let date: i64 = date_s.trim().parse().unwrap_or(0);
    let time: i64 = time_s.trim().parse().unwrap_or(0);
    let _ = (offset_s, sys_offset_s);
    let (y, m, d) = if date > 19000000 {
        (date / 10000, (date % 10000) / 100, date % 100)
    } else {
        let dt_s = cobol_fn_date_of_integer(date_s);
        let dt: i64 = dt_s.trim().parse().unwrap_or(0);
        (dt / 10000, (dt % 10000) / 100, dt % 100)
    };
    let hh = time / 10000;
    let mm = (time % 10000) / 100;
    let ss = time % 100;
    let iod_s = cobol_fn_integer_of_date(&format!("{}", y * 10000 + m * 100 + d));
    let iod: i64 = iod_s.trim().parse().unwrap_or(0);
    fmt.replace("YYYY", &format!("{:04}", y))
        .replace("MM", &format!("{:02}", m))
        .replace("DD", &format!("{:02}", d))
        .replace("DDD", &format!("{:03}", iod % 1000))
        .replace("hh", &format!("{:02}", hh))
        .replace("mm", &format!("{:02}", mm))
        .replace("ss", &format!("{:02}", ss))
        .replace("Z", "+0000")
}

/// FUNCTION FORMATTED-TIME — accepts 2-4 &str args (variadic-safe)
pub fn cobol_fn_formatted_time(fmt: &str, time_s: &str, offset_s: &str, sys_offset_s: &str) -> String {
    let time: i64 = time_s.trim().parse().unwrap_or(0);
    let _ = (offset_s, sys_offset_s);
    let hh = time / 10000;
    let mm = (time % 10000) / 100;
    let ss = time % 100;
    fmt.replace("hh", &format!("{:02}", hh))
       .replace("mm", &format!("{:02}", mm))
       .replace("ss", &format!("{:02}", ss))
       .replace("Z", "+0000")
}

/// FUNCTION EXCEPTION-STATUS — returns last exception condition name.
/// Stubbed: screen exceptions not supported in batch mode.
pub fn cobol_fn_exception_status() -> String {
    String::new()
}

/// SYSTEM-OFFSET — system timezone offset in minutes from UTC.
pub fn cobol_system_offset() -> i64 {
    0 // UTC by default in portable mode
}

/// CEE3ABD — IBM LE abend routine (stubbed)
pub fn cee3abd(_code: i32, _timing: i32) {
    std::process::exit(1);
}

/// CEEDAYS — IBM LE days conversion (stubbed)
pub fn ceedays(_date: &str, _fmt: &str, _output: &mut i64, _fc: &mut i32) {
    *_output = 0;
    *_fc = 0;
}

// ---------------------------------------------------------------------------
// Math intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_abs(x: &str) -> String {
    let v: f64 = x.trim().parse().unwrap_or(0.0);
    format!("{}", v.abs())
}
pub fn cobol_fn_acos(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.acos()) }
pub fn cobol_fn_asin(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.asin()) }
pub fn cobol_fn_atan(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.atan()) }
pub fn cobol_fn_cos(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.cos()) }
pub fn cobol_fn_sin(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.sin()) }
pub fn cobol_fn_tan(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.tan()) }
pub fn cobol_fn_sqrt(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.sqrt()) }
pub fn cobol_fn_exp(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.exp()) }
pub fn cobol_fn_exp10(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", 10.0_f64.powf(v)) }
pub fn cobol_fn_log(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(1.0); format!("{}", v.ln()) }
pub fn cobol_fn_log10(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(1.0); format!("{}", v.log10()) }
pub fn cobol_fn_factorial(x: &str) -> String {
    let n: u64 = x.trim().parse().unwrap_or(0);
    let mut r: u64 = 1;
    for i in 2..=n { r = r.saturating_mul(i); }
    format!("{}", r)
}
pub fn cobol_fn_sign(x: &str) -> String {
    let v: f64 = x.trim().parse().unwrap_or(0.0);
    if v > 0.0 { "1".into() } else if v < 0.0 { "-1".into() } else { "0".into() }
}
pub fn cobol_fn_integer_part(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.trunc()) }
pub fn cobol_fn_fraction_part(x: &str) -> String { let v: f64 = x.trim().parse().unwrap_or(0.0); format!("{}", v.fract()) }
pub fn cobol_fn_rem(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(1.0);
    format!("{}", va % vb)
}
pub fn cobol_fn_random(seed: &str) -> String {
    let s: u64 = seed.trim().parse().unwrap_or(0);
    // Simple LCG pseudo-random for deterministic output
    let r = ((s.wrapping_mul(6364136223846793005).wrapping_add(1442695040888963407)) >> 33) as f64 / (u32::MAX as f64);
    format!("{:.10}", r)
}
pub fn cobol_fn_annuity(rate: &str, periods: &str) -> String {
    let r: f64 = rate.trim().parse().unwrap_or(0.0);
    let n: f64 = periods.trim().parse().unwrap_or(1.0);
    if r == 0.0 { format!("{}", 1.0 / n) }
    else { format!("{}", r / (1.0 - (1.0 + r).powf(-n))) }
}
pub fn cobol_fn_present_value(rate: &str, amounts: &str) -> String {
    let r: f64 = rate.trim().parse().unwrap_or(0.0);
    let a: f64 = amounts.trim().parse().unwrap_or(0.0);
    if r == 0.0 { format!("{}", a) }
    else { format!("{}", a / (1.0 + r)) }
}

// ---------------------------------------------------------------------------
// Aggregate / variadic intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_min(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", va.min(vb))
}
pub fn cobol_fn_max(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", va.max(vb))
}
pub fn cobol_fn_mean(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", (va + vb) / 2.0)
}
pub fn cobol_fn_median(a: &str, b: &str) -> String { cobol_fn_mean(a, b) }
pub fn cobol_fn_sum(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", va + vb)
}
pub fn cobol_fn_range(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", (va - vb).abs())
}
pub fn cobol_fn_variance(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    let mean = (va + vb) / 2.0;
    format!("{}", ((va - mean).powi(2) + (vb - mean).powi(2)) / 2.0)
}
pub fn cobol_fn_standard_deviation(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    let mean = (va + vb) / 2.0;
    let var = ((va - mean).powi(2) + (vb - mean).powi(2)) / 2.0;
    format!("{}", var.sqrt())
}
pub fn cobol_fn_ord(c: &str) -> i64 { c.bytes().next().unwrap_or(0) as i64 }
pub fn cobol_fn_ord_max(a: &str, b: &str) -> String {
    if a >= b { "1".into() } else { "2".into() }
}
pub fn cobol_fn_ord_min(a: &str, b: &str) -> String {
    if a <= b { "1".into() } else { "2".into() }
}
pub fn cobol_fn_char(n: &str) -> String {
    let v: u8 = n.trim().parse().unwrap_or(32);
    String::from(v as char)
}

// ---------------------------------------------------------------------------
// String / text intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_substitute(src: &str, from: &str, to: &str) -> String {
    src.replace(from, to)
}
pub fn cobol_fn_byte_length(s: &str) -> i64 { s.len() as i64 }
pub fn cobol_fn_stored_char_length(s: &str) -> i64 { s.trim_end().len() as i64 }
pub fn cobol_fn_content_length(s: &str) -> i64 { s.trim().len() as i64 }
pub fn cobol_fn_concatenate(a: &str, b: &str) -> String { format!("{}{}", a, b) }
pub fn cobol_fn_hex_of(s: &str) -> String {
    s.bytes().map(|b| format!("{:02X}", b)).collect()
}
pub fn cobol_fn_hex_to_char(s: &str) -> String {
    let bytes: Vec<u8> = (0..s.len()).step_by(2)
        .filter_map(|i| u8::from_str_radix(&s[i..i+2], 16).ok())
        .collect();
    String::from_utf8_lossy(&bytes).into_owned()
}
pub fn cobol_fn_bit_of(s: &str) -> String {
    s.bytes().map(|b| format!("{:08b}", b)).collect()
}
pub fn cobol_fn_bit_to_char(s: &str) -> String {
    let bytes: Vec<u8> = (0..s.len()).step_by(8)
        .filter_map(|i| {
            let end = (i + 8).min(s.len());
            u8::from_str_radix(&s[i..end], 2).ok()
        })
        .collect();
    String::from_utf8_lossy(&bytes).into_owned()
}

// ---------------------------------------------------------------------------
// Date/time intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_integer_of_day(s: &str) -> String {
    let yyyyddd: i64 = s.trim().parse().unwrap_or(0);
    let year = yyyyddd / 1000;
    let doy = yyyyddd % 1000;
    let y = year - 1;
    format!("{}", y * 365 + y / 4 - y / 100 + y / 400 + doy)
}
pub fn cobol_fn_day_of_integer(n_s: &str) -> String {
    // Inverse of integer_of_day — approximate
    let d_s = cobol_fn_date_of_integer(n_s);
    let d: i64 = d_s.trim().parse().unwrap_or(0);
    let year = d / 10000;
    let month = (d / 100) % 100;
    let day = d % 100;
    let doy = day + (month - 1) * 30; // rough approximation
    format!("{}", year * 1000 + doy)
}
pub fn cobol_fn_date_to_yyyymmdd(date: &str, century_window: &str) -> String {
    let d: i64 = date.trim().parse().unwrap_or(0);
    let cw: i64 = century_window.trim().parse().unwrap_or(50);
    if d > 999999 { return format!("{}", d); } // already 8-digit
    let yy = d / 10000;
    let mmdd = d % 10000;
    let yyyy = if yy >= cw { 1900 + yy } else { 2000 + yy };
    format!("{}{:04}", yyyy, mmdd)
}
pub fn cobol_fn_day_to_yyyyddd(day: &str, century_window: &str) -> String {
    let d: i64 = day.trim().parse().unwrap_or(0);
    let cw: i64 = century_window.trim().parse().unwrap_or(50);
    if d > 99999 { return format!("{}", d); }
    let yy = d / 1000;
    let ddd = d % 1000;
    let yyyy = if yy >= cw { 1900 + yy } else { 2000 + yy };
    format!("{}{:03}", yyyy, ddd)
}
pub fn cobol_fn_year_to_yyyy(yy: &str, century_window: &str) -> String {
    let y: i64 = yy.trim().parse().unwrap_or(0);
    let cw: i64 = century_window.trim().parse().unwrap_or(50);
    let yyyy = if y >= cw { 1900 + y } else { 2000 + y };
    format!("{}", yyyy)
}
pub fn cobol_fn_test_date_yyyymmdd(date: &str) -> i64 {
    let d: i64 = date.trim().parse().unwrap_or(0);
    let month = (d / 100) % 100;
    let day = d % 100;
    if month >= 1 && month <= 12 && day >= 1 && day <= 31 { 0 } else { 1 }
}
pub fn cobol_fn_test_day_yyyyddd(day: &str) -> i64 {
    let d: i64 = day.trim().parse().unwrap_or(0);
    let doy = d % 1000;
    if doy >= 1 && doy <= 366 { 0 } else { 1 }
}
pub fn cobol_fn_test_formatted_datetime(fmt: &str, val: &str) -> i64 {
    // Return 0 if valid (non-empty matching format), 1 otherwise
    if !val.is_empty() && val.len() >= fmt.len() { 0 } else { 1 }
}
pub fn cobol_fn_test_numval_f(s: &str) -> i64 {
    if s.trim().parse::<f64>().is_ok() { 0 } else { 1 }
}
pub fn cobol_fn_seconds_past_midnight() -> String {
    let now = cobol_fn_current_date();
    if now.len() >= 12 {
        let hh: f64 = now[9..11].parse().unwrap_or(0.0);
        let mm: f64 = now[11..13].parse().unwrap_or(0.0);
        let ss: f64 = if now.len() >= 14 { now[13..15].parse().unwrap_or(0.0) } else { 0.0 };
        format!("{}", hh * 3600.0 + mm * 60.0 + ss)
    } else {
        "0".into()
    }
}
pub fn cobol_fn_seconds_from_formatted_time(fmt: &str, time: &str) -> String {
    // Parse HH:MM:SS or HHMMSS format
    let t = time.trim().replace(':', "");
    if t.len() >= 6 {
        let hh: f64 = t[0..2].parse().unwrap_or(0.0);
        let mm: f64 = t[2..4].parse().unwrap_or(0.0);
        let ss: f64 = t[4..6].parse().unwrap_or(0.0);
        format!("{}", hh * 3600.0 + mm * 60.0 + ss)
    } else {
        let _ = fmt; // acknowledge format arg
        "0".into()
    }
}
pub fn cobol_fn_formatted_date(fmt: &str, date: &str) -> String {
    cobol_fn_formatted_datetime(fmt, date, "0", "0", "0")
}
pub fn cobol_fn_formatted_current_date(fmt: &str) -> String {
    let cd = cobol_fn_current_date();
    let _ = fmt;
    cd
}

// ---------------------------------------------------------------------------
// Locale / environment intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_locale_compare(a: &str, b: &str) -> i64 {
    match a.cmp(b) {
        std::cmp::Ordering::Less => -1,
        std::cmp::Ordering::Equal => 0,
        std::cmp::Ordering::Greater => 1,
    }
}
pub fn cobol_fn_locale_date(date: &str) -> String { date.to_string() }
pub fn cobol_fn_locale_time(time: &str) -> String { time.to_string() }

pub fn cobol_fn_numeric_decimal_point() -> String { ".".into() }
pub fn cobol_fn_numeric_thousands_separator() -> String { ",".into() }
pub fn cobol_fn_monetary_decimal_point() -> String { ".".into() }
pub fn cobol_fn_monetary_thousands_separator() -> String { ",".into() }
pub fn cobol_fn_currency_symbol() -> String { "$".into() }

// ---------------------------------------------------------------------------
// Module / misc intrinsic functions
// ---------------------------------------------------------------------------

pub fn cobol_fn_module_name() -> String { String::new() }
pub fn cobol_fn_module_path() -> String { String::new() }
pub fn cobol_fn_module_source() -> String { String::new() }
pub fn cobol_fn_module_date() -> String { String::new() }
pub fn cobol_fn_module_time() -> String { String::new() }
pub fn cobol_fn_module_caller_id() -> String { String::new() }
pub fn cobol_fn_module_formatted_date() -> String { String::new() }
pub fn cobol_fn_combined_datetime(date: &str, time: &str) -> String {
    format!("{}{}", date.trim(), time.trim())
}
pub fn cobol_fn_highest_algebraic(pic: &str) -> String {
    // Return max value for PIC size — simplified
    let digits = pic.matches('9').count();
    if digits == 0 { return "9999999999".into(); }
    format!("{}", "9".repeat(digits))
}
pub fn cobol_fn_lowest_algebraic(pic: &str) -> String {
    let digits = pic.matches('9').count();
    if pic.contains('S') {
        format!("-{}", "9".repeat(if digits == 0 { 10 } else { digits }))
    } else {
        "0".into()
    }
}
pub fn cobol_fn_e() -> String { format!("{}", std::f64::consts::E) }
pub fn cobol_fn_pi() -> String { format!("{}", std::f64::consts::PI) }
pub fn cobol_fn_numval_f(s: &str) -> String {
    let v: f64 = s.trim().parse().unwrap_or(0.0);
    format!("{}", v)
}

// Additional missing functions found in compile audit
pub fn cobol_fn_exception_statement() -> String { String::new() }
pub fn cobol_fn_exception_file() -> String { String::new() }
pub fn cobol_fn_exception_location() -> String { String::new() }
pub fn cobol_fn_module_id() -> String { String::new() }
pub fn cobol_fn_midrange(a: &str, b: &str) -> String {
    let va: f64 = a.trim().parse().unwrap_or(0.0);
    let vb: f64 = b.trim().parse().unwrap_or(0.0);
    format!("{}", (va + vb) / 2.0)
}
pub fn cobol_fn_locale_time_from_seconds(secs: &str) -> String {
    let s: f64 = secs.trim().parse().unwrap_or(0.0);
    let h = (s / 3600.0) as i64;
    let m = ((s % 3600.0) / 60.0) as i64;
    let sec = (s % 60.0) as i64;
    format!("{:02}{:02}{:02}", h, m, sec)
}
pub fn cobol_fn_integer_of_formatted_date(fmt: &str, date: &str) -> String {
    let _ = fmt;
    let d: i64 = date.trim().replace('-', "").parse().unwrap_or(0);
    cobol_fn_integer_of_date(&format!("{}", d))
}
pub fn cobol_fn_content_of(s: &str) -> String { s.trim().to_string() }
pub fn cobol_fn_substitute_case(src: &str, from: &str, to: &str) -> String {
    // Case-insensitive substitute
    let lower_src = src.to_lowercase();
    let lower_from = from.to_lowercase();
    let mut result = String::new();
    let mut i = 0;
    while i < src.len() {
        if i + from.len() <= src.len() && lower_src[i..i+from.len()] == lower_from {
            result.push_str(to);
            i += from.len();
        } else {
            result.push(src.as_bytes()[i] as char);
            i += 1;
        }
    }
    result
}
pub fn cobol_fn_x(s: &str) -> String { s.to_string() }
pub fn cobol_fn_national_of(s: &str) -> String { s.to_string() }
pub fn cobol_fn_display_of(s: &str) -> String { s.to_string() }
pub fn cobol_fn_integer_of_boolean(s: &str) -> String {
    if s.trim() == "1" || s.trim().to_lowercase() == "true" { "1".into() } else { "0".into() }
}
pub fn cobol_fn_boolean_of_integer(s: &str) -> String {
    if s.trim() == "0" { "0".into() } else { "1".into() }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_upper_lower() {
        assert_eq!(cobol_fn_upper_case("hello"), "HELLO");
        assert_eq!(cobol_fn_lower_case("HELLO"), "hello");
    }

    #[test]
    fn test_length() {
        assert_eq!(cobol_fn_length("abc"), 3);
    }

    #[test]
    fn test_reverse() {
        assert_eq!(cobol_fn_reverse("abc"), "cba");
    }

    #[test]
    fn test_mod() {
        assert_eq!(cobol_fn_mod("10", "3"), "1");
        assert_eq!(cobol_fn_mod("-1", "3"), "2");
    }

    #[test]
    fn test_refmod() {
        assert_eq!(cobol_refmod("ABCDE", 2, 3), "BCD");
        assert_eq!(cobol_refmod("AB", 1, 5), "AB");
    }

    #[test]
    fn test_trim() {
        assert_eq!(cobol_fn_trim("  hello  "), "hello");
    }

    #[test]
    fn test_numval() {
        let d = cobol_fn_numval("  42  ");
        assert_eq!(d.value, 4200); // scale=2, so 42.0 * 100 = 4200
    }

    #[test]
    fn test_inspect_converting() {
        let result = cobol_inspect_converting("ABCABC", "ABC", "XYZ");
        assert_eq!(result, "XYZXYZ");
    }

    #[test]
    fn test_current_date_format() {
        let d = cobol_fn_current_date();
        assert_eq!(d.len(), 21);
    }

    #[test]
    fn test_integer_of_date() {
        let d = cobol_fn_integer_of_date("20260101");
        assert!(d.parse::<i64>().unwrap() > 0);
    }
}
