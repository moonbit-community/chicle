///|
test "wrap_row (upstream: generated/flex/wrap_row.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(31.0), height=length(30.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(32.0), height=length(30.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(33.0), height=length(30.0)),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(34.0), height=length(30.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size::new(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 60.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 31.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 32.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 31.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 33.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 63.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 34.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 30.0)
}
