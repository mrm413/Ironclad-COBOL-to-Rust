// CobolNum: Space-aware numeric wrapper for COBOL PIC 9 DISPLAY fields.
// Stores i64 with sentinel i64::MIN for "space-filled" state.
// Only used for DISPLAY-usage PIC 9/S9 integer fields.
// COMP/BINARY fields remain as u32/i32/u64/i64.

use crate::CobolToF64;

/// A COBOL DISPLAY-usage numeric field that can hold either a numeric value
/// or a "space-filled" sentinel (from `MOVE SPACE TO group`).
#[derive(Debug, Clone, Copy)]
pub struct CobolNum(pub i64);

impl CobolNum {
    /// The sentinel value representing a space-filled field.
    const SPACE_SENTINEL: i64 = i64::MIN;
    /// Raw byte sentinels: i64::MIN+1 .. i64::MIN+256
    const RAW_BYTE_BASE: i64 = i64::MIN + 1;
    /// Raw multi-byte display sentinels: packs up to 7 raw display bytes into i64.
    /// Encoding: RAW_DISPLAY_BASE + len * 256^7 + b[0]*256^6 + ... + b[6]
    /// where len is 1..=7 and unused trailing bytes are 0.
    const RAW_DISPLAY_BASE: i64 = i64::MIN + 512;
    /// Upper bound for raw display range (exclusive): RAW_DISPLAY_BASE + 8 * 256^7
    const RAW_DISPLAY_END: i64 = Self::RAW_DISPLAY_BASE + 8 * (1i64 << 56);

    /// Check if this field is in "space-filled" state.
    #[inline]
    pub fn is_space(&self) -> bool {
        self.0 == Self::SPACE_SENTINEL
    }

    /// Check if this field holds a raw (non-numeric) byte value.
    #[inline]
    pub fn is_raw_byte(&self) -> bool {
        self.0 >= Self::RAW_BYTE_BASE && self.0 < Self::RAW_BYTE_BASE + 256
    }

    /// Check if this field holds raw multi-byte display data.
    #[inline]
    pub fn is_raw_display(&self) -> bool {
        self.0 >= Self::RAW_DISPLAY_BASE && self.0 < Self::RAW_DISPLAY_END
    }

    /// Get the raw byte value (if in raw byte state).
    #[inline]
    pub fn raw_byte(&self) -> Option<u8> {
        if self.is_raw_byte() { Some((self.0 - Self::RAW_BYTE_BASE) as u8) } else { None }
    }

    /// Get raw display bytes (if in raw display state). Returns (bytes, len).
    #[inline]
    pub fn raw_display_bytes(&self) -> Option<([u8; 7], usize)> {
        if !self.is_raw_display() { return None; }
        let offset = (self.0 - Self::RAW_DISPLAY_BASE) as u64;
        let len = (offset >> 56) as usize; // top byte = length (1..7)
        let packed = offset & 0x00FF_FFFF_FFFF_FFFFu64; // lower 56 bits = 7 bytes
        let mut buf = [0u8; 7];
        for i in 0..7 {
            buf[i] = ((packed >> (48 - i * 8)) & 0xFF) as u8;
        }
        Some((buf, len))
    }

    /// Create a CobolNum from a raw (non-numeric) byte.
    #[inline]
    pub fn from_raw_byte(b: u8) -> Self {
        Self(Self::RAW_BYTE_BASE + b as i64)
    }

    /// Create a CobolNum from raw display bytes (up to 7 bytes).
    /// Used when INITIALIZE with ref-mod creates a non-numeric byte pattern.
    #[inline]
    pub fn from_raw_display(bytes: &[u8]) -> Self {
        let len = bytes.len().min(7);
        if len == 0 { return Self::space(); }
        // First try normal numeric parse
        let s = std::str::from_utf8(bytes).unwrap_or("").trim();
        if let Ok(v) = s.parse::<i64>() {
            return Self(v);
        }
        // All spaces → space sentinel
        if bytes.iter().all(|&b| b == b' ') {
            return Self::space();
        }
        // All same byte → single raw byte sentinel
        if bytes.iter().all(|&b| b == bytes[0]) {
            return Self::from_raw_byte(bytes[0]);
        }
        // Pack into raw display encoding
        let mut packed: u64 = 0;
        for i in 0..7 {
            if i < len {
                packed |= (bytes[i] as u64) << (48 - i * 8);
            }
        }
        let offset = (len as u64) << 56 | packed;
        Self(Self::RAW_DISPLAY_BASE + offset as i64)
    }

    /// Create a space-filled CobolNum.
    #[inline]
    pub fn space() -> Self {
        Self(Self::SPACE_SENTINEL)
    }

    /// Get the numeric value (0 if space-filled, raw byte, or raw display).
    #[inline]
    pub fn val(&self) -> i64 {
        if self.is_space() || self.is_raw_byte() || self.is_raw_display() { 0 } else { self.0 }
    }

    /// Comparison value: returns -1 for space-filled fields (GnuCOBOL treats
    /// spaces in integer DISPLAY as negative due to `byte - '0'` yielding -16).
    /// Non-space sentinels (raw_byte, raw_display) return 0 like val().
    #[inline]
    pub fn cmp_val(&self) -> i64 {
        if self.is_space() { -1 }
        else if self.is_raw_byte() || self.is_raw_display() { 0 }
        else { self.0 }
    }

    /// Compare space-aware integer DISPLAY with a Decimal's scaled value.
    /// GnuCOBOL uses mpz (unsigned) path for cross-type comparison,
    /// causing space bytes to wrap positive via unsigned overflow.
    #[inline]
    pub fn cmp_scaled_decimal(&self, decimal_value: i128, scale_factor: i128) -> i64 {
        if self.is_space() {
            return 1; // space-filled: positive in cross-type decimal comparison
        }
        let v = self.val() as i128; // 0 for other sentinels, normal value otherwise
        let scaled = v.saturating_mul(scale_factor);
        match scaled.cmp(&decimal_value) {
            std::cmp::Ordering::Greater => 1,
            std::cmp::Ordering::Less => -1,
            std::cmp::Ordering::Equal => 0,
        }
    }

    /// Display this CobolNum with a given PIC width.
    /// Handles space-filled (spaces), raw byte (repeated char), raw display (exact bytes),
    /// and numeric (zero-padded).
    pub fn display_with_width(&self, width: usize) -> String {
        if self.is_space() {
            " ".repeat(width)
        } else if let Some(b) = self.raw_byte() {
            std::iter::repeat(b as char).take(width).collect()
        } else if let Some((buf, len)) = self.raw_display_bytes() {
            // Render stored raw bytes, padded/truncated to requested width
            let mut result = String::with_capacity(width);
            for i in 0..width {
                if i < len {
                    result.push(buf[i] as char);
                } else {
                    result.push(' ');
                }
            }
            result
        } else {
            format!("{:0>width$}", self.val(), width = width)
        }
    }

    /// Check if this field is infinite (always false for CobolNum since it's always i64)
    #[inline]
    pub fn is_infinite(&self) -> bool {
        false  // i64 can never be infinite
    }

    /// Check if this field is NaN (always false for CobolNum since it's always i64)
    #[inline]
    pub fn is_nan(&self) -> bool {
        false  // i64 can never be NaN
    }

    /// Parse from DISPLAY bytes. If all spaces, returns space sentinel.
    /// If non-numeric but uniform byte, stores as raw byte.
    pub fn from_display_bytes(bytes: &[u8]) -> Self {
        if bytes.iter().all(|&b| b == b' ') {
            Self::space()
        } else {
            let s = std::str::from_utf8(bytes).unwrap_or("").trim();
            match s.parse::<i64>() {
                Ok(v) => Self(v),
                Err(_) => {
                    // Non-numeric: if all same byte, store as raw byte
                    if !bytes.is_empty() && bytes.iter().all(|&b| b == bytes[0]) {
                        Self::from_raw_byte(bytes[0])
                    } else if bytes.len() <= 7 {
                        // Mixed non-numeric bytes (e.g., from INITIALIZE with ref-mod):
                        // store as raw display bytes
                        Self::from_raw_display(bytes)
                    } else {
                        Self(0)
                    }
                }
            }
        }
    }
}

impl Default for CobolNum {
    fn default() -> Self {
        Self(0)
    }
}

impl From<i64> for CobolNum {
    fn from(v: i64) -> Self { Self(v) }
}

impl From<i32> for CobolNum {
    fn from(v: i32) -> Self { Self(v as i64) }
}

impl From<u32> for CobolNum {
    fn from(v: u32) -> Self { Self(v as i64) }
}

impl From<u64> for CobolNum {
    fn from(v: u64) -> Self { Self(v as i64) }
}

impl From<f64> for CobolNum {
    fn from(v: f64) -> Self { Self(v as i64) }
}

impl PartialEq for CobolNum {
    fn eq(&self, other: &Self) -> bool {
        self.val() == other.val()
    }
}

impl Eq for CobolNum {}

impl std::hash::Hash for CobolNum {
    fn hash<H: std::hash::Hasher>(&self, state: &mut H) {
        self.val().hash(state);
    }
}

impl PartialOrd for CobolNum {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for CobolNum {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        self.val().cmp(&other.val())
    }
}

impl PartialEq<i64> for CobolNum {
    fn eq(&self, other: &i64) -> bool {
        self.val() == *other
    }
}

impl PartialEq<i32> for CobolNum {
    fn eq(&self, other: &i32) -> bool {
        self.val() == *other as i64
    }
}

impl PartialEq<u32> for CobolNum {
    fn eq(&self, other: &u32) -> bool {
        self.val() == *other as i64
    }
}

impl PartialOrd<i64> for CobolNum {
    fn partial_cmp(&self, other: &i64) -> Option<std::cmp::Ordering> {
        Some(self.val().cmp(other))
    }
}

impl PartialEq<CobolNum> for i64 {
    fn eq(&self, other: &CobolNum) -> bool {
        *self == other.val()
    }
}

impl PartialOrd<CobolNum> for i64 {
    fn partial_cmp(&self, other: &CobolNum) -> Option<std::cmp::Ordering> {
        Some(self.cmp(&other.val()))
    }
}

impl PartialOrd<i32> for CobolNum {
    fn partial_cmp(&self, other: &i32) -> Option<std::cmp::Ordering> {
        Some(self.val().cmp(&(*other as i64)))
    }
}

impl PartialOrd<u32> for CobolNum {
    fn partial_cmp(&self, other: &u32) -> Option<std::cmp::Ordering> {
        Some(self.val().cmp(&(*other as i64)))
    }
}

impl std::fmt::Display for CobolNum {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        self.val().fmt(f)
    }
}

impl CobolToF64 for CobolNum {
    fn cobol_to_f64(&self) -> f64 {
        self.val() as f64
    }
}

// Allow parsing from strings (for .parse().unwrap_or_default())
impl std::str::FromStr for CobolNum {
    type Err = std::num::ParseIntError;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        if s.trim().is_empty() || s.bytes().all(|b| b == b' ') {
            Ok(Self::space())
        } else {
            s.trim().parse::<i64>().map(CobolNum)
        }
    }
}

// Into<FixedString> for MOVE numeric → string
impl<const N: usize> From<CobolNum> for crate::FixedString<N> {
    fn from(v: CobolNum) -> Self {
        if v.is_space() {
            Self::new() // all spaces
        } else if let Some(b) = v.raw_byte() {
            Self::from_str(&std::iter::repeat(b as char).take(N).collect::<String>())
        } else {
            Self::from_str(&format!("{}", v.val()))
        }
    }
}

// From<&str> for CobolNum (string → numeric parse)
impl From<&str> for CobolNum {
    fn from(s: &str) -> Self {
        if s.trim().is_empty() || s.bytes().all(|b| b == b' ') {
            Self::space()
        } else {
            Self(s.trim().parse::<i64>().unwrap_or(0))
        }
    }
}

// Arithmetic operations for ADD/SUBTRACT CORRESPONDING
impl std::ops::Add for CobolNum {
    type Output = CobolNum;
    fn add(self, rhs: CobolNum) -> CobolNum {
        CobolNum(self.val() + rhs.val())
    }
}

impl std::ops::Add<i64> for CobolNum {
    type Output = i64;
    fn add(self, rhs: i64) -> i64 {
        self.val() + rhs
    }
}

impl std::ops::Add<CobolNum> for i64 {
    type Output = i64;
    fn add(self, rhs: CobolNum) -> i64 {
        self + rhs.val()
    }
}

impl std::ops::Sub for CobolNum {
    type Output = CobolNum;
    fn sub(self, rhs: CobolNum) -> CobolNum {
        CobolNum(self.val() - rhs.val())
    }
}

impl std::ops::Sub<i64> for CobolNum {
    type Output = i64;
    fn sub(self, rhs: i64) -> i64 {
        self.val() - rhs
    }
}

impl std::ops::Sub<CobolNum> for i64 {
    type Output = i64;
    fn sub(self, rhs: CobolNum) -> i64 {
        self - rhs.val()
    }
}

impl std::ops::AddAssign for CobolNum {
    fn add_assign(&mut self, rhs: CobolNum) {
        *self = CobolNum(self.val() + rhs.val());
    }
}

impl std::ops::AddAssign<i64> for CobolNum {
    fn add_assign(&mut self, rhs: i64) {
        *self = CobolNum(self.val() + rhs);
    }
}

impl std::ops::AddAssign<i32> for CobolNum {
    fn add_assign(&mut self, rhs: i32) {
        *self = CobolNum(self.val() + rhs as i64);
    }
}

impl std::ops::SubAssign for CobolNum {
    fn sub_assign(&mut self, rhs: CobolNum) {
        *self = CobolNum(self.val() - rhs.val());
    }
}

impl std::ops::SubAssign<i64> for CobolNum {
    fn sub_assign(&mut self, rhs: i64) {
        *self = CobolNum(self.val() - rhs);
    }
}

impl std::ops::SubAssign<i32> for CobolNum {
    fn sub_assign(&mut self, rhs: i32) {
        *self = CobolNum(self.val() - rhs as i64);
    }
}

// Mul/Div for COMPUTE expressions
impl std::ops::Mul for CobolNum {
    type Output = CobolNum;
    fn mul(self, rhs: CobolNum) -> CobolNum {
        CobolNum(self.val() * rhs.val())
    }
}

impl std::ops::Mul<i64> for CobolNum {
    type Output = i64;
    fn mul(self, rhs: i64) -> i64 {
        self.val() * rhs
    }
}

impl std::ops::Div for CobolNum {
    type Output = CobolNum;
    fn div(self, rhs: CobolNum) -> CobolNum {
        if rhs.val() == 0 { CobolNum(0) } else { CobolNum(self.val() / rhs.val()) }
    }
}

impl std::ops::Div<i64> for CobolNum {
    type Output = i64;
    fn div(self, rhs: i64) -> i64 {
        if rhs == 0 { 0 } else { self.val() / rhs }
    }
}

impl std::ops::Rem for CobolNum {
    type Output = CobolNum;
    fn rem(self, rhs: CobolNum) -> CobolNum {
        if rhs.val() == 0 { CobolNum(0) } else { CobolNum(self.val() % rhs.val()) }
    }
}

impl std::ops::Neg for CobolNum {
    type Output = CobolNum;
    fn neg(self) -> CobolNum {
        CobolNum(-self.val())
    }
}

// Add/Sub with f32 (for ADD CORRESPONDING mixed types)
impl std::ops::Add<f32> for CobolNum {
    type Output = f32;
    fn add(self, rhs: f32) -> f32 {
        self.val() as f32 + rhs
    }
}

impl std::ops::Add<CobolNum> for f32 {
    type Output = f32;
    fn add(self, rhs: CobolNum) -> f32 {
        self + rhs.val() as f32
    }
}

impl std::ops::Sub<f32> for CobolNum {
    type Output = f32;
    fn sub(self, rhs: f32) -> f32 {
        self.val() as f32 - rhs
    }
}

impl std::ops::Sub<CobolNum> for f32 {
    type Output = f32;
    fn sub(self, rhs: CobolNum) -> f32 {
        self - rhs.val() as f32
    }
}

impl std::ops::Add<f64> for CobolNum {
    type Output = f64;
    fn add(self, rhs: f64) -> f64 {
        self.val() as f64 + rhs
    }
}

impl std::ops::Add<CobolNum> for f64 {
    type Output = f64;
    fn add(self, rhs: CobolNum) -> f64 {
        self + rhs.val() as f64
    }
}

impl std::ops::Sub<f64> for CobolNum {
    type Output = f64;
    fn sub(self, rhs: f64) -> f64 {
        self.val() as f64 - rhs
    }
}

impl std::ops::Sub<CobolNum> for f64 {
    type Output = f64;
    fn sub(self, rhs: CobolNum) -> f64 {
        self - rhs.val() as f64
    }
}

impl std::ops::AddAssign<CobolNum> for f32 {
    fn add_assign(&mut self, rhs: CobolNum) {
        *self += rhs.val() as f32;
    }
}

impl std::ops::SubAssign<CobolNum> for f32 {
    fn sub_assign(&mut self, rhs: CobolNum) {
        *self -= rhs.val() as f32;
    }
}

impl std::ops::AddAssign<CobolNum> for f64 {
    fn add_assign(&mut self, rhs: CobolNum) {
        *self += rhs.val() as f64;
    }
}

impl std::ops::SubAssign<CobolNum> for f64 {
    fn sub_assign(&mut self, rhs: CobolNum) {
        *self -= rhs.val() as f64;
    }
}

impl std::ops::AddAssign<CobolNum> for i64 {
    fn add_assign(&mut self, rhs: CobolNum) {
        *self += rhs.val();
    }
}

impl std::ops::SubAssign<CobolNum> for i64 {
    fn sub_assign(&mut self, rhs: CobolNum) {
        *self -= rhs.val();
    }
}

// i64::from(CobolNum) — for COMPUTE integer expressions
impl From<CobolNum> for i64 {
    fn from(v: CobolNum) -> i64 { v.val() }
}

impl From<CobolNum> for i32 {
    fn from(v: CobolNum) -> i32 { v.val() as i32 }
}

impl From<CobolNum> for u32 {
    fn from(v: CobolNum) -> u32 { v.val() as u32 }
}

impl From<CobolNum> for u64 {
    fn from(v: CobolNum) -> u64 { v.val() as u64 }
}

impl From<CobolNum> for f64 {
    fn from(v: CobolNum) -> f64 { v.val() as f64 }
}

impl From<CobolNum> for f32 {
    fn from(v: CobolNum) -> f32 { v.val() as f32 }
}
