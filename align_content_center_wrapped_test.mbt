///|
test "align_content_center_wrapped (upstream: generated/flex/align_content_center_wrapped.rs)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let mk = fn() {
    taffy.new_leaf(
      Style::default().with_size(
        Size::new(width=length(50.0), height=length(10.0)),
      ),
    )
  }
  let node0 = mk()
  let node1 = mk()
  let node2 = mk()
  let node3 = mk()
  let node4 = mk()
  let node5 = mk()
  let root = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_center())
    .with_size(Size::new(width=length(120.0), height=length(100.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(root)
  assert_eq(layout.size.width, 120.0)
  assert_eq(layout.size.height, 100.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 35.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 35.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 45.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 45.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 55.0)
  let l5 = taffy.layout(node5)
  assert_eq(l5.location.x, 50.0)
  assert_eq(l5.location.y, 55.0)
}
