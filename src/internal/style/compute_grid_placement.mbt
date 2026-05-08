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
fn merged_placement_line(
  placement : Line[GridPlacement],
  legacy_start : Int?,
) -> Line[GridPlacement] {
  match legacy_start {
    Some(v) => Line(start=PlaceLine(v), end=placement.end)
    None => placement
  }
}

///|
fn placement_span_value(span : Int) -> Int {
  if span > 0 {
    span
  } else {
    1
  }
}

///|
fn axis_resolve_start_line_and_span(
  placement : Line[GridPlacement],
  explicit_track_count : Int,
) -> (Int?, Int) {
  let start_line = match placement.start {
    PlaceLine(v) => origin_zero_line(v, explicit_track_count)
    _ => None
  }
  let end_line = match placement.end {
    PlaceLine(v) => origin_zero_line(v, explicit_track_count)
    _ => None
  }
  let explicit_span = match placement.start {
    PlaceSpan(s) => Some(placement_span_value(s))
    _ =>
      match placement.end {
        PlaceSpan(s) => Some(placement_span_value(s))
        _ => None
      }
  }
  match explicit_span {
    Some(span) =>
      match (start_line, end_line) {
        (Some(sl), _) => (Some(sl), span)
        (None, Some(el)) => (Some(el - span), span)
        _ => (None, span)
      }
    None =>
      match (start_line, end_line) {
        (Some(sl), Some(el)) => {
          let span = if el > sl { el - sl } else { 1 }
          (Some(sl), span)
        }
        (Some(sl), None) => (Some(sl), 1)
        (None, Some(el)) => (Some(el - 1), 1)
        _ => (None, 1)
      }
  }
}

///|
fn axis_auto_track_list(auto_tracks : Array[Dimension]) -> Array[Dimension] {
  if auto_tracks.length() == 0 {
    [DimAuto]
  } else {
    auto_tracks
  }
}

///|
fn negative_auto_track_at(
  auto_tracks : Array[Dimension],
  offset_from_explicit : Int,
) -> Dimension {
  let len = auto_tracks.length()
  if len == 0 {
    DimAuto
  } else {
    // `offset_from_explicit` is 1-based: 1 means the track adjacent to the explicit grid.
    let m = offset_from_explicit % len
    let idx = (len - m) % len
    auto_tracks[idx]
  }
}

///|
fn axis_start_index_and_span(
  placement : Line[GridPlacement],
  legacy_start : Int?,
  explicit_track_count : Int,
  negative_implicit : Int,
) -> (Int?, Int) {
  let merged = merged_placement_line(placement, legacy_start)
  let resolved = axis_resolve_start_line_and_span(merged, explicit_track_count)
  let start = match resolved.0 {
    Some(sl) => Some(sl + negative_implicit)
    None => None
  }
  (start, resolved.1)
}

///|
fn child_start_indexes_and_spans(
  child_style : Style,
  explicit_cols : Int,
  explicit_rows : Int,
  negative_cols : Int,
  negative_rows : Int,
) -> (Int?, Int, Int?, Int) {
  let col = axis_start_index_and_span(
    child_style.grid_column,
    child_style.grid_column_start,
    explicit_cols,
    negative_cols,
  )
  let row = axis_start_index_and_span(
    child_style.grid_row,
    child_style.grid_row_start,
    explicit_rows,
    negative_rows,
  )
  (row.0, row.1, col.0, col.1)
}

///|
fn track_basis_fit_content(
  min_c : Double,
  max_c : Double,
  limit : Dimension,
  available : Double,
) -> Double {
  match limit {
    DimPercent(_) => max_c
    _ => {
      let lim = resolve_track_dimension(limit, available)
      let preferred = if max_c < lim { max_c } else { lim }
      if preferred < min_c {
        min_c
      } else {
        preferred
      }
    }
  }
}

///|
fn axis_min_content_basis(
  tracks : Array[Dimension],
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  gap : Double,
) -> Double {
  let mut total = 0.0
  let mut fr_sum = 0.0
  let mut fr_fraction = 0.0
  for i in 0..<tracks.length() {
    let min_c = min_contrib[i]
    let max_c = max_contrib[i]
    match tracks[i] {
      DimFr(w) =>
        if w > 0.0 {
          fr_sum = fr_sum + w
          let ratio = min_c / w
          if ratio > fr_fraction {
            fr_fraction = ratio
          }
        } else {
          total = total + min_c
        }
      _ =>
        total = total +
          (match tracks[i] {
            DimLength(v) => v
            DimAuto => min_c
            DimPercent(_) => min_c
            DimMinContent => min_c
            DimMaxContent => max_c
            DimFitContent(limit) =>
              track_basis_fit_content(min_c, max_c, limit, 0.0)
            DimMinMax(min_d, _max_d) =>
              // Conservative: use the min sizing function where possible.
              match min_d {
                DimAuto | DimMinContent => min_c
                DimMaxContent => max_c
                _ => resolve_track_dimension(min_d, 0.0)
              }
            _ => 0.0
          })
    }
  }
  total = total + fr_fraction * fr_sum
  if tracks.length() > 1 {
    total = total + gap * (tracks.length() - 1).to_double()
  }
  total
}

///|
fn axis_max_content_basis(
  tracks : Array[Dimension],
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  gap : Double,
) -> Double {
  let mut total = 0.0
  let mut fr_sum = 0.0
  let mut fr_fraction = 0.0
  for i in 0..<tracks.length() {
    let min_c = min_contrib[i]
    let max_c = max_contrib[i]
    match tracks[i] {
      DimFr(w) =>
        if w > 0.0 {
          fr_sum = fr_sum + w
          let ratio = max_c / w
          if ratio > fr_fraction {
            fr_fraction = ratio
          }
        } else {
          total = total + max_c
        }
      _ =>
        total = total +
          (match tracks[i] {
            DimLength(v) => v
            DimAuto => max_c
            DimPercent(_) => max_c
            DimMinContent => min_c
            DimMaxContent => max_c
            DimFitContent(limit) =>
              track_basis_fit_content(min_c, max_c, limit, 0.0)
            DimMinMax(_min_d, max_d) => {
              let min_basis = match _min_d {
                DimAuto => 0.0
                DimMinContent => min_c
                DimMaxContent => max_c
                DimFitContent(limit) =>
                  track_basis_fit_content(min_c, max_c, limit, 0.0)
                _ => resolve_track_dimension(_min_d, 0.0)
              }
              let max_basis = match max_d {
                DimAuto | DimMaxContent => max_c
                DimMinContent => min_c
                DimPercent(_) => max_c
                DimFr(_) => max_c
                DimFitContent(limit) =>
                  track_basis_fit_content(min_c, max_c, limit, 0.0)
                _ => resolve_track_dimension(max_d, 0.0)
              }
              if max_basis < min_basis {
                min_basis
              } else {
                max_basis
              }
            }
            _ => 0.0
          })
    }
  }
  total = total + fr_fraction * fr_sum
  if tracks.length() > 1 {
    total = total + gap * (tracks.length() - 1).to_double()
  }
  total
}

///|
fn available_inset_or_basis(
  available : AvailableSpace,
  inset : Double,
  min_basis : Double,
  max_basis : Double,
) -> Double {
  match available {
    AvailDefinite(v) => max_double(v - inset, 0.0)
    AvailMinContent => min_basis
    AvailMaxContent => max_basis
  }
}

///|
fn resolve_grid_abs_line_position(lines : Array[Double], line : Int) -> Double {
  let last = lines.length() - 1
  if last <= 0 {
    lines[0]
  } else {
    let raw = if line > 0 { line - 1 } else { last + line + 1 }
    let idx = if raw < 0 { 0 } else if raw > last { last } else { raw }
    lines[idx]
  }
}

///|
fn resolve_grid_abs_axis_containing_block(
  placement : Line[GridPlacement],
  lines : Array[Double],
  padding_box_size : Double,
) -> (Double, Double) {
  let start_line = match placement.start {
    PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
    _ => None
  }
  let end_line = match placement.end {
    PlaceLine(v) => Some(resolve_grid_abs_line_position(lines, v))
    _ => None
  }
  let start_pos = match (start_line, end_line) {
    (Some(s), _) => s
    (None, Some(_)) => 0.0
    (None, None) => 0.0
  }
  let end_pos = match (start_line, end_line) {
    (_, Some(e)) => e
    (Some(_), None) => padding_box_size
    (None, None) => padding_box_size
  }
  if end_pos >= start_pos {
    (start_pos, end_pos)
  } else {
    (end_pos, start_pos)
  }
}
