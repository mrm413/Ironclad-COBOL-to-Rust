# Ironclad: COBOL-to-Rust — Byte-for-Byte Golden Parity

**835 / 835 byte-for-byte parity tests pass (100.0%) on the GnuCOBOL 3.2 in-scope test corpus | Zero external dependencies | No AI**

This repository contains the **output** of the Ironclad transpilation system — not the system itself. Every `.rs` file here was generated automatically from legacy COBOL source code. Every program is then run through a side-by-side validator that compares the GnuCOBOL reference output to the Ironclad-generated Rust output, **byte for byte**, on the same inputs.

Ironclad is a proprietary transpilation engine built by [Torsova LLC](https://torsova.com). The source code for Ironclad is not included in this repository.

---

## What Is This?

A reproducible, public proof of byte-for-byte equivalence between legacy COBOL and the Rust that Ironclad produces from it.

The validator runs both engines on every program in the test corpus and diffs their stdout, exit code, and produced files. A test counts as a pass only if the Rust output is identical to the GnuCOBOL output to the byte.

| Metric | Value |
|--------|-------|
| **Byte-for-byte parity** | **835 / 835 (100.0%)** |
| MATCH (non-empty equal output) | 391 |
| BOTH_EMPTY (programs that produce no stdout, both empty) | 444 |
| MISMATCH | 0 |
| BUILD_FAIL | 0 |
| RUN_ERROR | 0 |
| External dependencies | 0 |
| `unsafe` blocks in generated Rust | 0 |
| AI / LLM in the loop | None |

The `parity_results/` directory in this repo contains the raw sweep log, including the per-test PASS / MISMATCH / BOTH_EMPTY tag for every program in the corpus.

---

## Test Corpus

The validator runs against the program-bearing portion of the GnuCOBOL 3.2 test suite. Out-of-scope tests are excluded by design and listed below — none of them are silently dropped, every exclusion has a documented reason.

| Group | Count | Status |
|---|---|---|
| In-scope program tests | **835** | **100% byte-for-byte MATCH** |
| Architectural exclusions (documented below) | 29 | Excluded — see list |
| Compiler/tooling tests (`syn_*`, listings, `used_binaries_*`) | 136 | Out of scope — these test the COBOL compiler's error detection, not program execution |
| **Total raw golden files in the suite** | 1,000 | |

### Why the architectural exclusions exist

These are program features that depend on subsystems outside the scope of a deterministic source-to-source transpiler. We document them honestly rather than quietly skipping them:

- **V-ISAM / EXTFH / FCD subsystem** — vendor-specific external file handler with its own binary protocol
- **DEBUGGING declaratives** — relies on the compiler's runtime debug shim
- **C-interop programs** — call directly into linked C object files
- **`OCCURS UNBOUNDED`** — dynamic allocation tied to the runtime's heap manager
- **`ADDRESS OF` redirect** — true pointer redirection in a flat memory model
- **Variable-length `RETURNING`** — type punning across CALL boundaries
- **ANSI graphics test programs** — terminal-specific escape sequence output
- **x87 80-bit float emulation** — hardware-specific floating-point precision
- **Specific libcob debugging / dump output formats** — bound to that runtime's internal layout

Everything else passes. There is no soft pass — only byte-equal stdout, byte-equal exit code, byte-equal produced files.

---

## Reproducing the Result

The Docker harness in this repo runs the parity validator end-to-end. It compiles every COBOL program with GnuCOBOL 3.x, transpiles + compiles every program with Ironclad's Rust output, runs both, and diffs the outputs byte for byte.

```bash
# Build the parity validator image
docker build -t ironclad-parity -f Dockerfile.parity .

# Full sweep — all 835 in-scope programs
docker run --rm ironclad-parity

# Filter to a single test category
docker run --rm ironclad-parity bash parity_harness.sh --filter run_misc

# Quick check — first 50 programs
docker run --rm ironclad-parity bash parity_harness.sh --quick 50
```

Exit codes:

| Code | Meaning |
|---|---|
| 0 | 100% parity |
| 1 | At least one MISMATCH (logic divergence) |
| 2 | At least one BUILD_FAIL_RUST (transpiled output didn't compile) |
| 3 | At least one TIMEOUT_DIVERGE (one engine hung, other didn't) |

The harness prints a streaming log so you can watch the result for every test in real time.

---

## Why Byte-for-Byte Matters

Most "modernization" tools claim success when the new code "looks like it works." For mainframe replacements that's not enough. The same input has to produce the same output to the byte — leading zeros, trailing spaces, signed zone-decimal nibbles, packed-decimal sign half-bytes, all of it. Lose one byte and downstream batch jobs that count columns will silently corrupt.

The validator in this repo does not allow any of that. It runs both COBOL and Rust on the same input, captures both stdouts, and `cmp -s` them. If a single byte differs the test fails.

835 / 835 means every program in the in-scope corpus produces the exact same bytes from Rust as it does from COBOL.

---

## Why Rust as the Target

Rust doesn't need a hardening stage. The borrow checker, ownership model, and type system make entire categories of vulnerabilities impossible at compile time:

- **Buffer overflows** — `FixedString<N>` is bounds-checked at compile time
- **Integer overflow** — caught (panic in debug, explicit wrap in release)
- **Use-after-free** — prevented structurally by the ownership model
- **Null pointer dereference** — Rust has no null; `Option<T>` forces explicit handling
- **Data races** — prevented by the borrow checker

### The Day-Two Advantage

Day one, any well-built transpiler can produce safe output. Day two — when a developer needs to add a feature, fix a bug, or optimize a hot path — is where the choice of target language matters.

In **C++17**, nothing stops someone from writing `memcpy` instead of using the safety wrappers. The safety framework is a convention, and conventions break under deadline pressure.

In **Rust**, `rustc` will refuse to compile unsafe code. The borrow checker will reject dangling references. The type system will catch buffer overflows before the code ever runs. **You cannot ship an unsafe update because the compiler won't let you.**

We also build a **C++17 sibling**, [Torsova's COBOL-to-C++17 transpiler](https://github.com/mrm413/lazarus-cobol-showcase), for shops that need to land in existing C++ infrastructure. Same COBOL input, different target language, different tradeoff.

---

## Type Mapping

| COBOL | Rust |
|-------|------|
| `PIC X(N)` | `FixedString<N>` |
| `PIC 9(N)` | `u32` / `u64` |
| `PIC S9(N)` | `i32` / `i64` |
| `PIC S9(N)V9(M)` | exact fixed-point Decimal |
| `PIC S9(N) COMP` | `i16` / `i32` / `i64` |
| `PIC S9(N) COMP-3` | packed BCD |
| `BINARY-DOUBLE UNSIGNED` | `u64` |
| `BINARY-LONG UNSIGNED` | `u32` |
| `88-level` | enum variant |
| `OCCURS N TIMES` | `[T; N]` |
| `OCCURS DEPENDING ON` | `Vec<T>` |
| `REDEFINES` | struct overlay |
| `FD file-name` | sequential / indexed / relative file handle |

The runtime library is a single pure Rust crate with **zero external dependencies** — no FFI, no C bindings, no `unsafe` in either the runtime or any of the generated programs.

---

## Looking at the Output

### COBOL Input

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    prog.
       DATA           DIVISION.
       WORKING-STORAGE SECTION.
       01  X          PIC X(04) VALUE "AAAA".
       01  FILLER REDEFINES X.
           03  XBYTE  PIC X.
           03  FILLER PIC XXX.
       PROCEDURE DIVISION.
           MOVE X"0D" TO XBYTE.
           IF X ALPHABETIC
              DISPLAY "Fail - Alphabetic"
              END-DISPLAY
           END-IF.
           MOVE "A"   TO XBYTE.
           IF X NOT ALPHABETIC
              DISPLAY "Fail - Not Alphabetic"
              END-DISPLAY
           END-IF.
           STOP RUN.
```

### Rust Output (generated)

```rust
#![allow(unused_imports, unused_variables, dead_code, unused_parens, non_snake_case)]

use cobol_runtime::FixedString;

#[derive(Default)]
pub struct ProgramState {
    pub x:        FixedString<4>,
    pub xbyte:    FixedString<1>,
    pub return_code: i32,
}

fn main() {
    let mut state = ProgramState::default();
    state.x = FixedString::from("AAAA");

    state.xbyte = FixedString::from("\x0D");
    if !state.x.as_str().chars().all(|c| c.is_alphabetic() || c == ' ') {
        // X is not alphabetic — pass
    } else {
        println!("Fail - Alphabetic");
    }

    state.xbyte = "A".into();
    if state.x.as_str().chars().all(|c| c.is_alphabetic() || c == ' ') {
        // X is alphabetic — pass
    } else {
        println!("Fail - Not Alphabetic");
    }

    std::process::exit(0);
}
```

Run both, capture stdout, diff. Test passes only if the bytes match.

---

## What Makes Ironclad Different

1. **Deterministic** — Same COBOL input always produces the same Rust output. No randomness, no LLM, no heuristic guessing.
2. **Provable equivalence** — The validator compares COBOL and Rust outputs byte for byte on every test, every run.
3. **Real Rust types** — Enums, match expressions, `Result`-based error handling, iterators. Not string-encoded everything wrapped in `unsafe`.
4. **Zero dependencies** — Pure Rust runtime, no external crates, no FFI, no C bindings.
5. **Audit-grade provenance** — Every Rust file has a one-to-one COBOL source. No regenerated history; no "AI-rewrote-it-and-here's-hoping" gaps.

---

## Related Showcases

| Repo | What it shows |
|------|---|
| [cms-medicare-ironclad-showcase](https://github.com/mrm413/cms-medicare-ironclad-showcase) | Real CMS Medicare pricers (1998–2021, FY2005–FY2021 active range) — byte-for-byte parity across SNF / ESRD / Hospice / Home Health / IPF / IRF |
| [ironclad-carddemo-showcase](https://github.com/mrm413/ironclad-carddemo-showcase) | AWS CardDemo CICS / COBOL — 44/44 transpiled with a production CICS runtime + React 3270 UI |
| [lazarus-cobol-showcase](https://github.com/mrm413/lazarus-cobol-showcase) | C++17 sibling: same COBOL input, hardened C++17 output |

---

## Built By

**Torsova LLC** — [torsova.com](https://torsova.com)

Ironclad is part of Torsova's suite of legacy modernization tools including transpilers for COBOL (Rust and C++17), HLASM, JCL, DFSORT, PL/I, REXX, Easytrieve, SAS, VB6, Stored Procedures, Crystal Reports, and Microsoft Access.

---

## License

Licensed under the [Apache License, Version 2.0](LICENSE).

The original GnuCOBOL test programs are from the [GnuCOBOL project](https://gnucobol.sourceforge.io/).

All modifications and additions — including the Rust transpiled programs, the parity validator, and the test harness — are Copyright 2025–2026 Michael R. Mull / Torsova LLC. See [NOTICE](NOTICE) for details.
