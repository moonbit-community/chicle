# Set the playground product boundary

Type: grilling
Status: resolved

## Question

What user experience, API layering, sharing behavior, style coverage, and measurement boundary define the Chicle GitHub Pages playground?

## Answer

- Publish a dependency-free static GitHub Pages playground with an editable JSON Layout Document on the left and a live DOM Layout Preview on the right.
- Recompute after edits and encode the last valid Layout Document into `#layout=<base64url>` after roughly 150 ms of debounce using `history.replaceState`.
- Invalid JSON or invalid layout input must not replace the last valid Share URL. Opening a Share URL restores both the editor and preview.
- JSON parsing and Layout Result serialization are generic Chicle capabilities available to every backend. The Wasm Adapter only exports the generic string convenience function to JavaScript.
- The intended API layers are a typed path (`LayoutDocument::from_json`, `compute_layout_document`, and `LayoutResult::to_json`) plus `compute_layout_json(String) -> String` for foreign-function boundaries.
- Layout Document v1 covers every public `Style` field supported by Chicle. Omitted fields inherit `Style::default()`; runtime-private state and caches are not serializable inputs.
- V1 has no intrinsic content measurement callback. Preview labels are decorative and never feed browser measurements back into Chicle.
