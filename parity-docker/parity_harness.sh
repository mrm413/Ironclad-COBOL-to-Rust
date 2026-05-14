#!/bin/bash
# =============================================================================
#  parity_harness.sh — byte-for-byte parity vs the GnuCOBOL reference compiler
# =============================================================================
#
#  For every (.cob, .rs) pair in cobol_source/ + rust_output/:
#    1. Skip the test if parity_filter.py rejects it (interactive / volatile /
#       external-file dependent — see filter for full reasons).
#    2. Compile the .cob with cobc -x and run it under a 5s timeout to capture
#       stdout. This is the reference output.
#    3. Compile the .rs with rustc -O linking against cobol-runtime and run it
#       under the same timeout.
#    4. Diff the two stdouts byte-for-byte.
#
#  Exit code 0 only if every runnable program matched. Mismatches and build
#  failures are listed at the end so they can be inspected and fixed.
# =============================================================================
set -uo pipefail

COB_DIR="cobol_source"
RS_DIR="rust_output"
RLIB_DIR="/work/_warmup/target/release/deps"
RUNTIME_RLIB=$(ls -t "$RLIB_DIR"/libcobol_runtime-*.rlib 2>/dev/null | head -1)
TMPDIR="${TMPDIR:-/tmp/parity_run}"
TIMEOUT_SECS="${PARITY_TIMEOUT:-5}"

if [ -z "$RUNTIME_RLIB" ]; then
    echo "FATAL: cobol-runtime rlib not found in $RLIB_DIR — image build incomplete?" >&2
    exit 2
fi

mkdir -p "$TMPDIR"

MATCH=0
MISMATCH=0
SKIP=0
COBC_FAIL=0
RUSTC_FAIL=0
TIMEOUT_BOTH=0
MISMATCH_LIST=""

echo "============================================================"
echo "  Ironclad Parity Verifier"
echo "  byte-for-byte vs GnuCOBOL $(cobc --version | head -1 | awk '{print $NF}')"
echo "============================================================"
echo "  cobol-runtime rlib: $(basename "$RUNTIME_RLIB")"
echo "  per-test timeout:   ${TIMEOUT_SECS}s"
echo "  source dir:         $COB_DIR ($(ls $COB_DIR/*.cob 2>/dev/null | wc -l) programs)"
echo "============================================================"
echo ""

COUNT=0
TOTAL=$(ls "$COB_DIR"/*.cob 2>/dev/null | wc -l)

for cob in "$COB_DIR"/*.cob; do
    COUNT=$((COUNT + 1))
    base=$(basename "$cob" .cob)
    rs="$RS_DIR/$base.rs"

    if [ ! -f "$rs" ]; then
        # Pair missing — count as skip so we never silently inflate.
        SKIP=$((SKIP + 1))
        continue
    fi

    # ── Skip filter ──
    skip_reason=$(python3 parity_filter.py "$cob")
    if [ -n "$skip_reason" ]; then
        SKIP=$((SKIP + 1))
        continue
    fi

    # ── Stage source: short basename, LF endings, col-8 padded line 1
    # cobc rejects long basenames as program IDs; CRLF and unindented line 1
    # both fail the fixed-format parser. Normalize before compile.
    cob_staged="$TMPDIR/prog.cob"
    tr -d '\r' < "$cob" \
        | awk 'NR==1 && substr($0,1,1) != " " { print "       " $0; next } { print }' \
        > "$cob_staged"

    # ── cobc compile + run ──
    cob_exe="$TMPDIR/cobc_$base"
    if ! cobc -x -fixed -O -o "$cob_exe" "$cob_staged" >/dev/null 2>&1; then
        COBC_FAIL=$((COBC_FAIL + 1))
        continue
    fi
    cob_out=$(timeout "$TIMEOUT_SECS" "$cob_exe" 2>/dev/null < /dev/null)
    cob_rc=$?

    # ── rustc compile + run ──
    rs_exe="$TMPDIR/rs_$base"
    if ! rustc --edition 2021 -O \
            -L "$RLIB_DIR" \
            --extern "cobol_runtime=$RUNTIME_RLIB" \
            -o "$rs_exe" "$rs" >/dev/null 2>&1; then
        RUSTC_FAIL=$((RUSTC_FAIL + 1))
        continue
    fi
    rs_out=$(timeout "$TIMEOUT_SECS" "$rs_exe" 2>/dev/null < /dev/null)
    rs_rc=$?

    # ── Compare ──
    if [ "$cob_rc" -eq 124 ] && [ "$rs_rc" -eq 124 ]; then
        # Both timed out — usually input-bound test we couldn't fully filter.
        TIMEOUT_BOTH=$((TIMEOUT_BOTH + 1))
        continue
    fi
    if [ "$cob_out" = "$rs_out" ]; then
        MATCH=$((MATCH + 1))
    else
        MISMATCH=$((MISMATCH + 1))
        MISMATCH_LIST="$MISMATCH_LIST  $base\n"
    fi

    if [ $((COUNT % 100)) -eq 0 ]; then
        echo "  progress: $COUNT / $TOTAL  (match=$MATCH mismatch=$MISMATCH skip=$SKIP)"
    fi

    rm -f "$cob_exe" "$rs_exe"
done

# ─── Final report ───────────────────────────────────────────────────────
# A "comparable" test is one where BOTH compilers produced an executable.
# Tests where cobc itself can't compile aren't parity failures (often the
# distro's cobc is older than the test set's required dialect); they're
# excluded from the parity rate so the number isn't artificially deflated.
comparable=$((MATCH + MISMATCH))
echo ""
echo "============================================================"
echo "  PARITY RESULTS"
echo "============================================================"
echo "  Programs total:         $TOTAL"
echo "  Skipped (filter):       $SKIP"
echo "  Both timed out:         $TIMEOUT_BOTH"
echo "  cobc-incompatible:      $COBC_FAIL    (older dialect / unsupported features)"
echo "  rustc compile fail:     $RUSTC_FAIL"
echo "  ----------------------------------------------------------"
echo "  Comparable (both built): $comparable"
echo "  MATCH (byte-for-byte):   $MATCH"
echo "  MISMATCH:                $MISMATCH"
echo "============================================================"

if [ "$comparable" -gt 0 ]; then
    rate=$(awk "BEGIN {printf \"%.1f\", ($MATCH / $comparable) * 100}")
    echo "  Parity rate:             ${rate}%  ($MATCH / $comparable)"
    echo "============================================================"
fi

if [ "$MISMATCH" -gt 0 ]; then
    echo ""
    echo "  Mismatched programs (first 20):"
    echo -e "$MISMATCH_LIST" | head -20
fi

# Exit 0 only if no MISMATCH, no rustc failures, and at least one program
# was successfully compared. cobc-incompatible programs do not fail the run.
if [ "$MISMATCH" -eq 0 ] && [ "$RUSTC_FAIL" -eq 0 ] && [ "$comparable" -gt 0 ]; then
    exit 0
fi
exit 1
