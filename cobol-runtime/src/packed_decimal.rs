// PackedDecimal — COBOL PIC S9(N) COMP-3 equivalent.
// BCD-packed: each digit in 4 bits, sign nibble at end.
// Stored internally as i64 for arithmetic; BCD encoding used only for I/O.

use std::fmt;
use std::ops::{Add, AddAssign, Sub, SubAssign};

/// COMP-3 packed decimal with N total digits.
/// Internally stored as i64 for fast arithmetic.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct PackedDecimal<const N: usize> {
    pub value: i64,
}

impl<const N: usize> PackedDecimal<N> {
    pub const fn zero() -> Self {
        Self { value: 0 }
    }

    pub const fn new(value: i64) -> Self {
        Self { value }
    }

    pub fn value(&self) -> i64 {
        self.value
    }

    /// Encode to BCD bytes (COBOL COMP-3 wire format).
    /// Each byte holds 2 digits, last nibble is sign (C=positive, D=negative).
    pub fn to_bcd(&self) -> Vec<u8> {
        let byte_count = (N + 2) / 2; // N digits + 1 sign nibble, packed 2 per byte
        let mut bytes = vec![0u8; byte_count];
        let abs_val = self.value.unsigned_abs();
        let sign_nibble: u8 = if self.value < 0 { 0x0D } else { 0x0C };

        // Fill digits from right to left
        let mut remaining = abs_val;
        let total_nibbles = N + 1; // digits + sign
        for i in 0..total_nibbles {
            let nibble = if i == 0 {
                sign_nibble & 0x0F
            } else {
                let d = (remaining % 10) as u8;
                remaining /= 10;
                d
            };
            let byte_idx = byte_count - 1 - i / 2;
            if i % 2 == 0 {
                bytes[byte_idx] |= nibble; // low nibble
            } else {
                bytes[byte_idx] |= nibble << 4; // high nibble
            }
        }
        bytes
    }

    /// Create from display-format bytes (for file I/O field parsing).
    /// Parses ASCII digit bytes into the packed value.
    pub fn from_bytes(bytes: &[u8]) -> Self {
        let s = std::str::from_utf8(bytes).unwrap_or("0").trim();
        let v = s.parse::<i64>().unwrap_or(0);
        Self { value: v }
    }

    /// Serialize to display-format bytes (for file I/O field writing).
    /// Returns the value formatted as a right-justified ASCII string.
    pub fn to_bytes(&self) -> Vec<u8> {
        let s = format!("{}", self.value);
        s.into_bytes()
    }

    /// Decode from BCD bytes.
    pub fn from_bcd(bytes: &[u8]) -> Self {
        if bytes.is_empty() {
            return Self::zero();
        }
        let sign_nibble = bytes[bytes.len() - 1] & 0x0F;
        let negative = sign_nibble == 0x0D;

        let mut value: i64 = 0;
        let total_nibbles = bytes.len() * 2;
        // Skip first nibble if odd number of digits (padding)
        let start = if total_nibbles > N + 1 { 1 } else { 0 };

        for i in start..total_nibbles - 1 {
            let byte_idx = i / 2;
            let nibble = if i % 2 == 0 {
                (bytes[byte_idx] >> 4) & 0x0F
            } else {
                bytes[byte_idx] & 0x0F
            };
            value = value * 10 + nibble as i64;
        }

        if negative { value = -value; }
        Self { value }
    }
}

impl<const N: usize> Default for PackedDecimal<N> {
    fn default() -> Self {
        Self::zero()
    }
}

impl<const N: usize> From<i64> for PackedDecimal<N> {
    fn from(v: i64) -> Self {
        Self::new(v)
    }
}

impl<const N: usize> From<i32> for PackedDecimal<N> {
    fn from(v: i32) -> Self {
        Self::new(v as i64)
    }
}

impl<const N: usize> Add<i64> for PackedDecimal<N> {
    type Output = Self;
    fn add(self, rhs: i64) -> Self {
        Self { value: self.value + rhs }
    }
}

impl<const N: usize> AddAssign<i64> for PackedDecimal<N> {
    fn add_assign(&mut self, rhs: i64) {
        self.value += rhs;
    }
}

impl<const N: usize> Sub<i64> for PackedDecimal<N> {
    type Output = Self;
    fn sub(self, rhs: i64) -> Self {
        Self { value: self.value - rhs }
    }
}

impl<const N: usize> SubAssign<i64> for PackedDecimal<N> {
    fn sub_assign(&mut self, rhs: i64) {
        self.value -= rhs;
    }
}

impl<const N: usize> PartialEq<i64> for PackedDecimal<N> {
    fn eq(&self, other: &i64) -> bool {
        self.value == *other
    }
}

impl<const N: usize> PartialOrd<i64> for PackedDecimal<N> {
    fn partial_cmp(&self, other: &i64) -> Option<std::cmp::Ordering> {
        self.value.partial_cmp(other)
    }
}

// PackedDecimal<N> self-ops (same-size arithmetic)
impl<const N: usize> Add<PackedDecimal<N>> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn add(self, rhs: PackedDecimal<N>) -> PackedDecimal<N> { PackedDecimal { value: self.value + rhs.value } }
}
impl<const N: usize> Sub<PackedDecimal<N>> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn sub(self, rhs: PackedDecimal<N>) -> PackedDecimal<N> { PackedDecimal { value: self.value - rhs.value } }
}
impl<const N: usize> std::ops::Mul<PackedDecimal<N>> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn mul(self, rhs: PackedDecimal<N>) -> PackedDecimal<N> { PackedDecimal { value: self.value * rhs.value } }
}
impl<const N: usize> std::ops::Div<PackedDecimal<N>> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn div(self, rhs: PackedDecimal<N>) -> PackedDecimal<N> {
        PackedDecimal { value: if rhs.value != 0 { self.value / rhs.value } else { 0 } }
    }
}
impl<const N: usize> AddAssign<PackedDecimal<N>> for PackedDecimal<N> {
    fn add_assign(&mut self, rhs: PackedDecimal<N>) { self.value += rhs.value; }
}
impl<const N: usize> SubAssign<PackedDecimal<N>> for PackedDecimal<N> {
    fn sub_assign(&mut self, rhs: PackedDecimal<N>) { self.value -= rhs.value; }
}
impl<const N: usize> std::ops::MulAssign<PackedDecimal<N>> for PackedDecimal<N> {
    fn mul_assign(&mut self, rhs: PackedDecimal<N>) { self.value *= rhs.value; }
}
impl<const N: usize> std::ops::DivAssign<PackedDecimal<N>> for PackedDecimal<N> {
    fn div_assign(&mut self, rhs: PackedDecimal<N>) { if rhs.value != 0 { self.value /= rhs.value; } }
}

// AddAssign/SubAssign for i64 with PackedDecimal (COBOL ADD/SUB cross-type)
impl<const N: usize> AddAssign<PackedDecimal<N>> for i64 {
    fn add_assign(&mut self, rhs: PackedDecimal<N>) { *self += rhs.value; }
}
impl<const N: usize> SubAssign<PackedDecimal<N>> for i64 {
    fn sub_assign(&mut self, rhs: PackedDecimal<N>) { *self -= rhs.value; }
}
impl<const N: usize> Add<PackedDecimal<N>> for i64 {
    type Output = i64;
    fn add(self, rhs: PackedDecimal<N>) -> i64 { self + rhs.value }
}
impl<const N: usize> Sub<PackedDecimal<N>> for i64 {
    type Output = i64;
    fn sub(self, rhs: PackedDecimal<N>) -> i64 { self - rhs.value }
}
// i32 cross-type ops with PackedDecimal
impl<const N: usize> AddAssign<PackedDecimal<N>> for i32 {
    fn add_assign(&mut self, rhs: PackedDecimal<N>) { *self = (*self as i64 + rhs.value) as i32; }
}
impl<const N: usize> SubAssign<PackedDecimal<N>> for i32 {
    fn sub_assign(&mut self, rhs: PackedDecimal<N>) { *self = (*self as i64 - rhs.value) as i32; }
}
// u32 cross-type ops
impl<const N: usize> AddAssign<PackedDecimal<N>> for u32 {
    fn add_assign(&mut self, rhs: PackedDecimal<N>) { *self = (*self as i64 + rhs.value) as u32; }
}
impl<const N: usize> SubAssign<PackedDecimal<N>> for u32 {
    fn sub_assign(&mut self, rhs: PackedDecimal<N>) { *self = (*self as i64 - rhs.value) as u32; }
}
// PartialEq for i32/u32 with PackedDecimal
impl<const N: usize> PartialEq<PackedDecimal<N>> for i64 {
    fn eq(&self, other: &PackedDecimal<N>) -> bool { *self == other.value }
}
impl<const N: usize> PartialEq<PackedDecimal<N>> for i32 {
    fn eq(&self, other: &PackedDecimal<N>) -> bool { *self as i64 == other.value }
}
impl<const N: usize> PartialEq<PackedDecimal<N>> for u32 {
    fn eq(&self, other: &PackedDecimal<N>) -> bool { *self as i64 == other.value }
}
impl<const N: usize> PartialOrd<PackedDecimal<N>> for i64 {
    fn partial_cmp(&self, other: &PackedDecimal<N>) -> Option<std::cmp::Ordering> { self.partial_cmp(&other.value) }
}
impl<const N: usize> PartialEq<i32> for PackedDecimal<N> {
    fn eq(&self, other: &i32) -> bool { self.value == *other as i64 }
}
impl<const N: usize> PartialEq<u32> for PackedDecimal<N> {
    fn eq(&self, other: &u32) -> bool { self.value == *other as i64 }
}
impl<const N: usize> PartialOrd<i32> for PackedDecimal<N> {
    fn partial_cmp(&self, other: &i32) -> Option<std::cmp::Ordering> { self.value.partial_cmp(&(*other as i64)) }
}
impl<const N: usize> PartialOrd<u32> for PackedDecimal<N> {
    fn partial_cmp(&self, other: &u32) -> Option<std::cmp::Ordering> { self.value.partial_cmp(&(*other as i64)) }
}
// PackedDecimal ↔ Decimal PartialEq
impl<const N: usize> PartialEq<crate::Decimal> for PackedDecimal<N> {
    fn eq(&self, other: &crate::Decimal) -> bool { self.value == i64::from(*other) }
}
// Mul/Div for PackedDecimal
impl<const N: usize> std::ops::Mul<i64> for PackedDecimal<N> {
    type Output = Self;
    fn mul(self, rhs: i64) -> Self { Self { value: self.value * rhs } }
}
impl<const N: usize> std::ops::Div<i64> for PackedDecimal<N> {
    type Output = Self;
    fn div(self, rhs: i64) -> Self { Self { value: if rhs != 0 { self.value / rhs } else { 0 } } }
}
impl<const N: usize> std::ops::MulAssign<i64> for PackedDecimal<N> {
    fn mul_assign(&mut self, rhs: i64) { self.value *= rhs; }
}

// From/Into for more numeric types
impl<const N: usize> From<u32> for PackedDecimal<N> {
    fn from(v: u32) -> Self { Self::new(v as i64) }
}

impl<const N: usize> From<u64> for PackedDecimal<N> {
    fn from(v: u64) -> Self { Self::new(v as i64) }
}

impl<const N: usize> From<f64> for PackedDecimal<N> {
    fn from(v: f64) -> Self { Self::new(v.round() as i64) }
}

impl<const N: usize> From<f32> for PackedDecimal<N> {
    fn from(v: f32) -> Self { Self::new(v.round() as i64) }
}

impl<const N: usize> From<PackedDecimal<N>> for i64 {
    fn from(d: PackedDecimal<N>) -> i64 { d.value }
}

impl<const N: usize> From<PackedDecimal<N>> for i32 {
    fn from(d: PackedDecimal<N>) -> i32 { d.value as i32 }
}

impl<const N: usize> From<PackedDecimal<N>> for u32 {
    fn from(d: PackedDecimal<N>) -> u32 { d.value as u32 }
}

// From PackedDecimal for FixedString (numeric display)
impl<const N: usize, const M: usize> From<PackedDecimal<N>> for crate::FixedString<M> {
    fn from(d: PackedDecimal<N>) -> Self {
        Self::from_cobol_str(&d.value.to_string())
    }
}

// From Decimal for FixedString
impl<const N: usize> From<crate::Decimal> for crate::FixedString<N> {
    fn from(d: crate::Decimal) -> Self {
        Self::from_cobol_str(&format!("{}", d))
    }
}

// PartialEq<f32/f64> for PackedDecimal
impl<const N: usize> PartialEq<f64> for PackedDecimal<N> {
    fn eq(&self, other: &f64) -> bool { (self.value as f64) == *other }
}

impl<const N: usize> PartialEq<f32> for PackedDecimal<N> {
    fn eq(&self, other: &f32) -> bool { (self.value as f32) == *other }
}

// Decimal ↔ PackedDecimal reverse
impl<const N: usize> PartialEq<PackedDecimal<N>> for crate::Decimal {
    fn eq(&self, other: &PackedDecimal<N>) -> bool { i64::from(*self) == other.value() }
}

// Div for integer types with PackedDecimal
impl<const N: usize> std::ops::Div<PackedDecimal<N>> for i64 {
    type Output = i64;
    fn div(self, rhs: PackedDecimal<N>) -> i64 { let v = rhs.value(); if v != 0 { self / v } else { 0 } }
}
impl<const N: usize> std::ops::Mul<PackedDecimal<N>> for i64 {
    type Output = i64;
    fn mul(self, rhs: PackedDecimal<N>) -> i64 { self * rhs.value() }
}

// Add/Sub/Mul for i32 types with PackedDecimal
impl<const N: usize> std::ops::Add<PackedDecimal<N>> for i32 {
    type Output = i32;
    fn add(self, rhs: PackedDecimal<N>) -> i32 { self + rhs.value() as i32 }
}
impl<const N: usize> std::ops::Sub<PackedDecimal<N>> for i32 {
    type Output = i32;
    fn sub(self, rhs: PackedDecimal<N>) -> i32 { self - rhs.value() as i32 }
}
impl<const N: usize> std::ops::Mul<PackedDecimal<N>> for i32 {
    type Output = i32;
    fn mul(self, rhs: PackedDecimal<N>) -> i32 { self * rhs.value() as i32 }
}
impl<const N: usize> std::ops::Div<PackedDecimal<N>> for i32 {
    type Output = i32;
    fn div(self, rhs: PackedDecimal<N>) -> i32 { let v = rhs.value() as i32; if v != 0 { self / v } else { 0 } }
}

// PackedDecimal ↔ FixedString comparisons
impl<const N: usize, const M: usize> PartialEq<crate::FixedString<M>> for PackedDecimal<N> {
    fn eq(&self, other: &crate::FixedString<M>) -> bool {
        if let Ok(v) = other.trimmed().parse::<i64>() { self.value == v } else { false }
    }
}

// PackedDecimal ops with u32/i32
impl<const N: usize> std::ops::Add<u32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn add(self, rhs: u32) -> PackedDecimal<N> { PackedDecimal::new(self.value + rhs as i64) }
}
impl<const N: usize> std::ops::Sub<u32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn sub(self, rhs: u32) -> PackedDecimal<N> { PackedDecimal::new(self.value - rhs as i64) }
}
impl<const N: usize> std::ops::Mul<u32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn mul(self, rhs: u32) -> PackedDecimal<N> { PackedDecimal::new(self.value * rhs as i64) }
}
impl<const N: usize> std::ops::Div<u32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn div(self, rhs: u32) -> PackedDecimal<N> { PackedDecimal::new(if rhs != 0 { self.value / rhs as i64 } else { 0 }) }
}
impl<const N: usize> std::ops::Add<i32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn add(self, rhs: i32) -> PackedDecimal<N> { PackedDecimal::new(self.value + rhs as i64) }
}
impl<const N: usize> std::ops::Sub<i32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn sub(self, rhs: i32) -> PackedDecimal<N> { PackedDecimal::new(self.value - rhs as i64) }
}
impl<const N: usize> std::ops::Mul<i32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn mul(self, rhs: i32) -> PackedDecimal<N> { PackedDecimal::new(self.value * rhs as i64) }
}
impl<const N: usize> std::ops::Div<i32> for PackedDecimal<N> {
    type Output = PackedDecimal<N>;
    fn div(self, rhs: i32) -> PackedDecimal<N> { PackedDecimal::new(if rhs != 0 { self.value / rhs as i64 } else { 0 }) }
}
// Compound-assign with i32/u32/f64
impl<const N: usize> std::ops::AddAssign<i32> for PackedDecimal<N> {
    fn add_assign(&mut self, rhs: i32) { self.value += rhs as i64; }
}
impl<const N: usize> std::ops::SubAssign<i32> for PackedDecimal<N> {
    fn sub_assign(&mut self, rhs: i32) { self.value -= rhs as i64; }
}
impl<const N: usize> std::ops::MulAssign<i32> for PackedDecimal<N> {
    fn mul_assign(&mut self, rhs: i32) { self.value *= rhs as i64; }
}
impl<const N: usize> std::ops::AddAssign<u32> for PackedDecimal<N> {
    fn add_assign(&mut self, rhs: u32) { self.value += rhs as i64; }
}
impl<const N: usize> std::ops::SubAssign<u32> for PackedDecimal<N> {
    fn sub_assign(&mut self, rhs: u32) { self.value -= rhs as i64; }
}
impl<const N: usize> std::ops::MulAssign<u32> for PackedDecimal<N> {
    fn mul_assign(&mut self, rhs: u32) { self.value *= rhs as i64; }
}
impl<const N: usize> std::ops::AddAssign<f64> for PackedDecimal<N> {
    fn add_assign(&mut self, rhs: f64) { self.value += rhs.round() as i64; }
}
impl<const N: usize> std::ops::SubAssign<f64> for PackedDecimal<N> {
    fn sub_assign(&mut self, rhs: f64) { self.value -= rhs.round() as i64; }
}

impl<const N: usize> fmt::Display for PackedDecimal<N> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.value)
    }
}

impl<const N: usize> fmt::Debug for PackedDecimal<N> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "PackedDecimal<{}>({})", N, self.value)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_zero() {
        let d: PackedDecimal<9> = PackedDecimal::zero();
        assert_eq!(d.value(), 0);
    }

    #[test]
    fn test_arithmetic() {
        let mut d: PackedDecimal<9> = PackedDecimal::new(0);
        d += 5;
        assert_eq!(d.value(), 5);
        d += 3;
        assert_eq!(d.value(), 8);
        d -= 2;
        assert_eq!(d.value(), 6);
    }

    #[test]
    fn test_comparison() {
        let d: PackedDecimal<9> = PackedDecimal::new(10);
        assert!(d > 5);
        assert!(d == 10);
        assert!(d < 20);
    }

    #[test]
    fn test_bcd_roundtrip() {
        let original: PackedDecimal<9> = PackedDecimal::new(12345);
        let bcd = original.to_bcd();
        let decoded: PackedDecimal<9> = PackedDecimal::from_bcd(&bcd);
        assert_eq!(original, decoded);
    }

    #[test]
    fn test_bcd_negative() {
        let original: PackedDecimal<9> = PackedDecimal::new(-9876);
        let bcd = original.to_bcd();
        let decoded: PackedDecimal<9> = PackedDecimal::from_bcd(&bcd);
        assert_eq!(original, decoded);
    }

    #[test]
    fn test_default() {
        let d: PackedDecimal<9> = Default::default();
        assert_eq!(d.value(), 0);
    }

    #[test]
    fn test_display() {
        let d: PackedDecimal<9> = PackedDecimal::new(42);
        assert_eq!(format!("{}", d), "42");
    }
}
