// Report Writer Runtime for Ironclad-generated Rust programs.
// Replaces COBOL Report Writer (INITIATE/GENERATE/TERMINATE) with native Rust.
// Output: formatted text reports with page breaks, headers, footers, control breaks.

use std::collections::HashMap;
use std::io::{self, Write, BufWriter};
use std::fs::File;

// ── Report Line Types ───────────────────────────────────────────────

#[derive(Debug, Clone)]
pub enum LineType {
    ReportHeading,
    PageHeading,
    ControlHeading(String),  // group name
    Detail,
    ControlFooting(String),  // group name
    PageFooting,
    ReportFooting,
}

/// A formatted line in the report.
#[derive(Debug, Clone)]
pub struct ReportLine {
    pub line_type: LineType,
    pub text: String,
    pub fields: Vec<(String, String)>, // (name, formatted_value)
}

impl ReportLine {
    pub fn detail(fields: Vec<(String, String)>) -> Self {
        let text = fields.iter().map(|(_, v)| v.as_str()).collect::<Vec<_>>().join("  ");
        Self { line_type: LineType::Detail, text, fields }
    }

    pub fn heading(line_type: LineType, text: &str) -> Self {
        Self { line_type, text: text.to_string(), fields: Vec::new() }
    }
}

// ── Control Break ───────────────────────────────────────────────────

/// Tracks control break state for a single control field.
#[derive(Debug, Clone)]
struct ControlBreak {
    field_name: String,
    last_value: Option<String>,
    sum_fields: HashMap<String, f64>,  // running totals
    count: u64,
}

impl ControlBreak {
    fn new(field_name: &str) -> Self {
        Self {
            field_name: field_name.to_string(),
            last_value: None,
            sum_fields: HashMap::new(),
            count: 0,
        }
    }

    fn check(&mut self, current_value: &str) -> bool {
        let changed = match &self.last_value {
            Some(prev) => prev != current_value,
            None => false,
        };
        self.last_value = Some(current_value.to_string());
        changed
    }

    fn accumulate(&mut self, field: &str, value: f64) {
        *self.sum_fields.entry(field.to_string()).or_insert(0.0) += value;
        self.count += 1;
    }

    fn reset(&mut self) {
        self.sum_fields.clear();
        self.count = 0;
    }
}

// ── Report Context ──────────────────────────────────────────────────

/// Report Writer context — manages one report's state.
pub struct ReportContext {
    pub name: String,
    /// Lines per page (from LINAGE or default 60)
    pub page_size: usize,
    /// Current line on page (1-based)
    pub line_number: usize,
    /// Current page number
    pub page_number: usize,
    /// Total lines generated
    pub total_lines: usize,
    /// Page heading text
    pub page_heading: Option<String>,
    /// Page footing text
    pub page_footing: Option<String>,
    /// Report heading text
    pub report_heading: Option<String>,
    /// Report footing text
    pub report_footing: Option<String>,
    /// Control break fields (in minor-to-major order)
    control_breaks: Vec<ControlBreak>,
    /// Grand totals
    grand_totals: HashMap<String, f64>,
    grand_count: u64,
    /// Column headers
    pub column_headers: Vec<String>,
    /// Column widths
    pub column_widths: Vec<usize>,
    /// Output sink
    output: Box<dyn Write + Send>,
    /// Is the report active?
    active: bool,
    /// Lines at top (before first detail, after heading)
    pub lines_at_top: usize,
    /// Footing line (trigger page break when reached)
    pub footing_line: usize,
}

impl ReportContext {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_uppercase(),
            page_size: 60,
            line_number: 0,
            page_number: 0,
            total_lines: 0,
            page_heading: None,
            page_footing: None,
            report_heading: None,
            report_footing: None,
            control_breaks: Vec::new(),
            grand_totals: HashMap::new(),
            grand_count: 0,
            column_headers: Vec::new(),
            column_widths: Vec::new(),
            output: Box::new(BufWriter::new(io::stdout())),
            active: false,
            lines_at_top: 1,
            footing_line: 0, // 0 = no footing trigger
        }
    }

    /// Create with file output.
    pub fn with_file(name: &str, path: &str) -> io::Result<Self> {
        let file = File::create(path)?;
        let mut ctx = Self::new(name);
        ctx.output = Box::new(BufWriter::new(file));
        Ok(ctx)
    }

    /// Create with in-memory buffer (for testing).
    pub fn with_buffer(name: &str, buffer: Box<dyn Write + Send>) -> Self {
        let mut ctx = Self::new(name);
        ctx.output = buffer;
        ctx
    }

    /// Set page size (LINAGE).
    pub fn set_page_size(&mut self, lines: usize) {
        self.page_size = lines;
        if self.footing_line == 0 {
            self.footing_line = lines.saturating_sub(3);
        }
    }

    /// Add a control break field.
    pub fn add_control_break(&mut self, field_name: &str) {
        self.control_breaks.push(ControlBreak::new(field_name));
    }

    /// Set column definitions.
    pub fn set_columns(&mut self, headers: Vec<String>, widths: Vec<usize>) {
        self.column_headers = headers;
        self.column_widths = widths;
    }

    // ── INITIATE ────────────────────────────────────────────────────

    /// INITIATE report — begin report processing.
    pub fn initiate(&mut self) {
        self.active = true;
        self.page_number = 0;
        self.line_number = 0;
        self.total_lines = 0;
        self.grand_totals.clear();
        self.grand_count = 0;
        for cb in &mut self.control_breaks {
            cb.reset();
            cb.last_value = None;
        }
        // Emit report heading
        if let Some(heading) = &self.report_heading.clone() {
            self.emit_line(heading);
        }
        self.new_page();
    }

    // ── GENERATE ────────────────────────────────────────────────────

    /// GENERATE detail — process one detail record.
    pub fn generate(&mut self, fields: &[(&str, &str)]) {
        if !self.active { return; }

        // Check control breaks (major to minor)
        let mut breaks = Vec::new();
        for (i, cb) in self.control_breaks.iter_mut().enumerate() {
            let value = fields.iter()
                .find(|(k, _)| k.eq_ignore_ascii_case(&cb.field_name))
                .map(|(_, v)| *v)
                .unwrap_or("");
            if cb.check(value) {
                breaks.push(i);
            }
        }

        // Emit control footings for broken levels (minor to major)
        for &idx in breaks.iter().rev() {
            let cb = &self.control_breaks[idx];
            let totals: Vec<String> = cb.sum_fields.iter()
                .map(|(k, v)| format!("  {} Total: {:.2}", k, v))
                .collect();
            let footer = format!("*** {} Break ({} records) ***{}",
                cb.field_name,
                cb.count,
                if totals.is_empty() { String::new() } else { format!("\n{}", totals.join("\n")) }
            );
            self.emit_line(&footer);
        }

        // Reset broken control breaks
        for &idx in &breaks {
            self.control_breaks[idx].reset();
            // Emit control heading for new value
            let cb = &self.control_breaks[idx];
            if let Some(val) = &cb.last_value {
                let heading = format!("--- {} = {} ---", cb.field_name, val);
                self.emit_line(&heading);
            }
        }

        // Accumulate values
        for (name, val_str) in fields {
            if let Ok(v) = val_str.parse::<f64>() {
                for cb in &mut self.control_breaks {
                    cb.accumulate(name, v);
                }
                *self.grand_totals.entry(name.to_string()).or_insert(0.0) += v;
            }
        }
        self.grand_count += 1;

        // Emit detail line
        let detail = if self.column_widths.is_empty() {
            fields.iter().map(|(_, v)| *v).collect::<Vec<_>>().join("  ")
        } else {
            fields.iter().zip(self.column_widths.iter())
                .map(|((_, v), w)| format!("{:<width$}", v, width = w))
                .collect::<Vec<_>>()
                .join(" ")
        };
        self.emit_line(&detail);
    }

    // ── TERMINATE ───────────────────────────────────────────────────

    /// TERMINATE report — end report processing, emit final totals.
    pub fn terminate(&mut self) {
        if !self.active { return; }

        // Emit remaining control footings
        for i in (0..self.control_breaks.len()).rev() {
            let cb = &self.control_breaks[i];
            if cb.count > 0 {
                let totals: Vec<String> = cb.sum_fields.iter()
                    .map(|(k, v)| format!("  {} Total: {:.2}", k, v))
                    .collect();
                let footer = format!("*** {} Final ({} records) ***{}",
                    cb.field_name,
                    cb.count,
                    if totals.is_empty() { String::new() } else { format!("\n{}", totals.join("\n")) }
                );
                self.emit_line(&footer);
            }
        }

        // Grand totals
        if !self.grand_totals.is_empty() {
            self.emit_line(&format!("=== GRAND TOTAL ({} records) ===", self.grand_count));
            let totals: Vec<(String, f64)> = self.grand_totals.iter()
                .map(|(k, v)| (k.clone(), *v)).collect();
            for (name, total) in &totals {
                self.emit_line(&format!("  {}: {:.2}", name, total));
            }
        }

        // Report footing
        if let Some(footing) = &self.report_footing.clone() {
            self.emit_line(footing);
        }

        // Page footing on last page
        self.emit_page_footing();

        let _ = self.output.flush();
        self.active = false;
    }

    // ── Internal ────────────────────────────────────────────────────

    fn new_page(&mut self) {
        if self.page_number > 0 {
            self.emit_page_footing();
            let _ = self.output.write_all(b"\x0C"); // form feed
        }
        self.page_number += 1;
        self.line_number = 0;

        // Page heading
        if let Some(heading) = &self.page_heading.clone() {
            let heading = heading.replace("{PAGE}", &self.page_number.to_string());
            let _ = writeln!(self.output, "{}", heading);
            self.line_number += 1;
        }

        // Column headers
        if !self.column_headers.is_empty() {
            let header = if self.column_widths.is_empty() {
                self.column_headers.join("  ")
            } else {
                self.column_headers.iter().zip(self.column_widths.iter())
                    .map(|(h, w)| format!("{:<width$}", h, width = w))
                    .collect::<Vec<_>>()
                    .join(" ")
            };
            let _ = writeln!(self.output, "{}", header);
            let sep: String = header.chars().map(|c| if c == ' ' { ' ' } else { '-' }).collect();
            let _ = writeln!(self.output, "{}", sep);
            self.line_number += 2;
        }

        // Lines at top spacing
        for _ in 0..self.lines_at_top.saturating_sub(self.line_number) {
            let _ = writeln!(self.output);
            self.line_number += 1;
        }
    }

    fn emit_page_footing(&mut self) {
        if let Some(footing) = &self.page_footing.clone() {
            // Advance to footing position
            while self.line_number < self.page_size.saturating_sub(1) {
                let _ = writeln!(self.output);
                self.line_number += 1;
            }
            let footing = footing.replace("{PAGE}", &self.page_number.to_string());
            let _ = writeln!(self.output, "{}", footing);
        }
    }

    fn emit_line(&mut self, text: &str) {
        // Check page break
        let trigger = if self.footing_line > 0 { self.footing_line } else { self.page_size };
        if self.line_number >= trigger {
            self.new_page();
        }

        let _ = writeln!(self.output, "{}", text);
        self.line_number += 1;
        self.total_lines += 1;
    }
}

// ── Convenience functions (called by generated code) ────────────────

/// Global report registry for generated programs.
static mut REPORTS: Option<HashMap<String, ReportContext>> = None;

fn reports() -> &'static mut HashMap<String, ReportContext> {
    unsafe {
        REPORTS.get_or_insert_with(HashMap::new)
    }
}

/// Register a report context (call during program init).
pub fn register_report(ctx: ReportContext) {
    reports().insert(ctx.name.clone(), ctx);
}

/// INITIATE report-name.
pub fn report_initiate(name: &str) {
    if let Some(ctx) = reports().get_mut(&name.to_uppercase()) {
        ctx.initiate();
    }
}

/// GENERATE report-group (detail line).
pub fn report_generate(name: &str, fields: &[(&str, &str)]) {
    if let Some(ctx) = reports().get_mut(&name.to_uppercase()) {
        ctx.generate(fields);
    }
}

/// TERMINATE report-name.
pub fn report_terminate(name: &str) {
    if let Some(ctx) = reports().get_mut(&name.to_uppercase()) {
        ctx.terminate();
    }
}

// ── Tests ───────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;

    fn capture_report(name: &str) -> (ReportContext, Vec<u8>) {
        let buf: Vec<u8> = Vec::new();
        let ctx = ReportContext::with_buffer(name, Box::new(buf));
        (ctx, Vec::new())
    }

    #[test]
    fn test_basic_initiate_generate_terminate() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("TEST", Box::new(buf));
        ctx.page_size = 100; // large page to avoid breaks
        ctx.page_heading = Some("Test Report - Page {PAGE}".into());

        ctx.initiate();
        ctx.generate(&[("NAME", "John"), ("AMOUNT", "100.00")]);
        ctx.generate(&[("NAME", "Jane"), ("AMOUNT", "200.00")]);
        ctx.terminate();

        assert_eq!(ctx.total_lines, 4); // heading + 2 details + grand total header
        assert_eq!(ctx.grand_count, 2);
    }

    #[test]
    fn test_control_break() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("SALES", Box::new(buf));
        ctx.page_size = 100;
        ctx.add_control_break("DEPT");

        ctx.initiate();
        ctx.generate(&[("DEPT", "SALES"), ("AMT", "100")]);
        ctx.generate(&[("DEPT", "SALES"), ("AMT", "200")]);
        ctx.generate(&[("DEPT", "ENGINEERING"), ("AMT", "300")]); // break here
        ctx.terminate();

        assert!(ctx.grand_count == 3);
    }

    #[test]
    fn test_page_break() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("PG", Box::new(buf));
        ctx.page_size = 5;
        ctx.footing_line = 4;

        ctx.initiate();
        for i in 0..10 {
            ctx.generate(&[("LINE", &i.to_string())]);
        }
        ctx.terminate();

        assert!(ctx.page_number > 1);
    }

    #[test]
    fn test_column_formatting() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("COL", Box::new(buf));
        ctx.page_size = 100;
        ctx.set_columns(vec!["NAME".into(), "AMOUNT".into()], vec![20, 10]);

        ctx.initiate();
        ctx.generate(&[("NAME", "Test"), ("AMOUNT", "99.99")]);
        ctx.terminate();
    }

    #[test]
    fn test_grand_totals() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("TOT", Box::new(buf));
        ctx.page_size = 100;

        ctx.initiate();
        ctx.generate(&[("AMT", "100.50")]);
        ctx.generate(&[("AMT", "200.25")]);
        ctx.generate(&[("AMT", "50.25")]);
        ctx.terminate();

        let total = ctx.grand_totals.get("AMT").copied().unwrap_or(0.0);
        assert!((total - 351.0).abs() < 0.01);
        assert_eq!(ctx.grand_count, 3);
    }

    #[test]
    fn test_inactive_generate_ignored() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("NOOP", Box::new(buf));
        // Don't call initiate
        ctx.generate(&[("X", "1")]);
        assert_eq!(ctx.total_lines, 0);
    }

    #[test]
    fn test_linage() {
        let buf = Vec::<u8>::new();
        let mut ctx = ReportContext::with_buffer("LIN", Box::new(buf));
        ctx.set_page_size(40);
        assert_eq!(ctx.page_size, 40);
        assert_eq!(ctx.footing_line, 37);
    }
}
