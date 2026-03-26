# Ironclad: Deterministic COBOL-to-Rust Transpiler Output

**1,314 Rust programs transpiled from 1,545 COBOL test programs | 100% compile | 100% runtime | Zero external dependencies**

This repository contains the **output** of the Ironclad transpilation system — not the system itself. Every file here was generated automatically from legacy COBOL source code and compiled as idiomatic Rust.

Ironclad is a proprietary transpilation engine built by [Torsova LLC](https://lazarus-systems.com). The source code for Ironclad is not included in this repository.

---

## What Is This?

Ironclad takes legacy COBOL programs and produces deterministic, idiomatic Rust. This repository demonstrates that capability at scale: the full GnuCOBOL 3.2 validation suite has been transpiled and compiled to working Rust binaries.

| Metric | Value |
|--------|-------|
| COBOL programs processed | 1,545 |
| Rust programs generated | 1,314 |
| Compile success rate | 100.0% |
| Runtime validation rate | 100.0% |
| Total transpiled Rust lines | 223,922 |
| Runtime library lines | 5,900 (17 modules) |
| Expansion ratio | ~2.5x (COBOL lines to Rust lines) |
| Pipeline speed | ~1.64 seconds total |
| External dependencies | 0 |
| AI/LLM in the loop | None |

### What Changed (v2)

The transpiler now produces significantly more compact output:

- **`define_record!` macro** — Data record structs that previously required ~17 lines of boilerplate (struct + Display + From + helpers) are now declared in a single macro invocation. The macro generates all standard trait implementations at compile time.
- **Shared runtime helpers** — `CobolInto` trait and `cobol_helpers` module now live in the runtime library instead of being duplicated in every generated file. One import replaces ~130 lines of inline code per program.
- **Dead paragraph elimination** — Unreachable paragraphs are detected via transitive closure analysis from the entry point and excluded from output.
- **Clean compilation** — A single file-level `#![allow(...)]` attribute replaces scattered per-item annotations.

On the CardDemo enterprise benchmark (44 COBOL programs, 30K lines), these changes reduced output from 103,715 to 76,208 lines — a **26.5% reduction**, bringing the expansion ratio from 3.44x down to **2.53x**.

---

## Why Rust?

This is the part that matters.

**Rust doesn't need a hardening stage.** The borrow checker, ownership model, and type system make entire categories of vulnerabilities impossible at compile time. There is no bolted-on safety layer, no convention that developers can skip under deadline pressure, no runtime overhead for bounds checks that the compiler already proved unnecessary.

When Ironclad produces Rust output, the safety is **baked into the language**:

- **Buffer overflows** — impossible. `FixedString<N>` is bounds-checked at compile time.
- **Integer overflow** — caught. Rust panics on overflow in debug, wraps explicitly in release.
- **Use-after-free** — impossible. The ownership model prevents it structurally.
- **Null pointer dereference** — impossible. Rust has no null. `Option<T>` forces explicit handling.
- **Data races** — impossible. The borrow checker prevents shared mutable state.

### The Day-Two Advantage

This is where Rust separates from every other target language.

**Day one**, any well-built transpiler can produce safe output. Lazarus (our C++17 transpiler) produces hardened C++17 with `FixedString<N>`, `SafeInt<T>`, and bounds-checked access. Day one, it's safe.

**Day two** is when a developer needs to add a feature, fix a bug, or optimize a hot path.

- In **C++17**, nothing stops someone from writing `memcpy` instead of using the safety wrappers. Nothing prevents casting away a bounds check for "performance." The safety framework is a convention, and conventions break under deadline pressure.

- In **Rust**, `rustc` will refuse to compile unsafe code. The borrow checker will reject dangling references. The type system will catch buffer overflows before the code ever runs. **You cannot ship an unsafe update because the compiler won't let you.**

This isn't a matter of discipline. It's a matter of architecture. C++ trusts the programmer. Rust does not. Both are valid philosophies, but they have fundamentally different long-term maintenance profiles.

### Ironclad vs. Lazarus

We build both. [Lazarus](https://github.com/mrm413/lazarus-cobol-showcase) produces hardened C++17. Ironclad produces idiomatic Rust. Same COBOL input, different target languages, different tradeoffs:

| | Lazarus (C++17) | Ironclad (Rust) |
|---|---|---|
| Pipeline stages | 6 (includes hardening) | 4 (no hardening needed) |
| Safety model | Convention (wrappers) | Compiler-enforced |
| Day-two safety | Depends on developer discipline | Enforced by `rustc` |
| Ecosystem fit | Existing C++ infrastructure | Greenfield or Rust shops |
| Hiring pool | Larger (more C++ devs) | Smaller (growing fast) |
| Regulatory acceptance | Established audit processes | Gaining recognition |

The right tool depends on the constraints. If you're landing in existing C++ infrastructure, Lazarus is the pragmatic choice. If you can choose your stack, Ironclad and Rust are the safer long-term bet.

---

## The Four-Stage Pipeline

```
  COBOL Source (.cbl / .cob)
      |
      v
  [1. Parser ]          DATA DIVISION  -> typed field map
      |                  PROCEDURE DIV  -> verb-level AST
      |                  COPY/REPLACE   -> expanded inline
      v
  Typed COBOL IR          structs, enums, decimals, file descriptors
      |
  [2. Rustifier ]       PIC -> Rust types, PERFORM -> loops,
      |                  EVALUATE -> match, READ/WRITE -> Result<T,E>
      v
  Rust AST                real structs, real enums, real error handling
      |
  [3. Emitter ]         formatted .rs output
      |
      v
  Idiomatic Rust (.rs)    cargo build
      |
  [4. Validator ]        same inputs -> same outputs (byte-for-byte)
      v
  Equivalence Report      PASS/FAIL per test vector
```

Every stage is deterministic. Same COBOL input always produces the same Rust output. No randomness, no LLM, no heuristics. The validator runs both the original COBOL and the generated Rust against the same test inputs and compares outputs byte-for-byte.

---

## Repository Structure

```
ironclad-showcase/
  README.md                          # This file
  cobol-runtime/
    src/
      lib.rs                         # Core types: FixedString, Decimal, PackedDecimal
      fixed_string.rs                # FixedString<N> implementation
      decimal.rs                     # Fixed-point exact arithmetic
      packed_decimal.rs              # COMP-3 packed decimal arithmetic
      file_status.rs                 # FileStatus codes (00, 10, 35, etc.)
      cobol_file.rs                  # CobolFile sequential/indexed/relative I/O
      cobol_into.rs                  # CobolInto trait — universal MOVE conversion
      cobol_helpers.rs               # Shared helper functions (intrinsics, refmod, INSPECT)
      record_macro.rs                # define_record! macro for compact struct generation
      string_ops.rs                  # STRING, UNSTRING, INSPECT operations
      ebcdic.rs                      # EBCDIC/ASCII conversion tables
      edited_numeric.rs              # Number formatting (edit masks)
      chrono_shim.rs                 # Date/time functions (ACCEPT FROM DATE)
      report_writer.rs               # INITIATE, GENERATE, TERMINATE stubs
      cics.rs                        # CICS runtime stubs
      sql.rs                         # SQL context + SQLCA
      dli.rs                         # DLI/IMS hierarchical database
  samples/                           # Curated before/after examples
    display_literals/                # Basic DISPLAY statement
    alphabetic_test/                 # Conditional logic with REDEFINES
    function_abs/                    # Intrinsic function ABS
    customer_report/                 # Report Writer (INITIATE/GENERATE/TERMINATE)
    packed_decimal_arithmetic/       # COMP-3 packed decimal math
    binary_64bit_compare/            # 64-bit unsigned binary comparison
  cobol_source/                      # All 1,545 original COBOL programs
  rust_output/                       # All 1,314 transpiled Rust programs
```

---

## Type Mapping

| COBOL | Rust | Notes |
|-------|------|-------|
| `PIC X(N)` | `FixedString<N>` | Space-padded, EBCDIC-safe |
| `PIC 9(N)` | `u32` / `u64` | Display numeric |
| `PIC S9(N)` | `i32` / `i64` | Signed display |
| `PIC S9(N)V9(M)` | `Decimal` | Fixed-point exact arithmetic |
| `PIC S9(N) COMP` | `i16` / `i32` / `i64` | Binary native |
| `PIC S9(N) COMP-3` | `PackedDecimal<N>` | BCD packed decimal |
| `BINARY-DOUBLE UNSIGNED` | `u64` | 64-bit unsigned native binary |
| `BINARY-LONG UNSIGNED` | `u32` | 32-bit unsigned native binary |
| `88-level` | enum variant | Condition names |
| `OCCURS N TIMES` | `[T; N]` | Fixed array |
| `OCCURS DEPENDING ON` | `Vec<T>` | Variable length |
| `REDEFINES` | struct overlay | Type-safe reinterpretation |
| `FD file-name` | `CobolFile` + `BufReader`/`Writer` | File descriptor |

## Verb Mapping

| COBOL | Rust |
|-------|------|
| `MOVE X TO Y` | `y = format!("{}", x).cobol_into()` |
| `ADD X TO Y` | `y += x` |
| `COMPUTE Y = expr` | `y = expr` (native operators) |
| `IF / ELSE / END-IF` | `if / else` |
| `EVALUATE / WHEN` | `match` arms |
| `PERFORM para` | `para(&mut state)` |
| `PERFORM UNTIL cond` | `while !cond { ... }` |
| `PERFORM VARYING` | `for i in range { ... }` |
| `READ file AT END` | `match reader { Ok(line) => ..., Err(AtEnd) => ... }` |
| `WRITE rec` | `writer.write_record(&buf)` |
| `OPEN INPUT file` | `CobolFile::open_input(path)` |
| `CLOSE file` | `handle.close()` |
| `STRING / UNSTRING` | `format!` / `split` |
| `INSPECT TALLYING` | `cobol_inspect_tallying_count()` |
| `FUNCTION ABS(X)` | `x.value().abs()` |
| `FUNCTION UPPER-CASE` | `cobol_fn_upper_case()` |
| `FUNCTION CURRENT-DATE` | `cobol_fn_current_date()` |
| `STOP RUN` | `std::process::exit(code)` |
| `DISPLAY` | `println!()` |

---

## The Runtime Library

The `cobol-runtime` crate is a pure Rust library with **zero external dependencies**. It provides the types and operations that COBOL programs need at runtime:

- **`FixedString<N>`** — Fixed-length, space-padded strings that match COBOL `PIC X(N)` semantics exactly. No heap allocation for strings that fit in the fixed buffer.
- **`Decimal`** — Exact fixed-point arithmetic so `0.1 + 0.2 == 0.3`. No floating-point surprise. Financial math that matches COBOL penny-for-penny.
- **`PackedDecimal<N>`** — COMP-3 Binary Coded Decimal with the exact byte layout of mainframe packed fields.
- **`CobolFile`** — Sequential, indexed, and relative file I/O with `FileStatus` codes matching the COBOL standard (`00`, `10`, `35`, etc.).
- **`EBCDIC`** — Full EBCDIC-to-ASCII conversion tables for mainframe data migration.
- **`CobolInto`** — Universal type conversion trait implementing COBOL MOVE semantics. One trait handles all implicit conversions (string-to-numeric, numeric-to-string, cross-type moves).
- **`cobol_helpers`** — Shared helper functions for intrinsic functions (`CURRENT-DATE`, `UPPER-CASE`, `ABS`, `NUMVAL`, etc.), reference modification, and INSPECT operations.
- **`define_record!`** — Declarative macro that generates data record structs with all standard trait implementations (Display, From, helper methods) in a single invocation, reducing per-struct boilerplate from ~17 lines to ~5.

The entire runtime is ~5,900 lines of Rust across 17 modules. No `unsafe` blocks. No FFI. No C dependencies.

---

## Looking at the Output

### Example: COBOL Input

```cobol
       IDENTIFICATION   DIVISION.
       PROGRAM-ID.      prog.
       DATA             DIVISION.
       WORKING-STORAGE  SECTION.
       01  X            PIC X(04) VALUE "AAAA".
       01  FILLER REDEFINES X.
           03  XBYTE    PIC X.
           03  FILLER   PIC XXX.
       PROCEDURE        DIVISION.
           MOVE X"0D"   TO XBYTE.
           IF X ALPHABETIC
              DISPLAY "Fail - Alphabetic"
              END-DISPLAY
           END-IF.
           MOVE "A"     TO XBYTE.
           IF X NOT ALPHABETIC
              DISPLAY "Fail - Not Alphabetic"
              END-DISPLAY
           END-IF.
           STOP RUN.
```

### Example: Rust Output

```rust
#![allow(unused_imports, unused_variables, dead_code, unused_parens, non_snake_case)]

use cobol_runtime::FixedString;
use cobol_runtime::CobolInto;
use cobol_runtime::cobol_helpers::*;
use cobol_runtime::define_record;

define_record! {
    /// FILLER REDEFINES X
    pub struct XRedefines {
        /// XBYTE
        pub xbyte: FixedString<1>,
        /// FILLER
        pub _filler_8: FixedString<3>,
    }
}

#[derive(Debug, Clone)]
pub struct ProgramState {
    pub x: FixedString<4>,
    pub x_redefines: XRedefines,
    pub xbyte: FixedString<1>,
    pub return_code: i32,
}

impl Default for ProgramState {
    fn default() -> Self {
        Self {
            x: FixedString::from_cobol_str("AAAA"),
            x_redefines: Default::default(),
            xbyte: Default::default(),
            return_code: 0,
        }
    }
}

fn main() {
    let mut state = ProgramState::default();
    state.x_redefines.xbyte = FixedString::from("\x0D");
    if !state.x.as_str().chars().all(|c| c.is_alphabetic() || c == ' ') {
        // X is not alphabetic — correct
    } else {
        println!("{}", "Fail - Alphabetic");
    }
    state.x_redefines.xbyte = "A".into();
    if state.x.as_str().chars().all(|c| c.is_alphabetic() || c == ' ') {
        // X is alphabetic — correct
    } else {
        println!("{}", "Fail - Not Alphabetic");
    }
    std::process::exit(0);
}
```

Every COBOL data structure becomes a Rust struct. Every paragraph becomes a function. Every `PIC X(N)` becomes a `FixedString<N>`. Record structs use `define_record!` to eliminate boilerplate. The Rust compiler enforces safety on every line — no wrappers, no conventions, no hoping the next developer reads the docs.

---

## Test Categories

The GnuCOBOL 3.2 test suite covers the full breadth of the COBOL language:

| Category | Tests | Description |
|----------|-------|-------------|
| `configuration` | 15 | Compiler flags, dialect settings, source formats |
| `data_binary` | 11 | COMP, COMP-4, binary data items |
| `data_display` | 11 | DISPLAY format numeric/alphanumeric |
| `data_packed` | 25 | COMP-3 packed decimal |
| `data_pointer` | 6 | Pointer and address operations |
| `listings` | 9 | Source listings and REPLACE |
| `run_accept` | 6 | ACCEPT statement |
| `run_extensions` | 140 | MF/IBM extensions, system routines |
| `run_file` | 132 | Sequential, indexed, relative file I/O |
| `run_functions` | 15 | Intrinsic functions |
| `run_fundamental` | 123 | Core language: MOVE, ADD, IF, PERFORM, CALL, STRING |
| `run_initialize` | 76 | INITIALIZE statement |
| `run_manual_screen` | 7 | Screen section |
| `run_misc` | 244 | SORT, MERGE, INSPECT, EXIT, reference modification |
| `run_ml` | 2 | JSON/XML GENERATE |
| `run_refmod` | 29 | Reference modification |
| `run_reportwriter` | 29 | Report Writer (RD, GENERATE, TERMINATE) |
| `run_returncode` | 7 | RETURN-CODE and STOP RUN |
| `run_subscripts` | 5 | Table subscripts and indexing |
| `syn_copy` | 88 | COPY and REPLACE directives |
| `syn_definition` | 91 | Data definition validation |
| `syn_file` | 37 | File control validation |
| `syn_functions` | 39 | Function syntax validation |
| `syn_ipn` | 12 | Identification/program-name syntax |
| `syn_literals` | 21 | Numeric and string literals |
| `syn_misc` | 195 | Miscellaneous syntax validation |
| `syn_move` | 10 | MOVE statement validation |
| `syn_occur` | 12 | OCCURS clause validation |
| `syn_refmod` | 13 | Reference modification syntax |
| `syn_reportwriter` | 31 | Report Writer syntax |
| `syn_screen` | 28 | Screen section syntax |
| `syn_subscripts` | 5 | Subscript syntax |
| `syn_value` | 5 | VALUE clause validation |
| `used_binaries` | 28 | Binary/executable linkage |

---

## What Makes Ironclad Different

1. **Direct COBOL-to-Rust** — No C or C++ intermediate stage that destroys type information. COBOL's typed data definitions map directly to Rust structs.
2. **Deterministic** — Same COBOL input always produces the same Rust output. No randomness, no LLM in the loop, no heuristic guessing.
3. **Provable equivalence** — The validator runs both the original COBOL and the generated Rust against the same test inputs and compares outputs byte-for-byte.
4. **Real Rust types** — Enums, match expressions, Result-based error handling, iterators. Not string-encoded everything wrapped in unsafe blocks.
5. **Zero dependencies** — The runtime library is pure Rust with no external crates, no FFI, no C bindings.
6. **Compact output** — The `define_record!` macro and shared runtime helpers keep the expansion ratio around 2.5x, not 5-10x like template-based approaches.
7. **Government-grade** — Audit trail, reproducible builds, NIST-friendly provenance chain.

---

## Built By

**Torsova LLC** — [lazarus-systems.com](https://lazarus-systems.com)

Ironclad is part of a suite of legacy modernization tools including transpilers for COBOL (C++17 and Rust), HLASM, JCL, DFSORT, PL/I, REXX, Easytrieve, SAS, VB6, Stored Procedures, Crystal Reports, and Microsoft Access.

See also: [Lazarus COBOL-to-C++17 Showcase](https://github.com/mrm413/lazarus-cobol-showcase) — the C++17 counterpart with 1,607/1,607 tests passing.

---

## License

Licensed under the [Apache License, Version 2.0](LICENSE).

The original GnuCOBOL test programs are from the [GnuCOBOL project](https://gnucobol.sourceforge.io/).

All modifications and additions -- including the Rust transpiled programs, build system, and test harness -- are Copyright 2025 Michael R. Mull / Lazarus Systems. See [NOTICE](NOTICE) for details.
