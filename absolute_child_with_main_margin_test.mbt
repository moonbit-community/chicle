///|
test "absolute_child_with_main_margin (upstream: generated/flex/absolute_child_with_main_margin.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size::new(width=length(9.0), height=length(9.0)))
    .with_margin(
      Rect::new(
        left=length(7.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(20.0), height=length(37.0)),
    ),
    [child],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 20.0)
  assert_eq(layout.size.height, 37.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let c = taffy.layout(child)
  assert_eq(c.size.width, 9.0)
  assert_eq(c.size.height, 9.0)
  assert_eq(c.location.x, 7.0)
  assert_eq(c.location.y, 0.0)
}
