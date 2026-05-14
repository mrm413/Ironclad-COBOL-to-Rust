# =============================================================================
#  Ironclad Parity Verifier — byte-for-byte vs GnuCOBOL reference compiler
# =============================================================================
#
#  Builds a fresh Ubuntu 22.04 image with the official `gnucobol` apt package
#  and a stable Rust toolchain, then runs every paired (.cob, .rs) program
#  side-by-side and compares stdout byte-for-byte.
#
#  This is the strongest claim in the repo: not "matches what we wrote down as
#  expected" but "matches what `apt install gnucobol` + `cobc -x prog.cob &&
#  ./prog` produces, on a fresh container with no Ironclad-written goldens."
#
#  Build:  docker build -t ironclad-parity -f parity-docker/Dockerfile .
#  Run:    docker run --rm ironclad-parity
#
#  The harness is filtered to programs that run headless (no ACCEPT-stdin, no
#  required data files, no volatile DATE/TIME without explicit FROM, etc.)
#  Final report: total runnable / total matched / mismatched names.
# =============================================================================
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV COB_UNIX_LF=1

# Reference compiler from the distro repo — no custom builds, no patches.
# This is the same gnucobol that any Ubuntu 22.04 user gets with `apt install`.
RUN apt-get update && apt-get install -y --no-install-recommends \
        gnucobol \
        build-essential \
        coreutils \
        python3 \
        curl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Stable Rust (matches the runtime crate's MSRV).
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- -y --default-toolchain stable --profile minimal
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /work

# Copy runtime, transpiled programs, and original COBOL side-by-side.
COPY cobol-runtime/ ./cobol-runtime/
COPY cobol_source/  ./cobol_source/
COPY rust_output/   ./rust_output/
COPY parity-docker/parity_harness.sh ./parity_harness.sh
COPY parity-docker/parity_filter.py  ./parity_filter.py
RUN chmod +x parity_harness.sh

# Pre-build the cobol-runtime crate so per-test rustc invocations link fast.
RUN mkdir -p /work/_warmup/src \
    && printf '[package]\nname = "warmup"\nversion = "0.1.0"\nedition = "2021"\n[dependencies]\ncobol-runtime = { path = "/work/cobol-runtime" }\n' \
        > /work/_warmup/Cargo.toml \
    && echo 'fn main() {}' > /work/_warmup/src/main.rs \
    && cd /work/_warmup && cargo build --release && cd /

CMD ["bash", "parity_harness.sh"]
