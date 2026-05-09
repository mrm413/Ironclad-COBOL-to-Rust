// Variable-length record methods for CobolFile.

use std::io::{Read, Seek, SeekFrom, Write};
use std::collections::BTreeMap;
use crate::FileStatus;
use super::CobolFile;

impl CobolFile {
    // ── Variable-length record methods ──────────────────────────────

    /// WRITE for variable-length records (LINE SEQUENTIAL).
    /// Writes only `actual_len` bytes of data, trimming trailing spaces, then newline.
    pub fn write_variable_line(&mut self, data: &[u8], actual_len: usize) -> Result<(), FileStatus> {
        let use_len = actual_len.min(data.len());
        let slice = &data[..use_len];
        let text = String::from_utf8_lossy(slice);
        let trimmed = text.trim_end();
        self.write_line(trimmed)
    }

    /// READ for variable-length records (LINE SEQUENTIAL).
    /// Reads a line, space-pads buffer.
    /// Returns Ok((actual_len, is_split_remainder)):
    ///   - actual_len: number of bytes in the line (may exceed max_len)
    ///   - is_split_remainder: true when this is a COB_LS_SPLIT continuation chunk
    ///     (caller should skip the min_len check for remainders)
    /// Returns Err for real I/O failures (AtEnd, etc).
    pub fn read_variable_line(&mut self, buf: &mut [u8], _min_len: usize, max_len: usize) -> Result<(usize, bool), FileStatus> {
        let split_mode = !std::env::var("COB_LS_SPLIT")
            .map(|v| v.eq_ignore_ascii_case("FALSE"))
            .unwrap_or(false);

        // In split mode, return any leftover from a previous split first.
        if split_mode {
            if let CobolFile::Reading(_, _, remainder) = self {
                if let Some(leftover) = remainder.take() {
                    let bytes = leftover.into_bytes();
                    let actual_len = bytes.len();
                    for b in buf.iter_mut() { *b = b' '; }
                    if actual_len > max_len {
                        // Remainder itself exceeds max_len — split again
                        let copy_len = max_len.min(buf.len());
                        buf[..copy_len].copy_from_slice(&bytes[..copy_len]);
                        *remainder = Some(String::from_utf8_lossy(&bytes[max_len..]).into_owned());
                    } else {
                        let copy_len = actual_len.min(buf.len());
                        buf[..copy_len].copy_from_slice(&bytes[..copy_len]);
                    }
                    return Ok((actual_len, true)); // remainder: skip min check
                }
            }
        }

        match self.read_line() {
            Ok(line) => {
                let line_bytes = line.into_bytes();
                let actual_len = line_bytes.len();
                for b in buf.iter_mut() { *b = b' '; }

                if split_mode && actual_len > max_len {
                    // Copy first max_len bytes; save the rest as remainder for next call.
                    let copy_len = max_len.min(buf.len());
                    buf[..copy_len].copy_from_slice(&line_bytes[..copy_len]);
                    if let CobolFile::Reading(_, _, remainder) = self {
                        *remainder = Some(String::from_utf8_lossy(&line_bytes[max_len..]).into_owned());
                    }
                } else {
                    // Truncate mode or line fits: copy up to buffer capacity.
                    let copy_len = actual_len.min(buf.len());
                    buf[..copy_len].copy_from_slice(&line_bytes[..copy_len]);
                }
                Ok((actual_len, false))
            }
            Err(e) => Err(e),
        }
    }

    /// WRITE for variable-length records (binary SEQUENTIAL).
    /// Writes [4-byte little-endian length][data[0..actual_len]].
    pub fn write_variable_record(&mut self, data: &[u8], actual_len: usize) -> Result<(), FileStatus> {
        let use_len = actual_len.min(data.len());
        let len_bytes = (use_len as u32).to_le_bytes();
        match self {
            CobolFile::Writing(writer) => {
                writer.write_all(&len_bytes).map_err(|_| FileStatus::WriteNotAllowed)?;
                writer.write_all(&data[..use_len]).map_err(|_| FileStatus::WriteNotAllowed)?;
                Ok(())
            }
            CobolFile::ReadWrite(file, _) => {
                file.write_all(&len_bytes).map_err(|_| FileStatus::WriteNotAllowed)?;
                file.write_all(&data[..use_len]).map_err(|_| FileStatus::WriteNotAllowed)?;
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// READ for variable-length records (binary SEQUENTIAL).
    /// Reads [4-byte little-endian length][data], returns actual length.
    /// Pads buffer with spaces, returns status 04/06 for under/over.
    pub fn read_variable_record(&mut self, buf: &mut [u8], min_len: usize, max_len: usize) -> Result<usize, FileStatus> {
        // Read 4-byte length header
        let mut len_buf = [0u8; 4];
        match self.read_record(&mut len_buf) {
            Ok(n) if n < 4 => return Err(FileStatus::AtEnd),
            Err(e) => return Err(e),
            _ => {}
        }
        let rec_len = u32::from_le_bytes(len_buf) as usize;
        // Space-fill the buffer
        for b in buf.iter_mut() { *b = b' '; }
        // Read the record data
        let mut temp = vec![0u8; rec_len];
        match self {
            CobolFile::Reading(reader, at_end, _remainder) => {
                if *at_end { return Err(FileStatus::NoCurrentRecord); }
                match reader.read_exact(&mut temp) {
                    Ok(()) => {}
                    Err(_) => { *at_end = true; return Err(FileStatus::AtEnd); }
                }
            }
            CobolFile::ReadWrite(file, _) => {
                if file.read_exact(&mut temp).is_err() {
                    return Err(FileStatus::AtEnd);
                }
            }
            _ => return Err(FileStatus::ReadNotAllowed),
        }
        let copy_len = rec_len.min(buf.len());
        buf[..copy_len].copy_from_slice(&temp[..copy_len]);
        // Determine status
        if rec_len > max_len {
            Err(FileStatus::SuccessRecordTooLong) // 06
        } else if rec_len < min_len {
            Err(FileStatus::SuccessNoLength) // 04
        } else {
            Ok(rec_len)
        }
    }

    /// WRITE for variable-length records in RELATIVE files.
    /// Stores [4-byte length][data padded to max_rec_len] per slot.
    pub fn write_variable_relative(&mut self, key: u32, data: &[u8], actual_len: usize, max_rec_len: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len: _, file_len, writable, .. } => {
                if !*writable { return Err(FileStatus::WriteNotAllowed); }
                if key == 0 { return Err(FileStatus::BoundaryViolation); }
                // Slot size = 4 (length header) + max_rec_len
                let slot_size = 4 + max_rec_len;
                let offset = ((key - 1) as u64) * (slot_size as u64);
                // Extend file with NUL bytes if needed
                if offset > *file_len {
                    file.seek(SeekFrom::Start(*file_len))
                        .map_err(|_| FileStatus::PermanentError)?;
                    let gap = (offset - *file_len) as usize;
                    let zeros = vec![0u8; gap];
                    file.write_all(&zeros).map_err(|_| FileStatus::PermanentError)?;
                }
                file.seek(SeekFrom::Start(offset))
                    .map_err(|_| FileStatus::PermanentError)?;
                let use_len = actual_len.min(data.len()).min(max_rec_len);
                let len_bytes = (use_len as u32).to_le_bytes();
                file.write_all(&len_bytes).map_err(|_| FileStatus::WriteNotAllowed)?;
                let mut rec = vec![b' '; max_rec_len];
                rec[..use_len].copy_from_slice(&data[..use_len]);
                file.write_all(&rec).map_err(|_| FileStatus::WriteNotAllowed)?;
                let _ = file.flush();
                let new_end = offset + slot_size as u64;
                if new_end > *file_len { *file_len = new_end; }
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// READ NEXT for variable-length records in RELATIVE files.
    /// Each slot: [4-byte length][max_rec_len data]. Returns (key, actual_length).
    pub fn read_variable_relative_next(&mut self, buf: &mut [u8], max_rec_len: usize) -> Result<(u32, usize), FileStatus> {
        match self {
            CobolFile::Relative { file, record_len: _, file_len, current_key, .. } => {
                if *current_key == Some(u32::MAX) {
                    return Err(FileStatus::NoCurrentRecord);
                }
                let slot_size = 4 + max_rec_len;
                let max_slots = (*file_len as usize) / slot_size;
                let start = match current_key {
                    Some(k) => *k as usize,
                    None => 1,
                };
                for k in start..=max_slots {
                    let offset = ((k - 1) as u64) * (slot_size as u64);
                    if file.seek(SeekFrom::Start(offset)).is_err() { continue; }
                    let mut len_buf = [0u8; 4];
                    if file.read_exact(&mut len_buf).is_err() {
                        *current_key = Some(u32::MAX);
                        return Err(FileStatus::AtEnd);
                    }
                    let actual_len = u32::from_le_bytes(len_buf) as usize;
                    let mut rec = vec![0u8; max_rec_len];
                    if file.read_exact(&mut rec).is_err() {
                        *current_key = Some(u32::MAX);
                        return Err(FileStatus::AtEnd);
                    }
                    // Check if slot is empty (len=0 and all NUL)
                    if actual_len == 0 && rec.iter().all(|&b| b == 0) {
                        continue;
                    }
                    // Fill buffer with spaces, then copy actual data
                    for b in buf.iter_mut() { *b = b' '; }
                    let copy_len = actual_len.min(buf.len()).min(max_rec_len);
                    buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                    *current_key = Some((k + 1) as u32);
                    return Ok((k as u32, actual_len));
                }
                *current_key = Some(u32::MAX);
                Err(FileStatus::AtEnd)
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// WRITE for variable-length records in INDEXED files.
    pub fn write_variable_indexed(&mut self, data: &[u8], actual_len: usize, _max_rec_len: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if !store.writable { return Err(FileStatus::WriteNotAllowed); }
                let rl = store.record_len;
                let mut rec = vec![b' '; rl];
                let use_len = actual_len.min(data.len()).min(rl);
                rec[..use_len].copy_from_slice(&data[..use_len]);
                let key = store.extract_key(&rec);
                if store.records.contains_key(&key) {
                    return Err(FileStatus::DuplicateKey);
                }
                // Check and insert into alternate key indices
                for alt in &mut store.alt_keys {
                    let ak = alt.extract_key(&rec);
                    alt.insert(ak, key.clone())?;
                }
                if store.actual_lengths.is_none() {
                    store.actual_lengths = Some(BTreeMap::new());
                }
                if let Some(ref mut lengths) = store.actual_lengths {
                    lengths.insert(key.clone(), use_len);
                }
                store.insertion_order.push(key.clone());
                store.records.insert(key, rec);
                store.modified = true;
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// READ NEXT for variable-length records in INDEXED files.
    /// Returns actual length.
    /// Mirrors `indexed_read_next` logic: honors start_positioned, active_alt_key, position_invalid.
    pub fn read_variable_indexed_next(&mut self, buf: &mut [u8], _max_rec_len: usize) -> Result<usize, FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                // After a failed START, return NoCurrentRecord (46)
                if store.position_invalid {
                    return Err(FileStatus::NoCurrentRecord);
                }
                if let Some(alt_idx) = store.active_alt_key {
                    // Alternate key iteration
                    let entries_len = store.alt_keys[alt_idx].entries.len();
                    if entries_len == 0 { return Err(FileStatus::AtEnd); }
                    let pos = if store.start_positioned {
                        store.start_positioned = false;
                        store.alt_cursor_pos
                    } else {
                        store.alt_cursor_pos + 1
                    };
                    if pos >= entries_len { return Err(FileStatus::AtEnd); }
                    store.alt_cursor_pos = pos;
                    let pk = store.alt_keys[alt_idx].entries[pos].1.clone();
                    if let Some(rec) = store.records.get(&pk) {
                        for b in buf.iter_mut() { *b = b' '; }
                        let actual_len = store.actual_lengths.as_ref()
                            .and_then(|m| m.get(&pk).copied())
                            .unwrap_or(rec.len());
                        let copy_len = actual_len.min(buf.len()).min(rec.len());
                        buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                        store.cursor = Some(pk);
                        Ok(actual_len)
                    } else {
                        Err(FileStatus::AtEnd)
                    }
                } else {
                    // Primary key iteration
                    let next_key = if store.start_positioned {
                        store.start_positioned = false;
                        store.cursor.clone()
                    } else {
                        match &store.cursor {
                            None => store.records.keys().next().cloned(),
                            Some(cur) => store.next_key_after(cur),
                        }
                    };
                    match next_key {
                        Some(key) => {
                            if let Some(rec) = store.records.get(&key) {
                                for b in buf.iter_mut() { *b = b' '; }
                                let actual_len = store.actual_lengths.as_ref()
                                    .and_then(|m| m.get(&key).copied())
                                    .unwrap_or(rec.len());
                                let copy_len = actual_len.min(buf.len()).min(rec.len());
                                buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                                store.cursor = Some(key);
                                Ok(actual_len)
                            } else {
                                Err(FileStatus::AtEnd)
                            }
                        }
                        None => Err(FileStatus::AtEnd),
                    }
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// READ KEY IS for variable-length records in INDEXED files.
    /// Returns (record_data, actual_len).
    pub fn read_variable_indexed_key(&mut self, key_data: &[u8], _ko: usize, _kl: usize, _max_rec_len: usize) -> Result<(Vec<u8>, usize), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                let search_key = key_data.to_vec();
                store.active_alt_key = None;
                match store.records.get(&search_key) {
                    Some(rec) => {
                        let actual_len = store.actual_lengths.as_ref()
                            .and_then(|m| m.get(&search_key).copied())
                            .unwrap_or(rec.len());
                        store.cursor = Some(search_key);
                        Ok((rec.clone(), actual_len))
                    }
                    None => Err(FileStatus::RecordNotFound),
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// REWRITE current record in a variable-length INDEXED file.
    /// Updates the actual_lengths entry for the record.
    pub fn rewrite_variable_indexed(&mut self, data: &[u8], actual_len: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if !store.writable { return Err(FileStatus::WriteNotAllowed); }
                let cursor_key = match &store.cursor {
                    Some(k) => k.clone(),
                    None => return Err(FileStatus::RecordNotFound),
                };
                let old_rec = match store.records.get(&cursor_key) {
                    Some(r) => r.clone(),
                    None => return Err(FileStatus::RecordNotFound),
                };
                let rl = store.record_len;
                let mut rec = vec![b' '; rl];
                let use_len = actual_len.min(data.len()).min(rl);
                rec[..use_len].copy_from_slice(&data[..use_len]);
                let new_key = store.extract_key(&rec);
                // Remove old alt key entries
                for alt in &mut store.alt_keys {
                    let old_ak = alt.extract_key(&old_rec);
                    alt.remove(&old_ak, &cursor_key);
                }
                if new_key != cursor_key {
                    if store.records.contains_key(&new_key) {
                        // Restore alt key entries since we removed them
                        for alt in &mut store.alt_keys {
                            let old_ak = alt.extract_key(&old_rec);
                            let _ = alt.insert(old_ak, cursor_key.clone());
                        }
                        return Err(FileStatus::DuplicateKey);
                    }
                    store.records.remove(&cursor_key);
                    if let Some(ref mut lengths) = store.actual_lengths {
                        lengths.remove(&cursor_key);
                        lengths.insert(new_key.clone(), use_len);
                    }
                    for alt in &mut store.alt_keys {
                        let new_ak = alt.extract_key(&rec);
                        let _ = alt.insert(new_ak, new_key.clone());
                    }
                    store.records.insert(new_key.clone(), rec);
                    store.cursor = Some(new_key);
                } else {
                    if let Some(ref mut lengths) = store.actual_lengths {
                        lengths.insert(cursor_key.clone(), use_len);
                    }
                    for alt in &mut store.alt_keys {
                        let new_ak = alt.extract_key(&rec);
                        let _ = alt.insert(new_ak, cursor_key.clone());
                    }
                    store.records.insert(cursor_key, rec);
                }
                store.modified = true;
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }
}
