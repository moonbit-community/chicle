///|
test "vertical_padding_percentage_uses_width_as_basis" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(
    Style::default().with_padding(
      Rect::new(
        left=percent(1.0),
        right=length(0.0),
        top=percent(1.0),
        bottom=length(0.0),
      ),
    ),
  )
  taffy.compute_layout(
    node,
    Size::new(
      width=available_space_definite(200.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}
