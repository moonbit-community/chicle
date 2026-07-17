#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
WASM_PATH="$ROOT_DIR/_build/wasm-gc/release/build/cmd/playground_wasm/playground_wasm.wasm"
DIST_DIR="$ROOT_DIR/dist"

cd "$ROOT_DIR"
moon build --target wasm-gc --release

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"
cp "$ROOT_DIR/site/index.html" "$DIST_DIR/index.html"
cp "$ROOT_DIR/site/styles.css" "$DIST_DIR/styles.css"
cp "$ROOT_DIR/site/app.js" "$DIST_DIR/app.js"
cp "$WASM_PATH" "$DIST_DIR/chicle.wasm"
touch "$DIST_DIR/.nojekyll"

echo "Built GitHub Pages artifact at $DIST_DIR"
