// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_auto" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_auto.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 40.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 40.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 10.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([fit_content(length(50.0))]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 40.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 40.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 10.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_middle.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([fit_content(length(30.0))]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 30.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 30.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 30.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_fit_content_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([fit_content(length(10.0))]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 20.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 20.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_larger" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_larger.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([length(50.0)]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 50.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 50.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 10.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_middle" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_middle.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([length(30.0)]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 30.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 30.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 30.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fixed_smaller.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([length(10.0)]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 10.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 10.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 10.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_fr" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_fr.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([fr(1.0)]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 40.0)
  assert_eq(l_node.size.height, 10.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 40.0)
  assert_eq(l_node0.size.height, 10.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 40.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 10.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_max_content" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_max_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_min_content()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 20.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 20.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_block_in_grid_min_content" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_block_in_grid_min_content.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_display(display_block()),
    TextMeasure::{ text_content: "HH\u{200B}HH", writing_mode: Horizontal },
  )
  let node1 = taffy.new_leaf(Style::default().with_display(display_block()))
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([grid_min_content()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 20.0)
  assert_eq(l_node.size.height, 20.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l_node0 = taffy.layout(node0)
  assert_eq(l_node0.size.width, 20.0)
  assert_eq(l_node0.size.height, 20.0)
  assert_eq(l_node0.location.x, 0.0)
  assert_eq(l_node0.location.y, 0.0)
  let l_node1 = taffy.layout(node1)
  assert_eq(l_node1.size.width, 20.0)
  assert_eq(l_node1.size.height, 0.0)
  assert_eq(l_node1.location.x, 0.0)
  assert_eq(l_node1.location.y, 20.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_grid_in_block" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_grid_in_block.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node00],
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 200.0)
  assert_eq(l_node.size.height, 70.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 50.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_collapse_through_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 40.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 0.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 30.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_first_child_collapse_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 10.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 50.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid" {
  // Ported from taffy-reference/tests/generated/blockgrid/blockgrid_margin_y_last_child_collapse_blocked_by_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 50.0)
  assert_eq(l_node.size.height, 30.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 50.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/blockgrid/mod" {
  // Upstream mod.rs only declares submodules; no standalone runnable vector.
  ()
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_aspect_ratio_overrides_height_of_full_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 360.0)
  assert_eq(l0.size.height, 120.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=percent(0.05), right=auto(), top=percent(0.05), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 67.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_height_from_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_height_from_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(
        left=percent(0.1),
        right=percent(0.1),
        top=percent(0.05),
        bottom=auto(),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 320.0)
  assert_eq(l0.size.height, 107.0)
  assert_eq(l0.location.x, 40.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 17.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_position(position_absolute())
    .with_max_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
    TextMeasure::{
      text_content: "HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH\u{200B}HHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 25.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_height" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size(width=length(50.0), height=auto()))
    .with_aspect_ratio(3.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 17.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_min_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_min_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(0.5),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 25.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=percent(0.2)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=percent(0.05), right=auto(), top=percent(0.05), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 180.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 15.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_fill_width_from_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_fill_width_from_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 180.0)
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/absolute_aspect_ratio_height_overrides_inset" {
  // Ported from taffy-reference/tests/generated/flex/absolute_aspect_ratio_height_overrides_inset.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let l_node = taffy.layout(node)
  assert_eq(l_node.size.width, 400.0)
  assert_eq(l_node.size.height, 300.0)
  assert_eq(l_node.location.x, 0.0)
  assert_eq(l_node.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 90.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
}
