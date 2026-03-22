// Decimal<P, S> — COBOL PIC S9(P)V9(S) fixed-point decimal.
// Exact arithmetic with no floating-point errors. Stored as scaled integer.

use std::fmt;

/// Fixed-point decimal with P integer digits and S fractional digits.
/// Internally stored as i64 scaled by 10^S.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Decimal {
    /// Scaled integer value: actual = value / 10^scale
    pub value: i64,
    /// Number of fractional digits
    pub scale: u8,
}

impl Decimal {
    pub const fn zero(scale: u8) -> Self {
        Self { value: 0, scale }
    }

    pub fn new(integer: i64, fraction: u64, scale: u8) -> Self {
        let factor = 10i64.pow(scale as u32);
        let value = integer * factor + fraction as i64 * integer.signum().max(1);
        Self { value, scale }
    }

    pub fn from_i64(value: i64, scale: u8) -> Self {
        let factor = 10i64.pow(scale as u32);
        Self { value: value * factor, scale }
    }

    pub fn to_f64(self) -> f64 {
        self.value as f64 / 10f64.powi(self.scale as i32)
    }

    pub fn raw_value(self) -> i64 { self.value }

    /// Create from display-format bytes (for file I/O field parsing).
    pub fn from_bytes(bytes: &[u8], scale: u8) -> Self {
        let s = std::str::from_utf8(bytes).unwrap_or("0").trim();
        if let Ok(f) = s.parse::<f64>() {
            let factor = 10f64.powi(scale as i32);
            Self { value: (f * factor).round() as i64, scale }
        } else {
            Self::zero(scale)
        }
    }

    /// Serialize to display-format bytes (for file I/O field writing).
    pub fn to_bytes(&self) -> Vec<u8> {
        if self.scale == 0 {
            format!("{}", self.value).into_bytes()
        } else {
            let factor = 10f64.powi(self.scale as i32);
            format!("{:.prec$}", self.value as f64 / factor, prec = self.scale as usize).into_bytes()
        }
    }

    /// Align rhs to self's scale, returning the adjusted raw value
    fn align_scales(self, rhs: Self) -> i64 {
        if self.scale == rhs.scale {
            rhs.value
        } else if self.scale > rhs.scale {
            rhs.value * 10i64.pow((self.scale - rhs.scale) as u32)
        } else {
            rhs.value / 10i64.pow((rhs.scale - self.scale) as u32)
        }
    }

    pub fn add(self, other: Self) -> Self {
        assert_eq!(self.scale, other.scale, "Decimal scale mismatch");
        Self { value: self.value + other.value, scale: self.scale }
    }

    pub fn sub(self, other: Self) -> Self {
        assert_eq!(self.scale, other.scale, "Decimal scale mismatch");
        Self { value: self.value - other.value, scale: self.scale }
    }

    pub fn mul(self, other: Self) -> Self {
        let product = self.value * other.value;
        // Rescale to self.scale
        let factor = 10i64.pow(other.scale as u32);
        Self { value: product / factor, scale: self.scale }
    }

    pub fn div(self, other: Self) -> Self {
        if other.value == 0 { return Self::zero(self.scale); }
        // Scale up numerator to preserve precision, then divide
        let factor = 10i64.pow(other.scale as u32);
        Self { value: (self.value * factor) / other.value, scale: self.scale }
    }
}

// Decimal ↔ Decimal operator traits
impl std::ops::Add<Decimal> for Decimal {
    type Output = Decimal;
    fn add(self, rhs: Decimal) -> Decimal {
        let r = self.align_scales(rhs);
        Decimal { value: self.value + r, scale: self.scale }
    }
}
impl std::ops::Sub<Decimal> for Decimal {
    type Output = Decimal;
    fn sub(self, rhs: Decimal) -> Decimal {
        let r = self.align_scales(rhs);
        Decimal { value: self.value - r, scale: self.scale }
    }
}
impl std::ops::Mul<Decimal> for Decimal {
    type Output = Decimal;
    fn mul(self, rhs: Decimal) -> Decimal {
        let product = self.value * rhs.value;
        let factor = 10i64.pow(rhs.scale as u32);
        Decimal { value: product / factor, scale: self.scale }
    }
}
impl std::ops::Div<Decimal> for Decimal {
    type Output = Decimal;
    fn div(self, rhs: Decimal) -> Decimal {
        if rhs.value == 0 { return Decimal::zero(self.scale); }
        let factor = 10i64.pow(rhs.scale as u32);
        Decimal { value: (self.value * factor) / rhs.value, scale: self.scale }
    }
}
impl std::ops::AddAssign<Decimal> for Decimal {
    fn add_assign(&mut self, rhs: Decimal) {
        let r = self.align_scales(rhs);
        self.value += r;
    }
}
impl std::ops::SubAssign<Decimal> for Decimal {
    fn sub_assign(&mut self, rhs: Decimal) {
        let r = self.align_scales(rhs);
        self.value -= r;
    }
}
impl std::ops::MulAssign<Decimal> for Decimal {
    fn mul_assign(&mut self, rhs: Decimal) {
        self.value = self.value * rhs.value / 10i64.pow(rhs.scale as u32);
    }
}
impl std::ops::DivAssign<Decimal> for Decimal {
    fn div_assign(&mut self, rhs: Decimal) {
        if rhs.value != 0 {
            self.value = (self.value * 10i64.pow(rhs.scale as u32)) / rhs.value;
        }
    }
}

impl Default for Decimal {
    fn default() -> Self {
        Self::zero(0)
    }
}

impl From<i64> for Decimal {
    fn from(value: i64) -> Self {
        Self { value: value, scale: 0 }
    }
}

impl From<i32> for Decimal {
    fn from(value: i32) -> Self {
        Self { value: value as i64, scale: 0 }
    }
}

impl From<f64> for Decimal {
    fn from(value: f64) -> Self {
        // Default to 2 decimal places for float conversion
        let scale = 2u8;
        let factor = 10i64.pow(scale as u32);
        Self { value: (value * factor as f64).round() as i64, scale }
    }
}

impl From<f32> for Decimal {
    fn from(value: f32) -> Self {
        Self::from(value as f64)
    }
}

impl From<u32> for Decimal {
    fn from(value: u32) -> Self {
        Self { value: value as i64, scale: 0 }
    }
}

impl From<u64> for Decimal {
    fn from(value: u64) -> Self {
        Self { value: value as i64, scale: 0 }
    }
}

impl From<Decimal> for i64 {
    fn from(d: Decimal) -> i64 {
        if d.scale == 0 { d.value } else { d.value / 10i64.pow(d.scale as u32) }
    }
}

impl From<Decimal> for i32 {
    fn from(d: Decimal) -> i32 {
        let val: i64 = d.into();
        val as i32
    }
}

impl From<Decimal> for u32 {
    fn from(d: Decimal) -> u32 {
        let val: i64 = d.into();
        val as u32
    }
}

impl From<Decimal> for f64 {
    fn from(d: Decimal) -> f64 {
        d.to_f64()
    }
}

// AddAssign / SubAssign for numeric types
impl std::ops::AddAssign<Decimal> for i32 {
    fn add_assign(&mut self, rhs: Decimal) {
        *self += i32::from(rhs);
    }
}

impl std::ops::AddAssign<Decimal> for u32 {
    fn add_assign(&mut self, rhs: Decimal) {
        let val = i64::from(rhs);
        *self = (*self as i64 + val) as u32;
    }
}

impl std::ops::SubAssign<Decimal> for i32 {
    fn sub_assign(&mut self, rhs: Decimal) {
        *self -= i32::from(rhs);
    }
}

impl std::ops::SubAssign<Decimal> for u32 {
    fn sub_assign(&mut self, rhs: Decimal) {
        let val = i64::from(rhs);
        *self = (*self as i64 - val) as u32;
    }
}

impl std::ops::AddAssign<Decimal> for i64 {
    fn add_assign(&mut self, rhs: Decimal) {
        *self += i64::from(rhs);
    }
}

impl std::ops::SubAssign<Decimal> for i64 {
    fn sub_assign(&mut self, rhs: Decimal) {
        *self -= i64::from(rhs);
    }
}

// Add/Sub Decimal for integer types (COBOL COMPUTE cross-type arithmetic)
impl std::ops::Add<Decimal> for i64 {
    type Output = i64;
    fn add(self, rhs: Decimal) -> i64 { self + i64::from(rhs) }
}
impl std::ops::Sub<Decimal> for i64 {
    type Output = i64;
    fn sub(self, rhs: Decimal) -> i64 { self - i64::from(rhs) }
}
impl std::ops::Mul<Decimal> for i64 {
    type Output = i64;
    fn mul(self, rhs: Decimal) -> i64 { self * i64::from(rhs) }
}
impl std::ops::Div<Decimal> for i64 {
    type Output = i64;
    fn div(self, rhs: Decimal) -> i64 { let v = i64::from(rhs); if v != 0 { self / v } else { 0 } }
}
impl std::ops::Mul<Decimal> for u32 {
    type Output = u32;
    fn mul(self, rhs: Decimal) -> u32 { (self as i64 * i64::from(rhs)) as u32 }
}
// Decimal ops with integer RHS
impl std::ops::Add<i64> for Decimal {
    type Output = Decimal;
    fn add(self, rhs: i64) -> Decimal { Decimal { value: self.value + rhs * 10i64.pow(self.scale as u32), scale: self.scale } }
}
impl std::ops::Sub<i64> for Decimal {
    type Output = Decimal;
    fn sub(self, rhs: i64) -> Decimal { Decimal { value: self.value - rhs * 10i64.pow(self.scale as u32), scale: self.scale } }
}
impl std::ops::AddAssign<i64> for Decimal {
    fn add_assign(&mut self, rhs: i64) { self.value += rhs * 10i64.pow(self.scale as u32); }
}
impl std::ops::SubAssign<i64> for Decimal {
    fn sub_assign(&mut self, rhs: i64) { self.value -= rhs * 10i64.pow(self.scale as u32); }
}
impl std::ops::Mul<i64> for Decimal {
    type Output = Decimal;
    fn mul(self, rhs: i64) -> Decimal { Decimal { value: self.value * rhs, scale: self.scale } }
}
impl std::ops::MulAssign<i64> for Decimal {
    fn mul_assign(&mut self, rhs: i64) { self.value *= rhs; }
}
impl std::ops::Div<i64> for Decimal {
    type Output = Decimal;
    fn div(self, rhs: i64) -> Decimal { Decimal { value: if rhs != 0 { self.value / rhs } else { 0 }, scale: self.scale } }
}
// PartialOrd<Decimal> for integer types
impl PartialOrd<Decimal> for i64 {
    fn partial_cmp(&self, other: &Decimal) -> Option<std::cmp::Ordering> { self.partial_cmp(&i64::from(*other)) }
}
impl PartialOrd<Decimal> for i32 {
    fn partial_cmp(&self, other: &Decimal) -> Option<std::cmp::Ordering> { self.partial_cmp(&i32::from(*other)) }
}

// PartialEq<Decimal> for numeric types
impl PartialEq<Decimal> for i32 {
    fn eq(&self, other: &Decimal) -> bool { *self == i32::from(*other) }
}

impl PartialEq<Decimal> for u32 {
    fn eq(&self, other: &Decimal) -> bool { *self as i64 == i64::from(*other) }
}

impl PartialEq<Decimal> for i64 {
    fn eq(&self, other: &Decimal) -> bool { *self == i64::from(*other) }
}

// Additional cross-type comparisons
impl PartialEq<Decimal> for f64 {
    fn eq(&self, other: &Decimal) -> bool { *self == other.to_f64() }
}

impl PartialOrd<Decimal> for f64 {
    fn partial_cmp(&self, other: &Decimal) -> Option<std::cmp::Ordering> { self.partial_cmp(&other.to_f64()) }
}

impl PartialEq<f64> for Decimal {
    fn eq(&self, other: &f64) -> bool { self.to_f64() == *other }
}

impl PartialOrd<f64> for Decimal {
    fn partial_cmp(&self, other: &f64) -> Option<std::cmp::Ordering> { self.to_f64().partial_cmp(other) }
}

impl PartialEq<i64> for Decimal {
    fn eq(&self, other: &i64) -> bool { i64::from(*self) == *other }
}

impl PartialOrd<i64> for Decimal {
    fn partial_cmp(&self, other: &i64) -> Option<std::cmp::Ordering> { i64::from(*self).partial_cmp(other) }
}

impl PartialEq<i32> for Decimal {
    fn eq(&self, other: &i32) -> bool { i32::from(*self) == *other }
}

impl PartialEq<u32> for Decimal {
    fn eq(&self, other: &u32) -> bool { i64::from(*self) == *other as i64 }
}

impl PartialOrd<u32> for Decimal {
    fn partial_cmp(&self, other: &u32) -> Option<std::cmp::Ordering> { i64::from(*self).partial_cmp(&(*other as i64)) }
}

impl PartialOrd<Decimal> for u32 {
    fn partial_cmp(&self, other: &Decimal) -> Option<std::cmp::Ordering> { (*self as i64).partial_cmp(&i64::from(*other)) }
}

// Decimal ↔ &str comparisons (COBOL compares numeric to alphanumeric)
impl PartialEq<&str> for Decimal {
    fn eq(&self, other: &&str) -> bool {
        if let Ok(v) = other.trim().parse::<f64>() { self.to_f64() == v } else { false }
    }
}

impl PartialOrd<&str> for Decimal {
    fn partial_cmp(&self, other: &&str) -> Option<std::cmp::Ordering> {
        if let Ok(v) = other.trim().parse::<f64>() { self.to_f64().partial_cmp(&v) } else { None }
    }
}

// Decimal ↔ i32 ops
impl std::ops::Add<i32> for Decimal {
    type Output = Decimal;
    fn add(self, rhs: i32) -> Decimal { self + (rhs as i64) }
}
impl std::ops::Sub<i32> for Decimal {
    type Output = Decimal;
    fn sub(self, rhs: i32) -> Decimal { self - (rhs as i64) }
}
impl std::ops::Mul<i32> for Decimal {
    type Output = Decimal;
    fn mul(self, rhs: i32) -> Decimal { self * (rhs as i64) }
}
impl std::ops::Div<i32> for Decimal {
    type Output = Decimal;
    fn div(self, rhs: i32) -> Decimal { self / (rhs as i64) }
}
impl std::ops::AddAssign<i32> for Decimal {
    fn add_assign(&mut self, rhs: i32) { *self += rhs as i64; }
}
impl std::ops::SubAssign<i32> for Decimal {
    fn sub_assign(&mut self, rhs: i32) { *self -= rhs as i64; }
}

// Decimal ↔ u32 ops
impl std::ops::Add<u32> for Decimal {
    type Output = Decimal;
    fn add(self, rhs: u32) -> Decimal { self + (rhs as i64) }
}
impl std::ops::Sub<u32> for Decimal {
    type Output = Decimal;
    fn sub(self, rhs: u32) -> Decimal { self - (rhs as i64) }
}
impl std::ops::Mul<u32> for Decimal {
    type Output = Decimal;
    fn mul(self, rhs: u32) -> Decimal { self * (rhs as i64) }
}
impl std::ops::AddAssign<u32> for Decimal {
    fn add_assign(&mut self, rhs: u32) { *self += rhs as i64; }
}
impl std::ops::SubAssign<u32> for Decimal {
    fn sub_assign(&mut self, rhs: u32) { *self -= rhs as i64; }
}

impl std::ops::MulAssign<i32> for Decimal {
    fn mul_assign(&mut self, rhs: i32) { *self *= rhs as i64; }
}
impl std::ops::MulAssign<u32> for Decimal {
    fn mul_assign(&mut self, rhs: u32) { *self *= rhs as i64; }
}
impl std::ops::DivAssign<i32> for Decimal {
    fn div_assign(&mut self, rhs: i32) { if rhs != 0 { self.value /= rhs as i64; } }
}
impl std::ops::DivAssign<i64> for Decimal {
    fn div_assign(&mut self, rhs: i64) { if rhs != 0 { self.value /= rhs; } }
}
impl std::ops::AddAssign<f64> for Decimal {
    fn add_assign(&mut self, rhs: f64) { self.value += (rhs * 10f64.powi(self.scale as i32)).round() as i64; }
}
impl std::ops::SubAssign<f64> for Decimal {
    fn sub_assign(&mut self, rhs: f64) { self.value -= (rhs * 10f64.powi(self.scale as i32)).round() as i64; }
}

// NOTE: Cross-type integer arithmetic (i32 += u32 etc.) cannot be implemented here
// due to Rust's orphan rule. The emitter must generate explicit casts instead.

// Decimal ↔ FixedString comparisons (COBOL allows numeric vs alphanumeric)
impl<const N: usize> PartialEq<crate::FixedString<N>> for Decimal {
    fn eq(&self, other: &crate::FixedString<N>) -> bool {
        if let Ok(v) = other.trimmed().parse::<f64>() { self.to_f64() == v } else { false }
    }
}
impl<const N: usize> PartialOrd<crate::FixedString<N>> for Decimal {
    fn partial_cmp(&self, other: &crate::FixedString<N>) -> Option<std::cmp::Ordering> {
        if let Ok(v) = other.trimmed().parse::<f64>() { self.to_f64().partial_cmp(&v) } else { None }
    }
}
impl<const N: usize> PartialEq<Decimal> for crate::FixedString<N> {
    fn eq(&self, other: &Decimal) -> bool {
        if let Ok(v) = self.trimmed().parse::<f64>() { v == other.to_f64() } else { false }
    }
}
impl fmt::Display for Decimal {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        if self.scale == 0 {
            write!(f, "{}", self.value)
        } else {
            let factor = 10i64.pow(self.scale as u32);
            let int_part = self.value / factor;
            let frac_part = (self.value % factor).unsigned_abs();
            write!(f, "{}.{:0>width$}", int_part, frac_part, width = self.scale as usize)
        }
    }
}

impl fmt::Debug for Decimal {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Decimal({}, scale={})", self, self.scale)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_zero() {
        let d = Decimal::zero(2);
        assert_eq!(format!("{}", d), "0.00");
    }

    #[test]
    fn test_from_i64() {
        let d = Decimal::from_i64(42, 2);
        assert_eq!(format!("{}", d), "42.00");
    }

    #[test]
    fn test_add() {
        let a = Decimal::from_i64(10, 2);
        let b = Decimal::from_i64(5, 2);
        assert_eq!(format!("{}", a.add(b)), "15.00");
    }

    #[test]
    fn test_sub() {
        let a = Decimal::from_i64(10, 2);
        let b = Decimal::from_i64(3, 2);
        assert_eq!(format!("{}", a.sub(b)), "7.00");
    }

    #[test]
    fn test_exact_decimal() {
        // 0.1 + 0.2 must equal 0.3 exactly (unlike floating point)
        let a = Decimal { value: 10, scale: 2 }; // 0.10
        let b = Decimal { value: 20, scale: 2 }; // 0.20
        let c = a.add(b);
        assert_eq!(c.value, 30); // 0.30 exactly
    }
}
