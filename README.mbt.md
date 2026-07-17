# Milky2018/chicle

MoonBit UI layout engine.

[Open the interactive Chicle playground](https://moonbit-community.github.io/chicle/) to edit a compact YAML layout document and see the WebAssembly-computed layout update immediately. Valid documents are stored in the URL fragment, so every layout can be shared directly.

- Public API: import the focused packages directly: `geometry`, `style`, `style_helpers`, and `tree`.
- Inspired by [taffy](https://github.com/dioxusLabs/taffy).

## Compact YAML layout API

The root package parses a concise authoring format and converts it to the same typed `LayoutDocument` used by the JSON API:

- `LayoutDocument::from_yaml` parses compact YAML.
- `compute_layout_yaml` parses, computes, and returns the same JSON result envelope as `compute_layout_json`.

```yaml
space: [640, 360]
layout:
  Dashboard:
    size: [320, 180]
    padding: 16
    gap: { column: 12 }
    children:
      - Sidebar:
          width: 100
      - Content:
          grow: 1
```

A node is a single-key mapping whose key becomes its unique ID. `label` defaults to that ID, and ordered `children` contain more nodes. Numbers represent lengths; strings such as `50%`, `1fr`, `auto`, `min-content`, and `max-content` represent other dimensions. Common fields include `size`, `width`, `height`, `padding`, `gap`, `flow`, `grow`, `align`, `grid`, `place`, and `absolute`. Advanced callers can use a canonical `style` object instead of compact style fields.

## JSON layout API

The root package provides a backend-independent JSON API for tools and foreign-function boundaries:

- `LayoutDocument::from_json` parses a typed layout document.
- `compute_layout_document` computes a typed `LayoutResult`.
- `LayoutResult::to_json` serializes node geometry and metadata.
- `compute_layout_json` is the `String -> String` convenience API exported by the browser Wasm adapter.

Each document contains a `root` node, optional `available_space`, and nested `children`. A node has a unique `id`, an optional display `label`, and a partial `style`; omitted style fields inherit `Style::default()`.

## Quick start

```mbt check
///|
test {
  let chicle : @Milky2018/chicle/tree.ChicleTree[Unit] = @Milky2018/chicle/tree.ChicleTree()
  let child = chicle.new_leaf(@Milky2018/chicle/style.Style::default())
  let root = chicle.new_with_children(
    @Milky2018/chicle/style.Style::default().with_size(
      @Milky2018/chicle/geometry.Size(
        width=@Milky2018/chicle/style_helpers.length(100.0),
        height=@Milky2018/chicle/style_helpers.length(100.0),
      ),
    ),
    [child],
  )
  chicle.compute_layout(root, @Milky2018/chicle/geometry.Size::max_content())
  let layout = chicle.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
}
```
