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
test "upstream/generated/flex/margin_auto_top_and_bottom_stretch" {
  // Ported from taffy-reference/tests/generated/flex/margin_auto_top_and_bottom_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=auto()),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_stretch())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 50.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 150.0)
}

///|
test "upstream/generated/flex/margin_auto_top_stretching_child" {
  // Ported from taffy-reference/tests/generated/flex/margin_auto_top_stretching_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_margin(
      Rect(left=length(0.0), right=length(0.0), top=auto(), bottom=length(0.0)),
    ),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 150.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 200.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 150.0)
  assert_eq(l1.location.y, 75.0)
}

///|
test "upstream/generated/flex/margin_bottom" {
  // Ported from taffy-reference/tests/generated/flex/margin_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 80.0)
}

///|
test "upstream/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/margin_fix_left_auto_right_child_bigger_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(72.0), height=length(72.0)))
    .with_margin(
      Rect(left=length(10.0), right=auto(), top=length(0.0), bottom=length(0.0)),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(52.0), height=length(52.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 52.0)
  assert_eq(lnode.size.height, 52.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 42.0)
  assert_eq(l0.size.height, 72.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/margin_left" {
  // Ported from taffy-reference/tests/generated/flex/margin_left.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(10.0), height=auto()))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/margin_right" {
  // Ported from taffy-reference/tests/generated/flex/margin_right.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(10.0), height=auto()))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 80.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/margin_should_not_be_part_of_max_height" {
  // Ported from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(20.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(250.0), height=length(250.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 250.0)
  assert_eq(lnode.size.height, 250.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
}

///|
test "upstream/generated/flex/margin_should_not_be_part_of_max_width" {
  // Ported from taffy-reference/tests/generated/flex/margin_should_not_be_part_of_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=length(100.0), height=auto()))
    .with_margin(
      Rect(
        left=length(20.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(250.0), height=length(250.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 250.0)
  assert_eq(lnode.size.height, 250.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/margin_top" {
  // Ported from taffy-reference/tests/generated/flex/margin_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
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
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/margin_with_sibling_column" {
  // Ported from taffy-reference/tests/generated/flex/margin_with_sibling_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(0.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 45.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 45.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 55.0)
}

///|
test "upstream/generated/flex/margin_with_sibling_row" {
  // Ported from taffy-reference/tests/generated/flex/margin_with_sibling_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node1 = taffy.new_leaf(Style::default().with_flex_grow(1.0))
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 45.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 45.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 55.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_height" {
  // Ported from taffy-reference/tests/generated/flex/max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(10.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_height_overrides_height" {
  // Ported from taffy-reference/tests/generated/flex/max_height_overrides_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(200.0)))
    .with_max_size(Size(width=auto(), height=length(100.0))),
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_height_overrides_height_on_root" {
  // Ported from taffy-reference/tests/generated/flex/max_height_overrides_height_on_root.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(200.0)))
    .with_max_size(Size(width=auto(), height=length(100.0))),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_width" {
  // Ported from taffy-reference/tests/generated/flex/max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(10.0)))
    .with_max_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_width_overrides_width" {
  // Ported from taffy-reference/tests/generated/flex/max_width_overrides_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(200.0), height=auto()))
    .with_max_size(Size(width=length(100.0), height=auto())),
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 0.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/max_width_overrides_width_on_root" {
  // Ported from taffy-reference/tests/generated/flex/max_width_overrides_width_on_root.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(200.0), height=auto()))
    .with_max_size(Size(width=length(100.0), height=auto())),
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 0.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child" {
  // Ported from taffy-reference/tests/generated/flex/measure_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHHHH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child_absolute" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_absolute.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_position(position_absolute()),
    TextMeasure::{ text_content: "HHHHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child_constraint" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_constraint.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child_constraint_padding_parent" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_constraint_padding_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 120.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/measure_child_with_flex_grow" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_with_flex_grow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "H\u{200b}H\u{200b}H\u{200b}H\u{200b}H",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child_with_flex_shrink" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH",
    writing_mode: Horizontal,
  })
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/measure_child_with_flex_shrink_hidden" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_with_flex_shrink_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0),
    TextMeasure::{
      text_content: "HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH\u{200b}HHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 100.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 9.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 91.0, 50.0, 9.0, 0.0)
}

///|
test "upstream/generated/flex/measure_child_with_min_size_greater_than_available_space" {
  // Ported from taffy-reference/tests/generated/flex/measure_child_with_min_size_greater_than_available_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_min_size(Size(width=length(200.0), height=auto())),
    TextMeasure::{
      text_content: "HHHHHHHH\u{200b}HHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 10.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}
