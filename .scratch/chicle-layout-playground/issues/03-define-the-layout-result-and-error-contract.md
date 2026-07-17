# Define the Layout Result and error contract

Type: grilling
Status: resolved
Blocked by: 02

## Question

What stable JSON shape should return node geometry and public layout metadata, preserve the relationship to Layout Document nodes, and distinguish parse, validation, tree, and layout failures for all backends?

## Answer

Successful responses contain `ok: true` and a result with `root_id` plus pre-order nodes carrying `id`, `label`, `parent_id`, `depth`, and every public `Layout` metadata field. Failures contain `ok: false` with a stable `kind` and message. Parse and input failures are distinguished from layout failures.
