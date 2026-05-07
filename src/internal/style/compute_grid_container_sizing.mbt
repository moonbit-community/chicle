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
fn grid_axis_used_size(track_sizes : Array[Double], gap : Double) -> Double {
  let mut used = 0.0
  for size in track_sizes {
    used = used + size
  }
  let track_count = track_sizes.length()
  if track_count > 1 {
    used + gap * (track_count - 1).to_double()
  } else {
    used
  }
}

///|
fn grid_definite_axis_border_content_size(
  specified_size : Double?,
  min_size : Dimension,
  max_size : Dimension,
  available_space : AvailableSpace,
  inset : Double,
  non_scroll_inset : Double,
) -> (Double, Double) {
  match specified_size {
    Some(size) => {
      let border_box = max_double(
        clamp_dimension(size, min_size, max_size, available_space),
        non_scroll_inset,
      )
      (border_box, max_double(border_box - inset, 0.0))
    }
    None => (0.0, 0.0)
  }
}

///|
fn grid_auto_axis_border_content_size(
  available_space : AvailableSpace,
  inset : Double,
  non_scroll_inset : Double,
  min_size : Dimension,
  max_size : Dimension,
  min_basis : Double,
  max_basis : Double,
  used_size : Double,
) -> (Double, Double) {
  let intrinsic_size = match available_space {
    AvailMaxContent => max_basis
    AvailMinContent => min_basis
    AvailDefinite(_) => used_size
  }
  let border_box = max_double(
    clamp_dimension(
      max_double(intrinsic_size + inset, inset),
      min_size,
      max_size,
      available_space,
    ),
    non_scroll_inset,
  )
  (border_box, max_double(border_box - inset, 0.0))
}

///|
fn resolve_deferred_grid_percent_gaps(
  content_width : Double,
  col_gap : Double,
  row_gap : Double,
  gap_width_percent : Double?,
  gap_height_percent : Double?,
) -> (Double, Double, Bool) {
  let mut resolved_col_gap = col_gap
  let mut resolved_row_gap = row_gap
  let mut rerun_track_sizing = false
  match gap_width_percent {
    Some(percent) =>
      if resolved_col_gap == 0.0 && content_width > 0.0 {
        resolved_col_gap = content_width * percent
        rerun_track_sizing = true
      }
    None => ()
  }
  match gap_height_percent {
    Some(percent) =>
      if resolved_row_gap == 0.0 && content_width > 0.0 {
        resolved_row_gap = content_width * percent
        rerun_track_sizing = true
      }
    None => ()
  }
  (resolved_col_gap, resolved_row_gap, rerun_track_sizing)
}

///|
fn[C] compute_grid_column_track_contributions(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  col_min_contrib : Array[Double],
  col_max_contrib : Array[Double],
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
    item.apply_column_contributions(
      col_tracks, col_min_contrib, col_max_contrib,
    )
  }
}

///|
fn[C] compute_grid_row_track_contributions(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_sizes : Array[Double],
  row_min_contrib : Array[Double],
  row_max_contrib : Array[Double],
  col_gap : Double,
  row_gap : Double,
  default_justify_items_for_contrib : AlignItems,
) -> Unit raise TaffyError {
  let tree = view.tree
  for i in 0..<placement_count {
    if !grid_items[i].placed {
      continue
    }
    let item = grid_items[i]
    let child_id = item.node
    let child_style = item.style
    let mut col_w = 0.0
    for j in item.column..<(item.column + item.column_span) {
      col_w = col_w + col_sizes[j]
    }
    if item.column_span > 1 {
      col_w = col_w + col_gap * (item.column_span - 1).to_double()
    }
    let row_gap_total = row_gap * (item.row_span - 1).to_double()
    let resolved_margin = resolve_rect_width_basis(
      child_style.margin,
      Size(width=AvailDefinite(col_w), height=AvailMaxContent),
    )
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
    view.perform_child_layout(
      child_id,
      Size(width=known_w_for_contrib, height=None),
      Size(width=AvailDefinite(col_w), height=AvailMaxContent),
      Point::zero(),
      false,
    )
    let max_h = tree.nodes[child_id].unrounded_layout.size.height
    let max_needed = max_double(
      max_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
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
      min_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
      0.0,
    )
    item.set_row_contributions(minimum=min_needed, max_content=max_needed)
    item.apply_row_contributions(row_min_contrib, row_max_contrib)
  }
}

///|
fn reset_grid_track_contributions(
  col_min_contrib : Array[Double],
  col_max_contrib : Array[Double],
  row_min_contrib : Array[Double],
  row_max_contrib : Array[Double],
) -> Unit {
  for i in 0..<col_min_contrib.length() {
    col_min_contrib[i] = 0.0
    col_max_contrib[i] = 0.0
  }
  for i in 0..<row_min_contrib.length() {
    row_min_contrib[i] = 0.0
    row_max_contrib[i] = 0.0
  }
}

///|
fn[C] compute_initial_grid_track_sizing(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  col_min_contrib : Array[Double],
  col_max_contrib : Array[Double],
  row_min_contrib : Array[Double],
  row_max_contrib : Array[Double],
  col_gap : Double,
  row_gap : Double,
  content_width : Double,
  content_height : Double,
  available_space : Size[AvailableSpace],
  horiz_inset : Double,
  vert_inset : Double,
  specified_width : Double?,
  specified_height : Double?,
  default_justify_items_for_contrib : AlignItems,
) -> (
  Array[Double],
  Array[Double],
  Double,
  Double,
  Double,
  Double,
  Double,
  Double,
) raise TaffyError {
  compute_grid_column_track_contributions(
    view, grid_items, placement_count, col_tracks, row_tracks, col_min_contrib, col_max_contrib,
    col_gap, row_gap, content_height, specified_height, true,
  )
  let mut col_min_basis = axis_min_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let mut col_max_basis = axis_max_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let mut col_available = match specified_width {
    Some(_) => content_width
    None =>
      available_inset_or_basis(
        available_space.width,
        horiz_inset,
        col_min_basis,
        col_max_basis,
      )
  }
  let mut col_available_base = col_available
  let mut col_sizes = compute_grid_track_sizes_with_contributions(
    col_tracks,
    col_available,
    col_gap,
    col_min_contrib,
    col_max_contrib,
    specified_width is Some(_),
  )
  if specified_width is None && available_space.width is AvailMaxContent {
    match
      compute_max_content_spanning_track_sizes_for_grid_items(
        col_tracks, grid_items,
      ) {
      Some(result) => {
        col_sizes = result.0
        col_available = result.1
        col_available_base = col_available
        let basis_with_gaps = result.1 +
          col_gap * (col_tracks.length() - 1).to_double()
        col_min_basis = basis_with_gaps
        col_max_basis = basis_with_gaps
      }
      None => ()
    }
  }
  compute_grid_row_track_contributions(
    view, grid_items, placement_count, col_sizes, row_min_contrib, row_max_contrib,
    col_gap, row_gap, default_justify_items_for_contrib,
  )
  let mut row_min_basis = axis_min_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let mut row_max_basis = axis_max_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let mut row_available_base = match specified_height {
    Some(_) => content_height
    None =>
      available_inset_or_basis(
        available_space.height,
        vert_inset,
        row_min_basis,
        row_max_basis,
      )
  }
  let mut row_sizes = compute_grid_track_sizes_with_contributions(
    row_tracks,
    row_available_base,
    row_gap,
    row_min_contrib,
    row_max_contrib,
    specified_height is Some(_),
  )
  if specified_height is None && available_space.height is AvailMaxContent {
    match
      compute_max_content_spanning_row_track_sizes_for_grid_items(
        row_tracks, grid_items,
      ) {
      Some(result) => {
        row_sizes = result.0
        row_available_base = result.1
        let basis_with_gaps = result.1 +
          row_gap * (row_tracks.length() - 1).to_double()
        row_min_basis = basis_with_gaps
        row_max_basis = basis_with_gaps
      }
      None => ()
    }
  }
  (
    col_sizes, row_sizes, col_min_basis, col_max_basis, col_available_base, row_min_basis,
    row_max_basis, row_available_base,
  )
}

///|
fn[C] rerun_grid_track_sizing_after_percent_gap_resolution(
  view : TaffyView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  col_min_contrib : Array[Double],
  col_max_contrib : Array[Double],
  row_min_contrib : Array[Double],
  row_max_contrib : Array[Double],
  col_available_base : Double,
  row_available_base : Double,
  col_gap : Double,
  row_gap : Double,
  content_height : Double,
  specified_width : Double?,
  specified_height : Double?,
  default_justify_items_for_contrib : AlignItems,
) -> (Array[Double], Array[Double], Double, Double) raise TaffyError {
  reset_grid_track_contributions(
    col_min_contrib, col_max_contrib, row_min_contrib, row_max_contrib,
  )
  compute_grid_column_track_contributions(
    view, grid_items, placement_count, col_tracks, row_tracks, col_min_contrib, col_max_contrib,
    col_gap, row_gap, content_height, specified_height, false,
  )
  let col_sizes = compute_grid_track_sizes_with_contributions(
    col_tracks,
    col_available_base,
    col_gap,
    col_min_contrib,
    col_max_contrib,
    specified_width is Some(_),
  )
  compute_grid_row_track_contributions(
    view, grid_items, placement_count, col_sizes, row_min_contrib, row_max_contrib,
    col_gap, row_gap, default_justify_items_for_contrib,
  )
  let row_sizes = compute_grid_track_sizes_with_contributions(
    row_tracks,
    row_available_base,
    row_gap,
    row_min_contrib,
    row_max_contrib,
    specified_height is Some(_),
  )
  (
    col_sizes,
    row_sizes,
    grid_axis_used_size(col_sizes, col_gap),
    grid_axis_used_size(row_sizes, row_gap),
  )
}
