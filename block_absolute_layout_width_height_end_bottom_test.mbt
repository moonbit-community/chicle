///|
test "upstream/generated/block/block_absolute_layout_width_height_end_bottom" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child_style = Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=auto(),
        right=length(10.0),
        top=auto(),
        bottom=length(10.0),
      ),
    )
  let child = taffy.new_leaf(child_style)
  let root_style = Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
  let root = taffy.new_with_children(root_style, [child])
  taffy.compute_layout(root, Size::max_content())
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 10.0)
  assert_eq(layout.size.height, 10.0)
  assert_eq(layout.location.x, 80.0)
  assert_eq(layout.location.y, 80.0)
}
