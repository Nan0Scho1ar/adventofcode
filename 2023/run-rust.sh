#!/usr/bin/env sh
# Rebuild and rerun any time rust source file for that project changes.
# E.G. ./run-rust.sh day-01

echo -e "Cargo.toml\n$1/main.rs"  | entr sh -c "cargo build --bin $1; cargo run --bin $1"
