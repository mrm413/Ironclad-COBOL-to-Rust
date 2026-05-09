// ═══════════════════════════════════════════════════════════════════════════
// Behavioral Coercion Oracle — Adaptive Type Intelligence Engine
// Torsova LLC — Ironclad Runtime
//
// Learns from parity test results which coercion strategies produce correct
// output for each COBOL type-context pattern. Confidence scores update via
// Bayesian weighting — the more evidence, the stronger the signal.
//
// Architecture:
//   ┌──────────────────────────────────────────────────────┐
//   │  CoercionOracle                                      │
//   │  ┌────────────┐ ┌──────────────┐ ┌────────────────┐ │
//   │  │ PatternMap  │ │ ConfidenceDB │ │ FeedbackEngine │ │
//   │  │ (fingerprnt)│ │ (Bayesian)   │ │ (parity loop)  │ │
//   │  └──────┬─────┘ └──────┬───────┘ └──────┬─────────┘ │
//   │         └───────────────┼────────────────┘           │
//   │                         ▼                             │
//   │         ┌─────────────────────────────┐              │
//   │         │    Decision Engine          │              │
//   │         │  context → best strategy    │              │
//   │         └─────────────────────────────┘              │
//   │                         │                             │
//   │                         ▼                             │
//   │         ┌─────────────────────────────┐              │
//   │         │  Static Coerce<T> traits    │              │
//   │         │  (coerce.rs — unchanged)    │              │
//   │         └─────────────────────────────┘              │
//   └──────────────────────────────────────────────────────┘
// ═══════════════════════════════════════════════════════════════════════════

use std::collections::HashMap;
use std::path::{Path, PathBuf};

// ─── Type Classification ─────────────────────────────────────────────────

/// Abstract classification of a COBOL data type for pattern matching.
/// The oracle groups coercions by these categories, not exact PIC strings,
/// so knowledge transfers across similar fields.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum CoercionType {
    /// PIC 9(n) — unsigned integer display
    NumericDisplay(u8),
    /// PIC S9(n) — signed integer display
    SignedDisplay(u8),
    /// PIC 9(n)V9(m) — fixed-point decimal display
    DecimalDisplay(u8, u8),
    /// PIC X(n) — alphanumeric
    Alphanumeric(u16),
    /// PIC A(n) — alphabetic
    Alphabetic(u16),
    /// COMP / COMP-5 — binary integer
    Binary(u8),
    /// COMP-3 — packed decimal
    Packed(u8),
    /// COMP-1 — single-precision float
    Float32,
    /// COMP-2 — double-precision float
    Float64,
    /// Group item (no PIC, subordinate fields)
    Group(u16),
    /// Edited numeric (PIC Z, -, +, *, etc.)
    EditedNumeric,
    /// Edited alphanumeric (PIC X with B, 0, /)
    EditedAlphanumeric,
    /// USAGE INDEX
    Index,
    /// USAGE POINTER
    Pointer,
    /// Literal value (numeric or alphanumeric)
    Literal,
    /// Figurative constant (SPACES, ZEROS, etc.)
    Figurative,
    /// Unknown / unclassified
    Unknown,
}

impl CoercionType {
    /// Create from a PIC string and optional USAGE clause.
    pub fn from_pic(pic: &str, usage: Option<&str>) -> Self {
        let pic_upper = pic.to_uppercase();
        let usage_upper = usage.map(|u| u.to_uppercase());

        // Check USAGE first — it overrides PIC interpretation
        if let Some(ref u) = usage_upper {
            if u.contains("COMP-3") || u.contains("PACKED") {
                let digits = count_pic_digits(&pic_upper);
                return CoercionType::Packed(digits);
            }
            if u.contains("COMP-1") { return CoercionType::Float32; }
            if u.contains("COMP-2") { return CoercionType::Float64; }
            if u.contains("COMP") || u.contains("BINARY") {
                let digits = count_pic_digits(&pic_upper);
                return CoercionType::Binary(digits);
            }
            if u.contains("INDEX") { return CoercionType::Index; }
            if u.contains("POINTER") { return CoercionType::Pointer; }
        }

        // Edited check — any Z, *, -, +, B, 0, / in PIC
        if pic_upper.contains('Z') || pic_upper.contains('*')
            || pic_upper.contains('+') || pic_upper.contains('-')
            || pic_upper.contains('B') || pic_upper.contains('/')
        {
            if pic_upper.contains('9') || pic_upper.contains('Z') || pic_upper.contains('*') {
                return CoercionType::EditedNumeric;
            }
            return CoercionType::EditedAlphanumeric;
        }

        // Decimal — has V or implied decimal
        if pic_upper.contains('V') {
            let (int_d, dec_d) = count_pic_decimal(&pic_upper);
            if pic_upper.contains('S') {
                return CoercionType::DecimalDisplay(int_d, dec_d);
            }
            return CoercionType::DecimalDisplay(int_d, dec_d);
        }

        // Pure numeric
        if pic_upper.contains('9') && !pic_upper.contains('X') && !pic_upper.contains('A') {
            let digits = count_pic_digits(&pic_upper);
            if pic_upper.contains('S') {
                return CoercionType::SignedDisplay(digits);
            }
            return CoercionType::NumericDisplay(digits);
        }

        // Alphabetic
        if pic_upper.contains('A') && !pic_upper.contains('X') && !pic_upper.contains('9') {
            let size = count_pic_size(&pic_upper);
            return CoercionType::Alphabetic(size);
        }

        // Alphanumeric (default for PIC X)
        if pic_upper.contains('X') {
            let size = count_pic_size(&pic_upper);
            return CoercionType::Alphanumeric(size);
        }

        CoercionType::Unknown
    }

    /// Compact string tag for pattern key generation.
    fn tag(&self) -> String {
        match self {
            CoercionType::NumericDisplay(d) => format!("N{}", d),
            CoercionType::SignedDisplay(d) => format!("SN{}", d),
            CoercionType::DecimalDisplay(i, d) => format!("D{}V{}", i, d),
            CoercionType::Alphanumeric(s) => format!("X{}", s),
            CoercionType::Alphabetic(s) => format!("A{}", s),
            CoercionType::Binary(d) => format!("B{}", d),
            CoercionType::Packed(d) => format!("P{}", d),
            CoercionType::Float32 => "F32".into(),
            CoercionType::Float64 => "F64".into(),
            CoercionType::Group(s) => format!("G{}", s),
            CoercionType::EditedNumeric => "EN".into(),
            CoercionType::EditedAlphanumeric => "EA".into(),
            CoercionType::Index => "IDX".into(),
            CoercionType::Pointer => "PTR".into(),
            CoercionType::Literal => "LIT".into(),
            CoercionType::Figurative => "FIG".into(),
            CoercionType::Unknown => "UNK".into(),
        }
    }

    /// Parse a tag string back into a CoercionType.
    pub fn from_tag(tag: &str) -> Self {
        // Fixed tags
        match tag {
            "F32" => return CoercionType::Float32,
            "F64" => return CoercionType::Float64,
            "EN" => return CoercionType::EditedNumeric,
            "EA" => return CoercionType::EditedAlphanumeric,
            "IDX" => return CoercionType::Index,
            "PTR" => return CoercionType::Pointer,
            "LIT" => return CoercionType::Literal,
            "FIG" => return CoercionType::Figurative,
            "UNK" => return CoercionType::Unknown,
            // Generalized tags from pattern DB
            "N_sm" => return CoercionType::NumericDisplay(4),
            "N_md" => return CoercionType::NumericDisplay(9),
            "N_lg" => return CoercionType::NumericDisplay(18),
            "SN_sm" => return CoercionType::SignedDisplay(4),
            "SN_md" => return CoercionType::SignedDisplay(9),
            "SN_lg" => return CoercionType::SignedDisplay(18),
            "X_sm" => return CoercionType::Alphanumeric(10),
            "X_md" => return CoercionType::Alphanumeric(30),
            "X_lg" => return CoercionType::Alphanumeric(100),
            "PACK" => return CoercionType::Packed(9),
            "DEC" => return CoercionType::DecimalDisplay(9, 2),
            "G0" => return CoercionType::Group(0),
            "*" => return CoercionType::Unknown,
            _ => {}
        }
        // Parametric tags: N5, SN9, D5V2, X10, A5, B4, P9, G80
        if tag.starts_with("SN") {
            if let Ok(d) = tag[2..].parse::<u8>() { return CoercionType::SignedDisplay(d); }
        } else if tag.starts_with("N") {
            if let Ok(d) = tag[1..].parse::<u8>() { return CoercionType::NumericDisplay(d); }
        } else if tag.starts_with("D") {
            if let Some(v_pos) = tag.find('V') {
                if let (Ok(i), Ok(d)) = (tag[1..v_pos].parse::<u8>(), tag[v_pos+1..].parse::<u8>()) {
                    return CoercionType::DecimalDisplay(i, d);
                }
            }
        } else if tag.starts_with("X") {
            if let Ok(s) = tag[1..].parse::<u16>() { return CoercionType::Alphanumeric(s); }
        } else if tag.starts_with("A") {
            if let Ok(s) = tag[1..].parse::<u16>() { return CoercionType::Alphabetic(s); }
        } else if tag.starts_with("B") {
            if let Ok(d) = tag[1..].parse::<u8>() { return CoercionType::Binary(d); }
        } else if tag.starts_with("P") {
            if let Ok(d) = tag[1..].parse::<u8>() { return CoercionType::Packed(d); }
        } else if tag.starts_with("G") {
            if let Ok(s) = tag[1..].parse::<u16>() { return CoercionType::Group(s); }
        }
        CoercionType::Unknown
    }

    /// Generalized tag — collapses specific sizes into categories for broader matching.
    /// This lets knowledge about PIC 9(5) transfer to PIC 9(7).
    fn generalized_tag(&self) -> String {
        match self {
            CoercionType::NumericDisplay(d) => {
                if *d <= 4 { "N_sm".into() }
                else if *d <= 9 { "N_md".into() }
                else { "N_lg".into() }
            }
            CoercionType::SignedDisplay(d) => {
                if *d <= 4 { "SN_sm".into() }
                else if *d <= 9 { "SN_md".into() }
                else { "SN_lg".into() }
            }
            CoercionType::DecimalDisplay(_, _) => "DEC".into(),
            CoercionType::Alphanumeric(s) => {
                if *s <= 10 { "X_sm".into() }
                else if *s <= 80 { "X_md".into() }
                else { "X_lg".into() }
            }
            CoercionType::Alphabetic(_) => "ALPHA".into(),
            CoercionType::Binary(_) => "BIN".into(),
            CoercionType::Packed(_) => "PACK".into(),
            _ => self.tag(),
        }
    }
}

/// Count total digit positions in a PIC string.
fn count_pic_digits(pic: &str) -> u8 {
    let mut count = 0u16;
    let chars: Vec<char> = pic.chars().collect();
    let mut i = 0;
    while i < chars.len() {
        if chars[i] == '9' {
            if i + 1 < chars.len() && chars[i + 1] == '(' {
                if let Some(end) = pic[i+2..].find(')') {
                    if let Ok(n) = pic[i+2..i+2+end].parse::<u16>() {
                        count += n;
                    }
                    i += 3 + end;
                    continue;
                }
            }
            count += 1;
        }
        i += 1;
    }
    count.min(255) as u8
}

/// Count integer and decimal digits from PIC with V.
fn count_pic_decimal(pic: &str) -> (u8, u8) {
    let parts: Vec<&str> = pic.split('V').collect();
    let int_part = parts.first().copied().unwrap_or("");
    let dec_part = parts.get(1).copied().unwrap_or("");
    (count_pic_digits(int_part), count_pic_digits(dec_part))
}

/// Count total character positions.
fn count_pic_size(pic: &str) -> u16 {
    let mut count = 0u16;
    let chars: Vec<char> = pic.chars().collect();
    let mut i = 0;
    while i < chars.len() {
        if chars[i] == 'X' || chars[i] == 'A' || chars[i] == '9' {
            if i + 1 < chars.len() && chars[i + 1] == '(' {
                if let Some(end) = pic[i+2..].find(')') {
                    if let Ok(n) = pic[i+2..i+2+end].parse::<u16>() {
                        count += n;
                        i += 3 + end;
                        continue;
                    }
                }
            }
            count += 1;
        }
        i += 1;
    }
    count
}

// ─── Coercion Verb ───────────────────────────────────────────────────────

/// The COBOL statement that triggered the coercion.
/// Different verbs have different implicit coercion rules.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum CoercionVerb {
    Move,
    Compute,
    Add,
    Subtract,
    Multiply,
    Divide,
    StringConcat,
    Inspect,
    Display,
    Condition,
    Initialize,
    Set,
    Accept,
    Return,
    Call,
}

impl CoercionVerb {
    fn tag(&self) -> &'static str {
        match self {
            CoercionVerb::Move => "MOV",
            CoercionVerb::Compute => "CMP",
            CoercionVerb::Add => "ADD",
            CoercionVerb::Subtract => "SUB",
            CoercionVerb::Multiply => "MUL",
            CoercionVerb::Divide => "DIV",
            CoercionVerb::StringConcat => "STR",
            CoercionVerb::Inspect => "INS",
            CoercionVerb::Display => "DSP",
            CoercionVerb::Condition => "CND",
            CoercionVerb::Initialize => "INI",
            CoercionVerb::Set => "SET",
            CoercionVerb::Accept => "ACC",
            CoercionVerb::Return => "RET",
            CoercionVerb::Call => "CAL",
        }
    }

    /// Parse a tag string back into a CoercionVerb.
    pub fn from_tag(tag: &str) -> Self {
        match tag {
            "MOV" => CoercionVerb::Move,
            "CMP" => CoercionVerb::Compute,
            "ADD" => CoercionVerb::Add,
            "SUB" => CoercionVerb::Subtract,
            "MUL" => CoercionVerb::Multiply,
            "DIV" => CoercionVerb::Divide,
            "STR" => CoercionVerb::StringConcat,
            "INS" => CoercionVerb::Inspect,
            "DSP" => CoercionVerb::Display,
            "CND" => CoercionVerb::Condition,
            "INI" => CoercionVerb::Initialize,
            "SET" => CoercionVerb::Set,
            "ACC" => CoercionVerb::Accept,
            "RET" => CoercionVerb::Return,
            "CAL" => CoercionVerb::Call,
            _ => CoercionVerb::Move,
        }
    }
}

// ─── Coercion Strategy ───────────────────────────────────────────────────

/// Available conversion strategies for coercion decisions.
/// The oracle learns which strategy produces correct output for each pattern.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum CoercionStrategy {
    /// Use the static Coerce trait (default path)
    Direct,
    /// Treat alphanumeric content as numeric (strip spaces, parse)
    NumericReinterpret,
    /// Right-justify, zero-pad (PIC 9 semantics)
    RightJustifyZeroPad,
    /// Left-justify, space-pad (PIC X semantics)
    LeftJustifySpacePad,
    /// Truncate from left (high-order truncation)
    TruncateLeft,
    /// Truncate from right (standard COBOL truncation)
    TruncateRight,
    /// Adjust decimal scale during conversion
    ScaleAdjust,
    /// Zero-fill the target field
    ZeroFill,
    /// Space-fill the target field
    SpaceFill,
    /// Preserve sign through conversion (explicit sign handling)
    SignPreserve,
    /// Group-level byte move (ignore elementary types)
    GroupByteMove,
    /// De-edit numeric (strip edit characters, extract raw value)
    DeEdit,
    /// Formatted numeric display (leading zeros, sign, decimal point)
    FormattedDisplay,
}

impl CoercionStrategy {
    /// Get the compact tag for persistence.
    pub fn to_tag(&self) -> &'static str {
        match self {
            CoercionStrategy::Direct => "DIR",
            CoercionStrategy::NumericReinterpret => "NRI",
            CoercionStrategy::RightJustifyZeroPad => "RJZ",
            CoercionStrategy::LeftJustifySpacePad => "LJS",
            CoercionStrategy::TruncateLeft => "TRL",
            CoercionStrategy::TruncateRight => "TRR",
            CoercionStrategy::ScaleAdjust => "SCA",
            CoercionStrategy::ZeroFill => "ZFL",
            CoercionStrategy::SpaceFill => "SFL",
            CoercionStrategy::SignPreserve => "SGN",
            CoercionStrategy::GroupByteMove => "GBM",
            CoercionStrategy::DeEdit => "DED",
            CoercionStrategy::FormattedDisplay => "FMD",
        }
    }

    /// Parse a tag string back into a CoercionStrategy.
    pub fn from_tag(tag: &str) -> Self {
        match tag {
            "DIR" => CoercionStrategy::Direct,
            "NRI" => CoercionStrategy::NumericReinterpret,
            "RJZ" => CoercionStrategy::RightJustifyZeroPad,
            "LJS" => CoercionStrategy::LeftJustifySpacePad,
            "TRL" => CoercionStrategy::TruncateLeft,
            "TRR" => CoercionStrategy::TruncateRight,
            "SCA" => CoercionStrategy::ScaleAdjust,
            "ZFL" => CoercionStrategy::ZeroFill,
            "SFL" => CoercionStrategy::SpaceFill,
            "SGN" => CoercionStrategy::SignPreserve,
            "GBM" => CoercionStrategy::GroupByteMove,
            "DED" => CoercionStrategy::DeEdit,
            "FMD" => CoercionStrategy::FormattedDisplay,
            _ => CoercionStrategy::Direct,
        }
    }

    /// Get the default strategies to try for a given source→target type pair.
    /// These are the candidate strategies the oracle will score.
    pub fn candidates_for(source: &CoercionType, target: &CoercionType) -> Vec<CoercionStrategy> {
        use CoercionType::*;
        match (source, target) {
            // Alphanumeric → Numeric: might need numeric reinterpret
            (Alphanumeric(_), NumericDisplay(_)) |
            (Alphanumeric(_), SignedDisplay(_)) |
            (Alphanumeric(_), DecimalDisplay(_, _)) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::NumericReinterpret,
                CoercionStrategy::RightJustifyZeroPad,
            ],
            // Numeric → Alphanumeric: justification matters
            (NumericDisplay(_), Alphanumeric(_)) |
            (SignedDisplay(_), Alphanumeric(_)) |
            (DecimalDisplay(_, _), Alphanumeric(_)) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::LeftJustifySpacePad,
                CoercionStrategy::FormattedDisplay,
            ],
            // Numeric → Numeric with different sizes: truncation + padding
            (NumericDisplay(_), NumericDisplay(_)) |
            (SignedDisplay(_), SignedDisplay(_)) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::TruncateLeft,
                CoercionStrategy::RightJustifyZeroPad,
                CoercionStrategy::SignPreserve,
            ],
            // Decimal adjustments
            (DecimalDisplay(_, _), DecimalDisplay(_, _)) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::ScaleAdjust,
                CoercionStrategy::TruncateRight,
            ],
            // Edited → anything: de-edit first
            (EditedNumeric, _) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::DeEdit,
                CoercionStrategy::NumericReinterpret,
            ],
            // Anything → Edited: format
            (_, EditedNumeric) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::FormattedDisplay,
            ],
            // Group moves: byte-level semantics
            (Group(_), _) | (_, Group(_)) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::GroupByteMove,
                CoercionStrategy::LeftJustifySpacePad,
            ],
            // Figurative → anything
            (Figurative, _) => vec![
                CoercionStrategy::Direct,
                CoercionStrategy::ZeroFill,
                CoercionStrategy::SpaceFill,
            ],
            // Default: try Direct first
            _ => vec![
                CoercionStrategy::Direct,
            ],
        }
    }
}

// ─── Coercion Context ────────────────────────────────────────────────────

/// Full context about a coercion event — the oracle uses this to match patterns.
#[derive(Debug, Clone)]
pub struct CoercionContext {
    pub source_type: CoercionType,
    pub target_type: CoercionType,
    pub verb: CoercionVerb,
    /// Original source PIC clause (for exact matching)
    pub source_pic: Option<String>,
    /// Original target PIC clause
    pub target_pic: Option<String>,
    /// Source USAGE clause
    pub source_usage: Option<String>,
    /// Target USAGE clause
    pub target_usage: Option<String>,
    /// Name of the test/program (for feedback correlation)
    pub program_id: Option<String>,
}

impl CoercionContext {
    pub fn new(source: CoercionType, target: CoercionType, verb: CoercionVerb) -> Self {
        Self {
            source_type: source,
            target_type: target,
            verb,
            source_pic: None,
            target_pic: None,
            source_usage: None,
            target_usage: None,
            program_id: None,
        }
    }

    /// Generate the exact pattern key (type + size + verb).
    fn exact_key(&self) -> PatternKey {
        PatternKey {
            source_tag: self.source_type.tag(),
            target_tag: self.target_type.tag(),
            verb_tag: self.verb.tag().to_string(),
        }
    }

    /// Generate a generalized key (type category + verb) for broader matching.
    fn general_key(&self) -> PatternKey {
        PatternKey {
            source_tag: self.source_type.generalized_tag(),
            target_tag: self.target_type.generalized_tag(),
            verb_tag: self.verb.tag().to_string(),
        }
    }

    /// Generate a universal key (type category only, no verb).
    fn universal_key(&self) -> PatternKey {
        PatternKey {
            source_tag: self.source_type.generalized_tag(),
            target_tag: self.target_type.generalized_tag(),
            verb_tag: "*".to_string(),
        }
    }
}

// ─── Pattern Key ─────────────────────────────────────────────────────────

/// Fingerprint that groups similar coercion events together.
/// The oracle stores learned scores indexed by PatternKey.
#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub struct PatternKey {
    source_tag: String,
    target_tag: String,
    verb_tag: String,
}

impl PatternKey {
    /// Serialize to a compact string for file storage.
    fn to_line(&self) -> String {
        format!("{}|{}|{}", self.source_tag, self.target_tag, self.verb_tag)
    }

    /// Deserialize from a compact string.
    fn from_line(s: &str) -> Option<Self> {
        let parts: Vec<&str> = s.split('|').collect();
        if parts.len() >= 3 {
            Some(PatternKey {
                source_tag: parts[0].to_string(),
                target_tag: parts[1].to_string(),
                verb_tag: parts[2].to_string(),
            })
        } else {
            None
        }
    }
}

// ─── Strategy Score ──────────────────────────────────────────────────────

/// Bayesian confidence score for a strategy within a pattern.
/// Updated incrementally as parity test feedback arrives.
#[derive(Debug, Clone)]
pub struct StrategyScore {
    pub strategy: CoercionStrategy,
    /// Confidence: 0.0 = unknown, 1.0 = always correct
    pub confidence: f64,
    /// Total times this strategy was observed for this pattern
    pub observations: u32,
    /// Times this strategy produced correct output
    pub correct: u32,
    /// Times this strategy produced incorrect output
    pub incorrect: u32,
}

impl StrategyScore {
    fn new(strategy: CoercionStrategy) -> Self {
        Self {
            strategy,
            confidence: 0.5, // uninformed prior
            observations: 0,
            correct: 0,
            incorrect: 0,
        }
    }

    /// Bayesian update: incorporate a new observation.
    /// Uses Laplace smoothing to prevent 0/1 lock-in.
    fn update(&mut self, was_correct: bool) {
        self.observations += 1;
        if was_correct {
            self.correct += 1;
        } else {
            self.incorrect += 1;
        }
        // Laplace-smoothed confidence: (correct + 1) / (total + 2)
        self.confidence = (self.correct as f64 + 1.0) / (self.observations as f64 + 2.0);
    }

    /// Apply time decay — reduce confidence toward the prior (0.5).
    fn decay(&mut self, factor: f64) {
        self.confidence = 0.5 + (self.confidence - 0.5) * factor;
    }

    /// Serialize to compact format.
    fn to_line(&self) -> String {
        format!("{}:{}:{}:{}",
            self.strategy.to_tag(), self.observations, self.correct, self.incorrect)
    }

    /// Deserialize from compact format.
    fn from_line(s: &str) -> Option<Self> {
        let parts: Vec<&str> = s.split(':').collect();
        if parts.len() >= 4 {
            let strategy = CoercionStrategy::from_tag(parts[0]);
            let obs = parts[1].parse().ok()?;
            let correct = parts[2].parse().ok()?;
            let incorrect = parts[3].parse().ok()?;
            let confidence = if obs > 0 {
                (correct as f64 + 1.0) / (obs as f64 + 2.0)
            } else {
                0.5
            };
            Some(StrategyScore { strategy, confidence, observations: obs, correct, incorrect })
        } else {
            None
        }
    }
}

// ─── Coercion Outcome ────────────────────────────────────────────────────

/// Result of a coercion (determined by parity test comparison).
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CoercionOutcome {
    /// Produced byte-for-byte matching output
    Correct,
    /// Output differed from GnuCOBOL reference
    Incorrect,
    /// Both produced empty output (inconclusive)
    Inconclusive,
}

// ─── Coercion Record ─────────────────────────────────────────────────────

/// A single coercion event recorded during transpilation.
/// The oracle collects these and correlates them with parity results.
#[derive(Debug, Clone)]
pub struct CoercionRecord {
    pub context: CoercionContext,
    pub strategy: CoercionStrategy,
    pub record_id: u64,
}

// ─── Feedback Summary ────────────────────────────────────────────────────

/// Statistics from a feedback ingestion round.
#[derive(Debug, Clone, Default)]
pub struct FeedbackSummary {
    /// Tests processed
    pub tests_processed: u32,
    /// Patterns updated
    pub patterns_updated: u32,
    /// New patterns discovered
    pub new_patterns: u32,
    /// Confidence increases (strategy got more evidence)
    pub reinforced: u32,
    /// Confidence decreases (strategy was wrong)
    pub corrected: u32,
}

// ─── Oracle Stats ────────────────────────────────────────────────────────

/// Self-report of the oracle's knowledge state.
#[derive(Debug, Clone)]
pub struct OracleStats {
    /// Total distinct patterns known
    pub total_patterns: usize,
    /// Patterns with high confidence (>= 0.8)
    pub high_confidence: usize,
    /// Patterns with medium confidence (0.5-0.8)
    pub medium_confidence: usize,
    /// Patterns with low confidence (< 0.5)
    pub low_confidence: usize,
    /// Total observations across all patterns
    pub total_observations: u64,
    /// Most confident patterns (top 10)
    pub top_patterns: Vec<(String, f64, u32)>,
    /// Weakest patterns (bottom 10, need more data)
    pub weak_patterns: Vec<(String, f64, u32)>,
}

// ─── Oracle Mode ─────────────────────────────────────────────────────────

/// Operating mode determines recording behavior.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum OracleMode {
    /// Record all coercion events, update scores (training loop)
    Training,
    /// Read-only — use learned patterns but don't record
    Production,
    /// Record unknown patterns, use known ones (incremental learning)
    Hybrid,
}

// ═══════════════════════════════════════════════════════════════════════════
// THE ORACLE
// ═══════════════════════════════════════════════════════════════════════════

/// Behavioral Coercion Oracle — learns from parity tests which type conversion
/// strategies produce correct output for each COBOL context pattern.
///
/// # Usage Flow
/// ```text
/// 1. oracle = CoercionOracle::load("oracle.dat")  // Load learned patterns
/// 2. strategy = oracle.recommend(&ctx)              // Get best strategy
/// 3. oracle.record(&ctx, &strategy)                 // Record what we used
/// 4. [run parity tests]
/// 5. oracle.ingest_parity_results(results)          // Learn from outcomes
/// 6. oracle.save("oracle.dat")                      // Persist knowledge
/// 7. [repeat — oracle gets smarter each cycle]
/// ```
pub struct CoercionOracle {
    /// Pattern → strategy scores (the learned knowledge)
    patterns: HashMap<PatternKey, Vec<StrategyScore>>,
    /// Pending records (not yet correlated with outcomes)
    pending: Vec<CoercionRecord>,
    /// Program → records mapping for feedback correlation
    program_records: HashMap<String, Vec<CoercionRecord>>,
    /// Next record ID
    next_id: u64,
    /// Operating mode
    pub mode: OracleMode,
    /// Path for persistence (set on load)
    store_path: Option<PathBuf>,
    /// Built-in heuristic rules (COBOL spec knowledge)
    heuristics_enabled: bool,
}

impl CoercionOracle {
    /// Create a new empty oracle in training mode.
    pub fn new() -> Self {
        let mut oracle = Self {
            patterns: HashMap::new(),
            pending: Vec::new(),
            program_records: HashMap::new(),
            next_id: 0,
            mode: OracleMode::Training,
            store_path: None,
            heuristics_enabled: true,
        };
        oracle.seed_heuristics();
        oracle
    }

    /// Create with a specific mode.
    pub fn with_mode(mode: OracleMode) -> Self {
        let mut oracle = Self::new();
        oracle.mode = mode;
        oracle
    }

    /// Seed the oracle with known COBOL coercion rules.
    /// These are the "instincts" — spec-defined behaviors that don't need learning.
    fn seed_heuristics(&mut self) {
        // MOVE numeric → numeric: right-justify, zero-pad, truncate left
        self.seed_pattern("N_sm", "N_md", "MOV", CoercionStrategy::RightJustifyZeroPad, 0.9);
        self.seed_pattern("N_md", "N_sm", "MOV", CoercionStrategy::TruncateLeft, 0.85);
        self.seed_pattern("N_lg", "N_sm", "MOV", CoercionStrategy::TruncateLeft, 0.85);

        // MOVE alphanumeric → alphanumeric: left-justify, space-pad, truncate right
        self.seed_pattern("X_sm", "X_md", "MOV", CoercionStrategy::LeftJustifySpacePad, 0.9);
        self.seed_pattern("X_md", "X_sm", "MOV", CoercionStrategy::TruncateRight, 0.85);
        self.seed_pattern("X_lg", "X_sm", "MOV", CoercionStrategy::TruncateRight, 0.85);

        // MOVE alphanumeric → numeric: numeric reinterpret
        self.seed_pattern("X_sm", "N_sm", "MOV", CoercionStrategy::NumericReinterpret, 0.8);
        self.seed_pattern("X_md", "N_md", "MOV", CoercionStrategy::NumericReinterpret, 0.8);

        // MOVE numeric → alphanumeric: left-justify space-pad
        self.seed_pattern("N_sm", "X_sm", "MOV", CoercionStrategy::LeftJustifySpacePad, 0.8);
        self.seed_pattern("N_md", "X_md", "MOV", CoercionStrategy::LeftJustifySpacePad, 0.8);

        // MOVE decimal → decimal: scale adjust
        self.seed_pattern("DEC", "DEC", "MOV", CoercionStrategy::ScaleAdjust, 0.85);

        // MOVE figurative → numeric: zero fill
        self.seed_pattern("FIG", "N_sm", "MOV", CoercionStrategy::ZeroFill, 0.95);
        self.seed_pattern("FIG", "N_md", "MOV", CoercionStrategy::ZeroFill, 0.95);
        self.seed_pattern("FIG", "N_lg", "MOV", CoercionStrategy::ZeroFill, 0.95);

        // MOVE figurative → alphanumeric: space fill
        self.seed_pattern("FIG", "X_sm", "MOV", CoercionStrategy::SpaceFill, 0.95);
        self.seed_pattern("FIG", "X_md", "MOV", CoercionStrategy::SpaceFill, 0.95);

        // DISPLAY: formatted display for numeric types
        self.seed_pattern("N_sm", "X_sm", "DSP", CoercionStrategy::FormattedDisplay, 0.85);
        self.seed_pattern("N_md", "X_md", "DSP", CoercionStrategy::FormattedDisplay, 0.85);
        self.seed_pattern("DEC", "X_md", "DSP", CoercionStrategy::FormattedDisplay, 0.85);

        // Group moves: byte-level semantics
        self.seed_pattern("G0", "X_md", "MOV", CoercionStrategy::GroupByteMove, 0.8);
        self.seed_pattern("G0", "G0", "MOV", CoercionStrategy::GroupByteMove, 0.9);

        // Signed types: sign preservation
        self.seed_pattern("SN_sm", "SN_md", "MOV", CoercionStrategy::SignPreserve, 0.85);
        self.seed_pattern("SN_md", "SN_sm", "MOV", CoercionStrategy::SignPreserve, 0.85);
        self.seed_pattern("SN_sm", "N_sm", "MOV", CoercionStrategy::SignPreserve, 0.7);

        // Edited → numeric: de-edit
        self.seed_pattern("EN", "N_md", "MOV", CoercionStrategy::DeEdit, 0.8);
        self.seed_pattern("EN", "DEC", "MOV", CoercionStrategy::DeEdit, 0.8);

        // Packed ↔ display: direct coercion works well
        self.seed_pattern("PACK", "N_md", "MOV", CoercionStrategy::Direct, 0.85);
        self.seed_pattern("N_md", "PACK", "MOV", CoercionStrategy::Direct, 0.85);

        // COMPUTE always uses direct (arithmetic result)
        self.seed_pattern("*", "*", "CMP", CoercionStrategy::Direct, 0.9);
    }

    /// Helper to seed a single heuristic pattern.
    fn seed_pattern(&mut self, src: &str, tgt: &str, verb: &str,
                    strategy: CoercionStrategy, confidence: f64) {
        let key = PatternKey {
            source_tag: src.to_string(),
            target_tag: tgt.to_string(),
            verb_tag: verb.to_string(),
        };
        let score = StrategyScore {
            strategy,
            confidence,
            observations: 1, // pseudo-count to anchor the prior
            correct: 1,
            incorrect: 0,
        };
        self.patterns.entry(key).or_default().push(score);
    }

    // ─── Recording ───────────────────────────────────────────────────────

    /// Record a coercion event during transpilation.
    /// The oracle stores this and correlates it with parity results later.
    pub fn record(&mut self, ctx: &CoercionContext, strategy: &CoercionStrategy) {
        if self.mode == OracleMode::Production {
            return;
        }

        let record = CoercionRecord {
            context: ctx.clone(),
            strategy: strategy.clone(),
            record_id: self.next_id,
        };
        self.next_id += 1;

        if let Some(ref prog) = ctx.program_id {
            self.program_records
                .entry(prog.clone())
                .or_default()
                .push(record.clone());
        }
        self.pending.push(record);
    }

    // ─── Recommendation ──────────────────────────────────────────────────

    /// Get the best strategy for a given context.
    /// Searches exact match → generalized → universal → heuristic fallback.
    pub fn recommend(&self, ctx: &CoercionContext) -> CoercionStrategy {
        // Level 1: exact pattern match
        if let Some(scores) = self.patterns.get(&ctx.exact_key()) {
            if let Some(best) = best_strategy(scores) {
                return best;
            }
        }

        // Level 2: generalized match (size category)
        if let Some(scores) = self.patterns.get(&ctx.general_key()) {
            if let Some(best) = best_strategy(scores) {
                return best;
            }
        }

        // Level 3: universal match (type category, any verb)
        if let Some(scores) = self.patterns.get(&ctx.universal_key()) {
            if let Some(best) = best_strategy(scores) {
                return best;
            }
        }

        // Level 4: wildcard COMPUTE rule
        let compute_key = PatternKey {
            source_tag: "*".to_string(),
            target_tag: "*".to_string(),
            verb_tag: ctx.verb.tag().to_string(),
        };
        if let Some(scores) = self.patterns.get(&compute_key) {
            if let Some(best) = best_strategy(scores) {
                return best;
            }
        }

        // Level 5: heuristic based on type pair
        if self.heuristics_enabled {
            return self.heuristic_recommend(ctx);
        }

        CoercionStrategy::Direct
    }

    /// Get the confidence score for a context's recommended strategy.
    pub fn confidence(&self, ctx: &CoercionContext) -> f64 {
        for key_fn in [
            CoercionContext::exact_key,
            CoercionContext::general_key,
            CoercionContext::universal_key,
        ] {
            let key = key_fn(ctx);
            if let Some(scores) = self.patterns.get(&key) {
                if let Some(best) = scores.iter().max_by(|a, b| {
                    a.confidence.partial_cmp(&b.confidence).unwrap_or(std::cmp::Ordering::Equal)
                }) {
                    return best.confidence;
                }
            }
        }
        0.5 // uninformed prior
    }

    /// Get all scored strategies for a context (for debugging/inspection).
    pub fn all_strategies(&self, ctx: &CoercionContext) -> Vec<(CoercionStrategy, f64, u32)> {
        let mut result = Vec::new();
        for key_fn in [
            CoercionContext::exact_key,
            CoercionContext::general_key,
            CoercionContext::universal_key,
        ] {
            let key = key_fn(ctx);
            if let Some(scores) = self.patterns.get(&key) {
                for s in scores {
                    result.push((s.strategy.clone(), s.confidence, s.observations));
                }
                if !result.is_empty() {
                    break; // Use the most specific level that has data
                }
            }
        }
        result.sort_by(|a, b| b.1.partial_cmp(&a.1).unwrap_or(std::cmp::Ordering::Equal));
        result
    }

    /// Heuristic fallback based on COBOL specification rules.
    fn heuristic_recommend(&self, ctx: &CoercionContext) -> CoercionStrategy {
        use CoercionType::*;
        match (&ctx.source_type, &ctx.target_type) {
            // Alphanumeric → Numeric: reinterpret
            (Alphanumeric(_), NumericDisplay(_)) |
            (Alphanumeric(_), SignedDisplay(_)) |
            (Alphanumeric(_), DecimalDisplay(_, _)) |
            (Alphanumeric(_), Binary(_)) |
            (Alphanumeric(_), Packed(_)) => CoercionStrategy::NumericReinterpret,

            // Numeric → Alphanumeric: left-justify, space-pad
            (NumericDisplay(_), Alphanumeric(_)) |
            (SignedDisplay(_), Alphanumeric(_)) |
            (Binary(_), Alphanumeric(_)) |
            (Packed(_), Alphanumeric(_)) => CoercionStrategy::LeftJustifySpacePad,

            // Decimal → Decimal: scale adjust
            (DecimalDisplay(_, _), DecimalDisplay(_, _)) => CoercionStrategy::ScaleAdjust,

            // Group → anything: byte move
            (Group(_), _) => CoercionStrategy::GroupByteMove,

            // Figurative → numeric: zero fill
            (Figurative, NumericDisplay(_)) |
            (Figurative, SignedDisplay(_)) |
            (Figurative, Binary(_)) |
            (Figurative, Packed(_)) => CoercionStrategy::ZeroFill,

            // Figurative → alphanumeric: space fill
            (Figurative, Alphanumeric(_)) |
            (Figurative, Alphabetic(_)) => CoercionStrategy::SpaceFill,

            // Edited → anything: de-edit
            (EditedNumeric, _) => CoercionStrategy::DeEdit,

            _ => CoercionStrategy::Direct,
        }
    }

    // ─── Feedback Ingestion ──────────────────────────────────────────────

    /// Ingest feedback for a single test — updates strategy scores.
    pub fn ingest_feedback(&mut self, test_name: &str, outcome: CoercionOutcome) {
        if outcome == CoercionOutcome::Inconclusive {
            return;
        }

        let was_correct = outcome == CoercionOutcome::Correct;

        // Find all records for this test and update their pattern scores
        if let Some(records) = self.program_records.get(test_name).cloned() {
            for record in &records {
                let keys = vec![
                    record.context.exact_key(),
                    record.context.general_key(),
                    record.context.universal_key(),
                ];
                for key in keys {
                    let scores = self.patterns.entry(key).or_default();
                    // Find or create score for this strategy
                    let existing = scores.iter_mut()
                        .find(|s| s.strategy == record.strategy);
                    if let Some(score) = existing {
                        score.update(was_correct);
                    } else {
                        let mut score = StrategyScore::new(record.strategy.clone());
                        score.update(was_correct);
                        scores.push(score);
                    }
                }
            }
        }
    }

    /// Batch ingest from parity test JSON results.
    /// Expected format: `[{"name": "test_name", "status": "MATCH|MISMATCH|..."}]`
    pub fn ingest_parity_json(&mut self, json: &str) -> FeedbackSummary {
        let mut summary = FeedbackSummary::default();

        // Simple JSON array parser (no serde dependency)
        let entries = parse_parity_entries(json);
        for (name, status) in &entries {
            let outcome = match status.as_str() {
                "MATCH" => CoercionOutcome::Correct,
                "MISMATCH" | "RUST_BUILD_FAIL" => CoercionOutcome::Incorrect,
                _ => CoercionOutcome::Inconclusive,
            };
            if outcome == CoercionOutcome::Inconclusive {
                continue;
            }

            let pattern_count_before = self.patterns.len();
            self.ingest_feedback(name, outcome.clone());
            let pattern_count_after = self.patterns.len();

            summary.tests_processed += 1;
            if pattern_count_after > pattern_count_before {
                summary.new_patterns += (pattern_count_after - pattern_count_before) as u32;
            }
            summary.patterns_updated += 1;
            if outcome == CoercionOutcome::Correct {
                summary.reinforced += 1;
            } else {
                summary.corrected += 1;
            }
        }

        summary
    }

    // ─── Time Decay ──────────────────────────────────────────────────────

    /// Apply time decay to all patterns.
    /// `factor` should be between 0 and 1 (e.g., 0.95 = 5% decay per cycle).
    /// This prevents stale patterns from dominating when the transpiler changes.
    pub fn decay(&mut self, factor: f64) {
        let factor = factor.clamp(0.0, 1.0);
        for scores in self.patterns.values_mut() {
            for score in scores.iter_mut() {
                score.decay(factor);
            }
        }
    }

    // ─── Statistics ──────────────────────────────────────────────────────

    /// Get comprehensive stats about the oracle's knowledge state.
    pub fn stats(&self) -> OracleStats {
        let mut total_observations: u64 = 0;
        let mut high = 0;
        let mut medium = 0;
        let mut low = 0;
        let mut all_patterns: Vec<(String, f64, u32)> = Vec::new();

        for (key, scores) in &self.patterns {
            if let Some(best) = scores.iter().max_by(|a, b| {
                a.confidence.partial_cmp(&b.confidence).unwrap_or(std::cmp::Ordering::Equal)
            }) {
                let total_obs: u32 = scores.iter().map(|s| s.observations).sum();
                total_observations += total_obs as u64;

                if best.confidence >= 0.8 { high += 1; }
                else if best.confidence >= 0.5 { medium += 1; }
                else { low += 1; }

                all_patterns.push((key.to_line(), best.confidence, total_obs));
            }
        }

        all_patterns.sort_by(|a, b| b.1.partial_cmp(&a.1).unwrap_or(std::cmp::Ordering::Equal));

        let top = all_patterns.iter().take(10).cloned().collect();
        let weak = all_patterns.iter().rev().take(10).cloned().collect();

        OracleStats {
            total_patterns: self.patterns.len(),
            high_confidence: high,
            medium_confidence: medium,
            low_confidence: low,
            total_observations,
            top_patterns: top,
            weak_patterns: weak,
        }
    }

    /// Get the number of pending (unprocessed) records.
    pub fn pending_count(&self) -> usize {
        self.pending.len()
    }

    /// Clear pending records after feedback ingestion.
    pub fn clear_pending(&mut self) {
        self.pending.clear();
        self.program_records.clear();
    }

    // ─── Persistence ─────────────────────────────────────────────────────

    /// Save learned patterns to a file.
    /// Format: one line per pattern, pipe-separated.
    /// `KEY|STRATEGY_SCORES`
    /// where KEY = `source|target|verb`
    /// and STRATEGY_SCORES = comma-separated `tag:obs:correct:incorrect`
    pub fn save(&self, path: &Path) -> Result<(), String> {
        let mut lines = Vec::new();
        lines.push("# Ironclad Coercion Oracle — Learned Patterns".to_string());
        lines.push(format!("# Patterns: {} | Mode: {:?}", self.patterns.len(), self.mode));
        lines.push(format!("# next_id: {}", self.next_id));

        for (key, scores) in &self.patterns {
            let score_parts: Vec<String> = scores.iter().map(|s| s.to_line()).collect();
            lines.push(format!("P|{}|{}", key.to_line(), score_parts.join(",")));
        }

        // Persist program records so feedback can correlate across invocations
        for (prog_id, records) in &self.program_records {
            for record in records {
                let ek = record.context.exact_key();
                lines.push(format!("R|{}|{}|{}|{}|{}",
                    prog_id, ek.source_tag, ek.target_tag, ek.verb_tag,
                    record.strategy.to_tag()));
            }
        }

        let content = lines.join("\n");
        std::fs::write(path, content).map_err(|e| format!("save failed: {}", e))
    }

    /// Load learned patterns from a file.
    pub fn load(path: &Path) -> Result<Self, String> {
        let content = std::fs::read_to_string(path)
            .map_err(|e| format!("load failed: {}", e))?;

        let mut oracle = Self {
            patterns: HashMap::new(),
            pending: Vec::new(),
            program_records: HashMap::new(),
            next_id: 0,
            mode: OracleMode::Hybrid,
            store_path: Some(path.to_path_buf()),
            heuristics_enabled: true,
        };

        for line in content.lines() {
            let line = line.trim();
            if line.starts_with('#') || line.is_empty() {
                if line.starts_with("# next_id: ") {
                    if let Ok(id) = line["# next_id: ".len()..].parse::<u64>() {
                        oracle.next_id = id;
                    }
                }
                continue;
            }
            if line.starts_with("P|") {
                let rest = &line[2..];
                // Parse: source|target|verb|strategy_scores
                let parts: Vec<&str> = rest.splitn(4, '|').collect();
                if parts.len() >= 4 {
                    let key = PatternKey {
                        source_tag: parts[0].to_string(),
                        target_tag: parts[1].to_string(),
                        verb_tag: parts[2].to_string(),
                    };
                    let scores: Vec<StrategyScore> = parts[3]
                        .split(',')
                        .filter_map(StrategyScore::from_line)
                        .collect();
                    if !scores.is_empty() {
                        oracle.patterns.insert(key, scores);
                    }
                }
            } else if line.starts_with("R|") {
                // Parse program record: R|prog_id|src_tag|dst_tag|verb_tag|strategy_tag
                let rest = &line[2..];
                let parts: Vec<&str> = rest.splitn(5, '|').collect();
                if parts.len() >= 5 {
                    let prog_id = parts[0].to_string();
                    let src_ct = CoercionType::from_tag(parts[1]);
                    let dst_ct = CoercionType::from_tag(parts[2]);
                    let verb = CoercionVerb::from_tag(parts[3]);
                    let strategy = CoercionStrategy::from_tag(parts[4]);
                    let mut ctx = CoercionContext::new(src_ct, dst_ct, verb);
                    ctx.program_id = Some(prog_id.clone());
                    let record = CoercionRecord {
                        context: ctx,
                        strategy,
                        record_id: oracle.next_id,
                    };
                    oracle.next_id += 1;
                    oracle.program_records
                        .entry(prog_id)
                        .or_default()
                        .push(record);
                }
            }
        }

        // Seed heuristics for any patterns not already loaded
        let mut heuristic_oracle = CoercionOracle::new();
        for (key, scores) in heuristic_oracle.patterns.drain() {
            oracle.patterns.entry(key).or_insert(scores);
        }

        Ok(oracle)
    }

    /// Load from path, or create fresh if file doesn't exist.
    pub fn load_or_new(path: &Path) -> Self {
        if path.exists() {
            Self::load(path).unwrap_or_else(|_| {
                let mut oracle = Self::new();
                oracle.store_path = Some(path.to_path_buf());
                oracle
            })
        } else {
            let mut oracle = Self::new();
            oracle.store_path = Some(path.to_path_buf());
            oracle
        }
    }

    /// Save to the path set during load (convenience method).
    pub fn save_default(&self) -> Result<(), String> {
        if let Some(ref path) = self.store_path {
            self.save(path)
        } else {
            Err("no store path set".to_string())
        }
    }

    // ─── Inspection / Debugging ──────────────────────────────────────────

    /// Export all patterns as human-readable reports.
    pub fn export_patterns(&self) -> Vec<PatternReport> {
        let mut reports = Vec::new();
        for (key, scores) in &self.patterns {
            let mut strategies = Vec::new();
            for s in scores {
                strategies.push(StrategyReport {
                    strategy: format!("{:?}", s.strategy),
                    confidence: s.confidence,
                    observations: s.observations,
                    correct: s.correct,
                    incorrect: s.incorrect,
                });
            }
            strategies.sort_by(|a, b| b.confidence.partial_cmp(&a.confidence).unwrap_or(std::cmp::Ordering::Equal));
            reports.push(PatternReport {
                pattern: key.to_line(),
                strategies,
            });
        }
        reports.sort_by(|a, b| a.pattern.cmp(&b.pattern));
        reports
    }
}

/// Select the highest-confidence strategy from a list.
/// Requires confidence > 0.5 (better than random) and at least 1 observation.
fn best_strategy(scores: &[StrategyScore]) -> Option<CoercionStrategy> {
    scores.iter()
        .filter(|s| s.confidence > 0.5)
        .max_by(|a, b| {
            a.confidence.partial_cmp(&b.confidence).unwrap_or(std::cmp::Ordering::Equal)
        })
        .map(|s| s.strategy.clone())
}

// ─── Pattern Report ──────────────────────────────────────────────────────

/// Human-readable pattern report for inspection.
#[derive(Debug, Clone)]
pub struct PatternReport {
    pub pattern: String,
    pub strategies: Vec<StrategyReport>,
}

/// Human-readable strategy report.
#[derive(Debug, Clone)]
pub struct StrategyReport {
    pub strategy: String,
    pub confidence: f64,
    pub observations: u32,
    pub correct: u32,
    pub incorrect: u32,
}

// ─── Minimal JSON Parser ─────────────────────────────────────────────────
// (Zero-dependency — extracts name + status from parity_results.json)

fn parse_parity_entries(json: &str) -> Vec<(String, String)> {
    let mut entries = Vec::new();
    // Find all {"name": "...", "status": "..."} objects
    let mut pos = 0;
    let bytes = json.as_bytes();
    while pos < bytes.len() {
        // Find next "name"
        if let Some(name_start) = find_json_key(json, pos, "name") {
            if let Some((name_val, after_name)) = extract_json_string(json, name_start) {
                // Find "status" after name
                if let Some(status_start) = find_json_key(json, after_name, "status") {
                    if let Some((status_val, after_status)) = extract_json_string(json, status_start) {
                        entries.push((name_val, status_val));
                        pos = after_status;
                        continue;
                    }
                }
                pos = after_name;
                continue;
            }
        }
        break;
    }
    entries
}

fn find_json_key(json: &str, start: usize, key: &str) -> Option<usize> {
    let search = format!("\"{}\"", key);
    json[start..].find(&search).map(|i| {
        let after_key = start + i + search.len();
        // Skip whitespace and colon
        let rest = &json[after_key..];
        let trimmed = rest.trim_start();
        let skip = rest.len() - trimmed.len();
        if trimmed.starts_with(':') {
            after_key + skip + 1
        } else {
            after_key + skip
        }
    })
}

fn extract_json_string(json: &str, start: usize) -> Option<(String, usize)> {
    let bytes = json.as_bytes();
    // Skip whitespace
    let mut pos = start;
    while pos < bytes.len() && bytes[pos].is_ascii_whitespace() {
        pos += 1;
    }
    if pos >= bytes.len() || bytes[pos] != b'"' {
        return None;
    }
    pos += 1; // skip opening quote
    let value_start = pos;
    let mut escaped = false;
    while pos < bytes.len() {
        if escaped {
            escaped = false;
            pos += 1;
            continue;
        }
        if bytes[pos] == b'\\' {
            escaped = true;
            pos += 1;
            continue;
        }
        if bytes[pos] == b'"' {
            let value = json[value_start..pos].to_string();
            return Some((value, pos + 1));
        }
        pos += 1;
    }
    None
}

// ─── Display impls ───────────────────────────────────────────────────────

impl std::fmt::Display for OracleStats {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        writeln!(f, "=== Coercion Oracle Stats ===")?;
        writeln!(f, "Patterns: {} total", self.total_patterns)?;
        writeln!(f, "  High confidence (>=0.8): {}", self.high_confidence)?;
        writeln!(f, "  Medium (0.5-0.8):        {}", self.medium_confidence)?;
        writeln!(f, "  Low (<0.5):              {}", self.low_confidence)?;
        writeln!(f, "Total observations: {}", self.total_observations)?;
        if !self.top_patterns.is_empty() {
            writeln!(f, "\nTop patterns:")?;
            for (p, c, o) in &self.top_patterns {
                writeln!(f, "  {:.2} ({} obs) — {}", c, o, p)?;
            }
        }
        if !self.weak_patterns.is_empty() {
            writeln!(f, "\nWeakest patterns (need more data):")?;
            for (p, c, o) in &self.weak_patterns {
                writeln!(f, "  {:.2} ({} obs) — {}", c, o, p)?;
            }
        }
        Ok(())
    }
}

impl std::fmt::Display for FeedbackSummary {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        writeln!(f, "=== Feedback Summary ===")?;
        writeln!(f, "Tests processed: {}", self.tests_processed)?;
        writeln!(f, "Patterns updated: {}", self.patterns_updated)?;
        writeln!(f, "New patterns: {}", self.new_patterns)?;
        writeln!(f, "Reinforced (correct): {}", self.reinforced)?;
        writeln!(f, "Corrected (wrong): {}", self.corrected)?;
        Ok(())
    }
}

// ═══════════════════════════════════════════════════════════════════════════
// TESTS
// ═══════════════════════════════════════════════════════════════════════════

#[cfg(test)]
mod tests {
    use super::*;

    // ── PIC Parsing ──

    #[test]
    fn pic_numeric_display() {
        let t = CoercionType::from_pic("9(5)", None);
        assert_eq!(t, CoercionType::NumericDisplay(5));
    }

    #[test]
    fn pic_signed_display() {
        let t = CoercionType::from_pic("S9(7)", None);
        assert_eq!(t, CoercionType::SignedDisplay(7));
    }

    #[test]
    fn pic_decimal() {
        let t = CoercionType::from_pic("9(5)V99", None);
        assert_eq!(t, CoercionType::DecimalDisplay(5, 2));
    }

    #[test]
    fn pic_alphanumeric() {
        let t = CoercionType::from_pic("X(20)", None);
        assert_eq!(t, CoercionType::Alphanumeric(20));
    }

    #[test]
    fn pic_comp3() {
        let t = CoercionType::from_pic("S9(7)V99", Some("COMP-3"));
        assert_eq!(t, CoercionType::Packed(9));
    }

    #[test]
    fn pic_binary() {
        let t = CoercionType::from_pic("9(4)", Some("COMP"));
        assert_eq!(t, CoercionType::Binary(4));
    }

    #[test]
    fn pic_edited() {
        let t = CoercionType::from_pic("Z(5)9.99", None);
        assert_eq!(t, CoercionType::EditedNumeric);
    }

    #[test]
    fn pic_float() {
        let t = CoercionType::from_pic("", Some("COMP-1"));
        assert_eq!(t, CoercionType::Float32);
        let t = CoercionType::from_pic("", Some("COMP-2"));
        assert_eq!(t, CoercionType::Float64);
    }

    // ── Oracle Creation ──

    #[test]
    fn oracle_new_has_heuristics() {
        let oracle = CoercionOracle::new();
        assert!(oracle.patterns.len() > 10, "should have seeded heuristic patterns");
    }

    #[test]
    fn oracle_recommend_numeric_to_alpha() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::LeftJustifySpacePad);
    }

    #[test]
    fn oracle_recommend_alpha_to_numeric() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::Alphanumeric(5),
            CoercionType::NumericDisplay(5),
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::NumericReinterpret);
    }

    #[test]
    fn oracle_recommend_figurative_to_numeric() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::Figurative,
            CoercionType::NumericDisplay(5),
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::ZeroFill);
    }

    #[test]
    fn oracle_recommend_figurative_to_alpha() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::Figurative,
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::SpaceFill);
    }

    #[test]
    fn oracle_recommend_decimal_to_decimal() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::DecimalDisplay(5, 2),
            CoercionType::DecimalDisplay(7, 4),
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::ScaleAdjust);
    }

    #[test]
    fn oracle_recommend_compute_uses_direct() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::DecimalDisplay(5, 2),
            CoercionVerb::Compute,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::Direct);
    }

    // ── Recording + Feedback ──

    #[test]
    fn oracle_record_and_feedback() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::Alphanumeric(10),
            CoercionType::NumericDisplay(5),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("test_001".into());

        oracle.record(&ctx, &CoercionStrategy::NumericReinterpret);
        oracle.ingest_feedback("test_001", CoercionOutcome::Correct);

        // The numeric reinterpret strategy should now have higher confidence
        let scores = oracle.patterns.get(&ctx.exact_key());
        assert!(scores.is_some());
        let nri = scores.unwrap().iter()
            .find(|s| s.strategy == CoercionStrategy::NumericReinterpret);
        assert!(nri.is_some());
        assert!(nri.unwrap().confidence > 0.5);
        assert_eq!(nri.unwrap().correct, 1);
    }

    #[test]
    fn oracle_feedback_incorrect_lowers_confidence() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::Alphanumeric(10),
            CoercionType::NumericDisplay(5),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("test_bad".into());

        oracle.record(&ctx, &CoercionStrategy::Direct);
        oracle.ingest_feedback("test_bad", CoercionOutcome::Incorrect);

        let scores = oracle.patterns.get(&ctx.exact_key()).unwrap();
        let direct = scores.iter()
            .find(|s| s.strategy == CoercionStrategy::Direct)
            .unwrap();
        assert!(direct.confidence < 0.5, "incorrect feedback should lower confidence below 0.5");
        assert_eq!(direct.incorrect, 1);
    }

    #[test]
    fn oracle_repeated_correct_raises_confidence() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("test_repeat".into());

        for i in 0..10 {
            ctx.program_id = Some(format!("test_repeat_{}", i));
            oracle.record(&ctx, &CoercionStrategy::LeftJustifySpacePad);
            oracle.ingest_feedback(&format!("test_repeat_{}", i), CoercionOutcome::Correct);
        }

        let confidence = oracle.confidence(&ctx);
        assert!(confidence > 0.85, "10 correct observations should push confidence above 0.85, got {}", confidence);
    }

    // ── Bayesian Update ──

    #[test]
    fn strategy_score_laplace_smoothing() {
        let mut score = StrategyScore::new(CoercionStrategy::Direct);
        assert!((score.confidence - 0.5).abs() < 0.01, "initial prior should be 0.5");

        score.update(true);
        // (1+1)/(1+2) = 0.667
        assert!((score.confidence - 0.667).abs() < 0.01);

        score.update(true);
        // (2+1)/(2+2) = 0.75
        assert!((score.confidence - 0.75).abs() < 0.01);

        score.update(false);
        // (2+1)/(3+2) = 0.6
        assert!((score.confidence - 0.6).abs() < 0.01);
    }

    #[test]
    fn strategy_score_converges() {
        let mut score = StrategyScore::new(CoercionStrategy::Direct);
        // 100 correct observations
        for _ in 0..100 {
            score.update(true);
        }
        // (100+1)/(100+2) ≈ 0.99
        assert!(score.confidence > 0.98, "should converge near 1.0 with all-correct");
    }

    #[test]
    fn strategy_score_converges_low() {
        let mut score = StrategyScore::new(CoercionStrategy::Direct);
        // 100 incorrect observations
        for _ in 0..100 {
            score.update(false);
        }
        // (0+1)/(100+2) ≈ 0.01
        assert!(score.confidence < 0.02, "should converge near 0.0 with all-incorrect");
    }

    // ── Time Decay ──

    #[test]
    fn decay_moves_toward_prior() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("decay_test".into());

        oracle.record(&ctx, &CoercionStrategy::LeftJustifySpacePad);
        oracle.ingest_feedback("decay_test", CoercionOutcome::Correct);

        let before = oracle.confidence(&ctx);
        oracle.decay(0.5); // aggressive 50% decay
        let after = oracle.confidence(&ctx);

        // After decay, confidence should be closer to 0.5
        assert!((after - 0.5).abs() < (before - 0.5).abs(),
            "decay should move confidence toward 0.5 prior");
    }

    // ── Persistence ──

    #[test]
    fn save_and_load_roundtrip() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::Alphanumeric(10),
            CoercionType::NumericDisplay(5),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("persist_test".into());

        oracle.record(&ctx, &CoercionStrategy::NumericReinterpret);
        oracle.ingest_feedback("persist_test", CoercionOutcome::Correct);

        let confidence_before = oracle.confidence(&ctx);

        // Save to temp file
        let tmp = std::env::temp_dir().join("ironclad_oracle_test.dat");
        oracle.save(&tmp).unwrap();

        // Load from temp file
        let loaded = CoercionOracle::load(&tmp).unwrap();
        let confidence_after = loaded.confidence(&ctx);

        // Cleanup
        let _ = std::fs::remove_file(&tmp);

        assert!((confidence_before - confidence_after).abs() < 0.1,
            "confidence should survive save/load roundtrip");
    }

    // ── Generalized Matching ──

    #[test]
    fn generalized_key_transfers_knowledge() {
        let mut oracle = CoercionOracle::new();

        // Train on PIC 9(3) → PIC X(5)
        let mut ctx3 = CoercionContext::new(
            CoercionType::NumericDisplay(3),
            CoercionType::Alphanumeric(5),
            CoercionVerb::Move,
        );
        ctx3.program_id = Some("gen_test".into());
        oracle.record(&ctx3, &CoercionStrategy::LeftJustifySpacePad);
        oracle.ingest_feedback("gen_test", CoercionOutcome::Correct);

        // Query with PIC 9(4) → PIC X(8) (different sizes, same category)
        let ctx4 = CoercionContext::new(
            CoercionType::NumericDisplay(4),
            CoercionType::Alphanumeric(8),
            CoercionVerb::Move,
        );

        // Should still recommend LeftJustifySpacePad via generalized match
        let strategy = oracle.recommend(&ctx4);
        assert_eq!(strategy, CoercionStrategy::LeftJustifySpacePad);
    }

    // ── JSON Parsing ──

    #[test]
    fn parse_parity_json_basic() {
        let json = r#"[
            {"name": "run_fundamental_001", "status": "MATCH", "cobol_output": "", "rust_output": ""},
            {"name": "run_fundamental_002", "status": "MISMATCH", "cobol_output": "foo", "rust_output": "bar"}
        ]"#;

        let entries = parse_parity_entries(json);
        assert_eq!(entries.len(), 2);
        assert_eq!(entries[0].0, "run_fundamental_001");
        assert_eq!(entries[0].1, "MATCH");
        assert_eq!(entries[1].0, "run_fundamental_002");
        assert_eq!(entries[1].1, "MISMATCH");
    }

    #[test]
    fn parse_parity_json_empty() {
        let entries = parse_parity_entries("[]");
        assert!(entries.is_empty());
    }

    #[test]
    fn ingest_parity_json_full() {
        let mut oracle = CoercionOracle::new();

        // Record some coercion events
        let mut ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("run_fundamental_001".into());
        oracle.record(&ctx, &CoercionStrategy::LeftJustifySpacePad);

        ctx.program_id = Some("run_fundamental_002".into());
        oracle.record(&ctx, &CoercionStrategy::Direct);

        // Ingest parity results
        let json = r#"[
            {"name": "run_fundamental_001", "status": "MATCH"},
            {"name": "run_fundamental_002", "status": "MISMATCH"}
        ]"#;

        let summary = oracle.ingest_parity_json(json);
        assert_eq!(summary.tests_processed, 2);
        assert_eq!(summary.reinforced, 1);
        assert_eq!(summary.corrected, 1);
    }

    // ── Stats ──

    #[test]
    fn oracle_stats_report() {
        let oracle = CoercionOracle::new();
        let stats = oracle.stats();
        assert!(stats.total_patterns > 0);
        assert!(stats.total_observations > 0);
        // Just verify it doesn't panic and produces readable output
        let display = format!("{}", stats);
        assert!(display.contains("Coercion Oracle Stats"));
    }

    // ── Strategy Candidates ──

    #[test]
    fn candidates_alpha_to_numeric() {
        let candidates = CoercionStrategy::candidates_for(
            &CoercionType::Alphanumeric(10),
            &CoercionType::NumericDisplay(5),
        );
        assert!(candidates.contains(&CoercionStrategy::NumericReinterpret));
        assert!(candidates.contains(&CoercionStrategy::Direct));
    }

    #[test]
    fn candidates_group_move() {
        let candidates = CoercionStrategy::candidates_for(
            &CoercionType::Group(80),
            &CoercionType::Alphanumeric(80),
        );
        assert!(candidates.contains(&CoercionStrategy::GroupByteMove));
    }

    // ── All Strategies Inspection ──

    #[test]
    fn all_strategies_returns_sorted() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::NumericDisplay(3),
            CoercionType::NumericDisplay(7),
            CoercionVerb::Move,
        );
        let strategies = oracle.all_strategies(&ctx);
        // Should be sorted by confidence descending
        for window in strategies.windows(2) {
            assert!(window[0].1 >= window[1].1, "should be sorted by confidence desc");
        }
    }

    // ── Pattern Report ──

    #[test]
    fn export_patterns_not_empty() {
        let oracle = CoercionOracle::new();
        let reports = oracle.export_patterns();
        assert!(!reports.is_empty());
        for report in &reports {
            assert!(!report.pattern.is_empty());
            assert!(!report.strategies.is_empty());
        }
    }

    // ── Edge Cases ──

    #[test]
    fn production_mode_does_not_record() {
        let mut oracle = CoercionOracle::with_mode(OracleMode::Production);
        let ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        oracle.record(&ctx, &CoercionStrategy::Direct);
        assert_eq!(oracle.pending_count(), 0);
    }

    #[test]
    fn unknown_type_falls_through_to_direct() {
        let oracle = CoercionOracle::new();
        let ctx = CoercionContext::new(
            CoercionType::Unknown,
            CoercionType::Unknown,
            CoercionVerb::Move,
        );
        let strategy = oracle.recommend(&ctx);
        assert_eq!(strategy, CoercionStrategy::Direct);
    }

    #[test]
    fn load_nonexistent_creates_fresh() {
        let oracle = CoercionOracle::load_or_new(Path::new("/nonexistent/path/oracle.dat"));
        assert!(oracle.patterns.len() > 10); // Has seeded heuristics
    }

    #[test]
    fn clear_pending_resets() {
        let mut oracle = CoercionOracle::new();
        let mut ctx = CoercionContext::new(
            CoercionType::NumericDisplay(5),
            CoercionType::Alphanumeric(10),
            CoercionVerb::Move,
        );
        ctx.program_id = Some("clear_test".into());
        oracle.record(&ctx, &CoercionStrategy::Direct);
        assert_eq!(oracle.pending_count(), 1);

        oracle.clear_pending();
        assert_eq!(oracle.pending_count(), 0);
    }

    // ── Multi-strategy competition ──

    #[test]
    fn competing_strategies_best_wins() {
        let mut oracle = CoercionOracle::new();
        let key = PatternKey {
            source_tag: "TEST_SRC".into(),
            target_tag: "TEST_TGT".into(),
            verb_tag: "MOV".into(),
        };

        // Insert two competing strategies
        let mut good = StrategyScore::new(CoercionStrategy::NumericReinterpret);
        for _ in 0..10 { good.update(true); }

        let mut bad = StrategyScore::new(CoercionStrategy::Direct);
        for _ in 0..10 { bad.update(false); }

        oracle.patterns.insert(key.clone(), vec![good, bad]);

        let ctx = CoercionContext {
            source_type: CoercionType::Unknown,
            target_type: CoercionType::Unknown,
            verb: CoercionVerb::Move,
            source_pic: None,
            target_pic: None,
            source_usage: None,
            target_usage: None,
            program_id: None,
        };

        // Manually check the pattern
        let scores = oracle.patterns.get(&key).unwrap();
        let best = best_strategy(scores).unwrap();
        assert_eq!(best, CoercionStrategy::NumericReinterpret,
            "strategy with more correct observations should win");
    }

    // ── PIC Parser Edge Cases ──

    #[test]
    fn pic_simple_9() {
        let t = CoercionType::from_pic("9", None);
        assert_eq!(t, CoercionType::NumericDisplay(1));
    }

    #[test]
    fn pic_simple_x() {
        let t = CoercionType::from_pic("X", None);
        assert_eq!(t, CoercionType::Alphanumeric(1));
    }

    #[test]
    fn pic_mixed_999v99() {
        let t = CoercionType::from_pic("999V99", None);
        assert_eq!(t, CoercionType::DecimalDisplay(3, 2));
    }

    #[test]
    fn pic_s9_4_comp() {
        let t = CoercionType::from_pic("S9(4)", Some("COMP-5"));
        assert_eq!(t, CoercionType::Binary(4));
    }

    #[test]
    fn pic_empty_unknown() {
        let t = CoercionType::from_pic("", None);
        assert_eq!(t, CoercionType::Unknown);
    }
}
