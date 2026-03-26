// CICS Runtime for Ironclad-generated Rust programs.
// Replaces IBM CICS transaction server with native Rust equivalents.
// All EXEC CICS commands route through CicsContext::execute().

use std::collections::{HashMap, VecDeque};
use std::io::{self, Write, BufRead, BufReader};
use std::fs::{File, OpenOptions};


// ── Response Codes ──────────────────────────────────────────────────

/// CICS EIBRESP values (subset covering common conditions).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(i32)]
pub enum CicsResp {
    Normal        = 0,
    Error         = 1,
    Eof           = 2,   // ENDFILE
    NotFound      = 13,  // NOTFND
    DuplicateKey  = 14,  // DUPREC
    DuplicateRec  = 15,
    Disabled      = 18,  // DISABLED
    InvalidReq    = 16,  // INVREQ
    IoErr         = 17,
    NotOpen       = 19,
    EndData       = 20,  // ENDDATA (browse)
    LenErr        = 22,
    QIdErr        = 26,  // QIDERR
    ItemErr       = 27,  // ITEMERR
    PgmIdErr      = 28,  // PGMIDERR
    NotAuth       = 70,
}

impl CicsResp {
    pub fn code(self) -> i32 { self as i32 }
}

// ── CICS Context (one per task/transaction) ─────────────────────────

pub struct CicsContext {
    /// EIBRESP after last command
    pub resp: i32,
    /// EIBRESP2 after last command
    pub resp2: i32,
    /// EIBCALEN — length of COMMAREA passed in
    pub calen: i32,
    /// EIBTRNID — transaction ID
    pub tran_id: String,
    /// COMMAREA — communication area between programs
    pub commarea: Vec<u8>,
    /// Temporary Storage queues: name → queue of records
    ts_queues: HashMap<String, VecDeque<Vec<u8>>>,
    /// Transient Data queues: name → file path
    td_queues: HashMap<String, String>,
    /// File handles for browse operations: token → (reader, key)
    browse_cursors: HashMap<u32, BrowseCursor>,
    next_browse_token: u32,
    /// Program dispatch table: program name → function pointer
    #[allow(clippy::type_complexity)]
    programs: HashMap<String, fn(&mut CicsContext, &[u8]) -> Vec<u8>>,
    /// Condition handlers: condition name → action
    handlers: HashMap<String, ConditionAction>,
    /// Transaction journal for SYNCPOINT/ROLLBACK
    journal: Vec<JournalEntry>,
    /// Output sink (for SEND MAP/TEXT)
    output: Box<dyn Write + Send>,
    /// Input source (for RECEIVE MAP)
    input: Box<dyn BufRead + Send>,
}

#[derive(Debug, Clone)]
#[allow(dead_code)]
enum ConditionAction {
    Label(String),    // GO TO label
    Ignore,           // HANDLE CONDITION ... IGNORE
    Default,          // Default system action
}

#[allow(dead_code)]
struct BrowseCursor {
    reader: BufReader<File>,
    ridfld: String,
}

#[derive(Debug, Clone)]
struct JournalEntry {
    operation: String,
    file: String,
    key: String,
    before_image: Vec<u8>,
}

impl Default for CicsContext {
    fn default() -> Self {
        Self::new()
    }
}

impl CicsContext {
    pub fn new() -> Self {
        Self {
            resp: 0,
            resp2: 0,
            calen: 0,
            tran_id: String::new(),
            commarea: Vec::new(),
            ts_queues: HashMap::new(),
            td_queues: HashMap::new(),
            browse_cursors: HashMap::new(),
            next_browse_token: 1,
            programs: HashMap::new(),
            handlers: HashMap::new(),
            journal: Vec::new(),
            output: Box::new(io::stdout()),
            input: Box::new(BufReader::new(io::stdin())),
        }
    }

    /// Create context with custom I/O (for testing or batch mode).
    pub fn with_io(output: Box<dyn Write + Send>, input: Box<dyn BufRead + Send>) -> Self {
        let mut ctx = Self::new();
        ctx.output = output;
        ctx.input = input;
        ctx
    }

    /// Register a program for LINK/XCTL dispatch.
    pub fn register_program(&mut self, name: &str, func: fn(&mut CicsContext, &[u8]) -> Vec<u8>) {
        self.programs.insert(name.to_uppercase(), func);
    }

    /// Register a TD queue backed by a file.
    pub fn register_td_queue(&mut self, name: &str, path: &str) {
        self.td_queues.insert(name.to_uppercase(), path.to_string());
    }

    fn set_resp(&mut self, r: CicsResp) {
        self.resp = r.code();
        self.resp2 = 0;
    }

    // ── SEND ────────────────────────────────────────────────────────

    /// EXEC CICS SEND TEXT/MAP — write formatted output.
    pub fn send(&mut self, data: &str, erase: bool) {
        if erase {
            // Clear screen equivalent
            let _ = self.output.write_all(b"\x1B[2J\x1B[H");
        }
        let _ = self.output.write_all(data.as_bytes());
        let _ = self.output.write_all(b"\n");
        let _ = self.output.flush();
        self.set_resp(CicsResp::Normal);
    }

    /// EXEC CICS SEND MAP — format fields into map template and send.
    pub fn send_map(&mut self, map: &str, mapset: &str, data: &HashMap<String, String>, erase: bool) {
        if erase {
            let _ = self.output.write_all(b"\x1B[2J\x1B[H");
        }
        // Emit map/mapset header + all field values
        let _ = writeln!(self.output, "--- MAP: {} MAPSET: {} ---", map, mapset);
        for (field, value) in data {
            let _ = writeln!(self.output, "  {}: {}", field, value);
        }
        let _ = writeln!(self.output, "---");
        let _ = self.output.flush();
        self.set_resp(CicsResp::Normal);
    }

    // ── RECEIVE ─────────────────────────────────────────────────────

    /// EXEC CICS RECEIVE MAP — read input into field map.
    pub fn receive(&mut self, into: &mut HashMap<String, String>) {
        let mut line = String::new();
        match self.input.read_line(&mut line) {
            Ok(0) => self.set_resp(CicsResp::Eof),
            Ok(_) => {
                // Parse "FIELD=VALUE" pairs separated by commas or newlines
                for pair in line.trim().split(',') {
                    let pair = pair.trim();
                    if let Some((k, v)) = pair.split_once('=') {
                        into.insert(k.trim().to_uppercase(), v.trim().to_string());
                    }
                }
                self.set_resp(CicsResp::Normal);
            }
            Err(_) => self.set_resp(CicsResp::Error),
        }
    }

    // ── READ/WRITE/REWRITE/DELETE (file control) ────────────────────

    /// EXEC CICS READ FILE — read a record by key from a flat file.
    /// Records stored as: key\tdata\n
    pub fn read_file(&mut self, file_path: &str, ridfld: &str) -> Option<String> {
        let file = match File::open(file_path) {
            Ok(f) => f,
            Err(_) => { self.set_resp(CicsResp::NotOpen); return None; }
        };
        let reader = BufReader::new(file);
        for line in reader.lines().map_while(Result::ok) {
            if let Some((key, data)) = line.split_once('\t') {
                if key == ridfld {
                    self.set_resp(CicsResp::Normal);
                    return Some(data.to_string());
                }
            }
        }
        self.set_resp(CicsResp::NotFound);
        None
    }

    /// EXEC CICS WRITE FILE — append a record.
    pub fn write_file(&mut self, file_path: &str, ridfld: &str, data: &str) {
        match OpenOptions::new().create(true).append(true).open(file_path) {
            Ok(mut f) => {
                let _ = writeln!(f, "{}\t{}", ridfld, data);
                self.journal.push(JournalEntry {
                    operation: "WRITE".into(), file: file_path.into(),
                    key: ridfld.into(), before_image: Vec::new(),
                });
                self.set_resp(CicsResp::Normal);
            }
            Err(_) => self.set_resp(CicsResp::NotOpen),
        }
    }

    /// EXEC CICS REWRITE — update existing record (read-then-write).
    pub fn rewrite_file(&mut self, file_path: &str, ridfld: &str, data: &str) {
        // Read all, replace matching key, rewrite file
        let lines: Vec<String> = match std::fs::read_to_string(file_path) {
            Ok(content) => content.lines().map(|l| l.to_string()).collect(),
            Err(_) => { self.set_resp(CicsResp::NotOpen); return; }
        };
        let mut found = false;
        let mut output = Vec::new();
        for line in &lines {
            if let Some((key, old_data)) = line.split_once('\t') {
                if key == ridfld {
                    found = true;
                    self.journal.push(JournalEntry {
                        operation: "REWRITE".into(), file: file_path.into(),
                        key: ridfld.into(), before_image: old_data.as_bytes().to_vec(),
                    });
                    output.push(format!("{}\t{}", ridfld, data));
                    continue;
                }
            }
            output.push(line.clone());
        }
        if found {
            let _ = std::fs::write(file_path, output.join("\n") + "\n");
            self.set_resp(CicsResp::Normal);
        } else {
            self.set_resp(CicsResp::NotFound);
        }
    }

    /// EXEC CICS DELETE FILE — remove record by key.
    pub fn delete_file(&mut self, file_path: &str, ridfld: &str) {
        let lines: Vec<String> = match std::fs::read_to_string(file_path) {
            Ok(content) => content.lines().map(|l| l.to_string()).collect(),
            Err(_) => { self.set_resp(CicsResp::NotOpen); return; }
        };
        let before_len = lines.len();
        let filtered: Vec<&String> = lines.iter()
            .filter(|l| !l.starts_with(&format!("{}\t", ridfld)))
            .collect();
        if filtered.len() < before_len {
            let content: Vec<&str> = filtered.iter().map(|s| s.as_str()).collect();
            let _ = std::fs::write(file_path, content.join("\n") + "\n");
            self.set_resp(CicsResp::Normal);
        } else {
            self.set_resp(CicsResp::NotFound);
        }
    }

    // ── LINK / XCTL / RETURN ────────────────────────────────────────

    /// EXEC CICS LINK — call program, return here after.
    pub fn link(&mut self, program: &str, commarea: &[u8]) -> Vec<u8> {
        let key = program.to_uppercase();
        if let Some(func) = self.programs.get(&key).copied() {
            self.set_resp(CicsResp::Normal);
            func(self, commarea)
        } else {
            self.set_resp(CicsResp::PgmIdErr);
            Vec::new()
        }
    }

    /// EXEC CICS XCTL — transfer control (does not return to caller).
    pub fn xctl(&mut self, program: &str, commarea: &[u8]) -> Vec<u8> {
        // Same as LINK in our model — caller won't execute further
        self.link(program, commarea)
    }

    /// EXEC CICS RETURN — end current program (TRANSID for next).
    pub fn return_program(&mut self, transid: Option<&str>) {
        if let Some(t) = transid {
            self.tran_id = t.to_uppercase();
        }
        self.set_resp(CicsResp::Normal);
    }

    /// EXEC CICS ABEND — abnormal termination.
    pub fn abend(&mut self, code: &str) {
        eprintln!("CICS ABEND: {}", code);
        self.set_resp(CicsResp::Error);
    }

    // ── TEMPORARY STORAGE QUEUES ────────────────────────────────────

    /// EXEC CICS WRITEQ TS — write item to temporary storage queue.
    pub fn writeq_ts(&mut self, queue: &str, data: &[u8]) {
        let q = self.ts_queues.entry(queue.to_uppercase()).or_default();
        q.push_back(data.to_vec());
        self.set_resp(CicsResp::Normal);
    }

    /// EXEC CICS READQ TS — read next item from temporary storage queue.
    pub fn readq_ts(&mut self, queue: &str) -> Option<Vec<u8>> {
        let key = queue.to_uppercase();
        if let Some(q) = self.ts_queues.get_mut(&key) {
            if let Some(item) = q.pop_front() {
                self.set_resp(CicsResp::Normal);
                Some(item)
            } else {
                self.set_resp(CicsResp::ItemErr);
                None
            }
        } else {
            self.set_resp(CicsResp::QIdErr);
            None
        }
    }

    /// EXEC CICS DELETEQ TS — delete entire TS queue.
    pub fn deleteq_ts(&mut self, queue: &str) {
        let key = queue.to_uppercase();
        if self.ts_queues.remove(&key).is_some() {
            self.set_resp(CicsResp::Normal);
        } else {
            self.set_resp(CicsResp::QIdErr);
        }
    }

    // ── TRANSIENT DATA QUEUES ───────────────────────────────────────

    /// EXEC CICS WRITEQ TD — write record to transient data queue (file-backed).
    pub fn writeq_td(&mut self, queue: &str, data: &[u8]) {
        let key = queue.to_uppercase();
        if let Some(path) = self.td_queues.get(&key).cloned() {
            match OpenOptions::new().create(true).append(true).open(&path) {
                Ok(mut f) => {
                    let _ = f.write_all(data);
                    let _ = f.write_all(b"\n");
                    self.set_resp(CicsResp::Normal);
                }
                Err(_) => self.set_resp(CicsResp::Disabled),
            }
        } else {
            self.set_resp(CicsResp::QIdErr);
        }
    }

    /// EXEC CICS READQ TD — read next record from transient data queue.
    pub fn readq_td(&mut self, queue: &str) -> Option<Vec<u8>> {
        let key = queue.to_uppercase();
        if let Some(path) = self.td_queues.get(&key).cloned() {
            // Read first line and remove it
            let content = match std::fs::read_to_string(&path) {
                Ok(c) => c,
                Err(_) => { self.set_resp(CicsResp::QIdErr); return None; }
            };
            let mut lines: Vec<&str> = content.lines().collect();
            if lines.is_empty() {
                self.set_resp(CicsResp::QIdErr);
                return None;
            }
            let first = lines.remove(0).as_bytes().to_vec();
            let _ = std::fs::write(&path, lines.join("\n") + if lines.is_empty() { "" } else { "\n" });
            self.set_resp(CicsResp::Normal);
            Some(first)
        } else {
            self.set_resp(CicsResp::QIdErr);
            None
        }
    }

    // ── BROWSE (STARTBR / READNEXT / READPREV / ENDBR) ─────────────

    /// EXEC CICS STARTBR — start browse on a file from given key.
    pub fn startbr(&mut self, file_path: &str, ridfld: &str) -> u32 {
        match File::open(file_path) {
            Ok(f) => {
                let token = self.next_browse_token;
                self.next_browse_token += 1;
                let reader = BufReader::new(f);
                self.browse_cursors.insert(token, BrowseCursor {
                    reader,
                    ridfld: ridfld.to_string(),
                });
                self.set_resp(CicsResp::Normal);
                token
            }
            Err(_) => {
                self.set_resp(CicsResp::NotOpen);
                0
            }
        }
    }

    /// EXEC CICS READNEXT — read next record in browse.
    pub fn readnext(&mut self, token: u32) -> Option<(String, String)> {
        if let Some(cursor) = self.browse_cursors.get_mut(&token) {
            let mut line = String::new();
            match cursor.reader.read_line(&mut line) {
                Ok(0) => {
                    self.set_resp(CicsResp::EndData);
                    None
                }
                Ok(_) => {
                    if let Some((key, data)) = line.trim().split_once('\t') {
                        self.set_resp(CicsResp::Normal);
                        Some((key.to_string(), data.to_string()))
                    } else {
                        self.set_resp(CicsResp::Error);
                        None
                    }
                }
                Err(_) => {
                    self.set_resp(CicsResp::Error);
                    None
                }
            }
        } else {
            self.set_resp(CicsResp::NotOpen);
            None
        }
    }

    /// EXEC CICS ENDBR — end browse.
    pub fn endbr(&mut self, token: u32) {
        if self.browse_cursors.remove(&token).is_some() {
            self.set_resp(CicsResp::Normal);
        } else {
            self.set_resp(CicsResp::NotOpen);
        }
    }

    // ── HANDLE CONDITION ────────────────────────────────────────────

    /// EXEC CICS HANDLE CONDITION — register error handler.
    pub fn handle_condition(&mut self, condition: &str, action: &str) {
        let act = if action.eq_ignore_ascii_case("IGNORE") {
            ConditionAction::Ignore
        } else {
            ConditionAction::Label(action.to_uppercase())
        };
        self.handlers.insert(condition.to_uppercase(), act);
    }

    /// Check if current RESP should be handled; returns label to branch to if any.
    pub fn check_handler(&self, condition: &str) -> Option<String> {
        match self.handlers.get(&condition.to_uppercase()) {
            Some(ConditionAction::Label(lbl)) => Some(lbl.clone()),
            _ => None,
        }
    }

    // ── SYNCPOINT / ROLLBACK ────────────────────────────────────────

    /// EXEC CICS SYNCPOINT — commit transaction (clear journal).
    pub fn syncpoint(&mut self) {
        self.journal.clear();
        self.set_resp(CicsResp::Normal);
    }

    /// EXEC CICS SYNCPOINT ROLLBACK — undo changes since last syncpoint.
    pub fn rollback(&mut self) {
        // Replay journal in reverse to restore before-images
        for entry in self.journal.iter().rev() {
            match entry.operation.as_str() {
                "WRITE" => {
                    // Remove the written record
                    self.delete_file_internal(&entry.file, &entry.key);
                }
                "REWRITE" => {
                    // Restore before image
                    let data = String::from_utf8_lossy(&entry.before_image);
                    self.rewrite_file_internal(&entry.file, &entry.key, &data);
                }
                _ => {}
            }
        }
        self.journal.clear();
        self.set_resp(CicsResp::Normal);
    }

    fn delete_file_internal(&self, file_path: &str, ridfld: &str) {
        if let Ok(content) = std::fs::read_to_string(file_path) {
            let filtered: Vec<&str> = content.lines()
                .filter(|l| !l.starts_with(&format!("{}\t", ridfld)))
                .collect();
            let _ = std::fs::write(file_path, filtered.join("\n") + "\n");
        }
    }

    fn rewrite_file_internal(&self, file_path: &str, ridfld: &str, data: &str) {
        if let Ok(content) = std::fs::read_to_string(file_path) {
            let output: Vec<String> = content.lines().map(|line| {
                if line.starts_with(&format!("{}\t", ridfld)) {
                    format!("{}\t{}", ridfld, data)
                } else {
                    line.to_string()
                }
            }).collect();
            let _ = std::fs::write(file_path, output.join("\n") + "\n");
        }
    }

    // ── MASTER EXECUTE (dispatch any EXEC CICS command) ─────────────

    /// Execute a CICS command by name with options.
    /// This is what rustify.rs emits calls to.
    pub fn execute(&mut self, command: &str, options: &[(&str, Option<&str>)]) -> Option<String> {
        let cmd = command.to_uppercase();
        let opt = |key: &str| -> Option<&str> {
            options.iter()
                .find(|(k, _)| k.eq_ignore_ascii_case(key))
                .and_then(|(_, v)| *v)
        };

        match cmd.as_str() {
            "SEND" => {
                let erase = options.iter().any(|(k, _)| k.eq_ignore_ascii_case("ERASE"));
                if let Some(map) = opt("MAP") {
                    let mapset = opt("MAPSET").unwrap_or("DFHBMS");
                    // In execute() mode, send map name as text
                    self.send(&format!("[MAP:{} MAPSET:{}]", map, mapset), erase);
                } else if let Some(from) = opt("FROM") {
                    self.send(from, erase);
                } else {
                    self.send("", erase);
                }
                None
            }
            "RECEIVE" => {
                let mut fields = HashMap::new();
                self.receive(&mut fields);
                // Return received data as key=value pairs
                let result: Vec<String> = fields.iter().map(|(k,v)| format!("{}={}", k, v)).collect();
                Some(result.join(","))
            }
            "READ" => {
                let file = opt("FILE").or_else(|| opt("DATASET")).unwrap_or("");
                let ridfld = opt("RIDFLD").unwrap_or("");
                self.read_file(file, ridfld)
            }
            "WRITE" => {
                let file = opt("FILE").or_else(|| opt("DATASET")).unwrap_or("");
                let ridfld = opt("RIDFLD").unwrap_or("");
                let from = opt("FROM").unwrap_or("");
                self.write_file(file, ridfld, from);
                None
            }
            "REWRITE" => {
                let file = opt("FILE").or_else(|| opt("DATASET")).unwrap_or("");
                let ridfld = opt("RIDFLD").unwrap_or("");
                let from = opt("FROM").unwrap_or("");
                self.rewrite_file(file, ridfld, from);
                None
            }
            "DELETE" => {
                let file = opt("FILE").or_else(|| opt("DATASET")).unwrap_or("");
                let ridfld = opt("RIDFLD").unwrap_or("");
                self.delete_file(file, ridfld);
                None
            }
            "LINK" => {
                let prog = opt("PROGRAM").unwrap_or("");
                let comm = opt("COMMAREA").unwrap_or("").as_bytes();
                let result = self.link(prog, comm);
                if result.is_empty() { None } else { Some(String::from_utf8_lossy(&result).to_string()) }
            }
            "XCTL" => {
                let prog = opt("PROGRAM").unwrap_or("");
                let comm = opt("COMMAREA").unwrap_or("").as_bytes();
                let result = self.xctl(prog, comm);
                if result.is_empty() { None } else { Some(String::from_utf8_lossy(&result).to_string()) }
            }
            "RETURN" => {
                let transid = opt("TRANSID");
                self.return_program(transid);
                None
            }
            "ABEND" => {
                let code = opt("ABCODE").unwrap_or("????");
                self.abend(code);
                None
            }
            "WRITEQ" => {
                let data = opt("FROM").unwrap_or("").as_bytes();
                if options.iter().any(|(k, _)| k.eq_ignore_ascii_case("TS")) {
                    let q = opt("QUEUE").unwrap_or("");
                    self.writeq_ts(q, data);
                } else {
                    let q = opt("QUEUE").unwrap_or("");
                    self.writeq_td(q, data);
                }
                None
            }
            "READQ" => {
                if options.iter().any(|(k, _)| k.eq_ignore_ascii_case("TS")) {
                    let q = opt("QUEUE").unwrap_or("");
                    self.readq_ts(q).map(|d| String::from_utf8_lossy(&d).to_string())
                } else {
                    let q = opt("QUEUE").unwrap_or("");
                    self.readq_td(q).map(|d| String::from_utf8_lossy(&d).to_string())
                }
            }
            "DELETEQ" => {
                let q = opt("QUEUE").unwrap_or("");
                self.deleteq_ts(q);
                None
            }
            "STARTBR" => {
                let file = opt("FILE").or_else(|| opt("DATASET")).unwrap_or("");
                let ridfld = opt("RIDFLD").unwrap_or("");
                let token = self.startbr(file, ridfld);
                Some(token.to_string())
            }
            "READNEXT" => {
                // Browse token would be tracked by the generated code
                None
            }
            "ENDBR" => {
                None
            }
            "SYNCPOINT" => {
                if options.iter().any(|(k, _)| k.eq_ignore_ascii_case("ROLLBACK")) {
                    self.rollback();
                } else {
                    self.syncpoint();
                }
                None
            }
            _ => {
                // Unknown CICS command — log and continue
                eprintln!("CICS: unrecognized command '{}', continuing", cmd);
                self.set_resp(CicsResp::InvalidReq);
                None
            }
        }
    }
}

// ── Tests ───────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Cursor;

    fn test_ctx() -> CicsContext {
        let output = Box::new(Vec::<u8>::new());
        let input = Box::new(BufReader::new(Cursor::new(Vec::<u8>::new())));
        CicsContext::with_io(output, input)
    }

    #[test]
    fn test_ts_queue_write_read() {
        let mut ctx = test_ctx();
        ctx.writeq_ts("MYQUEUE", b"record1");
        ctx.writeq_ts("MYQUEUE", b"record2");
        assert_eq!(ctx.resp, 0);
        let r1 = ctx.readq_ts("MYQUEUE").unwrap();
        assert_eq!(r1, b"record1");
        let r2 = ctx.readq_ts("MYQUEUE").unwrap();
        assert_eq!(r2, b"record2");
        // Queue empty
        assert!(ctx.readq_ts("MYQUEUE").is_none());
        assert_eq!(ctx.resp, CicsResp::ItemErr as i32);
    }

    #[test]
    fn test_ts_queue_delete() {
        let mut ctx = test_ctx();
        ctx.writeq_ts("Q1", b"data");
        ctx.deleteq_ts("Q1");
        assert_eq!(ctx.resp, 0);
        ctx.deleteq_ts("Q1");
        assert_eq!(ctx.resp, CicsResp::QIdErr as i32);
    }

    #[test]
    fn test_file_read_write() {
        let mut ctx = test_ctx();
        let tmp = std::env::temp_dir().join("ironclad_cics_test.dat");
        let path = tmp.to_str().unwrap();
        let _ = std::fs::remove_file(path);

        ctx.write_file(path, "KEY001", "John Doe,100");
        assert_eq!(ctx.resp, 0);
        ctx.write_file(path, "KEY002", "Jane Doe,200");

        let r = ctx.read_file(path, "KEY001");
        assert_eq!(r, Some("John Doe,100".to_string()));

        let r = ctx.read_file(path, "KEY999");
        assert!(r.is_none());
        assert_eq!(ctx.resp, CicsResp::NotFound as i32);

        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_file_rewrite() {
        let mut ctx = test_ctx();
        let tmp = std::env::temp_dir().join("ironclad_cics_rewrite.dat");
        let path = tmp.to_str().unwrap();
        let _ = std::fs::remove_file(path);

        ctx.write_file(path, "K1", "old_value");
        ctx.rewrite_file(path, "K1", "new_value");
        assert_eq!(ctx.resp, 0);

        let r = ctx.read_file(path, "K1");
        assert_eq!(r, Some("new_value".to_string()));

        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_file_delete() {
        let mut ctx = test_ctx();
        let tmp = std::env::temp_dir().join("ironclad_cics_delete.dat");
        let path = tmp.to_str().unwrap();
        let _ = std::fs::remove_file(path);

        ctx.write_file(path, "K1", "data1");
        ctx.write_file(path, "K2", "data2");
        ctx.delete_file(path, "K1");
        assert_eq!(ctx.resp, 0);

        assert!(ctx.read_file(path, "K1").is_none());
        assert_eq!(ctx.read_file(path, "K2"), Some("data2".to_string()));

        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_link_program() {
        let mut ctx = test_ctx();
        fn echo(_ctx: &mut CicsContext, data: &[u8]) -> Vec<u8> {
            let mut result = b"ECHO:".to_vec();
            result.extend_from_slice(data);
            result
        }
        ctx.register_program("MYPROG", echo);
        let result = ctx.link("MYPROG", b"hello");
        assert_eq!(result, b"ECHO:hello");
        assert_eq!(ctx.resp, 0);

        let result = ctx.link("NOPROG", b"");
        assert!(result.is_empty());
        assert_eq!(ctx.resp, CicsResp::PgmIdErr as i32);
    }

    #[test]
    fn test_syncpoint_rollback() {
        let mut ctx = test_ctx();
        let tmp = std::env::temp_dir().join("ironclad_cics_sync.dat");
        let path = tmp.to_str().unwrap();
        let _ = std::fs::remove_file(path);

        ctx.write_file(path, "K1", "original");
        ctx.syncpoint(); // commit
        assert!(ctx.journal.is_empty());

        ctx.rewrite_file(path, "K1", "modified");
        assert_eq!(ctx.journal.len(), 1);
        ctx.rollback();

        let r = ctx.read_file(path, "K1");
        assert_eq!(r, Some("original".to_string()));

        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_execute_dispatch() {
        let mut ctx = test_ctx();
        let tmp = std::env::temp_dir().join("ironclad_cics_exec.dat");
        let path = tmp.to_str().unwrap();
        let _ = std::fs::remove_file(path);

        ctx.execute("WRITE", &[("FILE", Some(path)), ("RIDFLD", Some("K1")), ("FROM", Some("data"))]);
        assert_eq!(ctx.resp, 0);

        let r = ctx.execute("READ", &[("FILE", Some(path)), ("RIDFLD", Some("K1"))]);
        assert_eq!(r, Some("data".to_string()));

        let _ = std::fs::remove_file(path);
    }

    #[test]
    fn test_handle_condition() {
        let mut ctx = test_ctx();
        ctx.handle_condition("NOTFND", "ERROR-HANDLER");
        assert_eq!(ctx.check_handler("NOTFND"), Some("ERROR-HANDLER".to_string()));
        ctx.handle_condition("DUPKEY", "IGNORE");
        assert_eq!(ctx.check_handler("DUPKEY"), None); // IGNORE returns None
    }

    #[test]
    fn test_receive_input() {
        let input_data = b"NAME=JOHN,AGE=30\n";
        let output = Box::new(Vec::<u8>::new());
        let input = Box::new(BufReader::new(Cursor::new(input_data.to_vec())));
        let mut ctx = CicsContext::with_io(output, input);

        let mut fields = HashMap::new();
        ctx.receive(&mut fields);
        assert_eq!(ctx.resp, 0);
        assert_eq!(fields.get("NAME"), Some(&"JOHN".to_string()));
        assert_eq!(fields.get("AGE"), Some(&"30".to_string()));
    }

    #[test]
    fn test_resp_codes() {
        let mut ctx = test_ctx();
        ctx.set_resp(CicsResp::Normal);
        assert_eq!(ctx.resp, 0);
        ctx.set_resp(CicsResp::NotFound);
        assert_eq!(ctx.resp, 13);
    }
}
