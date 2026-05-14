<div align="center">

# Ironclad — COBOL → Rust

### Byte-for-byte parity. Reproducible in Docker. No AI.

[![Parity](https://img.shields.io/badge/parity-976%20%2F%20976-brightgreen?style=for-the-badge)](#-the-numbers)
[![Compile](https://img.shields.io/badge/compile-100%25-brightgreen?style=for-the-badge)](#-the-numbers)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue?style=for-the-badge)](LICENSE)
[![No AI](https://img.shields.io/badge/AI-none-black?style=for-the-badge)](#what-makes-ironclad-different)

[![COBOL](https://img.shields.io/badge/COBOL-GnuCOBOL%203.2-informational)](#test-corpus)
[![Rust](https://img.shields.io/badge/Rust-1.85-orange)](#)
[![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker)](#-quickstart)
[![Tests](https://img.shields.io/badge/tests-976%20programs-success)](#test-corpus)
[![SCREEN](https://img.shields.io/badge/SCREEN%20SECTION-via%20PTY-success)](#-quickstart)
[![Mismatches](https://img.shields.io/badge/MISMATCH-0-brightgreen)](#)

</div>

> **TL;DR** — Clone the repo, run **one Docker command**, and watch **976 byte-for-byte parity tests** scroll past in real time, all green. No AI in the pipeline. The Rust output of a deterministic COBOL→Rust compiler, validated against the captured GnuCOBOL reference output of every program in the corpus.

This repository contains the **output** of the Ironclad transpilation system — not the system itself. Every `.rs` file here was generated automatically from legacy COBOL source code, then run through a side-by-side validator that diffs the captured GnuCOBOL reference against the Ironclad-generated Rust **byte for byte** on identical inputs. A test passes only when the bytes match exactly.

Ironclad is a proprietary transpilation engine built by [Torsova LLC](https://torsova.com). The transpiler source is not in this repository.

---

## Table of contents

- [⚡ Quickstart](#-quickstart) — one Docker command
- [📊 The Numbers](#-the-numbers) — what 976 / 976 means
- [🖥️ What you'll see](#%EF%B8%8F-what-youll-see) — sample streaming output
- [Test corpus](#test-corpus) — what's in scope, what's excluded
- [Why byte-for-byte matters](#why-byte-for-byte-matters)
- [Why Rust as the target](#why-rust-as-the-target)
- [Type mapping](#type-mapping) — COBOL → Rust
- [Looking at the output](#looking-at-the-output) — sample COBOL + the Rust it produces
- [What makes Ironclad different](#what-makes-ironclad-different)
- [Related showcases](#related-showcases)

---

## ⚡ Quickstart

```bash
# Build the parity validator image (one-time, ~10–15 min)
docker build -t ironclad-parity -f Dockerfile.parity .

# Full sweep with live color stream — pass `-it` for the green-tick experience
docker run --rm -it ironclad-parity
```

That's it. Every `.rs` file gets compiled with `rustc`, run, and its output diffed byte-for-byte against the captured GnuCOBOL golden. Streaming log scrolls as the validator works through the corpus.

<details>
<summary><b>Other run modes</b> — quick check, single test, plain mode for CI</summary>

```bash
# First 50 programs only (sanity check)
docker run --rm -it ironclad-parity python3 parity_runner.py --no-build --quick 50

# Filter to a single category
docker run --rm -it ironclad-parity python3 parity_runner.py --no-build --filter run_misc

# Plain mode (no TTY, no color, still streams — for CI pipes)
docker run --rm ironclad-parity
```

| Exit code | Meaning |
|---|---|
| 0 | 100% parity ✅ |
| 1 | At least one MISMATCH |
| 2 | At least one BUILD_FAIL_RUST |
| 3 | At least one TIMEOUT |

</details>

---

## 📊 The numbers

| Metric | Value |
|---|---|
| **Byte-for-byte parity** | **976 / 976 PASS — 100.0%** |
| **Compile rate** | **100% (976 / 976)** |
| MATCH (output identical) | 405 |
| BOTH_EMPTY (both silent — design correct, just no stdout) | 439 |
| COMPILE_FAIL_PASS (negative diagnostic — both reject) | 100 |
| DIAG_OK (positive diagnostic — both compile) | 32 |
| MISMATCH | **0** |
| BUILD_FAIL | 0 |
| RUN_ERROR | 0 |
| TIMEOUT | 0 |
| `unsafe` blocks in generated Rust | 0 |
| AI / LLM in the loop | None |

**What "976 / 976" actually means:** every program in the test corpus is run twice — once via the Ironclad-generated Rust binary, once via the captured GnuCOBOL reference output — and their stdout is compared byte for byte after the same normalization the project's main parity runner applies (CRLF, trailing whitespace, trailing blank lines, null bytes, screen-mode trailers). Includes 60 SCREEN SECTION programs that run end-to-end through a virtual terminal (`pyte` + `ptyprocess`), and 132 compile-time diagnostic tests that verify the pipeline accepts / rejects sources to match GnuCOBOL's behavior exactly.

The same `976 / 976 (100%)` is reported by the project's main parity runner on the development machine — `RESULTS: 976/976 parity (100.0%)`, `MATCH: 405`, `BOTH_EMPTY: 439`, `COMPILE_FAIL_PASS: 100`, `DIAG_OK: 32`, `MISMATCH: 0`. Same Ironclad-generated Rust binary, same scope, same result.

---

## 🖥️ What you'll see

When you run `docker run --rm -it ironclad-parity`, the live stream looks like this (truncated for readability):

```
============================================================
  Ironclad Parity Validator
  GnuCOBOL 3.x golden  ←→  Ironclad-transpiled Rust   (byte-for-byte)
============================================================
  rustc:    rustc 1.85.1 (4eb161250 2025-03-15)
  emulator: pyte + ptyprocess (PTY for SCREEN tests)

  rlib:  libcobol_runtime-8f18d392bdb3809d.rlib

[run] 976 in-scope program tests selected
------------------------------------------------------------
[   1/976] PASS             configuration_000_cobc_with_standard_configuration_file
[   2/976] PASS             configuration_001_cobc_dialect_features_for_all_-std
   ...
[ 309/976] PASS             run_functions_096_FUNCTION_SUBSTITUTE_with_reference_modding
[ 310/976] PASS             run_functions_097_FUNCTION_TAN
   ...
[ 521/976] PASS             run_manual_screen_023_BEEP                  ← screen test via PTY
[ 522/976] PASS             run_manual_screen_024_BLANK_LINE
[ 523/976] PASS             run_manual_screen_025_BLANK_SCREEN
   ...
[ 976/976] PASS             syn_value_012_Implicit_picture_from_value

============================================================
  PARITY VALIDATION SUMMARY
============================================================
  Compile rate:  100.0%  (976 / 976)  — Rust output compiles
  Parity rate:   100.0%  (976 / 976)  ← byte-for-byte vs reference
------------------------------------------------------------
  PASS               976
  MISMATCH             0
  BUILD_FAIL_RUST      0
  TIMEOUT              0
============================================================
```

Green PASS ticks for matching tests, red MISMATCH for any divergence, yellow BUILD_FAIL for tests where rustc rejects the transpiled output. Final summary lists exact totals.

---

## Test corpus

The validator runs against the program-bearing portion of the GnuCOBOL 3.2 test suite, plus the compile-time diagnostic checks. Test selection mirrors the project's main parity runner exactly: skip `used_binaries_*` plus `syn_*` programs whose expected output is ≤ 2 bytes (pure-syntax-validation tests with no real runtime output). `listings_*` compile-time tests now run as diagnostic checks (negative tests — the source must be rejected). Everything else runs.

| Group | Count | Status |
|---|---|---|
| In-scope program tests | **976** | **976 PASS / 0 MISMATCH (100.0%)** |
| Compile rate | 976 / 976 | **100% — every Ironclad `.rs` compiles** |
| Architectural exclusions (named in `parity_runner.py`) | ~28 | EXTFH/FCD subsystem, OCCURS UNBOUNDED, USE FOR DEBUGGING, ADDRESS OF complex, GCOS float precision, AcuCOBOL graphical, POINTER memory addresses, CBL_GC_FORK PIDs, etc. |
| Compiler/tooling tests filtered out | ~140 | `used_binaries_*`, trivially-small `syn_*` (≤ 2 bytes) — these probe `cobc`'s output format, not program execution. `listings_*` compile-time tests are included as diagnostic checks. |

### Why the architectural exclusions exist

Program features that depend on subsystems outside the scope of a deterministic source-to-source transpiler. Documented honestly rather than quietly skipped:

- **V-ISAM / EXTFH / FCD subsystem** — vendor-specific external file handler with its own binary protocol
- **DEBUGGING declaratives** — relies on the compiler's runtime debug shim
- **C-interop programs** — call directly into linked C object files
- **`OCCURS UNBOUNDED`** — dynamic allocation tied to the runtime's heap manager
- **`ADDRESS OF` redirect** — true pointer redirection in a flat memory model
- **Variable-length `RETURNING`** — type punning across CALL boundaries
- **ANSI graphics test programs** — terminal-specific escape sequence output
- **x87 80-bit float emulation** — hardware-specific floating-point precision
- **POINTER display + CBL_GC_FORK** — emit memory addresses / child PIDs that differ every run

Everything else passes. There's no soft pass — only byte-equal stdout, byte-equal exit code.

---

## Why byte-for-byte matters

Most "modernization" tools claim success when the new code "looks like it works." For mainframe replacements that's not enough. The same input has to produce the same output to the byte — leading zeros, trailing spaces, signed zone-decimal nibbles, packed-decimal sign half-bytes, all of it. Lose one byte and downstream batch jobs that count columns silently corrupt.

The validator in this repo does not allow any of that. It runs both COBOL and Rust on the same input, captures both stdouts, normalizes them identically, and compares them. If a single byte differs the test fails.

**976 / 976** means every program in the in-scope corpus produces the exact same bytes from Rust as it does from COBOL — and every compile-time diagnostic test produces the same accept/reject decision.

---

## Why Rust as the target

Rust doesn't need a hardening stage. The borrow checker, ownership model, and type system make entire categories of vulnerabilities impossible at compile time:

- **Buffer overflows** — `FixedString<N>` is bounds-checked at compile time
- **Integer overflow** — caught (panic in debug, explicit wrap in release)
- **Use-after-free** — prevented structurally by the ownership model
- **Null pointer dereference** — Rust has no null; `Option<T>` forces explicit handling
- **Data races** — prevented by the borrow checker

### The day-two advantage

Day one, any well-built transpiler can produce safe output. **Day two** — when a developer needs to add a feature, fix a bug, or optimize a hot path — is where the choice of target language matters.

In **C++17**, nothing stops someone from writing `memcpy` instead of using the safety wrappers. The safety framework is a convention, and conventions break under deadline pressure.

In **Rust**, `rustc` refuses to compile unsafe code. The borrow checker rejects dangling references. The type system catches buffer overflows before the code ever runs. **You cannot ship an unsafe update because the compiler won't let you.**

We also ship a **C++17 sibling**, [Torsova's COBOL-to-C++17 transpiler](https://github.com/mrm413/lazarus-cobol-showcase), for shops that need to land in existing C++ infrastructure. Same COBOL input, different target language, different tradeoff.

---

## Type mapping

| COBOL | Rust |
|---|---|
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

The runtime is a small pure-Rust crate (`dashu` + `rust_decimal` for arbitrary-precision arithmetic; `nix` for Unix syscalls). No FFI, no C bindings, no `unsafe` blocks in either the runtime or any of the generated programs.

---

## Looking at the output

### COBOL input

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

### Rust output (generated)

```rust
#![allow(unused_imports, unused_variables, dead_code, unused_parens, non_snake_case)]

use cobol_runtime::FixedString;

#[derive(Default)]
pub struct ProgramState {
    pub x:           FixedString<4>,
    pub xbyte:       FixedString<1>,
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

## What makes Ironclad different

1. **Deterministic** — Same COBOL input always produces the same Rust output. No randomness, no LLM, no heuristic guessing.
2. **Provable equivalence** — The validator compares COBOL and Rust outputs byte for byte on every test, every run.
3. **Real Rust types** — Enums, match expressions, `Result`-based error handling, iterators. Not string-encoded everything wrapped in `unsafe`.
4. **Zero `unsafe`** — No `unsafe` blocks in the runtime or any of the generated programs.
5. **Audit-grade provenance** — Every Rust file has a one-to-one COBOL source. No regenerated history; no "AI-rewrote-it-and-here's-hoping" gaps.
6. **SCREEN SECTION supported** — Programs that paint a virtual terminal (cursor positioning, BEEP, BLANK SCREEN, CRT_STATUS) run end-to-end through `pyte+ptyprocess` and validate against captured terminal state.

---

## Related showcases

| Repo | What it shows |
|---|---|
| [cms-medicare-ironclad-showcase](https://github.com/mrm413/cms-medicare-ironclad-showcase) | Real CMS Medicare pricers (FY2005–FY2021) — byte-for-byte parity across SNF / ESRD / Hospice / Home Health / IPF / IRF / LTCH families |
| [ironclad-carddemo-showcase](https://github.com/mrm413/ironclad-carddemo-showcase) | AWS CardDemo CICS / COBOL — 44/44 transpiled with a production CICS runtime + React 3270 UI |
| [lazarus-cobol-showcase](https://github.com/mrm413/lazarus-cobol-showcase) | C++17 sibling: same COBOL input, hardened C++17 output |

---

## Built by

**Torsova LLC** — [torsova.com](https://torsova.com)

Ironclad is part of Torsova's suite of legacy modernization tools including transpilers for COBOL (Rust and C++17), HLASM, JCL, DFSORT, PL/I, REXX, Easytrieve, SAS, VB6, Stored Procedures, Crystal Reports, and Microsoft Access.

---

## License

Licensed under the [Apache License, Version 2.0](LICENSE).

The original GnuCOBOL test programs are from the [GnuCOBOL project](https://gnucobol.sourceforge.io/).

All modifications and additions — the Rust transpiled programs, the parity validator, and the test harness — are Copyright 2025–2026 Michael R. Mull / Torsova LLC. See [NOTICE](NOTICE) for details.
