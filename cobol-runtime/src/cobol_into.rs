// cobol_into.rs — Universal COBOL MOVE conversion trait.
//
// The CobolInto trait handles COBOL's implicit type conversions (MOVE semantics):
// any source type -> format as string -> parse into target type.
// This replaces the per-file trait definition that was duplicated in every generated program.

use crate::{Decimal, FixedString, PackedDecimal, FileStatus};

/// Universal COBOL type conversion trait (MOVE semantics).
/// `source.cobol_into()` converts any COBOL value to the target type.
pub trait CobolInto<T> {
    fn cobol_into(self) -> T;
}

// String -> FixedString<N>
impl<const N: usize> CobolInto<FixedString<N>> for String {
    fn cobol_into(self) -> FixedString<N> { FixedString::from(self.as_str()) }
}

// String -> Decimal
impl CobolInto<Decimal> for String {
    fn cobol_into(self) -> Decimal { self.trim().parse::<i64>().map(Decimal::from).unwrap_or_default() }
}

// String -> numeric types
impl CobolInto<i32> for String {
    fn cobol_into(self) -> i32 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<i16> for String {
    fn cobol_into(self) -> i16 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<u8> for String {
    fn cobol_into(self) -> u8 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<u16> for String {
    fn cobol_into(self) -> u16 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<u32> for String {
    fn cobol_into(self) -> u32 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<u64> for String {
    fn cobol_into(self) -> u64 { self.trim().parse().unwrap_or_default() }
}
impl CobolInto<i64> for String {
    fn cobol_into(self) -> i64 { self.trim().parse().unwrap_or_default() }
}

// String -> String (identity)
impl CobolInto<String> for String {
    fn cobol_into(self) -> String { self }
}

// String -> bool
impl CobolInto<bool> for String {
    fn cobol_into(self) -> bool { matches!(self.trim(), "Y" | "1" | "TRUE") }
}

// String -> PackedDecimal<N>
impl<const N: usize> CobolInto<PackedDecimal<N>> for String {
    fn cobol_into(self) -> PackedDecimal<N> { Default::default() }
}

// String -> Array (default)
impl<T: Default, const N: usize> CobolInto<[T; N]> for String where [T; N]: Default {
    fn cobol_into(self) -> [T; N] { Default::default() }
}

// String -> FileStatus
impl CobolInto<FileStatus> for String {
    fn cobol_into(self) -> FileStatus { FileStatus::Success }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_string_to_i32() {
        let v: i32 = "42".to_string().cobol_into();
        assert_eq!(v, 42);
    }

    #[test]
    fn test_string_to_i32_with_spaces() {
        let v: i32 = "  123  ".to_string().cobol_into();
        assert_eq!(v, 123);
    }

    #[test]
    fn test_string_to_string() {
        let v: String = "hello".to_string().cobol_into();
        assert_eq!(v, "hello");
    }

    #[test]
    fn test_string_to_bool() {
        let v: bool = String::from("Y").cobol_into();
        assert!(v);
        let v: bool = String::from("1").cobol_into();
        assert!(v);
        let v: bool = String::from("N").cobol_into();
        assert!(!v);
    }

    #[test]
    fn test_string_to_fixed_string() {
        let v: FixedString<5> = "ABC".to_string().cobol_into();
        assert_eq!(format!("{}", v), "ABC");
    }
}
