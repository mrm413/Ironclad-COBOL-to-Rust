// Sequential file I/O methods for CobolFile.

use std::io::{BufRead, Read, Seek, SeekFrom, Write};
use crate::FileStatus;
use super::CobolFile;

impl CobolFile {
    pub fn read_record(&mut self, buf: &mut [u8]) -> Result<usize, FileStatus> {
        match self {
            CobolFile::Reading(reader, at_end, _remainder) => {
                if *at_end { return Err(FileStatus::NoCurrentRecord); }
                match reader.read(buf) {
                    Ok(0) => { *at_end = true; Err(FileStatus::AtEnd) }
                    Ok(n) => Ok(n),
                    Err(_) => Err(FileStatus::NoCurrentRecord),
                }
            }
            CobolFile::ReadWrite(file, _) => {
                match file.read(buf) {
                    Ok(0) => Err(FileStatus::AtEnd),
                    Ok(n) => Ok(n),
                    Err(_) => Err(FileStatus::NoCurrentRecord),
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    pub fn read_line(&mut self) -> Result<String, FileStatus> {
        match self {
            CobolFile::Reading(reader, at_end, _remainder) => {
                if *at_end { return Err(FileStatus::NoCurrentRecord); }
                let mut line = String::new();
                match reader.read_line(&mut line) {
                    Ok(0) => { *at_end = true; Err(FileStatus::AtEnd) }
                    Ok(_) => {
                        if line.ends_with('\n') { line.pop(); }
                        if line.ends_with('\r') { line.pop(); }
                        Ok(line)
                    }
                    Err(_) => Err(FileStatus::NoCurrentRecord),
                }
            }
            CobolFile::ReadWrite(file, last_disk_len) => {
                // Manual line reading for raw File handle (no BufReader)
                let mut line = String::new();
                let mut buf = [0u8; 1];
                let mut disk_bytes: usize = 0;
                loop {
                    match file.read(&mut buf) {
                        Ok(0) => {
                            if line.is_empty() { return Err(FileStatus::AtEnd); }
                            break;
                        }
                        Ok(_) => {
                            disk_bytes += 1;
                            if buf[0] == b'\n' { break; }
                            if buf[0] != b'\r' {
                                line.push(buf[0] as char);
                            }
                        }
                        Err(_) => return Err(FileStatus::NoCurrentRecord),
                    }
                }
                // Track the on-disk length (content + CR/LF) for REWRITE comparison
                *last_disk_len = Some(disk_bytes);
                Ok(line)
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// LINE SEQUENTIAL read with COB_LS_SPLIT behavior:
    /// If a line is longer than record_len, return the first record_len chars
    /// and save the remainder for the next call.
    pub fn read_line_split(&mut self, record_len: usize) -> Result<String, FileStatus> {
        match self {
            CobolFile::Reading(_reader, _at_end, remainder) => {
                if let Some(leftover) = remainder.take() {
                    if leftover.len() > record_len {
                        let (first, rest) = leftover.split_at(record_len);
                        let result = first.to_string();
                        *remainder = Some(rest.to_string());
                        return Ok(result);
                    }
                    return Ok(leftover);
                }
            }
            _ => {}
        }
        // No remainder — read a fresh line and split if needed
        let line = self.read_line()?;
        if line.len() > record_len {
            let (first, rest) = line.split_at(record_len);
            let result = first.to_string();
            if let CobolFile::Reading(_, _, remainder) = self {
                *remainder = Some(rest.to_string());
            }
            Ok(result)
        } else {
            Ok(line)
        }
    }

    /// LINE SEQUENTIAL read that handles record-size comparison and returns
    /// the appropriate COBOL file status.
    ///
    /// Reads a line, strips CR/LF endings, then:
    /// - If line length == record_size: fills buf, returns Ok(FileStatus::Success) ["00"]
    /// - If line length < record_size: pads with spaces, returns Ok(FileStatus::SuccessNoLength) ["04"]
    /// - If line length > record_size: truncates to record_size, returns Ok(FileStatus::SuccessRecordTooLong) ["06"]
    ///   (or SuccessNoLength ["04"] when COB_LS_SPLIT=FALSE)
    /// - On EOF: returns Err(FileStatus::AtEnd) ["10"]
    ///
    /// `buf` must be at least `record_size` bytes. The buffer is space-filled first,
    /// then the line data is copied (truncated to record_size if needed).
    /// Returns `(status, actual_line_length)`.
    pub fn read_line_sequential(&mut self, buf: &mut [u8], record_size: usize) -> Result<(FileStatus, usize), FileStatus> {
        // Check for split remainder first (COB_LS_SPLIT=TRUE, the default)
        let split_mode = !std::env::var("COB_LS_SPLIT")
            .map(|v| v.eq_ignore_ascii_case("FALSE"))
            .unwrap_or(false);

        let (line_bytes, is_remainder) = if split_mode {
            // Try to consume remainder from a previous split
            let leftover = match self {
                CobolFile::Reading(_, _, remainder) => remainder.take(),
                _ => None,
            };
            if let Some(leftover) = leftover {
                let bytes = leftover.into_bytes();
                if bytes.len() > record_size {
                    // Still too long — split again
                    let rest = String::from_utf8_lossy(&bytes[record_size..]).into_owned();
                    if let CobolFile::Reading(_, _, remainder) = self {
                        *remainder = Some(rest);
                    }
                    (bytes[..record_size].to_vec(), true)
                } else {
                    (bytes, true)
                }
            } else {
                // No remainder — read a fresh line
                let line = self.read_line()?;
                let bytes = line.into_bytes();
                if bytes.len() > record_size {
                    // Save remainder for next call
                    let rest = String::from_utf8_lossy(&bytes[record_size..]).into_owned();
                    if let CobolFile::Reading(_, _, remainder) = self {
                        *remainder = Some(rest);
                    }
                    (bytes[..record_size].to_vec(), false)
                } else {
                    (bytes, false)
                }
            }
        } else {
            // COB_LS_SPLIT=FALSE: no splitting, just read and truncate
            let line = self.read_line()?;
            let bytes = line.into_bytes();
            (bytes, false)
        };

        let actual_len = line_bytes.len();

        // Space-fill the buffer
        for b in buf.iter_mut().take(record_size) {
            *b = b' ';
        }
        // Copy line data (truncated to record_size)
        let copy_len = actual_len.min(record_size).min(buf.len());
        buf[..copy_len].copy_from_slice(&line_bytes[..copy_len]);

        // Determine status
        let status = if actual_len == record_size {
            FileStatus::Success                 // 00: exact match
        } else if actual_len < record_size {
            if is_remainder {
                // Remainder chunks from split are normal (status 00),
                // they're just a continuation of the previous line
                FileStatus::Success
            } else {
                FileStatus::SuccessNoLength     // 04: short record, padded with spaces
            }
        } else {
            // actual_len > record_size (only in non-split mode, since split truncates above)
            if split_mode {
                FileStatus::SuccessRecordTooLong // 06: overflow/split
            } else {
                FileStatus::SuccessNoLength      // 04: truncated
            }
        };

        Ok((status, actual_len))
    }

    pub fn write_record(&mut self, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Writing(writer) => {
                match writer.write_all(data) {
                    Ok(()) => Ok(()),
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            CobolFile::ReadWrite(file, _) => {
                match file.write_all(data) {
                    Ok(()) => Ok(()),
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    pub fn write_line(&mut self, data: &str) -> Result<(), FileStatus> {
        match self {
            CobolFile::Writing(writer) => {
                match writeln!(writer, "{}", data) {
                    Ok(()) => Ok(()),
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            CobolFile::ReadWrite(file, _) => {
                match writeln!(file, "{}", data) {
                    Ok(()) => Ok(()),
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// REWRITE: seek back to the start of the last-read record and overwrite it.
    /// `record_len` is the FD record length (bytes on disk per line, including newline).
    /// For LINE SEQUENTIAL files, the on-disk record includes a trailing newline,
    /// so the caller should pass `data.len() + 1` as `record_len` when using line mode,
    /// or simply pass the byte count consumed by the last read.
    pub fn rewrite(&mut self, data: &[u8], record_len: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::ReadWrite(file, _) => {
                // Seek back by record_len bytes from current position
                let offset = -(record_len as i64);
                if file.seek(SeekFrom::Current(offset)).is_err() {
                    return Err(FileStatus::NoCurrentRecord);
                }
                match file.write_all(data) {
                    Ok(()) => {
                        let _ = file.flush();
                        Ok(())
                    }
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// REWRITE for LINE SEQUENTIAL: seek back past the last-read line and overwrite.
    /// Uses the tracked last_disk_len from read_line() to seek back correctly.
    /// Returns RecordOverflow (status 44) if the new trimmed data length differs
    /// from the original on-disk line content length (GnuCOBOL behavior for LINE SEQUENTIAL).
    pub fn rewrite_line(&mut self, data: &str, _last_line_disk_len: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::ReadWrite(file, last_disk_len) => {
                // Use tracked disk length from last read_line() if available
                let actual_disk_len = last_disk_len.unwrap_or(_last_line_disk_len);
                if actual_disk_len == 0 {
                    return Err(FileStatus::NoCurrentRecord);
                }
                // Compute the content length (exclude newline bytes)
                let content_len = if actual_disk_len >= 2 {
                    // Could be CR+LF (Windows) — check if we need to account for \r\n
                    // For simplicity, assume the newline consumed 1 byte on Unix, 2 on Windows
                    // The disk_bytes from read_line counts all bytes including \r and \n
                    actual_disk_len.saturating_sub(1) // The \n was counted; \r was also counted but not added to line
                } else {
                    actual_disk_len.saturating_sub(1)
                };
                // GnuCOBOL LINE SEQUENTIAL REWRITE: if new trimmed data length != original
                // content length, return status 44 (RecordOverflow)
                let trimmed_data = data.trim_end();
                if trimmed_data.len() != content_len {
                    return Err(FileStatus::RecordOverflow);
                }
                let offset = -(actual_disk_len as i64);
                if file.seek(SeekFrom::Current(offset)).is_err() {
                    return Err(FileStatus::NoCurrentRecord);
                }
                // Pad or truncate to match original on-disk length (preserve file structure)
                let padded: String = if data.len() >= content_len {
                    data[..content_len].to_string()
                } else {
                    let mut s = data.to_string();
                    s.extend(std::iter::repeat(' ').take(content_len - data.len()));
                    s
                };
                match writeln!(file, "{}", padded) {
                    Ok(()) => {
                        let _ = file.flush();
                        Ok(())
                    }
                    Err(_) => Err(FileStatus::WriteNotAllowed),
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }
}
