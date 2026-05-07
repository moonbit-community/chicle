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
