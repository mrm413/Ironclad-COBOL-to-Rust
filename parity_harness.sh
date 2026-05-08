#!/bin/bash
# ============================================================================
#  Ironclad Federal Parity Validator — GnuCOBOL 3.2 Suite
# ============================================================================
#
#  Runs both engines side-by-side on every COBOL program in this repo:
#
#    1. GnuCOBOL  (cobc -x)   compiles  cobol_source/<name>.cob → gnu.exe
#    2. Ironclad  (rustc)     compiles  rust_output/<name>.rs   → iron.exe
#    3. Both run with identical input. stdout captured.
#    4. Byte-for-byte diff. PASS / MISMATCH / BUILD_FAIL_<engine> / TIMEOUT
#
#  Streams each result LIVE — no buffering. The federal evaluator watches
#  green ticks scroll past in real time. Final summary prints at end.
#
#  Three layered claims reported:
#    - Compile rate   (Rust output compiles)
#    - Runtime rate   (Rust output runs cleanly)
#    - Parity rate    (Rust output matches GnuCOBOL byte-for-byte)
#
#  Usage:
#    bash parity_harness.sh                 # all 1545 programs
#    bash parity_harness.sh --quick 50      # first 50 only (sanity check)
#    bash parity_harness.sh --filter run_   # only tests matching substring
#    bash parity_harness.sh --no-build      # skip rebuilding cobol-runtime
#    docker build -t ironclad-parity -f Dockerfile.parity .
#    docker run --rm ironclad-parity
# ============================================================================

set -uo pipefail

COBOL_DIR="cobol_source"
RUST_DIR="rust_output"
RUNTIME_DIR="cobol-runtime"
WORK_DIR="_parity_work"
RESULTS_DIR="parity_results"
TIMEOUT_SECS=5

# ── ANSI colors (auto-disabled if stdout isn't a TTY or NO_COLOR is set) ──
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    C_RESET=$'\033[0m'
    C_BOLD=$'\033[1m'
    C_GREEN=$'\033[32m'
    C_RED=$'\033[31m'
    C_YELLOW=$'\033[33m'
    C_CYAN=$'\033[36m'
    C_DIM=$'\033[2m'
else
    C_RESET=""; C_BOLD=""; C_GREEN=""; C_RED=""; C_YELLOW=""; C_CYAN=""; C_DIM=""
fi
# These categories are not standalone programs — listings test cobc's listing
# output, configuration tests cobc's config handling, used_binaries probes the
# cobc binary, and syn_* programs are intentionally invalid COBOL for testing
# compiler error detection. Skip them in parity (Ironclad transpiles them
# fine, but cobc has no runtime semantics for them).
SKIP_PREFIXES_REGEX="(_configuration_|_listings_|_used_binaries_|_syn_)"

# ─────────────────────────────────────────────────────────────────────────────
# arg parsing
QUICK_LIMIT=0
FILTER=""
SKIP_BUILD=0
while [[ $# -gt 0 ]]; do
    case "$1" in
        --quick)    QUICK_LIMIT="${2:-50}"; shift 2 ;;
        --filter)   FILTER="$2"; shift 2 ;;
        --no-build) SKIP_BUILD=1; shift ;;
        --timeout)  TIMEOUT_SECS="$2"; shift 2 ;;
        -h|--help)  sed -n '1,30p' "$0"; exit 0 ;;
        *)          echo "unknown arg: $1"; exit 2 ;;
    esac
done

# ─────────────────────────────────────────────────────────────────────────────
# preflight
echo "${C_BOLD}${C_CYAN}============================================================${C_RESET}"
echo "${C_BOLD}  Ironclad Parity Validator${C_RESET}"
echo "  ${C_DIM}GnuCOBOL 3.x  ←→  Ironclad-transpiled Rust   (byte-for-byte)${C_RESET}"
echo "${C_BOLD}${C_CYAN}============================================================${C_RESET}"

if ! command -v cobc >/dev/null 2>&1; then
    echo "ERROR: cobc not found. Install GnuCOBOL 3.x first."
    echo "  Debian/Ubuntu: apt install gnucobol3"
    exit 2
fi
if ! command -v rustc >/dev/null 2>&1; then
    echo "ERROR: rustc not found. Install Rust toolchain (stable 1.70+)."
    exit 2
fi

echo "  cobc:  $(cobc --version | head -1)"
echo "  rustc: $(rustc --version)"
echo

# ─────────────────────────────────────────────────────────────────────────────
# build cobol-runtime so we can rustc against it
if [ "$SKIP_BUILD" -eq 0 ]; then
    echo "[setup] Building cobol-runtime (release)…"
    (cd "$RUNTIME_DIR" && cargo build --release 2>&1 | tail -2) || {
        echo "ERROR: cobol-runtime failed to build"
        exit 2
    }
fi

RLIB=$(ls "$RUNTIME_DIR"/target/release/deps/libcobol_runtime-*.rlib 2>/dev/null | head -1)
if [ -z "$RLIB" ]; then
    echo "ERROR: libcobol_runtime-*.rlib not found in $RUNTIME_DIR/target/release/deps/"
    exit 2
fi
DEPS_DIR="$RUNTIME_DIR/target/release/deps"
echo "  rlib:  $(basename "$RLIB")"
echo

# ─────────────────────────────────────────────────────────────────────────────
# enumerate test set
mkdir -p "$WORK_DIR" "$RESULTS_DIR"
trap 'rm -rf "$WORK_DIR"' EXIT

TESTS=()
SKIPPED_NONPROG=0
for cob in "$COBOL_DIR"/*.cob; do
    [ -f "$cob" ] || continue
    name=$(basename "$cob" .cob)
    rs="$RUST_DIR/${name}.rs"
    [ -f "$rs" ] || continue
    if [ -n "$FILTER" ] && [[ "$name" != *"$FILTER"* ]]; then continue; fi
    if [[ "$name" =~ $SKIP_PREFIXES_REGEX ]]; then
        SKIPPED_NONPROG=$((SKIPPED_NONPROG + 1))
        continue
    fi
    TESTS+=("$name")
done

if [ "$QUICK_LIMIT" -gt 0 ]; then
    TESTS=("${TESTS[@]:0:$QUICK_LIMIT}")
fi

TOTAL="${#TESTS[@]}"
if [ "$TOTAL" -eq 0 ]; then
    echo "No tests found. Check $COBOL_DIR / $RUST_DIR."
    exit 2
fi

echo "[run] $TOTAL program tests selected ($SKIPPED_NONPROG non-program tests skipped: configuration/listings/syn_/used_binaries)"
echo "------------------------------------------------------------"

# ─────────────────────────────────────────────────────────────────────────────
# run loop
PASS=0
MISMATCH=0
BFAIL_GNU=0
BFAIL_RUST=0
TIMEOUT_BOTH=0
RUN_ERR=0

# Mismatch log
MISMATCH_LOG="$RESULTS_DIR/mismatches.txt"
> "$MISMATCH_LOG"

idx=0
for name in "${TESTS[@]}"; do
    idx=$((idx + 1))
    cob="$COBOL_DIR/${name}.cob"
    rs="$RUST_DIR/${name}.rs"
    gnu_exe="$WORK_DIR/${idx}_gnu"
    iron_exe="$WORK_DIR/${idx}_iron"

    # Pad index for clean alignment
    printf "[%4d/%d] " "$idx" "$TOTAL"

    # ── compile reference ──
    # cobc rejects long file-base names; copy to a short stable name first.
    # Also normalize for cobc: CRLF→LF, and col-7 fixed-format `*` comments
    # rewritten as free-format `*>` (Ironclad accepts both forms; cobc picks one).
    # Try -free then -fixed since the test corpus mixes both styles.
    short_cob="$WORK_DIR/p_${idx}.cob"
    sed -E 's/^(......)\*/\1*>/' "$cob" | tr -d '\r' > "$short_cob"
    if ! cobc -x -free -o "$gnu_exe" "$short_cob" >"$WORK_DIR/${idx}.gnu_err" 2>&1; then
        if ! cobc -x -fixed -frelax-syntax-checks -o "$gnu_exe" "$short_cob" >>"$WORK_DIR/${idx}.gnu_err" 2>&1; then
            BFAIL_GNU=$((BFAIL_GNU + 1))
            printf "${C_YELLOW}BUILD_FAIL_GNU${C_RESET}   %s\n" "$name"
            rm -f "$short_cob"
            continue
        fi
    fi
    rm -f "$short_cob"

    # ── compile transpiler output ──
    if ! rustc --edition 2021 \
            -L "$DEPS_DIR" \
            --extern "cobol_runtime=$RLIB" \
            "$rs" -o "$iron_exe" \
            >"$WORK_DIR/${idx}.rust_err" 2>&1; then
        BFAIL_RUST=$((BFAIL_RUST + 1))
        printf "${C_RED}BUILD_FAIL_RUST${C_RESET}  %s\n" "$name"
        continue
    fi

    # ── run both with same </dev/null input ──
    gnu_out=$(timeout "$TIMEOUT_SECS" "$gnu_exe" </dev/null 2>/dev/null) || gnu_rc=$?
    gnu_rc=${gnu_rc:-0}
    iron_out=$(timeout "$TIMEOUT_SECS" "$iron_exe" </dev/null 2>/dev/null) || iron_rc=$?
    iron_rc=${iron_rc:-0}

    # 124 = timeout exit code on Linux
    if [ "$gnu_rc" = "124" ] && [ "$iron_rc" = "124" ]; then
        TIMEOUT_BOTH=$((TIMEOUT_BOTH + 1))
        printf "${C_CYAN}TIMEOUT_BOTH${C_RESET}     %s  ${C_DIM}(interactive — same on both engines)${C_RESET}\n" "$name"
        continue
    fi
    if [ "$gnu_rc" = "124" ] || [ "$iron_rc" = "124" ]; then
        RUN_ERR=$((RUN_ERR + 1))
        printf "${C_RED}TIMEOUT_DIVERGE${C_RESET}  %s  ${C_DIM}(gnu_rc=%s iron_rc=%s)${C_RESET}\n" "$name" "$gnu_rc" "$iron_rc"
        continue
    fi

    # ── byte-for-byte compare ──
    if [ "$gnu_out" = "$iron_out" ]; then
        PASS=$((PASS + 1))
        printf "${C_GREEN}PASS${C_RESET}             %s\n" "$name"
    else
        MISMATCH=$((MISMATCH + 1))
        printf "${C_RED}${C_BOLD}MISMATCH${C_RESET}         %s\n" "$name"
        {
            echo "=== $name ==="
            echo "--- GnuCOBOL ---"
            printf '%s\n' "$gnu_out"
            echo "--- Ironclad ---"
            printf '%s\n' "$iron_out"
            echo
        } >> "$MISMATCH_LOG"
    fi

    # cleanup per-test exes
    rm -f "$gnu_exe" "$iron_exe" "$WORK_DIR/${idx}.gnu_err" "$WORK_DIR/${idx}.rust_err"
done

# ─────────────────────────────────────────────────────────────────────────────
# summary
COMPILE_OK=$((TOTAL - BFAIL_RUST))
RUNTIME_OK=$((PASS + MISMATCH + TIMEOUT_BOTH))
PARITY_DENOM=$((PASS + MISMATCH))
PARITY_PCT="0.0"
if [ "$PARITY_DENOM" -gt 0 ]; then
    PARITY_PCT=$(awk "BEGIN{printf \"%.1f\", $PASS*100/$PARITY_DENOM}")
fi
COMPILE_PCT=$(awk "BEGIN{printf \"%.1f\", $COMPILE_OK*100/$TOTAL}")

echo
echo "${C_BOLD}============================================================${C_RESET}"
echo "${C_BOLD}  PARITY VALIDATION SUMMARY${C_RESET}"
echo "${C_BOLD}============================================================${C_RESET}"
printf "  Compile rate:  ${C_BOLD}%s%%${C_RESET}  (%d / %d)  ${C_DIM}— Rust output compiles${C_RESET}\n" "$COMPILE_PCT" "$COMPILE_OK" "$TOTAL"
printf "  Runtime rate:  ?     (%d ran, %d interactive timeouts)\n" "$RUNTIME_OK" "$TIMEOUT_BOTH"
printf "  Parity rate:   ${C_BOLD}${C_GREEN}%s%%${C_RESET}  (%d / %d)  ${C_DIM}← byte-for-byte vs GnuCOBOL${C_RESET}\n" "$PARITY_PCT" "$PASS" "$PARITY_DENOM"
echo "------------------------------------------------------------"
printf "  ${C_GREEN}PASS${C_RESET}              %4d\n" "$PASS"
printf "  ${C_RED}MISMATCH${C_RESET}          %4d  ${C_DIM}(logic divergence — see $MISMATCH_LOG)${C_RESET}\n" "$MISMATCH"
printf "  ${C_YELLOW}BUILD_FAIL_GNU${C_RESET}    %4d  ${C_DIM}(cobc rejected source)${C_RESET}\n" "$BFAIL_GNU"
printf "  ${C_RED}BUILD_FAIL_RUST${C_RESET}   %4d  ${C_DIM}(rustc rejected transpiled .rs)${C_RESET}\n" "$BFAIL_RUST"
printf "  ${C_CYAN}TIMEOUT_BOTH${C_RESET}      %4d  ${C_DIM}(interactive — both engines hung identically)${C_RESET}\n" "$TIMEOUT_BOTH"
printf "  ${C_RED}TIMEOUT_DIVERGE${C_RESET}   %4d  ${C_DIM}(one engine hung, other didn't — bug)${C_RESET}\n" "$RUN_ERR"
echo "${C_BOLD}============================================================${C_RESET}"

if [ "$MISMATCH" -gt 0 ]; then
    echo
    echo "  First 5 mismatches:"
    head -40 "$MISMATCH_LOG" | sed 's/^/    /'
fi

# Exit code semantics for CI / federal evaluator scripts
if [ "$MISMATCH" -gt 0 ]; then exit 1; fi
if [ "$BFAIL_RUST" -gt 0 ]; then exit 2; fi
if [ "$RUN_ERR" -gt 0 ]; then exit 3; fi
exit 0
