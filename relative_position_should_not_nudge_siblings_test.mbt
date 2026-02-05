///|
test "relative_position_should_not_nudge_siblings (upstream: generated/flex/relative_position_should_not_nudge_siblings.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child_style = Style::default()
    .with_size(Size::new(width=auto(), height=length(10.0)))
    .with_inset(
      Rect::new(left=auto(), right=auto(), top=length(15.0), bottom=auto()),
    )
  let node0 = taffy.new_leaf(child_style)
  let node1 = taffy.new_leaf(child_style)
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 15.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 25.0)
}
