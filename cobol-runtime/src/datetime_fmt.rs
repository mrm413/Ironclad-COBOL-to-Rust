// COBOL date/time formatting runtime functions.
// Implements FORMATTED-DATE, FORMATTED-TIME, FORMATTED-DATETIME,
// FORMATTED-CURRENT-DATE, INTEGER-OF-FORMATTED-DATE,
// TEST-FORMATTED-DATETIME, SECONDS-FROM-FORMATTED-TIME.

// COBOL integer date: day 1 = 1601-01-01. JDN of 1601-01-01 = 2305814.
const JDN_OFFSET: i64 = 2305813; // date_int + JDN_OFFSET = JDN

fn is_leap(y: i64) -> bool {
    y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)
}

fn days_in_year(y: i64) -> i64 {
    if is_leap(y) { 366 } else { 365 }
}

fn days_in_month(y: i64, m: i64) -> i64 {
    match m {
        1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
        4 | 6 | 9 | 11 => 30,
        2 => if is_leap(y) { 29 } else { 28 },
        _ => 30,
    }
}

fn date_int_to_ymd(d: i64) -> (i64, i64, i64) {
    let jdn = d + JDN_OFFSET;
    let a = jdn + 32044;
    let b = (4 * a + 3) / 146097;
    let c = a - (146097 * b / 4);
    let dd = (4 * c + 3) / 1461;
    let e = c - (1461 * dd / 4);
    let mm = (5 * e + 2) / 153;
    let day = e - (153 * mm + 2) / 5 + 1;
    let month = mm + 3 - 12 * (mm / 10);
    let year = b * 100 + dd - 4800 + mm / 10;
    (year, month, day)
}

fn ymd_to_date_int(y: i64, m: i64, d: i64) -> i64 {
    let a = (14 - m) / 12;
    let yy = y + 4800 - a;
    let mm = m + 12 * a - 3;
    let jdn = d + (153 * mm + 2) / 5 + 365 * yy + yy / 4 - yy / 100 + yy / 400 - 32045;
    jdn - JDN_OFFSET
}

fn ymd_to_ordinal(y: i64, m: i64, d: i64) -> i64 {
    ymd_to_date_int(y, m, d) - ymd_to_date_int(y, 1, 1) + 1
}

// ISO weekday: 1=Monday .. 7=Sunday
fn day_of_week(y: i64, m: i64, d: i64) -> i64 {
    let jdn = ymd_to_date_int(y, m, d) + JDN_OFFSET;
    // JDN 0 = Monday, so JDN % 7: 0=Mon..6=Sun → ISO = (JDN%7)+1
    (jdn % 7) + 1
}

fn iso_weeks_in_year(y: i64) -> i64 {
    let dow = day_of_week(y, 1, 1);
    if dow == 4 || (is_leap(y) && dow == 3) { 53 } else { 52 }
}

fn ymd_to_iso_week(y: i64, m: i64, d: i64) -> (i64, i64, i64) {
    let dow = day_of_week(y, m, d);
    let doy = ymd_to_ordinal(y, m, d);
    // The Thursday of the current ISO week
    let thu_doy = doy + 4 - dow;
    if thu_doy < 1 {
        // Thursday falls in previous year
        let py = y - 1;
        let py_days = days_in_year(py);
        let prev_doy = py_days + thu_doy;
        let week = (prev_doy - 1) / 7 + 1;
        (py, week, dow)
    } else if thu_doy > days_in_year(y) {
        // Thursday falls in next year
        (y + 1, 1, dow)
    } else {
        let week = (thu_doy - 1) / 7 + 1;
        (y, week, dow)
    }
}

fn iso_week_to_date_int(iso_y: i64, w: i64, wd: i64) -> i64 {
    // Monday of ISO week 1 = the Monday on or before Jan 4
    let jan4_int = ymd_to_date_int(iso_y, 1, 4);
    let jan4_dow = day_of_week(iso_y, 1, 4);
    let w1_monday = jan4_int - (jan4_dow - 1);
    w1_monday + (w - 1) * 7 + (wd - 1)
}

fn ordinal_to_date_int(y: i64, doy: i64) -> i64 {
    ymd_to_date_int(y, 1, 1) + doy - 1
}

// Check if a numeric value (given as individual digits, possibly partial) is in [lo, hi].
// `expected_len` is the total expected digit count (e.g., 4 for year, 2 for month).
// Returns 1-indexed error position (start_pos + offset) or 0 if OK/undetermined.
fn check_range(digits: &[u8], expected_len: usize, start_pos: i64, lo: i64, hi: i64) -> i64 {
    let n = expected_len;
    let given = digits.len();
    let mut running = 0i64;
    for i in 0..given {
        running = running * 10 + digits[i] as i64;
        let remaining = (n - i - 1) as u32;
        let mult = 10i64.pow(remaining);
        let pmin = running * mult;
        let pmax = running * mult + (mult - 1);
        if pmax < lo || pmin > hi {
            return start_pos + i as i64;
        }
    }
    0 // valid or not yet determinable (partial data)
}

// Format date part of a format string.
fn format_date_part(fmt: &str, y: i64, m: i64, d: i64, doy: i64, iso_y: i64, iso_w: i64, iso_wd: i64) -> String {
    let chars: Vec<char> = fmt.chars().collect();
    let mut out = String::new();
    let mut i = 0;
    while i < chars.len() {
        if i + 4 <= chars.len() && chars[i..i + 4].iter().all(|&c| c == 'Y') {
            let year = if fmt.contains('w') { iso_y } else { y };
            out.push_str(&format!("{:04}", year));
            i += 4;
        } else if i + 3 <= chars.len() && chars[i..i + 3].iter().all(|&c| c == 'D') {
            out.push_str(&format!("{:03}", doy));
            i += 3;
        } else if i + 2 <= chars.len() && chars[i] == 'M' && chars[i + 1] == 'M' {
            out.push_str(&format!("{:02}", m));
            i += 2;
        } else if i + 2 <= chars.len() && chars[i] == 'D' && chars[i + 1] == 'D' {
            out.push_str(&format!("{:02}", d));
            i += 2;
        } else if i + 3 <= chars.len() && chars[i] == 'W' && chars[i + 1] == 'w' && chars[i + 2] == 'w' {
            out.push_str(&format!("W{:02}", iso_w));
            i += 3;
        } else if chars[i] == 'D' {
            // Single D = ISO weekday (after Www consumed)
            out.push_str(&format!("{}", iso_wd));
            i += 1;
        } else {
            out.push(chars[i]);
            i += 1;
        }
    }
    out
}

// Format time part of a format string.
fn format_time_part(fmt: &str, h: i64, mi: i64, s: i64, frac: f64, offset: i64) -> String {
    let chars: Vec<char> = fmt.chars().collect();
    let mut out = String::new();
    let mut i = 0;
    while i < chars.len() {
        if i + 1 < chars.len() && chars[i] == 'h' && chars[i + 1] == 'h' {
            out.push_str(&format!("{:02}", h));
            i += 2;
        } else if i + 1 < chars.len() && chars[i] == 'm' && chars[i + 1] == 'm' {
            out.push_str(&format!("{:02}", mi));
            i += 2;
        } else if i + 1 < chars.len() && chars[i] == 's' && chars[i + 1] == 's' {
            out.push_str(&format!("{:02}", s));
            i += 2;
            // Check for fractional seconds: . or , followed by more s's
            if i < chars.len() && (chars[i] == '.' || chars[i] == ',') {
                let sep = chars[i];
                i += 1;
                let frac_start = i;
                while i < chars.len() && chars[i] == 's' {
                    i += 1;
                }
                let frac_digits = i - frac_start;
                if frac_digits > 0 {
                    let mult = 10f64.powi(frac_digits as i32);
                    let frac_val = (frac * mult).round() as i64;
                    out.push(sep);
                    out.push_str(&format!("{:0>w$}", frac_val, w = frac_digits));
                }
            }
        } else if chars[i] == 'Z' {
            out.push('Z');
            i += 1;
        } else if chars[i] == '+' {
            // Offset display: +hhmm or +hh:mm
            let sign = if offset < 0 { '-' } else { '+' };
            let oh = offset.abs() / 60;
            let om = offset.abs() % 60;
            out.push(sign);
            i += 1;
            if i + 1 < chars.len() && chars[i] == 'h' && chars[i + 1] == 'h' {
                out.push_str(&format!("{:02}", oh));
                i += 2;
            }
            if i < chars.len() && chars[i] == ':' {
                out.push(':');
                i += 1;
            }
            if i + 1 < chars.len() && chars[i] == 'm' && chars[i + 1] == 'm' {
                out.push_str(&format!("{:02}", om));
                i += 2;
            }
        } else {
            out.push(chars[i]);
            i += 1;
        }
    }
    out
}

/// FUNCTION FORMATTED-DATE(format, date_int)
pub fn formatted_date(fmt: &str, date_int: i64) -> String {
    let (y, m, d) = date_int_to_ymd(date_int);
    let doy = ymd_to_ordinal(y, m, d);
    let (iso_y, iso_w, iso_wd) = ymd_to_iso_week(y, m, d);
    format_date_part(fmt, y, m, d, doy, iso_y, iso_w, iso_wd)
}

/// FUNCTION FORMATTED-TIME(format, seconds [, offset_minutes])
pub fn formatted_time(fmt: &str, seconds: f64, offset: Option<i64>) -> String {
    let off = offset.unwrap_or(0);
    let has_z = fmt.contains('Z');

    // Validate offset range: must be -1439..=1439
    if fmt.contains('+') || has_z {
        if off < -1439 || off > 1439 {
            return " ".repeat(fmt.len());
        }
    }

    let (adj_secs, _) = if has_z {
        // Convert local time to UTC
        let utc = seconds - (off as f64 * 60.0);
        let wrapped = ((utc % 86400.0) + 86400.0) % 86400.0;
        (wrapped, 0i64)
    } else {
        (seconds, off)
    };

    let total = adj_secs as i64;
    let frac = adj_secs - total as f64;
    let h = (total / 3600) % 24;
    let mi = (total % 3600) / 60;
    let s = total % 60;

    format_time_part(fmt, h, mi, s, frac, off)
}

/// FUNCTION FORMATTED-DATETIME(format, date_int, seconds [, offset_minutes])
pub fn formatted_datetime(fmt: &str, date_int: i64, seconds: f64, offset: Option<i64>) -> String {
    let off = offset.unwrap_or(0);

    // Validate offset
    if fmt.contains('+') || fmt.contains('Z') {
        if off < -1439 || off > 1439 {
            return " ".repeat(fmt.len());
        }
    }

    // Split format at 'T' into date and time parts
    let t_pos = fmt.find('T');
    let (date_fmt, time_fmt) = match t_pos {
        Some(p) => (&fmt[..p], &fmt[p + 1..]),
        None => (fmt, ""),
    };

    // Handle Z conversion with possible date rollback/forward
    let has_z = time_fmt.contains('Z');
    let (adj_date_int, adj_secs) = if has_z {
        let utc = seconds - (off as f64 * 60.0);
        if utc < 0.0 {
            (date_int - 1, utc + 86400.0)
        } else if utc >= 86400.0 {
            (date_int + 1, utc - 86400.0)
        } else {
            (date_int, utc)
        }
    } else {
        (date_int, seconds)
    };

    let (y, m, d) = date_int_to_ymd(adj_date_int);
    let doy = ymd_to_ordinal(y, m, d);
    let (iso_y, iso_w, iso_wd) = ymd_to_iso_week(y, m, d);

    let total = adj_secs as i64;
    let frac = adj_secs - total as f64;
    let h = (total / 3600) % 24;
    let mi = (total % 3600) / 60;
    let s = total % 60;

    let date_part = format_date_part(date_fmt, y, m, d, doy, iso_y, iso_w, iso_wd);
    let time_part = format_time_part(time_fmt, h, mi, s, frac, off);

    if time_fmt.is_empty() {
        date_part
    } else {
        format!("{}T{}", date_part, time_part)
    }
}

/// FUNCTION FORMATTED-CURRENT-DATE(format)
pub fn formatted_current_date(fmt: &str) -> String {
    use std::time::{SystemTime, UNIX_EPOCH};
    let dur = SystemTime::now().duration_since(UNIX_EPOCH).unwrap_or_default();
    let unix_secs = dur.as_secs() as i64;
    let frac_ms = dur.subsec_millis() as f64 / 1000.0;
    // Unix epoch = 1970-01-01 = COBOL day 134774
    let days = unix_secs / 86400;
    let tod = unix_secs % 86400;
    let cobol_date = days + 134774;
    let seconds = tod as f64 + frac_ms;
    // Use UTC offset 0 (we don't have timezone info without external deps)
    // The offset display will show +0000
    let off = system_offset_minutes();
    formatted_datetime(fmt, cobol_date, seconds, Some(off))
}

/// FUNCTION INTEGER-OF-FORMATTED-DATE(format, date_string)
pub fn integer_of_formatted_date(fmt: &str, date_str: &str) -> i64 {
    // Strip any time part (after T)
    let ds = if let Some(p) = date_str.find('T') { &date_str[..p] } else { date_str };
    let df = if let Some(p) = fmt.find('T') { &fmt[..p] } else { fmt };

    let fc: Vec<char> = df.chars().collect();
    let dc: Vec<char> = ds.chars().collect();

    // Extract digits by scanning format
    let mut year_digits = Vec::new();
    let mut month_digits = Vec::new();
    let mut day_digits = Vec::new();
    let mut ordinal_digits = Vec::new();
    let mut week_digits = Vec::new();
    let mut weekday_digit = None;
    let mut has_ordinal = false;
    let mut has_week = false;

    let mut fi = 0;
    let mut di = 0;
    while fi < fc.len() && di < dc.len() {
        match fc[fi] {
            'Y' => {
                year_digits.push(dc[di]);
                fi += 1;
                di += 1;
            }
            'M' => {
                month_digits.push(dc[di]);
                fi += 1;
                di += 1;
            }
            'D' => {
                // Check for DDD (3 D's)
                if fi + 2 < fc.len() && fc[fi + 1] == 'D' && fc[fi + 2] == 'D' {
                    has_ordinal = true;
                    ordinal_digits.push(dc[di]);
                    if di + 1 < dc.len() { ordinal_digits.push(dc[di + 1]); }
                    if di + 2 < dc.len() { ordinal_digits.push(dc[di + 2]); }
                    fi += 3;
                    di += 3;
                } else if fi + 1 < fc.len() && fc[fi + 1] == 'D' {
                    day_digits.push(dc[di]);
                    if di + 1 < dc.len() { day_digits.push(dc[di + 1]); }
                    fi += 2;
                    di += 2;
                } else {
                    // Single D = weekday
                    weekday_digit = dc[di].to_digit(10).map(|d| d as i64);
                    fi += 1;
                    di += 1;
                }
            }
            'W' => {
                if fi + 2 < fc.len() && fc[fi + 1] == 'w' && fc[fi + 2] == 'w' {
                    has_week = true;
                    // Skip 'W' literal in input
                    di += 1; // skip 'W'
                    if di < dc.len() { week_digits.push(dc[di]); di += 1; }
                    if di < dc.len() { week_digits.push(dc[di]); di += 1; }
                    fi += 3;
                } else {
                    fi += 1;
                    di += 1;
                }
            }
            _ => {
                // Separator — skip both
                fi += 1;
                di += 1;
            }
        }
    }

    let parse_digits = |chars: &[char]| -> i64 {
        chars.iter().fold(0i64, |a, &c| a * 10 + c.to_digit(10).unwrap_or(0) as i64)
    };

    let y = parse_digits(&year_digits);

    if has_week {
        let w = parse_digits(&week_digits);
        let wd = weekday_digit.unwrap_or(1);
        iso_week_to_date_int(y, w, wd)
    } else if has_ordinal {
        let doy = parse_digits(&ordinal_digits);
        ordinal_to_date_int(y, doy)
    } else {
        let m = parse_digits(&month_digits);
        let d = parse_digits(&day_digits);
        ymd_to_date_int(y, m, d)
    }
}

/// FUNCTION SECONDS-FROM-FORMATTED-TIME(format, time_string)
pub fn seconds_from_formatted_time(fmt: &str, time_str: &str) -> f64 {
    // If format has 'T', skip to time part
    let (tf, ts) = if let Some(p) = fmt.find('T') {
        (&fmt[p + 1..], &time_str[p + 1..])
    } else {
        (fmt, time_str)
    };

    let fc: Vec<char> = tf.chars().collect();
    let tc: Vec<char> = ts.chars().collect();

    let mut h = 0i64;
    let mut mi = 0i64;
    let mut s = 0i64;
    let mut frac_str = String::new();

    let mut fi = 0;
    let mut ti = 0;
    let mut got_time = false;
    while fi < fc.len() && ti < tc.len() {
        // Stop at offset/UTC marker — we only want the time value
        if fc[fi] == '+' || fc[fi] == 'Z' {
            break;
        }
        if fi + 1 < fc.len() && fc[fi] == 'h' && fc[fi + 1] == 'h' && !got_time {
            let d0 = tc.get(ti).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            let d1 = tc.get(ti + 1).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            h = d0 * 10 + d1;
            fi += 2;
            ti += 2;
        } else if fi + 1 < fc.len() && fc[fi] == 'm' && fc[fi + 1] == 'm' && !got_time {
            let d0 = tc.get(ti).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            let d1 = tc.get(ti + 1).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            mi = d0 * 10 + d1;
            fi += 2;
            ti += 2;
        } else if fi + 1 < fc.len() && fc[fi] == 's' && fc[fi + 1] == 's' {
            let d0 = tc.get(ti).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            let d1 = tc.get(ti + 1).and_then(|c| c.to_digit(10)).unwrap_or(0) as i64;
            s = d0 * 10 + d1;
            fi += 2;
            ti += 2;
            got_time = true;
            // Check for fractional part
            if fi < fc.len() && (fc[fi] == '.' || fc[fi] == ',') {
                fi += 1;
                ti += 1; // skip decimal separator in input
                while fi < fc.len() && fc[fi] == 's' {
                    if ti < tc.len() {
                        frac_str.push(tc[ti]);
                        ti += 1;
                    }
                    fi += 1;
                }
            }
        } else {
            // Skip separator chars (:, etc.)
            fi += 1;
            ti += 1;
        }
    }

    let base = (h * 3600 + mi * 60 + s) as f64;
    if frac_str.is_empty() {
        base
    } else {
        let frac_val: f64 = format!("0.{}", frac_str).parse().unwrap_or(0.0);
        base + frac_val
    }
}

/// FUNCTION TEST-FORMATTED-DATETIME(format, value)
/// Returns 0 if valid, or the 1-based position of the first error.
pub fn test_formatted_datetime(fmt: &str, val: &str) -> i64 {
    let fc: Vec<char> = fmt.chars().collect();
    // Trim trailing spaces (COBOL PIC X fields are space-padded)
    let trimmed = val.trim_end();
    let vc: Vec<char> = trimmed.chars().collect();
    let flen = fc.len();

    // Check for blank/too-short input
    if trimmed.is_empty() {
        return 1;
    }

    // Scan format and input together, collecting component digits.
    // On syntax error, return immediately. On too-short, record position but
    // continue to range checking (a partial component might already be invalid
    // at an earlier position).
    let mut pos = 0usize;
    let mut vi = 0usize;
    let mut too_short_pos: Option<i64> = None;

    let mut year_pos = 0usize;  let mut year_digs: Vec<u8> = Vec::new();
    let mut month_pos = 0usize; let mut month_digs: Vec<u8> = Vec::new();
    let mut day_pos = 0usize;   let mut day_digs: Vec<u8> = Vec::new();
    let mut ordinal_pos = 0usize; let mut ordinal_digs: Vec<u8> = Vec::new();
    let mut week_pos = 0usize;  let mut week_digs: Vec<u8> = Vec::new();
    let mut weekday_pos = 0usize; let mut weekday_digs: Vec<u8> = Vec::new();
    let mut hour_pos = 0usize;  let mut hour_digs: Vec<u8> = Vec::new();
    let mut min_pos = 0usize;   let mut min_digs: Vec<u8> = Vec::new();
    let mut sec_pos = 0usize;   let mut sec_digs: Vec<u8> = Vec::new();
    let mut has_ordinal = false;
    let mut has_week = false;
    let mut has_time = false;
    let mut offset_sign_is_digit = false;
    let mut offset_last_pos = 0usize;
    let mut offset_digs: Vec<u8> = Vec::new();

    macro_rules! need_char {
        () => {
            if vi >= vc.len() {
                if too_short_pos.is_none() { too_short_pos = Some((pos + 1) as i64); }
                break; // stop scanning, proceed to range checks
            }
        };
    }

    while pos < flen && too_short_pos.is_none() {
        let p1 = (pos + 1) as i64;
        need_char!();
        let fch = fc[pos];
        let vch = vc[vi];

        match fch {
            'Y' => {
                if !vch.is_ascii_digit() { return p1; }
                if year_digs.is_empty() { year_pos = pos; }
                year_digs.push(vch.to_digit(10).unwrap() as u8);
                pos += 1; vi += 1;
            }
            'M' => {
                if !vch.is_ascii_digit() { return p1; }
                if month_digs.is_empty() { month_pos = pos; }
                month_digs.push(vch.to_digit(10).unwrap() as u8);
                pos += 1; vi += 1;
            }
            'D' => {
                if pos + 2 < flen && fc[pos + 1] == 'D' && fc[pos + 2] == 'D' {
                    has_ordinal = true;
                    ordinal_pos = pos;
                    for _ in 0..3 {
                        need_char!();
                        if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                        ordinal_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                        pos += 1; vi += 1;
                    }
                } else if pos + 1 < flen && fc[pos + 1] == 'D' {
                    day_pos = pos;
                    for _ in 0..2 {
                        need_char!();
                        if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                        day_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                        pos += 1; vi += 1;
                    }
                } else {
                    if !vch.is_ascii_digit() { return p1; }
                    weekday_pos = pos;
                    weekday_digs.push(vch.to_digit(10).unwrap() as u8);
                    pos += 1; vi += 1;
                }
            }
            'W' if pos + 2 < flen && fc[pos + 1] == 'w' && fc[pos + 2] == 'w' => {
                has_week = true;
                if vch != 'W' { return p1; }
                pos += 1; vi += 1;
                week_pos = pos;
                for _ in 0..2 {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    week_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    pos += 1; vi += 1;
                }
            }
            'h' if pos + 1 < flen && fc[pos + 1] == 'h' => {
                has_time = true;
                hour_pos = pos;
                for _ in 0..2 {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    hour_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    pos += 1; vi += 1;
                }
            }
            'm' if pos + 1 < flen && fc[pos + 1] == 'm' => {
                min_pos = pos;
                for _ in 0..2 {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    min_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    pos += 1; vi += 1;
                }
            }
            's' if pos + 1 < flen && fc[pos + 1] == 's' => {
                sec_pos = pos;
                for _ in 0..2 {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    sec_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    pos += 1; vi += 1;
                }
                if pos < flen && (fc[pos] == '.' || fc[pos] == ',') {
                    let expected_sep = fc[pos];
                    need_char!();
                    if vc[vi] != expected_sep { return (pos + 1) as i64; }
                    pos += 1; vi += 1;
                    while pos < flen && fc[pos] == 's' {
                        need_char!();
                        if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                        pos += 1; vi += 1;
                    }
                }
            }
            'Z' => {
                if vch != 'Z' { return p1; }
                pos += 1; vi += 1;
            }
            '+' => {
                if vch != '+' && vch != '-' && !vch.is_ascii_digit() {
                    return p1;
                }
                offset_sign_is_digit = vch.is_ascii_digit();
                let offset_start = pos;
                pos += 1; vi += 1;
                // Offset hh part
                while pos < flen && fc[pos] == 'h' {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    offset_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    offset_last_pos = pos;
                    pos += 1; vi += 1;
                }
                // Optional colon
                if pos < flen && fc[pos] == ':' {
                    need_char!();
                    if vc[vi] != ':' { return (pos + 1) as i64; }
                    pos += 1; vi += 1;
                }
                // Offset mm part
                while pos < flen && fc[pos] == 'm' {
                    need_char!();
                    if !vc[vi].is_ascii_digit() { return (pos + 1) as i64; }
                    offset_digs.push(vc[vi].to_digit(10).unwrap() as u8);
                    offset_last_pos = pos;
                    pos += 1; vi += 1;
                }
                let _ = offset_start;
            }
            _ => {
                if vch != fch { return p1; }
                pos += 1; vi += 1;
            }
        }
    }

    // Check if input is longer than format
    if too_short_pos.is_none() && vi < vc.len() {
        return (flen + 1) as i64;
    }

    // Range validation — check even partial components. check_range handles
    // partial digits by considering possible completions.
    let mut earliest_range_err: Option<i64> = None;

    let mut check = |digs: &[u8], expected_len: usize, start: usize, lo: i64, hi: i64| {
        if digs.is_empty() { return; }
        let r = check_range(digs, expected_len, (start + 1) as i64, lo, hi);
        if r > 0 {
            if earliest_range_err.is_none() || r < earliest_range_err.unwrap() {
                earliest_range_err = Some(r);
            }
        }
    };

    check(&year_digs, 4, year_pos, 1601, 9999);
    let year_val = year_digs.iter().fold(0i64, |a, &d| a * 10 + d as i64);

    if has_week {
        let max_w = if year_val >= 1601 { iso_weeks_in_year(year_val) } else { 52 };
        check(&week_digs, 2, week_pos, 1, max_w);
        check(&weekday_digs, 1, weekday_pos, 1, 7);
    } else if has_ordinal {
        let max_d = if year_val >= 1601 { days_in_year(year_val) } else { 366 };
        check(&ordinal_digs, 3, ordinal_pos, 1, max_d);
    } else {
        check(&month_digs, 2, month_pos, 1, 12);
        if !day_digs.is_empty() {
            let month_val = month_digs.iter().fold(0i64, |a, &d| a * 10 + d as i64);
            let max_d = if month_val >= 1 && month_val <= 12 && year_val >= 1601 {
                days_in_month(year_val, month_val)
            } else { 31 };
            check(&day_digs, 2, day_pos, 1, max_d);
        }
    }

    if has_time {
        check(&hour_digs, 2, hour_pos, 0, 23);
        check(&min_digs, 2, min_pos, 0, 59);
        check(&sec_digs, 2, sec_pos, 0, 59);
    }

    // Offset validation: if sign was a digit (not +/-), the offset value must be 0
    if offset_sign_is_digit && !offset_digs.is_empty() {
        let off_val = offset_digs.iter().fold(0i64, |a, &d| a * 10 + d as i64);
        if off_val != 0 {
            // Error at last offset digit position
            if let Some(e) = earliest_range_err {
                if (offset_last_pos + 1) as i64 > e { /* keep earlier */ }
                else { earliest_range_err = Some((offset_last_pos + 1) as i64); }
            } else {
                earliest_range_err = Some((offset_last_pos + 1) as i64);
            }
        }
    }

    // Return the earliest error: range error or too-short, whichever comes first
    match (earliest_range_err, too_short_pos) {
        (Some(r), Some(s)) => r.min(s),
        (Some(r), None) => r,
        (None, Some(s)) => s,
        (None, None) => 0,
    }
}

/// Get system UTC offset in minutes. Returns 0 if unavailable.
pub fn system_offset_minutes() -> i64 {
    #[cfg(windows)]
    {
        // Windows: use GetTimeZoneInformation
        #[repr(C)]
        struct SystemTime {
            w_year: u16, w_month: u16, w_day_of_week: u16, w_day: u16,
            w_hour: u16, w_minute: u16, w_second: u16, w_milliseconds: u16,
        }
        #[repr(C)]
        struct TimeZoneInformation {
            bias: i32,
            _standard_name: [u16; 32],
            _standard_date: SystemTime,
            _standard_bias: i32,
            _daylight_name: [u16; 32],
            _daylight_date: SystemTime,
            _daylight_bias: i32,
        }
        extern "system" {
            fn GetTimeZoneInformation(info: *mut TimeZoneInformation) -> u32;
        }
        unsafe {
            let mut info: TimeZoneInformation = std::mem::zeroed();
            let result = GetTimeZoneInformation(&mut info);
            // Bias is minutes WEST of UTC; negate for minutes EAST (standard offset)
            let total_bias = if result == 2 {
                // Daylight time active
                info.bias + info._daylight_bias
            } else {
                info.bias
            };
            -(total_bias as i64)
        }
    }
    #[cfg(not(windows))]
    {
        0
    }
}

// ── Public date conversion wrappers for transpiler intrinsics ────────

/// FUNCTION INTEGER-OF-DATE(yyyymmdd) → COBOL integer date
/// Input: 8-digit integer YYYYMMDD
pub fn integer_of_date(yyyymmdd: i64) -> i64 {
    let y = yyyymmdd / 10000;
    let m = (yyyymmdd % 10000) / 100;
    let d = yyyymmdd % 100;
    ymd_to_date_int(y, m, d)
}

/// FUNCTION DATE-OF-INTEGER(date_int) → YYYYMMDD
pub fn date_of_integer(date_int: i64) -> i64 {
    let (y, m, d) = date_int_to_ymd(date_int);
    y * 10000 + m * 100 + d
}

/// FUNCTION INTEGER-OF-DAY(yyyyddd) → COBOL integer date
/// Input: 7-digit integer YYYYDDD
pub fn integer_of_day(yyyyddd: i64) -> i64 {
    let y = yyyyddd / 1000;
    let doy = yyyyddd % 1000;
    ordinal_to_date_int(y, doy)
}

/// FUNCTION DAY-OF-INTEGER(date_int) → YYYYDDD
pub fn day_of_integer(date_int: i64) -> i64 {
    let (y, m, d) = date_int_to_ymd(date_int);
    let doy = ymd_to_ordinal(y, m, d);
    y * 1000 + doy
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_date_int_roundtrip() {
        // Day 1 = 1601-01-01
        assert_eq!(date_int_to_ymd(1), (1601, 1, 1));
        assert_eq!(ymd_to_date_int(1601, 1, 1), 1);
        // Day 150844 = 2013-12-30
        assert_eq!(date_int_to_ymd(150844), (2013, 12, 30));
        assert_eq!(ymd_to_date_int(2013, 12, 30), 150844);
    }

    #[test]
    fn test_iso_week() {
        // 2012-01-01 (Sunday) → ISO 2011-W52-7
        assert_eq!(ymd_to_iso_week(2012, 1, 1), (2011, 52, 7));
        // 2013-12-30 (Monday) → ISO 2014-W01-1
        assert_eq!(ymd_to_iso_week(2013, 12, 30), (2014, 1, 1));
        // 2009 has 53 weeks
        assert_eq!(iso_weeks_in_year(2009), 53);
        // 1601 has 52 weeks
        assert_eq!(iso_weeks_in_year(1601), 52);
    }

    #[test]
    fn test_formatted_date_basic() {
        assert_eq!(formatted_date("YYYYMMDD", 1), "16010101");
        assert_eq!(formatted_date("YYYY-MM-DD", 1), "1601-01-01");
        assert_eq!(formatted_date("YYYYDDD", 1), "1601001");
        assert_eq!(formatted_date("YYYY-DDD", 1), "1601-001");
        assert_eq!(formatted_date("YYYYWwwD", 1), "1601W011");
        assert_eq!(formatted_date("YYYY-Www-D", 1), "1601-W01-1");
    }

    #[test]
    fn test_formatted_date_week_edge() {
        assert_eq!(formatted_date("YYYYWwwD", 150115), "2011W527");
        assert_eq!(formatted_date("YYYYWwwD", 150844), "2014W011");
    }

    #[test]
    fn test_formatted_time_basic() {
        assert_eq!(formatted_time("hhmmss", 45296.0, None), "123456");
        assert_eq!(formatted_time("hh:mm:ss", 45296.0, None), "12:34:56");
        assert_eq!(formatted_time("hhmmssZ", 86399.0, Some(-1)), "000059Z");
        assert_eq!(formatted_time("hh:mm:ssZ", 45296.0, None), "12:34:56Z");
        assert_eq!(formatted_time("hhmmss.ss", 45296.78, None), "123456.78");
        assert_eq!(formatted_time("hh:mm:ss.ssZ", 0.0, Some(120)), "22:00:00.00Z");
        assert_eq!(formatted_time("hhmmss+hhmm", 45296.0, None), "123456+0000");
        assert_eq!(formatted_time("hh:mm:ss+hh:mm", 45296.0, Some(0)), "12:34:56+00:00");
        assert_eq!(formatted_time("hhmmss+hhmm", 45296.0, Some(-754)), "123456-1234");
    }

    #[test]
    fn test_formatted_time_invalid_offset() {
        let result = formatted_time("hhmmss+hhmm", 1.0, Some(3000));
        assert_eq!(result.trim(), ""); // all spaces
        let result = formatted_time("hhmmss+hhmm", 1.0, Some(-3000));
        assert_eq!(result.trim(), "");
    }

    #[test]
    fn test_fmt_datetime() {
        assert_eq!(formatted_datetime("YYYYMMDDThhmmss", 1, 45296.0, None), "16010101T123456");
        assert_eq!(formatted_datetime("YYYY-MM-DDThh:mm:ss", 1, 45296.0, None), "1601-01-01T12:34:56");
        assert_eq!(formatted_datetime("YYYYDDDThhmmss+hhmm", 1, 45296.0, Some(-754)), "1601001T123456-1234");
        assert_eq!(formatted_datetime("YYYYDDDThhmmss+hhmm", 1, 45296.0, None), "1601001T123456+0000");
        // Z with date rollback
        assert_eq!(formatted_datetime("YYYYDDDThhmmss.sssssssssZ", 150846, 0.0, Some(1)),
                   "2013365T235900.000000000Z");
    }

    #[test]
    fn test_integer_of_formatted_date() {
        assert_eq!(integer_of_formatted_date("YYYY-MM-DD", "2013-12-30"), 150844);
        assert_eq!(integer_of_formatted_date("YYYY-DDD", "2013-364"), 150844);
        assert_eq!(integer_of_formatted_date("YYYY-Www-D", "2014-W01-1"), 150844);
        assert_eq!(integer_of_formatted_date("YYYY-MM-DDThh:mm:ss", "2013-12-30T12:34:56"), 150844);
    }

    #[test]
    fn test_seconds_from_formatted_time() {
        assert_eq!(seconds_from_formatted_time("hhmmss", "010203"), 3723.0);
        assert_eq!(seconds_from_formatted_time("hh:mm:ss", "01:02:03"), 3723.0);
        let r = seconds_from_formatted_time("hhmmss.ssssssss", "010203.04050607");
        assert!((r - 3723.04050607).abs() < 1e-8);
        assert_eq!(seconds_from_formatted_time("hhmmssZ", "010203Z"), 3723.0);
        assert_eq!(seconds_from_formatted_time("hhmmss+hhmm", "010203+0405"), 3723.0);
        assert_eq!(seconds_from_formatted_time("YYYYMMDDThhmmss", "16010101T010203"), 3723.0);
    }

    #[test]
    fn test_test_formatted_datetime_dates() {
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "16010101"), 0);
        assert_eq!(super::test_formatted_datetime("YYYY-MM-DD", "1601-01-01"), 0);
        assert_eq!(super::test_formatted_datetime("YYYYDDD", "1601001"), 0);
        assert_eq!(super::test_formatted_datetime("YYYY-DDD", "1601-001"), 0);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "1601W011"), 0);
        assert_eq!(super::test_formatted_datetime("YYYY-Www-D", "1601-W01-1"), 0);

        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "1"), 2);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "160A0101"), 4);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "00000101"), 1);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "16000101"), 4);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "16010001"), 6);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "16011301"), 6);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "16010190"), 7);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "18000229"), 8);
        assert_eq!(super::test_formatted_datetime("YYYY-MM-DD", "1601 01 01"), 5);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "160101010"), 9);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "1601A011"), 5);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "1601W531"), 7);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "1601W601"), 6);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "2009W531"), 0);
        assert_eq!(super::test_formatted_datetime("YYYYWwwD", "1601W018"), 8);
        assert_eq!(super::test_formatted_datetime("YYYYDDD", "1601366"), 7);
        assert_eq!(super::test_formatted_datetime("YYYYDDD", "1601370"), 6);
        assert_eq!(super::test_formatted_datetime("YYYYDDD", "1601400"), 5);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "01"), 1);
        assert_eq!(super::test_formatted_datetime("YYYYMMDD", "1601010"), 8);
    }

    #[test]
    fn test_test_formatted_datetime_times() {
        assert_eq!(super::test_formatted_datetime("hhmmss.sssssssssZ", "000000.000000000Z"), 0);
        assert_eq!(super::test_formatted_datetime("hh:mm:ss.sssssssssZ", "00:00:00.000000000Z"), 0);
        assert_eq!(super::test_formatted_datetime("hhmmss.sssssssss+hhmm", "000000.00000000000000"), 0);
        assert_eq!(super::test_formatted_datetime("hh:mm:ss.sssssssss+hh:mm", "00:00:00.000000000+00:00"), 0);

        assert_eq!(super::test_formatted_datetime("hhmmss", "300000"), 1);
        assert_eq!(super::test_formatted_datetime("hhmmss", "250000"), 2);
        assert_eq!(super::test_formatted_datetime("hhmmss", "006000"), 3);
        assert_eq!(super::test_formatted_datetime("hhmmss", "000060"), 5);
        assert_eq!(super::test_formatted_datetime("hh:mm:ss", "00-00-00"), 3);
        assert_eq!(super::test_formatted_datetime("hhmmss.ss", "000000,00"), 7);
        assert_eq!(super::test_formatted_datetime("hhmmss+hhmm", "000000 0000"), 7);
        assert_eq!(super::test_formatted_datetime("hhmmss+hhmm", "00000000001"), 11);
        assert_eq!(super::test_formatted_datetime("hhmmssZ", "000000A"), 7);
        assert_eq!(super::test_formatted_datetime("hhmmss", " "), 1);
    }

    #[test]
    fn test_test_formatted_datetimes() {
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss", "16010101T000000"), 0);
        assert_eq!(super::test_formatted_datetime("YYYY-MM-DDThh:mm:ss.sssssssss+hh:mm",
                   "1601-01-01T00:00:00.000000000+00:00"), 0);
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss", "16010101 000000"), 9);
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss", " "), 1);
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss", "16010101T      "), 10);
    }

    #[test]
    fn test_test_formatted_dp_comma() {
        assert_eq!(super::test_formatted_datetime("hhmmss,ss", "000000,00"), 0);
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss,ss", "16010101T000000,00"), 0);
        assert_eq!(super::test_formatted_datetime("hhmmss,ss", "000000.00"), 7);
        assert_eq!(super::test_formatted_datetime("YYYYMMDDThhmmss,ss", "16010101T000000.00"), 16);
    }
}
