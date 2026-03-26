// CobolFile — file handle wrapper for COBOL file I/O operations.
// Compatible with derive macros (Clone, Debug via manual impl).

use std::io::{BufRead, BufReader, BufWriter, Write};
use std::fs::File;
use crate::FileStatus;

#[derive(Default)]
pub enum CobolFile {
    #[default]
    Closed,
    Reading(BufReader<File>),
    Writing(BufWriter<File>),
}

impl Clone for CobolFile {
    fn clone(&self) -> Self {
        CobolFile::Closed
    }
}

impl std::fmt::Debug for CobolFile {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            CobolFile::Closed => write!(f, "CobolFile::Closed"),
            CobolFile::Reading(_) => write!(f, "CobolFile::Reading"),
            CobolFile::Writing(_) => write!(f, "CobolFile::Writing"),
        }
    }
}

impl CobolFile {
    pub fn open_input(path: &str) -> Result<Self, String> {
        match File::open(path) {
            Ok(f) => Ok(CobolFile::Reading(BufReader::new(f))),
            Err(e) => Err(format!("Failed to open {}: {}", path, e)),
        }
    }

    pub fn open_output(path: &str) -> Result<Self, String> {
        match File::create(path) {
            Ok(f) => Ok(CobolFile::Writing(BufWriter::new(f))),
            Err(e) => Err(format!("Failed to create {}: {}", path, e)),
        }
    }

    pub fn open_io(path: &str) -> Result<Self, String> {
        // I-O mode: open existing file for read/write. For now, open for reading.
        match std::fs::OpenOptions::new().read(true).write(true).open(path) {
            Ok(f) => Ok(CobolFile::Reading(BufReader::new(f))),
            Err(e) => Err(format!("Failed to open I-O {}: {}", path, e)),
        }
    }

    pub fn open_extend(path: &str) -> Result<Self, String> {
        // EXTEND mode: open for append
        match std::fs::OpenOptions::new().create(true).append(true).open(path) {
            Ok(f) => Ok(CobolFile::Writing(BufWriter::new(f))),
            Err(e) => Err(format!("Failed to open extend {}: {}", path, e)),
        }
    }

    pub fn read_record(&mut self, buf: &mut [u8]) -> Result<usize, FileStatus> {
        match self {
            CobolFile::Reading(reader) => {
                use std::io::Read;
                match reader.read(buf) {
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
            CobolFile::Reading(reader) => {
                let mut line = String::new();
                match reader.read_line(&mut line) {
                    Ok(0) => Err(FileStatus::AtEnd),
                    Ok(_) => {
                        if line.ends_with('\n') { line.pop(); }
                        if line.ends_with('\r') { line.pop(); }
                        Ok(line)
                    }
                    Err(_) => Err(FileStatus::NoCurrentRecord),
                }
            }
            _ => Err(FileStatus::ReadNotAllowed),
        }
    }

    pub fn write_record(&mut self, data: &[u8]) -> Result<(), FileStatus> {
        match self {
            CobolFile::Writing(writer) => {
                match writer.write_all(data) {
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
            _ => Err(FileStatus::WriteNotAllowed),
        }
    }

    pub fn close(&mut self) -> Result<(), FileStatus> {
        *self = CobolFile::Closed;
        Ok(())
    }
}
