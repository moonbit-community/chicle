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
test "upstream/generated/grid/grid_align_items_baseline_child" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 5.0, 5.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_margin_percent" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_margin_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0)))
    .with_margin(
      Rect(
        left=percent(0.01),
        right=percent(0.01),
        top=percent(0.01),
        bottom=percent(0.01),
      ),
    ),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 1.0, 1.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_flex_wrap(flex_wrap_wrap())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(50.0), height=auto())),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 40.0, 0.0, 60.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_no_override_on_secondline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 25.0, 0.0, 68.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_multiline_override" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_multiline_override.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node12 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(25.0), height=length(20.0))),
  )
  let node13 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(25.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(50.0), height=length(25.0))),
    [node10, node11, node12, node13],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 25.0, 0.0, 68.0)
  assert_layout_xywh(taffy, node10, 25.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node11, 25.0, 10.0, 25.0, 0.0)
  assert_layout_xywh(taffy, node12, 25.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node13, 25.0, 10.0, 25.0, 20.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0)))
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 5.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 5.0, 5.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_top" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 10.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_child_top2" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_child_top2.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0)))
    .with_inset(Rect(left=auto(), right=auto(), top=length(5.0), bottom=auto())),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 70.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_complex" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_complex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node60 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node6 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
    [node60],
  )
  let node70 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(5.0))),
  )
  let node7 = taffy.new_with_children(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
    [node70],
  )
  let node8 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7, node8],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 20.0, 40.0, 10.0)
  assert_layout_xywh(taffy, node10, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 20.0, 80.0, 10.0)
  assert_layout_xywh(taffy, node20, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 20.0, 20.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 20.0, 20.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node5, 20.0, 20.0, 80.0, 40.0)
  assert_layout_xywh(taffy, node6, 20.0, 20.0, 0.0, 90.0)
  assert_layout_xywh(taffy, node60, 0.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node7, 20.0, 20.0, 40.0, 95.0)
  assert_layout_xywh(taffy, node70, 0.0, 5.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node8, 20.0, 20.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_double_nested_child" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_double_nested_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(15.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 50.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 0.0, 65.0)
  assert_layout_xywh(taffy, node10, 50.0, 15.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 20.0, 50.0, 40.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 20.0, 0.0, 100.0)
  assert_layout_xywh(taffy, node20, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 50.0, 50.0, 60.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(30.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(40.0), height=length(70.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 30.0, 50.0, 50.0, 30.0)
  assert_layout_xywh(taffy, node10, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 70.0, 0.0, 90.0)
  assert_layout_xywh(taffy, node20, 10.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 20.0, 50.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_multiline_row_and_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_multiline_row_and_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node10],
  )
  let node20 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node20],
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(20.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_grid_template_columns([auto(), auto()])
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 50.0, 50.0, 50.0, 40.0)
  assert_layout_xywh(taffy, node10, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 50.0, 20.0, 0.0, 100.0)
  assert_layout_xywh(taffy, node20, 50.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 50.0, 20.0, 50.0, 90.0)
}

///|
test "upstream/generated/grid/grid_align_items_baseline_nested_column" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_baseline_nested_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node100 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(30.0))),
  )
  let node101 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(40.0))),
  )
  let node10 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(50.0), height=length(80.0))),
    [node100, node101],
  )
  let node1 = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node10],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_baseline())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 50.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 100.0, 80.0, 0.0, 60.0)
  assert_layout_xywh(taffy, node10, 50.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node100, 50.0, 30.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node101, 50.0, 40.0, 0.0, 35.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_center" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_center.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_center())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 10.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 70.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_end" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_end.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_end())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 60.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_start" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_start.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_start())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_items_sized_stretch" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_items_sized_stretch.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(1)
    .with_grid_column_start(1)
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row_start(3)
    .with_grid_column_start(3)
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_align_items(align_items_stretch())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 80.0, 80.0)
}

///|
test "upstream/generated/grid/grid_align_self_sized_all" {
  // Ported from taffy-reference/tests/generated/grid/grid_align_self_sized_all.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_start())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_end())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node5 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node6 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node7 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_stretch())
    .with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4, node5, node6, node7],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 60.0, 60.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 20.0, 80.0, 20.0)
  assert_layout_xywh(taffy, node3, 60.0, 60.0, 0.0, 20.0)
  assert_layout_xywh(taffy, node4, 20.0, 20.0, 40.0, 50.0)
  assert_layout_xywh(taffy, node5, 60.0, 60.0, 80.0, 30.0)
  assert_layout_xywh(taffy, node6, 20.0, 20.0, 0.0, 80.0)
  assert_layout_xywh(taffy, node7, 60.0, 60.0, 40.0, 80.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_aspect_ratio_overrides_height_of_full_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 360.0, 120.0, 20.0, 15.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_height_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 320.0, 107.0, 40.0, 15.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_fill_width_from_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 180.0, 60.0, 0.0, 90.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_height_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=auto(), height=percent(0.1)))
    .with_aspect_ratio(3.0)
    .with_inset(
      Rect(left=auto(), right=auto(), top=percent(0.3), bottom=percent(0.5)),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 90.0, 30.0, 0.0, 90.0)
}

///|
test "upstream/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset" {
  // Ported from taffy-reference/tests/generated/grid/grid_aspect_ratio_absolute_width_overrides_inset.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_position(position_absolute())
    .with_size(Size(width=percent(0.4), height=auto()))
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
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(400.0), height=length(300.0))),
    [node0],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_layout_xywh(taffy, root, 400.0, 300.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 160.0, 53.0, 40.0, 15.0)
}
