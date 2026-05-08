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
priv struct GridTrackContributions {
  column_minimum : Array[Double]
  column_max_content : Array[Double]
  row_minimum : Array[Double]
  row_max_content : Array[Double]
}

///|
fn GridTrackContributions::GridTrackContributions(
  column_count~ : Int,
  row_count~ : Int,
) -> GridTrackContributions {
  {
    column_minimum: Array::make(column_count, 0.0),
    column_max_content: Array::make(column_count, 0.0),
    row_minimum: Array::make(row_count, 0.0),
    row_max_content: Array::make(row_count, 0.0),
  }
}

///|
fn GridTrackContributions::reset(self : GridTrackContributions) -> Unit {
  for i in 0..<self.column_minimum.length() {
    self.column_minimum[i] = 0.0
    self.column_max_content[i] = 0.0
  }
  for i in 0..<self.row_minimum.length() {
    self.row_minimum[i] = 0.0
    self.row_max_content[i] = 0.0
  }
}

///|
fn GridTrackContributions::apply_column_item(
  self : GridTrackContributions,
  item : GridItem,
  col_tracks : Array[Dimension],
) -> Unit {
  apply_col_contribution(
    col_tracks,
    item.column,
    item.column_span,
    item.column_minimum_contribution,
    self.column_minimum,
  )
  apply_col_contribution(
    col_tracks,
    item.column,
    item.column_span,
    item.column_max_content_contribution,
    self.column_max_content,
  )
}

///|
fn GridTrackContributions::apply_row_item(
  self : GridTrackContributions,
  item : GridItem,
) -> Unit {
  let min_share = item.row_minimum_contribution / item.row_span.to_double()
  let max_share = item.row_max_content_contribution / item.row_span.to_double()
  for j in item.row..<(item.row + item.row_span) {
    if min_share > self.row_minimum[j] {
      self.row_minimum[j] = min_share
    }
    if max_share > self.row_max_content[j] {
      self.row_max_content[j] = max_share
    }
  }
}

///|
fn compute_alignment_gutter_adjustment(
  alignment : AlignContent,
  axis_inner_node_size : Double?,
  track_sizes : Array[Double],
  gap : Double,
) -> Double {
  if track_sizes.length() <= 1 {
    return 0.0
  }
  let inner_gutter_weight = match alignment {
    AlignSpaceBetween => 1
    AlignSpaceAround => 2
    AlignSpaceEvenly => 1
    _ => 0
  }
  if inner_gutter_weight == 0 {
    return 0.0
  }
  let outer_gutter_weight = match alignment {
    AlignFlexStart | AlignStart | AlignFlexEnd | AlignEnd | AlignCenter => 1
    AlignSpaceAround | AlignSpaceEvenly => 1
    _ => 0
  }
  match axis_inner_node_size {
    Some(inner_size) => {
      let mut track_size_sum = 0.0
      for size in track_sizes {
        track_size_sum = track_size_sum + size
      }
      track_size_sum = track_size_sum +
        gap * (track_sizes.length() - 1).to_double()
      let free_space = max_double(inner_size - track_size_sum, 0.0)
      let weighted_gutter_count = (track_sizes.length() - 1) *
        inner_gutter_weight +
        2 * outer_gutter_weight
      if weighted_gutter_count == 0 {
        0.0
      } else {
        free_space /
        weighted_gutter_count.to_double() *
        inner_gutter_weight.to_double()
      }
    }
    None => 0.0
  }
}

///|
fn grid_item_contribution_column_width(
  item : GridItem,
  col_sizes : Array[Double],
  col_gap : Double,
  col_gutter_alignment_adjustment : Double,
) -> Double {
  let mut col_w = 0.0
  for j in item.column..<(item.column + item.column_span) {
    col_w = col_w + col_sizes[j]
  }
  if item.column_span > 1 {
    col_w = col_w +
      (col_gap + col_gutter_alignment_adjustment) *
      (item.column_span - 1).to_double()
  }
  col_w
}

///|
fn grid_item_known_width_for_row_contribution(
  child_style : Style,
  col_w : Double,
  resolved_margin : Rect[Double],
  default_justify_items_for_contrib : AlignItems,
) -> Double? {
  let margin_left_auto = child_style.margin.left is DimAuto
  let margin_right_auto = child_style.margin.right is DimAuto
  let has_auto_margin_x = margin_left_auto || margin_right_auto
  let justify = match child_style.justify_self {
    Some(value) => value
    None => default_justify_items_for_contrib
  }
  let available_w_for_item = max_double(
    col_w - resolved_margin.left - resolved_margin.right,
    0.0,
  )
  let mut known_w_for_contrib = resolve_optional_dimension(
    child_style.size.width,
    AvailDefinite(col_w),
  )
  if known_w_for_contrib is None &&
    child_style.size.width is DimAuto &&
    justify is ItemsStretch &&
    !has_auto_margin_x {
    known_w_for_contrib = Some(available_w_for_item)
  }
  known_w_for_contrib
}

///|
fn[C] resolve_grid_item_baseline_shims_for_track_sizing(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_sizes : Array[Double],
  col_gap : Double,
  col_gutter_alignment_adjustment : Double,
  default_align_items_for_contrib : AlignItems,
  default_justify_items_for_contrib : AlignItems,
) -> Unit raise TaffyError {
  let mut row_count = 0
  for item in grid_items {
    if item.placed && item.row_span == 1 && item.row + 1 > row_count {
      row_count = item.row + 1
    }
  }
  if row_count == 0 {
    return
  }
  let baseline_item_count : Array[Int] = Array::make(row_count, 0)
  let row_max_baseline : Array[Double] = Array::make(row_count, 0.0)
  let measured_baseline : Array[Double] = Array::make(placement_count, 0.0)
  let measured_margin_top : Array[Double] = Array::make(placement_count, 0.0)
  let tree = view.tree
  for i in 0..<placement_count {
    let item = grid_items[i]
    if !item.is_relative_grid_child() || !item.placed || item.row_span != 1 {
      continue
    }
    let child_style = item.style
    let align = match child_style.align_self {
      Some(v) => v
      None => default_align_items_for_contrib
    }
    if !(align is ItemsBaseline) {
      continue
    }
    baseline_item_count[item.row] = baseline_item_count[item.row] + 1
  }
  for i in 0..<placement_count {
    let item = grid_items[i]
    if !item.is_relative_grid_child() ||
      !item.placed ||
      item.row_span != 1 ||
      baseline_item_count[item.row] <= 1 {
      continue
    }
    let child_style = item.style
    let col_w = grid_item_contribution_column_width(
      item, col_sizes, col_gap, col_gutter_alignment_adjustment,
    )
    let resolved_margin = resolve_rect_width_basis(
      child_style.margin,
      Size(width=AvailDefinite(col_w), height=AvailMaxContent),
    )
    let known_w_for_contrib = grid_item_known_width_for_row_contribution(
      child_style, col_w, resolved_margin, default_justify_items_for_contrib,
    )
    view.perform_child_layout(
      item.node,
      Size(width=known_w_for_contrib, height=None),
      Size(width=AvailDefinite(col_w), height=AvailMinContent),
      Point::zero(),
      false,
    )
    let baseline = grid_item_baseline_offset_y(tree, item.node)
    let baseline_before = resolved_margin.top + baseline
    measured_baseline[i] = baseline
    measured_margin_top[i] = resolved_margin.top
    row_max_baseline[item.row] = max_double(
      row_max_baseline[item.row],
      baseline_before,
    )
  }
  for i in 0..<placement_count {
    let item = grid_items[i]
    if !item.is_relative_grid_child() ||
      !item.placed ||
      item.row_span != 1 ||
      baseline_item_count[item.row] <= 1 {
      continue
    }
    item.set_baseline_and_shim(
      baseline=measured_baseline[i],
      baseline_shim=max_double(
        row_max_baseline[item.row] -
        measured_margin_top[i] -
        measured_baseline[i],
        0.0,
      ),
    )
  }
}

///|
fn[C] compute_grid_column_track_contributions(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  contributions : GridTrackContributions,
  col_gap : Double,
  row_gap : Double,
  content_height : Double,
  specified_height : Double?,
  use_row_track_constraints : Bool,
) -> Unit raise TaffyError {
  let tree = view.tree
  for i in 0..<placement_count {
    if !grid_items[i].placed {
      continue
    }
    let item = grid_items[i]
    let child_id = item.node
    let child_style = item.style
    let gap_total = col_gap * (item.column_span - 1).to_double()
    let contrib_available_height = match specified_height {
      Some(_) => AvailDefinite(content_height)
      None =>
        if use_row_track_constraints {
          match
            spanned_definite_len(row_tracks, item.row, item.row_span, row_gap) {
            Some(size) => AvailDefinite(size)
            None => AvailMaxContent
          }
        } else {
          AvailMaxContent
        }
    }
    view.perform_child_layout(
      child_id,
      Size(width=None, height=None),
      Size(width=AvailMaxContent, height=contrib_available_height),
      Point::zero(),
      false,
    )
    let max_sz = tree.nodes[child_id].unrounded_layout.size
    let resolved_margin = resolve_rect_width_basis(
      child_style.margin,
      Size(width=AvailMaxContent, height=AvailMaxContent),
    )
    let max_needed = max_double(
      max_sz.width + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    view.perform_child_layout(
      child_id,
      Size(width=None, height=None),
      Size(width=AvailMinContent, height=contrib_available_height),
      Point::zero(),
      false,
    )
    let min_col_raw = tree.nodes[child_id].unrounded_layout.size.width
    let min_col = match (child_style.overflow.x, child_style.overflow.y) {
      (OverflowVisible, OverflowVisible) => min_col_raw
      _ => 0.0
    }
    let min_content_needed = max_double(
      min_col_raw + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    let min_needed = max_double(
      min_col + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    item.set_column_contributions(
      minimum=min_needed,
      min_content=min_content_needed,
      max_content=max_needed,
    )
    contributions.apply_column_item(item, col_tracks)
  }
}

///|
fn[C] compute_grid_row_track_contributions(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_sizes : Array[Double],
  contributions : GridTrackContributions,
  col_gap : Double,
  col_gutter_alignment_adjustment : Double,
  row_gap : Double,
  default_align_items_for_contrib : AlignItems,
  default_justify_items_for_contrib : AlignItems,
) -> Unit raise TaffyError {
  let tree = view.tree
  resolve_grid_item_baseline_shims_for_track_sizing(
    view, grid_items, placement_count, col_sizes, col_gap, col_gutter_alignment_adjustment,
    default_align_items_for_contrib, default_justify_items_for_contrib,
  )
  for i in 0..<placement_count {
    if !grid_items[i].placed {
      continue
    }
    let item = grid_items[i]
    let child_id = item.node
    let child_style = item.style
    let col_w = grid_item_contribution_column_width(
      item, col_sizes, col_gap, col_gutter_alignment_adjustment,
    )
    let row_gap_total = row_gap * (item.row_span - 1).to_double()
    let resolved_margin = resolve_rect_width_basis(
      child_style.margin,
      Size(width=AvailDefinite(col_w), height=AvailMaxContent),
    )
    let known_w_for_contrib = grid_item_known_width_for_row_contribution(
      child_style, col_w, resolved_margin, default_justify_items_for_contrib,
    )
    view.perform_child_layout(
      child_id,
      Size(width=known_w_for_contrib, height=None),
      Size(width=AvailDefinite(col_w), height=AvailMaxContent),
      Point::zero(),
      false,
    )
    let max_h = tree.nodes[child_id].unrounded_layout.size.height
    let max_needed = max_double(
      max_h +
      resolved_margin.top +
      resolved_margin.bottom +
      item.baseline_shim -
      row_gap_total,
      0.0,
    )
    view.perform_child_layout(
      child_id,
      Size(width=known_w_for_contrib, height=None),
      Size(width=AvailDefinite(col_w), height=AvailMinContent),
      Point::zero(),
      false,
    )
    let min_h_raw = tree.nodes[child_id].unrounded_layout.size.height
    let min_h = match (child_style.overflow.x, child_style.overflow.y) {
      (OverflowVisible, OverflowVisible) => min_h_raw
      _ => 0.0
    }
    let min_needed = max_double(
      min_h +
      resolved_margin.top +
      resolved_margin.bottom +
      item.baseline_shim -
      row_gap_total,
      0.0,
    )
    item.set_row_contributions(minimum=min_needed, max_content=max_needed)
    contributions.apply_row_item(item)
  }
}
