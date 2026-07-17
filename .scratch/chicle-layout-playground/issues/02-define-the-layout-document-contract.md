# Define the Layout Document contract

Type: grilling
Status: resolved

## Question

What exact v1 JSON shape represents a layout tree, node identity and labels, every public Style field, available-space constraints, defaults, and invalid input while remaining independent of the playground and Wasm?

## Answer

Version 1 is a nested `root` node document. Every node has a unique non-empty `id`, an optional `label` defaulting to its id, an optional partial `style` inheriting `Style::default()`, and optional `children`. `available_space.width` and `height` accept numbers, `MinContent`, or `MaxContent`. The contract is owned by the root Chicle package.
