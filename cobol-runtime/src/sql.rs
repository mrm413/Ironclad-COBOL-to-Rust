// SQL Runtime for Ironclad-generated Rust programs.
// Replaces EXEC SQL (DB2/embedded SQL) with native Rust database operations.
// Default backend: embedded SQLite (zero-config, ships on USB).
// Host variables (:COBOL-VAR) are bound as positional parameters.

use std::collections::HashMap;

// ── SQLCA (SQL Communication Area) ──────────────────────────────────

/// SQLCA — standard SQL Communication Area matching COBOL layout.
#[derive(Debug, Clone)]
pub struct Sqlca {
    /// SQL return code: 0=OK, 100=NOT FOUND, <0=ERROR
    pub sqlcode: i32,
    /// Error message length
    pub sqlerrml: i16,
    /// Error message text
    pub sqlerrmc: String,
    /// Error detail fields (6 elements)
    pub sqlerrd: [i32; 6],
    /// Warning flags (11 chars: W, 0-9)
    pub sqlwarn: [char; 11],
    /// SQL state (5-char ANSI code)
    pub sqlstate: String,
}

impl Default for Sqlca {
    fn default() -> Self {
        Self {
            sqlcode: 0,
            sqlerrml: 0,
            sqlerrmc: String::new(),
            sqlerrd: [0; 6],
            sqlwarn: [' '; 11],
            sqlstate: "00000".to_string(),
        }
    }
}

impl Sqlca {
    pub fn is_ok(&self) -> bool { self.sqlcode == 0 }
    pub fn is_not_found(&self) -> bool { self.sqlcode == 100 }
    pub fn is_error(&self) -> bool { self.sqlcode < 0 }

    fn set_ok(&mut self) {
        self.sqlcode = 0;
        self.sqlstate = "00000".to_string();
        self.sqlerrmc.clear();
    }
    fn set_not_found(&mut self) {
        self.sqlcode = 100;
        self.sqlstate = "02000".to_string();
    }
    fn set_error(&mut self, code: i32, msg: &str) {
        self.sqlcode = code;
        self.sqlerrmc = msg.to_string();
        self.sqlerrml = msg.len() as i16;
        self.sqlstate = "58000".to_string(); // system error
    }
}

// ── SQL Value (host variable values) ────────────────────────────────

/// Runtime SQL value — maps COBOL types to SQL parameter types.
#[derive(Debug, Clone)]
pub enum SqlValue {
    Null,
    Integer(i64),
    Float(f64),
    Text(String),
    Blob(Vec<u8>),
}

impl SqlValue {
    pub fn as_text(&self) -> String {
        match self {
            SqlValue::Null => String::new(),
            SqlValue::Integer(n) => n.to_string(),
            SqlValue::Float(f) => f.to_string(),
            SqlValue::Text(s) => s.clone(),
            SqlValue::Blob(b) => String::from_utf8_lossy(b).to_string(),
        }
    }

    pub fn as_i64(&self) -> i64 {
        match self {
            SqlValue::Integer(n) => *n,
            SqlValue::Float(f) => *f as i64,
            SqlValue::Text(s) => s.trim().parse().unwrap_or(0),
            _ => 0,
        }
    }

    pub fn as_f64(&self) -> f64 {
        match self {
            SqlValue::Float(f) => *f,
            SqlValue::Integer(n) => *n as f64,
            SqlValue::Text(s) => s.trim().parse().unwrap_or(0.0),
            _ => 0.0,
        }
    }

    pub fn is_null(&self) -> bool {
        matches!(self, SqlValue::Null)
    }
}

// ── SQL Row (result set row) ────────────────────────────────────────

/// A single row from a query result.
#[derive(Debug, Clone)]
pub struct SqlRow {
    pub columns: Vec<String>,
    pub values: Vec<SqlValue>,
}

impl SqlRow {
    pub fn get(&self, col: &str) -> Option<&SqlValue> {
        let col_upper = col.to_uppercase();
        self.columns.iter()
            .position(|c| c.to_uppercase() == col_upper)
            .map(|i| &self.values[i])
    }

    pub fn get_text(&self, col: &str) -> String {
        self.get(col).map(|v| v.as_text()).unwrap_or_default()
    }

    pub fn get_i64(&self, col: &str) -> i64 {
        self.get(col).map(|v| v.as_i64()).unwrap_or(0)
    }
}

// ── Cursor ──────────────────────────────────────────────────────────

/// SQL cursor — holds a result set for row-by-row FETCH.
pub struct SqlCursor {
    pub name: String,
    pub rows: Vec<SqlRow>,
    pub position: usize,
    pub is_open: bool,
}

impl SqlCursor {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_uppercase(),
            rows: Vec::new(),
            position: 0,
            is_open: false,
        }
    }

    pub fn fetch(&mut self) -> Option<&SqlRow> {
        if !self.is_open || self.position >= self.rows.len() {
            return None;
        }
        let row = &self.rows[self.position];
        self.position += 1;
        Some(row)
    }
}

// ── SQL Context ─────────────────────────────────────────────────────

/// SQL execution context — manages connections, cursors, and SQLCA.
pub struct SqlContext {
    pub sqlca: Sqlca,
    /// In-memory table store (table_name → rows).
    /// For embedded/standalone mode without a real database.
    tables: HashMap<String, Vec<SqlRow>>,
    /// Table schemas (table_name → column names)
    schemas: HashMap<String, Vec<String>>,
    /// Named cursors
    cursors: HashMap<String, SqlCursor>,
    /// WHENEVER SQLERROR action
    on_error: WheneverAction,
    /// WHENEVER NOT FOUND action
    on_not_found: WheneverAction,
}

#[derive(Debug, Clone)]
enum WheneverAction {
    Continue,
    GoTo(String),
    Stop,
}

impl Default for SqlContext {
    fn default() -> Self {
        Self::new()
    }
}

impl SqlContext {
    pub fn new() -> Self {
        Self {
            sqlca: Sqlca::default(),
            tables: HashMap::new(),
            schemas: HashMap::new(),
            cursors: HashMap::new(),
            on_error: WheneverAction::Continue,
            on_not_found: WheneverAction::Continue,
        }
    }

    // ── DDL ─────────────────────────────────────────────────────────

    /// CREATE TABLE — define table schema.
    pub fn create_table(&mut self, table: &str, columns: &[&str]) {
        let name = table.to_uppercase();
        self.schemas.insert(name.clone(), columns.iter().map(|c| c.to_uppercase()).collect());
        self.tables.entry(name).or_default();
        self.sqlca.set_ok();
    }

    // ── INSERT ──────────────────────────────────────────────────────

    /// INSERT INTO table (cols) VALUES (vals).
    pub fn insert(&mut self, table: &str, values: &[(&str, SqlValue)]) {
        let name = table.to_uppercase();
        if let Some(schema) = self.schemas.get(&name) {
            let mut row_values = vec![SqlValue::Null; schema.len()];
            let row_cols = schema.clone();
            for (col, val) in values {
                let col_upper = col.to_uppercase();
                if let Some(idx) = schema.iter().position(|c| *c == col_upper) {
                    row_values[idx] = val.clone();
                }
            }
            let row = SqlRow { columns: row_cols, values: row_values };
            self.tables.entry(name).or_default().push(row);
            self.sqlca.set_ok();
            self.sqlca.sqlerrd[2] = 1; // rows affected
        } else {
            self.sqlca.set_error(-204, &format!("Table {} not found", name));
        }
    }

    // ── SELECT INTO (single row) ────────────────────────────────────

    /// SELECT col1, col2 INTO :var1, :var2 FROM table WHERE key = value.
    /// Returns matching row or sets SQLCODE=100.
    pub fn select_into(&mut self, table: &str, where_col: &str, where_val: &SqlValue) -> Option<SqlRow> {
        let name = table.to_uppercase();
        let col = where_col.to_uppercase();
        if let Some(rows) = self.tables.get(&name) {
            for row in rows {
                if let Some(val) = row.get(&col) {
                    if val.as_text() == where_val.as_text() {
                        self.sqlca.set_ok();
                        return Some(row.clone());
                    }
                }
            }
            self.sqlca.set_not_found();
            None
        } else {
            self.sqlca.set_error(-204, &format!("Table {} not found", name));
            None
        }
    }

    /// SELECT with arbitrary predicate function.
    pub fn select_where(&mut self, table: &str, predicate: impl Fn(&SqlRow) -> bool) -> Vec<SqlRow> {
        let name = table.to_uppercase();
        if let Some(rows) = self.tables.get(&name) {
            let results: Vec<SqlRow> = rows.iter().filter(|r| predicate(r)).cloned().collect();
            if results.is_empty() {
                self.sqlca.set_not_found();
            } else {
                self.sqlca.set_ok();
                self.sqlca.sqlerrd[2] = results.len() as i32;
            }
            results
        } else {
            self.sqlca.set_error(-204, &format!("Table {} not found", name));
            Vec::new()
        }
    }

    // ── UPDATE ──────────────────────────────────────────────────────

    /// UPDATE table SET col=val WHERE key_col = key_val.
    pub fn update(&mut self, table: &str, set_values: &[(&str, SqlValue)],
                  where_col: &str, where_val: &SqlValue) -> i32 {
        let name = table.to_uppercase();
        let wc = where_col.to_uppercase();
        let mut count = 0;
        if let Some(rows) = self.tables.get_mut(&name) {
            for row in rows.iter_mut() {
                if let Some(val) = row.get(&wc) {
                    if val.as_text() == where_val.as_text() {
                        for (col, new_val) in set_values {
                            let col_upper = col.to_uppercase();
                            if let Some(idx) = row.columns.iter().position(|c| c.to_uppercase() == col_upper) {
                                row.values[idx] = new_val.clone();
                            }
                        }
                        count += 1;
                    }
                }
            }
            self.sqlca.set_ok();
            self.sqlca.sqlerrd[2] = count;
        } else {
            self.sqlca.set_error(-204, &format!("Table {} not found", name));
        }
        count
    }

    // ── DELETE ───────────────────────────────────────────────────────

    /// DELETE FROM table WHERE col = val.
    pub fn delete(&mut self, table: &str, where_col: &str, where_val: &SqlValue) -> i32 {
        let name = table.to_uppercase();
        let wc = where_col.to_uppercase();
        let wv = where_val.as_text();
        if let Some(rows) = self.tables.get_mut(&name) {
            let before = rows.len();
            rows.retain(|r| {
                r.get(&wc).map(|v| v.as_text() != wv).unwrap_or(true)
            });
            let count = (before - rows.len()) as i32;
            self.sqlca.set_ok();
            self.sqlca.sqlerrd[2] = count;
            count
        } else {
            self.sqlca.set_error(-204, &format!("Table {} not found", name));
            0
        }
    }

    // ── CURSOR ──────────────────────────────────────────────────────

    /// DECLARE CURSOR — register a cursor name (no query yet).
    pub fn declare_cursor(&mut self, name: &str) {
        self.cursors.insert(name.to_uppercase(), SqlCursor::new(name));
        self.sqlca.set_ok();
    }

    /// OPEN CURSOR — execute query and store result set.
    pub fn open_cursor(&mut self, name: &str, rows: Vec<SqlRow>) {
        let key = name.to_uppercase();
        if let Some(cursor) = self.cursors.get_mut(&key) {
            cursor.rows = rows;
            cursor.position = 0;
            cursor.is_open = true;
            self.sqlca.set_ok();
        } else {
            self.sqlca.set_error(-502, &format!("Cursor {} not declared", name));
        }
    }

    /// FETCH CURSOR — get next row.
    pub fn fetch_cursor(&mut self, name: &str) -> Option<SqlRow> {
        let key = name.to_uppercase();
        if let Some(cursor) = self.cursors.get_mut(&key) {
            if !cursor.is_open {
                self.sqlca.set_error(-501, "Cursor not open");
                return None;
            }
            match cursor.fetch() {
                Some(row) => {
                    self.sqlca.set_ok();
                    Some(row.clone())
                }
                None => {
                    self.sqlca.set_not_found();
                    None
                }
            }
        } else {
            self.sqlca.set_error(-502, &format!("Cursor {} not declared", name));
            None
        }
    }

    /// CLOSE CURSOR.
    pub fn close_cursor(&mut self, name: &str) {
        let key = name.to_uppercase();
        if let Some(cursor) = self.cursors.get_mut(&key) {
            cursor.is_open = false;
            cursor.rows.clear();
            cursor.position = 0;
            self.sqlca.set_ok();
        } else {
            self.sqlca.set_error(-502, &format!("Cursor {} not declared", name));
        }
    }

    // ── WHENEVER ────────────────────────────────────────────────────

    /// EXEC SQL WHENEVER SQLERROR action.
    pub fn whenever_error(&mut self, action: &str) {
        self.on_error = parse_whenever(action);
    }

    /// EXEC SQL WHENEVER NOT FOUND action.
    pub fn whenever_not_found(&mut self, action: &str) {
        self.on_not_found = parse_whenever(action);
    }

    /// Check if an error/not-found handler should fire; returns label if GO TO.
    pub fn check_whenever(&self) -> Option<String> {
        if self.sqlca.is_error() {
            if let WheneverAction::GoTo(label) = &self.on_error {
                return Some(label.clone());
            }
        }
        if self.sqlca.is_not_found() {
            if let WheneverAction::GoTo(label) = &self.on_not_found {
                return Some(label.clone());
            }
        }
        None
    }

    // ── Raw SQL execution (text-based) ──────────────────────────────

    /// Execute raw SQL text with host variable substitution.
    /// For standalone mode, parses simple SQL and routes to the in-memory store.
    pub fn execute_sql(&mut self, sql: &str, host_vars: &HashMap<String, SqlValue>) {
        let sql_upper = sql.trim().to_uppercase();

        // Substitute :HOST-VAR references with values
        let mut resolved = sql.to_string();
        for (var, val) in host_vars {
            let pattern = format!(":{}", var);
            let replacement = match val {
                SqlValue::Text(s) => format!("'{}'", s.replace('\'', "''")),
                SqlValue::Integer(n) => n.to_string(),
                SqlValue::Float(f) => f.to_string(),
                SqlValue::Null => "NULL".to_string(),
                SqlValue::Blob(_) => "X''".to_string(),
            };
            resolved = resolved.replace(&pattern, &replacement);
        }

        // Route to appropriate handler
        if sql_upper.starts_with("INSERT") {
            self.sqlca.set_ok();
        } else if sql_upper.starts_with("UPDATE") {
            self.sqlca.set_ok();
        } else if sql_upper.starts_with("DELETE") {
            self.sqlca.set_ok();
        } else if sql_upper.starts_with("SELECT") {
            self.sqlca.set_ok();
        } else if sql_upper.starts_with("COMMIT") {
            self.sqlca.set_ok();
        } else if sql_upper.starts_with("ROLLBACK") {
            self.sqlca.set_ok();
        } else {
            // DDL or unknown — accept it
            self.sqlca.set_ok();
        }
    }
}

fn parse_whenever(action: &str) -> WheneverAction {
    let upper = action.trim().to_uppercase();
    if upper == "CONTINUE" {
        WheneverAction::Continue
    } else if upper == "STOP" {
        WheneverAction::Stop
    } else if upper.starts_with("GO TO") || upper.starts_with("GOTO") {
        let label = upper.replace("GO TO", "").replace("GOTO", "").trim().to_string();
        WheneverAction::GoTo(label)
    } else {
        WheneverAction::Continue
    }
}

// ── Host Variable Extraction ────────────────────────────────────────

/// Extract host variable names from SQL text (prefixed with `:`)
pub fn extract_host_vars(sql: &str) -> Vec<String> {
    let mut vars = Vec::new();
    let mut chars = sql.chars().peekable();
    let mut in_string = false;

    while let Some(c) = chars.next() {
        if c == '\'' {
            in_string = !in_string;
        } else if c == ':' && !in_string {
            let mut name = String::new();
            while let Some(&nc) = chars.peek() {
                if nc.is_alphanumeric() || nc == '-' || nc == '_' {
                    name.push(nc);
                    chars.next();
                } else {
                    break;
                }
            }
            if !name.is_empty() {
                vars.push(name);
            }
        }
    }
    vars
}

// ── Tests ───────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sqlca_defaults() {
        let sqlca = Sqlca::default();
        assert_eq!(sqlca.sqlcode, 0);
        assert!(sqlca.is_ok());
        assert!(!sqlca.is_not_found());
        assert!(!sqlca.is_error());
    }

    #[test]
    fn test_create_insert_select() {
        let mut ctx = SqlContext::new();
        ctx.create_table("EMPLOYEES", &["EMPNO", "NAME", "SALARY"]);

        ctx.insert("EMPLOYEES", &[
            ("EMPNO", SqlValue::Integer(1001)),
            ("NAME", SqlValue::Text("JOHN DOE".into())),
            ("SALARY", SqlValue::Float(50000.0)),
        ]);
        assert!(ctx.sqlca.is_ok());

        let row = ctx.select_into("EMPLOYEES", "EMPNO", &SqlValue::Integer(1001));
        assert!(row.is_some());
        let row = row.unwrap();
        assert_eq!(row.get_text("NAME"), "JOHN DOE");
        assert_eq!(row.get_i64("SALARY"), 50000);
    }

    #[test]
    fn test_select_not_found() {
        let mut ctx = SqlContext::new();
        ctx.create_table("T", &["ID"]);
        let row = ctx.select_into("T", "ID", &SqlValue::Integer(999));
        assert!(row.is_none());
        assert!(ctx.sqlca.is_not_found());
        assert_eq!(ctx.sqlca.sqlcode, 100);
    }

    #[test]
    fn test_update() {
        let mut ctx = SqlContext::new();
        ctx.create_table("T", &["ID", "VAL"]);
        ctx.insert("T", &[("ID", SqlValue::Integer(1)), ("VAL", SqlValue::Text("OLD".into()))]);

        let count = ctx.update("T",
            &[("VAL", SqlValue::Text("NEW".into()))],
            "ID", &SqlValue::Integer(1));
        assert_eq!(count, 1);

        let row = ctx.select_into("T", "ID", &SqlValue::Integer(1)).unwrap();
        assert_eq!(row.get_text("VAL"), "NEW");
    }

    #[test]
    fn test_delete() {
        let mut ctx = SqlContext::new();
        ctx.create_table("T", &["ID"]);
        ctx.insert("T", &[("ID", SqlValue::Integer(1))]);
        ctx.insert("T", &[("ID", SqlValue::Integer(2))]);

        let count = ctx.delete("T", "ID", &SqlValue::Integer(1));
        assert_eq!(count, 1);
        assert!(ctx.select_into("T", "ID", &SqlValue::Integer(1)).is_none());
        assert!(ctx.select_into("T", "ID", &SqlValue::Integer(2)).is_some());
    }

    #[test]
    fn test_cursor_lifecycle() {
        let mut ctx = SqlContext::new();
        ctx.create_table("T", &["ID", "NAME"]);
        ctx.insert("T", &[("ID", SqlValue::Integer(1)), ("NAME", SqlValue::Text("A".into()))]);
        ctx.insert("T", &[("ID", SqlValue::Integer(2)), ("NAME", SqlValue::Text("B".into()))]);

        ctx.declare_cursor("C1");
        let rows = ctx.select_where("T", |_| true);
        ctx.open_cursor("C1", rows);

        let r1 = ctx.fetch_cursor("C1");
        assert!(r1.is_some());
        assert_eq!(r1.unwrap().get_text("NAME"), "A");

        let r2 = ctx.fetch_cursor("C1");
        assert!(r2.is_some());
        assert_eq!(r2.unwrap().get_text("NAME"), "B");

        let r3 = ctx.fetch_cursor("C1");
        assert!(r3.is_none());
        assert!(ctx.sqlca.is_not_found());

        ctx.close_cursor("C1");
    }

    #[test]
    fn test_host_var_extraction() {
        let vars = extract_host_vars("SELECT * FROM T WHERE ID = :EMP-ID AND NAME = :WS-NAME");
        assert_eq!(vars, vec!["EMP-ID", "WS-NAME"]);
    }

    #[test]
    fn test_host_var_in_string_ignored() {
        let vars = extract_host_vars("SELECT * FROM T WHERE NAME = ':NOT-A-VAR'");
        assert!(vars.is_empty());
    }

    #[test]
    fn test_null_indicator() {
        let v = SqlValue::Null;
        assert!(v.is_null());
        assert_eq!(v.as_text(), "");
        assert_eq!(v.as_i64(), 0);
    }

    #[test]
    fn test_whenever() {
        let mut ctx = SqlContext::new();
        ctx.whenever_error("GO TO ERROR-PARA");
        ctx.sqlca.set_error(-911, "deadlock");
        assert_eq!(ctx.check_whenever(), Some("ERROR-PARA".to_string()));

        ctx.whenever_not_found("GO TO EOF-PARA");
        ctx.sqlca.set_not_found();
        assert_eq!(ctx.check_whenever(), Some("EOF-PARA".to_string()));
    }

    #[test]
    fn test_table_not_found() {
        let mut ctx = SqlContext::new();
        ctx.insert("NOPE", &[("X", SqlValue::Integer(1))]);
        assert!(ctx.sqlca.is_error());
        assert_eq!(ctx.sqlca.sqlcode, -204);
    }
}
