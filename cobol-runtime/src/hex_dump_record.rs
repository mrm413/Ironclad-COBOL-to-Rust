//! Hex-dump helper for the legacy `field::CobolRecord`.
//!
//! Parity-generated code uses `field::CobolRecord::new(size, vec![FieldDescriptor])`,
//! so auto-dump on program exit must introspect *that* struct — not the
//! central-buffer `CobolRecordV2`. This module provides a single public
//! entry point, [`maybe_dump_record`], that the v2 rustifier injects
//! before every `std::process::exit(...)` emit site.
//!
//! # Activation
//!
//! Controlled entirely by the `IRONCLAD_HEXDUMP` environment variable:
//!
//! * unset / empty / `0` / `off` / `false` → no-op (zero runtime cost
//!   beyond one env lookup and a bool compare)
//! * `1` / `bytes` → raw byte dump only
//! * `full` / `fields` / any other non-empty value → raw bytes **and**
//!   per-field breakdown
//!
//! # Output
//!
//! Everything is written to `stderr` so it never contaminates stdout,
//! which is what the parity harness diffs against GnuCOBOL. The header
//! includes the program name so concurrent test runs are easy to
//! disentangle.

use std::io::Write;

use crate::field::{CobolRecord, FieldDescriptor, FieldType};

/// Runtime entry point. Called unconditionally from generated code at
/// every program-exit emit site; the env-var check is cheap and
/// returns immediately when unset so we can leave the call in release
/// builds without measurable overhead.
pub fn maybe_dump_record(record: &CobolRecord, program: &str) {
    let mode = match std::env::var("IRONCLAD_HEXDUMP") {
        Ok(v) => v,
        Err(_) => return,
    };
    let mode = mode.trim().to_ascii_lowercase();
    if mode.is_empty() || mode == "0" || mode == "off" || mode == "false" {
        return;
    }
    let include_fields = !matches!(mode.as_str(), "1" | "bytes" | "raw");

    let stderr = std::io::stderr();
    let mut out = stderr.lock();
    let _ = writeln!(
        out,
        "=== IRONCLAD HEX DUMP — program={} — {} bytes ===",
        program,
        record.data.len()
    );
    render_bytes(&mut out, &record.data);
    if include_fields {
        let _ = writeln!(out, "--- fields ({}) ---", record.fields.len());
        render_fields(&mut out, record);
    }
    let _ = writeln!(out, "=== END DUMP ===");
    let _ = out.flush();
}

// ────────────────────────────────────────────────────────────────────
// Byte renderer — classic xxd layout: 16 bytes per row, split at 8,
// offset prefix, trailing ASCII gutter (period for non-printable).
// ────────────────────────────────────────────────────────────────────
fn render_bytes<W: Write>(out: &mut W, bytes: &[u8]) {
    if bytes.is_empty() {
        let _ = writeln!(out, "(empty)");
        return;
    }
    let mut offset = 0usize;
    while offset < bytes.len() {
        let end = (offset + 16).min(bytes.len());
        let row = &bytes[offset..end];
        let _ = write!(out, "{:08x}: ", offset);
        for i in 0..16 {
            if i == 8 {
                let _ = write!(out, " ");
            }
            if i < row.len() {
                let _ = write!(out, "{:02x} ", row[i]);
            } else {
                let _ = write!(out, "   ");
            }
        }
        let _ = write!(out, " |");
        for &b in row {
            let c = if (0x20..=0x7e).contains(&b) { b as char } else { '.' };
            let _ = write!(out, "{}", c);
        }
        let _ = writeln!(out, "|");
        offset = end;
    }
}

// ────────────────────────────────────────────────────────────────────
// Field renderer — offset+len | name | type | hex | decoded value
// ────────────────────────────────────────────────────────────────────
fn render_fields<W: Write>(out: &mut W, record: &CobolRecord) {
    for fd in &record.fields {
        let end = fd.offset.saturating_add(fd.size);
        if end > record.data.len() {
            let _ = writeln!(
                out,
                "  @{:06}+{:<4} {:<28} {:<18} <out-of-range>",
                fd.offset,
                fd.size,
                truncate(&fd.name, 28),
                type_label(&fd.field_type),
            );
            continue;
        }
        let slice = &record.data[fd.offset..end];
        let hex = hex_of(slice);
        let decoded = decode(fd, slice);
        let _ = writeln!(
            out,
            "  @{:06}+{:<4} {:<28} {:<18} {} | {}",
            fd.offset,
            fd.size,
            truncate(&fd.name, 28),
            type_label(&fd.field_type),
            hex,
            decoded,
        );
    }
}

fn truncate(s: &str, max: usize) -> String {
    if s.len() <= max { s.to_string() } else { format!("{}…", &s[..max.saturating_sub(1)]) }
}

fn hex_of(bytes: &[u8]) -> String {
    const MAX: usize = 32;
    let mut s = String::with_capacity(bytes.len().min(MAX) * 3 + 4);
    for (i, b) in bytes.iter().take(MAX).enumerate() {
        if i > 0 { s.push(' '); }
        s.push_str(&format!("{:02x}", b));
    }
    if bytes.len() > MAX { s.push_str(" …"); }
    s
}

fn type_label(t: &FieldType) -> &'static str {
    match t {
        FieldType::AlphaNumeric => "AlphaNumeric",
        FieldType::NumericDisplay => "NumericDisplay",
        FieldType::SignedDisplay => "SignedDisplay",
        FieldType::Binary16 => "Binary16",
        FieldType::Binary32 => "Binary32",
        FieldType::Binary64 => "Binary64",
        FieldType::Packed => "Packed(COMP-3)",
        FieldType::Comp6 => "Comp6",
        FieldType::Float32 => "Float32",
        FieldType::Float64 => "Float64",
        FieldType::EditedNumeric(_) => "EditedNumeric",
        FieldType::EditedAlpha(_) => "EditedAlpha",
        FieldType::Group => "Group",
        FieldType::Binary8 => "Binary8",
        FieldType::FloatDecimal16 => "FloatDecimal16",
        FieldType::FloatDecimal34 => "FloatDecimal34",
    }
}

fn decode(fd: &FieldDescriptor, bytes: &[u8]) -> String {
    match &fd.field_type {
        FieldType::AlphaNumeric | FieldType::EditedAlpha(_) => {
            let s: String = bytes.iter().map(|&b| {
                if (0x20..=0x7e).contains(&b) { b as char } else { '.' }
            }).collect();
            format!("\"{}\"", s)
        }
        FieldType::NumericDisplay | FieldType::SignedDisplay => {
            let s: String = bytes.iter().map(|&b| {
                if (0x20..=0x7e).contains(&b) { b as char } else { '.' }
            }).collect();
            if fd.pic_scale > 0 {
                format!("\"{}\" (scale {})", s, fd.pic_scale)
            } else {
                format!("\"{}\"", s)
            }
        }
        FieldType::Binary16 => decode_binary(bytes, 2, fd.is_signed, fd.pic_scale),
        FieldType::Binary32 => decode_binary(bytes, 4, fd.is_signed, fd.pic_scale),
        FieldType::Binary64 => decode_binary(bytes, 8, fd.is_signed, fd.pic_scale),
        FieldType::Float32 => {
            if bytes.len() >= 4 {
                let mut b = [0u8; 4];
                b.copy_from_slice(&bytes[..4]);
                format!("{}", f32::from_ne_bytes(b))
            } else { "<short>".into() }
        }
        FieldType::Float64 => {
            if bytes.len() >= 8 {
                let mut b = [0u8; 8];
                b.copy_from_slice(&bytes[..8]);
                format!("{}", f64::from_ne_bytes(b))
            } else { "<short>".into() }
        }
        FieldType::Packed => decode_packed(bytes, fd.pic_scale, true),
        FieldType::Comp6 => decode_packed(bytes, fd.pic_scale, false),
        FieldType::EditedNumeric(_) => {
            let s: String = bytes.iter().map(|&b| {
                if (0x20..=0x7e).contains(&b) { b as char } else { '.' }
            }).collect();
            format!("\"{}\"", s)
        }
        FieldType::Group => String::new(),
        FieldType::Binary8 => decode_binary(bytes, 1, fd.is_signed, fd.pic_scale),
        FieldType::FloatDecimal16 => {
            if bytes.len() >= 8 {
                let mut b = [0u8; 8];
                b.copy_from_slice(&bytes[..8]);
                format!("{}", f64::from_be_bytes(b))
            } else { "<short>".into() }
        }
        FieldType::FloatDecimal34 => {
            let s = String::from_utf8_lossy(bytes);
            format!("\"{}\"", s.trim_end_matches('\0').trim())
        }
    }
}

fn decode_binary(bytes: &[u8], width: usize, signed: bool, scale: u8) -> String {
    if bytes.len() < width {
        return "<short>".into();
    }
    // GnuCOBOL COMP is big-endian in storage
    let mut acc: i128 = 0;
    let first = bytes[0];
    if signed && first & 0x80 != 0 {
        acc = -1;
    }
    for &b in &bytes[..width] {
        acc = (acc << 8) | (b as i128 & 0xff);
    }
    if signed {
        // sign-extend from `width` bytes
        let bits = (width * 8) as u32;
        let mask = if bits >= 128 { -1i128 } else { (1i128 << bits) - 1 };
        let val = acc & mask;
        let sign_bit = if bits >= 128 { 0 } else { 1i128 << (bits - 1) };
        let signed_val = if bits < 128 && val & sign_bit != 0 { val - (1i128 << bits) } else { val };
        if scale > 0 {
            format!("{} (scale {})", signed_val, scale)
        } else {
            signed_val.to_string()
        }
    } else {
        let bits = (width * 8) as u32;
        let mask = if bits >= 128 { -1i128 } else { (1i128 << bits) - 1 };
        let v = (acc as i128) & mask;
        if scale > 0 {
            format!("{} (scale {})", v as u128, scale)
        } else {
            (v as u128).to_string()
        }
    }
}

fn decode_packed(bytes: &[u8], scale: u8, with_sign: bool) -> String {
    let mut digits = String::new();
    for (i, &b) in bytes.iter().enumerate() {
        let hi = (b >> 4) & 0x0f;
        let lo = b & 0x0f;
        digits.push((b'0' + hi) as char);
        let is_last = i + 1 == bytes.len();
        if with_sign && is_last {
            // low nibble is sign (C=+, D=-, F=unsigned)
            let sign = match lo {
                0x0D => "-",
                _ => "+",
            };
            return if scale > 0 {
                format!("{}{} (scale {})", sign, digits, scale)
            } else {
                format!("{}{}", sign, digits)
            };
        }
        digits.push((b'0' + lo) as char);
    }
    if scale > 0 {
        format!("{} (scale {})", digits, scale)
    } else {
        digits
    }
}

// ────────────────────────────────────────────────────────────────────
// Tests
// ────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;

    fn sample_record() -> CobolRecord {
        CobolRecord::new(
            16,
            vec![
                FieldDescriptor {
                    name: "NAME".into(),
                    offset: 0,
                    size: 8,
                    field_type: FieldType::AlphaNumeric,
                    pic_scale: 0,
                    pic_digits: 8,
                    is_signed: false,
                    justified_right: false,
                    blank_when_zero: false,
                    p_factor: 0,
                    sign_leading: false,
                    sign_separate: false,
                    is_pointer: false,
                    pic_clause_digits: 0,
                },
                FieldDescriptor {
                    name: "COUNT".into(),
                    offset: 8,
                    size: 4,
                    field_type: FieldType::Binary32,
                    pic_scale: 0,
                    pic_digits: 9,
                    is_signed: true,
                    justified_right: false,
                    blank_when_zero: false,
                    p_factor: 0,
                    sign_leading: false,
                    sign_separate: false,
                    is_pointer: false,
                    pic_clause_digits: 0,
                },
            ],
        )
    }

    #[test]
    fn noop_when_env_unset() {
        std::env::remove_var("IRONCLAD_HEXDUMP");
        let rec = sample_record();
        maybe_dump_record(&rec, "t");
    }

    #[test]
    fn render_bytes_empty_is_placeholder() {
        let mut buf = Vec::new();
        render_bytes(&mut buf, &[]);
        let s = String::from_utf8(buf).unwrap();
        assert!(s.contains("(empty)"));
    }

    #[test]
    fn render_bytes_classic_layout() {
        let mut buf = Vec::new();
        render_bytes(&mut buf, b"ABCDEFGHIJKLMNOP");
        let s = String::from_utf8(buf).unwrap();
        assert!(s.starts_with("00000000:"));
        assert!(s.contains("41 42 43 44"));
        assert!(s.contains("|ABCDEFGHIJKLMNOP|"));
    }

    #[test]
    fn fields_render_decoded_values() {
        let mut rec = sample_record();
        rec.data[..4].copy_from_slice(b"ALEX");
        rec.data[8..12].copy_from_slice(&42i32.to_be_bytes());
        let mut buf = Vec::new();
        render_fields(&mut buf, &rec);
        let s = String::from_utf8(buf).unwrap();
        assert!(s.contains("NAME"));
        assert!(s.contains("COUNT"));
        assert!(s.contains("42"));
    }
}
