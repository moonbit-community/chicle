# Milky2018/chicle

MoonBit port of the Rust crate **taffy** (UI layout engine).

- Upstream pinned: `taffy v0.5.2` (see `UPSTREAM.md`)
- Current status: generated upstream layout tests and top-level compatibility tests are ported and passing in MoonBit.
- Public API: import the focused packages directly: `geometry`, `style`, `style_helpers`, and `tree`.

## Quick start

```mbt check
///|
test {
  let taffy : @Milky2018/chicle/tree.TaffyTree[Unit] = @Milky2018/chicle/tree.TaffyTree()
  let child = taffy.new_leaf(@Milky2018/chicle/style.Style::default())
  let root = taffy.new_with_children(
    @Milky2018/chicle/style.Style::default().with_size(
      @Milky2018/chicle/geometry.Size(
        width=@Milky2018/chicle/style_helpers.length(100.0),
        height=@Milky2018/chicle/style_helpers.length(100.0),
      ),
    ),
    [child],
  )
  taffy.compute_layout(root, @Milky2018/chicle/geometry.Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
}
```
