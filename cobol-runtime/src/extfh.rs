//! EXTFH — Extended File Handler callable interface.
//!
//! Implements the `CALL "EXTFH" USING action-code, fcd` interface that
//! GnuCOBOL-style COBOL programs use for explicit file I/O through the
//! File Control Descriptor (FCD).
//!
//! # Design
//! * File handles are kept in a thread-local `HashMap<u64, CobolFile>`.
//!   The key is an opaque handle ID written into `FCD-HANDLE`.
//! * FCD field access goes through the named-field API on `CobolRecord`
//!   (all FCD sub-fields are present once `copy xfhfcd3.` is properly
//!   expanded by the transpiler).
//! * Filename and record data are located by decoding the byte offsets
//!   stored in `FCD-FILENAME-ADDRESS` / `FCD-RECORD-ADDRESS` (the 8-byte
//!   LE image written by `record.set_address_of`).

use std::cell::RefCell;
use std::collections::HashMap;

use crate::CobolFile;
use crate::field::CobolRecord;

// ── Handle registry ─────────────────────────────────────────────────────────

thread_local! {
    static HANDLES: RefCell<HashMap<u64, CobolFile>> = RefCell::new(HashMap::new());
    static NEXT_ID: std::cell::Cell<u64> = const { std::cell::Cell::new(1) };
}

fn alloc_handle(file: CobolFile) -> u64 {
    NEXT_ID.with(|c| {
        let id = c.get();
        c.set(id + 1);
        HANDLES.with(|h| h.borrow_mut().insert(id, file));
        id
    })
}

fn release_handle(id: u64) -> Option<CobolFile> {
    HANDLES.with(|h| h.borrow_mut().remove(&id))
}

fn with_handle<F, R>(id: u64, f: F) -> Option<R>
where
    F: FnOnce(&mut CobolFile) -> R,
{
    HANDLES.with(|h| {
        let mut map = h.borrow_mut();
        map.get_mut(&id).map(f)
    })
}

// ── Status helpers ──────────────────────────────────────────────────────────

/// Two-byte COBOL file status code ("00", "10", "22", etc.)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct FileStatus2(u8, u8);

impl FileStatus2 {
    pub const OK: Self = Self(b'0', b'0');
    pub const AT_END: Self = Self(b'1', b'0');
    pub const DUP_KEY: Self = Self(b'2', b'2');
    pub const NOT_FOUND: Self = Self(b'2', b'3');
    pub const FILE_NOT_FOUND: Self = Self(b'3', b'5');
    pub const PERM_DENIED: Self = Self(b'3', b'7');
    pub const NOT_OPEN: Self = Self(b'4', b'2');
    pub const SEQ_READ_ERR: Self = Self(b'4', b'6');
    pub const READ_NOT_ALLOWED: Self = Self(b'4', b'7');
    pub const WRITE_NOT_ALLOWED: Self = Self(b'4', b'8');
    pub const NOT_IMPL: Self = Self(b'9', b'1');

    fn bytes(self) -> [u8; 2] {
        [self.0, self.1]
    }
}

impl From<crate::FileStatus> for FileStatus2 {
    fn from(fs: crate::FileStatus) -> Self {
        let (s1, s2) = fs.code();
        // Map the digit pair into ASCII characters.
        Self(b'0' + (s1 & 0x0f), b'0' + (s2 & 0x0f))
    }
}

// ── FCD field access helpers ────────────────────────────────────────────────

/// Read the 2-byte action code (big-endian u16).
fn read_opcode(record: &CobolRecord, opcode_field: &str) -> u16 {
    let bytes = record.get_bytes(opcode_field);
    let hi = bytes.first().copied().unwrap_or(0) as u16;
    let lo = bytes.get(1).copied().unwrap_or(0) as u16;
    (hi << 8) | lo
}

/// Write FCD file-status bytes. Tries the composite field first, then
/// the two 1-byte sub-fields emitted by the xfhfcd3 copybook.
fn set_fcd_status(record: &mut CobolRecord, status: FileStatus2) {
    if record.has_field("FCD-FILE-STATUS") {
        record.set_bytes("FCD-FILE-STATUS", &status.bytes());
        return;
    }
    if record.has_field("FCD-STATUS-KEY-1") {
        record.set_bytes("FCD-STATUS-KEY-1", &[status.0]);
    }
    if record.has_field("FCD-STATUS-KEY-2") {
        record.set_bytes("FCD-STATUS-KEY-2", &[status.1]);
    }
}

/// Decode an 8-byte LE image stored at `offset` as a usize.
fn read_u64_le_at(record: &CobolRecord, offset: usize) -> u64 {
    let bytes = record.get_bytes_raw_offset(offset, 8);
    let mut buf = [0u8; 8];
    let n = bytes.len().min(8);
    buf[..n].copy_from_slice(&bytes[..n]);
    u64::from_le_bytes(buf)
}

fn write_u64_le_at(record: &mut CobolRecord, offset: usize, value: u64) {
    record.set_bytes_raw_offset(offset, &value.to_le_bytes());
}

/// Read a field as an unsigned big-endian integer of its declared width
/// (COMP-X style). Returns 0 for missing fields.
fn read_be_u(record: &CobolRecord, name: &str) -> u64 {
    if !record.has_field(name) {
        return 0;
    }
    let bytes = record.get_bytes(name);
    let mut v: u64 = 0;
    for &b in bytes {
        v = (v << 8) | (b as u64);
    }
    v
}

/// Write a big-endian unsigned integer into a field's declared width.
fn write_be_u(record: &mut CobolRecord, name: &str, value: u64) {
    let (_, size) = match record.field_offset_len(name) {
        Some(v) => v,
        None => return,
    };
    let mut buf = [0u8; 8];
    for i in 0..size.min(8) {
        buf[size.min(8) - 1 - i] = ((value >> (i * 8)) & 0xff) as u8;
    }
    let slice = &buf[..size.min(8)];
    record.set_bytes(name, slice);
}

/// Read the handle ID (stored as LE u64 in the 8-byte pointer slot).
fn read_handle(record: &CobolRecord) -> u64 {
    if let Some((off, _)) = record.field_offset_len("FCD-HANDLE") {
        return read_u64_le_at(record, off);
    }
    if let Some((off, _)) = record.field_offset_len("FCD-PTR-FILLER1") {
        return read_u64_le_at(record, off);
    }
    0
}

fn write_handle(record: &mut CobolRecord, id: u64) {
    if let Some((off, _)) = record.field_offset_len("FCD-HANDLE") {
        write_u64_le_at(record, off, id);
        return;
    }
    if let Some((off, _)) = record.field_offset_len("FCD-PTR-FILLER1") {
        write_u64_le_at(record, off, id);
    }
}

/// Read the filename from wherever FCD-FILENAME-ADDRESS points.
fn read_filename(record: &CobolRecord) -> String {
    let addr_off = if let Some((off, _)) = record.field_offset_len("FCD-FILENAME-ADDRESS") {
        off
    } else if let Some((off, _)) = record.field_offset_len("FCD-PTR-FILLER3") {
        off
    } else {
        return String::new();
    };
    let name_len = read_be_u(record, "FCD-NAME-LENGTH") as usize;
    let target = read_u64_le_at(record, addr_off) as usize;
    if name_len == 0 || target == 0 || target == usize::MAX {
        return String::new();
    }
    // Pointer values stored by `address_of_ptr` are 1-based (offset + 1)
    // so that 0 unambiguously means NULL. Convert back to 0-based here.
    let real_off = target - 1;
    let bytes = record.get_bytes_raw_offset(real_off, name_len);
    String::from_utf8_lossy(bytes).trim_end().to_string()
}

/// Return the (offset, length) of the record buffer referenced by
/// FCD-RECORD-ADDRESS, or None if unset.
fn record_target(record: &CobolRecord) -> Option<usize> {
    let addr_off = record
        .resolve_field("FCD-RECORD-ADDRESS")
        .map(|(_, off)| off)
        .or_else(|| record.field_offset_len("FCD-PTR-FILLER2").map(|(off, _)| off))?;
    let t = read_u64_le_at(record, addr_off) as usize;
    if t == 0 || t == usize::MAX { None } else { Some(t - 1) }
}

fn set_open_mode(record: &mut CobolRecord, mode: u8) {
    if record.has_field("FCD-OPEN-MODE") {
        record.set_bytes("FCD-OPEN-MODE", &[mode]);
    }
}

fn get_organization(record: &CobolRecord) -> u8 {
    read_be_u(record, "FCD-ORGANIZATION") as u8
}

fn get_max_rec_len(record: &CobolRecord) -> usize {
    let v = read_be_u(record, "FCD-MAX-REC-LENGTH") as usize;
    if v == 0 { 512 } else { v }
}

// ── OPEN ────────────────────────────────────────────────────────────────────

#[derive(Clone, Copy)]
enum OpenMode { Input, Output, Io, Extend }

fn do_open(record: &mut CobolRecord, mode: OpenMode) {
    let filename = read_filename(record);
    if filename.is_empty() {
        set_fcd_status(record, FileStatus2::FILE_NOT_FOUND);
        return;
    }

    let resolved = std::env::var(&filename)
        .or_else(|_| std::env::var(format!("DD_{}", filename)))
        .unwrap_or_else(|_| filename.clone());

    let result = match mode {
        OpenMode::Input  => CobolFile::open_input(&resolved),
        OpenMode::Output => CobolFile::open_output(&resolved),
        OpenMode::Io     => CobolFile::open_io(&resolved),
        OpenMode::Extend => CobolFile::open_extend(&resolved),
    };

    match result {
        Ok(f) => {
            let id = alloc_handle(f);
            write_handle(record, id);
            // debug removed
            let mode_byte: u8 = match mode {
                OpenMode::Input  => 0,
                OpenMode::Output => 1,
                OpenMode::Io     => 2,
                OpenMode::Extend => 3,
            };
            set_open_mode(record, mode_byte);
            set_fcd_status(record, FileStatus2::OK);
        }
        Err(e) => {
            write_handle(record, 0);
            set_open_mode(record, 128);
            set_fcd_status(record, FileStatus2::from(e));
        }
    }
}

// ── CLOSE ───────────────────────────────────────────────────────────────────

fn do_close(record: &mut CobolRecord) {
    let id = read_handle(record);
    if id == 0 {
        set_fcd_status(record, FileStatus2::NOT_OPEN);
        return;
    }
    match release_handle(id) {
        Some(mut f) => {
            let _ = f.close();
            drop(f);
            write_handle(record, 0);
            set_open_mode(record, 128);
            set_fcd_status(record, FileStatus2::OK);
        }
        None => {
            set_fcd_status(record, FileStatus2::NOT_OPEN);
        }
    }
}

// ── READ ────────────────────────────────────────────────────────────────────

fn do_read_seq(record: &mut CobolRecord) {
    let id = read_handle(record);
    if id == 0 {
        set_fcd_status(record, FileStatus2::NOT_OPEN);
        return;
    }
    let max_len = get_max_rec_len(record).max(1);
    let org = get_organization(record);

    let read_result = with_handle(id, |f| {
        if org == 0 {
            let mut buf = vec![b' '; max_len];
            match f.read_line() {
                Ok(line) => {
                    let bytes = line.as_bytes();
                    let n = bytes.len().min(max_len);
                    buf[..n].copy_from_slice(&bytes[..n]);
                    Ok((buf, n))
                }
                Err(e) => Err(e),
            }
        } else {
            let mut buf = vec![b' '; max_len];
            match f.read_record(&mut buf) {
                Ok(n) => Ok((buf, n)),
                Err(e) => Err(e),
            }
        }
    });

    match read_result {
        Some(Ok((data, n))) => {
            if let Some(offset) = record_target(record) {
                record.set_bytes_raw_offset(offset, &data[..data.len().min(max_len)]);
            }
            write_be_u(record, "FCD-CURRENT-REC-LEN", n as u64);
            set_fcd_status(record, FileStatus2::OK);
        }
        Some(Err(e)) => {
            set_fcd_status(record, FileStatus2::from(e));
        }
        None => {
            set_fcd_status(record, FileStatus2::NOT_OPEN);
        }
    }
}

// ── WRITE ───────────────────────────────────────────────────────────────────

fn do_write(record: &mut CobolRecord) {
    let id = read_handle(record);
    if id == 0 {
        set_fcd_status(record, FileStatus2::NOT_OPEN);
        return;
    }

    let org = get_organization(record);

    let cur_len = read_be_u(record, "FCD-CURRENT-REC-LEN") as usize;
    let rec_len = if cur_len == 0 { get_max_rec_len(record) } else { cur_len };
    if rec_len == 0 {
        set_fcd_status(record, FileStatus2::OK);
        return;
    }

    let data: Vec<u8> = if let Some(offset) = record_target(record) {
        record.get_bytes_raw_offset(offset, rec_len).to_vec()
    } else {
        vec![b' '; rec_len]
    };

    let write_result = with_handle(id, |f| {
        if org == 0 {
            let line = String::from_utf8_lossy(&data);
            let line_str = line.trim_end_matches(' ');
            f.write_line(line_str)
        } else {
            f.write_record(&data)
        }
    });

    match write_result {
        Some(Ok(())) => set_fcd_status(record, FileStatus2::OK),
        Some(Err(e)) => set_fcd_status(record, FileStatus2::from(e)),
        None => set_fcd_status(record, FileStatus2::NOT_OPEN),
    }
}

// ── REWRITE ─────────────────────────────────────────────────────────────────

fn do_rewrite(record: &mut CobolRecord) {
    do_write(record);
}

// ── DELETE ──────────────────────────────────────────────────────────────────

fn do_delete(record: &mut CobolRecord) {
    let id = read_handle(record);
    if id == 0 {
        set_fcd_status(record, FileStatus2::NOT_OPEN);
        return;
    }
    set_fcd_status(record, FileStatus2::NOT_FOUND);
}

// ── QUERY-FILE (opcode 0x0006) ──────────────────────────────────────────────

fn do_query_file(record: &mut CobolRecord) {
    let id = read_handle(record);
    if id == 0 {
        set_fcd_status(record, FileStatus2::NOT_OPEN);
        return;
    }
    set_fcd_status(record, FileStatus2::OK);
}

// ── START ───────────────────────────────────────────────────────────────────

fn do_start(record: &mut CobolRecord) {
    set_fcd_status(record, FileStatus2::OK);
}

// ── MAIN ENTRY POINT ────────────────────────────────────────────────────────

/// `CALL "EXTFH" USING action_code_field, fcd_field`
///
/// Both parameters are field names in `record`. The action code is a
/// 2-byte big-endian opcode; the FCD contains file descriptor fields
/// (populated by `copy xfhfcd3.` or inline FCD2 definition).
pub fn call(record: &mut CobolRecord, opcode_field: &str, _fcd_field: &str) {
    let opcode = read_opcode(record, opcode_field);

    match opcode {
        0xFA00 => do_open(record, OpenMode::Input),
        0xFA01 => do_open(record, OpenMode::Output),
        0xFA02 => do_open(record, OpenMode::Io),
        0xFA03 => do_open(record, OpenMode::Extend),
        0xFA04 => do_open(record, OpenMode::Input),
        0xFA05 => do_open(record, OpenMode::Output),
        0xFA08 => do_open(record, OpenMode::Input),
        0xFA80 | 0xFA81 | 0xFA82 | 0xFA84 | 0xFA85 | 0xFA86 => do_close(record),
        0xFA8D | 0xFAD8 | 0xFAD9 | 0xFAF5 => do_read_seq(record),
        0xFA8C | 0xFADE | 0xFADF | 0xFAF9 => do_read_seq(record),
        0xFA8E | 0xFADA | 0xFADB | 0xFAF6 => do_read_seq(record),
        0xFA8F | 0xFAD6 | 0xFAD7 | 0xFAC9 => do_read_seq(record),
        0xFAF1 => do_read_seq(record),
        0xFAE1..=0xFAE6 => do_write(record),
        0xFAF3 => do_write(record),
        0xFAF4 => do_rewrite(record),
        0xFAE8 | 0xFAE9 | 0xFAEA | 0xFAEB | 0xFAFE | 0xFAFF => do_start(record),
        0xFA90 | 0xFAD4 | 0xFAD5 | 0xFACA => do_read_seq(record),
        0xFA92 | 0xFAD0 | 0xFAD1 | 0xFACC => do_read_seq(record),
        0xFAF7 => do_delete(record),
        0xFAF8 => do_close(record),
        0xFA0E => set_fcd_status(record, FileStatus2::OK),
        0xFADC => set_fcd_status(record, FileStatus2::OK),
        0xFADD => set_fcd_status(record, FileStatus2::OK),
        0x0006 => do_query_file(record),
        0x0007 => set_fcd_status(record, FileStatus2::NOT_IMPL),
        0x0008 => do_read_seq(record),
        _ => {
            set_fcd_status(record, FileStatus2::NOT_IMPL);
        }
    }
}

// ── Unit tests ──────────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use crate::field::{CobolRecord, FieldDescriptor, FieldType};

    fn fd(name: &str, offset: usize, size: usize) -> FieldDescriptor {
        FieldDescriptor {
            name: name.into(),
            offset,
            size,
            field_type: FieldType::AlphaNumeric,
            pic_scale: 0,
            pic_digits: size as u8,
            is_signed: false,
            justified_right: false,
            blank_when_zero: false,
            p_factor: 0,
            sign_leading: false,
            sign_separate: false,
            is_pointer: false,
            pic_clause_digits: 0,
        }
    }

    fn make_record() -> CobolRecord {
        // Minimal FCD3-like layout laid out flat in 400 bytes.
        let fields = vec![
            fd("ACTION-CODE", 0, 2),
            fd("FCD-FILE-STATUS", 2, 2),
            fd("FCD-STATUS-KEY-1", 2, 1),
            fd("FCD-STATUS-KEY-2", 3, 1),
            fd("FCD-ORGANIZATION", 6, 1),
            fd("FCD-OPEN-MODE", 7, 1),
            fd("FCD-NAME-LENGTH", 8, 2),
            fd("FCD-CURRENT-REC-LEN", 10, 4),
            fd("FCD-MAX-REC-LENGTH", 14, 4),
            fd("FCD-HANDLE", 18, 8),
            fd("FCD-RECORD-ADDRESS", 26, 8),
            fd("FCD-FILENAME-ADDRESS", 34, 8),
            fd("FILENAME-BUF", 42, 80),
            fd("RECORD-BUF", 122, 256),
        ];
        CobolRecord::new(400, fields)
    }

    fn setup_fcd(record: &mut CobolRecord, filename: &str) {
        let fname_bytes = filename.as_bytes();
        record.set_bytes("FILENAME-BUF", fname_bytes);
        let (fname_off, _) = record.field_offset_len("FILENAME-BUF").unwrap();
        let (addr_off, _) = record.field_offset_len("FCD-FILENAME-ADDRESS").unwrap();
        record.set_bytes_raw_offset(addr_off, &(fname_off as u64).to_le_bytes());
        write_be_u(record, "FCD-NAME-LENGTH", fname_bytes.len() as u64);
        write_be_u(record, "FCD-MAX-REC-LENGTH", 256);
        let (rec_off, _) = record.field_offset_len("RECORD-BUF").unwrap();
        let (raddr_off, _) = record.field_offset_len("FCD-RECORD-ADDRESS").unwrap();
        record.set_bytes_raw_offset(raddr_off, &(rec_off as u64).to_le_bytes());
        record.set_bytes("FCD-ORGANIZATION", &[0]);
    }

    fn set_opcode(record: &mut CobolRecord, op: u16) {
        let bytes = [(op >> 8) as u8, (op & 0xFF) as u8];
        record.set_bytes("ACTION-CODE", &bytes);
    }

    fn get_status(record: &CobolRecord) -> [u8; 2] {
        let b = record.get_bytes("FCD-FILE-STATUS");
        [b[0], b[1]]
    }

    #[test]
    fn test_open_output_creates_file() {
        let mut rec = make_record();
        let path = "extfh_test_open_output.tmp";
        setup_fcd(&mut rec, path);
        set_opcode(&mut rec, 0xFA01);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let st = get_status(&rec);
        assert_eq!(st, [b'0', b'0'], "OPEN OUTPUT should return 00");
        let (hoff, _) = rec.field_offset_len("FCD-HANDLE").unwrap();
        let handle = read_u64_le_at(&rec, hoff);
        assert_ne!(handle, 0, "Handle should be non-zero after open");
        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_close_not_open_returns_42() {
        let mut rec = make_record();
        setup_fcd(&mut rec, "extfh_test_close_noop.tmp");
        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'4', b'2']);
    }

    #[test]
    fn test_open_input_nonexistent_returns_35() {
        let mut rec = make_record();
        let path = "extfh_test_nonexistent_xyz_1234.tmp";
        let _ = std::fs::remove_file(path);
        setup_fcd(&mut rec, path);
        set_opcode(&mut rec, 0xFA00);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'3', b'5']);
    }

    #[test]
    fn test_write_and_read_line_sequential() {
        let mut rec = make_record();
        let path = "extfh_test_write_read.tmp";
        let _ = std::fs::remove_file(path);
        setup_fcd(&mut rec, path);

        set_opcode(&mut rec, 0xFA01);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0']);

        let data = b"Hello EXTFH World";
        rec.set_bytes("RECORD-BUF", data);
        write_be_u(&mut rec, "FCD-CURRENT-REC-LEN", data.len() as u64);

        set_opcode(&mut rec, 0xFAF3);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0'], "WRITE should succeed");

        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let disk = std::fs::read(path).unwrap_or_default();
        eprintln!("DISK after close: len={} bytes={:?}", disk.len(), disk);

        // Reset FCD state before reopening
        write_be_u(&mut rec, "FCD-CURRENT-REC-LEN", 0);
        write_handle(&mut rec, 0);

        set_opcode(&mut rec, 0xFA00);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0']);

        set_opcode(&mut rec, 0xFA8D);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0'], "READ should succeed");
        let read_len = read_be_u(&rec, "FCD-CURRENT-REC-LEN") as usize;
        assert!(read_len > 0, "Read length should be non-zero");

        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_read_eof_returns_10() {
        let mut rec = make_record();
        let path = "extfh_test_eof.tmp";
        let _ = std::fs::remove_file(path);
        std::fs::write(path, b"").unwrap();
        setup_fcd(&mut rec, path);

        set_opcode(&mut rec, 0xFA00);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0']);

        set_opcode(&mut rec, 0xFA8D);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'1', b'0']);

        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_open_extend_existing_file() {
        let mut rec = make_record();
        let path = "extfh_test_extend.tmp";
        std::fs::write(path, b"line1\n").unwrap();
        setup_fcd(&mut rec, path);

        set_opcode(&mut rec, 0xFA03);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        assert_eq!(get_status(&rec), [b'0', b'0']);

        set_opcode(&mut rec, 0xFA80);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_unknown_opcode_returns_91() {
        let mut rec = make_record();
        setup_fcd(&mut rec, "extfh_test_unknown.tmp");
        let bytes = [0xFFu8, 0xFFu8];
        rec.set_bytes("ACTION-CODE", &bytes);
        call(&mut rec, "ACTION-CODE", "FCD-HANDLE");
        let st = get_status(&rec);
        assert_eq!(st[0], b'9', "Unknown opcode should return 9x status");
    }
}
