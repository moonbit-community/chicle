Label: wayfinder:map

## Destination

A decision-complete implementation brief for a dependency-free Chicle GitHub Pages playground: editable JSON on the left, a live DOM Layout Preview on the right, and a shareable URL. The route must define the generic JSON contracts, thin Wasm Adapter, browser behavior, examples, validation, and deployment well enough that implementation can begin without product or architecture guesses.

## Notes

- This is a planning map. It produces decisions and implementation guidance, not the playground itself.
- Domain terms live in [`CONTEXT.md`](../../CONTEXT.md).
- Sessions should consult `wayfinder`, `grilling`, `domain-modeling`, and `moonbit-agent-guide`; prototype tickets additionally use `prototype`.
- Keep the JSON Layout API backend-independent. The Wasm Adapter only exposes it to the browser.
- Refer to tickets by their linked names rather than their numbers.

## Decisions so far

- [Set the playground product boundary](issues/01-set-the-playground-product-boundary.md) — fixed the two-pane JSON experience, generic API boundary, thin Wasm export, live Share URL, full public Style coverage, and v1 measurement boundary.

## Not yet specified

- Schema evolution and migration policy after the v1 Layout Document shape is known.
- Share URL size handling after representative examples reveal realistic document sizes.
- The exact visual regression fixtures and browser support matrix after the DOM Projection is prototyped.
- Whether playground deployment should follow every `main` update or only selected release points.

## Out of scope

- Executing or editing MoonBit source code in the page.
- A custom layout DSL alongside JSON.
- Server-side storage, accounts, collaboration, or short-link infrastructure.
- Intrinsic text/content measurement and serializable runtime measurement callbacks in v1.
- A general-purpose visual layout editor, drag-and-drop authoring, or browser devtools replacement.
