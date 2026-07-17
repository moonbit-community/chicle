Label: wayfinder:map
Status: resolved

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
- [Define the Layout Document contract](issues/02-define-the-layout-document-contract.md) — chose a versioned nested-node JSON document with unique ids, optional labels, partial Style values, and available-space constraints.
- [Define the Layout Result and error contract](issues/03-define-the-layout-result-and-error-contract.md) — returns stable per-node layout metadata in a success/error JSON envelope.
- [Place the generic JSON API](issues/04-place-the-generic-json-api.md) — placed typed contracts and computation in the root Chicle package for every backend.
- [Validate the Wasm Adapter boundary](issues/05-validate-the-wasm-adapter-boundary.md) — verified a Wasm-GC `String -> String` export using JavaScript string builtins.
- [Prototype the DOM Projection](issues/06-prototype-the-dom-projection.md) — projects relative node geometry into nested absolute DOM boxes without browser measurement feedback.
- [Define editor, error, and URL state](issues/07-define-editor-error-and-url-state.md) — updates after 150 ms and replaces the Base64URL fragment only after valid computation.
- [Choose the teaching examples](issues/08-choose-the-teaching-examples.md) — includes editable Flex, Grid, and absolute-positioning examples.
- [Prototype the responsive accessible shell](issues/09-prototype-the-responsive-accessible-shell.md) — uses labeled controls, keyboard focus styles, and a stacked narrow-screen layout.
- [Define the validation gates](issues/10-define-the-validation-gates.md) — requires four-backend MoonBit gates, Wasm instantiation, browser interaction, URL restoration, console, and responsive checks.
- [Define Pages build and deployment](issues/11-define-pages-build-and-deployment.md) — builds a dependency-free artifact and deploys every relevant `main` update through GitHub Actions.

## Not yet specified

None for v1.

## Out of scope

- Executing or editing MoonBit source code in the page.
- A custom layout DSL alongside JSON.
- Server-side storage, accounts, collaboration, or short-link infrastructure.
- Intrinsic text/content measurement and serializable runtime measurement callbacks in v1.
- A general-purpose visual layout editor, drag-and-drop authoring, or browser devtools replacement.
