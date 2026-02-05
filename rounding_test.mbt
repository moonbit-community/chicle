///|
test "rounding_doesnt_leave_gaps" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let w_square = Size::new(width=length(100.3), height=length(100.3))
  let child_a = taffy.new_leaf(Style::default().with_size(w_square))
  let child_b = taffy.new_leaf(Style::default().with_size(w_square))
  let root_style = Style::default()
    .with_size(Size::new(width=length(963.3333), height=length(1000.0)))
    .with_justify_content(justify_content_center())
  let root = taffy.new_with_children(root_style, [child_a, child_b])
  taffy.compute_layout(root, Size::max_content())
  let layout_a = taffy.layout(child_a)
  let layout_b = taffy.layout(child_b)
  assert_eq(layout_a.location.x + layout_a.size.width, layout_b.location.x)
}
