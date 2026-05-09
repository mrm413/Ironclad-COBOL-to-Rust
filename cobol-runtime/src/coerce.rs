// Adaptive Type Coercion Engine — Sprint 1 Foundation (Audited)
// Torsova LLC — Ironclad Runtime
//
// Compile-time dispatched coercion between all runtime types.
// The transpiler emits `coerce!(target, source)` — the trait system handles resolution.

use crate::{Decimal, FixedString, PackedDecimal};

// ─── Safe exponentiation helpers (C1 fix) ────────────────────────────

/// Maximum safe scale for i128 (10^38 fits, 10^39 overflows)
const MAX_I128_SCALE: u8 = 38;
/// Maximum safe scale for i64 (10^18 fits, 10^19 overflows)
const MAX_I64_SCALE: u8 = 18;

fn safe_pow_i128(scale: u8) -> i128 {
    10i128.pow(scale.min(MAX_I128_SCALE) as u32)
}

fn safe_pow_i64(scale: u8) -> i64 {
    10i64.pow(scale.min(MAX_I64_SCALE) as u32)
}

/// Infer scale from a numeric string, defaulting to 0 if no decimal point (H2 fix)
fn infer_decimal_scale(s: &str) -> (i128, u8) {
    let trimmed = s.trim();
    if let Some(dot_pos) = trimmed.find('.') {
        let scale = (trimmed.len() - dot_pos - 1) as u8;
        let factor = safe_pow_i128(scale);
        if let Ok(f) = trimmed.parse::<f64>() {
            ((f * factor as f64).round() as i128, scale)
        } else {
            (0, 0)
        }
    } else if let Ok(v) = trimmed.parse::<i128>() {
        (v, 0)
    } else {
        (0, 0)
    }
}

// ─── Universal Intermediate ──────────────────────────────────────────

/// Figurative constant identifiers (SPACES, ZEROS, etc.)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum FigurativeConstant {
    Spaces,
    Zeros,
    LowValues,
    HighValues,
    Quotes,
}

/// Universal intermediate type for two-hop coercion paths.
/// Source → DynamicValue → Target when no direct Coerce impl exists.
#[derive(Debug, Clone)]
pub enum DynamicValue {
    Integer(i128),
    Decimal(i128, u8),
    Text(String),
    Boolean(bool),
    Bytes(Vec<u8>),
    Figurative(FigurativeConstant),
}

// ─── From<T> for DynamicValue ────────────────────────────────────────

macro_rules! impl_dv_from_int {
    ($($t:ty),*) => {
        $(
            impl From<$t> for DynamicValue {
                fn from(v: $t) -> Self { DynamicValue::Integer(v as i128) }
            }
        )*
    }
}
impl_dv_from_int!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

impl From<f32> for DynamicValue {
    fn from(v: f32) -> Self {
        let scaled = (v as f64 * 1_000_000.0).round() as i128;
        DynamicValue::Decimal(scaled, 6)
    }
}

impl From<f64> for DynamicValue {
    fn from(v: f64) -> Self {
        let scaled = (v * 1_000_000.0).round() as i128;
        DynamicValue::Decimal(scaled, 6)
    }
}

impl From<String> for DynamicValue {
    fn from(v: String) -> Self { DynamicValue::Text(v) }
}

impl From<&str> for DynamicValue {
    fn from(v: &str) -> Self { DynamicValue::Text(v.to_string()) }
}

impl From<bool> for DynamicValue {
    fn from(v: bool) -> Self { DynamicValue::Boolean(v) }
}

impl From<Vec<u8>> for DynamicValue {
    fn from(v: Vec<u8>) -> Self { DynamicValue::Bytes(v) }
}

impl From<FigurativeConstant> for DynamicValue {
    fn from(v: FigurativeConstant) -> Self { DynamicValue::Figurative(v) }
}

// From existing runtime types
impl<const N: usize> From<FixedString<N>> for DynamicValue {
    fn from(v: FixedString<N>) -> Self { DynamicValue::Text(v.as_str().to_string()) }
}

impl From<Decimal> for DynamicValue {
    fn from(v: Decimal) -> Self { DynamicValue::Decimal(v.value as i128, v.scale) }
}

impl<const N: usize> From<PackedDecimal<N>> for DynamicValue {
    fn from(v: PackedDecimal<N>) -> Self { DynamicValue::Integer(v.value() as i128) }
}

// ─── DynamicValue extraction helpers ─────────────────────────────────

impl DynamicValue {
    pub fn to_i128(&self) -> i128 {
        match self {
            DynamicValue::Integer(v) => *v,
            DynamicValue::Decimal(v, s) => v / safe_pow_i128(*s),
            DynamicValue::Text(s) => s.trim().parse().unwrap_or(0),
            DynamicValue::Boolean(b) => if *b { 1 } else { 0 },
            DynamicValue::Bytes(b) => {
                // Parse as UTF-8 numeric string, fall back to 0 (M3 fix)
                String::from_utf8_lossy(b).trim().parse().unwrap_or(0)
            }
            DynamicValue::Figurative(_) => 0,
        }
    }

    pub fn to_string_value(&self) -> String {
        match self {
            DynamicValue::Integer(v) => v.to_string(),
            DynamicValue::Decimal(v, s) => {
                if *s == 0 { return v.to_string(); }
                let factor = safe_pow_i128(*s);
                let int_part = v / factor;
                let frac_part = (v % factor).unsigned_abs();
                format!("{}.{:0>w$}", int_part, frac_part, w = *s as usize)
            }
            DynamicValue::Text(s) => s.clone(),
            DynamicValue::Boolean(b) => if *b { "1".into() } else { "0".into() },
            DynamicValue::Bytes(b) => String::from_utf8_lossy(b).to_string(),
            DynamicValue::Figurative(f) => match f {
                FigurativeConstant::Spaces => " ".into(),
                FigurativeConstant::Zeros => "0".into(),
                FigurativeConstant::LowValues => "\x00".into(),
                FigurativeConstant::HighValues => "\u{FF}".into(),
                FigurativeConstant::Quotes => "\"".into(),
            },
        }
    }

    pub fn to_f64(&self) -> f64 {
        match self {
            DynamicValue::Integer(v) => *v as f64,
            DynamicValue::Decimal(v, s) => *v as f64 / 10f64.powi((*s).min(MAX_I128_SCALE) as i32),
            DynamicValue::Text(s) => s.trim().parse().unwrap_or(0.0),
            DynamicValue::Boolean(b) => if *b { 1.0 } else { 0.0 },
            DynamicValue::Bytes(b) => {
                // Parse as UTF-8 numeric string, fall back to 0.0 (M3 fix)
                String::from_utf8_lossy(b).trim().parse().unwrap_or(0.0)
            }
            DynamicValue::Figurative(_) => 0.0,
        }
    }

    pub fn to_bool(&self) -> bool {
        match self {
            DynamicValue::Integer(v) => *v != 0,
            DynamicValue::Decimal(v, _) => *v != 0,
            DynamicValue::Text(s) => !s.trim().is_empty() && s.trim() != "0",
            DynamicValue::Boolean(b) => *b,
            DynamicValue::Bytes(b) => b.iter().any(|&x| x != 0),
            DynamicValue::Figurative(f) => !matches!(f, FigurativeConstant::Zeros | FigurativeConstant::LowValues),
        }
    }

    pub fn to_bytes_value(&self) -> Vec<u8> {
        match self {
            DynamicValue::Integer(v) => v.to_le_bytes().to_vec(),
            DynamicValue::Decimal(v, _) => v.to_le_bytes().to_vec(),
            DynamicValue::Text(s) => s.as_bytes().to_vec(),
            DynamicValue::Boolean(b) => vec![if *b { 1 } else { 0 }],
            DynamicValue::Bytes(b) => b.clone(),
            DynamicValue::Figurative(f) => match f {
                FigurativeConstant::Spaces => vec![b' '],
                FigurativeConstant::Zeros => vec![b'0'],
                FigurativeConstant::LowValues => vec![0x00],
                FigurativeConstant::HighValues => vec![0xFF],
                FigurativeConstant::Quotes => vec![b'"'],
            },
        }
    }
}

// ─── Coerce Trait ────────────────────────────────────────────────────

/// Core coercion trait. Implement for every (Source, Target) type pair.
/// The compiler monomorphizes these — zero runtime cost.
pub trait Coerce<Target> {
    fn coerce(&self) -> Target;
}

/// Mirror trait: Target::coerce_from(source)
pub trait CoerceFrom<Source> {
    fn coerce_from(source: &Source) -> Self;
}

/// Blanket: if T: Coerce<U>, then U: CoerceFrom<T>
impl<T, U> CoerceFrom<T> for U
where
    T: Coerce<U>,
{
    fn coerce_from(source: &T) -> Self {
        source.coerce()
    }
}

// ─── coerce! macro ───────────────────────────────────────────────────

/// Universal assignment macro. The transpiler emits ONLY this for assignments.
///
/// Variants:
/// - `coerce!(target, source)` — standard MOVE semantics
/// - `coerce!(target, source, truncate)` — explicit truncation (MOVE with size mismatch).
///   Truncation is inherent in the Coerce impls (integer `as` wraps, FixedString clips at N).
/// - `coerce!(target, source, checked)` — debug-mode validation (COMPUTE results).
///   Currently identical to standard; Sprint 3 will add debug_assert round-trip checking.
#[macro_export]
macro_rules! coerce {
    ($target:expr, $source:expr) => {{
        $target = $crate::coerce::Coerce::coerce(&$source);
    }};
    ($target:expr, $source:expr, truncate) => {{
        $target = $crate::coerce::Coerce::coerce(&$source);
    }};
    ($target:expr, $source:expr, checked) => {{
        let coerced = $crate::coerce::Coerce::coerce(&$source);
        $target = coerced;
    }};
}

// ─── DynamicValue ↔ DynamicValue (identity) ──────────────────────────

impl Coerce<DynamicValue> for DynamicValue {
    fn coerce(&self) -> DynamicValue { self.clone() }
}

// ─── DynamicValue → concrete types ───────────────────────────────────

impl Coerce<i32> for DynamicValue {
    fn coerce(&self) -> i32 { self.to_i128() as i32 }
}
impl Coerce<i64> for DynamicValue {
    fn coerce(&self) -> i64 { self.to_i128() as i64 }
}
impl Coerce<i128> for DynamicValue {
    fn coerce(&self) -> i128 { self.to_i128() }
}
impl Coerce<u32> for DynamicValue {
    fn coerce(&self) -> u32 { self.to_i128() as u32 }
}
impl Coerce<u64> for DynamicValue {
    fn coerce(&self) -> u64 { self.to_i128() as u64 }
}
impl Coerce<f32> for DynamicValue {
    fn coerce(&self) -> f32 { self.to_f64() as f32 }
}
impl Coerce<f64> for DynamicValue {
    fn coerce(&self) -> f64 { self.to_f64() }
}
impl Coerce<bool> for DynamicValue {
    fn coerce(&self) -> bool { self.to_bool() }
}
impl Coerce<String> for DynamicValue {
    fn coerce(&self) -> String { self.to_string_value() }
}
impl Coerce<Vec<u8>> for DynamicValue {
    fn coerce(&self) -> Vec<u8> { self.to_bytes_value() }
}

// ─── Concrete → DynamicValue ─────────────────────────────────────────

macro_rules! impl_coerce_to_dv {
    ($($t:ty),*) => {
        $(
            impl Coerce<DynamicValue> for $t {
                fn coerce(&self) -> DynamicValue { DynamicValue::from(*self) }
            }
        )*
    }
}
impl_coerce_to_dv!(i8, i16, i32, i64, i128, u8, u16, u32, u64, f32, f64, bool);

impl Coerce<DynamicValue> for String {
    fn coerce(&self) -> DynamicValue { DynamicValue::Text(self.clone()) }
}
impl Coerce<DynamicValue> for &str {
    fn coerce(&self) -> DynamicValue { DynamicValue::Text(self.to_string()) }
}
impl Coerce<DynamicValue> for Vec<u8> {
    fn coerce(&self) -> DynamicValue { DynamicValue::Bytes(self.clone()) }
}

// ─── Integer ↔ Integer coercions ─────────────────────────────────────

macro_rules! impl_int_coerce {
    ($src:ty => $($dst:ty),*) => {
        $(
            impl Coerce<$dst> for $src {
                fn coerce(&self) -> $dst { *self as $dst }
            }
        )*
    }
}

impl_int_coerce!(i8 => i16, i32, i64, i128, u8, u16, u32, u64, f32, f64);
impl_int_coerce!(i16 => i8, i32, i64, i128, u8, u16, u32, u64, f32, f64);
impl_int_coerce!(i32 => i8, i16, i64, i128, u8, u16, u32, u64, f32, f64);
impl_int_coerce!(i64 => i8, i16, i32, i128, u8, u16, u32, u64, f32, f64);
impl_int_coerce!(i128 => i8, i16, i32, i64, u8, u16, u32, u64, f32, f64);
impl_int_coerce!(u8 => i8, i16, i32, i64, i128, u16, u32, u64, f32, f64);
impl_int_coerce!(u16 => i8, i16, i32, i64, i128, u8, u32, u64, f32, f64);
impl_int_coerce!(u32 => i8, i16, i32, i64, i128, u8, u16, u64, f32, f64);
impl_int_coerce!(u64 => i8, i16, i32, i64, i128, u8, u16, u32, f32, f64);
impl_int_coerce!(f32 => i8, i16, i32, i64, i128, u8, u16, u32, u64);
impl_int_coerce!(f64 => i8, i16, i32, i64, i128, u8, u16, u32, u64, f32);

/// FLOAT-SHORT → FLOAT-LONG: round through decimal representation to match
/// GnuCOBOL's BCD-mediated MOVE semantics. Direct `f32 as f64` preserves binary
/// noise (e.g., 11.55f32 → 11.55000019073486f64) which breaks literal comparisons.
impl Coerce<f64> for f32 {
    fn coerce(&self) -> f64 {
        // 8 significant digits (%.7e) — enough for f32 fidelity, strips binary noise
        let s = format!("{:.7e}", *self);
        s.parse::<f64>().unwrap_or(*self as f64)
    }
}

// Identity coercions
macro_rules! impl_identity_coerce {
    ($($t:ty),*) => {
        $(
            impl Coerce<$t> for $t {
                fn coerce(&self) -> $t { *self }
            }
        )*
    }
}
impl_identity_coerce!(i8, i16, i32, i64, i128, u8, u16, u32, u64, f32, f64, bool);

impl Coerce<String> for String {
    fn coerce(&self) -> String { self.clone() }
}

// ─── Integer ↔ String coercions ──────────────────────────────────────

macro_rules! impl_int_to_string {
    ($($t:ty),*) => {
        $(
            impl Coerce<String> for $t {
                fn coerce(&self) -> String { self.to_string() }
            }
            impl Coerce<$t> for String {
                fn coerce(&self) -> $t { self.trim().parse().unwrap_or(0 as $t) }
            }
            impl Coerce<$t> for &str {
                fn coerce(&self) -> $t { self.trim().parse().unwrap_or(0 as $t) }
            }
        )*
    }
}
impl_int_to_string!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

impl Coerce<String> for f32 {
    fn coerce(&self) -> String { format!("{}", self) }
}
impl Coerce<String> for f64 {
    fn coerce(&self) -> String { format!("{}", self) }
}
impl Coerce<f32> for String {
    fn coerce(&self) -> f32 { self.trim().parse().unwrap_or(0.0) }
}
impl Coerce<f64> for String {
    fn coerce(&self) -> f64 { self.trim().parse().unwrap_or(0.0) }
}
impl Coerce<f32> for &str {
    fn coerce(&self) -> f32 { self.trim().parse().unwrap_or(0.0) }
}
impl Coerce<f64> for &str {
    fn coerce(&self) -> f64 { self.trim().parse().unwrap_or(0.0) }
}
impl Coerce<String> for &str {
    fn coerce(&self) -> String { self.to_string() }
}

// ─── Integer ↔ bool coercions ────────────────────────────────────────

macro_rules! impl_int_bool {
    ($($t:ty),*) => {
        $(
            impl Coerce<bool> for $t {
                fn coerce(&self) -> bool { *self != 0 as $t }
            }
            impl Coerce<$t> for bool {
                fn coerce(&self) -> $t { if *self { 1 as $t } else { 0 as $t } }
            }
        )*
    }
}
impl_int_bool!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

impl Coerce<bool> for f32 {
    fn coerce(&self) -> bool { *self != 0.0 }
}
impl Coerce<bool> for f64 {
    fn coerce(&self) -> bool { *self != 0.0 }
}
// M1 fix: bool → f32/f64
impl Coerce<f32> for bool {
    fn coerce(&self) -> f32 { if *self { 1.0 } else { 0.0 } }
}
impl Coerce<f64> for bool {
    fn coerce(&self) -> f64 { if *self { 1.0 } else { 0.0 } }
}
impl Coerce<bool> for String {
    fn coerce(&self) -> bool { !self.trim().is_empty() && self.trim() != "0" }
}
impl Coerce<bool> for &str {
    fn coerce(&self) -> bool { !self.trim().is_empty() && self.trim() != "0" }
}
impl Coerce<String> for bool {
    fn coerce(&self) -> String { if *self { "1".into() } else { "0".into() } }
}

// ─── FixedString<N> coercions ────────────────────────────────────────

// FixedString<N> → FixedString<M> (cross-size: truncates or pads as needed)
// Covers both identity (N==M) and cross-size (N!=M) cases.
impl<const N: usize, const M: usize> Coerce<FixedString<M>> for FixedString<N> {
    fn coerce(&self) -> FixedString<M> { FixedString::from_str(self.as_str()) }
}

// &str → FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for &str {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(self) }
}

// String → FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for String {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(self) }
}

// FixedString<N> → String
impl<const N: usize> Coerce<String> for FixedString<N> {
    fn coerce(&self) -> String { self.as_str().to_string() }
}

/// Integer ↔ FixedString<N> — left-aligned, space-padded (PIC X semantics).
/// For PIC 9 (numeric display, right-aligned, zero-padded), the transpiler should
/// emit a dedicated numeric display formatter rather than using coerce!.
macro_rules! impl_int_fixedstring {
    ($($t:ty),*) => {
        $(
            impl<const N: usize> Coerce<FixedString<N>> for $t {
                fn coerce(&self) -> FixedString<N> { FixedString::from_str(&self.to_string()) }
            }
            impl<const N: usize> Coerce<$t> for FixedString<N> {
                fn coerce(&self) -> $t { self.trimmed().parse().unwrap_or(0 as $t) }
            }
        )*
    }
}
impl_int_fixedstring!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

// CobolNum ↔ FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for crate::CobolNum {
    fn coerce(&self) -> FixedString<N> {
        if self.is_space() {
            FixedString::new() // all spaces
        } else {
            FixedString::from_str(&self.val().to_string())
        }
    }
}
impl<const N: usize> Coerce<crate::CobolNum> for FixedString<N> {
    fn coerce(&self) -> crate::CobolNum {
        crate::CobolNum::from_display_bytes(self.as_bytes())
    }
}

// CobolNum ↔ primitive integers
impl Coerce<crate::CobolNum> for i32 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self as i64) }
}
impl Coerce<crate::CobolNum> for i64 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self) }
}
impl Coerce<crate::CobolNum> for u32 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self as i64) }
}
impl Coerce<crate::CobolNum> for u64 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self as i64) }
}
impl Coerce<i32> for crate::CobolNum {
    fn coerce(&self) -> i32 { self.val() as i32 }
}
impl Coerce<i64> for crate::CobolNum {
    fn coerce(&self) -> i64 { self.val() }
}
impl Coerce<u32> for crate::CobolNum {
    fn coerce(&self) -> u32 { self.val() as u32 }
}
impl Coerce<u64> for crate::CobolNum {
    fn coerce(&self) -> u64 { self.val() as u64 }
}
impl Coerce<f32> for crate::CobolNum {
    fn coerce(&self) -> f32 { self.val() as f32 }
}
impl Coerce<f64> for crate::CobolNum {
    fn coerce(&self) -> f64 { self.val() as f64 }
}
impl Coerce<crate::CobolNum> for f32 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self as i64) }
}
impl Coerce<crate::CobolNum> for f64 {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(*self as i64) }
}
impl Coerce<crate::CobolNum> for crate::CobolNum {
    fn coerce(&self) -> crate::CobolNum { *self }
}

// CobolNum ↔ DynamicValue
impl Coerce<crate::CobolNum> for DynamicValue {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(self.to_i128() as i64) }
}
impl Coerce<DynamicValue> for crate::CobolNum {
    fn coerce(&self) -> DynamicValue { DynamicValue::Integer(self.val() as i128) }
}

// CobolNum ↔ Decimal
impl Coerce<crate::CobolNum> for Decimal {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(i64::from(*self)) }
}
impl Coerce<Decimal> for crate::CobolNum {
    fn coerce(&self) -> Decimal { Decimal::from(self.val()) }
}

// CobolNum ↔ PackedDecimal
impl<const N: usize> Coerce<crate::CobolNum> for crate::PackedDecimal<N> {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(self.value()) }
}
impl<const N: usize> Coerce<crate::PackedDecimal<N>> for crate::CobolNum {
    fn coerce(&self) -> crate::PackedDecimal<N> { crate::PackedDecimal::new(self.val()) }
}

// CobolNum → String
impl Coerce<String> for crate::CobolNum {
    fn coerce(&self) -> String { self.val().to_string() }
}
impl Coerce<crate::CobolNum> for String {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(self.trim().parse::<i64>().unwrap_or(0)) }
}
impl Coerce<crate::CobolNum> for &str {
    fn coerce(&self) -> crate::CobolNum { crate::CobolNum(self.trim().parse::<i64>().unwrap_or(0)) }
}

// Float ↔ FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for f32 {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(&format!("{}", self)) }
}
impl<const N: usize> Coerce<FixedString<N>> for f64 {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(&format!("{}", self)) }
}
impl<const N: usize> Coerce<f32> for FixedString<N> {
    fn coerce(&self) -> f32 { self.trimmed().parse().unwrap_or(0.0) }
}
impl<const N: usize> Coerce<f64> for FixedString<N> {
    fn coerce(&self) -> f64 { self.trimmed().parse().unwrap_or(0.0) }
}

// bool ↔ FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for bool {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(if *self { "1" } else { "0" }) }
}
impl<const N: usize> Coerce<bool> for FixedString<N> {
    fn coerce(&self) -> bool {
        let t = self.trimmed();
        !t.is_empty() && t != "0" && t.bytes().any(|b| b != b' ')
    }
}

// DynamicValue → FixedString<N>
impl<const N: usize> Coerce<FixedString<N>> for DynamicValue {
    fn coerce(&self) -> FixedString<N> { FixedString::from_str(&self.to_string_value()) }
}

// FixedString<N> → DynamicValue
impl<const N: usize> Coerce<DynamicValue> for FixedString<N> {
    fn coerce(&self) -> DynamicValue { DynamicValue::Text(self.as_str().to_string()) }
}

// ─── Decimal coercions ───────────────────────────────────────────────

// Integer → Decimal
macro_rules! impl_int_decimal {
    ($($t:ty),*) => {
        $(
            impl Coerce<Decimal> for $t {
                // NOTE: i128 → Decimal truncates to i64 (Decimal uses i64 internally)
                fn coerce(&self) -> Decimal { Decimal { value: *self as i128, scale: 0 } }
            }
            impl Coerce<$t> for Decimal {
                fn coerce(&self) -> $t {
                    let factor = safe_pow_i128(self.scale);
                    (self.value / factor) as $t
                }
            }
        )*
    }
}
impl_int_decimal!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

// Float ↔ Decimal (H2 fix: use scale=6 to match DynamicValue)
impl Coerce<Decimal> for f32 {
    fn coerce(&self) -> Decimal {
        Decimal { value: (*self as f64 * 1_000_000.0).round() as i128, scale: 6 }
    }
}
impl Coerce<Decimal> for f64 {
    fn coerce(&self) -> Decimal {
        Decimal { value: (*self * 1_000_000.0).round() as i128, scale: 6 }
    }
}
impl Coerce<f32> for Decimal {
    fn coerce(&self) -> f32 { self.to_f64() as f32 }
}
impl Coerce<f64> for Decimal {
    fn coerce(&self) -> f64 { self.to_f64() }
}

// Decimal ↔ Decimal (identity)
impl Coerce<Decimal> for Decimal {
    fn coerce(&self) -> Decimal { *self }
}

// Decimal → String (C2 fix: preserve scale, don't use to_f64)
impl Coerce<String> for Decimal {
    fn coerce(&self) -> String {
        if self.scale == 0 {
            return self.value.to_string();
        }
        let factor = safe_pow_i128(self.scale);
        let int_part = self.value / factor;
        let frac_part = (self.value % factor).unsigned_abs();
        format!("{}.{:0>w$}", int_part, frac_part, w = self.scale as usize)
    }
}

// String/&str → Decimal (H2 fix: infer scale from input)
impl Coerce<Decimal> for String {
    fn coerce(&self) -> Decimal {
        let (value, scale) = infer_decimal_scale(self);
        Decimal { value, scale }
    }
}
impl Coerce<Decimal> for &str {
    fn coerce(&self) -> Decimal {
        let (value, scale) = infer_decimal_scale(self);
        Decimal { value, scale }
    }
}

// Decimal ↔ bool
impl Coerce<bool> for Decimal {
    fn coerce(&self) -> bool { self.value != 0 }
}
impl Coerce<Decimal> for bool {
    fn coerce(&self) -> Decimal {
        Decimal { value: if *self { 1 } else { 0 }, scale: 0 }
    }
}

// Decimal ↔ FixedString<N> (C2 fix: reuse scale-preserving String impl)
impl<const N: usize> Coerce<FixedString<N>> for Decimal {
    fn coerce(&self) -> FixedString<N> {
        let s: String = Coerce::coerce(self);
        FixedString::from_str(&s)
    }
}
impl<const N: usize> Coerce<Decimal> for FixedString<N> {
    fn coerce(&self) -> Decimal {
        let (value, scale) = infer_decimal_scale(self.trimmed());
        Decimal { value, scale }
    }
}

// Decimal ↔ DynamicValue
impl Coerce<DynamicValue> for Decimal {
    fn coerce(&self) -> DynamicValue { DynamicValue::Decimal(self.value, self.scale) }
}
impl Coerce<Decimal> for DynamicValue {
    fn coerce(&self) -> Decimal {
        match self {
            DynamicValue::Integer(v) => Decimal { value: *v, scale: 0 },
            DynamicValue::Decimal(v, s) => Decimal { value: *v, scale: *s },
            DynamicValue::Text(s) => <&str as Coerce<Decimal>>::coerce(&s.as_str()),
            _ => Decimal { value: 0, scale: 0 },
        }
    }
}

// ─── PackedDecimal coercions (H4 fix) ────────────────────────────────

impl<const N: usize> Coerce<i32> for PackedDecimal<N> {
    fn coerce(&self) -> i32 { self.value() as i32 }
}
impl<const N: usize> Coerce<i64> for PackedDecimal<N> {
    fn coerce(&self) -> i64 { self.value() }
}
impl<const N: usize> Coerce<i128> for PackedDecimal<N> {
    fn coerce(&self) -> i128 { self.value() as i128 }
}
impl<const N: usize> Coerce<u32> for PackedDecimal<N> {
    fn coerce(&self) -> u32 { self.value() as u32 }
}
impl<const N: usize> Coerce<u64> for PackedDecimal<N> {
    fn coerce(&self) -> u64 { self.value() as u64 }
}
impl<const N: usize> Coerce<f64> for PackedDecimal<N> {
    fn coerce(&self) -> f64 { self.value() as f64 }
}
impl<const N: usize> Coerce<bool> for PackedDecimal<N> {
    fn coerce(&self) -> bool { self.value() != 0 }
}
impl<const N: usize> Coerce<String> for PackedDecimal<N> {
    fn coerce(&self) -> String { self.value().to_string() }
}
impl<const N: usize> Coerce<Decimal> for PackedDecimal<N> {
    fn coerce(&self) -> Decimal { Decimal { value: self.value() as i128, scale: 0 } }
}
impl<const N: usize> Coerce<DynamicValue> for PackedDecimal<N> {
    fn coerce(&self) -> DynamicValue { DynamicValue::Integer(self.value() as i128) }
}
impl<const N: usize> Coerce<f32> for PackedDecimal<N> {
    fn coerce(&self) -> f32 { self.value() as f32 }
}
impl<const N: usize, const M: usize> Coerce<FixedString<M>> for PackedDecimal<N> {
    fn coerce(&self) -> FixedString<M> { FixedString::from_str(&self.value().to_string()) }
}
// PackedDecimal<N> → PackedDecimal<M> (cross-size)
impl<const N: usize, const M: usize> Coerce<PackedDecimal<M>> for PackedDecimal<N> {
    fn coerce(&self) -> PackedDecimal<M> { PackedDecimal::new(self.value()) }
}

// ─── Reverse coercions: concrete types → PackedDecimal (Sprint 2) ────

macro_rules! impl_int_to_packed {
    ($($t:ty),*) => {
        $(
            impl<const N: usize> Coerce<PackedDecimal<N>> for $t {
                fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(*self as i64) }
            }
        )*
    }
}
impl_int_to_packed!(i8, i16, i32, i64, i128, u8, u16, u32, u64);

impl<const N: usize> Coerce<PackedDecimal<N>> for f32 {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(*self as i64) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for f64 {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(*self as i64) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for bool {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(if *self { 1 } else { 0 }) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for String {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(self.trim().parse().unwrap_or(0)) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for &str {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(self.trim().parse().unwrap_or(0)) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for Decimal {
    fn coerce(&self) -> PackedDecimal<N> {
        let factor = safe_pow_i128(self.scale);
        PackedDecimal::new((self.value / factor) as i64)
    }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for DynamicValue {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(self.to_i128() as i64) }
}
impl<const N: usize, const M: usize> Coerce<PackedDecimal<N>> for FixedString<M> {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(self.trimmed().parse().unwrap_or(0)) }
}
impl<const N: usize> Coerce<PackedDecimal<N>> for FigurativeConstant {
    fn coerce(&self) -> PackedDecimal<N> { PackedDecimal::new(0) }
}

// ─── FigurativeConstant coercions ────────────────────────────────────

impl<const N: usize> Coerce<FixedString<N>> for FigurativeConstant {
    fn coerce(&self) -> FixedString<N> {
        match self {
            FigurativeConstant::Spaces => FixedString::spaces(),
            FigurativeConstant::Zeros => {
                let mut fs = FixedString::new();
                for b in fs.as_bytes_mut() { *b = b'0'; }
                fs
            }
            FigurativeConstant::LowValues => FixedString::low_values(),
            FigurativeConstant::HighValues => FixedString::high_values(),
            FigurativeConstant::Quotes => {
                let mut fs = FixedString::new();
                for b in fs.as_bytes_mut() { *b = b'"'; }
                fs
            }
        }
    }
}

impl Coerce<crate::CobolNum> for FigurativeConstant {
    fn coerce(&self) -> crate::CobolNum {
        match self {
            FigurativeConstant::Spaces => crate::CobolNum::space(),
            _ => crate::CobolNum(0),
        }
    }
}
impl Coerce<i32> for FigurativeConstant {
    fn coerce(&self) -> i32 { 0 }
}
impl Coerce<i64> for FigurativeConstant {
    fn coerce(&self) -> i64 { 0 }
}
impl Coerce<u32> for FigurativeConstant {
    fn coerce(&self) -> u32 { 0 }
}
impl Coerce<u64> for FigurativeConstant {
    fn coerce(&self) -> u64 { 0 }
}
impl Coerce<f64> for FigurativeConstant {
    fn coerce(&self) -> f64 { 0.0 }
}
// C3 fix: match DynamicValue path — ZEROS/LOW-VALUES are falsy, rest truthy
impl Coerce<bool> for FigurativeConstant {
    fn coerce(&self) -> bool {
        !matches!(self, FigurativeConstant::Zeros | FigurativeConstant::LowValues)
    }
}
/// Figurative → String produces a SINGLE representative character.
/// For field-filling behavior, use the FixedString<N> coercion which fills all N bytes.
impl Coerce<String> for FigurativeConstant {
    fn coerce(&self) -> String {
        match self {
            FigurativeConstant::Spaces => " ".into(),
            FigurativeConstant::Zeros => "0".into(),
            FigurativeConstant::LowValues => "\x00".into(),
            FigurativeConstant::HighValues => "\u{FF}".into(),
            FigurativeConstant::Quotes => "\"".into(),
        }
    }
}
impl Coerce<Decimal> for FigurativeConstant {
    fn coerce(&self) -> Decimal { Decimal { value: 0, scale: 0 } }
}

// Sprint 4: Full FigurativeConstant coverage — all missing int/float targets
macro_rules! impl_figurative_to_int {
    ($($t:ty),*) => {
        $(
            impl Coerce<$t> for FigurativeConstant {
                fn coerce(&self) -> $t { 0 as $t }
            }
        )*
    }
}
impl_figurative_to_int!(i8, i16, i128, u8, u16);

impl Coerce<f32> for FigurativeConstant {
    fn coerce(&self) -> f32 { 0.0 }
}

// Sprint 3: FigurativeConstant → DynamicValue (two-hop entry point)
impl Coerce<DynamicValue> for FigurativeConstant {
    fn coerce(&self) -> DynamicValue { DynamicValue::Figurative(*self) }
}

// Sprint 3: FigurativeConstant → Vec<u8> (group-level byte moves)
impl Coerce<Vec<u8>> for FigurativeConstant {
    fn coerce(&self) -> Vec<u8> {
        match self {
            FigurativeConstant::Spaces => vec![b' '],
            FigurativeConstant::Zeros => vec![b'0'],
            FigurativeConstant::LowValues => vec![0x00],
            FigurativeConstant::HighValues => vec![0xFF],
            FigurativeConstant::Quotes => vec![b'"'],
        }
    }
}

// Sprint 3: DynamicValue → PackedDecimal<N> already exists (line 700)
// Sprint 3: DynamicValue → FixedString<N> already exists (line 504)
// Sprint 3: DynamicValue → Decimal already exists (line 612)
// All two-hop paths Source→DynamicValue→Target are now covered.

// ─── Tests ───────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;

    // ── DynamicValue From conversions ──

    #[test]
    fn dv_from_i32() {
        let dv = DynamicValue::from(42i32);
        assert!(matches!(dv, DynamicValue::Integer(42)));
    }

    #[test]
    fn dv_from_i64() {
        let dv = DynamicValue::from(-999i64);
        assert!(matches!(dv, DynamicValue::Integer(-999)));
    }

    #[test]
    fn dv_from_u32() {
        let dv = DynamicValue::from(100u32);
        assert!(matches!(dv, DynamicValue::Integer(100)));
    }

    #[test]
    fn dv_from_u64_max() {
        let dv = DynamicValue::from(u64::MAX);
        assert_eq!(dv.to_i128(), u64::MAX as i128);
    }

    #[test]
    fn dv_from_f64() {
        let dv = DynamicValue::from(3.14f64);
        assert!(matches!(dv, DynamicValue::Decimal(_, 6)));
        let f: f64 = dv.to_f64();
        assert!((f - 3.14).abs() < 0.001);
    }

    #[test]
    fn dv_from_string() {
        let dv = DynamicValue::from("hello".to_string());
        assert!(matches!(dv, DynamicValue::Text(ref s) if s == "hello"));
    }

    #[test]
    fn dv_from_str() {
        let dv = DynamicValue::from("world");
        assert!(matches!(dv, DynamicValue::Text(ref s) if s == "world"));
    }

    #[test]
    fn dv_from_bool_true() {
        assert!(matches!(DynamicValue::from(true), DynamicValue::Boolean(true)));
    }

    #[test]
    fn dv_from_bool_false() {
        assert!(matches!(DynamicValue::from(false), DynamicValue::Boolean(false)));
    }

    #[test]
    fn dv_from_bytes() {
        let dv = DynamicValue::from(vec![1u8, 2, 3]);
        assert!(matches!(dv, DynamicValue::Bytes(ref b) if b.len() == 3));
    }

    #[test]
    fn dv_from_figurative() {
        let dv = DynamicValue::from(FigurativeConstant::Spaces);
        assert!(matches!(dv, DynamicValue::Figurative(FigurativeConstant::Spaces)));
    }

    #[test]
    fn dv_from_fixedstring() {
        let fs: FixedString<5> = FixedString::from_str("HI");
        let dv = DynamicValue::from(fs);
        assert!(matches!(dv, DynamicValue::Text(ref s) if s == "HI   "));
    }

    #[test]
    fn dv_from_decimal() {
        let d = Decimal { value: 12345, scale: 2 };
        let dv = DynamicValue::from(d);
        assert!(matches!(dv, DynamicValue::Decimal(12345, 2)));
    }

    // ── DynamicValue extraction ──

    #[test]
    fn dv_integer_to_i128() {
        assert_eq!(DynamicValue::Integer(42).to_i128(), 42);
    }

    #[test]
    fn dv_decimal_to_i128_truncates() {
        assert_eq!(DynamicValue::Decimal(12345, 2).to_i128(), 123);
    }

    #[test]
    fn dv_text_to_i128() {
        assert_eq!(DynamicValue::Text("  99  ".into()).to_i128(), 99);
    }

    #[test]
    fn dv_text_nonnumeric_to_i128() {
        assert_eq!(DynamicValue::Text("abc".into()).to_i128(), 0);
    }

    #[test]
    fn dv_bool_to_string() {
        assert_eq!(DynamicValue::Boolean(true).to_string_value(), "1");
        assert_eq!(DynamicValue::Boolean(false).to_string_value(), "0");
    }

    #[test]
    fn dv_decimal_to_string() {
        assert_eq!(DynamicValue::Decimal(12345, 2).to_string_value(), "123.45");
    }

    #[test]
    fn dv_to_bool() {
        assert!(DynamicValue::Integer(1).to_bool());
        assert!(!DynamicValue::Integer(0).to_bool());
        assert!(DynamicValue::Text("hello".into()).to_bool());
        assert!(!DynamicValue::Text("".into()).to_bool());
        assert!(!DynamicValue::Text("0".into()).to_bool());
    }

    // ── C1: pow overflow panic tests ──

    #[test]
    fn dv_decimal_huge_scale_no_panic() {
        let dv = DynamicValue::Decimal(12345, 255);
        let _ = dv.to_i128();
        let _ = dv.to_f64();
        let _ = dv.to_string_value();
    }

    #[test]
    fn decimal_huge_scale_no_panic() {
        let d = Decimal { value: 100, scale: 200 };
        let v: i32 = Coerce::coerce(&d);
        assert_eq!(v, 0);
    }

    // ── coerce! macro ──

    #[test]
    fn coerce_macro_i32_to_i64() {
        let mut target: i64 = 0;
        coerce!(target, 42i32);
        assert_eq!(target, 42);
    }

    #[test]
    fn coerce_macro_str_to_fixedstring() {
        let mut target: FixedString<10> = FixedString::new();
        coerce!(target, "HELLO");
        assert_eq!(target.trimmed(), "HELLO");
    }

    #[test]
    fn coerce_macro_i32_to_fixedstring() {
        let mut target: FixedString<5> = FixedString::new();
        coerce!(target, 42i32);
        assert_eq!(target.trimmed(), "42");
    }

    #[test]
    fn coerce_macro_fixedstring_to_i32() {
        let fs: FixedString<5> = FixedString::from_str("123");
        let mut target: i32 = 0;
        coerce!(target, fs);
        assert_eq!(target, 123);
    }

    #[test]
    fn coerce_macro_truncate_variant() {
        let mut target: FixedString<3> = FixedString::new();
        coerce!(target, "ABCDEFG", truncate);
        assert_eq!(target.as_str(), "ABC");
    }

    #[test]
    fn coerce_macro_checked_variant() {
        let mut target: i64 = 0;
        coerce!(target, 42i32, checked);
        assert_eq!(target, 42);
    }

    // ── Integer ↔ Integer coercion ──

    #[test]
    fn coerce_i32_to_u32() {
        let v: u32 = Coerce::coerce(&42i32);
        assert_eq!(v, 42);
    }

    #[test]
    fn coerce_i64_to_i32_truncation() {
        let v: i32 = Coerce::coerce(&(i32::MAX as i64 + 1));
        assert_eq!(v, i32::MIN);
    }

    #[test]
    fn coerce_u64_to_f64() {
        let v: f64 = Coerce::coerce(&1000u64);
        assert_eq!(v, 1000.0);
    }

    // ── Integer ↔ String coercion ──

    #[test]
    fn coerce_i32_to_string() {
        let s: String = Coerce::coerce(&-42i32);
        assert_eq!(s, "-42");
    }

    #[test]
    fn coerce_string_to_i32() {
        let v: i32 = Coerce::coerce(&"  99  ".to_string());
        assert_eq!(v, 99);
    }

    #[test]
    fn coerce_string_to_i32_invalid() {
        let v: i32 = Coerce::coerce(&"abc".to_string());
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_str_to_i64() {
        let v: i64 = Coerce::coerce(&"-12345");
        assert_eq!(v, -12345);
    }

    #[test]
    fn coerce_f64_to_string() {
        let s: String = Coerce::coerce(&3.14f64);
        assert_eq!(s, "3.14");
    }

    // ── H1: i128 ↔ String/FixedString/Decimal ──

    #[test]
    fn coerce_i128_to_string() {
        let s: String = Coerce::coerce(&42i128);
        assert_eq!(s, "42");
    }

    #[test]
    fn coerce_string_to_i128() {
        let v: i128 = Coerce::coerce(&"99999999999999999999".to_string());
        assert_eq!(v, 99999999999999999999i128);
    }

    #[test]
    fn coerce_i128_to_fixedstring() {
        let fs: FixedString<20> = Coerce::coerce(&42i128);
        assert_eq!(fs.trimmed(), "42");
    }

    #[test]
    fn coerce_i128_to_decimal() {
        let d: Decimal = Coerce::coerce(&42i128);
        assert_eq!(d.value, 42);
        assert_eq!(d.scale, 0);
    }

    // ── Integer ↔ bool coercion ──

    #[test]
    fn coerce_i32_to_bool() {
        assert!(Coerce::<bool>::coerce(&1i32));
        assert!(!Coerce::<bool>::coerce(&0i32));
        assert!(Coerce::<bool>::coerce(&-1i32));
    }

    #[test]
    fn coerce_bool_to_i32() {
        assert_eq!(Coerce::<i32>::coerce(&true), 1);
        assert_eq!(Coerce::<i32>::coerce(&false), 0);
    }

    #[test]
    fn coerce_string_to_bool() {
        assert!(Coerce::<bool>::coerce(&"hello".to_string()));
        assert!(!Coerce::<bool>::coerce(&"".to_string()));
        assert!(!Coerce::<bool>::coerce(&"0".to_string()));
    }

    // M1: bool → f64
    #[test]
    fn coerce_bool_to_f64() {
        assert_eq!(Coerce::<f64>::coerce(&true), 1.0);
        assert_eq!(Coerce::<f64>::coerce(&false), 0.0);
    }

    // ── FixedString coercions ──

    #[test]
    fn coerce_str_to_fixedstring_pads() {
        let fs: FixedString<10> = Coerce::coerce(&"HI");
        assert_eq!(fs.as_str(), "HI        ");
    }

    #[test]
    fn coerce_str_to_fixedstring_truncates() {
        let fs: FixedString<3> = Coerce::coerce(&"HELLO");
        assert_eq!(fs.as_str(), "HEL");
    }

    #[test]
    fn coerce_fixedstring_to_string() {
        let fs: FixedString<5> = FixedString::from_str("AB");
        let s: String = Coerce::coerce(&fs);
        assert_eq!(s, "AB   ");
    }

    #[test]
    fn coerce_i64_to_fixedstring() {
        let fs: FixedString<10> = Coerce::coerce(&12345i64);
        assert_eq!(fs.trimmed(), "12345");
    }

    #[test]
    fn coerce_fixedstring_to_i32() {
        let fs: FixedString<5> = FixedString::from_str("42");
        let v: i32 = Coerce::coerce(&fs);
        assert_eq!(v, 42);
    }

    #[test]
    fn coerce_fixedstring_to_i32_spaces() {
        let fs: FixedString<5> = FixedString::spaces();
        let v: i32 = Coerce::coerce(&fs);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_fixedstring_to_f64() {
        let fs: FixedString<10> = FixedString::from_str("3.14");
        let v: f64 = Coerce::coerce(&fs);
        assert!((v - 3.14).abs() < 0.001);
    }

    #[test]
    fn coerce_bool_to_fixedstring() {
        let fs: FixedString<3> = Coerce::coerce(&true);
        assert_eq!(fs.trimmed(), "1");
        let fs: FixedString<3> = Coerce::coerce(&false);
        assert_eq!(fs.trimmed(), "0");
    }

    #[test]
    fn coerce_fixedstring_to_bool_spaces() {
        let fs: FixedString<5> = FixedString::spaces();
        assert!(!Coerce::<bool>::coerce(&fs));
    }

    #[test]
    fn coerce_fixedstring_to_bool_nonspace() {
        let fs: FixedString<5> = FixedString::from_str("Y");
        assert!(Coerce::<bool>::coerce(&fs));
    }

    // ── Decimal coercions ──

    #[test]
    fn coerce_i32_to_decimal() {
        let d: Decimal = Coerce::coerce(&42i32);
        assert_eq!(d.value, 42);
        assert_eq!(d.scale, 0);
    }

    #[test]
    fn coerce_decimal_to_i32() {
        let d = Decimal { value: 12345, scale: 2 };
        let v: i32 = Coerce::coerce(&d);
        assert_eq!(v, 123);
    }

    #[test]
    fn coerce_decimal_to_f64() {
        let d = Decimal { value: 12345, scale: 2 };
        let v: f64 = Coerce::coerce(&d);
        assert!((v - 123.45).abs() < 0.001);
    }

    // H2: f64 → Decimal now uses scale=6
    #[test]
    fn coerce_f64_to_decimal() {
        let d: Decimal = Coerce::coerce(&3.14f64);
        assert_eq!(d.scale, 6);
        assert_eq!(d.value, 3_140_000);
    }

    // C2: Decimal → String preserves scale
    #[test]
    fn coerce_decimal_to_string() {
        let d = Decimal { value: 500, scale: 2 };
        let s: String = Coerce::coerce(&d);
        assert_eq!(s, "5.00");
    }

    #[test]
    fn coerce_decimal_scale0_to_string() {
        let d = Decimal { value: 42, scale: 0 };
        let s: String = Coerce::coerce(&d);
        assert_eq!(s, "42");
    }

    #[test]
    fn coerce_negative_decimal_to_string() {
        let d = Decimal { value: -12345, scale: 2 };
        let s: String = Coerce::coerce(&d);
        assert_eq!(s, "-123.45");
    }

    // H2: String → Decimal infers scale
    #[test]
    fn coerce_str_to_decimal_preserves_scale() {
        let d: Decimal = Coerce::coerce(&"3.1415");
        assert_eq!(d.scale, 4);
        assert_eq!(d.value, 31415);
    }

    #[test]
    fn coerce_str_to_decimal_integer() {
        let d: Decimal = Coerce::coerce(&"42");
        assert_eq!(d.scale, 0);
        assert_eq!(d.value, 42);
    }

    #[test]
    fn coerce_str_to_decimal() {
        let d: Decimal = Coerce::coerce(&"3.14");
        assert_eq!(d.value, 314);
        assert_eq!(d.scale, 2);
    }

    #[test]
    fn coerce_decimal_to_fixedstring() {
        let d = Decimal { value: 12345, scale: 2 };
        let fs: FixedString<10> = Coerce::coerce(&d);
        assert_eq!(fs.trimmed(), "123.45");
    }

    #[test]
    fn coerce_fixedstring_to_decimal() {
        let fs: FixedString<10> = FixedString::from_str("3.14");
        let d: Decimal = Coerce::coerce(&fs);
        assert_eq!(d.value, 314);
        assert_eq!(d.scale, 2);
    }

    #[test]
    fn coerce_decimal_to_bool() {
        assert!(Coerce::<bool>::coerce(&Decimal { value: 1, scale: 0 }));
        assert!(!Coerce::<bool>::coerce(&Decimal { value: 0, scale: 0 }));
    }

    // ── Decimal round-trip ──

    #[test]
    fn roundtrip_decimal_string_decimal() {
        let original = Decimal { value: 12345, scale: 2 };
        let s: String = Coerce::coerce(&original);
        assert_eq!(s, "123.45");
        let back: Decimal = Coerce::coerce(&s);
        assert_eq!(back.value, original.value);
        assert_eq!(back.scale, original.scale);
    }

    #[test]
    fn roundtrip_f64_decimal_f64() {
        let original = 3.14f64;
        let d: Decimal = Coerce::coerce(&original);
        let back: f64 = Coerce::coerce(&d);
        assert!((back - original).abs() < 0.0001);
    }

    // ── PackedDecimal coercions (H4) ──

    #[test]
    fn coerce_packed_decimal_to_i32() {
        let pd: PackedDecimal<5> = PackedDecimal::new(12345);
        let v: i32 = Coerce::coerce(&pd);
        assert_eq!(v, 12345);
    }

    #[test]
    fn coerce_packed_decimal_to_string() {
        let pd: PackedDecimal<5> = PackedDecimal::new(-99);
        let s: String = Coerce::coerce(&pd);
        assert_eq!(s, "-99");
    }

    #[test]
    fn coerce_packed_decimal_to_decimal() {
        let pd: PackedDecimal<5> = PackedDecimal::new(500);
        let d: Decimal = Coerce::coerce(&pd);
        assert_eq!(d.value, 500);
        assert_eq!(d.scale, 0);
    }

    #[test]
    fn coerce_packed_decimal_to_fixedstring() {
        let pd: PackedDecimal<5> = PackedDecimal::new(42);
        let fs: FixedString<10> = Coerce::coerce(&pd);
        assert_eq!(fs.trimmed(), "42");
    }

    // ── FigurativeConstant coercions ──

    #[test]
    fn coerce_spaces_to_fixedstring() {
        let fs: FixedString<5> = Coerce::coerce(&FigurativeConstant::Spaces);
        assert_eq!(fs.as_str(), "     ");
    }

    #[test]
    fn coerce_zeros_to_fixedstring() {
        let fs: FixedString<3> = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(fs.as_str(), "000");
    }

    #[test]
    fn coerce_low_values_to_fixedstring() {
        let fs: FixedString<3> = Coerce::coerce(&FigurativeConstant::LowValues);
        assert_eq!(fs.as_bytes(), &[0, 0, 0]);
    }

    #[test]
    fn coerce_high_values_to_fixedstring() {
        let fs: FixedString<3> = Coerce::coerce(&FigurativeConstant::HighValues);
        assert_eq!(fs.as_bytes(), &[0xFF, 0xFF, 0xFF]);
    }

    #[test]
    fn coerce_zeros_to_i32() {
        let v: i32 = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_zeros_to_decimal() {
        let d: Decimal = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(d.value, 0);
    }

    // C3: Figurative → bool consistency
    #[test]
    fn coerce_figurative_to_bool_consistency() {
        let cases = [
            (FigurativeConstant::Zeros, false),
            (FigurativeConstant::LowValues, false),
            (FigurativeConstant::Spaces, true),
            (FigurativeConstant::HighValues, true),
            (FigurativeConstant::Quotes, true),
        ];
        for (fig, expected) in cases {
            let direct: bool = Coerce::coerce(&fig);
            assert_eq!(direct, expected, "direct {:?}", fig);
            let dv = DynamicValue::from(fig);
            let via_dv: bool = dv.to_bool();
            assert_eq!(via_dv, expected, "via DynamicValue {:?}", fig);
            assert_eq!(direct, via_dv, "paths disagree for {:?}", fig);
        }
    }

    // ── DynamicValue two-hop path ──

    #[test]
    fn dv_two_hop_i32_to_fixedstring() {
        let dv = DynamicValue::from(42i32);
        let fs: FixedString<5> = Coerce::coerce(&dv);
        assert_eq!(fs.trimmed(), "42");
    }

    #[test]
    fn dv_two_hop_string_to_decimal() {
        let dv = DynamicValue::Text("3.14".into());
        let d: Decimal = Coerce::coerce(&dv);
        assert_eq!(d.value, 314);
    }

    #[test]
    fn dv_two_hop_decimal_to_i32() {
        let dv = DynamicValue::Decimal(12345, 2);
        let v: i32 = Coerce::coerce(&dv);
        assert_eq!(v, 123);
    }

    #[test]
    fn dv_two_hop_bool_to_i32() {
        let dv = DynamicValue::Boolean(true);
        let v: i32 = Coerce::coerce(&dv);
        assert_eq!(v, 1);
    }

    // ── Round-trip tests ──

    #[test]
    fn roundtrip_i32_string_i32() {
        let original = 12345i32;
        let s: String = Coerce::coerce(&original);
        let back: i32 = Coerce::coerce(&s);
        assert_eq!(original, back);
    }

    #[test]
    fn roundtrip_i64_fixedstring_i64() {
        let original = -999i64;
        let fs: FixedString<10> = Coerce::coerce(&original);
        let back: i64 = Coerce::coerce(&fs);
        assert_eq!(original, back);
    }

    #[test]
    fn roundtrip_str_fixedstring_string() {
        let original = "TEST";
        let fs: FixedString<10> = Coerce::coerce(&original);
        let back: String = Coerce::coerce(&fs);
        assert_eq!(back.trim_end(), original);
    }

    // ── M3: Bytes reinterpretation fix ──

    #[test]
    fn dv_bytes_to_f64_not_reinterpret() {
        let dv = DynamicValue::Bytes(vec![0xFF, 0xFF, 0xFF]);
        assert_eq!(dv.to_f64(), 0.0);
    }

    #[test]
    fn dv_bytes_numeric_string_to_i128() {
        let dv = DynamicValue::Bytes(b"42".to_vec());
        assert_eq!(dv.to_i128(), 42);
    }

    #[test]
    fn dv_empty_bytes_to_i128() {
        let dv = DynamicValue::Bytes(vec![]);
        assert_eq!(dv.to_i128(), 0);
    }

    // ── Edge cases ──

    #[test]
    fn coerce_empty_str_to_i32() {
        let v: i32 = Coerce::coerce(&"");
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_empty_string_to_fixedstring() {
        let fs: FixedString<5> = Coerce::coerce(&"");
        assert_eq!(fs.as_str(), "     ");
    }

    #[test]
    fn coerce_zero_to_fixedstring() {
        let fs: FixedString<5> = Coerce::coerce(&0i32);
        assert_eq!(fs.trimmed(), "0");
    }

    #[test]
    fn coerce_max_i32_to_fixedstring() {
        let fs: FixedString<20> = Coerce::coerce(&i32::MAX);
        assert_eq!(fs.trimmed(), "2147483647");
    }

    #[test]
    fn coerce_negative_to_fixedstring() {
        let fs: FixedString<10> = Coerce::coerce(&(-42i32));
        assert_eq!(fs.trimmed(), "-42");
    }

    #[test]
    fn coerce_fixedstring_nonnumeric_to_i32() {
        let fs: FixedString<10> = FixedString::from_str("ABCDE");
        let v: i32 = Coerce::coerce(&fs);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_identity_i32() {
        let v: i32 = Coerce::coerce(&42i32);
        assert_eq!(v, 42);
    }

    #[test]
    fn coerce_identity_string() {
        let s = "hello".to_string();
        let r: String = Coerce::coerce(&s);
        assert_eq!(r, "hello");
    }

    // ── Overflow / boundary tests ──

    #[test]
    fn coerce_i128_max_to_i32_wraps() {
        let v: i32 = Coerce::coerce(&i128::MAX);
        let _ = v; // no panic
    }

    #[test]
    fn coerce_negative_i32_to_u32_wraps() {
        let v: u32 = Coerce::coerce(&(-1i32));
        assert_eq!(v, u32::MAX);
    }

    #[test]
    fn coerce_f64_nan_to_i32() {
        let v: i32 = Coerce::coerce(&f64::NAN);
        let _ = v; // no panic
    }

    #[test]
    fn coerce_f64_infinity_to_i32() {
        let v: i32 = Coerce::coerce(&f64::INFINITY);
        let _ = v; // no panic
    }

    #[test]
    fn coerce_f64_max_to_decimal_no_panic() {
        let d: Decimal = Coerce::coerce(&f64::MAX);
        let _ = d; // no panic, garbage value via `as i64` is acceptable
    }

    // ── Negative Decimal tests ──

    #[test]
    fn coerce_negative_decimal_to_i32() {
        let d = Decimal { value: -500, scale: 2 };
        let v: i32 = Coerce::coerce(&d);
        assert_eq!(v, -5);
    }

    #[test]
    fn coerce_negative_decimal_to_fixedstring() {
        let d = Decimal { value: -12345, scale: 2 };
        let fs: FixedString<10> = Coerce::coerce(&d);
        assert_eq!(fs.trimmed(), "-123.45");
    }

    // ── DynamicValue edge cases ──

    #[test]
    fn dv_figurative_zeros_to_string() {
        let dv = DynamicValue::Figurative(FigurativeConstant::Zeros);
        assert_eq!(dv.to_string_value(), "0");
    }

    #[test]
    fn dv_figurative_high_values_to_string() {
        let dv = DynamicValue::Figurative(FigurativeConstant::HighValues);
        assert_eq!(dv.to_string_value(), "\u{FF}");
    }

    // ── Sprint 2: Cross-size FixedString ──

    #[test]
    fn coerce_fixedstring_5_to_10() {
        let src: FixedString<5> = FixedString::from_str("HI");
        let dst: FixedString<10> = Coerce::coerce(&src);
        assert_eq!(dst.as_str(), "HI        ");
    }

    #[test]
    fn coerce_fixedstring_10_to_3_truncates() {
        let src: FixedString<10> = FixedString::from_str("ABCDEFGHIJ");
        let dst: FixedString<3> = Coerce::coerce(&src);
        assert_eq!(dst.as_str(), "ABC");
    }

    #[test]
    fn coerce_fixedstring_same_size() {
        let src: FixedString<5> = FixedString::from_str("HELLO");
        let dst: FixedString<5> = Coerce::coerce(&src);
        assert_eq!(dst.as_str(), "HELLO");
    }

    // ── Sprint 2: Reverse PackedDecimal coercions ──

    #[test]
    fn coerce_i32_to_packed_decimal() {
        let pd: PackedDecimal<5> = Coerce::coerce(&42i32);
        assert_eq!(pd.value(), 42);
    }

    #[test]
    fn coerce_i64_to_packed_decimal() {
        let pd: PackedDecimal<9> = Coerce::coerce(&-12345i64);
        assert_eq!(pd.value(), -12345);
    }

    #[test]
    fn coerce_f64_to_packed_decimal() {
        let pd: PackedDecimal<5> = Coerce::coerce(&3.7f64);
        assert_eq!(pd.value(), 3); // truncated to integer
    }

    #[test]
    fn coerce_string_to_packed_decimal() {
        let pd: PackedDecimal<5> = Coerce::coerce(&"999".to_string());
        assert_eq!(pd.value(), 999);
    }

    #[test]
    fn coerce_str_to_packed_decimal() {
        let pd: PackedDecimal<5> = Coerce::coerce(&"  -42  ");
        assert_eq!(pd.value(), -42);
    }

    #[test]
    fn coerce_str_to_packed_decimal_invalid() {
        let pd: PackedDecimal<5> = Coerce::coerce(&"abc");
        assert_eq!(pd.value(), 0);
    }

    #[test]
    fn coerce_bool_to_packed_decimal() {
        let pd: PackedDecimal<3> = Coerce::coerce(&true);
        assert_eq!(pd.value(), 1);
        let pd: PackedDecimal<3> = Coerce::coerce(&false);
        assert_eq!(pd.value(), 0);
    }

    #[test]
    fn coerce_decimal_to_packed_decimal() {
        let d = Decimal { value: 12345, scale: 2 };
        let pd: PackedDecimal<5> = Coerce::coerce(&d);
        assert_eq!(pd.value(), 123); // integer part only
    }

    #[test]
    fn coerce_fixedstring_to_packed_decimal() {
        let fs: FixedString<10> = FixedString::from_str("777");
        let pd: PackedDecimal<5> = Coerce::coerce(&fs);
        assert_eq!(pd.value(), 777);
    }

    #[test]
    fn coerce_dv_to_packed_decimal() {
        let dv = DynamicValue::Integer(42);
        let pd: PackedDecimal<5> = Coerce::coerce(&dv);
        assert_eq!(pd.value(), 42);
    }

    #[test]
    fn coerce_figurative_to_packed_decimal() {
        let pd: PackedDecimal<5> = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(pd.value(), 0);
    }

    #[test]
    fn coerce_packed_decimal_cross_size() {
        let src: PackedDecimal<3> = PackedDecimal::new(42);
        let dst: PackedDecimal<9> = Coerce::coerce(&src);
        assert_eq!(dst.value(), 42);
    }

    #[test]
    fn coerce_packed_decimal_to_f32() {
        let pd: PackedDecimal<5> = PackedDecimal::new(42);
        let v: f32 = Coerce::coerce(&pd);
        assert_eq!(v, 42.0);
    }

    #[test]
    fn roundtrip_packed_decimal_string() {
        let original: PackedDecimal<5> = PackedDecimal::new(12345);
        let s: String = Coerce::coerce(&original);
        assert_eq!(s, "12345");
        let back: PackedDecimal<5> = Coerce::coerce(&s);
        assert_eq!(back.value(), 12345);
    }

    // ── Sprint 4: FigurativeConstant full coverage ──

    #[test]
    fn coerce_figurative_to_i8() {
        let v: i8 = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(v, 0);
        let v: i8 = Coerce::coerce(&FigurativeConstant::Spaces);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_figurative_to_i16() {
        let v: i16 = Coerce::coerce(&FigurativeConstant::HighValues);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_figurative_to_i128() {
        let v: i128 = Coerce::coerce(&FigurativeConstant::LowValues);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_figurative_to_u8() {
        let v: u8 = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_figurative_to_u16() {
        let v: u16 = Coerce::coerce(&FigurativeConstant::Quotes);
        assert_eq!(v, 0);
    }

    #[test]
    fn coerce_figurative_to_f32() {
        let v: f32 = Coerce::coerce(&FigurativeConstant::Zeros);
        assert_eq!(v, 0.0);
    }

    // ── Sprint 3: DynamicValue two-hop completeness ──

    #[test]
    fn coerce_figurative_to_dynamicvalue() {
        let dv: DynamicValue = Coerce::coerce(&FigurativeConstant::Spaces);
        assert!(matches!(dv, DynamicValue::Figurative(FigurativeConstant::Spaces)));
    }

    #[test]
    fn coerce_figurative_to_vec_u8() {
        let v: Vec<u8> = Coerce::coerce(&FigurativeConstant::Spaces);
        assert_eq!(v, vec![b' ']);
        let v: Vec<u8> = Coerce::coerce(&FigurativeConstant::HighValues);
        assert_eq!(v, vec![0xFF]);
    }

    #[test]
    fn two_hop_figurative_to_i32_via_dv() {
        // FigurativeConstant → DynamicValue → i32
        let dv: DynamicValue = Coerce::coerce(&FigurativeConstant::Zeros);
        let v: i32 = Coerce::coerce(&dv);
        assert_eq!(v, 0);
    }

    #[test]
    fn two_hop_figurative_to_fixedstring_via_dv() {
        let dv: DynamicValue = Coerce::coerce(&FigurativeConstant::Spaces);
        let fs: FixedString<5> = Coerce::coerce(&dv);
        assert_eq!(fs.as_str(), " ".to_string() + "    ");
    }

    #[test]
    fn coerce_figurative_all_types_no_panic() {
        // Exhaustive: every figurative → every target type must not panic
        for fig in [
            FigurativeConstant::Spaces,
            FigurativeConstant::Zeros,
            FigurativeConstant::LowValues,
            FigurativeConstant::HighValues,
            FigurativeConstant::Quotes,
        ] {
            let _: i8 = Coerce::coerce(&fig);
            let _: i16 = Coerce::coerce(&fig);
            let _: i32 = Coerce::coerce(&fig);
            let _: i64 = Coerce::coerce(&fig);
            let _: i128 = Coerce::coerce(&fig);
            let _: u8 = Coerce::coerce(&fig);
            let _: u16 = Coerce::coerce(&fig);
            let _: u32 = Coerce::coerce(&fig);
            let _: u64 = Coerce::coerce(&fig);
            let _: f32 = Coerce::coerce(&fig);
            let _: f64 = Coerce::coerce(&fig);
            let _: bool = Coerce::coerce(&fig);
            let _: String = Coerce::coerce(&fig);
            let _: Decimal = Coerce::coerce(&fig);
            let _: DynamicValue = Coerce::coerce(&fig);
            let _: Vec<u8> = Coerce::coerce(&fig);
            let _: FixedString<10> = Coerce::coerce(&fig);
            let _: PackedDecimal<5> = Coerce::coerce(&fig);
        }
    }
}
