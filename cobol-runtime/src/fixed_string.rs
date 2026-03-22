// FixedString<N> — COBOL PIC X(N) equivalent.
// Carried over from Cobol2Rust but with const fn support.

use std::fmt;

#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
pub struct FixedString<const N: usize> {
    data: [u8; N],
}

impl<const N: usize> FixedString<N> {
    pub const fn new() -> Self {
        Self { data: [b' '; N] }
    }

    pub fn from_str(s: &str) -> Self {
        let mut data = [b' '; N];
        let bytes = s.as_bytes();
        let copy_len = bytes.len().min(N);
        data[..copy_len].copy_from_slice(&bytes[..copy_len]);
        Self { data }
    }

    pub fn as_str(&self) -> &str {
        std::str::from_utf8(&self.data).unwrap_or("")
    }

    pub fn trimmed(&self) -> &str {
        self.as_str().trim_end()
    }

    pub fn len(&self) -> usize { N }

    pub fn at(&self, index: usize) -> u8 {
        self.data[index.min(N - 1)]
    }

    pub fn at_mut(&mut self, index: usize) -> &mut u8 {
        let idx = index.min(N - 1);
        &mut self.data[idx]
    }

    pub fn as_bytes(&self) -> &[u8] {
        &self.data
    }

    pub fn as_bytes_mut(&mut self) -> &mut [u8] {
        &mut self.data
    }

    pub fn substr(&self, offset: usize, len: usize) -> &str {
        let start = offset.min(N);
        let end = (offset + len).min(N);
        std::str::from_utf8(&self.data[start..end]).unwrap_or("")
    }

    pub fn spaces() -> Self {
        Self::new() // new() already fills with spaces
    }

    pub fn low_values() -> Self {
        Self { data: [0x00; N] }
    }

    pub fn high_values() -> Self {
        Self { data: [0xFF; N] }
    }
}

impl<const N: usize> Default for FixedString<N> {
    fn default() -> Self {
        Self::new()
    }
}

impl<const N: usize> From<String> for FixedString<N> {
    fn from(s: String) -> Self {
        Self::from_str(&s)
    }
}

impl<const N: usize> From<&str> for FixedString<N> {
    fn from(s: &str) -> Self {
        Self::from_str(s)
    }
}

impl<const N: usize> From<std::borrow::Cow<'_, str>> for FixedString<N> {
    fn from(s: std::borrow::Cow<'_, str>) -> Self {
        Self::from_str(&s)
    }
}

impl<const N: usize> PartialEq<&str> for FixedString<N> {
    fn eq(&self, other: &&str) -> bool {
        self.trimmed() == *other
    }
}

impl<const N: usize> PartialEq<str> for FixedString<N> {
    fn eq(&self, other: &str) -> bool {
        self.trimmed() == other
    }
}

impl<const N: usize> PartialOrd<&str> for FixedString<N> {
    fn partial_cmp(&self, other: &&str) -> Option<std::cmp::Ordering> {
        self.trimmed().partial_cmp(*other)
    }
}

impl<const N: usize> PartialOrd<str> for FixedString<N> {
    fn partial_cmp(&self, other: &str) -> Option<std::cmp::Ordering> {
        self.trimmed().partial_cmp(other)
    }
}

// Cross-type comparisons: FixedString vs numeric types (COBOL allows these)
impl<const N: usize> PartialEq<i32> for FixedString<N> {
    fn eq(&self, other: &i32) -> bool {
        self.trimmed().parse::<i32>().unwrap_or(0) == *other
    }
}

impl<const N: usize> PartialEq<i64> for FixedString<N> {
    fn eq(&self, other: &i64) -> bool {
        self.trimmed().parse::<i64>().unwrap_or(0) == *other
    }
}

impl<const N: usize> PartialEq<u32> for FixedString<N> {
    fn eq(&self, other: &u32) -> bool {
        self.trimmed().parse::<u32>().unwrap_or(0) == *other
    }
}

impl<const N: usize> PartialEq<u64> for FixedString<N> {
    fn eq(&self, other: &u64) -> bool {
        self.trimmed().parse::<u64>().unwrap_or(0) == *other
    }
}

impl<const N: usize> PartialEq<f32> for FixedString<N> {
    fn eq(&self, other: &f32) -> bool {
        self.trimmed().parse::<f32>().unwrap_or(0.0) == *other
    }
}

impl<const N: usize> PartialEq<f64> for FixedString<N> {
    fn eq(&self, other: &f64) -> bool {
        self.trimmed().parse::<f64>().unwrap_or(0.0) == *other
    }
}

impl<const N: usize> PartialOrd<i32> for FixedString<N> {
    fn partial_cmp(&self, other: &i32) -> Option<std::cmp::Ordering> {
        self.trimmed().parse::<i32>().unwrap_or(0).partial_cmp(other)
    }
}

impl<const N: usize> PartialOrd<i64> for FixedString<N> {
    fn partial_cmp(&self, other: &i64) -> Option<std::cmp::Ordering> {
        self.trimmed().parse::<i64>().unwrap_or(0).partial_cmp(other)
    }
}

// From numeric types for FixedString
impl<const N: usize> From<i32> for FixedString<N> {
    fn from(n: i32) -> Self { Self::from_str(&n.to_string()) }
}

impl<const N: usize> From<i64> for FixedString<N> {
    fn from(n: i64) -> Self { Self::from_str(&n.to_string()) }
}

impl<const N: usize> From<u32> for FixedString<N> {
    fn from(n: u32) -> Self { Self::from_str(&n.to_string()) }
}

impl<const N: usize> From<u64> for FixedString<N> {
    fn from(n: u64) -> Self { Self::from_str(&n.to_string()) }
}

impl<const N: usize> From<f32> for FixedString<N> {
    fn from(n: f32) -> Self { Self::from_str(&format!("{}", n)) }
}

impl<const N: usize> From<f64> for FixedString<N> {
    fn from(n: f64) -> Self { Self::from_str(&format!("{}", n)) }
}

impl<const N: usize> From<usize> for FixedString<N> {
    fn from(n: usize) -> Self { Self::from_str(&format!("{}", n)) }
}

impl<const N: usize> From<bool> for FixedString<N> {
    fn from(b: bool) -> Self { Self::from_str(if b { "1" } else { "0" }) }
}

// PartialEq<usize> for FixedString (COBOL numeric string comparison)
impl<const N: usize> PartialEq<usize> for FixedString<N> {
    fn eq(&self, other: &usize) -> bool {
        self.trimmed().parse::<usize>().unwrap_or(0) == *other
    }
}

impl<const N: usize> PartialEq<bool> for FixedString<N> {
    fn eq(&self, other: &bool) -> bool {
        let n = self.trimmed().parse::<u8>().unwrap_or(0);
        (*other && n != 0) || (!*other && n == 0)
    }
}

// Reverse comparisons: &str/String == FixedString (COBOL allows comparison in either direction)
impl<const N: usize> PartialEq<FixedString<N>> for &str {
    fn eq(&self, other: &FixedString<N>) -> bool {
        *self == other.trimmed()
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for str {
    fn eq(&self, other: &FixedString<N>) -> bool {
        self == other.trimmed()
    }
}

impl<const N: usize> PartialOrd<FixedString<N>> for &str {
    fn partial_cmp(&self, other: &FixedString<N>) -> Option<std::cmp::Ordering> {
        (*self).partial_cmp(other.trimmed())
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for String {
    fn eq(&self, other: &FixedString<N>) -> bool {
        self.as_str() == other.trimmed()
    }
}

impl<const N: usize> PartialOrd<FixedString<N>> for String {
    fn partial_cmp(&self, other: &FixedString<N>) -> Option<std::cmp::Ordering> {
        self.as_str().partial_cmp(other.trimmed())
    }
}

// Reverse numeric comparisons: i32/i64/u32/u64 == FixedString
impl<const N: usize> PartialEq<FixedString<N>> for i32 {
    fn eq(&self, other: &FixedString<N>) -> bool {
        other.trimmed().parse::<i32>().unwrap_or(0) == *self
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for i64 {
    fn eq(&self, other: &FixedString<N>) -> bool {
        other.trimmed().parse::<i64>().unwrap_or(0) == *self
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for u32 {
    fn eq(&self, other: &FixedString<N>) -> bool {
        other.trimmed().parse::<u32>().unwrap_or(0) == *self
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for f64 {
    fn eq(&self, other: &FixedString<N>) -> bool {
        other.trimmed().parse::<f64>().unwrap_or(0.0) == *self
    }
}

impl<const N: usize> PartialEq<FixedString<N>> for usize {
    fn eq(&self, other: &FixedString<N>) -> bool {
        other.trimmed().parse::<usize>().unwrap_or(0) == *self
    }
}

// Copy from another FixedString of different size (COBOL MOVE between different-sized fields)
impl<const N: usize> FixedString<N> {
    pub fn copy_from(other: &dyn std::fmt::Display) -> Self {
        let s = format!("{}", other);
        Self::from_str(&s)
    }
}

impl<const N: usize> fmt::Display for FixedString<N> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.trimmed())
    }
}

impl<const N: usize> fmt::Debug for FixedString<N> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "FixedString<{}>({:?})", N, self.trimmed())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new_is_spaces() {
        let s: FixedString<5> = FixedString::new();
        assert_eq!(s.as_str(), "     ");
    }

    #[test]
    fn test_from_str_pads() {
        let s: FixedString<10> = FixedString::from_str("HI");
        assert_eq!(s.as_str(), "HI        ");
        assert_eq!(s.trimmed(), "HI");
    }

    #[test]
    fn test_from_str_truncates() {
        let s: FixedString<3> = FixedString::from_str("HELLO");
        assert_eq!(s.as_str(), "HEL");
    }

    #[test]
    fn test_substr() {
        let s: FixedString<10> = FixedString::from_str("ABCDEFGHIJ");
        assert_eq!(s.substr(2, 3), "CDE");
    }

    #[test]
    fn test_const_new() {
        const S: FixedString<5> = FixedString::new();
        assert_eq!(S.data, [b' '; 5]);
    }
}

// COBOL treats all fields as numeric-capable — ADD/SUBTRACT on alphanumeric parses as integer
impl<const N: usize> std::ops::AddAssign<i32> for FixedString<N> {
    fn add_assign(&mut self, rhs: i32) {
        let val: i32 = self.trimmed().parse().unwrap_or(0);
        *self = FixedString::from_str(&format!("{}", val + rhs));
    }
}

impl<const N: usize> std::ops::SubAssign<i32> for FixedString<N> {
    fn sub_assign(&mut self, rhs: i32) {
        let val: i32 = self.trimmed().parse().unwrap_or(0);
        *self = FixedString::from_str(&format!("{}", val - rhs));
    }
}

impl<const N: usize> std::ops::AddAssign<i64> for FixedString<N> {
    fn add_assign(&mut self, rhs: i64) {
        let val: i64 = self.trimmed().parse().unwrap_or(0);
        *self = FixedString::from_str(&format!("{}", val + rhs));
    }
}

impl<const N: usize> std::ops::SubAssign<i64> for FixedString<N> {
    fn sub_assign(&mut self, rhs: i64) {
        let val: i64 = self.trimmed().parse().unwrap_or(0);
        *self = FixedString::from_str(&format!("{}", val - rhs));
    }
}
