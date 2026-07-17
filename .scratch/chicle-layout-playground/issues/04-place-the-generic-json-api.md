# Place the generic JSON API

Type: grilling
Status: resolved
Blocked by: 02, 03

## Question

Which Chicle package owns `LayoutDocument`, `LayoutResult`, their JSON conversions, and `compute_layout_json`, and which parts of that API are public so native, JavaScript, and future backends share one implementation without adding browser concerns to the layout engine?

## Answer

The module root package owns the public `LayoutNode`, `LayoutDocument`, `LayoutResultNode`, `LayoutResult`, typed computation, and string convenience API. It imports the focused geometry, style, and tree packages but contains no DOM or Wasm-specific behavior.
