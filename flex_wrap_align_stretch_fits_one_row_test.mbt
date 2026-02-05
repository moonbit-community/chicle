///|
test "flex_wrap_align_stretch_fits_one_row (upstream: generated/flex/flex_wrap_align_stretch_fits_one_row.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size::new(width=length(50.0), height=auto())),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size::new(width=length(150.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 150.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}
