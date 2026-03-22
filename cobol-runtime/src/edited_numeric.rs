/// Edited numeric formatting engine for COBOL PIC edit patterns.
///
/// COBOL edited numerics are display-only fields that format numbers with
/// zero suppression, commas, decimal points, dollar signs, and sign indicators.
///
/// Supported PIC edit characters:
///   9  — Always display digit
///   Z  — Suppress leading zero with space
///   *  — Suppress leading zero with asterisk
///   ,  — Comma (suppressed in zero-suppressed area)
///   .  — Decimal point
///   $  — Dollar sign (fixed: single $, floating: $$...)
///   +  — Sign (floating: shows + or -, fixed: shows + or -)
///   -  — Sign (floating: shows space or -, fixed: shows space or -)
///   CR — Credit (trailing "CR" if negative, spaces if positive)
///   DB — Debit (trailing "DB" if negative, spaces if positive)
///   B  — Blank insertion
///   0  — Zero insertion character
///   /  — Slash insertion

/// Format a numeric value according to a COBOL PIC edit pattern.
///
/// # Arguments
/// * `value` - The scaled integer value (e.g., 12345 for 123.45 with scale=2)
/// * `scale` - Number of decimal digits (V positions in original PIC)
/// * `pattern` - The expanded PIC edit pattern (e.g., "ZZZ,ZZZ,ZZ9")
///
/// # Returns
/// Formatted string matching the pattern length.
pub fn format_edited(value: i64, scale: usize, pattern: &str) -> String {
    let is_negative = value < 0;
    let abs_value = value.unsigned_abs();

    // Convert absolute value to digit string, zero-padded to needed length
    let digit_str = format!("{}", abs_value);

    // Count how many digit positions exist in the pattern
    // Digit positions: 9, Z, *, and floating $, +, - (after the first)
    let upper = pattern.to_uppercase();
    let chars: Vec<char> = upper.chars().collect();
    let pat_len = chars.len();

    // Detect CR/DB at end
    let (effective_pattern, has_cr, has_db) = detect_trailing_sign(&upper);
    let eff_chars: Vec<char> = effective_pattern.chars().collect();

    // Find decimal point position in pattern
    let decimal_pos = eff_chars.iter().position(|&c| c == '.');

    // Classify each position in the pattern
    let positions = classify_positions(&eff_chars);

    // Count total digit positions (integer + decimal)
    let int_digit_positions = positions.iter()
        .filter(|p| p.is_digit_position && !p.is_decimal_part)
        .count();
    let dec_digit_positions = positions.iter()
        .filter(|p| p.is_digit_position && p.is_decimal_part)
        .count();

    // Split value into integer and decimal parts
    let (int_part_str, dec_part_str) = split_value(abs_value, scale, int_digit_positions, dec_digit_positions);

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

    // Place insertion characters
    for (i, pos) in positions.iter().enumerate() {
        match pos.kind {
            PosKind::DecimalPoint => output[i] = '.',
            PosKind::Comma => output[i] = ',',
            PosKind::Slash => output[i] = '/',
            PosKind::BlankInsert => output[i] = ' ',
            PosKind::ZeroInsert => output[i] = '0',
            _ => {}
        }
    }

    // Apply zero suppression
    apply_zero_suppression(&mut output, &positions, &eff_chars, is_negative);

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
    if pattern.ends_with("CR") {
        (pattern[..pattern.len()-2].to_string(), true, false)
    } else if pattern.ends_with("DB") {
        (pattern[..pattern.len()-2].to_string(), false, true)
    } else {
        (pattern.to_string(), false, false)
    }
}

fn classify_positions(chars: &[char]) -> Vec<Position> {
    let mut positions = Vec::with_capacity(chars.len());
    let mut past_decimal = false;

    // Detect floating symbols: if there are 2+ consecutive $, +, or - they are floating
    let dollar_count = chars.iter().filter(|&&c| c == '$').count();
    let plus_count = chars.iter().filter(|&&c| c == '+').count();
    let minus_count = chars.iter().filter(|&&c| c == '-').count();

    let has_float_dollar = dollar_count >= 2;
    let has_float_plus = plus_count >= 2;
    let has_float_minus = minus_count >= 2;

    let mut first_dollar_seen = false;

    for &ch in chars {
        if ch == '.' {
            past_decimal = true;
            positions.push(Position {
                kind: PosKind::DecimalPoint,
                is_digit_position: false,
                is_decimal_part: false,
            });
            continue;
        }

        let (kind, is_digit) = match ch {
            '9' => (PosKind::Nine, true),
            'Z' => (PosKind::ZeroSuppress, true),
            '*' => (PosKind::StarSuppress, true),
            '$' => {
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
            ',' => (PosKind::Comma, false),
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

fn split_value(abs_value: u64, scale: usize, int_positions: usize, dec_positions: usize) -> (String, String) {
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
        let divisor = 10u64.pow(scale as u32);
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

fn apply_zero_suppression(output: &mut [char], positions: &[Position], _chars: &[char], is_negative: bool) {
    // Walk left-to-right through integer positions. Suppress leading zeros.
    let mut suppressing = true;
    let mut float_sign_placed = false;

    for (i, pos) in positions.iter().enumerate() {
        if pos.is_decimal_part {
            break; // Stop suppression at decimal point
        }

        match pos.kind {
            PosKind::ZeroSuppress => {
                if suppressing && output[i] == '0' {
                    output[i] = ' ';
                } else {
                    suppressing = false;
                }
            }
            PosKind::StarSuppress => {
                if suppressing && output[i] == '0' {
                    output[i] = '*';
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
                if suppressing && output[i] == '0' {
                    output[i] = ' ';
                } else {
                    suppressing = false;
                }
            }
            PosKind::FloatMinus => {
                if suppressing && output[i] == '0' {
                    output[i] = ' ';
                } else {
                    suppressing = false;
                }
            }
            PosKind::Nine => {
                suppressing = false;
            }
            PosKind::Comma => {
                // Comma in suppressed zone becomes space (or * for star suppress)
                if suppressing {
                    // Check if the suppress char is *
                    let star_mode = positions.iter()
                        .any(|p| p.kind == PosKind::StarSuppress);
                    output[i] = if star_mode { '*' } else { ' ' };
                }
                // Otherwise comma was already placed
            }
            PosKind::FixedDollar => {
                output[i] = '$';
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
            if pos.kind == PosKind::FloatDollar || pos.kind == PosKind::Comma {
                if output[i] != ' ' && pos.is_digit_position {
                    // First significant digit — place $ one position left
                    insert_pos = Some(i);
                    break;
                }
            }
        }
        if let Some(pos) = insert_pos {
            // Find the space just before this position
            if pos > 0 && output[pos - 1] == ' ' {
                output[pos - 1] = '$';
            } else if pos > 0 && (output[pos - 1] == ',' || positions[pos-1].kind == PosKind::Comma) {
                // Comma was suppressed, use it
                output[pos - 1] = '$';
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

    // For floating + or -: similar logic
    let has_float_plus = positions.iter().any(|p| p.kind == PosKind::FloatPlus);
    let has_float_minus = positions.iter().any(|p| p.kind == PosKind::FloatMinus);

    if has_float_plus {
        place_float_sign(output, positions, if is_negative { '-' } else { '+' }, PosKind::FloatPlus);
    }
    if has_float_minus {
        place_float_sign(output, positions, if is_negative { '-' } else { ' ' }, PosKind::FloatMinus);
    }
}

fn place_float_sign(output: &mut [char], positions: &[Position], sign_char: char, kind: PosKind) {
    // Find first non-space output position
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
        // All suppressed — place at rightmost float position
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
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_zzz_zzz_zz9_with_value() {
        // PIC ZZZ,ZZZ,ZZ9 with value 1234567
        let result = format_edited(1234567, 0, "ZZZ,ZZZ,ZZ9");
        assert_eq!(result, "  1,234,567");
    }

    #[test]
    fn test_zzz_zzz_zz9_with_zero() {
        // PIC ZZZ,ZZZ,ZZ9 with value 0
        let result = format_edited(0, 0, "ZZZ,ZZZ,ZZ9");
        assert_eq!(result, "          0");
    }

    #[test]
    fn test_zzz_zzz_zz9_small_value() {
        // PIC ZZZ,ZZZ,ZZ9 with value 42
        let result = format_edited(42, 0, "ZZZ,ZZZ,ZZ9");
        assert_eq!(result, "         42");
    }

    #[test]
    fn test_999_999_999() {
        // PIC 999,999,999 with value 1234567
        let result = format_edited(1234567, 0, "999,999,999");
        assert_eq!(result, "001,234,567");
    }

    #[test]
    fn test_star_suppress() {
        // PIC ***,***,**9 with value 42
        let result = format_edited(42, 0, "***,***,**9");
        assert_eq!(result, "*********42");
    }

    #[test]
    fn test_decimal_point() {
        // PIC ZZZ,ZZ9.99 with value 12345 (scale=2, so 123.45)
        let result = format_edited(12345, 2, "ZZZ,ZZ9.99");
        assert_eq!(result, "    123.45");
    }

    #[test]
    fn test_cr_negative() {
        // PIC ZZZ,ZZ9.99CR with negative value
        let result = format_edited(-12345, 2, "ZZZ,ZZ9.99CR");
        assert_eq!(result, "    123.45CR");
    }

    #[test]
    fn test_cr_positive() {
        // PIC ZZZ,ZZ9.99CR with positive value — CR becomes spaces
        let result = format_edited(12345, 2, "ZZZ,ZZ9.99CR");
        assert_eq!(result, "    123.45  ");
    }

    #[test]
    fn test_db_negative() {
        let result = format_edited(-5000, 0, "ZZZ,ZZ9DB");
        assert_eq!(result, "  5,000DB");
    }

    #[test]
    fn test_nine_always_shows() {
        // PIC 9(9) with value 42
        let result = format_edited(42, 0, "999999999");
        assert_eq!(result, "000000042");
    }

    #[test]
    fn test_slash_insertion() {
        // PIC 99/99/99 — date format
        let result = format_edited(123106, 0, "99/99/99");
        assert_eq!(result, "12/31/06");
    }

    #[test]
    fn test_single_z() {
        // PIC Z9 — suppress only first digit
        let result = format_edited(5, 0, "Z9");
        assert_eq!(result, " 5");
    }

    #[test]
    fn test_all_z_zero() {
        // PIC ZZZZ — all zeros suppressed to spaces
        let result = format_edited(0, 0, "ZZZZ");
        assert_eq!(result, "    ");
    }

    #[test]
    fn test_large_number_no_truncation() {
        // Value larger than pattern — should still show (overflow)
        let result = format_edited(1234567890, 0, "ZZZ,ZZZ,ZZ9");
        // Pattern has 9 digit positions, value has 10 digits — rightmost 9 shown
        assert_eq!(result.len(), 11); // 9 digits + 2 commas
    }
}
