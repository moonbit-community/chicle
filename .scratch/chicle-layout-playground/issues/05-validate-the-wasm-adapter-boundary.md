# Validate the Wasm Adapter boundary

Type: task
Status: resolved
Blocked by: 04

## Question

Using a minimal throwaway MoonBit build spike, what browser-target artifact, export declaration, JavaScript loading sequence, and string ABI are actually produced when the Wasm Adapter exposes only `compute_layout_json`?

## Answer

The adapter is a `wasm-gc`-only linked package exporting one public `compute_layout_json` function. `use-js-builtin-string` and the `_` imported-string namespace expose MoonBit strings as JavaScript strings. The release build produces a standalone Wasm module that was instantiated successfully in Node and Chromium.
