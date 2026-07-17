# Define Pages build and deployment

Type: grilling
Status: resolved
Blocked by: 05, 09, 10

## Question

What repository layout, MoonBit build command, static artifact assembly, GitHub Actions workflow, Pages source, cache policy, and deployment trigger should publish a reproducible playground without adding runtime dependencies?

## Answer

`scripts/build-pages.sh` builds the release Wasm-GC adapter and assembles `site/` plus `chicle.wasm` into ignored `dist/`. The Pages workflow verifies every MoonBit backend, builds the artifact, uploads it with the official Pages action, and deploys on relevant changes to `main` or manual dispatch.
