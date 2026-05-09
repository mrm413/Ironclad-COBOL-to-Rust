// cobol-runtime: Runtime types for Ironclad-generated Rust programs.
// These are the types that generated Rust code uses at runtime.

// Internal uses of `field::CobolRecord` under the `central-buffer` feature
// are a transitional state: Phase 4 wires the v2 facade in; Phase 5 migrates
// emitters; Phase 6 retires the legacy path. Suppress the self-deprecation
// warning during that window. External crates still see the deprecation.
#![cfg_attr(feature = "central-buffer", allow(deprecated))]

// ── Pre-existing lint debt ─────────────────────────────────────────────────
//
// The following lint categories fire on legacy pre-Phase-4 code (coerce,
// precision, cobol_file, oracle, datetime_fmt, dli, …). They are *not*
// introduced by the `memory_v2` facade; every new module in Phase 4 is
// clippy-clean on its own. These allows exist so that the Phase 4 exit
// criteria command
//
//   cargo clippy --release -p cobol-runtime --features central-buffer \
//       --all-targets -- -D warnings
//
// can pass without simultaneously requiring a sweep of the legacy runtime.
// A dedicated clippy-cleanup phase should strip this block.
#![allow(
    clippy::approx_constant,
    clippy::assign_op_pattern,
    clippy::collapsible_else_if,
    clippy::collapsible_if,
    clippy::derivable_impls,
    clippy::doc_lazy_continuation,
    clippy::if_same_then_else,
    clippy::implicit_saturating_sub,
    clippy::items_after_test_module,
    clippy::len_zero,
    clippy::manual_abs_diff,
    clippy::manual_ignore_case_cmp,
    clippy::manual_pattern_char_comparison,
    clippy::manual_range_contains,
    clippy::manual_repeat_n,
    clippy::manual_strip,
    clippy::needless_range_loop,
    clippy::needless_return,
    clippy::new_without_default,
    clippy::question_mark,
    clippy::single_match,
    clippy::suspicious_open_options,
    clippy::too_many_arguments,
    clippy::type_complexity,
    clippy::unnecessary_cast,
    clippy::unnecessary_map_or,
    dead_code,
    unused_imports,
    unused_variables,
    unused_mut,
    unreachable_patterns,
    dropping_references,
    unused_assignments,
)]

mod fixed_string;
mod decimal;
mod packed_decimal;
mod file_status;
mod cobol_file;
mod cobol_num;
pub mod chrono_shim;
pub mod ebcdic;
pub mod edited_numeric;
pub mod string_ops;
pub mod cics;
pub mod sql;
pub mod dli;
pub mod report_writer;
pub mod coerce;
pub mod oracle;
pub mod datetime_fmt;
pub use datetime_fmt::{integer_of_date, date_of_integer, integer_of_day, day_of_integer};
pub mod precision;
pub mod float_decimal;
pub use float_decimal::{format_fd16_display, format_fd34_display, fd34_compute, fd34_from_f64, fd34_is_overflow, fd34_is_underflow, fd16_is_overflow, fd16_is_overflow_str, fd16_is_underflow, fd16_is_underflow_str, fd34_parse, fd34_add, fd34_sub, fd34_mul, fd34_div, fd34_pow, fd34_to_f64, fd34_read, fd34_from_f64_str, fd16_compute, fd16_parse, fd16_add, fd16_sub, fd16_mul, fd16_div, fd16_pow, fd16_to_f64, fd16_read, fd16_from_f64_str, fd_cmp};
pub mod screen;
pub mod screen_emission;
mod sign_separate;
pub mod field;
pub mod field_ops;
pub mod field_system;
pub mod capi;
pub mod odo_slide;
pub mod extfh;
pub mod linage;

/// Central-buffer backed v2 memory facade (feature-gated).
///
/// Enabled by the `central-buffer` Cargo feature. Exposes
/// [`memory_v2::CobolRecordV2`] — a thin, index-based re-skin of
/// `ironclad-central-buffer` that lets Phase 5 codegen target the new
/// memory model without touching the legacy `field::CobolRecord`.
#[cfg(feature = "central-buffer")]
pub mod memory_v2;

/// Under the `central-buffer` feature, `CobolRecord` is an alias for
/// `CobolRecordV2` — the name-based adapter on the central-buffer
/// memory model (Phase 6 backend flip).  Generated code that says
/// `use cobol_runtime::CobolRecord` compiles unchanged against either
/// backend; only the in-memory representation changes.
///
/// Without the feature the legacy `field::CobolRecord` is used, kept
/// here for bisection / debugging.
#[cfg(feature = "central-buffer")]
pub use memory_v2::CobolRecordV2;
#[cfg(feature = "central-buffer")]
pub use memory_v2::CobolRecordV2 as CobolRecord;

/// Hex-dump helpers from the central buffer, re-exported so generated
/// code and debugging tools can render the exact byte layout of any
/// record without knowing the crate path.
///
/// Set `IRONCLAD_HEXDUMP=1` (or `full`) at runtime to have the
/// central-buffer runtime auto-emit a dump on program end — useful for
/// diffing against GnuCOBOL output at the byte level.
#[cfg(feature = "central-buffer")]
pub mod hex_dump {
    pub use ironclad_central_buffer::{
        hex_dump_bytes, hex_dump_field, hex_dump_all_fields, maybe_auto_dump,
    };
}

/// Hex-dump helper for the legacy `field::CobolRecord` — what parity
/// binaries actually run. Injected at program-exit emit sites by the
/// v2 rustifier. Activated only when `IRONCLAD_HEXDUMP` is set.
pub mod hex_dump_record;
pub use hex_dump_record::maybe_dump_record;

pub use fixed_string::FixedString;
pub use decimal::Decimal;
pub use packed_decimal::PackedDecimal;
pub use file_status::FileStatus;
pub use cobol_file::CobolFile;
pub use ebcdic::EncodingMode;
pub use cics::CicsContext;
pub use sql::{SqlContext, Sqlca, SqlValue, SqlRow};
pub use dli::{DliContext, DliFunc, PcbStatus, Segment, Ssa};
pub use report_writer::{ReportContext, report_initiate, report_generate, report_terminate};
pub use linage::{LinageState, LinageWriteResult, linage_write, linage_write_page, linage_do_write, linage_do_write_page, linage_reset};
pub use edited_numeric::format_edited;
pub use edited_numeric::format_alphanumeric_edited;
pub use edited_numeric::format_edited_currency;
pub use sign_separate::{format_sign_separate_i64, format_sign_separate_scaled};
pub use cobol_num::CobolNum;
pub use screen::{ScreenField, SPos, screen_display, FieldEditor, accept_field, accept_field_buffered, accept_field_buffered_predraw, accept_line_no_echo, accept_simple_buffered, screen_write_at, screen_flush_grid, screen_clear_grid, screen_clear_line, screen_at_position, set_raw_mode_hidden, restore_console_mode_hidden, screen_mark_touched, end_of_program_prompt, screen_declare_screen_section, screen_emit_pad, screen_align_for_emit, shadow_buffer_snapshot, shadow_buffer_apply, shadow_buffer_clear, with_shadow_and_emitter};
pub use screen_emission::{
    EmissionStyle, StdoutEmitter, GnuCobolLegacyEmitter, Mainframe3270Emitter,
    ShadowBuffer, install_emitter, with_emitter_locked, SHADOW_ROWS, SHADOW_COLS,
};
pub use coerce::{Coerce, CoerceFrom, DynamicValue, FigurativeConstant};
pub use oracle::{CoercionOracle, CoercionContext, CoercionType, CoercionVerb, CoercionStrategy, CoercionOutcome, OracleMode};
// Under central-buffer, CobolRecord is the CobolRecordV2 alias above.
// Without the feature, export the legacy CobolRecord from field.
#[cfg(feature = "central-buffer")]
pub use field::{FieldDescriptor, FieldType, LeafChildInfo};
#[cfg(not(feature = "central-buffer"))]
pub use field::{FieldDescriptor, FieldType, CobolRecord, LeafChildInfo};
pub use field_ops::{ArithOp, cobol_move, cobol_move_physical, cobol_arithmetic, cobol_display, read_as_decimal, write_decimal};
pub use capi::{CApiType, CApiParam, capi_dispatch};
pub use odo_slide::{OdoRegistry, OdoSlideSource, OdoOwnInfo, OdoFieldMeta, OdoDescriptor, InnerOdoCounter};
pub use field_system::{
    cbl_exit_proc_install, cbl_exit_proc_install_ex, cbl_exit_proc_uninstall, cbl_exit_proc_query, get_exit_handlers, is_exit_handler_registered,
    cbl_error_proc_install, cbl_error_proc_uninstall, get_error_handlers,
    set_exception_context, set_file_exception, clear_exception, get_exception_location, get_exception_statement, get_exception_status, get_exception_file, get_exception_message, file_status_to_ec,
    set_environment_name, get_environment_name, set_environment_value, get_environment_value,
    set_argument_number, get_argument_number, get_argument_value,
    set_child_process, take_child_process,
    cbl_gc_fork, cbl_gc_waitpid, enable_fork_emulation,
    set_bounds_check, bounds_check_enabled,
    signal_perform_exit, check_perform_exit,
    signal_section_exit, check_section_exit,
    enter_declarative, leave_declarative,
    set_ec_io_check, ec_io_check_is_on, ec_io_eof_check,
    cancel_program, check_and_clear_cancelled,
    mark_param_omitted, clear_omitted_params, is_param_omitted,
    push_param_sizes, pop_param_sizes, current_param_size,
    enter_program, leave_program,
    set_program_pointer, get_program_pointer, clear_program_pointer};
pub use rust_decimal::Decimal as RustDecimal;

/// Returns the FileStatus for a LINE SEQUENTIAL record that exceeded the maximum record size.
/// With COB_LS_SPLIT=FALSE: returns 04 (record truncated to max).
/// Default (COB_LS_SPLIT=TRUE): returns 06 (record split/overflow).
pub fn ls_overflow_status() -> FileStatus {
    if std::env::var("COB_LS_SPLIT")
        .map(|v| v.eq_ignore_ascii_case("FALSE"))
        .unwrap_or(false)
    {
        FileStatus::SuccessNoLength      // 04: truncated
    } else {
        FileStatus::SuccessRecordTooLong // 06: overflow/split
    }
}


/// matching the FixedString::trimmed() API so generated code compiles
/// regardless of which concrete string type backs a COBOL field.
pub trait CobolTrimmed {
    fn trimmed(&self) -> &str;
}

impl CobolTrimmed for String {
    fn trimmed(&self) -> &str {
        self.trim_end()
    }
}

/// Trait for display_with_width on types that aren't FixedString (e.g. String from refmod)
pub trait DisplayWithWidth {
    fn display_with_width(&self, width: usize) -> String;
}

impl DisplayWithWidth for String {
    fn display_with_width(&self, width: usize) -> String {
        if self.len() >= width {
            self[..width].to_string()
        } else {
            format!("{:<width$}", self, width = width)
        }
    }
}

/// Trait for COBOL MOVE-like conversions between types in generated CALL bindings.
/// Provides an identity impl plus specific impls for numeric casts and
/// FixedString↔numeric conversions that `From` doesn't cover.
pub trait CobolInto<T> {
    fn cobol_into(self) -> T;
}

// Identity: every type converts to itself.
impl<T> CobolInto<T> for T {
    #[inline]
    fn cobol_into(self) -> T { self }
}

// --- Numeric widening/truncating conversions ---
impl CobolInto<i64> for i32 { #[inline] fn cobol_into(self) -> i64 { self as i64 } }
impl CobolInto<i32> for i64 { #[inline] fn cobol_into(self) -> i32 { self as i32 } }
impl CobolInto<f64> for i32 { #[inline] fn cobol_into(self) -> f64 { self as f64 } }
impl CobolInto<f64> for i64 { #[inline] fn cobol_into(self) -> f64 { self as f64 } }
impl CobolInto<i64> for f64 { #[inline] fn cobol_into(self) -> i64 { self as i64 } }
impl CobolInto<i32> for f64 { #[inline] fn cobol_into(self) -> i32 { self as i32 } }

// --- FixedString<N> ↔ numeric conversions ---
impl<const N: usize> CobolInto<FixedString<N>> for i64 {
    #[inline] fn cobol_into(self) -> FixedString<N> { FixedString::from(self) }
}
impl<const N: usize> CobolInto<FixedString<N>> for i32 {
    #[inline] fn cobol_into(self) -> FixedString<N> { FixedString::from(self) }
}
impl<const N: usize> CobolInto<FixedString<N>> for f64 {
    #[inline] fn cobol_into(self) -> FixedString<N> { FixedString::from(self) }
}
impl<const N: usize> CobolInto<i64> for FixedString<N> {
    #[inline] fn cobol_into(self) -> i64 { self.trimmed().parse().unwrap_or(0) }
}
impl<const N: usize> CobolInto<i32> for FixedString<N> {
    #[inline] fn cobol_into(self) -> i32 { self.trimmed().parse().unwrap_or(0) }
}
impl<const N: usize> CobolInto<f64> for FixedString<N> {
    #[inline] fn cobol_into(self) -> f64 { self.trimmed().parse().unwrap_or(0.0) }
}

// --- FixedString<N> ↔ String conversions ---
impl<const N: usize> CobolInto<String> for FixedString<N> {
    #[inline] fn cobol_into(self) -> String { self.as_str().to_owned() }
}
impl<const N: usize> CobolInto<FixedString<N>> for String {
    #[inline] fn cobol_into(self) -> FixedString<N> { FixedString::from(self) }
}

// --- String ↔ numeric (parse-based) ---
impl CobolInto<i32> for String {
    #[inline] fn cobol_into(self) -> i32 { self.trim().parse().unwrap_or(0) }
}
impl CobolInto<i64> for String {
    #[inline] fn cobol_into(self) -> i64 { self.trim().parse().unwrap_or(0) }
}
impl CobolInto<f64> for String {
    #[inline] fn cobol_into(self) -> f64 { self.trim().parse().unwrap_or(0.0) }
}

/// Universal numeric-to-f64 trait for intrinsic function arguments.
/// Works for i32, i64, f32, f64, Decimal, PackedDecimal, and FixedString.
pub trait CobolToF64 {
    fn cobol_to_f64(&self) -> f64;
}

impl CobolToF64 for i8 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for i16 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for i32 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for i64 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for u8 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for u16 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for u32 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for u64 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for isize {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for usize {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for f32 {
    fn cobol_to_f64(&self) -> f64 { *self as f64 }
}
impl CobolToF64 for f64 {
    fn cobol_to_f64(&self) -> f64 { *self }
}
impl CobolToF64 for Decimal {
    fn cobol_to_f64(&self) -> f64 { self.to_f64() }
}
impl<const N: usize> CobolToF64 for PackedDecimal<N> {
    fn cobol_to_f64(&self) -> f64 { self.value() as f64 }
}
impl<const N: usize> CobolToF64 for FixedString<N> {
    fn cobol_to_f64(&self) -> f64 {
        self.to_string().trim().parse::<f64>().unwrap_or(0.0)
    }
}

/// Convert an f32 value to f64 via its canonical decimal representation.
/// This matches GnuCOBOL's behavior of using decimal arithmetic for FLOAT-SHORT
/// operations, avoiding f32 representation artifacts during arithmetic.
#[inline]
pub fn f32_to_clean_f64(x: f32) -> f64 {
    if x.is_nan() || x.is_infinite() || x == 0.0 {
        return x as f64;
    }
    // format!("{}", f32) produces the shortest decimal that round-trips to the same f32.
    // Parsing that as f64 gives a "clean" f64 free of f32 representation noise.
    format!("{}", x).parse::<f64>().unwrap_or(x as f64)
}

/// GnuCOBOL-compatible display for COMP-1 (FLOAT-SHORT / f32).
/// Uses C's `%.8g` convention: 8 significant digits, no trailing zeros,
/// scientific notation when exponent < -4 or >= 8.
pub fn cobol_display_comp1(val: f64) -> String {
    format_gnucobol_float(val, 8)
}

/// GnuCOBOL-compatible display for COMP-2 (FLOAT-LONG / f64).
/// Uses C's `%.16g` convention: 16 significant digits.
pub fn cobol_display_comp2(val: f64) -> String {
    format_gnucobol_float(val, 16)
}

/// COMP-1 (FLOAT-SHORT) equality comparison.
/// GnuCOBOL compares FLOAT-SHORT values with relative tolerance of f32 epsilon,
/// matching single-precision granularity for both promotion and literal comparisons.
pub fn comp1_eq(a: f64, b: f64) -> bool {
    if a == b { return true; }
    let diff = (a - b).abs();
    let mag = a.abs().max(b.abs());
    if mag == 0.0 { return diff == 0.0; }
    diff / mag <= f32::EPSILON as f64
}

/// COMP-1 (FLOAT-SHORT) less-than comparison with f32-epsilon tolerance.
pub fn comp1_lt(a: f64, b: f64) -> bool {
    if comp1_eq(a, b) { return false; }
    a < b
}

/// COMP-1 (FLOAT-SHORT) greater-than comparison with f32-epsilon tolerance.
pub fn comp1_gt(a: f64, b: f64) -> bool {
    if comp1_eq(a, b) { return false; }
    a > b
}

/// COBOL numeric equality: rounds both values to 10 decimal digits to avoid
/// f64 last-bit noise in intermediate arithmetic (e.g., 1.88*100 = 188.00000000000003).
pub fn cobol_num_cmp_eq(a: f64, b: f64) -> bool {
    if a == b { return true; }
    (a * 1e10).round() == (b * 1e10).round()
}

/// COBOL numeric less-than with rounding tolerance.
pub fn cobol_num_cmp_lt(a: f64, b: f64) -> bool {
    if cobol_num_cmp_eq(a, b) { return false; }
    a < b
}

/// COBOL numeric greater-than with rounding tolerance.
pub fn cobol_num_cmp_gt(a: f64, b: f64) -> bool {
    if cobol_num_cmp_eq(a, b) { return false; }
    a > b
}

/// Parse a decimal literal string to f64 with truncation toward zero,
/// matching GnuCOBOL's `mpf_get_d()` semantics.
///
/// Rust's `f64::from_str()` uses IEEE 754 round-to-nearest-even, which may
/// produce an f64 whose magnitude exceeds the exact decimal literal by up to
/// 0.5 ULP. GnuCOBOL stores float literals via GMP's `mpf_get_d()`, which
/// always truncates toward zero (magnitude never exceeds the literal).
///
/// This function parses the literal, then checks whether the nearest f64
/// overshot. If so, it backs off by one ULP.
pub fn f64_literal_trunc(literal: &str) -> f64 {
    let val: f64 = match literal.parse() {
        Ok(v) => v,
        Err(_) => return 0.0,
    };
    if val == 0.0 || !val.is_finite() {
        return val;
    }

    // Format the f64 with 18 significant digits (enough to uniquely identify
    // any f64) and compare digit-by-digit against the literal to determine
    // whether |val| > |literal|.
    let negative = val < 0.0;
    let abs_val = val.abs();
    let formatted = format!("{:.17E}", abs_val); // 18 significant digits

    // Normalize both the formatted f64 and the literal to (exponent, digit_string)
    let val_norm = normalize_sci_str(&formatted);
    let lit_norm = normalize_sci_str(literal.trim().trim_start_matches(|c: char| c == '+' || c == '-'));

    // Compare exponents
    if val_norm.0 > lit_norm.0 {
        // f64 has bigger magnitude — truncate
        return f64::from_bits(val.to_bits() - 1);
    }
    if val_norm.0 < lit_norm.0 {
        return val; // f64 is smaller — already truncated
    }

    // Same exponent — compare digit strings (zero-padded to equal length)
    let max_len = val_norm.1.len().max(lit_norm.1.len());
    let val_digits: String = val_norm.1.chars().chain(std::iter::repeat('0')).take(max_len).collect();
    let lit_digits: String = lit_norm.1.chars().chain(std::iter::repeat('0')).take(max_len).collect();

    if val_digits > lit_digits {
        // f64 overshot — step one ULP toward zero
        // For both positive and negative f64, `bits - 1` moves toward zero
        // (positive: smaller magnitude; negative: sign bit is 1 and the
        // exponent+mantissa encode magnitude, so `bits - 1` also decreases
        // magnitude).
        f64::from_bits(val.to_bits() - 1)
    } else {
        val
    }
}

/// Normalize a decimal string (possibly in scientific notation) into
/// `(leading_exponent, stripped_digit_string)`.
fn normalize_sci_str(s: &str) -> (i32, String) {
    let (mant, exp) = match s.find(|c: char| c == 'E' || c == 'e') {
        Some(i) => {
            let exp_str = s[i + 1..].trim_start_matches('+');
            let exp: i32 = exp_str.parse().unwrap_or(0);
            (&s[..i], exp)
        }
        None => (s, 0i32),
    };
    let (int_part, frac_part) = match mant.find('.') {
        Some(i) => (&mant[..i], &mant[i + 1..]),
        None => (mant, ""),
    };
    let mut digits: String = int_part.chars().chain(frac_part.chars())
        .filter(|c| c.is_ascii_digit()).collect();
    let mut lead_exp = (int_part.chars().filter(|c| c.is_ascii_digit()).count() as i32) - 1 + exp;
    while digits.starts_with('0') && digits.len() > 1 {
        digits.remove(0);
        lead_exp -= 1;
    }
    // Strip trailing zeros — the comparison pads with zeros, so this is safe
    while digits.len() > 1 && digits.ends_with('0') {
        digits.pop();
    }
    if digits.is_empty() || digits == "0" {
        return (0, "0".to_string());
    }
    (lead_exp, digits)
}

/// Add two f64 values with truncation toward zero, matching GnuCOBOL's
/// arithmetic path (mpz exact addition followed by `mpf_get_d()` truncation).
///
/// IEEE 754 `a + b` rounds to nearest, which may produce a result whose
/// magnitude exceeds the exact sum. This function detects that case using
/// compensated summation (2Sum / Dekker's algorithm) and backs off by one
/// ULP when the addition overshot.
pub fn f64_add_trunc(a: f64, b: f64) -> f64 {
    let result = a + b;
    if result == 0.0 || !result.is_finite() {
        return result;
    }
    // Dekker's 2Sum: compute the rounding error so that exact_sum = result + error
    let error = if a.abs() >= b.abs() {
        let tmp = result - a;
        (a - (result - tmp)) + (b - tmp)
    } else {
        let tmp = result - b;
        (b - (result - tmp)) + (a - tmp)
    };
    // If error has opposite sign from result, the IEEE 754 addition overshot
    // (result magnitude > exact sum magnitude). Truncate toward zero by one ULP.
    if (result > 0.0 && error < 0.0) || (result < 0.0 && error > 0.0) {
        f64::from_bits(result.to_bits() - 1)
    } else {
        result
    }
}

/// Subtract two f64 values with truncation toward zero, matching GnuCOBOL's
/// arithmetic path (mpz exact subtraction followed by `mpf_get_d()` truncation).
pub fn f64_sub_trunc(a: f64, b: f64) -> f64 {
    f64_add_trunc(a, -b)
}

/// Format a float value like C's `%.*g` with the given number of significant digits.
fn format_gnucobol_float(val: f64, sig_digits: usize) -> String {
    if val == 0.0 {
        return if val.is_sign_negative() { "-0".to_string() } else { "0".to_string() };
    }
    // Use Rust's scientific notation with (sig_digits - 1) decimal places,
    // then convert to %g-style output.
    let formatted = format!("{:.prec$E}", val, prec = sig_digits - 1);
    // Parse mantissa and exponent from "1.23456780E2" or "1.23456780E-4"
    let (mantissa_str, exp_str) = match formatted.find('E') {
        Some(pos) => (&formatted[..pos], &formatted[pos + 1..]),
        None => return formatted,
    };
    let exp: i32 = exp_str.parse().unwrap_or(0);

    // %g rule: use scientific notation if exp < -4 or exp >= sig_digits
    if exp < -4 || exp >= sig_digits as i32 {
        // Scientific notation: strip trailing zeros from mantissa
        let mantissa_trimmed = mantissa_str.trim_end_matches('0').trim_end_matches('.');
        // GnuCOBOL uses uppercase E with sign: E+02, E-04
        if exp >= 0 {
            format!("{}E+{:02}", mantissa_trimmed, exp)
        } else {
            format!("{}E-{:02}", mantissa_trimmed, -exp)
        }
    } else {
        // Fixed notation: compute the number of decimal places
        let dec_places = ((sig_digits as i32) - exp - 1).max(0) as usize;
        let s = format!("{:.prec$}", val, prec = dec_places);
        // Strip trailing zeros after decimal point (like %g)
        if s.contains('.') {
            let trimmed = s.trim_end_matches('0').trim_end_matches('.');
            trimmed.to_string()
        } else {
            s
        }
    }
}

/// Format a numeric value in COBOL DISPLAY style (zero-padded, optional sign, optional decimal).
/// Used by generated DISPLAY statements for numeric fields and inline FUNCTION results.
/// `int_digits`: number of integer digit positions (zero-padded)
/// `dec_digits`: number of decimal digit positions (0 = no decimal point shown)
/// `show_sign`: if true, prefix with '+' or '-'; if false, no sign character
pub fn cobol_display_numeric(value: f64, int_digits: usize, dec_digits: usize, show_sign: bool, decimal_comma: bool) -> String {
    let sign_char = if show_sign {
        if value < 0.0 { "-" } else { "+" }
    } else {
        ""
    };
    let sep = if decimal_comma { ',' } else { '.' };
    let abs_val = value.abs();
    if dec_digits > 0 {
        // Clamp effective scale to 18 to avoid u64 overflow, zero-pad the rest
        let eff = dec_digits.min(18);
        let factor_f64 = 10f64.powi(eff as i32);
        let scaled = (abs_val * factor_f64).round();
        let int_part = (scaled / factor_f64).trunc() as u64;
        let dec_part = (scaled % factor_f64) as u64;
        if dec_digits <= 18 {
            if int_digits == 0 {
                // P-scaled: no leading zero (e.g., VP9 → ".00")
                format!("{}{}{:0>wd$}", sign_char, sep, dec_part, wd = dec_digits)
            } else {
                format!("{}{:0>wi$}{}{:0>wd$}", sign_char, int_part, sep, dec_part, wi = int_digits, wd = dec_digits)
            }
        } else {
            // For scale > 18, format with 18 effective digits then zero-pad
            format!("{}{:0>wi$}{}{:0>18}{:0>pad$}", sign_char, int_part, sep, dec_part, 0, wi = int_digits, pad = dec_digits - 18)
        }
    } else {
        let int_val = if abs_val <= u64::MAX as f64 { abs_val.round() as u64 } else { 0 };
        format!("{}{:0>w$}", sign_char, int_val, w = int_digits)
    }
}

/// Format a numeric value with embedded sign encoding in the trailing or leading digit.
/// ASCII convention: positive 0-9 → '0'-'9'; negative 0-9 → 'p'-'y' (digit + 0x40)
/// EBCDIC convention: positive 0→'{', 1-9→'A'-'I'; negative 0→'}', 1-9→'J'-'R'
pub fn cobol_display_sign_embedded(value: f64, digits: usize, is_leading: bool, is_ebcdic: bool) -> String {
    let negative = value < 0.0;
    let abs_val = value.abs();
    let int_val = if abs_val <= u64::MAX as f64 { abs_val.round() as u64 } else { 0 };
    let mut s: Vec<u8> = format!("{:0>w$}", int_val, w = digits).into_bytes();
    // Truncate to digits width if value is wider
    if s.len() > digits {
        s = s[s.len() - digits..].to_vec();
    }
    // Encode sign into the leading or trailing digit
    let sign_pos = if is_leading { 0 } else { s.len().saturating_sub(1) };
    if sign_pos < s.len() {
        let d = (s[sign_pos] as char).to_digit(10).unwrap_or(0) as u8;
        s[sign_pos] = if is_ebcdic {
            if negative {
                match d { 0 => b'}', _ => b'J' + d - 1 }
            } else {
                match d { 0 => b'{', _ => b'A' + d - 1 }
            }
        } else {
            // ASCII
            if negative {
                b'p' + d  // 0→'p', 1→'q', ..., 9→'y'
            } else {
                b'0' + d  // unchanged
            }
        };
    }
    String::from_utf8(s).unwrap_or_default()
}

/// De-edit a COBOL edited numeric string back to its raw numeric value.
/// Handles currency symbols ($, etc.), sign indicators (CR, DB, +, -),
/// insertion characters (B, /, spaces), suppression fill (*, Z),
/// and decimal point (. or , depending on `decimal_comma`).
pub fn de_edit_numeric(s: &str, decimal_comma: bool) -> f64 {
    let trimmed = s.trim();
    if trimmed.is_empty() { return 0.0; }

    let mut negative = false;
    let mut work = trimmed;

    // Check for CR/DB at end (credit/debit = negative)
    let upper = trimmed.to_uppercase();
    if upper.ends_with("CR") || upper.ends_with("DB") {
        negative = true;
        work = &trimmed[..trimmed.len() - 2];
    }

    // Build clean numeric string
    let mut result = String::new();
    for c in work.chars() {
        match c {
            '0'..='9' => result.push(c),
            '-' => negative = true,
            '+' => {}
            '.' => {
                if !decimal_comma {
                    result.push('.'); // decimal point
                }
                // else: thousands separator, skip
            }
            ',' => {
                if decimal_comma {
                    result.push('.'); // decimal point → normalize to dot
                }
                // else: thousands separator, skip
            }
            _ => {} // skip: $, *, B, /, spaces, currency symbols, etc.
        }
    }

    if result.is_empty() { return 0.0; }

    let val = result.parse::<f64>().unwrap_or(0.0);
    if negative { -val } else { val }
}

/// Check if every byte of `field` matches the repeating `pattern` (for COBOL `ALL "X"` comparisons).
/// `pattern` is cyclically repeated to match the field length.
pub fn all_chars_eq(field: &[u8], pattern: &[u8]) -> bool {
    if pattern.is_empty() { return field.iter().all(|&b| b == b' '); }
    for (i, &b) in field.iter().enumerate() {
        if b != pattern[i % pattern.len()] { return false; }
    }
    true
}

/// COBOL ALL-literal comparison with ordering support.
/// Returns Ordering::Equal if field matches the cyclic pattern, otherwise compares byte-by-byte.
pub fn all_chars_cmp(field: &[u8], pattern: &[u8]) -> std::cmp::Ordering {
    if pattern.is_empty() {
        return if field.iter().all(|&b| b == b' ') { std::cmp::Ordering::Equal }
               else { field[0].cmp(&b' ') };
    }
    for (i, &b) in field.iter().enumerate() {
        let p = pattern[i % pattern.len()];
        match b.cmp(&p) {
            std::cmp::Ordering::Equal => continue,
            ord => return ord,
        }
    }
    std::cmp::Ordering::Equal
}

// ── XML / JSON GENERATE support ─────────────────────────────────────

/// Metadata for a single field within a group record (used by XML/JSON GENERATE).
pub struct FieldMeta {
    pub name: String,
    pub alias: Option<String>,
    pub offset: usize,
    pub size: usize,
    pub is_numeric: bool,
    pub is_group: bool,
    pub suppress: bool,
}

/// Generate JSON from a group record's bytes and field metadata.
/// GnuCOBOL 3.2 format: no space after colon, no space after comma,
/// alphanumeric values trimmed (min 1 space), numeric as JSON numbers.
pub fn json_generate(fields: &[FieldMeta], data: &[u8], _decimal_comma: bool) -> String {
    let mut json = String::from("{");
    let mut first = true;
    for field in fields {
        let field_data = if field.offset + field.size <= data.len() {
            &data[field.offset..field.offset + field.size]
        } else { &[] };
        if field.suppress {
            let is_all_spaces = field_data.iter().all(|&b| b == b' ');
            let is_all_zeros = !is_all_spaces && field_data.iter().all(|&b| b == b'0' || b == 0);
            if is_all_spaces || is_all_zeros { continue; }
        }
        if !first { json.push(','); }
        first = false;
        let key = field.alias.as_ref().unwrap_or(&field.name);
        json.push('"');
        json.push_str(&_json_esc(key));
        json.push_str("\":");
        if field.is_group || field.size == 0 {
            json.push_str("{}");
        } else if field.is_numeric {
            let s = std::str::from_utf8(field_data).unwrap_or("").trim();
            if s.is_empty() { json.push('0'); }
            else {
                // Numeric: strip leading zeros, output as JSON number
                let trimmed = s.trim_start_matches('0');
                if trimmed.is_empty() || trimmed.starts_with('.') {
                    json.push('0');
                    json.push_str(trimmed);
                } else {
                    json.push_str(trimmed);
                }
            }
        } else {
            // Alphanumeric: trim trailing spaces, minimum 1 space for all-spaces
            let s = std::str::from_utf8(field_data).unwrap_or("");
            let trimmed = s.trim_end();
            let val = if trimmed.is_empty() && !s.is_empty() { " " } else { trimmed };
            json.push('"'); json.push_str(&_json_esc(val)); json.push('"');
        }
    }
    json.push('}');
    json
}

/// Generate XML from a group record's bytes and field metadata.
/// GnuCOBOL format: alphanumeric trimmed, numeric stripped of leading zeros.
pub fn xml_generate(fields: &[FieldMeta], data: &[u8], decimal_comma: bool) -> String {
    let mut xml = String::new();
    for field in fields {
        let field_data = if field.offset + field.size <= data.len() {
            &data[field.offset..field.offset + field.size]
        } else { &[] };
        if field.suppress {
            let is_all_spaces = field_data.iter().all(|&b| b == b' ');
            let is_all_zeros = !is_all_spaces && field_data.iter().all(|&b| b == b'0' || b == 0);
            if is_all_spaces || is_all_zeros { continue; }
        }
        let tag = field.alias.as_ref().unwrap_or(&field.name);
        if field.is_numeric {
            let raw = std::str::from_utf8(field_data).unwrap_or("").trim();
            // Strip leading zeros but keep at least one digit before decimal
            let value = if raw.is_empty() { "0".to_string() }
            else {
                let neg = raw.starts_with('-');
                let abs = if neg { &raw[1..] } else { raw };
                let trimmed = abs.trim_start_matches('0');
                let s = if trimmed.is_empty() || trimmed.starts_with('.') {
                    format!("0{}", trimmed)
                } else { trimmed.to_string() };
                // Handle decimal comma: convert comma to period for XML output if DPC-IN-DATA
                let s = if decimal_comma { s.replace(',', ".") } else { s };
                if neg { format!("-{}", s) } else { s }
            };
            xml.push('<'); xml.push_str(tag); xml.push('>');
            xml.push_str(&_xml_esc(&value));
            xml.push_str("</"); xml.push_str(tag); xml.push('>');
        } else {
            // Alphanumeric: trim trailing spaces
            let value = std::str::from_utf8(field_data).unwrap_or("").trim_end();
            xml.push('<'); xml.push_str(tag); xml.push('>');
            xml.push_str(&_xml_esc(value));
            xml.push_str("</"); xml.push_str(tag); xml.push('>');
        }
    }
    xml
}

fn _json_esc(s: &str) -> String {
    let mut r = String::with_capacity(s.len());
    for c in s.chars() {
        match c {
            '"' => r.push_str("\\\""), '\\' => r.push_str("\\\\"),
            '\n' => r.push_str("\\n"), '\r' => r.push_str("\\r"),
            '\t' => r.push_str("\\t"),
            c if c.is_control() => r.push_str(&format!("\\u{:04x}", c as u32)),
            _ => r.push(c),
        }
    }
    r
}

fn _xml_esc(s: &str) -> String {
    let mut r = String::with_capacity(s.len());
    for c in s.chars() {
        match c {
            '<' => r.push_str("&lt;"), '>' => r.push_str("&gt;"),
            '&' => r.push_str("&amp;"), '"' => r.push_str("&quot;"),
            '\'' => r.push_str("&apos;"), _ => r.push(c),
        }
    }
    r
}

/// Public XML text content escaping (for v2 XML GENERATE).
pub fn xml_escape(s: &str) -> String { _xml_esc(s) }

/// Public XML attribute value escaping (for v2 XML GENERATE).
pub fn xml_escape_attr(s: &str) -> String { _xml_esc(s) }

// ── FUNCTION ANNUITY ──────────────────────────────────────────────
// High-precision ANNUITY(rate, periods) using rust_decimal.
// Returns rate / (1 - (1 + rate)^(-periods)) when rate != 0, else 1/periods.
// Output is a decimal string with up to 36 significant digits.
pub fn cobol_annuity(rate: f64, periods: f64) -> String {
    use rust_decimal::prelude::*;
    if rate == 0.0 {
        if periods == 0.0 { return "0".to_string(); }
        let one = RustDecimal::from(1);
        let n = RustDecimal::from_f64(periods).unwrap_or(RustDecimal::from(1));
        return (one / n).to_string();
    }
    // For integer rate and periods where the formula is a rational number,
    // compute exactly: r / (1 - (1+r)^(-n))
    // Use rust_decimal for higher precision (~28 digits)
    let r_dec = RustDecimal::from_f64(rate).unwrap_or(RustDecimal::ZERO);
    let n_i = periods as i64;
    let one = RustDecimal::from(1);
    let base = one + r_dec;
    // Compute base^n using repeated multiplication for integer n
    if n_i > 0 && n_i <= 100 && periods == n_i as f64 {
        let mut base_pow_n = one;
        for _ in 0..n_i {
            base_pow_n *= base;
        }
        // annuity = r * base^n / (base^n - 1)
        let numer = r_dec * base_pow_n;
        let denom = base_pow_n - one;
        if denom.is_zero() { return "0".to_string(); }
        let result = numer / denom;
        return result.to_string();
    }
    // Fallback to f64 for non-integer periods
    let result = rate / (1.0 - (1.0 + rate).powf(-periods));
    result.to_string()
}

// ── FUNCTION TEST-NUMVAL ───────────────────────────────────────────
// Returns 0 if the string is valid for NUMVAL, otherwise the 1-based
// position of the first character that violates the format.
// Format: [spaces] [sign] [spaces] [digits[.digits]] [spaces] [sign|CR|DB] [spaces]
// CR/DB are case-insensitive and indicate negative (credit/debit).
pub fn test_numval(s: &str) -> i32 {
    let bytes = s.as_bytes();
    let len = bytes.len();
    if len == 0 { return 1; }

    let mut i = 0;

    // Skip leading spaces
    while i < len && bytes[i] == b' ' { i += 1; }
    
    // All spaces is invalid
    if i >= len { return (len + 1) as i32; }

    // Optional leading sign (+/-)
    let mut has_leading_sign = false;
    if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
        has_leading_sign = true;
        i += 1;
        // Check for double sign (e.g., "+- 1") — invalid at second sign position
        if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
            return (i + 1) as i32;
        }
    }

    // Skip spaces after sign
    while i < len && bytes[i] == b' ' { i += 1; }
    
    // Must have at least one digit OR a decimal point followed by digit
    let mut has_digits = false;
    let mut has_decimal = false;
    let digit_start = i;
    
    while i < len {
        if bytes[i] >= b'0' && bytes[i] <= b'9' {
            has_digits = true;
            i += 1;
        } else if bytes[i] == b'.' && !has_decimal {
            has_decimal = true;
            i += 1;
            // Check for space after decimal point — only invalid if no digits before decimal
            // "0.   " is valid (digits before decimal, trailing spaces)
            // ".  0" is invalid (space between decimal and digit)
            if !has_digits && i < len && bytes[i] == b' ' {
                return (i + 1) as i32;
            }
        } else {
            break;
        }
    }

    // Must have at least one digit
    if !has_digits {
        return if i < len { (i + 1) as i32 } else { (len + 1) as i32 };
    }
    
    // Decimal point at end with no following digits AND no preceding digits is invalid
    // But "0." is valid, ".0" is valid
    if has_decimal && i == digit_start + 1 && !has_digits {
        return (digit_start + 1) as i32;
    }

    // Skip spaces before trailing sign/CR/DB
    let space_start = i;
    while i < len && bytes[i] == b' ' { i += 1; }

    // Optional trailing sign or CR/DB
    if i < len {
        if bytes[i] == b'+' || bytes[i] == b'-' {
            if has_leading_sign {
                return (i + 1) as i32; // can't have both leading and trailing sign
            }
            i += 1;
            // Check for more sign chars after trailing sign (invalid: "1 +-")
            if i < len && (bytes[i] == b'+' || bytes[i] == b'-' || bytes[i].to_ascii_uppercase() == b'C' || bytes[i].to_ascii_uppercase() == b'D') {
                return (i + 1) as i32;
            }
        } else {
            let b0 = bytes[i].to_ascii_uppercase();
            if b0 == b'C' || b0 == b'D' {
                // Potential CR/DB — need a second character
                if i + 1 < len {
                    let b1 = bytes[i + 1].to_ascii_uppercase();
                    if (b0 == b'C' && b1 == b'R') || (b0 == b'D' && b1 == b'B') {
                        if has_leading_sign {
                            return (i + 1) as i32;
                        }
                        i += 2;
                    } else {
                        // e.g. "CDB" — C is ok but D doesn't match R, error at the mismatch char
                        return (i + 2) as i32;
                    }
                } else {
                    // Lone C or D at end — incomplete CR/DB, error past end
                    return (len + 1) as i32;
                }
            } else if bytes[i] != b' ' {
                // Invalid character (not digit, space, sign, or CR/DB)
                return (i + 1) as i32;
            }
        }
    }

    // Skip trailing spaces
    while i < len && bytes[i] == b' ' { i += 1; }

    if i < len { (i + 1) as i32 } else { 0 }
}

// ── FUNCTION TEST-NUMVAL-C ──────────────────────────────────────────
// Returns 0 if the string is valid for NUMVAL-C, otherwise the 1-based
// position of the first character that violates the format.
// Format: [spaces] [sign] [spaces] [cs] [digits[sep digits]] [spaces] [sign|CR|DB] [spaces]
// `currency` is the currency symbol to accept (default "$").
// `decimal_comma`: if true, comma is decimal point and period is thousands sep.
pub fn test_numval_c(s: &str, currency: &str, decimal_comma: bool) -> i32 {
    let bytes = s.as_bytes();
    let len = bytes.len();
    if len == 0 { return 1; }

    let dec_sep: u8 = if decimal_comma { b',' } else { b'.' };
    let thou_sep: u8 = if decimal_comma { b'.' } else { b',' };
    let cs_bytes = currency.as_bytes();

    let mut i = 0;

    // Skip leading spaces
    while i < len && bytes[i] == b' ' { i += 1; }
    if i >= len { return 1; } // all spaces

    // Optional leading sign (+/-)
    let mut has_leading_sign = false;
    if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
        has_leading_sign = true;
        i += 1;
        // Check for double sign (e.g., "+- 1") — invalid at second sign position
        if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
            return (i + 1) as i32;
        }
    }

    // Skip spaces after sign
    while i < len && bytes[i] == b' ' { i += 1; }

    // Optional currency symbol
    if !cs_bytes.is_empty() && i + cs_bytes.len() <= len && &bytes[i..i + cs_bytes.len()] == cs_bytes {
        i += cs_bytes.len();
    }

    // Skip spaces after currency
    while i < len && bytes[i] == b' ' { i += 1; }

    // Digits (with optional thousands separators and one decimal point)
    let mut has_digits = false;
    let mut has_decimal = false;
    while i < len {
        if bytes[i] >= b'0' && bytes[i] <= b'9' {
            has_digits = true;
            i += 1;
        } else if bytes[i] == dec_sep && !has_decimal {
            has_decimal = true;
            i += 1;
        } else if bytes[i] == thou_sep {
            i += 1; // skip thousands separator
        } else {
            break;
        }
    }

    if !has_digits { return if i < len { (i + 1) as i32 } else { len as i32 }; }

    // Skip spaces before trailing sign/CR/DB
    while i < len && bytes[i] == b' ' { i += 1; }

    // Optional trailing sign or CR/DB
    if i < len {
        if bytes[i] == b'+' || bytes[i] == b'-' {
            if has_leading_sign {
                return (i + 1) as i32; // can't have both leading and trailing sign
            }
            i += 1;
            // Check for more sign chars after trailing sign
            if i < len && (bytes[i] == b'+' || bytes[i] == b'-' || bytes[i] == b'C' || bytes[i] == b'D') {
                return (i + 1) as i32;
            }
        } else if i + 2 <= len {
            // Check for CR/DB (case-insensitive)
            let b0 = bytes[i].to_ascii_uppercase();
            let b1 = bytes[i + 1].to_ascii_uppercase();
            if (b0 == b'C' && b1 == b'R') || (b0 == b'D' && b1 == b'B') {
                if has_leading_sign {
                    return (i + 1) as i32;
                }
                i += 2;
            } else if bytes[i] != b' ' {
                return (i + 1) as i32;
            }
        } else if bytes[i] != b' ' {
            return (i + 1) as i32;
        }
    }

    // Skip trailing spaces
    while i < len && bytes[i] == b' ' { i += 1; }

    if i < len { (i + 1) as i32 } else { 0 }
}

// ── FUNCTION TEST-NUMVAL-F ──────────────────────────────────────────
// Returns 0 if the string is valid for NUMVAL-F (floating-point format),
// otherwise the 1-based position of the first violating character.
// Format: [spaces] [sign] [spaces] digits[.digits] [spaces] [sign] [E [spaces] [sign] digit [spaces]]
pub fn test_numval_f(s: &str) -> i32 {
    let bytes = s.as_bytes();
    let len = bytes.len();
    if len == 0 { return 1; }

    let mut i = 0;

    // Skip leading spaces
    while i < len && bytes[i] == b' ' { i += 1; }
    if i >= len { return 1; }

    // Optional leading sign
    let mut has_leading_sign = false;
    if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
        has_leading_sign = true;
        i += 1;
        if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
            return (i + 1) as i32;
        }
    }

    // Skip spaces after sign
    while i < len && bytes[i] == b' ' { i += 1; }

    // Digits with optional decimal point
    let mut has_digits = false;
    let mut has_decimal = false;
    while i < len {
        if bytes[i] >= b'0' && bytes[i] <= b'9' {
            has_digits = true;
            i += 1;
        } else if bytes[i] == b'.' && !has_decimal {
            has_decimal = true;
            i += 1;
        } else {
            break;
        }
    }

    if !has_digits { return if i < len { (i + 1) as i32 } else { len as i32 }; }

    // Skip spaces after mantissa
    while i < len && bytes[i] == b' ' { i += 1; }

    // Optional trailing sign (only if no leading sign)
    if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
        if has_leading_sign {
            // Already had leading sign -- this is a second sign
            // But for NUMVAL-F, trailing sign after number is allowed if no leading sign
            return (i + 1) as i32;
        }
        i += 1;
        // After trailing sign, only spaces or E allowed
        while i < len && bytes[i] == b' ' { i += 1; }
    }

    // Check for invalid chars like CR/DB
    if i < len && bytes[i] != b'E' && bytes[i] != b' ' {
        return (i + 1) as i32;
    }

    // Optional exponent: E [spaces] [sign] digit(s)
    if i < len && bytes[i] == b'E' {
        i += 1;
        // Check for second E
        if i < len && bytes[i] == b'E' {
            return (i + 1) as i32;
        }
        // Skip spaces
        while i < len && bytes[i] == b' ' { i += 1; }
        // Optional sign
        if i < len && (bytes[i] == b'+' || bytes[i] == b'-') {
            i += 1;
        }
        // Skip spaces after sign
        while i < len && bytes[i] == b' ' { i += 1; }
        // Must have exactly 1 or 2 exponent digits
        let exp_start = i;
        while i < len && bytes[i] >= b'0' && bytes[i] <= b'9' {
            i += 1;
        }
        let exp_digits = i - exp_start;
        if exp_digits == 0 {
            return if i < len { (i + 1) as i32 } else { len as i32 };
        }
        if exp_digits > 2 {
            // More than 2 digits: error at the first exponent digit position (1-based)
            return (exp_start + 1) as i32;
        }
    }

    // Skip trailing spaces
    while i < len && bytes[i] == b' ' { i += 1; }

    if i < len { (i + 1) as i32 } else { 0 }
}

// ── FUNCTION NUMVAL ────────────────────────────────────────────────
// Parse a COBOL numeric string to f64 per GnuCOBOL 3.2+ rules.
// For invalid data, stops at first invalid character and parses what's valid.
pub fn numval(s: &str) -> f64 {
    // GnuCOBOL 3.2+ lenient NUMVAL: for invalid data, extract "whatever is valid"
    // by stripping non-numeric chars. Return 0 when parsing fails entirely.
    let trimmed = s.trim();
    if trimmed.is_empty() { return 0.0; }

    let upper = trimmed.to_uppercase();
    let mut negative = false;

    // 1) Check for CR/DB at end (case-insensitive) → negative, use text before it
    let work = if let Some(p) = upper.rfind("CR").or_else(|| upper.rfind("DB")) {
        negative = true;
        &trimmed[..p]
    } else {
        trimmed
    };

    // 2) Strip spaces and commas
    let work: String = work.chars().filter(|c| *c != ' ' && *c != ',').collect();

    // 3) Detect signs: leading sign takes priority over trailing
    let has_leading_sign = work.starts_with('+') || work.starts_with('-');
    let has_trailing_sign = work.ends_with('+') || work.ends_with('-');

    if has_leading_sign {
        if work.starts_with('-') { negative = true; }
        // Leading sign found — ignore any trailing sign
    } else if has_trailing_sign {
        if work.ends_with('-') { negative = true; }
    }

    // 4) Strip sign characters from both ends
    let work = work.trim_start_matches('+').trim_start_matches('-')
                   .trim_end_matches('+').trim_end_matches('-');

    // 5) Filter to digits and decimal point only
    let work: String = work.chars().filter(|c| c.is_ascii_digit() || *c == '.').collect();

    // 6) Parse — if multiple decimal points or other issues, returns 0
    let val = work.parse::<f64>().unwrap_or(0.0);
    if negative { -val } else { val }
}

// ── FUNCTION NUMVAL-C ───────────────────────────────────────────────
// Parse a COBOL numeric string with currency symbols, CR/DB, etc.
// `currency` is the currency symbol (default "$"), `decimal_comma` swaps . and , roles.
pub fn numval_c(s: &str, currency: &str, decimal_comma: bool) -> f64 {
    let dec_char = if decimal_comma { ',' } else { '.' };
    let thou_char = if decimal_comma { '.' } else { ',' };

    let trimmed = s.trim();
    if trimmed.is_empty() { return 0.0; }

    let mut negative = false;
    let mut work = trimmed.to_string();

    // Check for CR/DB at end
    {
        let upper = work.to_uppercase();
        if upper.ends_with("CR") || upper.ends_with("DB") {
            negative = true;
            work = work[..work.len() - 2].to_string();
        }
    }

    // Remove currency symbol
    work = work.replace(currency, "");

    // Remove spaces
    work = work.replace(' ', "");

    // Remove thousands separators
    work = work.replace(thou_char, "");

    // Check for sign
    if work.starts_with('-') {
        negative = true;
        work = work[1..].to_string();
    } else if work.starts_with('+') {
        work = work[1..].to_string();
    }
    if work.ends_with('-') {
        negative = true;
        work = work[..work.len() - 1].to_string();
    } else if work.ends_with('+') {
        work = work[..work.len() - 1].to_string();
    }

    // Replace decimal separator with '.' for Rust parsing
    work = work.replace(dec_char, ".");

    let val = work.parse::<f64>().unwrap_or(0.0);
    if negative { -val } else { val }
}

// ── FUNCTION TEST-DATE-YYYYMMDD ─────────────────────────────────────
// Returns 0 if date is valid. Otherwise returns error code:
// 1 = year invalid, 2 = month invalid, 3 = day invalid.
pub fn test_date_yyyymmdd(yyyymmdd: i64) -> i32 {
    if yyyymmdd == 0 { return 1; }
    let y = yyyymmdd / 10000;
    let m = (yyyymmdd % 10000) / 100;
    let d = yyyymmdd % 100;
    if y < 1601 || y > 9999 { return 1; }
    if m < 1 || m > 12 { return 2; }
    let is_leap = (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
    let max_day = match m {
        1 | 3 | 5 | 7 | 8 | 10 | 12 => 31,
        4 | 6 | 9 | 11 => 30,
        2 => if is_leap { 29 } else { 28 },
        _ => return 2,
    };
    if d < 1 || d > max_day { return 3; }
    0
}

// ── FUNCTION TEST-DAY-YYYYDDD ───────────────────────────────────────
// Returns 0 if Julian date is valid. Otherwise returns error code:
// 1 = year invalid, 2 = day-of-year invalid.
pub fn test_day_yyyyddd(yyyyddd: i64) -> i32 {
    if yyyyddd == 0 { return 1; }
    let y = yyyyddd / 1000;
    let doy = yyyyddd % 1000;
    if y < 1601 || y > 9999 { return 1; }
    if doy < 1 { return 2; }
    let is_leap = (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0);
    let max_doy = if is_leap { 366 } else { 365 };
    if doy > max_doy { return 2; }
    0
}
