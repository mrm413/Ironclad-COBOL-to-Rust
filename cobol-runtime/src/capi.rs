// capi.rs — CAPI introspection shim for GnuCOBOL C-API test compatibility.
// Emulates the CAPI C function that prints parameter metadata and mutates fields.

use crate::field::CobolRecord;

/// Type tag for CAPI parameter introspection.
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum CApiType {
    Binary,
    Comp3,
    Display,
    AlphaX,
    Group,
    Edited,
}

/// Compile-time metadata for one CALL "CAPI" parameter.
#[derive(Debug, Clone)]
pub struct CApiParam {
    pub field_name: String,       // e.g. "BINFLD5"; empty for literals
    pub capi_type: CApiType,
    pub pic: String,              // e.g. "S9(9)", "X(9)", "(18)"
    pub by_value: bool,
    pub size: usize,              // field size in bytes
    pub is_signed: bool,
    pub scale: usize,             // decimal places
    pub digits: usize,            // display digit count
    pub literal_display: String,  // pre-formatted display for literals; empty for fields
}

impl CApiType {
    pub fn label(&self) -> &'static str {
        match self {
            CApiType::Binary  => "BINARY",
            CApiType::Comp3   => "COMP-3",
            CApiType::Display => "DISPLAY",
            CApiType::AlphaX  => "X",
            CApiType::Group   => "Group",
            CApiType::Edited  => "EDITED",
        }
    }
}

/// CAPI dispatch — prints parameter introspection, mutates BY REFERENCE fields.
/// `field_based`: true = PIC-formatted display (test 151), false = raw integer (test 150)
pub fn capi_dispatch(params: &[CApiParam], record: &mut CobolRecord) {
    capi_dispatch_mode(params, record, false)
}

pub fn capi_dispatch_mode(params: &[CApiParam], record: &mut CobolRecord, field_based: bool) {
    println!("CAPI called with {} parameters", params.len());
    for (i, p) in params.iter().enumerate() {
        let k = i + 1;
        let mode = if p.by_value { "BY VALUE     " } else { "BY REFERENCE " };
        let is_literal = p.field_name.is_empty();

        match p.capi_type {
            CApiType::AlphaX => {
                let display_val = if is_literal {
                    p.literal_display.clone()
                } else {
                    let raw = record.get_bytes(&p.field_name);
                    let s = String::from_utf8_lossy(raw).to_string();
                    if field_based { s } else { s.trim_end().to_string() }
                };
                println!(" {}: {:<8} {}{:<11} '{}';", k, p.capi_type.label(), mode, p.pic, display_val);
                if !p.by_value && !is_literal {
                    let bye = format!("{:<width$}", "Bye!", width = p.size);
                    record.set_bytes(&p.field_name, bye.as_bytes());
                }
            }
            CApiType::Group => {
                let display_val = if is_literal {
                    p.literal_display.clone()
                } else {
                    let raw = record.get_bytes(&p.field_name);
                    let s = String::from_utf8_lossy(raw).to_string();
                    format!("{:<width$}", s, width = p.size)
                };
                println!(" {}: {:<8} {}{:<11} '{}';", k, p.capi_type.label(), mode, p.pic, display_val);
                if !p.by_value && !is_literal {
                    let bye = format!("{:<width$}", "Bye-Bye Birdie!", width = p.size);
                    record.set_bytes(&p.field_name, bye.as_bytes());
                }
            }
            CApiType::Edited => {
                if is_literal { return; } // Edited literals don't exist
                let raw_val = record.get_f64(&p.field_name);
                let factor = 10f64.powi(p.scale as i32);
                let scaled = (raw_val * factor).round() as i64;
                // Display: field_based shows PIC-edited bytes, param_based shows raw scaled integer
                let display_val = if field_based {
                    let raw = record.get_bytes(&p.field_name);
                    String::from_utf8_lossy(raw).to_string()
                } else {
                    format!("{}", scaled)
                };
                // Mutation: add 130 (scaled integer), negate
                let new_scaled = -(scaled + 130);
                let new_val = new_scaled as f64 / factor;
                if !p.by_value {
                    record.set_f64(&p.field_name, new_val);
                }
                // Get new PIC-edited display after mutation
                let new_raw = record.get_bytes(&p.field_name);
                let new_display = String::from_utf8_lossy(new_raw).to_string();
                println!(" {}: {:<8} {}{:<11} {}  to {};",
                    k, p.capi_type.label(), mode, p.pic, display_val, new_display);
            }
            _ => {
                // Numeric types: BINARY, COMP-3, DISPLAY
                let display_val = if is_literal {
                    p.literal_display.clone()
                } else {
                    let val = record.get_f64(&p.field_name);
                    if field_based {
                        format_numeric_display(val, p.digits, p.scale, p.is_signed)
                    } else {
                        format_numeric_raw(val, p.scale, p.is_signed)
                    }
                };

                println!(" {}: {:<8} {}{:<11} {};", k, p.capi_type.label(), mode, p.pic, display_val);

                // Mutation: add 3
                if !p.by_value && !is_literal {
                    let raw_val = record.get_f64(&p.field_name);
                    record.set_f64(&p.field_name, raw_val + 3.0);
                }
            }
        }
    }
}

/// Format a numeric value as raw integer for param_based CAPI output.
/// No leading zeros, sign only when negative.
fn format_numeric_raw(value: f64, scale: usize, _is_signed: bool) -> String {
    if scale > 0 {
        let factor = 10f64.powi(scale as i32);
        let scaled = (value * factor).round() as i64;
        format!("{}", scaled)
    } else {
        let int_val = value.round() as i64;
        format!("{}", int_val)
    }
}

/// Format a numeric value as PIC-formatted display for CAPI output.
/// Uses digits count for leading zeros and sign prefix when signed.
fn format_numeric_display(value: f64, digits: usize, scale: usize, is_signed: bool) -> String {
    let abs_val = value.abs();
    if scale > 0 {
        // Has decimal places: format as integer + decimal parts
        let factor = 10f64.powi(scale as i32);
        let total_scaled = (abs_val * factor).round() as i64;
        let int_part = total_scaled / (factor as i64);
        let dec_part = total_scaled % (factor as i64);
        let int_digits = if digits > scale { digits - scale } else { digits };
        let num_str = format!("{:0>width$}.{:0>scale$}", int_part, dec_part, width = int_digits, scale = scale);
        if is_signed {
            let sign = if value < 0.0 { "-" } else { "+" };
            format!("{}{}", sign, num_str)
        } else {
            num_str
        }
    } else {
        let int_val = abs_val.round() as i64;
        let num_str = format!("{:0>width$}", int_val, width = digits);
        if is_signed {
            let sign = if value < 0.0 { "-" } else { "+" };
            format!("{}{}", sign, num_str)
        } else {
            num_str
        }
    }
}
