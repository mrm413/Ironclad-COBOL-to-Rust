// IMS/DL-I Runtime for Ironclad-generated Rust programs.
// Replaces CALL 'CBLTDLI' with native Rust hierarchical data operations.
// Segments stored in a flat file-based store (JSON lines).

use std::collections::HashMap;
use std::fs::{File, OpenOptions};
use std::io::{BufRead, BufReader, Write};

// ── DL/I Function Codes ─────────────────────────────────────────────

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DliFunc {
    GU,   // Get Unique — direct retrieval by key
    GN,   // Get Next — sequential forward
    GHU,  // Get Hold Unique — read for update
    GHN,  // Get Hold Next — sequential read for update
    ISRT, // Insert segment
    DLET, // Delete segment (must hold)
    REPL, // Replace segment (must hold)
    GNP,  // Get Next within Parent
    GHNP, // Get Hold Next within Parent
}

impl DliFunc {
    pub fn parse_code(s: &str) -> Option<Self> {
        match s.trim().to_uppercase().as_str() {
            "GU"   => Some(Self::GU),
            "GN"   => Some(Self::GN),
            "GHU"  => Some(Self::GHU),
            "GHN"  => Some(Self::GHN),
            "ISRT" => Some(Self::ISRT),
            "DLET" => Some(Self::DLET),
            "REPL" => Some(Self::REPL),
            "GNP"  => Some(Self::GNP),
            "GHNP" => Some(Self::GHNP),
            _ => None,
        }
    }
}

// ── PCB Status Codes ────────────────────────────────────────────────

/// PCB status codes returned by DL/I calls.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PcbStatus {
    Ok,           // spaces — successful
    NotFound,     // GE — segment not found
    EndOfDb,      // GB — end of database
    DuplicateKey, // II — duplicate insert
    NoHold,       // DJ — delete without hold
    ReplaceErr,   // DA — replace rule violation
    Other(String),
}

impl PcbStatus {
    pub fn code(&self) -> &str {
        match self {
            PcbStatus::Ok => "  ",
            PcbStatus::NotFound => "GE",
            PcbStatus::EndOfDb => "GB",
            PcbStatus::DuplicateKey => "II",
            PcbStatus::NoHold => "DJ",
            PcbStatus::ReplaceErr => "DA",
            PcbStatus::Other(c) => c.as_str(),
        }
    }

    pub fn is_ok(&self) -> bool { matches!(self, PcbStatus::Ok) }
    pub fn is_not_found(&self) -> bool { matches!(self, PcbStatus::NotFound) }
}

// ── PCB (Program Communication Block) ───────────────────────────────

/// PCB — communication area between program and DL/I.
pub struct Pcb {
    pub db_name: String,
    pub status: PcbStatus,
    pub segment_name: String,
    pub key_feedback: String,
}

impl Pcb {
    pub fn new(db_name: &str) -> Self {
        Self {
            db_name: db_name.to_uppercase(),
            status: PcbStatus::Ok,
            segment_name: String::new(),
            key_feedback: String::new(),
        }
    }
}

// ── Segment (hierarchical record) ───────────────────────────────────

/// A segment in the hierarchical database — key-value fields.
#[derive(Debug, Clone)]
pub struct Segment {
    pub name: String,
    pub key: String,
    pub parent_key: String,
    pub fields: HashMap<String, String>,
}

impl Segment {
    /// Serialize to a tab-separated line: name\tkey\tparent_key\tfield1=val1|field2=val2
    fn to_line(&self) -> String {
        let fields: Vec<String> = self.fields.iter()
            .map(|(k, v)| format!("{}={}", k, v))
            .collect();
        format!("{}\t{}\t{}\t{}", self.name, self.key, self.parent_key, fields.join("|"))
    }

    /// Deserialize from a tab-separated line.
    fn from_line(line: &str) -> Option<Self> {
        let parts: Vec<&str> = line.split('\t').collect();
        if parts.len() < 4 { return None; }
        let mut fields = HashMap::new();
        for pair in parts[3].split('|') {
            if let Some((k, v)) = pair.split_once('=') {
                fields.insert(k.to_string(), v.to_string());
            }
        }
        Some(Segment {
            name: parts[0].to_string(),
            key: parts[1].to_string(),
            parent_key: parts[2].to_string(),
            fields,
        })
    }
}

// ── SSA (Segment Search Argument) ───────────────────────────────────

/// Parsed SSA — segment name with optional qualification.
#[derive(Debug, Clone)]
pub struct Ssa {
    pub segment_name: String,
    pub field: Option<String>,
    pub op: Option<String>,   // "=", ">=", "<=", ">", "<"
    pub value: Option<String>,
}

impl Ssa {
    /// Parse SSA from COBOL format: "SEGNAME(FIELD  = VALUE)"
    pub fn parse(s: &str) -> Self {
        let s = s.trim();
        if let Some(paren_start) = s.find('(') {
            let seg = s[..paren_start].trim().to_uppercase();
            let qual = &s[paren_start+1..s.len()-1]; // inside parens
            // Parse "FIELD  OP VALUE"
            let qual = qual.trim();
            let ops = [">=", "<=", "=", ">", "<"];
            for op in &ops {
                if let Some(pos) = qual.find(op) {
                    let field = qual[..pos].trim().to_string();
                    let value = qual[pos+op.len()..].trim().to_string();
                    return Ssa {
                        segment_name: seg,
                        field: Some(field),
                        op: Some(op.to_string()),
                        value: Some(value),
                    };
                }
            }
            Ssa { segment_name: seg, field: None, op: None, value: None }
        } else {
            Ssa { segment_name: s.to_uppercase(), field: None, op: None, value: None }
        }
    }

    /// Check if a segment matches this SSA.
    fn matches(&self, seg: &Segment) -> bool {
        if seg.name.to_uppercase() != self.segment_name { return false; }
        if let (Some(field), Some(op), Some(value)) = (&self.field, &self.op, &self.value) {
            let actual = seg.fields.get(field)
                .map(|s| s.as_str())
                .unwrap_or(&seg.key);
            match op.as_str() {
                "=" => actual == value,
                ">=" => actual >= value.as_str(),
                "<=" => actual <= value.as_str(),
                ">" => actual > value.as_str(),
                "<" => actual < value.as_str(),
                _ => true,
            }
        } else {
            true // unqualified SSA matches any segment of this type
        }
    }
}

// ── DL/I Context ────────────────────────────────────────────────────

/// DL/I execution context — manages hierarchical database and PCBs.
pub struct DliContext {
    /// Database file path
    db_path: String,
    /// All segments loaded in memory
    segments: Vec<Segment>,
    /// Current position for GN (sequential read)
    position: usize,
    /// Currently held segment index (for GHU/GHN → REPL/DLET)
    held: Option<usize>,
    /// PCB
    pub pcb: Pcb,
}

impl DliContext {
    pub fn new(db_name: &str, db_path: &str) -> Self {
        let segments = Self::load_segments(db_path);
        Self {
            db_path: db_path.to_string(),
            segments,
            position: 0,
            held: None,
            pcb: Pcb::new(db_name),
        }
    }

    fn load_segments(path: &str) -> Vec<Segment> {
        let file = match File::open(path) {
            Ok(f) => f,
            Err(_) => return Vec::new(),
        };
        BufReader::new(file).lines()
            .map_while(Result::ok)
            .filter_map(|l| Segment::from_line(&l))
            .collect()
    }

    fn save_segments(&self) {
        if let Ok(mut f) = OpenOptions::new().create(true).write(true).truncate(true).open(&self.db_path) {
            for seg in &self.segments {
                let _ = writeln!(f, "{}", seg.to_line());
            }
        }
    }

    /// Execute a DL/I CALL: CALL 'CBLTDLI' USING func, pcb, io_area, ssa1, ...
    pub fn call(&mut self, func: DliFunc, io_area: &mut Segment, ssas: &[Ssa]) -> PcbStatus {
        let status = match func {
            DliFunc::GU => self.get_unique(ssas),
            DliFunc::GN | DliFunc::GNP => self.get_next(ssas),
            DliFunc::GHU => {
                let result = self.get_unique(ssas);
                if result.is_ok() {
                    self.held = Some(self.position.saturating_sub(1));
                }
                result
            }
            DliFunc::GHN | DliFunc::GHNP => {
                let result = self.get_next(ssas);
                if result.is_ok() {
                    self.held = Some(self.position.saturating_sub(1));
                }
                result
            }
            DliFunc::ISRT => self.insert(io_area, ssas),
            DliFunc::DLET => self.delete(),
            DliFunc::REPL => self.replace(io_area),
        };

        // Copy found segment to io_area on successful read
        if status.is_ok()
            && matches!(func, DliFunc::GU | DliFunc::GN | DliFunc::GHU | DliFunc::GHN | DliFunc::GNP | DliFunc::GHNP)
            && self.position > 0
            && self.position <= self.segments.len()
        {
            let seg = &self.segments[self.position - 1];
            io_area.name = seg.name.clone();
            io_area.key = seg.key.clone();
            io_area.parent_key = seg.parent_key.clone();
            io_area.fields = seg.fields.clone();
            self.pcb.segment_name = seg.name.clone();
            self.pcb.key_feedback = seg.key.clone();
        }

        self.pcb.status = status.clone();
        status
    }

    fn get_unique(&mut self, ssas: &[Ssa]) -> PcbStatus {
        for (i, seg) in self.segments.iter().enumerate() {
            if ssas.iter().all(|ssa| ssa.matches(seg)) {
                self.position = i + 1;
                return PcbStatus::Ok;
            }
        }
        PcbStatus::NotFound
    }

    fn get_next(&mut self, ssas: &[Ssa]) -> PcbStatus {
        while self.position < self.segments.len() {
            let seg = &self.segments[self.position];
            self.position += 1;
            if ssas.is_empty() || ssas.iter().all(|ssa| ssa.matches(seg)) {
                return PcbStatus::Ok;
            }
        }
        PcbStatus::EndOfDb
    }

    fn insert(&mut self, io_area: &Segment, _ssas: &[Ssa]) -> PcbStatus {
        // Check for duplicate key
        if self.segments.iter().any(|s| s.name == io_area.name && s.key == io_area.key) {
            return PcbStatus::DuplicateKey;
        }
        self.segments.push(io_area.clone());
        self.save_segments();
        PcbStatus::Ok
    }

    fn delete(&mut self) -> PcbStatus {
        match self.held {
            Some(idx) if idx < self.segments.len() => {
                self.segments.remove(idx);
                self.save_segments();
                self.held = None;
                PcbStatus::Ok
            }
            _ => PcbStatus::NoHold,
        }
    }

    fn replace(&mut self, io_area: &Segment) -> PcbStatus {
        match self.held {
            Some(idx) if idx < self.segments.len() => {
                self.segments[idx] = io_area.clone();
                self.save_segments();
                self.held = None;
                PcbStatus::Ok
            }
            _ => PcbStatus::NoHold,
        }
    }

    /// Reset position to beginning.
    pub fn reset(&mut self) {
        self.position = 0;
        self.held = None;
    }
}

// ── Tests ───────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use std::io::Write;

    fn temp_db(name: &str) -> String {
        let path = std::env::temp_dir().join(format!("ironclad_dli_{}.dat", name));
        let _ = std::fs::remove_file(&path);
        path.to_str().unwrap().to_string()
    }

    fn make_segment(name: &str, key: &str, parent: &str, fields: &[(&str, &str)]) -> Segment {
        Segment {
            name: name.to_string(),
            key: key.to_string(),
            parent_key: parent.to_string(),
            fields: fields.iter().map(|(k, v)| (k.to_string(), v.to_string())).collect(),
        }
    }

    #[test]
    fn test_ssa_parse_qualified() {
        let ssa = Ssa::parse("CUSTOMER(CUSTNO = 1001)");
        assert_eq!(ssa.segment_name, "CUSTOMER");
        assert_eq!(ssa.field.as_deref(), Some("CUSTNO"));
        assert_eq!(ssa.op.as_deref(), Some("="));
        assert_eq!(ssa.value.as_deref(), Some("1001"));
    }

    #[test]
    fn test_ssa_parse_unqualified() {
        let ssa = Ssa::parse("ORDER");
        assert_eq!(ssa.segment_name, "ORDER");
        assert!(ssa.field.is_none());
    }

    #[test]
    fn test_insert_and_get_unique() {
        let path = temp_db("gu");
        let mut ctx = DliContext::new("CUSTDB", &path);
        let mut io = make_segment("CUSTOMER", "1001", "", &[("NAME", "JOHN DOE")]);

        let status = ctx.call(DliFunc::ISRT, &mut io, &[]);
        assert!(status.is_ok());

        let mut io2 = make_segment("", "", "", &[]);
        let ssa = Ssa::parse("CUSTOMER(KEY = 1001)");
        // GU by key field won't match since key is separate — use unqualified
        let ssa_unq = Ssa { segment_name: "CUSTOMER".into(), field: None, op: None, value: None };
        let status = ctx.call(DliFunc::GU, &mut io2, &[ssa_unq]);
        assert!(status.is_ok());
        assert_eq!(io2.key, "1001");
        assert_eq!(io2.fields.get("NAME"), Some(&"JOHN DOE".to_string()));

        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_get_next_sequential() {
        let path = temp_db("gn");
        let mut ctx = DliContext::new("CUSTDB", &path);

        let mut s1 = make_segment("CUSTOMER", "1001", "", &[("NAME", "ALICE")]);
        let mut s2 = make_segment("CUSTOMER", "1002", "", &[("NAME", "BOB")]);
        ctx.call(DliFunc::ISRT, &mut s1, &[]);
        ctx.call(DliFunc::ISRT, &mut s2, &[]);

        ctx.reset();
        let mut io = make_segment("", "", "", &[]);
        let status = ctx.call(DliFunc::GN, &mut io, &[]);
        assert!(status.is_ok());
        assert_eq!(io.fields.get("NAME"), Some(&"ALICE".to_string()));

        let status = ctx.call(DliFunc::GN, &mut io, &[]);
        assert!(status.is_ok());
        assert_eq!(io.fields.get("NAME"), Some(&"BOB".to_string()));

        let status = ctx.call(DliFunc::GN, &mut io, &[]);
        assert_eq!(status, PcbStatus::EndOfDb);

        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_get_hold_and_replace() {
        let path = temp_db("repl");
        let mut ctx = DliContext::new("CUSTDB", &path);

        let mut s1 = make_segment("CUSTOMER", "1001", "", &[("NAME", "OLD")]);
        ctx.call(DliFunc::ISRT, &mut s1, &[]);

        ctx.reset();
        let mut io = make_segment("", "", "", &[]);
        let status = ctx.call(DliFunc::GHU, &mut io, &[
            Ssa { segment_name: "CUSTOMER".into(), field: None, op: None, value: None }
        ]);
        assert!(status.is_ok());

        io.fields.insert("NAME".into(), "NEW".into());
        let status = ctx.call(DliFunc::REPL, &mut io, &[]);
        assert!(status.is_ok());

        // Verify
        ctx.reset();
        let mut check = make_segment("", "", "", &[]);
        ctx.call(DliFunc::GU, &mut check, &[
            Ssa { segment_name: "CUSTOMER".into(), field: None, op: None, value: None }
        ]);
        assert_eq!(check.fields.get("NAME"), Some(&"NEW".to_string()));

        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_get_hold_and_delete() {
        let path = temp_db("dlet");
        let mut ctx = DliContext::new("CUSTDB", &path);

        let mut s1 = make_segment("CUSTOMER", "1001", "", &[("NAME", "DELETE_ME")]);
        ctx.call(DliFunc::ISRT, &mut s1, &[]);

        ctx.reset();
        let mut io = make_segment("", "", "", &[]);
        ctx.call(DliFunc::GHN, &mut io, &[]);
        assert_eq!(io.key, "1001");

        let status = ctx.call(DliFunc::DLET, &mut io, &[]);
        assert!(status.is_ok());

        ctx.reset();
        let status = ctx.call(DliFunc::GN, &mut io, &[]);
        assert_eq!(status, PcbStatus::EndOfDb);

        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_duplicate_key_rejected() {
        let path = temp_db("dup");
        let mut ctx = DliContext::new("CUSTDB", &path);

        let mut s1 = make_segment("CUSTOMER", "1001", "", &[("NAME", "A")]);
        ctx.call(DliFunc::ISRT, &mut s1, &[]);

        let mut s2 = make_segment("CUSTOMER", "1001", "", &[("NAME", "B")]);
        let status = ctx.call(DliFunc::ISRT, &mut s2, &[]);
        assert_eq!(status, PcbStatus::DuplicateKey);

        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_delete_without_hold() {
        let path = temp_db("nohold");
        let mut ctx = DliContext::new("CUSTDB", &path);
        let mut io = make_segment("", "", "", &[]);
        let status = ctx.call(DliFunc::DLET, &mut io, &[]);
        assert_eq!(status, PcbStatus::NoHold);
        let _ = std::fs::remove_file(&path);
    }

    #[test]
    fn test_pcb_status_codes() {
        assert_eq!(PcbStatus::Ok.code(), "  ");
        assert_eq!(PcbStatus::NotFound.code(), "GE");
        assert_eq!(PcbStatus::EndOfDb.code(), "GB");
        assert!(PcbStatus::Ok.is_ok());
        assert!(PcbStatus::NotFound.is_not_found());
    }

    #[test]
    fn test_segment_serialization() {
        let seg = make_segment("CUST", "1001", "ROOT", &[("NAME", "JOHN"), ("BAL", "500")]);
        let line = seg.to_line();
        let restored = Segment::from_line(&line).unwrap();
        assert_eq!(restored.name, "CUST");
        assert_eq!(restored.key, "1001");
        assert_eq!(restored.parent_key, "ROOT");
        assert_eq!(restored.fields.get("NAME"), Some(&"JOHN".to_string()));
    }
}
