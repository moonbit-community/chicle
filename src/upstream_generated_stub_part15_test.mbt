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
test "upstream/generated/flex/align_items_center_with_min_height_with_padding_border" {
  // Ported from taffy-reference/tests/generated/flex/align_items_center_with_min_height_with_padding_border.rs
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
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(8.0),
        top=length(8.0),
        bottom=length(8.0),
      ),
    )
    .with_border(
      Rect(
        left=length(7.0),
        right=length(7.0),
        top=length(7.0),
        bottom=length(7.0),
      ),
    ),
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
    .with_align_content(align_content_flex_start())
    .with_size(Size(width=length(100.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(100.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(8.0),
        top=length(8.0),
        bottom=length(8.0),
      ),
    )
    .with_border(
      Rect(
        left=length(7.0),
        right=length(7.0),
        top=length(7.0),
        bottom=length(7.0),
      ),
    ),
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
  assert_eq(l00.location.x, 15.0)
  assert_eq(l00.location.y, 45.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 10.0)
  assert_eq(l01.size.height, 20.0)
  assert_eq(l01.location.x, 25.0)
  assert_eq(l01.location.y, 40.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 100.0)
  assert_eq(l1.size.height, 100.0)
  assert_eq(l1.location.x, 100.0)
  assert_eq(l1.location.y, 0.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 10.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 15.0)
  assert_eq(l10.location.y, 20.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 10.0)
  assert_eq(l11.size.height, 20.0)
  assert_eq(l11.location.x, 25.0)
  assert_eq(l11.location.y, 15.0)
}

///|
test "upstream/generated/flex/align_items_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/align_items_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_end())
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
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/align_items_flex_end_child_with_margin_bigger_than_parent.rs
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
    Style::default().with_align_items(align_items_flex_end()),
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
test "upstream/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent" {
  // Ported from taffy-reference/tests/generated/flex/align_items_flex_end_child_without_margin_bigger_than_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(70.0), height=length(70.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_align_items(align_items_flex_end()),
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
test "upstream/generated/flex/align_items_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_items_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_start())
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
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_min_max" {
  // Ported from taffy-reference/tests/generated/flex/align_items_min_max.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(60.0), height=length(60.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_size(Size(width=auto(), height=length(100.0)))
    .with_min_size(Size(width=length(100.0), height=auto()))
    .with_max_size(Size(width=length(200.0), height=auto())),
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
  assert_eq(l0.location.x, 20.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_stretch" {
  // Ported from taffy-reference/tests/generated/flex/align_items_stretch.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=auto())),
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
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_items_stretch_min_cross" {
  // Ported from taffy-reference/tests/generated/flex/align_items_stretch_min_cross.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_shrink(0.0)
    .with_size(Size(width=auto(), height=length(36.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_min_size(Size(width=length(400.0), height=length(50.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 400.0)
  assert_eq(lnode.size.height, 50.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 400.0)
  assert_eq(l0.size.height, 36.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_self_baseline" {
  // Ported from taffy-reference/tests/generated/flex/align_self_baseline.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(10.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_align_self(align_items_baseline())
    .with_size(Size(width=length(50.0), height=length(20.0))),
    [node10],
  )
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
  assert_eq(l0.size.width, 50.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 50.0)
  assert_eq(l1.size.height, 20.0)
  assert_eq(l1.location.x, 50.0)
  assert_eq(l1.location.y, 40.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 50.0)
  assert_eq(l10.size.height, 10.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_self_center" {
  // Ported from taffy-reference/tests/generated/flex/align_self_center.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(10.0), height=length(10.0))),
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 45.0)
}

///|
test "upstream/generated/flex/align_self_center_undefined_max_height" {
  // Ported from taffy-reference/tests/generated/flex/align_self_center_undefined_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(240.0), height=length(44.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_center())
    .with_size(Size(width=length(40.0), height=length(56.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=length(280.0), height=auto()))
    .with_min_size(Size(width=auto(), height=length(52.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 280.0)
  assert_eq(lnode.size.height, 56.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 240.0)
  assert_eq(l0.size.height, 44.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 40.0)
  assert_eq(l1.size.height, 56.0)
  assert_eq(l1.location.x, 240.0)
  assert_eq(l1.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_self_flex_end" {
  // Ported from taffy-reference/tests/generated/flex/align_self_flex_end.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_flex_end())
    .with_size(Size(width=length(10.0), height=length(10.0))),
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_self_flex_end_override_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_self_flex_end_override_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_flex_end())
    .with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_start())
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
  assert_eq(l0.location.y, 90.0)
}

///|
test "upstream/generated/flex/align_self_flex_start" {
  // Ported from taffy-reference/tests/generated/flex/align_self_flex_start.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_align_self(align_items_flex_start())
    .with_size(Size(width=length(10.0), height=length(10.0))),
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
  assert_eq(l0.size.height, 10.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/align_stretch_should_size_based_on_parent" {
  // Ported from taffy-reference/tests/generated/flex/align_stretch_should_size_based_on_parent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(20.0), height=length(20.0))),
  )
  let node00 = taffy.new_with_children(
    Style::default().with_flex_grow(1.0).with_flex_shrink(1.0),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_justify_content(justify_content_center())
    .with_flex_grow(0.0)
    .with_flex_shrink(1.0),
    [node00],
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
  assert_eq(l0.size.width, 20.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 20.0)
  assert_eq(l00.size.height, 100.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 20.0)
  assert_eq(l000.size.height, 20.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/android_news_feed" {
  // Ported from taffy-reference/tests/generated/flex/android_news_feed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000000 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(120.0), height=length(120.0))),
  )
  let node00000 = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(0.0),
    [node000000],
  )
  let node000010 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0),
  )
  let node000011 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0),
  )
  let node00001 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0)
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(36.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(36.0),
        right=length(36.0),
        top=length(21.0),
        bottom=length(18.0),
      ),
    ),
    [node000010, node000011],
  )
  let node0000 = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_start())
    .with_align_content(align_content_stretch())
    .with_margin(
      Rect(
        left=length(36.0),
        right=length(0.0),
        top=length(24.0),
        bottom=length(0.0),
      ),
    ),
    [node00000, node00001],
  )
  let node000 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch()),
    [node0000],
  )
  let node001000 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(72.0), height=length(72.0))),
  )
  let node00100 = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(0.0),
    [node001000],
  )
  let node001010 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0),
  )
  let node001011 = taffy.new_leaf(
    Style::default()
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0),
  )
  let node00101 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch())
    .with_flex_shrink(1.0)
    .with_margin(
      Rect(
        left=length(0.0),
        right=length(36.0),
        top=length(0.0),
        bottom=length(0.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(36.0),
        right=length(36.0),
        top=length(21.0),
        bottom=length(18.0),
      ),
    ),
    [node001010, node001011],
  )
  let node0010 = taffy.new_with_children(
    Style::default()
    .with_align_items(align_items_flex_start())
    .with_align_content(align_content_stretch())
    .with_margin(
      Rect(
        left=length(174.0),
        right=length(0.0),
        top=length(24.0),
        bottom=length(0.0),
      ),
    ),
    [node00100, node00101],
  )
  let node001 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch()),
    [node0010],
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch()),
    [node000, node001],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_shrink(0.0),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_content(align_content_stretch())
    .with_flex_shrink(0.0)
    .with_size(Size(width=length(1080.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 1080.0)
  assert_eq(lnode.size.height, 240.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 1080.0)
  assert_eq(l0.size.height, 240.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 1080.0)
  assert_eq(l00.size.height, 240.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 1080.0)
  assert_eq(l000.size.height, 144.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
  let l0000 = taffy.layout(node0000)
  assert_eq(l0000.size.width, 1044.0)
  assert_eq(l0000.size.height, 120.0)
  assert_eq(l0000.location.x, 36.0)
  assert_eq(l0000.location.y, 24.0)
  let l00000 = taffy.layout(node00000)
  assert_eq(l00000.size.width, 120.0)
  assert_eq(l00000.size.height, 120.0)
  assert_eq(l00000.location.x, 0.0)
  assert_eq(l00000.location.y, 0.0)
  let l000000 = taffy.layout(node000000)
  assert_eq(l000000.size.width, 120.0)
  assert_eq(l000000.size.height, 120.0)
  assert_eq(l000000.location.x, 0.0)
  assert_eq(l000000.location.y, 0.0)
  let l00001 = taffy.layout(node00001)
  assert_eq(l00001.size.width, 72.0)
  assert_eq(l00001.size.height, 39.0)
  assert_eq(l00001.location.x, 120.0)
  assert_eq(l00001.location.y, 0.0)
  let l000010 = taffy.layout(node000010)
  assert_eq(l000010.size.width, 0.0)
  assert_eq(l000010.size.height, 0.0)
  assert_eq(l000010.location.x, 36.0)
  assert_eq(l000010.location.y, 21.0)
  let l000011 = taffy.layout(node000011)
  assert_eq(l000011.size.width, 0.0)
  assert_eq(l000011.size.height, 0.0)
  assert_eq(l000011.location.x, 36.0)
  assert_eq(l000011.location.y, 21.0)
  let l001 = taffy.layout(node001)
  assert_eq(l001.size.width, 1080.0)
  assert_eq(l001.size.height, 96.0)
  assert_eq(l001.location.x, 0.0)
  assert_eq(l001.location.y, 144.0)
  let l0010 = taffy.layout(node0010)
  assert_eq(l0010.size.width, 906.0)
  assert_eq(l0010.size.height, 72.0)
  assert_eq(l0010.location.x, 174.0)
  assert_eq(l0010.location.y, 24.0)
  let l00100 = taffy.layout(node00100)
  assert_eq(l00100.size.width, 72.0)
  assert_eq(l00100.size.height, 72.0)
  assert_eq(l00100.location.x, 0.0)
  assert_eq(l00100.location.y, 0.0)
  let l001000 = taffy.layout(node001000)
  assert_eq(l001000.size.width, 72.0)
  assert_eq(l001000.size.height, 72.0)
  assert_eq(l001000.location.x, 0.0)
  assert_eq(l001000.location.y, 0.0)
  let l00101 = taffy.layout(node00101)
  assert_eq(l00101.size.width, 72.0)
  assert_eq(l00101.size.height, 39.0)
  assert_eq(l00101.location.x, 72.0)
  assert_eq(l00101.location.y, 0.0)
  let l001010 = taffy.layout(node001010)
  assert_eq(l001010.size.width, 0.0)
  assert_eq(l001010.size.height, 0.0)
  assert_eq(l001010.location.x, 36.0)
  assert_eq(l001010.location.y, 21.0)
  let l001011 = taffy.layout(node001011)
  assert_eq(l001011.size.width, 0.0)
  assert_eq(l001011.size.height, 0.0)
  assert_eq(l001011.location.x, 36.0)
  assert_eq(l001011.location.y, 21.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_min_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_min_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
    TextMeasure::{ text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_start())
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
  assert_eq(l0.size.width, 80.0)
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_fill_width_flex" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_fill_width_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
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
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}
