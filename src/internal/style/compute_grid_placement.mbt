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
