# Define the validation gates

Type: grilling
Status: resolved
Blocked by: 03, 05, 07, 09

## Question

Which automated checks and representative fixtures are sufficient to protect generic JSON round trips, cross-target layout equivalence, the Wasm export, DOM Projection, real-time error recovery, Share URL restoration, accessibility, and the production Pages artifact?

## Answer

The release gates are `moon check` with warning 73, all tests on wasm/wasm-gc/js/native, `moon info`, static artifact assembly, JavaScript syntax checking, direct Wasm instantiation, and Playwright checks for all examples, live edits, invalid-input recovery, Unicode URL restoration, console errors, desktop rendering, and narrow-screen layout.
