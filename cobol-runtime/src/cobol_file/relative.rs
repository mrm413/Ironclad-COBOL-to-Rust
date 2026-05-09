// Relative file organization methods for CobolFile.

use std::io::{Read, Seek, SeekFrom, Write};
use std::fs::File;
use crate::FileStatus;
use super::CobolFile;

impl CobolFile {
    // ── ORGANIZATION RELATIVE methods ──────────────────────────────

    /// Open a RELATIVE file for OUTPUT (creates/truncates).
    pub fn open_relative_output(path: &str, record_len: usize) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        match File::create(path) {
            Ok(f) => Ok(CobolFile::Relative {
                file: f,
                record_len,
                current_key: None,
                last_read_key: None,
                file_len: 0,
                writable: true,
            }),
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Open a RELATIVE file for EXTEND — preserves existing records and
    /// allows appending. Uses read+write without truncation.
    pub fn open_relative_extend(path: &str, record_len: usize) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        match std::fs::OpenOptions::new().read(true).write(true).create(true).open(path) {
            Ok(f) => {
                let len = f.metadata().map(|m| m.len()).unwrap_or(0);
                Ok(CobolFile::Relative {
                    file: f,
                    record_len,
                    current_key: None,
                last_read_key: None,
                    file_len: len,
                    writable: true,
                })
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Open a RELATIVE file for INPUT.
    pub fn open_relative_input(path: &str, record_len: usize) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        match File::open(path) {
            Ok(f) => {
                let len = f.metadata().map(|m| m.len()).unwrap_or(0);
                Ok(CobolFile::Relative {
                    file: f,
                    record_len,
                    current_key: None,
                last_read_key: None,
                    file_len: len,
                    writable: false,
                })
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Open a RELATIVE OPTIONAL file for INPUT. Returns (handle, was_missing).
    pub fn open_relative_input_optional(path: &str, record_len: usize) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        match File::open(path) {
            Ok(f) => {
                let len = f.metadata().map(|m| m.len()).unwrap_or(0);
                Ok((CobolFile::Relative {
                    file: f,
                    record_len,
                    current_key: None,
                last_read_key: None,
                    file_len: len,
                    writable: false,
                }, false))
            }
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
                match File::create(path) {
                    Ok(_) => {
                        match File::open(path) {
                            Ok(f) => Ok((CobolFile::Relative {
                                file: f,
                                record_len,
                                current_key: None,
                last_read_key: None,
                                file_len: 0,
                                writable: false,
                            }, true)),
                            Err(e2) => Err(Self::map_io_error(&e2)),
                        }
                    }
                    Err(e2) => Err(Self::map_io_error(&e2)),
                }
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Open a RELATIVE file for I-O.
    pub fn open_relative_io(path: &str, record_len: usize) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        match std::fs::OpenOptions::new().read(true).write(true).open(path) {
            Ok(f) => {
                let len = f.metadata().map(|m| m.len()).unwrap_or(0);
                Ok(CobolFile::Relative {
                    file: f,
                    record_len,
                    current_key: None,
                last_read_key: None,
                    file_len: len,
                    writable: true,
                })
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// Open a RELATIVE OPTIONAL file for I-O. Returns (handle, was_missing).
    pub fn open_relative_io_optional(path: &str, record_len: usize) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        match std::fs::OpenOptions::new().read(true).write(true).open(path) {
            Ok(f) => {
                let len = f.metadata().map(|m| m.len()).unwrap_or(0);
                Ok((CobolFile::Relative {
                    file: f,
                    record_len,
                    current_key: None,
                last_read_key: None,
                    file_len: len,
                    writable: true,
                }, false))
            }
            Err(e) if e.kind() == std::io::ErrorKind::NotFound => {
                match std::fs::OpenOptions::new().read(true).write(true).create(true).open(path) {
                    Ok(f) => Ok((CobolFile::Relative {
                        file: f,
                        record_len,
                        current_key: None,
                last_read_key: None,
                        file_len: 0,
                        writable: true,
                    }, true)),
                    Err(e2) => Err(Self::map_io_error(&e2)),
                }
            }
            Err(e) => Err(Self::map_io_error(&e)),
        }
    }

    /// WRITE to a RELATIVE file at the given key (1-based slot).
    /// Returns DuplicateKey (status 22) if the slot already contains data.
    pub fn relative_write(&mut self, key: u32, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, writable, .. } => {
                if !*writable { return Err(FileStatus::WriteNotAllowed); }
                if key == 0 { return Err(FileStatus::BoundaryViolation); }
                let rl = *record_len;
                let offset = ((key - 1) as u64) * (rl as u64);
                // Check if the slot already contains data (non-NUL = occupied)
                if offset + (rl as u64) <= *file_len {
                    file.seek(SeekFrom::Start(offset))
                        .map_err(|_| FileStatus::PermanentError)?;
                    let mut existing = vec![0u8; rl];
                    if file.read_exact(&mut existing).is_ok() {
                        if !existing.iter().all(|&b| b == 0) {
                            return Err(FileStatus::DuplicateKey); // 22
                        }
                    }
                }
                // Extend file with NUL bytes if needed
                if offset > *file_len {
                    file.seek(SeekFrom::Start(*file_len))
                        .map_err(|_| FileStatus::PermanentError)?;
                    let gap = (offset - *file_len) as usize;
                    let zeros = vec![0u8; gap];
                    file.write_all(&zeros)
                        .map_err(|_| FileStatus::PermanentError)?;
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                // Pad or truncate data to record_len
                let mut rec = vec![b' '; rl];
                let copy_len = data.len().min(rl);
                rec[..copy_len].copy_from_slice(&data[..copy_len]);
                file.write_all(&rec)
                    .map_err(|_| FileStatus::WriteNotAllowed)?;
                let _ = file.flush();
                let new_end = offset + (rl as u64);
                if new_end > *file_len {
                    *file_len = new_end;
                }
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// WRITE sequential (auto-increment) to a RELATIVE file.
    /// Used when ACCESS IS SEQUENTIAL and no RELATIVE KEY is defined.
    /// Writes to the next slot after the current file end.
    pub fn relative_write_next(&mut self, data: &[u8]) -> Result<u32, FileStatus> {
        let next_key = match self {
            CobolFile::Relative { file_len, record_len, .. } => {
                (*file_len as usize / *record_len) as u32 + 1
            }
            _ => return Err(FileStatus::WriteNotAllowed),
        };
        self.relative_write(next_key, data)?;
        Ok(next_key)
    }

    /// WRITE sequential variable-length (auto-increment) to a RELATIVE file.
    /// Used when ACCESS IS SEQUENTIAL, no RELATIVE KEY, and RECORD VARYING.
    pub fn write_variable_relative_next(&mut self, data: &[u8], actual_len: usize, max_rec_len: usize) -> Result<u32, FileStatus> {
        let slot_size = 4 + max_rec_len;
        let next_key = match self {
            CobolFile::Relative { file_len, .. } => {
                (*file_len as usize / slot_size) as u32 + 1
            }
            _ => return Err(FileStatus::WriteNotAllowed),
        };
        self.write_variable_relative(next_key, data, actual_len, max_rec_len)?;
        Ok(next_key)
    }

    /// REWRITE in a RELATIVE file — overwrite the record at last_read_key (set by last READ).
    pub fn relative_rewrite(&mut self, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, last_read_key, writable, .. } => {
                if !*writable { return Err(FileStatus::WriteNotAllowed); }
                let key = last_read_key.ok_or(FileStatus::NoCurrentRecord)?;
                let rl = *record_len;
                let offset = ((key - 1) as u64) * (rl as u64);
                if offset + (rl as u64) > *file_len {
                    return Err(FileStatus::RecordNotFound);
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                let mut rec = vec![b' '; rl];
                let copy_len = data.len().min(rl);
                rec[..copy_len].copy_from_slice(&data[..copy_len]);
                file.write_all(&rec)
                    .map_err(|_| FileStatus::WriteNotAllowed)?;
                let _ = file.flush();
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// REWRITE in a RELATIVE file with explicit key (RANDOM access mode).
    pub fn relative_rewrite_at(&mut self, key: u32, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, writable, .. } => {
                if !*writable { return Err(FileStatus::WriteNotAllowed); }
                if key == 0 { return Err(FileStatus::RecordNotFound); }
                let rl = *record_len;
                let offset = ((key - 1) as u64) * (rl as u64);
                if offset + (rl as u64) > *file_len {
                    return Err(FileStatus::RecordNotFound);
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                let mut rec = vec![b' '; rl];
                let copy_len = data.len().min(rl);
                rec[..copy_len].copy_from_slice(&data[..copy_len]);
                file.write_all(&rec)
                    .map_err(|_| FileStatus::WriteNotAllowed)?;
                let _ = file.flush();
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// READ from a RELATIVE file at the given key (1-based, RANDOM access).
    pub fn relative_read(&mut self, key: u32, buf: &mut [u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, current_key, last_read_key, .. } => {
                if key == 0 { return Err(FileStatus::RecordNotFound); }
                let rl = *record_len;
                let offset = ((key - 1) as u64) * (rl as u64);
                if offset + (rl as u64) > *file_len {
                    return Err(FileStatus::RecordNotFound);
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                let mut rec = vec![0u8; rl];
                file.read_exact(&mut rec)
                    .map_err(|_| FileStatus::RecordNotFound)?;
                // Check if slot is empty (all NUL)
                if rec.iter().all(|&b| b == 0) {
                    return Err(FileStatus::RecordNotFound);
                }
                let copy_len = buf.len().min(rl);
                buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                *current_key = Some(key + 1);
                *last_read_key = Some(key);
                Ok(())
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// START on a RELATIVE file: KEY < value — find highest occupied slot below key.
    /// GnuCOBOL scans for an actual record; returns 23 if file is empty or no match.
    pub fn relative_start_less_than(&mut self, key: u32) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, current_key, .. } => {
                if key <= 1 {
                    return Err(FileStatus::RecordNotFound);
                }
                let rl = *record_len;
                let max_slots = (*file_len as usize) / rl;
                if max_slots == 0 {
                    return Err(FileStatus::RecordNotFound);
                }
                let search_end = std::cmp::min((key - 1) as usize, max_slots);
                // Scan backwards from search_end to find highest occupied slot
                for k in (1..=search_end).rev() {
                    let offset = ((k - 1) as u64) * (rl as u64);
                    if file.seek(SeekFrom::Start(offset)).is_err() { continue; }
                    let mut rec = vec![0u8; rl];
                    if file.read_exact(&mut rec).is_err() { continue; }
                    if !rec.iter().all(|&b| b == 0) {
                        *current_key = Some(k as u32);
                        return Ok(());
                    }
                }
                Err(FileStatus::RecordNotFound)
            }
            _ => Err(FileStatus::RecordNotFound),
        }
    }

    /// START FIRST on a RELATIVE file: position to the first occupied slot.
    pub fn relative_start_first(&mut self) -> Result<(), FileStatus> {
        self.relative_start_ge(1)
    }

    /// START LAST on a RELATIVE file: position to the last occupied slot.
    pub fn relative_start_last(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, current_key, .. } => {
                let rl = *record_len;
                let max_slots = (*file_len as usize) / rl;
                if max_slots == 0 {
                    return Err(FileStatus::RecordNotFound);
                }
                // Scan backwards from last slot
                for k in (1..=max_slots).rev() {
                    let offset = ((k - 1) as u64) * (rl as u64);
                    if file.seek(SeekFrom::Start(offset)).is_err() { continue; }
                    let mut rec = vec![0u8; rl];
                    if file.read_exact(&mut rec).is_err() { continue; }
                    if !rec.iter().all(|&b| b == 0) {
                        *current_key = Some(k as u32);
                        return Ok(());
                    }
                }
                Err(FileStatus::RecordNotFound)
            }
            _ => Err(FileStatus::RecordNotFound),
        }
    }

    /// START on a RELATIVE file: KEY >= value — find first occupied slot at or after key.
    /// Returns 23 if file is empty or no matching record found.
    pub fn relative_start_ge(&mut self, key: u32) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, current_key, .. } => {
                let rl = *record_len;
                let max_slots = (*file_len as usize) / rl;
                if max_slots == 0 {
                    return Err(FileStatus::RecordNotFound);
                }
                let start_key = if key == 0 { 1 } else { key as usize };
                // Scan forward from start_key to find first occupied slot
                for k in start_key..=max_slots {
                    let offset = ((k - 1) as u64) * (rl as u64);
                    if file.seek(SeekFrom::Start(offset)).is_err() { continue; }
                    let mut rec = vec![0u8; rl];
                    if file.read_exact(&mut rec).is_err() { continue; }
                    if !rec.iter().all(|&b| b == 0) {
                        *current_key = Some(k as u32);
                        return Ok(());
                    }
                }
                Err(FileStatus::RecordNotFound)
            }
            _ => Err(FileStatus::RecordNotFound),
        }
    }

    /// DELETE the record at last_read_key (set by last successful READ).
    /// Zero-fills the slot so subsequent reads skip it (matching the
    /// "all-zero = deleted" convention used by relative_write).
    pub fn relative_delete(&mut self, key: Option<u32>) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, last_read_key, writable, .. } => {
                if !*writable { return Err(FileStatus::WriteNotAllowed); }
                let k = match key {
                    Some(k) => k,
                    None => last_read_key.ok_or(FileStatus::NoCurrentRecord)?,
                };
                if k == 0 { return Err(FileStatus::RecordNotFound); }
                let rl = *record_len;
                let offset = ((k - 1) as u64) * (rl as u64);
                if offset + (rl as u64) > *file_len {
                    return Err(FileStatus::RecordNotFound);
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                let zeros = vec![0u8; rl];
                file.write_all(&zeros)
                    .map_err(|_| FileStatus::PermanentError)?;
                let _ = file.flush();
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// READ NEXT on a RELATIVE file (sequential access after START).
    pub fn relative_read_next(&mut self, buf: &mut [u8]) -> Result<u32, FileStatus> {
        match self {
            CobolFile::Relative { file, record_len, file_len, current_key, last_read_key, .. } => {
                // After AtEnd, subsequent reads return NoCurrentRecord (46)
                if *current_key == Some(u32::MAX) {
                    return Err(FileStatus::NoCurrentRecord);
                }
                let rl = *record_len;
                let max_slots = (*file_len as usize) / rl;
                // current_key holds the NEXT key to attempt (or None = start at 1).
                // After START, current_key points at the START position. After
                // READ NEXT of slot k, current_key advances to k+1.
                let start = match current_key {
                    Some(k) => *k as usize,
                    None => 1,
                };
                for k in start..=max_slots {
                    let offset = ((k - 1) as u64) * (rl as u64);
                    if file.seek(SeekFrom::Start(offset)).is_err() { continue; }
                    let mut rec = vec![0u8; rl];
                    if file.read_exact(&mut rec).is_err() {
                        *current_key = Some(u32::MAX); // mark as past-end
                        return Err(FileStatus::AtEnd);
                    }
                    if !rec.iter().all(|&b| b == 0) {
                        let copy_len = buf.len().min(rl);
                        buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                        // Advance current_key past this slot, and record the
                        // just-read key for REWRITE/DELETE.
                        *current_key = Some((k + 1) as u32);
                        *last_read_key = Some(k as u32);
                        return Ok(k as u32);
                    }
                }
                *current_key = Some(u32::MAX); // mark as past-end
                Err(FileStatus::AtEnd)
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }
}
