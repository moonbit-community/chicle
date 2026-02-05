///|
test "flex_grow_to_min (upstream: generated/flex/flex_grow_to_min.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size::new(width=length(100.0), height=auto()))
    .with_min_size(Size::new(width=auto(), height=length(100.0)))
    .with_max_size(Size::new(width=auto(), height=length(500.0))),
    [node0, node1],
  )
  fn zero_measure(
    _known_dimensions : Size[Double?],
    _available_space : Size[AvailableSpace],
    _node_id : NodeId,
    _context : Unit?,
    _style : Style,
  ) -> Size[Double] {
    Size::zero()
  }

  taffy.compute_layout_with_measure(node, Size::max_content(), zero_measure)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let layout0 = taffy.layout(node0)
  assert_eq(layout0.size.width, 100.0)
  assert_eq(layout0.size.height, 50.0)
  assert_eq(layout0.location.x, 0.0)
  assert_eq(layout0.location.y, 0.0)
  let layout1 = taffy.layout(node1)
  assert_eq(layout1.size.width, 100.0)
  assert_eq(layout1.size.height, 50.0)
  assert_eq(layout1.location.x, 0.0)
  assert_eq(layout1.location.y, 50.0)
}
