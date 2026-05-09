// Indexed file organization — BTreeMap-backed keyed access.

use std::io::{Read, Write};
use std::fs::File;
use std::collections::BTreeMap;
use crate::FileStatus;
use super::CobolFile;

// ── AltKeyDef — alternate key definition for INDEXED files ────────────

/// Alternate key definition for INDEXED files.
/// Maintains a sorted flat list of (alt_key_value, primary_key) pairs.
pub struct AltKeyDef {
    /// (offset, length) pairs within the record for composite key extraction
    pub parts: Vec<(usize, usize)>,
    /// Whether duplicate alt key values are allowed
    pub with_duplicates: bool,
    /// SUPPRESS WHEN ALL character — if set, records whose alt key bytes are ALL this char are excluded
    pub suppress_char: Option<u8>,
    /// Sorted entries: (composite_alt_key, primary_key) — sorted by (alt_key, primary_key)
    pub(super) entries: Vec<(Vec<u8>, Vec<u8>)>,
}

impl Clone for AltKeyDef {
    fn clone(&self) -> Self {
        AltKeyDef {
            parts: self.parts.clone(),
            with_duplicates: self.with_duplicates,
            suppress_char: self.suppress_char,
            entries: self.entries.clone(),
        }
    }
}

impl AltKeyDef {
    pub(super) fn new(parts: Vec<(usize, usize)>, with_duplicates: bool, suppress_char: Option<u8>) -> Self {
        AltKeyDef { parts, with_duplicates, suppress_char, entries: Vec::new() }
    }

    pub(super) fn extract_key(&self, record: &[u8]) -> Vec<u8> {
        let mut key = Vec::new();
        for &(off, len) in &self.parts {
            let end = (off + len).min(record.len());
            let start = off.min(end);
            key.extend_from_slice(&record[start..end]);
        }
        key
    }

    pub(super) fn is_suppressed(&self, key: &[u8]) -> bool {
        if let Some(ch) = self.suppress_char {
            !key.is_empty() && key.iter().all(|&b| b == ch)
        } else {
            false
        }
    }

    pub(super) fn total_key_len(&self) -> usize {
        self.parts.iter().map(|&(_, len)| len).sum()
    }

    pub(super) fn insert(&mut self, alt_key: Vec<u8>, primary_key: Vec<u8>) -> Result<(), FileStatus> {
        if self.is_suppressed(&alt_key) {
            return Ok(()); // suppressed — don't add to index
        }
        // Check for exact duplicate
        if self.entries.iter().any(|(k, pk)| k == &alt_key && pk == &primary_key) {
            return Ok(());
        }
        if !self.with_duplicates {
            if self.entries.iter().any(|(k, _)| k == &alt_key) {
                return Err(FileStatus::DuplicateKey);
            }
        }
        // Insert at end of same-alt-key group to preserve insertion order for duplicates
        let pos = self.entries.partition_point(|(k, _)| *k <= alt_key);
        self.entries.insert(pos, (alt_key, primary_key));
        Ok(())
    }

    pub(super) fn remove(&mut self, alt_key: &[u8], primary_key: &[u8]) {
        self.entries.retain(|(k, pk)| !(k == alt_key && pk == primary_key));
    }

    /// Build alt key index from records in the given order.
    /// Uses stable sort by alt key to preserve the iteration order for duplicates.
    pub(super) fn build_from_records_ordered(&mut self, ordered_keys: &[Vec<u8>], records: &BTreeMap<Vec<u8>, Vec<u8>>) {
        self.entries.clear();
        for pk in ordered_keys {
            if let Some(rec) = records.get(pk) {
                let ak = self.extract_key(rec);
                if !self.is_suppressed(&ak) {
                    self.entries.push((ak, pk.clone()));
                }
            }
        }
        // Stable sort by alt key only — preserves insertion order for duplicate alt keys
        self.entries.sort_by(|a, b| a.0.cmp(&b.0));
    }

    pub(super) fn build_from_records(&mut self, records: &BTreeMap<Vec<u8>, Vec<u8>>) {
        let ordered: Vec<Vec<u8>> = records.keys().cloned().collect();
        self.build_from_records_ordered(&ordered, records);
    }
}

// ── IndexedStore — in-memory BTreeMap-based INDEXED file ────────────

/// In-memory store for ORGANIZATION INDEXED files.
/// Records are loaded into a BTreeMap on OPEN and flushed to disk on CLOSE.
/// This enables O(log n) key lookup, proper key ordering, DELETE, and
/// duplicate key detection — all of which the old flat-file approach lacked.
pub struct IndexedStore {
    pub(super) path: String,
    /// Primary key → full record bytes (always record_len bytes, space-padded)
    pub(super) records: BTreeMap<Vec<u8>, Vec<u8>>,
    /// For variable-length records: primary key → actual data length
    pub(super) actual_lengths: Option<BTreeMap<Vec<u8>, usize>>,
    pub(super) record_len: usize,
    /// Primary key parts: (offset, length) pairs supporting non-contiguous composite keys
    pub(super) primary_key_parts: Vec<(usize, usize)>,
    /// Key of the last-read record (cursor for READ NEXT / PREVIOUS / REWRITE / DELETE)
    pub(super) cursor: Option<Vec<u8>>,
    /// When true, cursor was set by START — READ NEXT should read AT cursor, not after it
    pub(super) start_positioned: bool,
    /// When true, file position indicator was invalidated by a failed START.
    /// Subsequent READ NEXT/PREVIOUS should return status 46 (NoCurrentRecord).
    pub(super) position_invalid: bool,
    pub(super) writable: bool,
    pub(super) modified: bool,
    /// Alternate key indices
    pub(super) alt_keys: Vec<AltKeyDef>,
    /// Which key index is active for iteration: None = primary, Some(i) = alt_keys[i]
    pub(super) active_alt_key: Option<usize>,
    /// Position within alt_keys[active].entries for sequential reads
    pub(super) alt_cursor_pos: usize,
    /// Tracks record insertion order for alt key duplicate ordering
    pub(super) insertion_order: Vec<Vec<u8>>,
    /// LOCK MODE: 0=none, 1=automatic, 2=manual
    pub(super) lock_mode: u8,
}

impl Clone for IndexedStore {
    fn clone(&self) -> Self {
        IndexedStore {
            path: self.path.clone(),
            records: self.records.clone(),
            actual_lengths: self.actual_lengths.clone(),
            record_len: self.record_len,
            primary_key_parts: self.primary_key_parts.clone(),
            cursor: self.cursor.clone(),
            start_positioned: self.start_positioned,
            position_invalid: self.position_invalid,
            writable: self.writable,
            modified: self.modified,
            alt_keys: self.alt_keys.clone(),
            active_alt_key: self.active_alt_key,
            alt_cursor_pos: self.alt_cursor_pos,
            insertion_order: self.insertion_order.clone(),
            lock_mode: self.lock_mode,
        }
    }
}

impl std::fmt::Debug for IndexedStore {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "IndexedStore({} records)", self.records.len())
    }
}

impl IndexedStore {
    /// Extract the primary key from a record (supports non-contiguous composite keys).
    pub(super) fn extract_key(&self, record: &[u8]) -> Vec<u8> {
        let mut key = Vec::new();
        for &(off, len) in &self.primary_key_parts {
            let end = (off + len).min(record.len());
            let start = off.min(end);
            key.extend_from_slice(&record[start..end]);
        }
        key
    }

    /// Check that an existing indexed file's data is consistent with the
    /// requested record_len. Returns Err(ConflictingAttr / 39) when the
    /// data section length isn't divisible by record_len — i.e. the caller
    /// declared a record size that doesn't match what's stored on disk.
    /// Empty/nonexistent files are treated as "no mismatch" (caller handles
    /// the not-found / empty cases separately).
    pub(super) fn check_record_size_compatibility(path: &str, record_len: usize) -> Result<(), FileStatus> {
        if record_len == 0 { return Ok(()); }
        let meta = match std::fs::metadata(path) {
            Ok(m) => m,
            Err(_) => return Ok(()),
        };
        let file_size = meta.len() as usize;
        if file_size == 0 { return Ok(()); }
        // Detect 4-byte "IRCL" magic
        let data_offset: usize = if let Ok(mut f) = File::open(path) {
            let mut hdr = [0u8; 4];
            if f.read_exact(&mut hdr).is_ok() && &hdr == b"IRCL" { 4 } else { 0 }
        } else { 0 };
        if file_size <= data_offset { return Ok(()); }
        let data_len = file_size - data_offset;
        if data_len % record_len != 0 {
            return Err(FileStatus::ConflictingAttr);
        }
        Ok(())
    }

    /// Load fixed-length records from a file into the BTreeMap.
    /// Expects a 4-byte "IRCL" header followed by fixed-length records.
    /// Returns (records, insertion_order) where insertion_order preserves file order.
    pub(super) fn load_fixed(path: &str, record_len: usize, key_parts: &[(usize, usize)]) -> (BTreeMap<Vec<u8>, Vec<u8>>, Vec<Vec<u8>>) {
        let mut map = BTreeMap::new();
        let mut order = Vec::new();
        if let Ok(mut file) = File::open(path) {
            // Skip the 4-byte magic header; if missing, try loading without header (legacy)
            let mut header = [0u8; 4];
            if file.read_exact(&mut header).is_err() {
                return (map, order);
            }
            if &header != b"IRCL" {
                // Legacy file without header — rewind and try reading from start
                drop(file);
                if let Ok(mut file2) = File::open(path) {
                    loop {
                        let mut rec = vec![0u8; record_len];
                        if file2.read_exact(&mut rec).is_err() {
                            break;
                        }
                        let mut key = Vec::new();
                        for &(off, len) in key_parts {
                            let end = (off + len).min(record_len);
                            let start = off.min(end);
                            key.extend_from_slice(&rec[start..end]);
                        }
                        order.push(key.clone());
                        map.insert(key, rec);
                    }
                }
                return (map, order);
            }
            loop {
                let mut rec = vec![0u8; record_len];
                if file.read_exact(&mut rec).is_err() {
                    break;
                }
                let mut key = Vec::new();
                for &(off, len) in key_parts {
                    let end = (off + len).min(record_len);
                    let start = off.min(end);
                    key.extend_from_slice(&rec[start..end]);
                }
                order.push(key.clone());
                map.insert(key, rec);
            }
        }
        (map, order)
    }

    /// Load variable-length records from a file into the BTreeMap.
    /// Expects a 4-byte "IRCL" header followed by [4-byte LE actual_len][padded-to-max_rec_len data] records.
    pub(super) fn load_variable(path: &str, max_rec_len: usize, key_parts: &[(usize, usize)])
        -> (BTreeMap<Vec<u8>, Vec<u8>>, BTreeMap<Vec<u8>, usize>, Vec<Vec<u8>>)
    {
        let mut map = BTreeMap::new();
        let mut lengths = BTreeMap::new();
        let mut order = Vec::new();
        if let Ok(mut file) = File::open(path) {
            // Skip the 4-byte magic header
            let mut header = [0u8; 4];
            if file.read_exact(&mut header).is_err() {
                return (map, lengths, order);
            }
            if &header != b"IRCL" {
                // Legacy file without header — rewind and try reading from start
                drop(file);
                if let Ok(mut file2) = File::open(path) {
                    loop {
                        let mut len_buf = [0u8; 4];
                        if file2.read_exact(&mut len_buf).is_err() { break; }
                        let actual_len = u32::from_le_bytes(len_buf) as usize;
                        let mut rec = vec![0u8; max_rec_len];
                        if file2.read_exact(&mut rec).is_err() { break; }
                        let mut key = Vec::new();
                        for &(off, len) in key_parts {
                            let end = (off + len).min(max_rec_len);
                            let start = off.min(end);
                            key.extend_from_slice(&rec[start..end]);
                        }
                        order.push(key.clone());
                        lengths.insert(key.clone(), actual_len);
                        map.insert(key, rec);
                    }
                }
                return (map, lengths, order);
            }
            loop {
                let mut len_buf = [0u8; 4];
                if file.read_exact(&mut len_buf).is_err() { break; }
                let actual_len = u32::from_le_bytes(len_buf) as usize;
                let mut rec = vec![0u8; max_rec_len];
                if file.read_exact(&mut rec).is_err() { break; }
                let mut key = Vec::new();
                for &(off, len) in key_parts {
                    let end = (off + len).min(max_rec_len);
                    let start = off.min(end);
                    key.extend_from_slice(&rec[start..end]);
                }
                order.push(key.clone());
                lengths.insert(key.clone(), actual_len);
                map.insert(key, rec);
            }
        }
        (map, lengths, order)
    }

    /// Flush all records to disk in insertion order.
    /// Writes a 4-byte "IRCL" header followed by records.
    pub(super) fn flush(&self) -> Result<(), FileStatus> {
        let mut file = File::create(&self.path)
            .map_err(|_| FileStatus::PermanentError)?;
        // Write magic header so empty indexed files are distinguishable from corrupt 0-byte files
        file.write_all(b"IRCL").map_err(|_| FileStatus::PermanentError)?;

        // Write records in insertion order to preserve alt key duplicate ordering across close/reopen
        let keys_in_order: Vec<&Vec<u8>> = if self.insertion_order.is_empty() {
            self.records.keys().collect()
        } else {
            // Use insertion_order, falling back to BTreeMap for any keys not tracked
            let mut ordered: Vec<&Vec<u8>> = self.insertion_order.iter()
                .filter(|k| self.records.contains_key(*k))
                .collect();
            // Add any keys not in insertion_order (shouldn't happen, but safety net)
            for k in self.records.keys() {
                if !self.insertion_order.contains(k) {
                    ordered.push(k);
                }
            }
            ordered
        };

        match &self.actual_lengths {
            Some(lengths) => {
                for key in &keys_in_order {
                    if let Some(rec) = self.records.get(*key) {
                        let actual_len = lengths.get(*key).copied().unwrap_or(rec.len());
                        let len_bytes = (actual_len as u32).to_le_bytes();
                        file.write_all(&len_bytes).map_err(|_| FileStatus::PermanentError)?;
                        file.write_all(rec).map_err(|_| FileStatus::PermanentError)?;
                    }
                }
            }
            None => {
                for key in &keys_in_order {
                    if let Some(rec) = self.records.get(*key) {
                        file.write_all(rec).map_err(|_| FileStatus::PermanentError)?;
                    }
                }
            }
        }
        file.flush().map_err(|_| FileStatus::PermanentError)?;
        Ok(())
    }

    /// Find the next key strictly after the given key.
    pub(super) fn next_key_after(&self, key: &[u8]) -> Option<Vec<u8>> {
        use std::ops::Bound::*;
        self.records.range((Excluded(key.to_vec()), Unbounded))
            .next()
            .map(|(k, _)| k.clone())
    }

    /// Find the previous key strictly before the given key.
    pub(super) fn prev_key_before(&self, key: &[u8]) -> Option<Vec<u8>> {
        self.records.range(..key.to_vec())
            .next_back()
            .map(|(k, _)| k.clone())
    }
}

// ── impl CobolFile — INDEXED methods ──────────────────────────────────

impl CobolFile {
    /// Open an INDEXED file for OUTPUT (creates/truncates).
    pub fn open_indexed_output(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        if let Some(parent) = std::path::Path::new(path).parent() {
            if !parent.as_os_str().is_empty() && (!parent.exists() || !parent.is_dir()) {
                return Err(FileStatus::PermanentError);
            }
        }
        // Create/truncate the file to establish it on disk
        File::create(path).map_err(|e| Self::map_io_error(&e))?;
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records: BTreeMap::new(),
            actual_lengths: None,
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: true,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order: Vec::new(),
            lock_mode: 0,
        })))
    }

    /// Open an INDEXED file for INPUT.
    pub fn open_indexed_input(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        let p = std::path::Path::new(path);
        if !p.exists() {
            return Err(FileStatus::FileNotFound);
        }
        // A 0-byte file is not a valid indexed file (matches GnuCOBOL BDB behavior)
        if p.metadata().map(|m| m.len()).unwrap_or(0) == 0 {
            return Err(FileStatus::PermanentError);
        }
        IndexedStore::check_record_size_compatibility(path, record_len)?;
        let (records, insertion_order) = IndexedStore::load_fixed(path, record_len, &key_parts);
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records,
            actual_lengths: None,
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: false,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order,
            lock_mode: 0,
        })))
    }

    /// WRITE to an INDEXED file(insert record, check for duplicate primary key).
    pub fn indexed_write(&mut self, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if !store.writable { return Err(FileStatus::WriteNotAllowed); }
                // LOCK MODE AUTOMATIC/MANUAL: simulate record lock error (48)
                if store.lock_mode == 1 || store.lock_mode == 2 {
                    return Err(FileStatus::WriteNotAllowed);
                }
                let mut rec = vec![b' '; store.record_len];
                let copy_len = data.len().min(store.record_len);
                rec[..copy_len].copy_from_slice(&data[..copy_len]);
                let key = store.extract_key(&rec);
                if std::env::var("IRONCLAD_DEBUG_INDEXED").is_ok() {
                    eprintln!("[IDX WRITE] file={} key={:02x?} dup={}",
                        store.path, &key, store.records.contains_key(&key));
                }
                if store.records.contains_key(&key) {
                    return Err(FileStatus::DuplicateKey);
                }
                // Check and insert into alternate key indices
                for alt in &mut store.alt_keys {
                    let ak = alt.extract_key(&rec);
                    alt.insert(ak, key.clone())?;
                }
                store.insertion_order.push(key.clone());
                store.records.insert(key.clone(), rec);
                store.cursor = Some(key);
                store.position_invalid = false;
                store.modified = true;
                Ok(())
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// Sequential READ NEXT from an INDEXED file.
    /// When active_alt_key is set, iterates in alternate key order.
    /// Otherwise iterates in primary key order.
    pub fn indexed_read_next(&mut self, buf: &mut [u8]) -> Result<(), FileStatus> {
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
                        let copy_len = buf.len().min(rec.len());
                        buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                        for b in buf[copy_len..].iter_mut() { *b = b' '; }
                        store.cursor = Some(pk);
                        Ok(())
                    } else {
                        Err(FileStatus::AtEnd)
                    }
                } else {
                    // Primary key iteration (existing logic)
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
                                let copy_len = buf.len().min(rec.len());
                                buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                                for b in buf[copy_len..].iter_mut() { *b = b' '; }
                                store.cursor = Some(key);
                                Ok(())
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

    /// READ PREVIOUS from an INDEXED file.
    /// When active_alt_key is set, iterates in reverse alternate key order.
    pub fn indexed_read_previous(&mut self, buf: &mut [u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                // After a failed START, return NoCurrentRecord (46)
                if store.position_invalid {
                    return Err(FileStatus::NoCurrentRecord);
                }
                if let Some(alt_idx) = store.active_alt_key {
                    // Alternate key reverse iteration
                    let entries_len = store.alt_keys[alt_idx].entries.len();
                    if entries_len == 0 { return Err(FileStatus::AtEnd); }
                    let pos = if store.start_positioned {
                        store.start_positioned = false;
                        store.alt_cursor_pos
                    } else if store.alt_cursor_pos == 0 {
                        return Err(FileStatus::AtEnd);
                    } else {
                        store.alt_cursor_pos - 1
                    };
                    if pos >= entries_len { return Err(FileStatus::AtEnd); }
                    store.alt_cursor_pos = pos;
                    let pk = store.alt_keys[alt_idx].entries[pos].1.clone();
                    if let Some(rec) = store.records.get(&pk) {
                        let copy_len = buf.len().min(rec.len());
                        buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                        for b in buf[copy_len..].iter_mut() { *b = b' '; }
                        store.cursor = Some(pk);
                        Ok(())
                    } else {
                        Err(FileStatus::AtEnd)
                    }
                } else {
                    // Primary key reverse iteration (existing logic)
                    let prev_key = if store.start_positioned {
                        store.start_positioned = false;
                        store.cursor.clone()
                    } else {
                        match &store.cursor {
                            None => store.records.keys().next_back().cloned(),
                            Some(cur) => store.prev_key_before(cur),
                        }
                    };
                    match prev_key {
                        Some(key) => {
                            if let Some(rec) = store.records.get(&key) {
                                let copy_len = buf.len().min(rec.len());
                                buf[..copy_len].copy_from_slice(&rec[..copy_len]);
                                for b in buf[copy_len..].iter_mut() { *b = b' '; }
                                store.cursor = Some(key);
                                Ok(())
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

    /// READ KEY IS — find a record by key value in an INDEXED file.
    pub fn indexed_read_key(&mut self, key_data: &[u8], _ko: usize, _kl: usize) -> Result<Vec<u8>, FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                // LOCK MODE AUTOMATIC/MANUAL: simulate record lock error (47)
                if store.lock_mode == 1 || store.lock_mode == 2 {
                    return Err(FileStatus::ReadNotAllowed);
                }
                let search_key = key_data.to_vec();
                store.active_alt_key = None;
                if std::env::var("IRONCLAD_DEBUG_INDEXED").is_ok() {
                    eprintln!("[IDX READ ] file={} key={:02x?} found={}",
                        store.path, &search_key, store.records.contains_key(&search_key));
                }
                match store.records.get(&search_key) {
                    Some(rec) => {
                        store.cursor = Some(search_key);
                        store.position_invalid = false;
                        Ok(rec.clone())
                    }
                    None => Err(FileStatus::RecordNotFound),
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// START with key comparison for INDEXED files.
    /// Positions the cursor at the first record matching the comparison.
    /// cmp: "ge" (>=), "gt" (>), "eq" (=), "le" (<=), "lt" (<)
    /// Supports partial key matching: only the first `key_data.len()` bytes are compared
    /// when key_data is shorter than the full key length.
    pub fn indexed_start_key(&mut self, cmp: &str, key_data: &[u8], _ko: usize, kl: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                store.active_alt_key = None;
                if store.records.is_empty() {
                    store.position_invalid = true;
                    return Err(FileStatus::RecordNotFound);
                }
                // Use the actual key_data length for partial key matching
                let compare_len = key_data.len().min(kl);
                let search = key_data[..compare_len].to_vec();

                let found = match cmp {
                    "eq" => {
                        store.records.keys().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix == search.as_slice()
                        }).cloned()
                    }
                    "ge" => {
                        store.records.keys().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix >= search.as_slice()
                        }).cloned()
                    }
                    "gt" => {
                        store.records.keys().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix > search.as_slice()
                        }).cloned()
                    }
                    "le" => {
                        store.records.keys().rev().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix <= search.as_slice()
                        }).cloned()
                    }
                    "lt" => {
                        store.records.keys().rev().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix < search.as_slice()
                        }).cloned()
                    }
                    _ => {
                        store.records.keys().find(|k| {
                            let k_prefix = &k[..compare_len.min(k.len())];
                            k_prefix >= search.as_slice()
                        }).cloned()
                    }
                };

                match found {
                    Some(k) => {
                        store.cursor = Some(k);
                        store.start_positioned = true;
                        store.position_invalid = false;
                        Ok(())
                    }
                    None => {
                        store.position_invalid = true;
                        Err(FileStatus::RecordNotFound)
                    }
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// START FIRST for INDEXED files — position at the first record.
    pub fn indexed_start_first(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                store.active_alt_key = None;
                match store.records.keys().next() {
                    Some(k) => {
                        store.cursor = Some(k.clone());
                        store.start_positioned = true;
                        store.position_invalid = false;
                        Ok(())
                    }
                    None => {
                        store.position_invalid = true;
                        Err(FileStatus::RecordNotFound)
                    }
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// START LAST for INDEXED files — position at the last record.
    pub fn indexed_start_last(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                store.active_alt_key = None;
                match store.records.keys().next_back() {
                    Some(k) => {
                        store.cursor = Some(k.clone());
                        store.start_positioned = true;
                        store.position_invalid = false;
                        Ok(())
                    }
                    None => {
                        store.position_invalid = true;
                        Err(FileStatus::RecordNotFound)
                    }
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// Open an INDEXED file for I-O (read-write).
    pub fn open_indexed_io(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        if !std::path::Path::new(path).exists() {
            return Err(FileStatus::FileNotFound);
        }
        IndexedStore::check_record_size_compatibility(path, record_len)?;
        let (records, insertion_order) = IndexedStore::load_fixed(path, record_len, &key_parts);
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records,
            actual_lengths: None,
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: true,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order,
            lock_mode: 0,
        })))
    }

    /// Open an INDEXED OPTIONAL file for I-O (read-write).
    pub fn open_indexed_io_optional(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        if std::path::Path::new(path).exists() {
            IndexedStore::check_record_size_compatibility(path, record_len)?;
            let (records, insertion_order) = IndexedStore::load_fixed(path, record_len, &key_parts);
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records,
                actual_lengths: None,
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: true,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order,
                lock_mode: 0,
            })), false))
        } else {
            // OPTIONAL file not found: create empty
            File::create(path).map_err(|e| Self::map_io_error(&e))?;
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records: BTreeMap::new(),
                actual_lengths: None,
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: true,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order: Vec::new(),
                lock_mode: 0,
            })), true))
        }
    }

    /// Open an INDEXED OPTIONAL file for INPUT.
    pub fn open_indexed_input_optional(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        let p = std::path::Path::new(path);
        if p.exists() {
            // A 0-byte file is not a valid indexed file (matches GnuCOBOL BDB behavior)
            if p.metadata().map(|m| m.len()).unwrap_or(0) == 0 {
                return Err(FileStatus::PermanentError);
            }
            IndexedStore::check_record_size_compatibility(path, record_len)?;
            let (records, insertion_order) = IndexedStore::load_fixed(path, record_len, &key_parts);
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records,
                actual_lengths: None,
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: false,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order,
                lock_mode: 0,
            })), false))
        } else {
            // OPTIONAL file not found: create empty file
            File::create(path).map_err(|e| Self::map_io_error(&e))?;
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records: BTreeMap::new(),
                actual_lengths: None,
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: false,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order: Vec::new(),
                lock_mode: 0,
            })), true))
        }
    }

    // ── Variable-length INDEXED open methods ──────────────────────────

    /// Open a variable-length INDEXED file for OUTPUT (creates/truncates).
    pub fn open_indexed_output_variable(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        if let Some(parent) = std::path::Path::new(path).parent() {
            if !parent.as_os_str().is_empty() && (!parent.exists() || !parent.is_dir()) {
                return Err(FileStatus::PermanentError);
            }
        }
        File::create(path).map_err(|e| Self::map_io_error(&e))?;
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records: BTreeMap::new(),
            actual_lengths: Some(BTreeMap::new()),
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: true,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order: Vec::new(),
            lock_mode: 0,
        })))
    }

    /// Open a variable-length INDEXED file for I-O (read-write).
    pub fn open_indexed_io_variable(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        if !std::path::Path::new(path).exists() {
            return Err(FileStatus::FileNotFound);
        }
        let (records, lengths, insertion_order) = IndexedStore::load_variable(path, record_len, &key_parts);
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records,
            actual_lengths: Some(lengths),
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: true,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order,
            lock_mode: 0,
        })))
    }

    /// Open a variable-length INDEXED OPTIONAL file for I-O (read-write).
    pub fn open_indexed_io_optional_variable(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        if std::path::Path::new(path).exists() {
            let (records, lengths, insertion_order) = IndexedStore::load_variable(path, record_len, &key_parts);
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records,
                actual_lengths: Some(lengths),
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: true,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order,
                lock_mode: 0,
            })), false))
        } else {
            File::create(path).map_err(|e| Self::map_io_error(&e))?;
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records: BTreeMap::new(),
                actual_lengths: Some(BTreeMap::new()),
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: true,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order: Vec::new(),
                lock_mode: 0,
            })), true))
        }
    }

    /// Open a variable-length INDEXED OPTIONAL file for INPUT.
    pub fn open_indexed_input_optional_variable(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<(Self, bool), FileStatus> {
        Self::validate_path(path)?;
        let p = std::path::Path::new(path);
        if p.exists() {
            if p.metadata().map(|m| m.len()).unwrap_or(0) == 0 {
                return Err(FileStatus::PermanentError);
            }
            let (records, lengths, insertion_order) = IndexedStore::load_variable(path, record_len, &key_parts);
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records,
                actual_lengths: Some(lengths),
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: false,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order,
                lock_mode: 0,
            })), false))
        } else {
            File::create(path).map_err(|e| Self::map_io_error(&e))?;
            Ok((CobolFile::Indexed(Box::new(IndexedStore {
                path: path.to_string(),
                records: BTreeMap::new(),
                actual_lengths: Some(BTreeMap::new()),
                record_len,
                primary_key_parts: key_parts,
                cursor: None,
                start_positioned: false,
                position_invalid: false,
                writable: false,
                modified: false,
                alt_keys: Vec::new(),
                active_alt_key: None,
                alt_cursor_pos: 0,
                insertion_order: Vec::new(),
                lock_mode: 0,
            })), true))
        }
    }

    /// Open a variable-length INDEXED file for INPUT.
    pub fn open_indexed_input_variable(path: &str, record_len: usize, key_parts: Vec<(usize, usize)>) -> Result<Self, FileStatus> {
        Self::validate_path(path)?;
        let p = std::path::Path::new(path);
        if !p.exists() {
            return Err(FileStatus::FileNotFound);
        }
        if p.metadata().map(|m| m.len()).unwrap_or(0) == 0 {
            return Err(FileStatus::PermanentError);
        }
        let (records, lengths, insertion_order) = IndexedStore::load_variable(path, record_len, &key_parts);
        Ok(CobolFile::Indexed(Box::new(IndexedStore {
            path: path.to_string(),
            records,
            actual_lengths: Some(lengths),
            record_len,
            primary_key_parts: key_parts,
            cursor: None,
            start_positioned: false,
            position_invalid: false,
            writable: false,
            modified: false,
            alt_keys: Vec::new(),
            active_alt_key: None,
            alt_cursor_pos: 0,
            insertion_order,
            lock_mode: 0,
        })))
    }

    /// REWRITE current record in an INDEXED file.
    pub fn indexed_rewrite(&mut self, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if !store.writable { return Err(FileStatus::WriteNotAllowed); }
                // LOCK MODE AUTOMATIC/MANUAL: simulate record lock error (49)
                if store.lock_mode == 1 || store.lock_mode == 2 {
                    return Err(FileStatus::DeleteNotAllowed);
                }
                let cursor_key = match &store.cursor {
                    Some(k) => k.clone(),
                    None => return Err(FileStatus::RecordNotFound),
                };
                let old_rec = match store.records.get(&cursor_key) {
                    Some(r) => r.clone(),
                    None => return Err(FileStatus::RecordNotFound),
                };
                let mut rec = vec![b' '; store.record_len];
                let copy_len = data.len().min(store.record_len);
                rec[..copy_len].copy_from_slice(&data[..copy_len]);
                let new_key = store.extract_key(&rec);
                // Remove old alt key entries
                for alt in &mut store.alt_keys {
                    let old_ak = alt.extract_key(&old_rec);
                    alt.remove(&old_ak, &cursor_key);
                }
                // GnuCOBOL semantics: REWRITE replaces the record at the
                // cursor's PRIMARY KEY position, regardless of whether the
                // user changed the primary-key bytes in the buffer. The new
                // record's bytes are stored as-is under cursor_key. Alt key
                // indices are updated based on the new bytes. A "with
                // DUPLICATES" alt key that now collides with another record's
                // alt key surfaces as status 02 (warning).
                let _ = new_key; // not used for storage; kept for any future spec change
                let mut had_alt_dup = false;
                for alt in &mut store.alt_keys {
                    let new_ak = alt.extract_key(&rec);
                    let old_ak = alt.extract_key(&old_rec);
                    // GnuCOBOL: status 02 only when this REWRITE *changed* the alt
                    // key value AND the new value collides with an existing record.
                    // A REWRITE that leaves the alt key bytes unchanged returns 00
                    // even if the file already contained duplicates of that value.
                    if alt.with_duplicates && new_ak != old_ak && !alt.is_suppressed(&new_ak) {
                        if alt.entries.iter().any(|(k, pk)| k == &new_ak && pk != &cursor_key) {
                            had_alt_dup = true;
                        }
                    }
                    let _ = alt.insert(new_ak, cursor_key.clone());
                }
                store.records.insert(cursor_key, rec);
                store.modified = true;
                if had_alt_dup {
                    Err(FileStatus::SuccessDuplicate)
                } else {
                    Ok(())
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    /// DELETE current record from an INDEXED file.
    pub fn indexed_delete(&mut self) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if !store.writable { return Err(FileStatus::WriteNotAllowed); }
                let cursor_key = match &store.cursor {
                    Some(k) => k.clone(),
                    None => return Err(FileStatus::NoCurrentRecord),
                };
                if let Some(old_rec) = store.records.remove(&cursor_key) {
                    // Remove from alt key indices
                    for alt in &mut store.alt_keys {
                        let ak = alt.extract_key(&old_rec);
                        alt.remove(&ak, &cursor_key);
                    }
                    if let Some(ref mut lengths) = store.actual_lengths {
                        lengths.remove(&cursor_key);
                    }
                    store.insertion_order.retain(|k| k != &cursor_key);
                    // Position cursor at next record after deleted one
                    store.cursor = store.next_key_after(&cursor_key)
                        .or_else(|| store.prev_key_before(&cursor_key));
                    store.modified = true;
                    Ok(())
                } else {
                    Err(FileStatus::RecordNotFound)
                }
            }
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    // ── Alternate key methods ──────────────────────────────────────

    /// Register an alternate key definition. Call after OPEN to set up alt key indices.
    /// `parts`: Vec of (offset, length) pairs for composite key extraction.
    /// Automatically rebuilds the index from existing records.
    pub fn register_alt_key(&mut self, parts: Vec<(usize, usize)>, with_duplicates: bool, suppress_char: Option<u8>) {
        match self {
            CobolFile::Indexed(store) => {
                let mut alt = AltKeyDef::new(parts, with_duplicates, suppress_char);
                alt.build_from_records_ordered(&store.insertion_order, &store.records);
                store.alt_keys.push(alt);
            }
            _ => {}
        }
    }

    /// Set the LOCK MODE for an INDEXED file.
    /// 0 = none/exclusive, 1 = automatic, 2 = manual.
    /// When automatic or manual, WRITE/READ/REWRITE operations will return
    /// lock-related status codes (47/48/49) to simulate record locking.
    pub fn set_lock_mode(&mut self, mode: u8) {
        match self {
            CobolFile::Indexed(store) => {
                store.lock_mode = mode;
            }
            _ => {}
        }
    }

    /// READ KEY IS for an alternate key — look up record by alt key value.
    /// `alt_idx`: index into the registered alt keys (0-based).
    pub fn indexed_read_alt_key(&mut self, alt_idx: usize, key_data: &[u8]) -> Result<Vec<u8>, FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if alt_idx >= store.alt_keys.len() {
                    return Err(FileStatus::RecordNotFound);
                }
                let search_key = key_data.to_vec();
                // Find the first entry with matching alt key
                let found = store.alt_keys[alt_idx].entries.iter()
                    .find(|(ak, _)| *ak == search_key);
                match found {
                    Some((_, pk)) => {
                        let pk = pk.clone();
                        if let Some(rec) = store.records.get(&pk) {
                            store.cursor = Some(pk);
                            store.active_alt_key = Some(alt_idx);
                            store.position_invalid = false;
                            // Set alt_cursor_pos to this entry's position
                            if let Some(pos) = store.alt_keys[alt_idx].entries.iter()
                                .position(|(ak, p)| *ak == search_key && *p == store.cursor.as_ref().unwrap().clone())
                            {
                                store.alt_cursor_pos = pos;
                            }
                            Ok(rec.clone())
                        } else {
                            Err(FileStatus::RecordNotFound)
                        }
                    }
                    None => Err(FileStatus::RecordNotFound),
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    /// START with key comparison for an alternate key in INDEXED files.
    /// Positions the cursor and sets the active alt key for subsequent READ NEXT/PREVIOUS.
    pub fn indexed_start_alt_key(&mut self, alt_idx: usize, cmp: &str, key_data: &[u8], kl: usize) -> Result<(), FileStatus> {
        match self {
            CobolFile::Indexed(store) => {
                if alt_idx >= store.alt_keys.len() {
                    return Err(FileStatus::RecordNotFound);
                }
                let entries = &store.alt_keys[alt_idx].entries;
                if entries.is_empty() {
                    return Err(FileStatus::RecordNotFound);
                }
                let compare_len = key_data.len().min(kl);
                let search = &key_data[..compare_len];

                let found_pos = match cmp {
                    "eq" => entries.iter().position(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix == search
                    }),
                    "ge" => entries.iter().position(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix >= search
                    }),
                    "gt" => entries.iter().position(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix > search
                    }),
                    "le" => entries.iter().rposition(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix <= search
                    }),
                    "lt" => entries.iter().rposition(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix < search
                    }),
                    _ => entries.iter().position(|(ak, _)| {
                        let ak_prefix = &ak[..compare_len.min(ak.len())];
                        ak_prefix >= search
                    }),
                };

                match found_pos {
                    Some(pos) => {
                        let pk = entries[pos].1.clone();
                        store.cursor = Some(pk);
                        store.active_alt_key = Some(alt_idx);
                        store.alt_cursor_pos = pos;
                        store.start_positioned = true;
                        store.position_invalid = false;
                        Ok(())
                    }
                    None => {
                        store.position_invalid = true;
                        Err(FileStatus::RecordNotFound)
                    }
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }
}
