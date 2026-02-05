///|
test "upstream/generated/block/block_absolute_layout_width_height_start_top" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child_style = Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect::new(
        left=length(10.0),
        right=auto(),
        top=length(10.0),
        bottom=auto(),
      ),
    )
  let child = taffy.new_leaf(child_style)
  let root_style = Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
  let root = taffy.new_with_children(root_style, [child])
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 100.0)
  assert_eq(root_layout.size.height, 100.0)
  assert_eq(root_layout.location.x, 0.0)
  assert_eq(root_layout.location.y, 0.0)
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 10.0)
  assert_eq(layout.size.height, 10.0)
  assert_eq(layout.location.x, 10.0)
  assert_eq(layout.location.y, 10.0)
}
