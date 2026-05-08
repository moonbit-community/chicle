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
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
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
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_column_stretch_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_column_stretch_fill_width.rs
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
  assert_eq(l0.size.height, 40.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_min_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_min_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_min_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
    { text_content: "", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_fill_width_flex" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_fill_width_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(50.0)))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
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
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 50.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_height.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=length(40.0), height=auto()))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_max_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_max_size(Size(width=auto(), height=length(20.0)))
    .with_aspect_ratio(2.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/aspect_ratio_flex_row_stretch_fill_width" {
  // Ported from taffy-reference/tests/generated/flex/aspect_ratio_flex_row_stretch_fill_width.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=auto(), height=length(40.0)))
    .with_aspect_ratio(2.0),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
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
test "upstream/generated/flex/bevy_issue_10343_block" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_10343_block.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(Style::default())
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_block())
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_around())
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
  assert_eq(l0.size.height, 210.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 90.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 90.0)
  assert_eq(l000.size.height, 0.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_10343_flex" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_10343_flex.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(Style::default())
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_around())
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
  assert_eq(l0.size.height, 210.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 90.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 200.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_10343_grid" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_10343_grid.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(Style::default())
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=length(200.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_flex()),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_justify_content(justify_content_space_around())
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
  assert_eq(l0.size.height, 210.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 90.0)
  assert_eq(l00.size.height, 200.0)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 90.0)
  assert_eq(l000.size.height, 200.0)
  assert_eq(l000.location.x, 0.0)
  assert_eq(l000.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_7976_3_level" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_7976_3_level.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(1.0), height=percent(1.0)))
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_min_size(Size(width=length(40.0), height=length(40.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_start())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 190.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 30.0)
  assert_eq(l00.size.height, 180.0)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
}

///|
test "upstream/generated/flex/bevy_issue_7976_4_level" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_7976_4_level.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(Style::default())
  let node00 = taffy.new_with_children(
    Style::default()
    .with_size(Size(width=percent(1.0), height=percent(1.0)))
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_min_size(Size(width=length(40.0), height=length(40.0)))
    .with_margin(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(5.0),
        right=length(5.0),
        top=length(5.0),
        bottom=length(5.0),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_start())
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 190.0)
  assert_eq(l0.location.x, 5.0)
  assert_eq(l0.location.y, 5.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 30.0)
  assert_eq(l00.size.height, 180.0)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
  let l000 = taffy.layout(node000)
  assert_eq(l000.size.width, 0.0)
  assert_eq(l000.size.height, 170.0)
  assert_eq(l000.location.x, 5.0)
  assert_eq(l000.location.y, 5.0)
}

///|
test "upstream/generated/flex/bevy_issue_7976_reduced" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_7976_reduced.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(40.0), height=auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_align_content(align_content_start())
    .with_size(Size(width=auto(), height=length(200.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 40.0)
  assert_eq(lnode.size.height, 200.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 200.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_8017" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_8017.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_gap(Size(width=length(8.0), height=length(8.0)))
    .with_size(Size(width=percent(1.0), height=percent(0.5))),
    [node00, node01],
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
  )
  let node11 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=percent(1.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_gap(Size(width=length(8.0), height=length(8.0)))
    .with_size(Size(width=percent(1.0), height=percent(0.5))),
    [node10, node11],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_flex())
    .with_flex_direction(flex_direction_column())
    .with_gap(Size(width=length(8.0), height=length(8.0)))
    .with_size(Size(width=length(400.0), height=length(400.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(8.0),
        top=length(8.0),
        bottom=length(8.0),
      ),
    ),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 400.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 384.0)
  assert_eq(l0.size.height, 188.0)
  assert_eq(l0.location.x, 8.0)
  assert_eq(l0.location.y, 8.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 188.0)
  assert_eq(l00.size.height, 188.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 188.0)
  assert_eq(l01.size.height, 188.0)
  assert_eq(l01.location.x, 196.0)
  assert_eq(l01.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 384.0)
  assert_eq(l1.size.height, 188.0)
  assert_eq(l1.location.x, 8.0)
  assert_eq(l1.location.y, 204.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 188.0)
  assert_eq(l10.size.height, 188.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 188.0)
  assert_eq(l11.size.height, 188.0)
  assert_eq(l11.location.x, 196.0)
  assert_eq(l11.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_8017_reduced" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_8017_reduced.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(Style::default())
  let node0 = taffy.new_with_children(
    Style::default().with_size(Size(width=auto(), height=percent(0.5))),
    [node00],
  )
  let node10 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_with_children(
    Style::default().with_size(Size(width=auto(), height=percent(0.5))),
    [node10],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_gap(Size(width=length(8.0), height=length(8.0)))
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 196.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 0.0)
  assert_eq(l00.size.height, 196.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 200.0)
  assert_eq(l1.size.height, 196.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 204.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 0.0)
  assert_eq(l10.size.height, 196.0)
  assert_eq(l10.location.x, 0.0)
  assert_eq(l10.location.y, 0.0)
}

///|
test "upstream/generated/flex/bevy_issue_8082" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_8082.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node01 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node02 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node03 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(50.0), height=length(50.0)))
    .with_margin(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_flex_start())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center()),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_stretch())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_flex_start())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 200.0)
  assert_eq(l0.size.height, 140.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 40.0)
  assert_eq(l00.location.y, 10.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 50.0)
  assert_eq(l01.size.height, 50.0)
  assert_eq(l01.location.x, 110.0)
  assert_eq(l01.location.y, 10.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 50.0)
  assert_eq(l02.size.height, 50.0)
  assert_eq(l02.location.x, 40.0)
  assert_eq(l02.location.y, 80.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 50.0)
  assert_eq(l03.size.height, 50.0)
  assert_eq(l03.location.x, 110.0)
  assert_eq(l03.location.y, 80.0)
}

///|
test "upstream/generated/flex/bevy_issue_8082_percent" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_8082_percent.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node01 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node02 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node03 = taffy.new_leaf(
    Style::default().with_size(Size(width=length(50.0), height=length(50.0))),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_wrap(flex_wrap_wrap())
    .with_align_items(align_items_flex_start())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_size(Size(width=percent(0.5), height=auto())),
    [node00, node01, node02, node03],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_stretch())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_flex_start())
    .with_size(Size(width=length(200.0), height=length(400.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 200.0)
  assert_eq(lnode.size.height, 400.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  assert_eq(l0.size.height, 100.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 50.0)
  assert_eq(l00.size.height, 50.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
  let l01 = taffy.layout(node01)
  assert_eq(l01.size.width, 50.0)
  assert_eq(l01.size.height, 50.0)
  assert_eq(l01.location.x, 50.0)
  assert_eq(l01.location.y, 0.0)
  let l02 = taffy.layout(node02)
  assert_eq(l02.size.width, 50.0)
  assert_eq(l02.size.height, 50.0)
  assert_eq(l02.location.x, 0.0)
  assert_eq(l02.location.y, 50.0)
  let l03 = taffy.layout(node03)
  assert_eq(l03.size.width, 50.0)
  assert_eq(l03.size.height, 50.0)
  assert_eq(l03.location.x, 50.0)
  assert_eq(l03.location.y, 50.0)
}

///|
test "upstream/generated/flex/bevy_issue_9530" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_9530.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=percent(1.0), height=length(20.0))),
  )
  let node10 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=length(50.0))),
  )
  let node11 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_items(align_items_center())
    .with_align_content(align_content_center())
    .with_justify_content(justify_content_center())
    .with_flex_grow(1.0)
    .with_margin(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
    {
      text_content: "HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH\u{200b}HHHH",
      writing_mode: Horizontal,
    },
  )
  let node12 = taffy.new_leaf(
    Style::default().with_size(Size(width=percent(1.0), height=length(50.0))),
  )
  let node1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0)
    .with_size(Size(width=percent(1.0), height=auto()))
    .with_margin(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    )
    .with_padding(
      Rect(
        left=length(20.0),
        right=length(20.0),
        top=length(20.0),
        bottom=length(20.0),
      ),
    ),
    [node10, node11, node12],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_align_items(align_items_center())
    .with_align_content(align_content_center())
    .with_size(Size(width=length(300.0), height=length(300.0)))
    .with_margin(Rect(left=auto(), right=auto(), top=auto(), bottom=auto())),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 300.0)
  assert_eq(lnode.size.height, 300.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 300.0)
  assert_eq(l0.size.height, 0.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l1 = taffy.layout(node1)
  assert_eq(l1.size.width, 300.0)
  assert_eq(l1.size.height, 420.0)
  assert_eq(l1.location.x, 0.0)
  assert_eq(l1.location.y, 20.0)
  let l10 = taffy.layout(node10)
  assert_eq(l10.size.width, 260.0)
  assert_eq(l10.size.height, 50.0)
  assert_eq(l10.location.x, 20.0)
  assert_eq(l10.location.y, 20.0)
  let l11 = taffy.layout(node11)
  assert_eq(l11.size.width, 220.0)
  assert_eq(l11.size.height, 240.0)
  assert_eq(l11.location.x, 40.0)
  assert_eq(l11.location.y, 90.0)
  let l12 = taffy.layout(node12)
  assert_eq(l12.size.width, 260.0)
  assert_eq(l12.size.height, 50.0)
  assert_eq(l12.location.x, 20.0)
  assert_eq(l12.location.y, 350.0)
}

///|
test "upstream/generated/flex/bevy_issue_9530_reduced" {
  // Ported from taffy-reference/tests/generated/flex/bevy_issue_9530_reduced.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf_with_context(
    Style::default().with_flex_grow(1.0),
    {
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_flex_grow(1.0),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(40.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  let lnode = taffy.layout(node)
  assert_eq(lnode.size.width, 40.0)
  assert_eq(lnode.size.height, 20.0)
  assert_eq(lnode.location.x, 0.0)
  assert_eq(lnode.location.y, 0.0)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 40.0)
  assert_eq(l0.size.height, 20.0)
  assert_eq(l0.location.x, 0.0)
  assert_eq(l0.location.y, 0.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.size.width, 40.0)
  assert_eq(l00.size.height, 20.0)
  assert_eq(l00.location.x, 0.0)
  assert_eq(l00.location.y, 0.0)
}
