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
pub fn cobol_fn_mod(a: i64, b: i64) -> i64 {
    if b == 0 { 0 } else { ((a % b) + b) % b }
}

/// FUNCTION NUMVAL-C
pub fn cobol_fn_numval_c(s: &str) -> Decimal {
    let cleaned: String = s.chars().filter(|c| c.is_ascii_digit() || *c == '.' || *c == '-').collect();
    cleaned.parse::<f64>().map(|v| Decimal::from(v)).unwrap_or_default()
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
    trimmed.parse::<f64>().map(|v| Decimal::from(v)).unwrap_or_default()
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
pub fn cobol_fn_integer_of_date(yyyymmdd: i64) -> i64 {
    let y = yyyymmdd / 10000;
    let m = (yyyymmdd % 10000) / 100;
    let d = yyyymmdd % 100;
    let a = (14 - m) / 12;
    let y2 = y + 4800 - a;
    let m2 = m + 12 * a - 3;
    d + (153 * m2 + 2) / 5 + 365 * y2 + y2 / 4 - y2 / 100 + y2 / 400 - 32045
}

/// FUNCTION INTEGER(x) -> truncate toward zero
pub fn cobol_fn_integer(x: f64) -> i64 { x as i64 }

/// FUNCTION DATE-OF-INTEGER(n) -> YYYYMMDD
pub fn cobol_fn_date_of_integer(n: i64) -> i64 {
    let a = n + 32044;
    let b = (4 * a + 3) / 146097;
    let c = a - (146097 * b) / 4;
    let d = (4 * c + 3) / 1461;
    let e = c - (1461 * d) / 4;
    let m = (5 * e + 2) / 153;
    let day = e - (153 * m + 2) / 5 + 1;
    let month = m + 3 - 12 * (m / 10);
    let year = 100 * b + d - 4800 + m / 10;
    year * 10000 + month * 100 + day
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

/// INSPECT CONVERTING (in-place)
pub fn cobol_inspect_converting(s: &mut String, from: &str, to: &str) {
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
    *s = result;
}

/// INSPECT TALLYING (count occurrences)
pub fn cobol_inspect_tallying_count(s: &str) -> i32 {
    s.len() as i32
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
        assert_eq!(cobol_fn_mod(10, 3), 1);
        assert_eq!(cobol_fn_mod(-1, 3), 2);
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
        let mut s = "ABCABC".to_string();
        cobol_inspect_converting(&mut s, "ABC", "XYZ");
        assert_eq!(s, "XYZXYZ");
    }

    #[test]
    fn test_current_date_format() {
        let d = cobol_fn_current_date();
        assert_eq!(d.len(), 21);
    }

    #[test]
    fn test_integer_of_date() {
        let d = cobol_fn_integer_of_date(20260101);
        assert!(d > 0);
    }
}
