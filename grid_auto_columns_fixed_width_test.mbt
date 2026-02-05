///|
test "upstream/generated/grid/grid_auto_columns_fixed_width" {
  let taffy : TaffyTree[Unit] = TaffyTree::new()
  let children : Array[NodeId] = []
  for _ in 0..<16 {
    children.push(taffy.new_leaf(Style::default()))
  }
  let root_style = Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), auto(), length(40.0), auto()])
    .with_grid_template_columns([length(40.0), auto(), length(40.0), auto()])
    .with_size(Size::new(width=length(200.0), height=length(200.0)))
  let root = taffy.new_with_children(root_style, children)
  taffy.compute_layout(root, Size::max_content())
  let col_w = [40.0, 60.0, 40.0, 60.0]
  let row_h = [40.0, 60.0, 40.0, 60.0]
  let col_x = [0.0, 40.0, 100.0, 140.0]
  let row_y = [0.0, 40.0, 100.0, 140.0]
  for i in 0..<16 {
    let row = i / 4
    let col = i % 4
    let node_id = children[i]
    let layout = taffy.layout(node_id)
    assert_eq(layout.size.width, col_w[col])
    assert_eq(layout.size.height, row_h[row])
    assert_eq(layout.location.x, col_x[col])
    assert_eq(layout.location.y, row_y[row])
  }
}
