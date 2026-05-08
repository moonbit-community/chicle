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
fn[C] compute_grid_size_estimate(
  tree : TaffyTree[C],
  children : Array[NodeId],
  explicit_col_count : Int,
  explicit_row_count : Int,
) -> (TrackCounts, TrackCounts) raise TaffyError {
  let mut col_min = 0
  let mut col_max = 0
  let mut col_max_span = 0
  let mut row_min = 0
  let mut row_max = 0
  let mut row_max_span = 0
  for child_id in children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let col_position = child_min_line_max_line_span(
      merged_placement_line(
        child.style.grid_column,
        child.style.grid_column_start,
      ),
      explicit_col_count,
    )
    let row_position = child_min_line_max_line_span(
      merged_placement_line(child.style.grid_row, child.style.grid_row_start),
      explicit_row_count,
    )
    col_min = min_int(col_min, col_position.0)
    col_max = max_int(col_max, col_position.1)
    col_max_span = max_int(col_max_span, col_position.2)
    row_min = min_int(row_min, row_position.0)
    row_max = max_int(row_max, row_position.1)
    row_max_span = max_int(row_max_span, row_position.2)
  }

  let negative_cols = if col_min < 0 { -col_min } else { 0 }
  let mut positive_cols = if col_max > explicit_col_count {
    col_max - explicit_col_count
  } else {
    0
  }
  let negative_rows = if row_min < 0 { -row_min } else { 0 }
  let mut positive_rows = if row_max > explicit_row_count {
    row_max - explicit_row_count
  } else {
    0
  }
  let total_cols = negative_cols + explicit_col_count + positive_cols
  if total_cols < col_max_span {
    positive_cols = col_max_span - explicit_col_count - negative_cols
  }
  let total_rows = negative_rows + explicit_row_count + positive_rows
  if total_rows < row_max_span {
    positive_rows = row_max_span - explicit_row_count - negative_rows
  }
  (
    TrackCounts::from_raw(
      negative_implicit=negative_cols,
      explicit=explicit_col_count,
      positive_implicit=positive_cols,
    ),
    TrackCounts::from_raw(
      negative_implicit=negative_rows,
      explicit=explicit_row_count,
      positive_implicit=positive_rows,
    ),
  )
}

///|
fn child_min_line_max_line_span(
  line : Line[GridPlacement],
  explicit_track_count : Int,
) -> (Int, Int, Int) {
  let resolved = axis_resolve_start_line_and_span(line, explicit_track_count)
  let min_line = match resolved.0 {
    Some(sl) => sl
    None => 0
  }
  let max_line = match resolved.0 {
    Some(sl) => sl + resolved.1
    None => 0
  }
  let span = match (line.start, line.end) {
    (PlaceAuto | PlaceSpan(_), PlaceAuto | PlaceSpan(_)) => resolved.1
    _ => 1
  }
  (min_line, max_line, span)
}

///|
fn min_int(a : Int, b : Int) -> Int {
  if a < b {
    a
  } else {
    b
  }
}

///|
fn max_int(a : Int, b : Int) -> Int {
  if a > b {
    a
  } else {
    b
  }
}
