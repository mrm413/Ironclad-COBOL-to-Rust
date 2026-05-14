# Parity Verifier (Docker)

This directory contains a self-contained Docker harness that proves
**byte-for-byte stdout equivalence** between the GnuCOBOL reference compiler
(`cobc` from Ubuntu's `gnucobol` apt package) and the Ironclad-transpiled
Rust output.

This is the strongest claim in the repo. It's not "matches what we wrote down
as expected." It's "matches what `apt install gnucobol` + `cobc -x prog.cob &&
./prog` produces, run on a fresh container with no Ironclad-written goldens."

## Run it

```bash
# from the repo root
docker build -t ironclad-parity -f parity-docker/Dockerfile .
docker run --rm ironclad-parity
```

If `docker build` fails at `apt-get update` with "Could not resolve
'archive.ubuntu.com'" (Docker Desktop on some Windows/WSL2 setups uses an
internal DNS forwarder that doesn't proxy outbound DNS), use a buildx
builder with explicit DNS:

```bash
cat > /tmp/buildkitd.toml <<EOF
[dns]
nameservers = ["8.8.8.8", "1.1.1.1"]
EOF
docker buildx create --name dnsfix --driver docker-container \
    --config /tmp/buildkitd.toml --use
docker buildx build --builder dnsfix --load \
    -t ironclad-parity -f parity-docker/Dockerfile .
docker run --rm --dns 8.8.8.8 ironclad-parity
```

The harness runs every paired (`cobol_source/*.cob`, `rust_output/*.rs`)
program. For each pair it:

1. Skips the program if `parity_filter.py` rejects it (interactive ACCEPT,
   volatile DATE/TIME, EXEC SQL/CICS, or required external data files —
   none of those are parity failures, they're categories CI can't compare).
2. Compiles the `.cob` with `cobc -x -O`, runs it under a 5-second timeout,
   captures stdout — that's the **reference**.
3. Compiles the `.rs` with `rustc -O` linked against `cobol-runtime`, runs it
   under the same timeout, captures stdout — that's the **actual**.
4. Byte-compares the two.

Final report counts MATCH / MISMATCH / SKIP / cobc-fail / rustc-fail, prints
the parity rate, and lists mismatched program names so they're inspectable.
Exit code 0 only if every runnable program matched.

## What this proves

- The Rust output is functionally equivalent to GnuCOBOL's output on every
  test the parity environment can fairly run.
- Reproducible by anyone — no proprietary toolchain, no Ironclad-side
  goldens, no special runtime flags. `docker build && docker run`.
- Defensible at audit. The reference compiler comes from the upstream
  distribution package; nothing about the test setup favors Ironclad.

## What it does **not** prove

- Programs that need stdin (`ACCEPT user-name`) — filter skips them.
- Programs with volatile output (`ACCEPT FROM TIME`) — filter skips them.
- Programs that need data files (`SELECT … ASSIGN to-file`) — filter skips
  them in this minimal image. The CMS Medicare and CardDemo showcases run
  parity with their full data dependencies staged.
- DB2 / CICS programs — those live in their own showcase repos
  (cms-medicare-ironclad-showcase, ironclad-carddemo-showcase).

## Tuning

- `PARITY_TIMEOUT=10 docker run --rm -e PARITY_TIMEOUT ironclad-parity`
  to bump the per-test timeout (default 5s).
- Mount a results dir to keep the report:
  `docker run --rm -v $(pwd)/results:/work/results ironclad-parity`
