# Milky2018/moon_taffy

MoonBit port (in-progress) of the Rust crate **taffy** (UI layout engine).

- Upstream pinned: `taffy v0.5.2` (see `UPSTREAM.md`)
- Current status: very small compatibility slice (enough for initial upstream tests)

## Quick start

```mbt check
///|
test {
  let taffy : @Milky2018/moon_taffy.TaffyTree[Unit] = @Milky2018/moon_taffy.TaffyTree::new()
  let child = taffy.new_leaf(@Milky2018/moon_taffy.Style::default())
  let root = taffy.new_with_children(
    @Milky2018/moon_taffy.Style::default().with_size(
      @Milky2018/moon_taffy.Size::new(
        width=@Milky2018/moon_taffy.length(100.0),
        height=@Milky2018/moon_taffy.length(100.0),
      ),
    ),
    [child],
  )
  taffy.compute_layout(root, @Milky2018/moon_taffy.Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
}
```
