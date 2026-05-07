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
test "upstream/generated/flex/justify_content_column_flex_start_reverse" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_flex_start_reverse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column_reverse())
    .with_justify_content(justify_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 90.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 80.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 70.0)
}

///|
test "upstream/generated/flex/justify_content_column_max_height_and_margin" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_max_height_and_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(80.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(100.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 180.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 80.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 100.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 30.0)
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=auto(), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=length(100.0),
        bottom=length(0.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(Style::default(), [node0])
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 150.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 100.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 15.0)
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin_bottom" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_bottom.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(20.0)))
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
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=auto(), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 10.0)
}

///|
test "upstream/generated/flex/justify_content_column_min_height_and_margin_top" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_min_height_and_margin_top.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(20.0), height=length(20.0)))
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
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=auto(), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 20.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_around" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_around.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_around())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 12.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 45.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 78.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_around_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_around())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_around_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_around_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_around())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_between" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_between.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_between())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 45.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 90.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_between_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_between())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_between_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_between_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_between())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_evenly.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_evenly())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 18.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 45.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 73.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_evenly())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/justify_content_column_space_evenly_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_space_evenly_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_space_evenly())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/justify_content_column_start" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 20.0)
}

///|
test "upstream/generated/flex/justify_content_column_start_negative_space" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_start())
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 20.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 40.0)
}

///|
test "upstream/generated/flex/justify_content_column_start_negative_space_gap" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_start_negative_space_gap.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=percent(0.8), height=length(20.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_justify_content(justify_content_start())
    .with_gap(Size(width=length(10.0), height=length(10.0)))
    .with_size(Size(width=auto(), height=length(10.0))),
    [node00, node01, node02],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(320.0), height=length(320.0)))
    .with_border(
      Rect(
        left=length(60.0),
        right=length(60.0),
        top=length(60.0),
        bottom=length(60.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 320.0)
  assert_eq(lnode.size.height, 320.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 60.0)
  assert_eq(l0.location.y, 60.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 160.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 20.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 160.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 20.0)
  assert_eq(l01.location.y, 30.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 160.0)
  assert_eq(l02.size.height, 20.0)
  assert_eq(l02.location.x, 20.0)
  assert_eq(l02.location.y, 60.0)
}

///|
test "upstream/generated/flex/justify_content_column_start_reverse" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_column_start_reverse.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=auto(), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column_reverse())
    .with_justify_content(justify_content_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.y, 20.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 10.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 10.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 100.0)
  assert_eq(l2.size.height, 10.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_min_max" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(200.0))),
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
  assert_eq(l0.size.height, 60.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 20.0)
}

///|
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_greater_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(300.0), height=length(100.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=length(400.0), height=auto()))
    .with_padding(
      Rect(
        left=length(100.0),
        right=length(100.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_content(align_content_stretch()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(1000.0), height=length(1584.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 1000.0)
  assert_eq(lnode.size.height, 1584.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 1000.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 500.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 300.0)
  assert_eq(l000.size.height, 100.0)
  assert_eq(l000.location.x, 100.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_min_width_with_padding_child_width_lower_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(199.0), height=length(100.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=length(400.0), height=auto()))
    .with_padding(
      Rect(
        left=length(100.0),
        right=length(100.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_content(align_content_stretch()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch())
    .with_size(Size(width=length(1080.0), height=length(1584.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 1080.0)
  assert_eq(lnode.size.height, 1584.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 1080.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 400.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 199.0)
  assert_eq(l000.size.height, 100.0)
  assert_eq(l000.location.x, 101.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_overflow_min_max" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_overflow_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node2 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_center())
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_max_size(Size(width=auto(), height=length(110.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 50.0)
  assert_eq(lnode.size.height, 110.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, -20.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 50.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 30.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 50.0)
  assert_eq(l2.size.height, 50.0)
  assert_eq(l2.location.x, 0.0)
  assert_eq(l2.location.y, 80.0)
}

///|
test "upstream/generated/flex/justify_content_row_center" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_row_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.x, 35.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 45.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 55.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_row_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_row_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_flex_end())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.x, 70.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 80.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 90.0)
  assert_eq(l2.location.y, 0.0)
}

///|
test "upstream/generated/flex/justify_content_row_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/justify_content_row_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_flex_start())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0, node1, node2],
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 10.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 10.0)
  assert_eq(l1.location.y, 0.0)
  let l2 = taffy.layout(node2)
  assert_eq(l2.size.width, 10.0)
  assert_eq(l2.size.height, 100.0)
  assert_eq(l2.location.x, 20.0)
  assert_eq(l2.location.y, 0.0)
}
