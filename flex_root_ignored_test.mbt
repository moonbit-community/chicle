///|
test "flex_root_ignored" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_basis(length(200.0)),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size::new(width=length(100.0), height=auto()))
    .with_min_size(Size::new(width=auto(), height=length(100.0)))
    .with_max_size(Size::new(width=auto(), height=length(500.0))),
    [node0, node1],
  )
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 300.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let layout0 = taffy.layout(node0)
  assert_eq(layout0.size.width, 100.0)
  assert_eq(layout0.size.height, 200.0)
  assert_eq(layout0.location.x, 0.0)
  assert_eq(layout0.location.y, 0.0)
  let layout1 = taffy.layout(node1)
  assert_eq(layout1.size.width, 100.0)
  assert_eq(layout1.size.height, 100.0)
  assert_eq(layout1.location.x, 0.0)
  assert_eq(layout1.location.y, 200.0)
}
