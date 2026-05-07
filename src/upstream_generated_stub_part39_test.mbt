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
test "upstream/generated/grid/grid_padding_border_overrides_min_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_padding_border_overrides_min_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_min_size(Size(width=length(0.0), height=length(0.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 22.0, 14.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 22.0, 14.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_padding_border_overrides_size" {
  // Ported from taffy-reference/tests/generated/grid/grid_padding_border_overrides_size.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(12.0), height=length(12.0)))
    .with_padding(
      Rect(
        left=length(8.0),
        right=length(4.0),
        top=length(2.0),
        bottom=length(6.0),
      ),
    )
    .with_border(
      Rect(
        left=length(7.0),
        right=length(3.0),
        top=length(1.0),
        bottom=length(5.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 22.0, 14.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 22.0, 14.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_item_inside_stretch_item" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_item_inside_stretch_item.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=percent(0.5), height=auto())),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 50.0, 100.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_items_nested_inside_stretch_alignment" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_nested_inside_stretch_alignment.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_display(display_grid())
    .with_padding(
      Rect(
        left=length(0.0),
        right=length(0.0),
        top=percent(0.2),
        bottom=length(0.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default().with_display(display_grid()),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 200.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 200.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node00, 200.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_items_nested_moderate" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_nested_moderate.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=percent(0.5), height=auto()))
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
        left=percent(0.03),
        right=percent(0.03),
        top=percent(0.03),
        bottom=percent(0.03),
      ),
    ),
    [node00],
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=auto()))
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
}

///|
test "upstream/generated/grid/grid_percent_items_nested_with_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node00 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    ),
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=percent(0.5), height=auto())),
    [node00],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  let l0 = taffy.layout(node0)
  assert_eq(l0.size.width, 100.0)
  let l00 = taffy.layout(node00)
  assert_eq(l00.location.x, 5.0)
  assert_eq(l00.location.y, 5.0)
  assert_eq(l00.size.width, 45.0)
  assert_eq(l00.size.height, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 10.0, 0.0, 0.0)
  assert_layout_xywh(taffy, root, 200.0, 10.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_items_nested_with_padding_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_nested_with_padding_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node000 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  let node00 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=percent(0.5), height=auto()))
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
        left=percent(0.03),
        right=percent(0.03),
        top=percent(0.03),
        bottom=percent(0.03),
      ),
    ),
    [node000],
  )
  let node0 = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_min_size(Size(width=percent(0.6), height=auto()))
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
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
    [node00],
  )
  let node1 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([fr(1.0), fr(4.0)])
    .with_size(Size(width=length(200.0), height=length(200.0))),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node0, 190.0, 41.0, 5.0, 5.0)
  assert_layout_xywh(taffy, node00, 92.0, 25.0, 8.0, 8.0)
  assert_layout_xywh(taffy, node000, 36.0, 6.0, 10.0, 10.0)
  assert_layout_xywh(taffy, node1, 200.0, 149.0, 0.0, 51.0)
  assert_layout_xywh(taffy, root, 200.0, 200.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_items_width_and_margin" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_width_and_margin.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.45), height=auto()))
    .with_margin(
      Rect(
        left=percent(0.05),
        right=percent(0.05),
        top=percent(0.05),
        bottom=percent(0.05),
      ),
    )
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=auto()))
    .with_padding(
      Rect(
        left=length(3.0),
        right=length(3.0),
        top=length(3.0),
        bottom=length(3.0),
      ),
    ),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 200.0, 31.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 87.0, 6.0, 13.0, 13.0)
}

///|
test "upstream/generated/grid/grid_percent_items_width_and_padding" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_items_width_and_padding.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=percent(0.5), height=auto()))
    .with_padding(
      Rect(
        left=percent(0.03),
        right=percent(0.03),
        top=percent(0.03),
        bottom=percent(0.03),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(200.0), height=auto())),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 200.0, 12.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 12.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_tracks_definite_overflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_overflow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.5), percent(0.8)])
    .with_grid_template_columns([percent(0.4), percent(0.4), percent(0.4)])
    .with_size(Size(width=length(120.0), height=length(60.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 48.0, 30.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 48.0, 30.0, 48.0, 0.0)
  assert_layout_xywh(taffy, node2, 48.0, 30.0, 96.0, 0.0)
  assert_layout_xywh(taffy, node3, 48.0, 48.0, 0.0, 30.0)
  assert_layout_xywh(taffy, node4, 48.0, 48.0, 48.0, 30.0)
  assert_layout_xywh(taffy, node5, 48.0, 48.0, 96.0, 30.0)
}

///|
test "upstream/generated/grid/grid_percent_tracks_definite_underflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_tracks_definite_underflow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.6)])
    .with_grid_template_columns([percent(0.1), percent(0.2), percent(0.3)])
    .with_size(Size(width=length(120.0), height=length(60.0))),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 12.0, 18.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 24.0, 18.0, 12.0, 0.0)
  assert_layout_xywh(taffy, node2, 36.0, 18.0, 36.0, 0.0)
  assert_layout_xywh(taffy, node3, 12.0, 36.0, 0.0, 18.0)
  assert_layout_xywh(taffy, node4, 24.0, 36.0, 12.0, 18.0)
  assert_layout_xywh(taffy, node5, 36.0, 36.0, 36.0, 18.0)
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_only" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_only.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(Style::default())
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.6)])
    .with_grid_template_columns([percent(0.1), percent(0.2), percent(0.3)]),
    [node0, node1, node2, node3, node4, node5],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node3, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node4, 0.0, 0.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node5, 0.0, 0.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_overflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_overflow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.5), percent(0.8)])
    .with_grid_template_columns([percent(0.4), percent(0.4), percent(0.4)]),
    [node0, node1, node2, node3, node4, node5, node6],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 50.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 50.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node3, 40.0, 50.0, 80.0, 0.0)
  assert_layout_xywh(taffy, node4, 40.0, 80.0, 0.0, 50.0)
  assert_layout_xywh(taffy, node5, 40.0, 80.0, 40.0, 50.0)
  assert_layout_xywh(taffy, node6, 40.0, 80.0, 80.0, 50.0)
}

///|
test "upstream/generated/grid/grid_percent_tracks_indefinite_with_content_underflow" {
  // Ported from taffy-reference/tests/generated/grid/grid_percent_tracks_indefinite_with_content_underflow.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto()))
    .with_size(Size(width=length(100.0), height=length(100.0))),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([percent(0.3), percent(0.6)])
    .with_grid_template_columns([percent(0.1), percent(0.2), percent(0.3)]),
    [node0, node1, node2, node3, node4, node5, node6],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 10.0, 30.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 30.0, 10.0, 0.0)
  assert_layout_xywh(taffy, node3, 30.0, 30.0, 30.0, 0.0)
  assert_layout_xywh(taffy, node4, 10.0, 60.0, 0.0, 30.0)
  assert_layout_xywh(taffy, node5, 20.0, 60.0, 10.0, 30.0)
  assert_layout_xywh(taffy, node6, 30.0, 60.0, 30.0, 30.0)
}

///|
test "upstream/generated/grid/grid_placement_auto_negative" {
  // Ported from taffy-reference/tests/generated/grid/grid_placement_auto_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(-5), end=place_auto())),
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(
    Style::default().with_grid_row(Line(start=line(2), end=place_auto())),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 20.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 20.0, 0.0)
  assert_layout_xywh(taffy, node2, 20.0, 40.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative" {
  // Ported from taffy-reference/tests/generated/grid/grid_placement_definite_in_secondary_axis_with_fully_definite_negative.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default().with_grid_row(Line(start=line(2), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(2), end=place_auto()))
    .with_grid_column(Line(start=line(-4), end=place_auto())),
  )
  let node2 = taffy.new_leaf(
    Style::default().with_grid_row(Line(start=line(1), end=place_auto())),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 40.0, 40.0)
  assert_layout_xywh(taffy, node1, 40.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 40.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_relative_all_sides" {
  // Ported from taffy-reference/tests/generated/grid/grid_relative_all_sides.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_size(Size(width=length(40.0), height=auto()))
    .with_inset(
      Rect(
        left=length(10.0),
        right=length(10.0),
        top=length(10.0),
        bottom=length(10.0),
      ),
    ),
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [node0],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 100.0, 100.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 100.0, 10.0, 10.0)
}

///|
test "upstream/generated/grid/grid_relayout_vertical_text" {
  // Ported from taffy-reference/tests/generated/grid/grid_relayout_vertical_text.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH\u{200B}HH",
    writing_mode: Vertical,
  })
  let node1 = taffy.new_leaf_with_context(Style::default(), TextMeasure::{
    text_content: "HH\u{200B}HH\u{200B}HH",
    writing_mode: Horizontal,
  })
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_min_content()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 40.0, 60.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 0.0, 40.0)
}

///|
test "upstream/generated/grid/grid_repeat_integer" {
  // Ported from taffy-reference/tests/generated/grid/grid_repeat_integer.rs
  let taffy : TaffyTree[Unit] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([repeat(repeat_count(3), [length(40.0)])])
    .with_grid_template_columns([repeat(repeat_count(3), [length(40.0)])])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    nodes,
  )
  taffy.compute_layout(root, Size::max_content())
  let root_layout = taffy.layout(root)
  assert_eq(root_layout.size.width, 120.0)
  assert_eq(root_layout.size.height, 120.0)
  let l8 = taffy.layout(nodes[8])
  assert_eq(l8.location.x, 80.0)
  assert_eq(l8.location.y, 80.0)
}

///|
test "upstream/generated/grid/grid_repeat_mixed" {
  // Ported from taffy-reference/tests/generated/grid/grid_repeat_mixed.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let nodes : Array[NodeId] = []
  for _i in 0..<9 {
    nodes.push(taffy.new_leaf(Style::default()))
  }
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([
      length(40.0),
      repeat(repeat_count(1), [length(40.0)]),
      repeat(repeat_auto_fill(), [length(40.0)]),
    ])
    .with_grid_template_columns([
      length(40.0),
      repeat(repeat_count(1), [length(40.0)]),
      repeat(repeat_auto_fill(), [length(40.0)]),
    ])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    nodes,
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_nodes_layout_xywh(
    taffy,
    nodes,
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0],
    [0.0, 40.0, 80.0, 0.0, 40.0, 80.0, 0.0, 40.0, 80.0],
    [0.0, 0.0, 0.0, 40.0, 40.0, 40.0, 80.0, 80.0, 80.0],
  )
}

///|
test "upstream/generated/grid/grid_size_child_fixed_tracks" {
  // Ported from taffy-reference/tests/generated/grid/grid_size_child_fixed_tracks.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start()),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node1 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start()),
    TextMeasure::{ text_content: "HHH\u{200b}HHH", writing_mode: Horizontal },
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start()),
    TextMeasure::{ text_content: "HH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node3 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_size(Size(width=length(20.0), height=auto())),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let node4 = taffy.new_leaf_with_context(
    Style::default()
    .with_align_self(align_items_start())
    .with_justify_self(align_items_start())
    .with_max_size(Size(width=length(30.0), height=auto())),
    TextMeasure::{
      text_content: "HH\u{200b}HH\u{200b}HH\u{200b}HH",
      writing_mode: Horizontal,
    },
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0), length(40.0)])
    .with_grid_template_columns([length(40.0), length(40.0), length(40.0)])
    .with_size(Size(width=length(120.0), height=length(120.0))),
    [node0, node1, node2, node3, node4],
  )
  taffy.compute_layout_with_measure(root, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, root, 120.0, 120.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 40.0, 20.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 40.0, 20.0, 40.0, 0.0)
  assert_layout_xywh(taffy, node2, 40.0, 20.0, 80.0, 0.0)
  assert_layout_xywh(taffy, node3, 20.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node4, 30.0, 40.0, 40.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default().with_grid_column(Line(start=line(1), end=span(13))),
    TextMeasure::{
      text_content: "HHHHHHHHHHHHHHHH\u{200b}HHHHHHHHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let node9 = taffy.new_leaf(Style::default())
  let node10 = taffy.new_leaf(Style::default())
  let node11 = taffy.new_leaf(Style::default())
  let node12 = taffy.new_leaf(Style::default())
  let node13 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      fit_content(length(20.0)),
      auto(),
      length(10.0),
      percent(0.2),
      minmax(length(2.0), auto()),
      minmax(length(2.0), length(4.0)),
      minmax(length(2.0), grid_min_content()),
      minmax(length(2.0), grid_max_content()),
      minmax(grid_min_content(), grid_max_content()),
      minmax(grid_min_content(), auto()),
      minmax(grid_max_content(), auto()),
    ]),
    [
      node0, node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
      node11, node12, node13,
    ],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 322.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 322.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 11.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 91.0, 40.0, 11.0, 40.0)
  assert_layout_xywh(taffy, node3, 11.0, 40.0, 102.0, 40.0)
  assert_layout_xywh(taffy, node4, 11.0, 40.0, 113.0, 40.0)
  assert_layout_xywh(taffy, node5, 10.0, 40.0, 124.0, 40.0)
  assert_layout_xywh(taffy, node6, 65.0, 40.0, 134.0, 40.0)
  assert_layout_xywh(taffy, node7, 2.0, 40.0, 199.0, 40.0)
  assert_layout_xywh(taffy, node8, 4.0, 40.0, 201.0, 40.0)
  assert_layout_xywh(taffy, node9, 2.0, 40.0, 205.0, 40.0)
  assert_layout_xywh(taffy, node10, 2.0, 40.0, 207.0, 40.0)
  assert_layout_xywh(taffy, node11, 11.0, 40.0, 209.0, 40.0)
  assert_layout_xywh(taffy, node12, 11.0, 40.0, 220.0, 40.0)
  assert_layout_xywh(taffy, node13, 91.0, 40.0, 231.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_13_most_non_flex_with_minmax_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf_with_context(
    Style::default()
    .with_overflow(Point(x=overflow_hidden(), y=overflow_hidden()))
    .with_scrollbar_width(15.0)
    .with_grid_column(Line(start=line(1), end=span(13))),
    TextMeasure::{
      text_content: "HHHHHHHHHHHHHHHH\u{200b}HHHHHHHHHHHHHHHH",
      writing_mode: Horizontal,
    },
  )
  let node1 = taffy.new_leaf(Style::default())
  let node2 = taffy.new_leaf(Style::default())
  let node3 = taffy.new_leaf(Style::default())
  let node4 = taffy.new_leaf(Style::default())
  let node5 = taffy.new_leaf(Style::default())
  let node6 = taffy.new_leaf(Style::default())
  let node7 = taffy.new_leaf(Style::default())
  let node8 = taffy.new_leaf(Style::default())
  let node9 = taffy.new_leaf(Style::default())
  let node10 = taffy.new_leaf(Style::default())
  let node11 = taffy.new_leaf(Style::default())
  let node12 = taffy.new_leaf(Style::default())
  let node13 = taffy.new_leaf(Style::default())
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0), length(40.0)])
    .with_grid_template_columns([
      grid_min_content(),
      grid_max_content(),
      fit_content(length(20.0)),
      auto(),
      length(10.0),
      percent(0.2),
      minmax(length(2.0), auto()),
      minmax(length(2.0), length(4.0)),
      minmax(length(2.0), grid_min_content()),
      minmax(length(2.0), grid_max_content()),
      minmax(grid_min_content(), grid_max_content()),
      minmax(grid_min_content(), auto()),
      minmax(grid_max_content(), auto()),
    ]),
    [
      node0, node1, node2, node3, node4, node5, node6, node7, node8, node9, node10,
      node11, node12, node13,
    ],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 322.0, 80.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 322.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 16.0, 40.0, 0.0, 40.0)
  assert_layout_xywh(taffy, node2, 95.0, 40.0, 16.0, 40.0)
  assert_layout_xywh(taffy, node3, 0.0, 40.0, 111.0, 40.0)
  assert_layout_xywh(taffy, node4, 0.0, 40.0, 111.0, 40.0)
  assert_layout_xywh(taffy, node5, 10.0, 40.0, 111.0, 40.0)
  assert_layout_xywh(taffy, node6, 64.0, 40.0, 121.0, 40.0)
  assert_layout_xywh(taffy, node7, 2.0, 40.0, 185.0, 40.0)
  assert_layout_xywh(taffy, node8, 4.0, 40.0, 187.0, 40.0)
  assert_layout_xywh(taffy, node9, 2.0, 40.0, 191.0, 40.0)
  assert_layout_xywh(taffy, node10, 2.0, 40.0, 193.0, 40.0)
  assert_layout_xywh(taffy, node11, 16.0, 40.0, 195.0, 40.0)
  assert_layout_xywh(taffy, node12, 15.0, 40.0, 211.0, 40.0)
  assert_layout_xywh(taffy, node13, 96.0, 40.0, 226.0, 40.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node2 = taffy.new_leaf_with_context(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=span(2))),
    TextMeasure::{ text_content: "HHHH\u{200b}HHHH", writing_mode: Horizontal },
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), auto()]),
    [node0, node1, node2],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 80.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 60.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 20.0, 40.0, 60.0, 0.0)
  assert_layout_xywh(taffy, node2, 80.0, 40.0, 0.0, 0.0)
}

///|
test "upstream/generated/grid/grid_span_2_max_content_auto_indefinite_hidden" {
  // Ported from taffy-reference/tests/generated/grid/grid_span_2_max_content_auto_indefinite_hidden.rs
  let taffy : TaffyTree[TextMeasure] = TaffyTree()
  let node0 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(1), end=place_auto())),
  )
  let node1 = taffy.new_leaf(
    Style::default()
    .with_grid_row(Line(start=line(1), end=place_auto()))
    .with_grid_column(Line(start=line(2), end=place_auto())),
  )
  let node = taffy.new_with_children(
    Style::default()
    .with_display(display_grid())
    .with_grid_template_rows([length(40.0)])
    .with_grid_template_columns([grid_max_content(), auto()]),
    [node0, node1],
  )
  taffy.compute_layout_with_measure(node, Size::max_content(), measure_text)
  assert_layout_xywh(taffy, node, 0.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node0, 0.0, 40.0, 0.0, 0.0)
  assert_layout_xywh(taffy, node1, 0.0, 40.0, 0.0, 0.0)
}
