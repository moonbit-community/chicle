///|
test "toggle_root_display_none" {
  let hidden_style = Style::default()
    .with_display(display_none())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
  let flex_style = Style::default()
    .with_display(display_flex())
    .with_size(Size::new(width=length(100.0), height=length(100.0)))
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(hidden_style)
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
  taffy.set_style(node, flex_style)
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 100.0)
  taffy.set_style(node, hidden_style)
  taffy.compute_layout(node, Size::max_content())
  let layout = taffy.layout(node)
  assert_eq(layout.location.x, 0.0)
  assert_eq(layout.location.y, 0.0)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
}

///|
test "toggle_root_display_none_with_children" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let child_style = Style::default().with_size(
    Size::new(width=length(800.0), height=length(100.0)),
  )
  let child = taffy.new_leaf(child_style)
  let parent_style = Style::default().with_size(
    Size::new(width=length(800.0), height=length(100.0)),
  )
  let parent = taffy.new_with_children(parent_style, [child])
  let root = taffy.new_with_children(Style::default(), [parent])
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.layout(child).size.width, 800.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
  taffy.set_style(root, Style::default().with_display(display_none()))
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.layout(child).size.width, 0.0)
  assert_eq(taffy.layout(child).size.height, 0.0)
  taffy.set_style(root, Style::default())
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.layout(child).size.width, 800.0)
  assert_eq(taffy.layout(child).size.height, 100.0)
}
