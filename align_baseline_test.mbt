///|
test "align_baseline (upstream: generated/flex/align_baseline.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(20.0)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_baseline())
    .with_size(Size::new(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 30.0)
}

///|
test "align_self_baseline (upstream: generated/flex/align_self_baseline.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size::new(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(10.0)),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size::new(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default().with_size(
      Size::new(width=length(100.0), height=length(100.0)),
    ),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}
