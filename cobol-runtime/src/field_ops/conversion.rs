// field_ops/conversion.rs — Numeric parsing, BCD pack/unpack, formatting utilities

use crate::field::FieldDescriptor;
use crate::edited_numeric::format_edited;

/// Parse display numeric (ASCII digit) bytes to i64.
pub fn parse_display_numeric(bytes: &[u8], signed: bool) -> i64 {
    let mut result: i64 = 0;
    let mut negative = false;

    for &b in bytes {
        match b {
            b'0'..=b'9' => {
                result = result * 10 + (b - b'0') as i64;
            }
            // Trailing sign overpunch: '{' = +0, 'A'-'I' = +1..+9
            b'{' => { result = result * 10; }
            b'A'..=b'I' => {
                result = result * 10 + (b - b'A' + 1) as i64;
            }
            // Trailing sign overpunch (EBCDIC): '}' = -0, 'J'-'R' = -1..-9
            b'}' => { result = result * 10; negative = true; }
            b'J'..=b'R' => {
                result = result * 10 + (b - b'J' + 1) as i64;
                negative = true;
            }
            // Trailing sign overpunch (GnuCOBOL ASCII): 'p' = -0, 'q'-'y' = -1..-9
            b'p' => { result = result * 10; negative = true; }
            b'q'..=b'y' => {
                result = result * 10 + (b - b'q' + 1) as i64;
                negative = true;
            }
            // Separate sign characters
            b'-' => { negative = true; }
            b'+' | b' ' => {}
            _ => {
                // Treat non-digit as zero
                result = result * 10;
            }
        }
    }

    if signed && negative {
        -result
    } else {
        result
    }
}

/// Parse display numeric (ASCII digit) bytes to i128 — handles values > 18 digits.
pub fn parse_display_numeric_i128(bytes: &[u8], signed: bool) -> i128 {
    let mut result: i128 = 0;
    let mut negative = false;

    for &b in bytes {
        match b {
            b'0'..=b'9' => {
                result = result * 10 + (b - b'0') as i128;
            }
            b'{' => { result = result * 10; }
            b'A'..=b'I' => {
                result = result * 10 + (b - b'A' + 1) as i128;
            }
            b'}' => { result = result * 10; negative = true; }
            b'J'..=b'R' => {
                result = result * 10 + (b - b'J' + 1) as i128;
                negative = true;
            }
            b'p' => { result = result * 10; negative = true; }
            b'q'..=b'y' => {
                result = result * 10 + (b - b'q' + 1) as i128;
                negative = true;
            }
            b'-' => { negative = true; }
            b'+' | b' ' => {}
            _ => {
                result = result * 10;
            }
        }
    }

    if signed && negative {
        -result
    } else {
        result
    }
}

/// Write i64 as display numeric (ASCII digits) into byte buffer.
pub fn write_display_numeric(dest: &mut [u8], value: i64, digits: u8, signed: bool) {
    write_display_numeric_ext(dest, value, digits, signed, false, false);
}

/// Write i64 as display numeric with sign position control.
pub fn write_display_numeric_ext(dest: &mut [u8], value: i64, digits: u8, signed: bool, sign_leading: bool, sign_separate: bool) {
    let negative = value < 0;
    let abs_val = value.unsigned_abs();

    if sign_separate && signed {
        // SEPARATE CHARACTER: sign byte is a separate +/- character
        let sign_byte = if negative { b'-' } else { b'+' };
        let d = digits.max(1) as usize;
        let s = format!("{:0>width$}", abs_val, width = d);
        let digit_bytes = s.as_bytes();

        if sign_leading {
            // LEADING SEPARATE: [sign][digits...]
            if !dest.is_empty() { dest[0] = sign_byte; }
            let digit_dest = &mut dest[1..];
            digit_dest.fill(b'0');
            let copy_len = digit_bytes.len().min(digit_dest.len());
            let src_start = digit_bytes.len().saturating_sub(digit_dest.len());
            let dst_start = digit_dest.len().saturating_sub(digit_bytes.len());
            digit_dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);
        } else {
            // TRAILING SEPARATE: [digits...][sign]
            let last = dest.len().saturating_sub(1);
            let digit_dest = &mut dest[..last];
            digit_dest.fill(b'0');
            let copy_len = digit_bytes.len().min(digit_dest.len());
            let src_start = digit_bytes.len().saturating_sub(digit_dest.len());
            let dst_start = digit_dest.len().saturating_sub(digit_bytes.len());
            digit_dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);
            if dest.len() > 0 { dest[last] = sign_byte; }
        }
    } else {
        // Embedded sign (overpunch)
        let d = digits.max(1) as usize;
        let s = format!("{:0>width$}", abs_val, width = d);
        let digit_bytes = s.as_bytes();

        dest.fill(b'0');
        let copy_len = digit_bytes.len().min(dest.len());
        let src_start = digit_bytes.len().saturating_sub(dest.len());
        let dst_start = dest.len().saturating_sub(digit_bytes.len());
        dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);

        if signed && negative && !dest.is_empty() {
            let sign_pos = if sign_leading { 0 } else { dest.len() - 1 };
            dest[sign_pos] = match dest[sign_pos] {
                b'0'..=b'9' => b'p' + (dest[sign_pos] - b'0'),
                _ => dest[sign_pos],
            };
        }
    }
}

/// Write i128 as display numeric (ASCII digits) into byte buffer.
/// Handles values larger than i64 range (> 18 digits).
pub fn write_display_numeric_i128(dest: &mut [u8], value: i128, digits: u8, signed: bool) {
    write_display_numeric_i128_ext(dest, value, digits, signed, false, false);
}

/// Write i128 as display numeric with sign position control.
pub fn write_display_numeric_i128_ext(dest: &mut [u8], value: i128, digits: u8, signed: bool, sign_leading: bool, sign_separate: bool) {
    let negative = value < 0;
    let abs_val = value.unsigned_abs();

    if sign_separate && signed {
        let sign_byte = if negative { b'-' } else { b'+' };
        let d = digits.max(1) as usize;
        let s = format!("{:0>width$}", abs_val, width = d);
        let digit_bytes = s.as_bytes();

        if sign_leading {
            if !dest.is_empty() { dest[0] = sign_byte; }
            let digit_dest = &mut dest[1..];
            digit_dest.fill(b'0');
            let copy_len = digit_bytes.len().min(digit_dest.len());
            let src_start = digit_bytes.len().saturating_sub(digit_dest.len());
            let dst_start = digit_dest.len().saturating_sub(digit_bytes.len());
            digit_dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);
        } else {
            let last = dest.len().saturating_sub(1);
            let digit_dest = &mut dest[..last];
            digit_dest.fill(b'0');
            let copy_len = digit_bytes.len().min(digit_dest.len());
            let src_start = digit_bytes.len().saturating_sub(digit_dest.len());
            let dst_start = digit_dest.len().saturating_sub(digit_bytes.len());
            digit_dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);
            if dest.len() > 0 { dest[last] = sign_byte; }
        }
    } else {
        let d = digits.max(1) as usize;
        let s = format!("{:0>width$}", abs_val, width = d);
        let digit_bytes = s.as_bytes();

        dest.fill(b'0');
        let copy_len = digit_bytes.len().min(dest.len());
        let src_start = digit_bytes.len().saturating_sub(dest.len());
        let dst_start = dest.len().saturating_sub(digit_bytes.len());
        dest[dst_start..dst_start + copy_len].copy_from_slice(&digit_bytes[src_start..src_start + copy_len]);

        if signed && negative && !dest.is_empty() {
            let sign_pos = if sign_leading { 0 } else { dest.len() - 1 };
            dest[sign_pos] = match dest[sign_pos] {
                b'0'..=b'9' => b'p' + (dest[sign_pos] - b'0'),
                _ => dest[sign_pos],
            };
        }
    }
}

/// Unpack BCD (COMP-3) bytes to display string.
pub fn unpack_bcd(bytes: &[u8], scale: u8, pic_digits: u8, is_signed: bool) -> String {
    if bytes.is_empty() {
        return "0".to_string();
    }

    let mut digits = Vec::new();
    // Each byte has two BCD digits, except last byte: high nibble = digit, low nibble = sign
    for i in 0..bytes.len() - 1 {
        digits.push((bytes[i] >> 4) & 0x0F);
        digits.push(bytes[i] & 0x0F);
    }
    // Last byte: high nibble = digit, low nibble = sign
    let last = bytes[bytes.len() - 1];
    digits.push((last >> 4) & 0x0F);
    let sign_nibble = last & 0x0F;
    let negative = sign_nibble == 0x0D || sign_nibble == 0x0B;

    // Pad/truncate digit string to match pic_digits
    let digit_str: String = digits.iter().map(|&d| (b'0' + d.min(9)) as char).collect();
    let pd = pic_digits.max(1) as usize;
    let digit_str = if digit_str.len() > pd {
        digit_str[digit_str.len() - pd..].to_string()
    } else {
        format!("{:0>width$}", digit_str, width = pd)
    };

    let sign_prefix = if is_signed {
        if negative { "-" } else { "+" }
    } else {
        ""
    };

    if scale > 0 {
        let scale = scale as usize;
        let int_len = digit_str.len().saturating_sub(scale);
        let int_part = &digit_str[..int_len];
        let dec_part = &digit_str[int_len..];
        let int_display = if int_part.is_empty() { "0" } else { int_part };
        format!("{}{}.{}", sign_prefix, int_display, dec_part)
    } else {
        format!("{}{}", sign_prefix, digit_str)
    }
}

/// Unpack BCD bytes to i64 (for arithmetic).
pub fn unpack_bcd_i64(bytes: &[u8], signed: bool) -> i64 {
    if bytes.is_empty() {
        return 0;
    }

    let mut result: i64 = 0;
    for i in 0..bytes.len() - 1 {
        result = result * 10 + ((bytes[i] >> 4) & 0x0F) as i64;
        result = result * 10 + (bytes[i] & 0x0F) as i64;
    }
    let last = bytes[bytes.len() - 1];
    result = result * 10 + ((last >> 4) & 0x0F) as i64;
    let sign_nibble = last & 0x0F;

    if signed && (sign_nibble == 0x0D || sign_nibble == 0x0B) {
        -result
    } else {
        result
    }
}

/// Pack i128 into BCD (COMP-3) bytes.
pub fn pack_bcd(dest: &mut [u8], value: i128, signed: bool) {
    let abs_val = value.unsigned_abs();
    let max_digits = dest.len() * 2 - 1; // last byte's low nibble is sign
    let s = format!("{:0>width$}", abs_val, width = max_digits);
    // Take rightmost max_digits characters (COBOL truncates high-order digits on overflow)
    let start = if s.len() > max_digits { s.len() - max_digits } else { 0 };
    let digit_bytes: Vec<u8> = s[start..].bytes().map(|b| b.wrapping_sub(b'0').min(9)).collect();

    dest.fill(0);
    let mut di = 0; // index into digit_bytes
    for i in 0..dest.len() - 1 {
        let high = if di < digit_bytes.len() { digit_bytes[di] } else { 0 };
        di += 1;
        let low = if di < digit_bytes.len() { digit_bytes[di] } else { 0 };
        di += 1;
        dest[i] = (high << 4) | low;
    }
    // Last byte: high nibble = last digit, low nibble = sign
    // GnuCOBOL convention: 0x0C = signed positive, 0x0D = signed negative, 0x0F = unsigned
    let last_digit = if di < digit_bytes.len() { digit_bytes[di] } else { 0 };
    let sign = if signed && value < 0 { 0x0D } else if signed { 0x0C } else { 0x0F };
    dest[dest.len() - 1] = (last_digit << 4) | sign;
}

/// Unpack BCD (COMP-3) bytes to i128 (for high-precision arithmetic on large fields).
pub fn unpack_bcd_i128(bytes: &[u8], signed: bool) -> i128 {
    if bytes.is_empty() {
        return 0;
    }
    let mut result: i128 = 0;
    for i in 0..bytes.len() - 1 {
        result = result * 10 + ((bytes[i] >> 4) & 0x0F) as i128;
        result = result * 10 + (bytes[i] & 0x0F) as i128;
    }
    let last = bytes[bytes.len() - 1];
    result = result * 10 + ((last >> 4) & 0x0F) as i128;
    let sign_nibble = last & 0x0F;
    if signed && (sign_nibble == 0x0D || sign_nibble == 0x0B) {
        -result
    } else {
        result
    }
}

/// Unpack COMP-6 (unsigned packed decimal, no sign nibble) to display string.
pub fn unpack_comp6(bytes: &[u8], scale: u8, pic_digits: u8) -> String {
    if bytes.is_empty() {
        return "0".to_string();
    }
    let mut digits = Vec::new();
    for &b in bytes {
        digits.push((b >> 4) & 0x0F);
        digits.push(b & 0x0F);
    }
    // Pad/truncate digit string to match pic_digits
    let pd = pic_digits.max(1) as usize;
    let digit_str: String = digits.iter().map(|&d| (b'0' + d.min(9)) as char).collect();
    let digit_str = if digit_str.len() > pd {
        digit_str[digit_str.len() - pd..].to_string()
    } else {
        format!("{:0>width$}", digit_str, width = pd)
    };
    if scale > 0 {
        let scale = scale as usize;
        let int_len = digit_str.len().saturating_sub(scale);
        let int_part = &digit_str[..int_len];
        let dec_part = &digit_str[int_len..];
        let int_display = if int_part.is_empty() { "0" } else { int_part };
        format!("{}.{}", int_display, dec_part)
    } else {
        digit_str
    }
}

/// Unpack COMP-6 bytes to i64 (for arithmetic).
pub fn unpack_comp6_i64(bytes: &[u8]) -> i64 {
    if bytes.is_empty() {
        return 0;
    }
    let mut result: i64 = 0;
    for &b in bytes {
        result = result * 10 + ((b >> 4) & 0x0F) as i64;
        result = result * 10 + (b & 0x0F) as i64;
    }
    result
}

/// Unpack COMP-6 bytes to i128 (for high-precision arithmetic on large fields).
pub fn unpack_comp6_i128(bytes: &[u8]) -> i128 {
    if bytes.is_empty() {
        return 0;
    }
    let mut result: i128 = 0;
    for &b in bytes {
        result = result * 10 + ((b >> 4) & 0x0F) as i128;
        result = result * 10 + (b & 0x0F) as i128;
    }
    result
}

/// Pack i128 into COMP-6 (unsigned packed decimal, no sign nibble) bytes.
pub fn pack_comp6(dest: &mut [u8], value: i128) {
    let abs_val = value.unsigned_abs();
    let max_digits = dest.len() * 2;
    let s = format!("{:0>width$}", abs_val, width = max_digits);
    let start = if s.len() > max_digits { s.len() - max_digits } else { 0 };
    let digit_bytes: Vec<u8> = s[start..].bytes().map(|b| b.wrapping_sub(b'0').min(9)).collect();
    dest.fill(0);
    let mut di = 0;
    for i in 0..dest.len() {
        let high = if di < digit_bytes.len() { digit_bytes[di] } else { 0 };
        di += 1;
        let low = if di < digit_bytes.len() { digit_bytes[di] } else { 0 };
        di += 1;
        dest[i] = (high << 4) | low;
    }
}

/// Format i64 with decimal scale for display.
pub fn format_with_scale(value: i64, scale: u8, digits: u8, is_signed: bool) -> String {
    // Binary truncation: truncate to pic_digits (COBOL -fbinary-truncate behavior)
    let d = digits.max(1) as u32;
    let modulus = 10i64.pow(d);
    let truncated = value.abs() % modulus;
    let negative = value < 0 && truncated != 0;
    let sign_prefix = if is_signed {
        if negative { "-" } else { "+" }
    } else {
        if negative { "-" } else { "" }
    };
    if scale == 0 {
        format!("{}{:0>width$}", sign_prefix, truncated, width = d as usize)
    } else {
        let scale = scale as usize;
        let divisor = 10i64.pow(scale as u32);
        let int_part = truncated / divisor;
        let dec_part = truncated % divisor;
        let int_digits = (digits as usize).saturating_sub(scale);
        if int_digits == 0 {
            // PIC V99: no integer digits, just ".dd"
            format!("{}.{:0>dw$}", sign_prefix, dec_part, dw = scale)
        } else {
            format!("{}{:0>iw$}.{:0>dw$}", sign_prefix, int_part, dec_part, iw = int_digits, dw = scale)
        }
    }
}

/// Format i128 with decimal scale for display — handles unsigned Binary64 values > i64::MAX.
pub fn format_with_scale_i128(value: i128, scale: u8, digits: u8, is_signed: bool) -> String {
    // Binary truncation: truncate to pic_digits (COBOL -fbinary-truncate behavior)
    let d = digits.max(1) as u32;
    let modulus = 10i128.pow(d);
    let truncated = value.abs() % modulus;
    let negative = value < 0 && truncated != 0;
    let sign_prefix = if is_signed {
        if negative { "-" } else { "+" }
    } else {
        if negative { "-" } else { "" }
    };
    if scale == 0 {
        format!("{}{:0>width$}", sign_prefix, truncated, width = d as usize)
    } else {
        let scale = scale as usize;
        let divisor = 10i128.pow(scale as u32);
        let int_part = truncated / divisor;
        let dec_part = truncated % divisor;
        let int_digits = (digits as usize).saturating_sub(scale);
        if int_digits == 0 {
            format!("{}.{:0>dw$}", sign_prefix, dec_part, dw = scale)
        } else {
            format!("{}{:0>iw$}.{:0>dw$}", sign_prefix, int_part, dec_part, iw = int_digits, dw = scale)
        }
    }
}

/// Format an i128 mantissa for COBOL numeric DISPLAY — avoids f64 precision loss.
/// `mantissa` is the raw parsed integer (e.g. 1234567 for PIC 9(5)V99 = 12345.67).
pub(crate) fn format_i128_display(mantissa: i128, int_digits: usize, dec_digits: usize, show_sign: bool) -> String {
    let negative = mantissa < 0;
    let abs = mantissa.unsigned_abs();

    let sign_char = if show_sign {
        if negative { "-" } else { "+" }
    } else {
        ""
    };

    if dec_digits > 0 {
        let divisor = 10u128.pow(dec_digits as u32);
        let int_part = abs / divisor;
        let dec_part = abs % divisor;
        if int_digits == 0 {
            format!("{}.{:0>wd$}", sign_char, dec_part, wd = dec_digits)
        } else {
            format!("{}{:0>wi$}.{:0>wd$}", sign_char, int_part, dec_part, wi = int_digits, wd = dec_digits)
        }
    } else {
        format!("{}{:0>w$}", sign_char, abs, w = int_digits)
    }
}

/// Format edited numeric from raw bytes (for display of EditedNumeric fields).
pub(crate) fn format_edited_from_bytes(bytes: &[u8], _pattern: &str, _scale: u8) -> String {
    // For now, return raw bytes as string — the edit pattern logic will be added
    // when the transpiler starts emitting edited fields
    String::from_utf8_lossy(bytes).to_string()
}

/// Format edited numeric from an f64 value using COBOL editing rules.
/// Handles: floating insertion (+, -, $), zero suppression (Z, *),
/// fixed digits (9), decimal point, comma, B/0// insertion, CR/DB,
/// fixed leading/trailing signs.
/// Pattern prefixed with '~' indicates DECIMAL-POINT IS COMMA mode.
pub(crate) fn format_edited_from_f64(value: f64, pattern: &str, _desc: &FieldDescriptor) -> String {
    // Check for DECIMAL-POINT IS COMMA marker
    let (decimal_comma, pattern) = if pattern.starts_with('~') {
        (true, &pattern[1..])
    } else {
        (false, pattern)
    };

    // Check for custom CURRENCY SIGN marker:
    //   @X@<rest>           — single-char custom currency
    //   @X=<string>@<rest>  — multi-char currency (CURRENCY SIGN "..." WITH PICTURE SYMBOL "X")
    // For multi-char: replacement string starting with whitespace places the currency
    // *after* the digits (trailing), per cobc behavior. Otherwise it's leading.
    let (custom_currency, custom_currency_str, pattern): (Option<char>, Option<String>, &str) =
        if let Some(rest) = pattern.strip_prefix('@') {
            let mut chars = rest.chars();
            if let Some(cc) = chars.next() {
                let after_cc = &rest[cc.len_utf8()..];
                if let Some(rest2) = after_cc.strip_prefix('=') {
                    // Multi-char form: @X=<string>@<rest>
                    if let Some(end) = rest2.find('@') {
                        let s = &rest2[..end];
                        let tail = &rest2[end+1..];
                        (Some(cc), Some(s.to_string()), tail)
                    } else {
                        (None, None, pattern)
                    }
                } else if let Some(rest2) = after_cc.strip_prefix('@') {
                    // Single-char form: @X@<rest>
                    (Some(cc), None, rest2)
                } else {
                    (None, None, pattern)
                }
            } else {
                (None, None, pattern)
            }
        } else {
            (None, None, pattern)
        };

    let apply_custom_currency = |mut result: String| -> String {
        if let Some(cc) = custom_currency {
            if let Some(ref s) = custom_currency_str {
                // Multi-char replacement; leading vs trailing per first char.
                if s.starts_with(char::is_whitespace) {
                    // Trailing: strip the placeholder column from the formatted
                    // output (the parser sized the field to include the multi-
                    // char extension at the end), then append the full string.
                    if let Some(idx) = result.find('$') {
                        result.replace_range(idx..idx+1, "");
                    }
                    result.push_str(s);
                } else {
                    // Leading: replace the first emitted '$' with the multi-
                    // char string. Floating-currency layouts only ever emit
                    // one '$', so a single replacement is sufficient.
                    result = result.replacen('$', s, 1);
                }
            } else {
                result = result.replace('$', &cc.to_string());
            }
        }
        result
    };

    // If decimal_comma mode, delegate to the format_edited engine which handles it properly
    if decimal_comma {
        // Count digit positions to determine scale
        let upper = pattern.to_uppercase();
        // Strip CR/DB
        let eff = upper.trim_end_matches("CR").trim_end_matches("DB");
        // In decimal_comma mode, ',' is the decimal separator
        let comma_pos = eff.rfind(',');
        let scale = comma_pos.map_or(0, |p| {
            eff[p+1..].chars().filter(|c| matches!(c, '9' | 'Z' | '*' | '+' | '-' | '$')).count()
        });
        // Scale the value to integer
        let factor = 10f64.powi(scale as i32);
        let scaled = (value * factor).round() as i128;
        let result = format_edited(scaled, scale, pattern, true);
        return apply_custom_currency(result);
    }

    let pchars: Vec<char> = pattern.chars().collect();
    let n = pchars.len();

    // Handle CR/DB suffix
    let (edit_chars, suffix_type) = if n >= 2 {
        let last2: String = pchars[n-2..].iter().collect();
        match last2.as_str() {
            "CR" | "cr" => (&pchars[..n-2], Some("CR")),
            "DB" | "db" => (&pchars[..n-2], Some("DB")),
            _ => (&pchars[..], None),
        }
    } else {
        (&pchars[..], None)
    };
    // Handle implied decimal point 'V'/'v': find position, then strip from pattern
    let v_pos = edit_chars.iter().position(|c| *c == 'V' || *c == 'v');
    let pchars_owned: Vec<char>;
    let pchars: &[char] = if v_pos.is_some() {
        pchars_owned = edit_chars.iter().copied().filter(|c| *c != 'V' && *c != 'v').collect();
        &pchars_owned
    } else {
        edit_chars
    };
    let n = pchars.len();

    // Detect fixed vs floating signs/currency
    // A single +/- is a fixed sign; 2+ of same char = floating
    let plus_count = pchars.iter().filter(|&&c| c == '+').count();
    let minus_count = pchars.iter().filter(|&&c| c == '-').count();
    let dollar_count = pchars.iter().filter(|&&c| c == '$').count();

    let float_char: Option<char> = if plus_count >= 2 { Some('+') }
        else if minus_count >= 2 { Some('-') }
        else if dollar_count >= 2 { Some('$') }
        else { None };

    // Identify fixed sign/currency positions (single occurrences)
    let fixed_sign_positions: Vec<(usize, char)> = {
        let mut v = Vec::new();
        for (i, ch) in pchars.iter().enumerate() {
            match ch {
                '+' if plus_count == 1 => v.push((i, '+')),
                '-' if minus_count == 1 => v.push((i, '-')),
                '$' if dollar_count == 1 => v.push((i, '$')),
                _ => {}
            }
        }
        v
    };

    // Find decimal point position ('.' = actual visible, 'V' = implied invisible)
    // 'V' has been stripped from pchars, so use v_pos to compute virtual decimal position.
    // v_pos is the position in the original (pre-V-strip) pattern; after stripping,
    // all positions at or after v_pos shift left by 1, so the virtual decimal position
    // in the stripped pattern is v_pos itself (it falls between positions v_pos-1 and v_pos).
    let decimal_pos = if let Some(vp) = v_pos {
        Some(vp) // virtual position: digits before vp are integer, digits at/after vp are decimal
    } else {
        pchars.iter().position(|c| *c == '.')
    };

    // Collect digit positions: chars that consume a digit from the value
    // Fixed signs/currency do NOT consume digits
    let mut digit_positions: Vec<(usize, char)> = Vec::new();
    for (i, ch) in pchars.iter().enumerate() {
        let is_fixed = fixed_sign_positions.iter().any(|&(fi, _)| fi == i);
        if is_fixed {
            continue; // fixed sign/currency doesn't consume a digit
        }
        if matches!(ch, '9' | 'Z' | '*' | '+' | '-' | '$') {
            digit_positions.push((i, *ch));
        }
    }
    let total_digits = digit_positions.len();
    if total_digits == 0 {
        // No digit positions — only fixed signs and insertions
        let mut result: Vec<char> = vec![' '; n];
        let is_negative = value < 0.0;
        let is_display_zero = value.abs() < 0.5;
        let effective_negative = is_negative && !is_display_zero;
        for &(i, ch) in &fixed_sign_positions {
            result[i] = match ch {
                '+' => if effective_negative { '-' } else { '+' },
                '-' => if effective_negative { '-' } else { ' ' },
                '$' => '$',
                _ => ' ',
            };
        }
        for (i, ch) in pchars.iter().enumerate() {
            if !fixed_sign_positions.iter().any(|&(fi, _)| fi == i) {
                result[i] = *ch;
            }
        }
        let mut s: String = result.iter().collect();
        if let Some(suffix) = suffix_type {
            if effective_negative { s.push_str(suffix); } else { s.push_str("  "); }
        }
        return s;
    }

    // Count int/dec digits
    // For '.' decimal: digits AFTER the '.' position (i > dp) are decimal
    // For 'V' implied decimal: digits AT OR AFTER the V position (i >= dp) are decimal
    let n_dec = decimal_pos.map_or(0, |dp| {
        if v_pos.is_some() {
            digit_positions.iter().filter(|&&(i, _)| i >= dp).count()
        } else {
            digit_positions.iter().filter(|&&(i, _)| i > dp).count()
        }
    });
    let n_int = total_digits - n_dec;

    // Extract numeric value
    let is_negative = value < 0.0;
    let abs_val = value.abs();
    let factor = 10f64.powi(n_dec as i32);
    let scaled = (abs_val * factor).round() as u64;
    let digit_str = format!("{:0>w$}", scaled, w = total_digits);
    let dchars: Vec<char> = if digit_str.len() > total_digits {
        digit_str[digit_str.len()-total_digits..].chars().collect()
    } else {
        digit_str.chars().collect()
    };

    let is_display_zero = scaled == 0;
    let effective_negative = is_negative && !is_display_zero;

    // Fill character (* fill or space fill)
    let fill = if digit_positions.iter().any(|(_, c)| *c == '*') { '*' } else { ' ' };

    // Split digits into integer and decimal parts
    let int_digits = &dchars[..n_int];
    let dec_digits = &dchars[n_int..];

    // Find significance trigger for integer part
    let int_first_nonzero = int_digits.iter().position(|c| *c != '0');
    let int_first_nine = digit_positions[..n_int].iter().enumerate()
        .find(|(_, (_, ch))| *ch == '9')
        .map(|(di, _)| di);

    let int_sig = match (int_first_nonzero, int_first_nine) {
        (Some(a), Some(b)) => Some(a.min(b)),
        (Some(a), None) => Some(a),
        (None, Some(b)) => Some(b),
        (None, None) => None,
    };

    let dec_has_nonzero = dec_digits.iter().any(|c| *c != '0');
    let dec_has_nine = digit_positions[n_int..].iter().any(|(_, ch)| *ch == '9');

    // Build output character by character
    let mut result = vec![' '; n];
    let mut d: usize = 0; // current digit index
    let mut int_significant = false;
    let mut currently_suppressed = false; // tracks if we're in active suppression zone

    for (i, ch) in pchars.iter().enumerate() {
        let before_decimal = decimal_pos.map_or(true, |dp| i < dp);
        let after_decimal = decimal_pos.map_or(false, |dp| {
            if v_pos.is_some() { i >= dp } else { i > dp }
        });

        // Check if this is a fixed sign/currency position
        if let Some(&(_, fch)) = fixed_sign_positions.iter().find(|&&(fi, _)| fi == i) {
            result[i] = match fch {
                '+' => if effective_negative { '-' } else { '+' },
                '-' => if effective_negative { '-' } else { ' ' },
                '$' => '$',
                _ => ' ',
            };
            continue;
        }

        if matches!(ch, '9' | 'Z' | '*' | '+' | '-' | '$') {
            if before_decimal || decimal_pos.is_none() {
                // Integer part digit
                if int_sig.map_or(false, |st| d >= st) {
                    int_significant = true;
                }
                if !int_significant {
                    result[i] = match ch { '*' => '*', _ => ' ' };
                    currently_suppressed = true;
                } else {
                    result[i] = dchars[d];
                    currently_suppressed = false;
                }
            } else {
                // Decimal part digit
                if *ch == '9' || dec_has_nonzero || int_significant {
                    result[i] = dchars[d];
                    currently_suppressed = false;
                } else {
                    result[i] = match ch { '*' => '*', _ => ' ' };
                    currently_suppressed = true;
                }
            }
            d += 1;
        } else {
            // Non-digit, non-fixed-sign position
            match ch {
                '.' => {
                    if int_significant || dec_has_nonzero || dec_has_nine {
                        result[i] = '.';
                    } else {
                        result[i] = if fill == '*' { '*' } else { ' ' };
                    }
                }
                ',' => {
                    if int_significant {
                        result[i] = ',';
                    } else {
                        result[i] = fill;
                    }
                }
                'B' => {
                    if currently_suppressed && fill == '*' {
                        result[i] = '*'; // B in * fill zone
                    } else {
                        result[i] = ' ';
                    }
                }
                '0' => {
                    if int_significant || after_decimal {
                        result[i] = '0';
                    } else {
                        result[i] = fill;
                    }
                }
                '/' => result[i] = '/',
                _ => result[i] = *ch,
            }
        }
    }

    // Place float character at the rightmost suppressed float position
    if let Some(ft) = float_char {
        let sign_char = match ft {
            '+' => if effective_negative { '-' } else { '+' },
            '-' => if effective_negative { '-' } else { ' ' },
            '$' => '$',
            _ => ' ',
        };

        let has_significance = int_sig.is_some() || dec_has_nonzero || dec_has_nine;

        if has_significance {
            let mut last_suppressed: Option<usize> = None;
            let mut d2: usize = 0;
            for (i, ch) in pchars.iter().enumerate() {
                if fixed_sign_positions.iter().any(|&(fi, _)| fi == i) { continue; }
                if matches!(ch, '9' | 'Z' | '*' | '+' | '-' | '$') {
                    if matches!(ch, '+' | '-' | '$') {
                        let suppress = if d2 < n_int {
                            int_sig.map_or(true, |st| d2 < st)
                        } else {
                            !dec_has_nonzero && !int_significant
                        };
                        if suppress {
                            last_suppressed = Some(i);
                        }
                    }
                    d2 += 1;
                }
            }

            if let Some(pos) = last_suppressed {
                result[pos] = sign_char;
            }
        }
    }

    // If all digit positions were suppressed (no significance ever triggered),
    // suppress fixed trailing signs too (show as space)
    let all_suppressed = !int_significant && !dec_has_nonzero && !dec_has_nine && int_sig.is_none();
    if all_suppressed {
        for &(i, ch) in &fixed_sign_positions {
            if ch != '$' { // currency sign is always shown; signs get suppressed
                result[i] = ' ';
            }
        }
    }

    // Build final string with CR/DB suffix
    let mut final_result: String = result.iter().collect();
    if let Some(suffix) = suffix_type {
        if effective_negative {
            final_result.push_str(suffix);
        } else {
            final_result.push_str("  ");
        }
    }

    // Substitute custom currency character back for '$' (with optional multi-char expansion)
    final_result = apply_custom_currency(final_result);

    final_result
}

/// Format edited numeric from a computed value.
pub(crate) fn format_edited_from_value(value: i64, _pattern: &str, desc: &FieldDescriptor) -> String {
    // Basic implementation — full edit pattern support will be added incrementally
    let s = if desc.pic_scale > 0 {
        let divisor = 10i64.pow(desc.pic_scale as u32);
        let int_part = value.abs() / divisor;
        let dec_part = value.abs() % divisor;
        format!("{}.{:0>width$}", int_part, dec_part, width = desc.pic_scale as usize)
    } else {
        format!("{}", value.abs())
    };
    // Pad to field size
    format!("{:>width$}", s, width = desc.size)
}

/// Format a floating-point value matching GnuCOBOL display conventions.
/// GnuCOBOL uses C sprintf with `%.*g` format:
///   - Float32 (COMP-1): `sprintf(buf, "%.8g", value)` → 8 significant digits
///   - Float64 (COMP-2): `sprintf(buf, "%.16g", value)` → 16 significant digits
/// `sig_digits` = total significant digits (8 for FLOAT-SHORT, 16 for FLOAT-LONG).
pub fn format_float_display(val: f64, sig_digits: usize) -> String {
    if val == 0.0 { return "0".to_string(); }
    // GnuCOBOL displays NaN and Inf as literal strings
    if val.is_nan() { return "NaN".to_string(); }
    if val.is_infinite() { return if val > 0.0 { "Inf".to_string() } else { "-Inf".to_string() }; }

    // For Float32 precision, work with the f32 value to match GnuCOBOL
    let work_val = if sig_digits <= 8 { (val as f32) as f64 } else { val };

    let abs_val = work_val.abs();

    // Compute the exponent (base-10 order of magnitude)
    let exp10 = abs_val.log10().floor() as i32;

    // C's %g uses fixed notation when exponent is in [-4, precision),
    // and scientific notation otherwise.
    // %g with precision P means P significant digits total.
    if exp10 >= -4 && exp10 < (sig_digits as i32) {
        // Fixed-point notation: use enough decimal places for sig_digits significant digits
        let decimal_places = if exp10 >= 0 {
            // e.g. 476.19049 has exp10=2, need sig_digits - (exp10+1) = 8-3 = 5 decimal places
            let dp = sig_digits as i32 - (exp10 + 1);
            if dp < 0 { 0usize } else { dp as usize }
        } else {
            // e.g. 0.00123 has exp10=-3, need sig_digits + |exp10| - 1 decimal places
            // Actually for %g: decimal_places = precision - (exp10 + 1) when exp10 >= -4
            let dp = sig_digits as i32 - (exp10 + 1);
            dp as usize
        };
        let s = format!("{:.prec$}", work_val, prec = decimal_places);
        // %g strips trailing zeros (but keeps the integer part)
        let trimmed = if s.contains('.') {
            let t = s.trim_end_matches('0');
            if t.ends_with('.') { &t[..t.len()-1] } else { t }
        } else {
            &s
        };
        trimmed.to_string()
    } else {
        // Scientific notation: sig_digits - 1 digits after the decimal point
        let s = format!("{:.prec$E}", work_val, prec = sig_digits - 1);
        // Process the string: strip trailing zeros from mantissa, fix exponent sign
        if let Some(e_pos) = s.rfind('E') {
            let mantissa = &s[..e_pos];
            let exp_str = &s[e_pos + 1..];
            // Strip trailing zeros from mantissa (but keep at least one digit after '.')
            let trimmed = if let Some(dot_pos) = mantissa.find('.') {
                let t = mantissa.trim_end_matches('0');
                if t.ends_with('.') { &mantissa[..dot_pos + 2] } else { t }
            } else {
                mantissa
            };
            // GnuCOBOL always uses E+ or E- (never bare E)
            if exp_str.starts_with('-') {
                format!("{}E{}", trimmed, exp_str)
            } else if exp_str.starts_with('+') {
                format!("{}E{}", trimmed, exp_str)
            } else {
                format!("{}E+{}", trimmed, exp_str)
            }
        } else {
            s
        }
    }
}

/// Compare two f64 values with ULP tolerance for decimal arithmetic emulation.
/// GnuCOBOL uses BCD/decimal arithmetic for DISPLAY numeric fields, which gives
/// exact results. Our f64 emulation accumulates tiny rounding errors in complex
/// expressions (e.g., ((399/100) - (211/100)) * 100 gives 188.0000000000000284
/// instead of 188.0). A 4-ULP tolerance handles this without masking real differences.
/// Returns: -1 (a < b), 0 (equal), 1 (a > b).
pub fn f64_cmp(a: f64, b: f64) -> i32 {
    if a == b { return 0; }
    if a.is_nan() || b.is_nan() {
        return if a.is_nan() && b.is_nan() { 0 } else if a.is_nan() { 1 } else { -1 };
    }
    // Same sign: check if within 4 ULPs
    if (a.to_bits() & 0x8000000000000000) == (b.to_bits() & 0x8000000000000000) {
        let ai = a.to_bits();
        let bi = b.to_bits();
        let diff = if ai > bi { ai - bi } else { bi - ai };
        if diff <= 4 { return 0; }
    }
    if a < b { -1 } else { 1 }
}

/// Compare two f64 values at COMP-1 (f32) precision with 1 ULP tolerance.
/// GnuCOBOL uses decimal-rounded comparison for COMP-1 fields, which means
/// values that differ by at most 1 ULP in f32 are considered equal.
/// This handles the inherent precision loss from f32 arithmetic round-trips.
/// Returns: -1 (a < b), 0 (equal), 1 (a > b).
pub fn f32_cmp(a: f64, b: f64) -> i32 {
    let af = a as f32;
    let bf = b as f32;
    if af == bf { return 0; }
    if af.is_nan() || bf.is_nan() {
        return if af.is_nan() && bf.is_nan() { 0 } else if af.is_nan() { 1 } else { -1 };
    }
    // Same sign + neither is exactly zero: check 1-ULP tolerance to absorb
    // f32 round-trip precision loss. Skip the tolerance when either operand
    // is exactly zero — otherwise the smallest subnormal (1.4012985E-45,
    // which is 1 ULP from 0) would compare equal to 0, breaking IEEE 754
    // f32 underflow loops (run_misc_166).
    if af != 0.0 && bf != 0.0
        && (af.to_bits() & 0x80000000) == (bf.to_bits() & 0x80000000)
    {
        let ai = af.to_bits();
        let bi = bf.to_bits();
        let diff = if ai > bi { ai - bi } else { bi - ai };
        if diff <= 1 { return 0; }
    }
    if af < bf { -1 } else { 1 }
}
