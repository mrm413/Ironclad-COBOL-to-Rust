// FileStatus — COBOL file status codes mapped to Rust Result-friendly types.

use std::fmt;

/// COBOL file status codes (ISO 2002).
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum FileStatus {
    // Successful
    Success,              // 00
    SuccessDuplicate,     // 02
    SuccessNoLength,      // 04 — record shorter than minimum
    SuccessOptional,      // 05
    SuccessRecordTooLong, // 06 — record longer than maximum

    // At End
    AtEnd,                // 10
    AtEndDuplicate,       // 14

    // Invalid Key
    SequenceError,        // 21
    DuplicateKey,         // 22
    RecordNotFound,       // 23
    BoundaryViolation,    // 24

    // Permanent Error
    PermanentError,       // 30
    InvalidFilename,      // 31 — blank, null, or invalid file name
    BoundaryError,        // 34
    InconsistentFilename, // 35
    FileNotFound,         // 35
    PermissionDenied,     // 37
    FileAlreadyClosed,    // 38
    ConflictingAttr,      // 39

    // Logic Error
    FileAlreadyOpen,      // 41
    FileNotOpen,          // 42
    NoReadBefore,         // 43
    RecordOverflow,       // 44
    NoCurrentRecord,      // 46
    ReadNotAllowed,       // 47
    WriteNotAllowed,      // 48
    DeleteNotAllowed,     // 49

    // Other
    Other(u8, u8),        // status-1, status-2
    Error(String),        // Generic error with code string
}

impl FileStatus {
    pub fn from_code(s1: u8, s2: u8) -> Self {
        match (s1, s2) {
            (0, 0) => Self::Success,
            (0, 2) => Self::SuccessDuplicate,
            (0, 4) => Self::SuccessNoLength,
            (0, 5) => Self::SuccessOptional,
            (0, 6) => Self::SuccessRecordTooLong,
            (1, 0) => Self::AtEnd,
            (1, 4) => Self::AtEndDuplicate,
            (2, 1) => Self::SequenceError,
            (2, 2) => Self::DuplicateKey,
            (2, 3) => Self::RecordNotFound,
            (2, 4) => Self::BoundaryViolation,
            (3, 0) => Self::PermanentError,
            (3, 1) => Self::InvalidFilename,
            (3, 4) => Self::BoundaryError,
            (3, 5) => Self::FileNotFound,
            (3, 7) => Self::PermissionDenied,
            (3, 8) => Self::FileAlreadyClosed,
            (3, 9) => Self::ConflictingAttr,
            (4, 1) => Self::FileAlreadyOpen,
            (4, 2) => Self::FileNotOpen,
            (4, 3) => Self::NoReadBefore,
            (4, 4) => Self::RecordOverflow,
            (4, 6) => Self::NoCurrentRecord,
            (4, 7) => Self::ReadNotAllowed,
            (4, 8) => Self::WriteNotAllowed,
            (4, 9) => Self::DeleteNotAllowed,
            _ => Self::Other(s1, s2),
        }
    }

    pub fn is_success(&self) -> bool {
        matches!(self, Self::Success | Self::SuccessDuplicate | Self::SuccessNoLength | Self::SuccessOptional | Self::SuccessRecordTooLong)
    }

    pub fn is_at_end(&self) -> bool {
        matches!(self, Self::AtEnd | Self::AtEndDuplicate)
    }

    pub fn code(&self) -> (u8, u8) {
        match self {
            Self::Success => (0, 0),
            Self::SuccessDuplicate => (0, 2),
            Self::SuccessNoLength => (0, 4),
            Self::SuccessOptional => (0, 5),
            Self::SuccessRecordTooLong => (0, 6),
            Self::AtEnd => (1, 0),
            Self::AtEndDuplicate => (1, 4),
            Self::SequenceError => (2, 1),
            Self::DuplicateKey => (2, 2),
            Self::RecordNotFound => (2, 3),
            Self::BoundaryViolation => (2, 4),
            Self::PermanentError => (3, 0),
            Self::InvalidFilename => (3, 1),
            Self::BoundaryError => (3, 4),
            Self::InconsistentFilename | Self::FileNotFound => (3, 5),
            Self::PermissionDenied => (3, 7),
            Self::FileAlreadyClosed => (3, 8),
            Self::ConflictingAttr => (3, 9),
            Self::FileAlreadyOpen => (4, 1),
            Self::FileNotOpen => (4, 2),
            Self::NoReadBefore => (4, 3),
            Self::RecordOverflow => (4, 4),
            Self::NoCurrentRecord => (4, 6),
            Self::ReadNotAllowed => (4, 7),
            Self::WriteNotAllowed => (4, 8),
            Self::DeleteNotAllowed => (4, 9),
            Self::Other(s1, s2) => (*s1, *s2),
            Self::Error(ref code) => {
                let bytes = code.as_bytes();
                let s1 = bytes.first().map(|b| b - b'0').unwrap_or(9);
                let s2 = bytes.get(1).map(|b| b - b'0').unwrap_or(9);
                (s1, s2)
            }
        }
    }
}

impl fmt::Display for FileStatus {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let (s1, s2) = self.code();
        write!(f, "{}{}", s1, s2)
    }
}

impl<const N: usize> From<FileStatus> for crate::FixedString<N> {
    fn from(fs: FileStatus) -> Self {
        let s = format!("{}", fs);
        Self::from_str(&s)
    }
}

impl PartialEq<&str> for FileStatus {
    fn eq(&self, other: &&str) -> bool {
        let s = format!("{}", self);
        s == *other
    }
}
