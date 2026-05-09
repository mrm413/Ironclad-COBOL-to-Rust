/// Edited numeric formatting engine for COBOL PIC edit patterns.
///
/// COBOL edited numerics are display-only fields that format numbers with
/// zero suppression, commas, decimal points, dollar signs, and sign indicators.
///
/// Supported PIC edit characters:
/// - `9`  — Always display digit
/// - `Z`  — Suppress leading zero with space
/// - `*`  — Suppress leading zero with asterisk
/// - `,`  — Comma (suppressed in zero-suppressed area)
/// - `.`  — Decimal point
/// - `$`  — Dollar sign (fixed: single $, floating: $$...)
/// - `+`  — Sign (floating: shows + or -, fixed: shows + or -)
/// - `-`  — Sign (floating: shows space or -, fixed: shows space or -)
/// - `CR` — Credit (trailing "CR" if negative, spaces if positive)
/// - `DB` — Debit (trailing "DB" if negative, spaces if positive)
/// - `B`  — Blank insertion
/// - `0`  — Zero insertion character
/// - `/`  — Slash insertion
///
/// Format a numeric value according to a COBOL PIC edit pattern.
///
/// # Arguments
/// * `value` - The scaled integer value (e.g., 12345 for 123.45 with scale=2)
/// * `scale` - Number of decimal digits (V positions in original PIC)
/// * `pattern` - The expanded PIC edit pattern (e.g., "ZZZ,ZZZ,ZZ9")
///
/// # Returns
/// Formatted string matching the pattern length.
pub fn format_edited(value: impl Into<i128>, scale: usize, pattern: &str, decimal_comma: bool) -> String {
    format_edited_currency(value, scale, pattern, decimal_comma, '$')
}

/// Format a numeric value with a custom currency character.
/// `currency_char` is the character used as a currency symbol in the PIC pattern (default '$').
pub fn format_edited_currency(value: impl Into<i128>, scale: usize, pattern: &str, decimal_comma: bool, currency_char: char) -> String {
    let value: i128 = value.into();
    let abs_value = value.unsigned_abs();

    // Convert absolute value to digit string, zero-padded to needed length
    let _digit_str = format!("{}", abs_value);

    // Count how many digit positions exist in the pattern
    // Digit positions: 9, Z, *, and floating $, +, - (after the first)
    let upper = pattern.to_uppercase();
    let chars: Vec<char> = upper.chars().collect();
    let _pat_len = chars.len();

    // Detect CR/DB at end
    let (effective_pattern, has_cr, has_db) = detect_trailing_sign(&upper);
    let eff_chars: Vec<char> = effective_pattern.chars().collect();

    // Find decimal point position in pattern
    let _decimal_pos = eff_chars.iter().position(|&c| c == '.');

    // Classify each position in the pattern
    let currency_upper = currency_char.to_ascii_uppercase();
    let positions = classify_positions(&eff_chars, decimal_comma, currency_upper);

    // Count total digit positions (integer + decimal)
    let int_digit_positions = positions.iter()
        .filter(|p| p.is_digit_position && !p.is_decimal_part)
        .count();
    let dec_digit_positions = positions.iter()
        .filter(|p| p.is_digit_position && p.is_decimal_part)
        .count();

    // Split value into integer and decimal parts
    let (int_part_str, dec_part_str) = split_value(abs_value, scale, int_digit_positions, dec_digit_positions);

    // If the displayed value is effectively 0, suppress the sign
    let is_negative = value < 0 && !(int_part_str.chars().all(|c| c == '0') && dec_part_str.chars().all(|c| c == '0'));

    // Build the output by filling digit positions right-to-left
    let mut output: Vec<char> = vec![' '; eff_chars.len()];
    let mut int_idx = int_part_str.len();
    let mut dec_idx = 0;

    // Fill decimal positions left-to-right
    for (i, pos) in positions.iter().enumerate() {
        if pos.is_decimal_part && pos.is_digit_position {
            if dec_idx < dec_part_str.len() {
                output[i] = dec_part_str.as_bytes()[dec_idx] as char;
            } else {
                output[i] = '0';
            }
            dec_idx += 1;
        }
    }

    // Fill integer positions right-to-left
    for (i, pos) in positions.iter().enumerate().rev() {
        if !pos.is_decimal_part && pos.is_digit_position {
            if int_idx > 0 {
                int_idx -= 1;
                output[i] = int_part_str.as_bytes()[int_idx] as char;
            } else {
                output[i] = '0'; // Leading zero (will be suppressed later)
            }
        }
    }

    // Place insertion characters (swap . and , when DECIMAL-POINT IS COMMA)
    let dp_char = if decimal_comma { ',' } else { '.' };
    let comma_char = if decimal_comma { '.' } else { ',' };
    for (i, pos) in positions.iter().enumerate() {
        match pos.kind {
            PosKind::DecimalPoint => output[i] = dp_char,
            PosKind::Comma => output[i] = comma_char,
            PosKind::Slash => output[i] = '/',
            PosKind::BlankInsert => output[i] = ' ',
            PosKind::ZeroInsert => output[i] = '0',
            PosKind::FixedDollar => output[i] = currency_char,
            _ => {}
        }
    }

    // Apply zero suppression
    apply_zero_suppression(&mut output, &positions, &eff_chars, is_negative, currency_char);

    let mut result: String = output.into_iter().collect();

    // Append CR/DB
    if has_cr {
        result.push_str(if is_negative { "CR" } else { "  " });
    }
    if has_db {
        result.push_str(if is_negative { "DB" } else { "  " });
    }

    result
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum PosKind {
    Nine,           // 9 — always display
    ZeroSuppress,   // Z — suppress with space
    StarSuppress,   // * — suppress with asterisk
    FixedDollar,    // $ — single dollar sign
    FloatDollar,    // $ — floating dollar sign (part of $$...)
    FloatPlus,      // + — floating plus/minus
    FloatMinus,     // - — floating space/minus
    DecimalPoint,   // . — decimal separator
    Comma,          // , — thousands separator
    Slash,          // / — date separator insertion
    BlankInsert,    // B — blank insertion
    ZeroInsert,     // 0 — zero insertion (when not a digit position)
}

#[derive(Debug, Clone)]
struct Position {
    kind: PosKind,
    is_digit_position: bool,
    is_decimal_part: bool,
}

fn detect_trailing_sign(pattern: &str) -> (String, bool, bool) {
    if let Some(stripped) = pattern.strip_suffix("CR") {
        (stripped.to_string(), true, false)
    } else if let Some(stripped) = pattern.strip_suffix("DB") {
        (stripped.to_string(), false, true)
    } else {
        (pattern.to_string(), false, false)
    }
}

fn classify_positions(chars: &[char], decimal_comma: bool, currency_char: char) -> Vec<Position> {
    let mut positions = Vec::with_capacity(chars.len());
    let mut past_decimal = false;

    // With DECIMAL-POINT IS COMMA, comma is the decimal separator and period is thousands
    let dec_sep = if decimal_comma { ',' } else { '.' };
    let thou_sep = if decimal_comma { '.' } else { ',' };

    // Detect floating symbols: if there are 2+ consecutive $, +, or - they are floating
    // Also handle custom currency character (e.g., 'Y' when CURRENCY SIGN IS "Y")
    let dollar_count = chars.iter().filter(|&&c| c == '$' || c == currency_char).count();
    let plus_count = chars.iter().filter(|&&c| c == '+').count();
    let minus_count = chars.iter().filter(|&&c| c == '-').count();

    let has_float_dollar = dollar_count >= 2;
    let has_float_plus = plus_count >= 2;
    let has_float_minus = minus_count >= 2;

    let mut first_dollar_seen = false;

    for &ch in chars {
        if ch == dec_sep {
            past_decimal = true;
            positions.push(Position {
                kind: PosKind::DecimalPoint,
                is_digit_position: false,
                is_decimal_part: false,
            });
            continue;
        }

        // V = implied decimal point (no physical character, just marks integer/decimal boundary)
        if ch == 'V' {
            past_decimal = true;
            continue;
        }

        let (kind, is_digit) = match ch {
            '9' => (PosKind::Nine, true),
            'Z' => (PosKind::ZeroSuppress, true),
            '*' => (PosKind::StarSuppress, true),
            c if c == '$' || c == currency_char => {
                if has_float_dollar {
                    if !first_dollar_seen {
                        first_dollar_seen = true;
                        (PosKind::FloatDollar, false) // First $ is the sign position
                    } else {
                        (PosKind::FloatDollar, true)  // Subsequent $ are digit positions
                    }
                } else {
                    (PosKind::FixedDollar, false)
                }
            }
            '+' => {
                if has_float_plus {
                    (PosKind::FloatPlus, true)
                } else {
                    (PosKind::FloatPlus, false)
                }
            }
            '-' => {
                if has_float_minus {
                    (PosKind::FloatMinus, true)
                } else {
                    (PosKind::FloatMinus, false)
                }
            }
            c if c == thou_sep => (PosKind::Comma, false),
            '/' => (PosKind::Slash, false),
            'B' => (PosKind::BlankInsert, false),
            '0' => (PosKind::ZeroInsert, false),
            _ => (PosKind::Nine, false), // Unknown — treat as literal
        };

        positions.push(Position {
            kind,
            is_digit_position: is_digit,
            is_decimal_part: past_decimal,
        });
    }

    positions
}

fn split_value(abs_value: u128, scale: usize, int_positions: usize, dec_positions: usize) -> (String, String) {
    if scale == 0 {
        let s = format!("{}", abs_value);
        let padded = if s.len() < int_positions {
            format!("{:0>width$}", abs_value, width = int_positions)
        } else {
            s
        };
        let dec = "0".repeat(dec_positions);
        (padded, dec)
    } else {
        let divisor = 10u128.pow(scale as u32);
        let int_part = abs_value / divisor;
        let dec_part = abs_value % divisor;

        let int_s = format!("{}", int_part);
        let padded_int = if int_s.len() < int_positions {
            format!("{:0>width$}", int_part, width = int_positions)
        } else {
            int_s
        };

        let dec_s = format!("{:0>width$}", dec_part, width = scale);
        // Truncate or pad to dec_positions
        let dec_padded = if dec_s.len() >= dec_positions {
            dec_s[..dec_positions].to_string()
        } else {
            format!("{:0<width$}", dec_s, width = dec_positions)
        };

        (padded_int, dec_padded)
    }
}

fn apply_zero_suppression(output: &mut [char], positions: &[Position], _chars: &[char], is_negative: bool, currency_char: char) {
    // Walk left-to-right through integer positions. Suppress leading zeros.
    let mut suppressing = true;
    let mut any_digit_suppressed = false; // Track if a digit position was actually suppressed
    let float_sign_placed = false;

    for (i, pos) in positions.iter().enumerate() {
        if pos.is_decimal_part {
            break; // Stop suppression at decimal point
        }

        match pos.kind {
            PosKind::ZeroSuppress => {
                if suppressing && output[i] == '0' {
                    output[i] = ' ';
                    any_digit_suppressed = true;
                } else {
                    suppressing = false;
                }
            }
            PosKind::StarSuppress => {
                if suppressing && output[i] == '0' {
                    output[i] = '*';
                    any_digit_suppressed = true;
                } else {
                    suppressing = false;
                }
            }
            PosKind::FloatDollar => {
                if pos.is_digit_position {
                    if suppressing && output[i] == '0' {
                        output[i] = ' ';
                    } else {
                        suppressing = false;
                    }
                }
                if !pos.is_digit_position {
                    // Fixed position for the $ sign — handled after suppression
                }
            }
            PosKind::FloatPlus => {
                if pos.is_digit_position {
                    if suppressing && output[i] == '0' {
                        output[i] = ' ';
                    } else {
                        suppressing = false;
                    }
                }
                // Non-digit FloatPlus (single +) is a fixed sign — don't affect suppression
            }
            PosKind::FloatMinus => {
                if pos.is_digit_position {
                    if suppressing && output[i] == '0' {
                        output[i] = ' ';
                    } else {
                        suppressing = false;
                    }
                }
                // Non-digit FloatMinus (single -) is a fixed sign — don't affect suppression
            }
            PosKind::Nine => {
                suppressing = false;
            }
            PosKind::Comma => {
                // Comma in suppressed zone becomes space (or * for star suppress)
                if suppressing {
                    let star_mode = positions.iter()
                        .any(|p| p.kind == PosKind::StarSuppress);
                    output[i] = if star_mode { '*' } else { ' ' };
                }
            }
            PosKind::BlankInsert => {
                // B in suppressed zone after a suppressed digit becomes fill char
                if suppressing && any_digit_suppressed {
                    let star_mode = positions.iter()
                        .any(|p| p.kind == PosKind::StarSuppress);
                    if star_mode {
                        output[i] = '*';
                    }
                }
            }
            PosKind::FixedDollar => {
                output[i] = currency_char;
            }
            _ => {}
        }
    }

    // Place floating symbols
    // For floating $: find the rightmost suppressed position and place $ just left of first significant digit
    let has_float_dollar = positions.iter().any(|p| p.kind == PosKind::FloatDollar);
    if has_float_dollar && !float_sign_placed {
        // Find first non-space digit position (from left)
        let mut insert_pos = None;
        for (i, pos) in positions.iter().enumerate() {
            if pos.is_decimal_part { break; }
            if (pos.kind == PosKind::FloatDollar || pos.kind == PosKind::Comma)
                && output[i] != ' ' && pos.is_digit_position
            {
                // First significant digit — place $ one position left
                insert_pos = Some(i);
                break;
            }
        }
        if let Some(pos) = insert_pos {
            // Find the space just before this position
            if pos > 0 && output[pos - 1] == ' ' {
                output[pos - 1] = currency_char;
            } else if pos > 0 && (output[pos - 1] == ',' || positions[pos-1].kind == PosKind::Comma) {
                // Comma was suppressed, use it
                output[pos - 1] = currency_char;
            }
        } else {
            // All zeros — place $ at rightmost float position before decimal
            let mut last_float = None;
            for (i, pos) in positions.iter().enumerate() {
                if pos.is_decimal_part { break; }
                if pos.kind == PosKind::FloatDollar {
                    last_float = Some(i);
                }
            }
            if let Some(pos) = last_float {
                output[pos] = '$';
            }
        }
    }

    // Count floating + and - to distinguish fixed vs floating
    let float_plus_count = positions.iter().filter(|p| p.kind == PosKind::FloatPlus).count();
    let float_minus_count = positions.iter().filter(|p| p.kind == PosKind::FloatMinus).count();

    // Handle floating signs (2+ positions)
    if float_plus_count >= 2 {
        place_float_sign(output, positions, if is_negative { '-' } else { '+' }, PosKind::FloatPlus);
    } else if float_plus_count == 1 {
        // Fixed sign — place directly at the sign position
        // But if all integer digit positions were suppressed, suppress sign too
        let all_int_digits_suppressed = positions.iter().enumerate()
            .filter(|(_, p)| p.is_digit_position && !p.is_decimal_part)
            .all(|(i, _)| output[i] == ' ' || output[i] == '*');
        for (i, pos) in positions.iter().enumerate() {
            if pos.kind == PosKind::FloatPlus {
                output[i] = if all_int_digits_suppressed { ' ' }
                            else if is_negative { '-' } else { '+' };
            }
        }
    }

    if float_minus_count >= 2 {
        place_float_sign(output, positions, if is_negative { '-' } else { ' ' }, PosKind::FloatMinus);
    } else if float_minus_count == 1 {
        // Fixed sign — place directly at the sign position
        // But if all integer digit positions were suppressed, suppress sign too
        let all_int_digits_suppressed = positions.iter().enumerate()
            .filter(|(_, p)| p.is_digit_position && !p.is_decimal_part)
            .all(|(i, _)| output[i] == ' ' || output[i] == '*');
        for (i, pos) in positions.iter().enumerate() {
            if pos.kind == PosKind::FloatMinus {
                output[i] = if all_int_digits_suppressed { ' ' }
                            else if is_negative { '-' } else { ' ' };
            }
        }
    }
}

fn place_float_sign(output: &mut [char], positions: &[Position], sign_char: char, kind: PosKind) {
    // Find first non-space output position among float positions
    let mut first_sig = None;
    for (i, pos) in positions.iter().enumerate() {
        if pos.is_decimal_part { break; }
        if pos.kind == kind && output[i] != ' ' {
            first_sig = Some(i);
            break;
        }
    }
    if let Some(pos) = first_sig {
        if pos > 0 && output[pos - 1] == ' ' {
            output[pos - 1] = sign_char;
        }
    } else {
        // All float digits suppressed — only place sign if there are fixed Nine digits
        // (anchors the sign just before the first significant fixed digit)
        let has_fixed_nine = positions.iter()
            .any(|p| !p.is_decimal_part && p.kind == PosKind::Nine);
        if has_fixed_nine {
            // Place sign at rightmost float position (just before the Nine)
            let mut last = None;
            for (i, pos) in positions.iter().enumerate() {
                if pos.is_decimal_part { break; }
                if pos.kind == kind {
                    last = Some(i);
                }
            }
            if let Some(pos) = last {
                output[pos] = sign_char;
            }
        }
        // If no fixed Nine, all-floating with zero → entire field is spaces (no sign)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_zzz_zzz_zz9_with_value() {
        // PIC ZZZ,ZZZ,ZZ9 with value 1234567
        let result = format_edited(1234567, 0, "ZZZ,ZZZ,ZZ9", false);
        assert_eq!(result, "  1,234,567");
    }

    #[test]
    fn test_zzz_zzz_zz9_with_zero() {
        // PIC ZZZ,ZZZ,ZZ9 with value 0
        let result = format_edited(0, 0, "ZZZ,ZZZ,ZZ9", false);
        assert_eq!(result, "          0");
    }

    #[test]
    fn test_zzz_zzz_zz9_small_value() {
        // PIC ZZZ,ZZZ,ZZ9 with value 42
        let result = format_edited(42, 0, "ZZZ,ZZZ,ZZ9", false);
        assert_eq!(result, "         42");
    }

    #[test]
    fn test_999_999_999() {
        // PIC 999,999,999 with value 1234567
        let result = format_edited(1234567, 0, "999,999,999", false);
        assert_eq!(result, "001,234,567");
    }

    #[test]
    fn test_star_suppress() {
        // PIC ***,***,**9 with value 42
        let result = format_edited(42, 0, "***,***,**9", false);
        assert_eq!(result, "*********42");
    }

    #[test]
    fn test_decimal_point() {
        // PIC ZZZ,ZZ9.99 with value 12345 (scale=2, so 123.45)
        let result = format_edited(12345, 2, "ZZZ,ZZ9.99", false);
        assert_eq!(result, "    123.45");
    }

    #[test]
    fn test_cr_negative() {
        // PIC ZZZ,ZZ9.99CR with negative value
        let result = format_edited(-12345, 2, "ZZZ,ZZ9.99CR", false);
        assert_eq!(result, "    123.45CR");
    }

    #[test]
    fn test_cr_positive() {
        // PIC ZZZ,ZZ9.99CR with positive value — CR becomes spaces
        let result = format_edited(12345, 2, "ZZZ,ZZ9.99CR", false);
        assert_eq!(result, "    123.45  ");
    }

    #[test]
    fn test_db_negative() {
        let result = format_edited(-5000, 0, "ZZZ,ZZ9DB", false);
        assert_eq!(result, "  5,000DB");
    }

    #[test]
    fn test_nine_always_shows() {
        // PIC 9(9) with value 42
        let result = format_edited(42, 0, "999999999", false);
        assert_eq!(result, "000000042");
    }

    #[test]
    fn test_slash_insertion() {
        // PIC 99/99/99 — date format
        let result = format_edited(123106, 0, "99/99/99", false);
        assert_eq!(result, "12/31/06");
    }

    #[test]
    fn test_single_z() {
        // PIC Z9 — suppress only first digit
        let result = format_edited(5, 0, "Z9", false);
        assert_eq!(result, " 5");
    }

    #[test]
    fn test_all_z_zero() {
        // PIC ZZZZ — all zeros suppressed to spaces
        let result = format_edited(0, 0, "ZZZZ", false);
        assert_eq!(result, "    ");
    }

    #[test]
    fn test_large_number_no_truncation() {
        // Value larger than pattern — should still show (overflow)
        let result = format_edited(1234567890, 0, "ZZZ,ZZZ,ZZ9", false);
        // Pattern has 9 digit positions, value has 10 digits — rightmost 9 shown
        assert_eq!(result.len(), 11); // 9 digits + 2 commas
    }

    #[test]
    fn test_alpha_edited_0xxxxxx() {
        let r = format_alphanumeric_edited("123456", "0XXXXXX");
        assert_eq!(r, "0123456");
    }

    #[test]
    fn test_alpha_edited_bxxxxxx() {
        let r = format_alphanumeric_edited("123456", "BXXXXXX");
        assert_eq!(r, " 123456");
    }

    #[test]
    fn test_alpha_edited_xb0xb099_slash() {
        let r = format_alphanumeric_edited("    ", "XB0XB099/");
        assert_eq!(r, "  0  0  /");
    }

    #[test]
    fn test_alpha_edited_short_source() {
        let r = format_alphanumeric_edited("12", "0XXXXXX");
        assert_eq!(r, "012    ");
    }
}

/// Format a string according to a COBOL alphanumeric edited PIC pattern.
///
/// Each X/A/9 in the pattern consumes one character from `source` (left to right).
/// 0 inserts '0', B inserts ' ', / inserts '/'.
/// If source is exhausted, remaining X/A positions get ' ', 9 positions get ' '.
pub fn format_alphanumeric_edited(source: &str, pic: &str) -> String {
    let src = source.as_bytes();
    let mut result = String::with_capacity(pic.len());
    let mut si = 0;
    for ch in pic.chars() {
        match ch.to_ascii_uppercase() {
            'X' | 'A' | '9' => {
                if si < src.len() {
                    result.push(src[si] as char);
                } else {
                    result.push(' ');
                }
                si += 1;
            }
            '0' => result.push('0'),
            'B' => result.push(' '),
            '/' => result.push('/'),
            _ => result.push(ch),
        }
    }
    result
}
