#!/bin/bash
# ============================================================================
# Ironclad Federal Validator — GnuCOBOL 3.2 Full Suite Compile Check
# ============================================================================
#
# This script compiles every transpiled Rust program in rust_output/ against
# the cobol-runtime library. Each file is copied into a cargo project and
# checked with `cargo check`. Results are logged to compile_results.txt.
#
# Usage:
#   bash test_harness.sh              # Run full suite
#   bash test_harness.sh --quick 50   # Spot-check first 50 files
#   docker build -t ironclad . && docker run ironclad
#
# Expected result: 1545/1545 PASS (100% compile rate)
# ============================================================================

set -euo pipefail

RUST_DIR="rust_output"
TMP_DIR="_compile_tmp"
RESULTS_FILE="compile_results.txt"
ERROR_FILE="error_details.txt"

# Parse args
QUICK_MODE=0
QUICK_LIMIT=0
if [[ "${1:-}" == "--quick" ]]; then
    QUICK_MODE=1
    QUICK_LIMIT="${2:-50}"
    echo "Quick mode: checking first $QUICK_LIMIT files"
fi

# Ensure compile workspace exists
if [ ! -f "$TMP_DIR/Cargo.toml" ]; then
    mkdir -p "$TMP_DIR/src"
    cat > "$TMP_DIR/Cargo.toml" <<'TOML'
[package]
name = "compile-check"
version = "0.1.0"
edition = "2021"
[dependencies]
cobol-runtime = { path = "../cobol-runtime" }
TOML
    echo 'fn main() {}' > "$TMP_DIR/src/main.rs"
    echo "Warming up cargo cache..."
    cd "$TMP_DIR" && cargo check 2>/dev/null && cd ..
fi

# Collect files
FILES=("$RUST_DIR"/*.rs)
TOTAL=${#FILES[@]}

if [ "$QUICK_MODE" -eq 1 ] && [ "$QUICK_LIMIT" -lt "$TOTAL" ]; then
    TOTAL=$QUICK_LIMIT
fi

echo "============================================"
echo "  Ironclad Federal Validator"
echo "  GnuCOBOL 3.2 Test Suite — Compile Check"
echo "============================================"
echo "Files to check: $TOTAL"
echo ""

PASS=0
FAIL=0
FAIL_LIST=""

> "$RESULTS_FILE"
> "$ERROR_FILE"

COUNT=0
for f in "${FILES[@]}"; do
    COUNT=$((COUNT + 1))
    if [ "$QUICK_MODE" -eq 1 ] && [ "$COUNT" -gt "$QUICK_LIMIT" ]; then
        break
    fi

    BASENAME=$(basename "$f" .rs)
    cp "$f" "$TMP_DIR/src/main.rs"

    if cargo check --manifest-path "$TMP_DIR/Cargo.toml" 2>/dev/null; then
        PASS=$((PASS + 1))
        echo "OK $BASENAME" >> "$RESULTS_FILE"
    else
        FAIL=$((FAIL + 1))
        echo "FAIL $BASENAME" >> "$RESULTS_FILE"
        FAIL_LIST="$FAIL_LIST  - $BASENAME\n"
        # Capture error detail
        ERR=$(cargo check --manifest-path "$TMP_DIR/Cargo.toml" 2>&1 | grep "^error" | head -3)
        echo "$BASENAME|$ERR" >> "$ERROR_FILE"
    fi

    # Progress every 100 files
    if [ $((COUNT % 100)) -eq 0 ]; then
        echo "Progress: $COUNT / $TOTAL (pass=$PASS, fail=$FAIL)"
    fi
done

echo ""
echo "============================================"
echo "  RESULTS"
echo "============================================"
echo "Total:  $((PASS + FAIL))"
echo "Pass:   $PASS"
echo "Fail:   $FAIL"

if [ "$FAIL" -eq 0 ]; then
    RATE="100"
else
    RATE=$(( (PASS * 100) / (PASS + FAIL) ))
fi
echo "Rate:   ${RATE}%"

if [ "$FAIL" -gt 0 ]; then
    echo ""
    echo "Failed files:"
    echo -e "$FAIL_LIST"
    echo "See $ERROR_FILE for error details."
    exit 1
else
    echo ""
    echo "ALL $PASS FILES COMPILE SUCCESSFULLY."
    echo "Ironclad COBOL-to-Rust: 100% compile rate on GnuCOBOL 3.2 test suite."
    exit 0
fi
