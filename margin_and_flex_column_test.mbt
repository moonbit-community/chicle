///|
test "margin_and_flex_column (upstream: generated/flex/margin_and_flex_column.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_margin(
      Rect::new(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let layout0 = taffy.layout(node0)
  assert_eq(layout0.size.width, 100.0)
  assert_eq(layout0.size.height, 80.0)
  assert_eq(layout0.location.x, 0.0)
  assert_eq(layout0.location.y, 10.0)
}
