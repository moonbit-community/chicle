# Milky2018/chicle

MoonBit UI layout engine.

受 taffy 启发。

- Public API: import the focused packages directly: `geometry`, `style`, `style_helpers`, and `tree`.

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
