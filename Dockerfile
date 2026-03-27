FROM rust:1.82-slim

# timeout is in coreutils (already present in Debian slim)
RUN apt-get update && apt-get install -y --no-install-recommends coreutils && rm -rf /var/lib/apt/lists/*

WORKDIR /ironclad

# Copy runtime library and all generated Rust programs
COPY cobol-runtime/ cobol-runtime/
COPY rust_output/ rust_output/

# Copy test harness
COPY test_harness.sh .

# Pre-build runtime dependency cache (compile + build)
RUN mkdir -p _compile_tmp/src && \
    printf '[package]\nname = "compile-check"\nversion = "0.1.0"\nedition = "2021"\n\n[dependencies]\ncobol-runtime = { path = "../cobol-runtime" }' \
    > _compile_tmp/Cargo.toml && \
    echo 'fn main() {}' > _compile_tmp/src/main.rs && \
    cd _compile_tmp && cargo build 2>/dev/null && cd ..

CMD ["bash", "test_harness.sh"]
