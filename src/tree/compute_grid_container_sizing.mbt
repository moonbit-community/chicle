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
      let border_box = @util.max_double(
        @util.clamp_dimension(size, min_size, max_size, available_space),
        non_scroll_inset,
      )
      (border_box, @util.max_double(border_box - inset, 0.0))
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
  let border_box = @util.max_double(
    @util.clamp_dimension(
      @util.max_double(intrinsic_size + inset, inset),
      min_size,
      max_size,
      available_space,
    ),
    non_scroll_inset,
  )
  (border_box, @util.max_double(border_box - inset, 0.0))
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
fn[C] compute_initial_grid_track_sizing(
  view : ChicleView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  contributions : GridTrackContributions,
  col_gap : Double,
  row_gap : Double,
  content_width : Double,
  content_height : Double,
  available_space : Size[AvailableSpace],
  horiz_inset : Double,
  vert_inset : Double,
  specified_width : Double?,
  specified_height : Double?,
  justify_content_for_contrib : AlignContent,
  default_align_items_for_contrib : AlignItems,
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
) raise ChicleError {
  compute_grid_column_track_contributions(
    view, grid_items, placement_count, col_tracks, row_tracks, contributions, col_gap,
    row_gap, content_height, specified_height, true,
  )
  let mut col_min_basis = axis_min_content_basis(
    col_tracks,
    contributions.column_minimum,
    contributions.column_max_content,
    col_gap,
  )
  let mut col_max_basis = axis_max_content_basis(
    col_tracks,
    contributions.column_minimum,
    contributions.column_max_content,
    col_gap,
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
  let col_alignment_inner_size = match specified_width {
    Some(_) => Some(content_width)
    None =>
      match available_space.width {
        AvailDefinite(_) => Some(col_available)
        _ => None
      }
  }
  let mut col_sizes = track_sizing_algorithm(
      GridTrackSizingAlgorithmInput(
        tracks=col_tracks,
        available=col_available,
        gap=col_gap,
        min_contribution=contributions.column_minimum,
        max_content_contribution=contributions.column_max_content,
        expand_to_fill=specified_width is Some(_),
      ),
    ).sizes
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
  let col_gutter_alignment_adjustment = compute_alignment_gutter_adjustment(
    justify_content_for_contrib, col_alignment_inner_size, col_sizes, col_gap,
  )
  compute_grid_row_track_contributions(
    view, grid_items, placement_count, col_sizes, contributions, col_gap, col_gutter_alignment_adjustment,
    row_gap, default_align_items_for_contrib, default_justify_items_for_contrib,
  )
  let mut row_min_basis = axis_min_content_basis(
    row_tracks,
    contributions.row_minimum,
    contributions.row_max_content,
    row_gap,
  )
  let mut row_max_basis = axis_max_content_basis(
    row_tracks,
    contributions.row_minimum,
    contributions.row_max_content,
    row_gap,
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
  let mut row_sizes = track_sizing_algorithm(
      GridTrackSizingAlgorithmInput(
        tracks=row_tracks,
        available=row_available_base,
        gap=row_gap,
        min_contribution=contributions.row_minimum,
        max_content_contribution=contributions.row_max_content,
        expand_to_fill=specified_height is Some(_),
      ),
    ).sizes
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
  view : ChicleView[C],
  grid_items : Array[GridItem],
  placement_count : Int,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
  contributions : GridTrackContributions,
  col_available_base : Double,
  row_available_base : Double,
  col_gap : Double,
  row_gap : Double,
  content_height : Double,
  specified_width : Double?,
  specified_height : Double?,
  justify_content_for_contrib : AlignContent,
  default_align_items_for_contrib : AlignItems,
  default_justify_items_for_contrib : AlignItems,
) -> (Array[Double], Array[Double], Double, Double) raise ChicleError {
  contributions.reset()
  compute_grid_column_track_contributions(
    view, grid_items, placement_count, col_tracks, row_tracks, contributions, col_gap,
    row_gap, content_height, specified_height, false,
  )
  let col_sizes = track_sizing_algorithm(
      GridTrackSizingAlgorithmInput(
        tracks=col_tracks,
        available=col_available_base,
        gap=col_gap,
        min_contribution=contributions.column_minimum,
        max_content_contribution=contributions.column_max_content,
        expand_to_fill=specified_width is Some(_),
      ),
    ).sizes
  let col_gutter_alignment_adjustment = compute_alignment_gutter_adjustment(
    justify_content_for_contrib,
    match specified_width {
      Some(_) => Some(col_available_base)
      None => None
    },
    col_sizes,
    col_gap,
  )
  compute_grid_row_track_contributions(
    view, grid_items, placement_count, col_sizes, contributions, col_gap, col_gutter_alignment_adjustment,
    row_gap, default_align_items_for_contrib, default_justify_items_for_contrib,
  )
  let row_sizes = track_sizing_algorithm(
      GridTrackSizingAlgorithmInput(
        tracks=row_tracks,
        available=row_available_base,
        gap=row_gap,
        min_contribution=contributions.row_minimum,
        max_content_contribution=contributions.row_max_content,
        expand_to_fill=specified_height is Some(_),
      ),
    ).sizes
  (
    col_sizes,
    row_sizes,
    grid_axis_used_size(col_sizes, col_gap),
    grid_axis_used_size(row_sizes, row_gap),
  )
}
