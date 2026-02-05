///|
test "measure_child_with_flex_grow (upstream: generated/flex/measure_child_with_flex_grow.rs)" {
  let taffy : TaffyTree[TextMeasure] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(50.0), height=length(50.0)),
    ),
  )
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "H\u{200B}H\u{200B}H\u{200B}H\u{200B}H",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size::new(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 50.0)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}
