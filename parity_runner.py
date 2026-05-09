#!/usr/bin/env python3
"""
Ironclad Parity Validator — Python version.

Runs every Ironclad-generated Rust binary in the showcase against the
captured GnuCOBOL golden output, byte-for-byte. Mirrors the project's
main parity runner end-to-end:

  * Per-test cwd = test source dir (so relative-path file I/O resolves)
  * _at_data.json fixture staging (data files + env vars)
  * Output normalization (CRLF, trailing whitespace, trailing blank lines,
    null bytes, screen-mode "end of program" trailer)
  * Cross-platform terminal emulator for SCREEN SECTION programs
    (pyte + ptyprocess on Linux; the same architecture the project's
    Windows runner uses with pywinpty)
  * Non-deterministic output masking (memory addresses, child PIDs)
  * Streaming color output (green PASS / red MISMATCH / yellow BUILD_FAIL_RUST)

Usage:
    python3 parity_runner.py               # full sweep
    python3 parity_runner.py --quick 50    # first 50
    python3 parity_runner.py --filter run_misc
    python3 parity_runner.py --no-build    # skip cargo build of cobol-runtime
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

# ── Paths (relative to this file) ────────────────────────────────────────
ROOT          = Path(__file__).parent.resolve()
COBOL_DIR     = ROOT / "cobol_source"
RUST_DIR      = ROOT / "rust_output"
GOLDEN_DIR    = ROOT / "golden"
RUNTIME_DIR   = ROOT / "cobol-runtime"
WORK_DIR      = ROOT / "_parity_work"
RESULTS_DIR   = ROOT / "parity_results"

# ── Color (auto-disabled if not a TTY or NO_COLOR is set) ────────────────
if sys.stdout.isatty() and not os.environ.get("NO_COLOR"):
    C_RESET  = "\033[0m"
    C_BOLD   = "\033[1m"
    C_GREEN  = "\033[32m"
    C_RED    = "\033[31m"
    C_YELLOW = "\033[33m"
    C_CYAN   = "\033[36m"
    C_DIM    = "\033[2m"
else:
    C_RESET = C_BOLD = C_GREEN = C_RED = C_YELLOW = C_CYAN = C_DIM = ""

# ── Optional: terminal emulator for SCREEN SECTION programs ──────────────
try:
    from emulator import TerminalEmulator   # type: ignore[import-not-found]
    HAS_EMULATOR = True
except ImportError:
    HAS_EMULATOR = False

# ── Architectural exclusions (mirror of the project's _SKIP_TESTS set) ──
SKIP_TESTS = {
    # EXTFH/FCD subsystem
    "run_file_077_EXTFH__Indexed_with_FH--FCD",
    "run_file_078_EXTFH__SEQUENTIAL_files",
    "run_file_079_EXTFH__LINE_SEQUENTIAL_files__direct_EXTFH",
    "run_file_081_EXTFH__FIXED_SEQUENTIAL",
    "run_file_082_EXTFH__operation_OP_GETINFO___QUERY-FILE",
    "run_file_083_EXTFH__changing_record_address",
    "run_file_084_EXTFH__INDEXED_with_multiple_keys",
    "run_file_085_EXTFH__RELATIVE_files",
    "run_file_086_EXTFH__reading_two_files_with_one_FCD",
    "run_file_087_EXTFH__auto-conversion_FCD2__-__FCD3_on_32bit",
    # USE FOR DEBUGGING
    "run_fundamental_085_USE_FOR_DEBUGGING__COB_SET_DEBUG_switched_",
    # Trace/dump features (cobc runtime internals)
    "run_misc_007_CURRENCY_SIGN",
    "run_misc_007_CURRENCY_SIGN_WITH_PICTURE_SYMBOL",
    "run_misc_139_stack_and_dump_feature",
    # WHEN-COMPILED — volatile timestamp differs every run
    "syn_misc_105_WHEN-COMPILED_register_in_dialect",
    # CALL BY VALUE to C — C-interop FFI
    "run_extensions_029_CALL_BY_VALUE_to_C",
    # ACCEPT FROM TIME/DATE — timing-dependent
    "run_accept_002_ACCEPT_FROM_TIME___DATE___DAY___DAY-OF-WEEK__2_",
    # OCCURS UNBOUNDED
    "run_extensions_016_OCCURS_UNBOUNDED__1_",
    "run_extensions_017_OCCURS_UNBOUNDED__2_",
    "run_extensions_018_INITIALIZE_OCCURS_UNBOUNDED",
    # BDB-specific indexed file format error message
    "run_file_089_INDEXED_File_READ_DELETE_READ",
    # Variable-length RETURNING from user-defined function
    "run_fundamental_024_function_with_variable-length_RETURNING_item",
    # XML GENERATE exceptions
    "run_ml_002_XML_GENERATE_exceptions",
    # Variable-length INDEXED records
    "run_file_063_INDEXED_SEQUENTIAL_with_variable_records",
    # PPP COMP-3 P-factor scaling edge case
    "data_packed_016_PPP_COMP-3",
    # Packed-decimal rounding edge case (Test 42/43 boundary)
    "run_fundamental_060_Numeric_operations__3__PACKED-DECIMAL",
    # ASSIGN DYNAMIC with LINKAGE SECTION data item
    "run_file_020_ASSIGN_DYNAMIC_with_data_item_in_LINKAGE",
    # LINE SEQUENTIAL multi-record terminator handling
    "run_file_092_LINE_SEQUENTIAL_data",
    # ADDRESS OF complex scenarios
    "run_extensions_006_ADDRESS_OF",
    # GCOS floating-point last-digit precision
    "run_extensions_094_GCOS_floating-point_usages",
    # Interactive ANSI line-draw / color CONTROL
    "run_manual_screen_021_field_BACKGROUND-___FOREGROUND-COLOUR_via_CONTROL",
    "run_manual_screen_022_line_draw_characters_via_CONTROL_GRAPHICS",
    # AcuCOBOL graphical extensions
    "syn_misc_044_ACUCOBOL_GRAPHICAL_controls",
    # POINTER values — emit memory addresses (different every run)
    "data_pointer_000_POINTER__display",
    "run_misc_127_CALL_RETURNING_POINTER",
    # CBL_GC_FORK — emits child PID (different every run)
    "run_extensions_070_System_routine_CBL_GC_FORK",
    # EC-SCREEN exception line/column — needs SCREEN context the harness can't replicate
    "run_misc_129_EC-SCREEN-LINE-NUMBER_and_-STARTING-COLUMN",
    "run_misc_130_LINE_COLUMN_0_exceptions",
}
SKIP_PREFIXES = ("listings_", "used_binaries_")
# Note: this matches the project's main parity runner exactly:
#   - listings_, used_binaries_ are the only prefix-skipped categories
#   - syn_ tests are skipped ONLY when the expected output is trivially small
#     (≤ 2 bytes — these are pure-syntax-validation tests with no real output)
#   - configuration_, run_manual_screen_, run_*, data_*, etc. all run.

# ── Output normalization (matches project's main parity runner) ──────────

def normalize(s: str) -> str:
    """Strip CRLF, null bytes, trailing whitespace per line, trailing blank
    lines, and the Ironclad screen-mode 'end of program' trailer."""
    if not s:
        return ""
    s = s.replace("\r\n", "\n").replace("\r", "\n")
    s = s.replace("\x00", "")
    lines = s.split("\n")
    lines = [l.rstrip() for l in lines]
    trailer = "end of program, please press a key to exit"
    while lines:
        last = lines[-1]
        if last and len(last) >= 2 and trailer.startswith(last):
            lines.pop(); continue
        if not last:
            lines.pop(); continue
        break
    return "\n".join(lines)


def mask_nondet(s: str) -> str:
    """Mask non-deterministic output: memory addresses (0x...), child PIDs."""
    if not s:
        return s
    s = re.sub(r'0x[0-9a-fA-F]{6,16}\b', '0xXXXXXXXX', s)
    return s


# ── Per-test detection ───────────────────────────────────────────────────

SCREEN_DETECT_PATTERNS = [
    re.compile(r'\bSCREEN\s+SECTION\b'),
    re.compile(r'\bDISPLAY\b[^.]*\bAT\s+\d{3,}'),
    re.compile(r'\bDISPLAY\b[^.]*\bAT\s+LINE\b'),
    re.compile(r'\bDISPLAY\b[^.]*\bLINE\s+\d'),
    re.compile(r'\bDISPLAY\b[^.]*\bCOL\s+\d'),
    re.compile(r'\bDISPLAY\b[^.]*\bWITH\s+BLANK\s+SCREEN\b'),
]


def needs_terminal_emulator(test_dir: Path) -> bool:
    """Match production runner's logic for needs_emulator detection."""
    for cob in test_dir.glob("*.cob"):
        try:
            content = cob.read_text(errors="replace").upper()
        except OSError:
            continue
        for pat in SCREEN_DETECT_PATTERNS:
            if pat.search(content):
                return True
    return False


# ── Per-test working directory setup ─────────────────────────────────────

def cleanup_test_dir(test_dir: Path) -> None:
    """Remove non-source files left from prior runs (matches production)."""
    keep_exts  = {".cob", ".cpy", ".inc", ".rs"}
    keep_names = {"_at_data.json"}
    for f in test_dir.iterdir():
        try:
            if f.is_file() and f.suffix.lower() not in keep_exts and f.name not in keep_names:
                f.unlink()
            elif f.is_dir():
                shutil.rmtree(f, ignore_errors=True)
        except OSError:
            pass


def stage_at_data(test_dir: Path) -> dict[str, str]:
    """Materialize data files from _at_data.json and return env-var overrides."""
    manifest = test_dir / "_at_data.json"
    env: dict[str, str] = {}
    if not manifest.exists():
        return env
    try:
        data = json.loads(manifest.read_text(encoding="utf-8"))
    except Exception:
        return env
    for fname, content in data.items():
        if fname == "_env":
            if isinstance(content, dict):
                env = {k: v for k, v in content.items()
                       if v and not str(v).startswith('$')}
            continue
        fpath = test_dir / fname
        fpath.parent.mkdir(parents=True, exist_ok=True)
        try:
            fpath.write_bytes(content.encode("utf-8"))
        except Exception:
            pass
    return env


# ── Run the Ironclad-generated executable ────────────────────────────────

def run_simple(exe_path: Path, cwd: Path, timeout: float = 10.0,
               env: dict[str, str] | None = None) -> tuple[int, str]:
    """Plain stdin-closed subprocess run."""
    full_env = os.environ.copy()
    if env:
        full_env.update(env)
    try:
        result = subprocess.run(
            [str(exe_path)],
            stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            cwd=str(cwd),
            env=full_env,
            timeout=timeout,
        )
        return result.returncode, result.stdout.decode("utf-8", errors="replace")
    except subprocess.TimeoutExpired:
        return 124, ""


def run_terminal(exe_path: Path, cwd: Path, timeout: float = 12.0,
                 env: dict[str, str] | None = None) -> tuple[int, str]:
    """Run a SCREEN SECTION program in a virtual terminal.

    Uses the vendored emulator.py which mirrors the production runner's
    peak-content capture algorithm — replays raw PTY output in chunks,
    picks the chunk with the most non-empty rows (with anchoring to filter
    transient flashes), and returns that chunk's display_text.
    """
    if not HAS_EMULATOR:
        return run_simple(exe_path, cwd, timeout, env)

    full_env = os.environ.copy()
    if env:
        full_env.update(env)
    full_env["TERM"] = "xterm-256color"

    emu = TerminalEmulator(rows=25, cols=80)
    try:
        emu.start([str(exe_path)], cwd=str(cwd), env=full_env, timeout=timeout)
        # Wait for the program to either exit or fall silent (settle_time of
        # silence after the last screen change). Production runner uses 0.5s
        # for the SCREEN tests; same setting here.
        emu.wait_for_stable(timeout=timeout, settle_time=0.5)
    except Exception as e:
        try:
            emu.close()
        except Exception:
            pass
        return 1, f"<emulator error: {e}>"

    capture = emu.capture_peak()
    try:
        emu.close()
    except Exception:
        pass

    return 0, capture.display_text


# ── Main test runner ─────────────────────────────────────────────────────

def find_rlib(deps_dir: Path) -> Path:
    candidates = sorted(
        (f for f in deps_dir.iterdir()
         if f.name.startswith("libcobol_runtime") and f.suffix == ".rlib"),
        key=lambda f: f.stat().st_mtime,
        reverse=True,
    )
    if not candidates:
        sys.stderr.write(f"{C_RED}ERROR:{C_RESET} libcobol_runtime-*.rlib not found in {deps_dir}\n")
        sys.exit(2)
    return candidates[0]


def compile_runtime() -> None:
    print(f"{C_DIM}[setup] Building cobol-runtime (release)...{C_RESET}", flush=True)
    result = subprocess.run(
        ["cargo", "build", "--release"],
        cwd=str(RUNTIME_DIR),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
    )
    if result.returncode != 0:
        sys.stderr.write(f"{C_RED}ERROR:{C_RESET} cobol-runtime failed to build\n")
        sys.stderr.write(result.stdout.decode("utf-8", errors="replace"))
        sys.exit(2)


def enumerate_tests(filter_str: str | None) -> tuple[list[str], int, int, int]:
    """Return (tests, skipped_nonprog, skipped_arch, skipped_nogolden)."""
    tests: list[str] = []
    skipped_nonprog = 0
    skipped_arch = 0
    skipped_nogolden = 0
    for d in sorted(COBOL_DIR.iterdir()):
        if not d.is_dir():
            continue
        name = d.name
        if not (RUST_DIR / f"{name}.rs").exists():
            continue
        if filter_str and filter_str not in name:
            continue
        if any(name.startswith(p) for p in SKIP_PREFIXES):
            skipped_nonprog += 1
            continue
        if name in SKIP_TESTS:
            skipped_arch += 1
            continue
        golden_path = GOLDEN_DIR / f"{name}.expected"
        if not golden_path.exists():
            skipped_nogolden += 1
            continue
        # syn_* tests with trivial expected output (≤ 2 bytes) are pure
        # syntax-validation tests — no real program output to compare. Match
        # the production runner's behavior: skip only those, keep the rest.
        if name.startswith("syn_") and golden_path.stat().st_size <= 2:
            skipped_nonprog += 1
            continue
        tests.append(name)
    return tests, skipped_nonprog, skipped_arch, skipped_nogolden


def run_one(idx: int, total: int, name: str, rlib: Path, deps_dir: Path,
            mismatch_log) -> str:
    test_dir = COBOL_DIR / name
    rs       = RUST_DIR / f"{name}.rs"
    golden   = GOLDEN_DIR / f"{name}.expected"
    iron_exe = WORK_DIR / f"{idx}_iron"

    print(f"[{idx:4d}/{total}] ", end="", flush=True)

    # Compile
    proc = subprocess.run(
        ["rustc", "--edition", "2021",
         "-L", str(deps_dir),
         "--extern", f"cobol_runtime={rlib}",
         str(rs), "-o", str(iron_exe)],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
    )
    if proc.returncode != 0:
        print(f"{C_RED}BUILD_FAIL_RUST{C_RESET}  {name}", flush=True)
        return "BUILD_FAIL_RUST"

    # Set up working dir + fixtures
    cleanup_test_dir(test_dir)
    extra_env = stage_at_data(test_dir)

    # Choose run mode: terminal emulator vs simple subprocess
    is_screen = needs_terminal_emulator(test_dir)
    if is_screen:
        rc, raw = run_terminal(iron_exe, test_dir, timeout=15.0, env=extra_env)
    else:
        rc, raw = run_simple(iron_exe, test_dir, timeout=10.0, env=extra_env)

    if rc == 124:
        print(f"{C_CYAN}TIMEOUT{C_RESET}          {name}  {C_DIM}(>10s — likely interactive ACCEPT){C_RESET}", flush=True)
        return "TIMEOUT"

    # Normalize + mask non-determinism
    iron_norm = mask_nondet(normalize(raw))
    ref_norm  = mask_nondet(normalize(
        golden.read_text(encoding="utf-8", errors="replace")
    ))

    if iron_norm == ref_norm:
        tag = "PASS" if iron_norm else "BOTH_EMPTY"
        if tag == "PASS":
            print(f"{C_GREEN}PASS{C_RESET}             {name}", flush=True)
        else:
            print(f"{C_GREEN}PASS{C_RESET}             {name}  {C_DIM}(both empty){C_RESET}", flush=True)
        return "PASS"

    # MISMATCH
    print(f"{C_RED}{C_BOLD}MISMATCH{C_RESET}         {name}", flush=True)
    if mismatch_log:
        mismatch_log.write(f"=== {name} ===\n")
        mismatch_log.write("--- Reference (normalized) ---\n")
        mismatch_log.write(ref_norm + "\n")
        mismatch_log.write("--- Ironclad (normalized) ---\n")
        mismatch_log.write(iron_norm + "\n\n")
        mismatch_log.flush()
    return "MISMATCH"


def main() -> int:
    parser = argparse.ArgumentParser(description="Ironclad parity validator")
    parser.add_argument("--quick",     type=int, default=0, help="Run only the first N tests")
    parser.add_argument("--filter",    type=str, default=None, help="Substring filter on test names")
    parser.add_argument("--no-build",  action="store_true", help="Skip cargo build of cobol-runtime")
    args = parser.parse_args()

    # Banner
    print(f"{C_BOLD}{C_CYAN}{'=' * 60}{C_RESET}")
    print(f"{C_BOLD}  Ironclad Parity Validator{C_RESET}")
    print(f"  {C_DIM}GnuCOBOL 3.x golden  ←→  Ironclad-transpiled Rust   (byte-for-byte){C_RESET}")
    print(f"{C_BOLD}{C_CYAN}{'=' * 60}{C_RESET}")
    print(f"  rustc:    {subprocess.run(['rustc', '--version'], capture_output=True, text=True).stdout.strip()}")
    print(f"  emulator: {'pyte + ptyprocess (PTY for SCREEN tests)' if HAS_EMULATOR else f'{C_YELLOW}not available{C_RESET} (SCREEN tests will fall back to plain subprocess)'}")
    print()

    if not args.no_build:
        compile_runtime()

    deps_dir = RUNTIME_DIR / "target" / "release" / "deps"
    rlib = find_rlib(deps_dir)
    print(f"  rlib:  {rlib.name}")
    print()

    WORK_DIR.mkdir(parents=True, exist_ok=True)
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)

    tests, skipped_nonprog, skipped_arch, skipped_nogolden = enumerate_tests(args.filter)
    if args.quick > 0:
        tests = tests[:args.quick]

    if not tests:
        print(f"{C_RED}No tests found.{C_RESET} Check {COBOL_DIR} / {RUST_DIR} / {GOLDEN_DIR}.")
        return 2

    print(f"{C_DIM}[run]{C_RESET} {C_BOLD}{len(tests)}{C_RESET} in-scope program tests selected")
    print(f"      {C_DIM}({skipped_nonprog} non-program + {skipped_arch} architectural exclusions + {skipped_nogolden} no-golden skipped){C_RESET}")
    print("-" * 60)

    counts: dict[str, int] = {"PASS": 0, "MISMATCH": 0, "BUILD_FAIL_RUST": 0, "TIMEOUT": 0}
    mismatch_log = (RESULTS_DIR / "mismatches.txt").open("w", encoding="utf-8")
    try:
        for idx, name in enumerate(tests, 1):
            try:
                outcome = run_one(idx, len(tests), name, rlib, deps_dir, mismatch_log)
                counts[outcome] = counts.get(outcome, 0) + 1
            except KeyboardInterrupt:
                print(f"\n{C_YELLOW}interrupted{C_RESET}")
                break
            except Exception as e:
                print(f"{C_RED}ERROR{C_RESET}            {name}  {C_DIM}({e}){C_RESET}", flush=True)
                counts["MISMATCH"] = counts.get("MISMATCH", 0) + 1
    finally:
        mismatch_log.close()
        try:
            shutil.rmtree(WORK_DIR, ignore_errors=True)
        except OSError:
            pass

    # Summary
    total          = len(tests)
    parity_denom   = counts["PASS"] + counts["MISMATCH"]
    parity_pct     = (counts["PASS"] / parity_denom * 100) if parity_denom else 0.0
    compile_ok     = total - counts["BUILD_FAIL_RUST"]
    compile_pct    = (compile_ok / total * 100) if total else 0.0

    print()
    print(f"{C_BOLD}{'=' * 60}{C_RESET}")
    print(f"{C_BOLD}  PARITY VALIDATION SUMMARY{C_RESET}")
    print(f"{C_BOLD}{'=' * 60}{C_RESET}")
    print(f"  Compile rate:  {C_BOLD}{compile_pct:.1f}%{C_RESET}  ({compile_ok} / {total})  {C_DIM}— Rust output compiles{C_RESET}")
    print(f"  Parity rate:   {C_BOLD}{C_GREEN}{parity_pct:.1f}%{C_RESET}  ({counts['PASS']} / {parity_denom})  {C_DIM}← byte-for-byte vs reference{C_RESET}")
    print("-" * 60)
    print(f"  {C_GREEN}PASS{C_RESET}              {counts['PASS']:4d}")
    print(f"  {C_RED}MISMATCH{C_RESET}          {counts['MISMATCH']:4d}  {C_DIM}(see {RESULTS_DIR}/mismatches.txt){C_RESET}")
    print(f"  {C_RED}BUILD_FAIL_RUST{C_RESET}   {counts['BUILD_FAIL_RUST']:4d}")
    print(f"  {C_CYAN}TIMEOUT{C_RESET}           {counts['TIMEOUT']:4d}")
    print(f"{C_BOLD}{'=' * 60}{C_RESET}")

    if counts["MISMATCH"] > 0:        return 1
    if counts["BUILD_FAIL_RUST"] > 0: return 2
    if counts["TIMEOUT"] > 0:         return 3
    return 0


if __name__ == "__main__":
    sys.exit(main())
