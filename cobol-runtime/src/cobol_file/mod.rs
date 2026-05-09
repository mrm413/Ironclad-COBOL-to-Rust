// CobolFile — file handle wrapper for COBOL file I/O operations.
// Compatible with derive macros (Clone, Debug via manual impl).

use std::io::{BufReader, BufWriter, Seek, SeekFrom, Write};
use std::fs::File;
use crate::FileStatus;

mod sequential;
mod indexed;
mod relative;
mod variable;

pub use indexed::{IndexedStore, AltKeyDef};

#[derive(Default)]
pub enum CobolFile {
    #[default]
    Closed,
    /// (reader, at_end_flag, line_split_remainder for COB_LS_SPLIT)
    Reading(BufReader<File>, bool, Option<String>),
    Writing(BufWriter<File>),
    /// I-O mode: raw File handle for read + write + seek (used by REWRITE/START)
    /// The Option<usize> tracks the on-disk byte count of the last-read line
    /// (content + newline) for LINE SEQUENTIAL REWRITE length comparison.
    ReadWrite(File, Option<usize>),
    /// ORGANIZATION RELATIVE: fixed-length slot-based file
    Relative {
        file: File,
        record_len: usize,
        /// Next position for READ NEXT (1-based key, or None for "start at 1").
        /// After a successful READ NEXT of slot k, this becomes Some(k+1).
        /// After START at slot k, this becomes Some(k) so the next READ NEXT
        /// returns slot k. AtEnd sets it to Some(u32::MAX).
        current_key: Option<u32>,
        /// Key of the LAST successfully READ record. Used by REWRITE/DELETE
        /// (which operate on the just-read record). None if no read has
        /// happened on this open. Distinct from current_key so that START
        /// can position without breaking REWRITE semantics.
        last_read_key: Option<u32>,
        /// File length in bytes (cached for empty-file checks)
        file_len: u64,
        /// Whether file is writable
        writable: bool,
    },
    /// ORGANIZATION INDEXED: BTreeMap-backed keyed access
    Indexed(Box<IndexedStore>),
}

impl Clone for CobolFile {
    fn clone(&self) -> Self {
        match self {
            CobolFile::Closed => CobolFile::Closed,
            CobolFile::Reading(reader, at_end, remainder) => {
                // try_clone duplicates the OS file descriptor
                if let Ok(f2) = reader.get_ref().try_clone() {
                    CobolFile::Reading(BufReader::new(f2), *at_end, remainder.clone())
                } else {
                    CobolFile::Closed
                }
            }
            CobolFile::Writing(writer) => {
                if let Ok(f2) = writer.get_ref().try_clone() {
                    CobolFile::Writing(BufWriter::new(f2))
                } else {
                    CobolFile::Closed
                }
            }
            CobolFile::ReadWrite(file, last_disk_len) => {
                if let Ok(f2) = file.try_clone() {
                    CobolFile::ReadWrite(f2, *last_disk_len)
                } else {
                    CobolFile::Closed
                }
            }
            CobolFile::Relative { file, record_len, current_key, last_read_key, file_len, writable } => {
                if let Ok(f2) = file.try_clone() {
                    CobolFile::Relative {
                        file: f2,
                        record_len: *record_len,
                        current_key: *current_key,
                        last_read_key: *last_read_key,
                        file_len: *file_len,
                        writable: *writable,
                    }
                } else {
                    CobolFile::Closed
                }
            }
            CobolFile::Indexed(store) => CobolFile::Indexed(store.clone()),
        }
    }
}

impl std::fmt::Debug for CobolFile {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            CobolFile::Closed => write!(f, "CobolFile::Closed"),
            CobolFile::Reading(..) => write!(f, "CobolFile::Reading"),
            CobolFile::Writing(_) => write!(f, "CobolFile::Writing"),
            CobolFile::ReadWrite(..) => write!(f, "CobolFile::ReadWrite"),
            CobolFile::Relative { .. } => write!(f, "CobolFile::Relative"),
            CobolFile::Indexed(store) => write!(f, "CobolFile::{:?}", store),
        }
    }
}

impl CobolFile {
    /// Map an IO error to the appropriate COBOL file status code.
    pub(crate) fn map_io_error(e: &std::io::Error) -> FileStatus {
        match e.kind() {
            std::io::ErrorKind::NotFound => FileStatus::FileNotFound,           // 35
            std::io::ErrorKind::PermissionDenied => FileStatus::PermissionDenied, // 37
            _ => FileStatus::PermanentError,                                     // 30
        }
    }

    /// Validate the file path. Returns Err(InvalidFilename) for blank/empty paths.
    pub(crate) fn validate_path(path: &str) -> Result<(), FileStatus> {
        if path.trim().is_empty() {
            Err(FileStatus::InvalidFilename) // 31
        } else {
            Ok(())
        }
    }

    pub fn open_input(path: &str) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        match File::open(path) {
            Ok(f) => Ok(CobolFile::Reading(BufReader::new(f), false, None)),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// OPEN INPUT on a SELECT OPTIONAL file.
    /// If the file does not exist, returns Ok with a special empty-file state
    /// and the caller should set file status to "05" (SuccessOptional).
    /// Returns Ok((handle, true)) if file was missing (optional open),
    /// Ok((handle, false)) if file exists normally.
    pub fn open_input_optional(path: &str) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        match File::open(path) {
            Ok(f) => Ok((CobolFile::Reading(BufReader::new(f), false, None), false)),
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
                // OPTIONAL file not found: create an empty file so handle is valid,
                // then open it for reading (it will immediately return AtEnd on READ).
                match File::create(path) {
                    Ok(_) => {
                        match File::open(path) {
                            Ok(f) => Ok((CobolFile::Reading(BufReader::new(f), false, None), true)),
                            Err(e2) => Err(Self::map_io_error(&e2)),
                        }
                    }
                    Err(e2) => Err(Self::map_io_error(&e2)),
                }
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    pub fn open_output(path: &str) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        // Check if parent directory exists and is a directory — missing or non-dir parent → 30
        if let Some(parent) = std::path::Path::new(path).parent() {
            if !parent.as_os_str().is_empty() && (!parent.exists() || !parent.is_dir()) {
                return Err(FileStatus::PermanentError); // 30
            }
        }
        match File::create(path) {
            Ok(f) => Ok(CobolFile::Writing(BufWriter::new(f))),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    pub fn open_io(path: &str) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        // I-O mode: open existing file for read/write/seek (supports REWRITE/START)
        match std::fs::OpenOptions::new().read(true).write(true).open(path) {
            Ok(f) => Ok(CobolFile::ReadWrite(f, None)),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// OPEN I-O on a SELECT OPTIONAL file.
    /// If the file does not exist, creates it and returns status "05" (SuccessOptional).
    /// Returns Ok((handle, true)) if file was missing, Ok((handle, false)) if it existed.
    pub fn open_io_optional(path: &str) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        match std::fs::OpenOptions::new().read(true).write(true).open(path) {
            Ok(f) => Ok((CobolFile::ReadWrite(f, None), false)),
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
                // Create the file first, then open for I-O
                match std::fs::OpenOptions::new().read(true).write(true).create(true).open(path) {
                    Ok(f) => Ok((CobolFile::ReadWrite(f, None), true)),
                    Err(e2) => Err(Self::map_io_error(&e2)),
                }
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    pub fn open_extend(path: &str) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        // Check if parent directory exists — missing parent → 30 (PermanentError)
        if let Some(parent) = std::path::Path::new(path).parent() {
            if !parent.as_os_str().is_empty() && !parent.exists() {
                return Err(FileStatus::PermanentError); // 30
            }
        }
        // EXTEND mode: open for append
        match std::fs::OpenOptions::new().create(true).append(true).open(path) {
            Ok(f) => Ok(CobolFile::Writing(BufWriter::new(f))),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Delete a file from disk (COBOL DELETE FILE statement).
    /// Returns Ok if the file was deleted or did not exist.
    pub fn delete_file(path: &str) -> Result<(), FileStatus> {
        match std::fs::remove_file(path) {
            Ok(()) => Ok(()),
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => Ok(()),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// START: position the file pointer. For SEQUENTIAL files this is a no-op
    /// (the file is already positioned). For other organizations it sets position
    /// for subsequent READ NEXT.
    pub fn start(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Reading(..) | CobolFile::ReadWrite(..) => {
                // For sequential / line-sequential files, START is a no-op
                // (the file pointer is already at the correct position).
                Ok(())
            }
            CobolFile::Relative { file_len, .. } => {
                // For RELATIVE files without explicit key: if file is empty,
                // return RecordNotFound (23); otherwise succeed.
                if *file_len == 0 {
                    Err(FileStatus::RecordNotFound)
                } else {
                    Ok(())
                }
            }
            CobolFile::Indexed(_) => {
                // For INDEXED files without explicit key: succeed (position at current).
                Ok(())
            }
            CobolFile::Closed => Err(FileStatus::FileNotOpen),
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// Seek to the beginning of the file (for indexed READ KEY IS searches).
    pub fn seek_to_start(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Reading(reader, at_end, remainder) => {
                reader.seek(SeekFrom::Start(0))
                    .map_err(|_| FileStatus::ReadNotAllowed)?;
                *at_end = false;
                *remainder = None; // clear split remainder on seek
                Ok(())
            }
            CobolFile::ReadWrite(file, _) => {
                file.seek(SeekFrom::Start(0))
                    .map_err(|_| FileStatus::ReadNotAllowed)?;
                Ok(())
            }
            CobolFile::Indexed(store) => {
                store.cursor = None; // reset to before-first
                Ok(())
            }
            CobolFile::Closed => Err(FileStatus::FileNotOpen),
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    pub fn close(&mut self) -> Result<(), FileStatus> {
        // Flush INDEXED data to disk before closing
        // Always flush writable indexed files so the "IRCL" header is written even for empty files
        if let CobolFile::Indexed(store) = self {
            if store.writable || store.modified {
                store.flush()?;
            }
        }
        *self = CobolFile::Closed;
        Ok(())
    }
}
