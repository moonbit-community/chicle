///|
test "upstream/generated/block/block_absolute_layout_within_border" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=length(0.0), right=auto(), top=length(0.0), bottom=auto()),
    ),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_position(position_absolute())
    .with_size(Size::new(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_inset(
      Rect::new(left=auto(), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let root_style = Style::default()
    .with_display(display_block())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect::new(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
  let root = taffy.new_with_children(root_style, [node0, node1, node2, node3])
  taffy.compute_layout(root, Size::max_content())
  let l0 = taffy.layout(node0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.location.x, 40.0)
  assert_eq(l1.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.location.x, 30.0)
  assert_eq(l3.location.y, 30.0)
}
