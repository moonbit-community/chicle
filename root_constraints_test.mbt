///|
test "root_with_percentage_size" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=percent(1.0), height=percent(1.0)),
    ),
  )
  taffy.compute_layout(
    node,
    Size::new(
      width=available_space_definite(100.0),
      height=available_space_definite(200.0),
    ),
  )
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 100.0)
  assert_eq(layout.size.height, 200.0)
}

///|
test "root_with_no_size" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(Style::default())
  taffy.compute_layout(
    node,
    Size::new(
      width=available_space_definite(100.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 0.0)
  assert_eq(layout.size.height, 0.0)
}

///|
test "root_with_larger_size" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let node = taffy.new_leaf(
    Style::default().with_size(
      Size::new(width=length(200.0), height=length(200.0)),
    ),
  )
  taffy.compute_layout(
    node,
    Size::new(
      width=available_space_definite(100.0),
      height=available_space_definite(100.0),
    ),
  )
  let layout = taffy.layout(node)
  assert_eq(layout.size.width, 200.0)
  assert_eq(layout.size.height, 200.0)
}

///|
test "root_padding_and_border_larger_than_definite_size" {
  let tree : TaffyTree[Unit] = TaffyTree::with_capacity(16)
  let child = tree.new_leaf(Style::default())
  let root_style = Style::default()
    .with_size(Size::new(width=length(10.0), height=length(10.0)))
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
  let root = tree.new_with_children(root_style, [child])
  tree.compute_layout(root, Size::max_content())
  let layout = tree.layout(root)
  assert_eq(layout.size.width, 40.0)
  assert_eq(layout.size.height, 40.0)
}
