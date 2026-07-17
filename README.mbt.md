# Milky2018/chicle

MoonBit UI layout engine.

受 taffy 启发。

[Open the interactive Chicle playground](https://moonbit-community.github.io/chicle/) to edit a JSON layout document and see the WebAssembly-computed layout update immediately. Valid documents are stored in the URL fragment, so every layout can be shared directly.

- Public API: import the focused packages directly: `geometry`, `style`, `style_helpers`, and `tree`.

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
