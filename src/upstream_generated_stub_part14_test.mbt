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
test "upstream/generated/flex/align_content_stretch_row_with_fixed_height" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_fixed_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(60.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 60.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 80.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 80.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 80.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_flex" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 0.0)
  assert_eq(l3.size.height, 100.0)
  assert_eq(l3.location.x, 100.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 100.0)
  assert_eq(l4.location.x, 100.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_flex_no_shrink" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_flex_no_shrink.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_flex_grow(1.0)
    .with_flex_shrink(0.0)
    .with_flex_basis(percent(0.0))
    .with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 0.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 50.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 0.0)
  assert_eq(l3.size.height, 100.0)
  assert_eq(l3.location.x, 100.0)
  assert_eq(l3.location.y, 0.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 100.0)
  assert_eq(l4.location.x, 100.0)
  assert_eq(l4.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_margin" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 60.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 40.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 40.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 20.0)
  assert_eq(l3.location.x, 60.0)
  assert_eq(l3.location.y, 50.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 20.0)
  assert_eq(l4.location.x, 0.0)
  assert_eq(l4.location.y, 80.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_max_height" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(20.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 50.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 50.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_min_height" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(80.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 90.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 90.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 90.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 10.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 90.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 10.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_padding" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
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
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node3 = taffy.new_leaf(
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
  )
  let node4 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
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
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 100.0)
  assert_eq(l2.location.y, 0.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 50.0)
  assert_eq(l3.size.height, 50.0)
  assert_eq(l3.location.x, 0.0)
  assert_eq(l3.location.y, 50.0)
  let l4 = taffy.layout(node4)
  assert_eq(l4.size.width, 50.0)
  assert_eq(l4.size.height, 50.0)
  assert_eq(l4.location.x, 50.0)
  assert_eq(l4.location.y, 50.0)
}

///|
test "upstream/generated/flex/align_content_stretch_row_with_single_row" {
  // Ported from taffy-reference/tests/generated/flex/align_content_stretch_row_with_single_row.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(150.0), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 150.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_flex_start_with_shrinking_children" {
  // Ported from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_flex_start()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 500.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 0.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 0.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_flex_start_with_shrinking_children_with_stretch" {
  // Ported from taffy-reference/tests/generated/flex/align_flex_start_with_shrinking_children_with_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_stretch())
    .with_flex_grow(1.0)
    .with_flex_shrink(1.0),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_flex_start()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 500.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 0.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 0.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_flex_start_with_stretching_children" {
  // Ported from taffy-reference/tests/generated/flex/align_flex_start_with_stretching_children.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_stretch()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default().with_size(Size(width=length(500.0), height=length(500.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 500.0)
  assert_eq(lnode.size.height, 500.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 0.0)
  assert_eq(l0.size.height, 500.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 500.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 500.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_center" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 45.0)
}

///|
test "upstream/generated/flex/align_items_center_child_with_margin_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_child_with_margin_bigger_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_center()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 70.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, -10.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 10.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_center_child_without_margin_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_child_without_margin_bigger_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(70.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_center()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(50.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 70.0)
  assert_eq(l0.size.height, 70.0)
  assert_eq(l0.location.x, -10.0)
  assert_eq(l0.location.y, -10.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 70.0)
  assert_eq(l00.size.height, 70.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_center_justify_content_center" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_justify_content_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf_with_context(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=percent(1.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(50.0))),
    [node00],
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
  assert_eq(l0.size.width, 500.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 245.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 10.0)
  assert_eq(l000.size.height, 10.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_items_center_min_max_with_padding" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_min_max_with_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(62.0), height=length(62.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_min_size(Size(width=length(320.0), height=length(72.0)))
    .with_max_size(Size(width=length(320.0), height=length(504.0)))
    .with_padding(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(8.0),
        bottom=length(8.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 78.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 62.0)
  assert_eq(l0.size.height, 62.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 8.0)
}

///|
test "upstream/generated/flex/align_items_center_with_child_margin" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_child_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(10.0), height=length(10.0)))
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
    .with_align_items(align_items_center())
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 50.0)
}

///|
test "upstream/generated/flex/align_items_center_with_child_top" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_child_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(10.0), height=length(10.0)))
    .with_inset(
      Rect(left=auto(), right=auto(), top=length(10.0), bottom=auto()),
    ),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 55.0)
}

///|
test "upstream/generated/flex/align_items_center_with_height_with_padding_border_with_wrap" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_height_with_padding_border_with_wrap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node10, node11],
  )
  let node = taffy.new_with_children(Style::default(), [node0, node1])
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
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 5.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 10.0)
  assert_eq(l01.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 10.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 45.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 10.0)
  assert_eq(l11.size.height, 20.0)
  assert_eq(l11.location.x, 10.0)
  assert_eq(l11.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_max_height_percentage_with_align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=percent(0.5))),
    [node00, node01],
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
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 20.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 10.0)
  assert_eq(l01.location.y, 15.0)
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_with_align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(150.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(100.0))),
    [node0, node1],
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
  assert_eq(l0.location.y, 25.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 150.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, -25.0)
}

///|
test "upstream/generated/flex/align_items_center_with_max_height_with_padding_border" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_max_height_with_padding_border.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(150.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(150.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_max_size(Size(width=auto(), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    )
    .with_border(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
    [node10, node11],
  )
  let node = taffy.new_with_children(
    Style::default().with_display(display_block()),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 45.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 150.0)
  assert_eq(l01.location.x, 30.0)
  assert_eq(l01.location.y, -25.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 100.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 10.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 20.0)
  assert_eq(l10.location.y, 90.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 10.0)
  assert_eq(l11.size.height, 150.0)
  assert_eq(l11.location.x, 30.0)
  assert_eq(l11.location.y, 20.0)
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_min_height_percentage_with_align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=percent(1.0))),
    [node00, node01],
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
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 45.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 10.0)
  assert_eq(l01.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 100.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 10.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 45.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, 40.0)
}

///|
test "upstream/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_align_content_flex_start_with_wrap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node10, node11],
  )
  let node20 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node21 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node2 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_items(align_items_center())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node20, node21],
  )
  let node30 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node31 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(20.0))),
  )
  let node3 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_align_items(align_items_center())
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0))),
    [node30, node31],
  )
  let node = taffy.new_with_children(Style::default(), [
    node0, node1, node2, node3,
  ])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 400.0)
  assert_eq(lnode.size.height, 100.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 10.0)
  assert_eq(l00.size.height, 10.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 5.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 10.0)
  assert_eq(l01.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 10.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 45.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 10.0)
  assert_eq(l11.size.height, 20.0)
  assert_eq(l11.location.x, 10.0)
  assert_eq(l11.location.y, 40.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 200.0)
  assert_eq(l2.location.y, 0.0)
  let l20 = taffy.layout(node20)
  assert_eq(l20.size.width, 10.0)
  assert_eq(l20.size.height, 10.0)
  assert_eq(l20.location.x, 0.0)
  assert_eq(l20.location.y, 45.0)
  let l21 = taffy.layout(node21)
  assert_eq(l21.size.width, 10.0)
  assert_eq(l21.size.height, 20.0)
  assert_eq(l21.location.x, 10.0)
  assert_eq(l21.location.y, 40.0)
  let l3 = taffy.layout(node3)
  assert_eq(l3.size.width, 100.0)
  assert_eq(l3.size.height, 100.0)
  assert_eq(l3.location.x, 300.0)
  assert_eq(l3.location.y, 0.0)
  let l30 = taffy.layout(node30)
  assert_eq(l30.size.width, 10.0)
  assert_eq(l30.size.height, 10.0)
  assert_eq(l30.location.x, 0.0)
  assert_eq(l30.location.y, 45.0)
  let l31 = taffy.layout(node31)
  assert_eq(l31.size.width, 10.0)
  assert_eq(l31.size.height, 20.0)
  assert_eq(l31.location.x, 10.0)
  assert_eq(l31.location.y, 40.0)
}
