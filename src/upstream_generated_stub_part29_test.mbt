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
test "upstream/generated/flex/size_defined_by_child" {
  // Ported from taffy-reference/tests/generated/flex/size_defined_by_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
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
test "upstream/generated/flex/size_defined_by_child_with_border" {
  // Ported from taffy-reference/tests/generated/flex/size_defined_by_child_with_border.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_border(
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
  assert_eq(lnode.size.width, 30.0)
  assert_eq(lnode.size.height, 30.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/size_defined_by_child_with_padding" {
  // Ported from taffy-reference/tests/generated/flex/size_defined_by_child_with_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_padding(
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
  assert_eq(lnode.size.width, 30.0)
  assert_eq(lnode.size.height, 30.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 10.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/size_defined_by_grand_child" {
  // Ported from taffy-reference/tests/generated/flex/size_defined_by_grand_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(Style::default(), [node00])
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/undefined_height_with_min_max" {
  // Ported from taffy-reference/tests/generated/flex/undefined_height_with_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=auto(), height=length(0.0)))
    .with_max_size(Size(width=auto(), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(0.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 0.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 320.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/undefined_width_with_min_max" {
  // Ported from taffy-reference/tests/generated/flex/undefined_width_with_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(0.0), height=auto()))
    .with_max_size(Size(width=length(100.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=auto(), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 0.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/undefined_width_with_min_max_row" {
  // Ported from taffy-reference/tests/generated/flex/undefined_width_with_min_max_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_min_size(Size(width=length(60.0), height=auto()))
    .with_max_size(Size(width=length(300.0), height=auto())),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=auto(), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 60.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 60.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 30.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_large_size" {
  // Ported from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_large_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(100.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 100.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_small_size" {
  // Ported from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_small_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(100.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 10.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 5.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 5.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 5.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 100.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size" {
  // Ported from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_unconstraint_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(100.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node10],
  )
  let node = taffy.new_with_children(Style::default(), [node0, node1])
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
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 100.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size" {
  // Ported from taffy-reference/tests/generated/flex/width_smaller_then_content_with_flex_grow_very_large_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node00],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(100.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=length(0.0), height=auto())),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(200.0), height=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 20.0)
  assert_eq(l10.size.height, 100.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_child" {
  // Ported from taffy-reference/tests/generated/flex/wrap_child.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
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
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_column" {
  // Ported from taffy-reference/tests/generated/flex/wrap_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(31.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(32.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(33.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(34.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 31.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 32.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 31.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 33.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 63.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 34.0)
  assert_eq(l3.location.x, 50.0)
  assert_eq(l3.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_grandchild" {
  // Ported from taffy-reference/tests/generated/flex/wrap_grandchild.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node0 = taffy.new_with_children(Style::default(), [node00])
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 100.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_nodes_with_content_sizing_margin_cross" {
  // Ported from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_margin_cross.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(40.0), height=length(40.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node000],
  )
  let node010 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(40.0), height=length(40.0))),
  )
  let node01 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(10.0),
        bottom=length(0.0),
      ),
    ),
    [node010],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(70.0), height=auto())),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 70.0)
  assert_eq(l0.size.height, 90.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 40.0)
  assert_eq(l00.size.height, 40.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 40.0)
  assert_eq(l000.size.height, 40.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 40.0)
  assert_eq(l01.size.height, 40.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 50.0)
  let l010 = taffy.layout(node010)
  assert_eq(l010.size.width, 40.0)
  assert_eq(l010.size.height, 40.0)
  assert_eq(l010.location.x, 0.0)
  assert_eq(l010.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin" {
  // Ported from taffy-reference/tests/generated/flex/wrap_nodes_with_content_sizing_overflowing_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(40.0), height=length(40.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_direction(flex_direction_column()),
    [node000],
  )
  let node010 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(40.0), height=length(40.0))),
  )
  let node01 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
    [node010],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(85.0), height=auto())),
    [node00, node01],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 85.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 40.0)
  assert_eq(l00.size.height, 40.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 40.0)
  assert_eq(l000.size.height, 40.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 40.0)
  assert_eq(l01.size.height, 40.0)
  assert_eq(l01.location.x, 0.0)
  assert_eq(l01.location.y, 40.0)
  let l010 = taffy.layout(node010)
  assert_eq(l010.size.width, 40.0)
  assert_eq(l010.size.height, 40.0)
  assert_eq(l010.location.x, 0.0)
  assert_eq(l010.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_column" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_column.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(31.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(32.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(33.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(34.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 31.0)
  assert_eq(l0.location.x, 70.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 32.0)
  assert_eq(l1.location.x, 70.0)
  assert_eq(l1.location.y, 31.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 33.0)
  assert_eq(l2.location.x, 70.0)
  assert_eq(l2.location.y, 63.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 34.0)
  assert_eq(l3.location.x, 20.0)
  assert_eq(l3.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_column_fixed_size" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_column_fixed_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 135.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 135.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 135.0)
  assert_eq(l2.location.y, 30.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 135.0)
  assert_eq(l3.location.y, 60.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 35.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(31.0), height=length(30.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(32.0), height=length(30.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(33.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(34.0), height=length(30.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 60.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 31.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 30.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 32.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 31.0)
  assert_eq(l1.location.y, 30.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 33.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 63.0)
  assert_eq(l2.location.y, 30.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 34.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_center" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_content(align_content_center())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 60.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 50.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 60.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 50.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_space_around" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_space_around.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_content(align_content_space_around())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 60.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 50.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row_align_content_stretch" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row_align_content_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 80.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 70.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 60.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 50.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 30.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_reverse_row_single_line_different_size" {
  // Ported from taffy-reference/tests/generated/flex/wrap_reverse_row_single_line_different_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(40.0))),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(30.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap_reverse())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(300.0), height=auto())),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 300.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 30.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 40.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 30.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 30.0)
  assert_eq(l1.location.y, 30.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 30.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 60.0)
  assert_eq(l2.location.y, 20.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 30.0)
  assert_eq(l3.size.height, 40.0)
  assert_eq(l3.location.x, 90.0)
  assert_eq(l3.location.y, 10.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 30.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 120.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/wrap_row" {
  // Ported from taffy-reference/tests/generated/flex/wrap_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(31.0), height=length(30.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(32.0), height=length(30.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(33.0), height=length(30.0))),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(34.0), height=length(30.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_size(Size(width=length(100.0), height=auto())),
    [node0, node1, node2, node3],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 60.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 31.0)
  assert_eq(l0.size.height, 30.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 32.0)
  assert_eq(l1.size.height, 30.0)
  assert_eq(l1.location.x, 31.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 33.0)
  assert_eq(l2.size.height, 30.0)
  assert_eq(l2.location.x, 63.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 34.0)
  assert_eq(l3.size.height, 30.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 30.0)
}
