///|
test "absolute_inset_left_top (github:issue#1 repro)" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let root_style = Style::default()
    .with_display(display_flex())
    .with_position(position_relative())
    .with_size(Size::new(width=length(800.0), height=length(600.0)))
  let child_style = Style::default()
    .with_position(position_absolute())
    .with_inset(
      Rect::new(
        left=length(40.0),
        right=auto(),
        top=length(50.0),
        bottom=auto(),
      ),
    )
    .with_size(Size::new(width=length(200.0), height=length(60.0)))
  let child = taffy.new_leaf(child_style)
  let root = taffy.new_with_children(root_style, [child])
  taffy.compute_layout(
    root,
    Size::new(
      width=available_space_definite(800.0),
      height=available_space_definite(600.0),
    ),
  )
  let layout = taffy.layout(child)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 60.0)
  assert_eq(layout.location.x, 40.0)
  assert_eq(layout.location.y, 50.0)
}
