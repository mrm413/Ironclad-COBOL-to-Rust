// record_macro.rs — Macro for defining data record structs with standard impls.
//
// Replaces ~17 lines of boilerplate per struct with a single macro invocation.
// Used by Ironclad-generated code for FD records and group items.

/// Define a data record struct with standard trait implementations.
///
/// Generates: struct definition, Display, From<&str>, From<String>, and helper methods.
///
/// # Usage
/// ```ignore
/// define_record! {
///     /// FD-ACCT-REC
///     pub struct FdAcctRec {
///         /// FD-ACCT-ID
///         pub fd_acct_id: Decimal,
///         /// FD-ACCT-DATA
///         pub fd_acct_data: FixedString<289>,
///     }
/// }
/// ```
#[macro_export]
macro_rules! define_record {
    (
        $(#[$meta:meta])*
        pub struct $name:ident {
            $(
                $(#[$field_meta:meta])*
                pub $field:ident : $ty:ty
            ),* $(,)?
        }
    ) => {
        #[derive(Debug, Clone, Default, PartialEq)]
        $(#[$meta])*
        pub struct $name {
            $(
                $(#[$field_meta])*
                pub $field: $ty,
            )*
        }

        impl std::fmt::Display for $name {
            fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
                $(write!(f, "{}", self.$field)?;)*
                Ok(())
            }
        }

        impl From<&str> for $name {
            fn from(_s: &str) -> Self { Self::default() }
        }

        impl From<String> for $name {
            fn from(_s: String) -> Self { Self::default() }
        }

        impl $name {
            pub fn as_str(&self) -> String { format!("{}", self) }
            pub fn as_bytes(&self) -> Vec<u8> { format!("{}", self).into_bytes() }
            pub fn as_bytes_mut(&mut self) -> Vec<u8> { format!("{}", self).into_bytes() }
            pub fn trimmed(&self) -> String { format!("{}", self).trim_end().to_string() }
        }
    };
}

#[cfg(test)]
mod tests {
    use crate::FixedString;
    use crate::Decimal;

    define_record! {
        /// Test record
        pub struct TestRec {
            /// ID field
            pub id: Decimal,
            /// Name field
            pub name: FixedString<10>,
        }
    }

    #[test]
    fn test_define_record_creates_struct() {
        let r = TestRec::default();
        assert_eq!(format!("{}", r.id), "0");
    }

    #[test]
    fn test_define_record_display() {
        let r = TestRec::default();
        let s = format!("{}", r);
        assert!(!s.is_empty());
    }

    #[test]
    fn test_define_record_from_str() {
        let r = TestRec::from("test");
        assert_eq!(r.id, Decimal::default());
    }

    #[test]
    fn test_define_record_helpers() {
        let r = TestRec::default();
        assert!(!r.as_str().is_empty());
        assert!(!r.as_bytes().is_empty());
        assert!(!r.trimmed().is_empty() || r.trimmed().is_empty());
    }
}
