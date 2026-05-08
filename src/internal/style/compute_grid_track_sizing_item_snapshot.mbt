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
priv struct GridTrackSizingItemSnapshot {
  placed : Array[Bool]
  start : Array[Int]
  span : Array[Int]
  minimum_contribution : Array[Double]
  min_content_contribution : Array[Double]
  max_content_contribution : Array[Double]
  crosses_flexible_track : Array[Bool]
  crosses_intrinsic_track : Array[Bool]
}

///|
fn grid_column_track_sizing_item_snapshot(
  items : Array[GridItem],
) -> GridTrackSizingItemSnapshot {
  let placed : Array[Bool] = []
  let start : Array[Int] = []
  let span : Array[Int] = []
  let minimum_contribution : Array[Double] = []
  let min_content_contribution : Array[Double] = []
  let max_content_contribution : Array[Double] = []
  let crosses_flexible_track : Array[Bool] = []
  let crosses_intrinsic_track : Array[Bool] = []
  for item in items {
    ignore(item.source_order)
    placed.push(item.placed)
    start.push(item.column)
    span.push(item.column_span)
    minimum_contribution.push(item.column_minimum_contribution)
    min_content_contribution.push(item.column_min_content_contribution)
    max_content_contribution.push(item.column_max_content_contribution)
    crosses_flexible_track.push(item.crosses_flexible_column)
    crosses_intrinsic_track.push(item.crosses_intrinsic_column)
  }
  {
    placed,
    start,
    span,
    minimum_contribution,
    min_content_contribution,
    max_content_contribution,
    crosses_flexible_track,
    crosses_intrinsic_track,
  }
}

///|
fn grid_row_track_sizing_item_snapshot(
  items : Array[GridItem],
) -> GridTrackSizingItemSnapshot {
  let placed : Array[Bool] = []
  let start : Array[Int] = []
  let span : Array[Int] = []
  let minimum_contribution : Array[Double] = []
  let min_content_contribution : Array[Double] = []
  let max_content_contribution : Array[Double] = []
  let crosses_flexible_track : Array[Bool] = []
  let crosses_intrinsic_track : Array[Bool] = []
  for item in items {
    ignore(item.source_order)
    placed.push(item.placed)
    start.push(item.row)
    span.push(item.row_span)
    minimum_contribution.push(item.row_minimum_contribution)
    min_content_contribution.push(item.row_minimum_contribution)
    max_content_contribution.push(item.row_max_content_contribution)
    crosses_flexible_track.push(item.crosses_flexible_row)
    crosses_intrinsic_track.push(item.crosses_intrinsic_row)
  }
  {
    placed,
    start,
    span,
    minimum_contribution,
    min_content_contribution,
    max_content_contribution,
    crosses_flexible_track,
    crosses_intrinsic_track,
  }
}

///|
fn compute_max_content_spanning_track_sizes_for_snapshot(
  tracks : Array[Dimension],
  snapshot : GridTrackSizingItemSnapshot,
) -> (Array[Double], Double)? {
  let mut has_spanning_item = false
  let mut has_flexible_spanning_item = false
  let mut has_intrinsic_spanning_item = false
  for i in 0..<snapshot.placed.length() {
    if snapshot.placed[i] && snapshot.span[i] > 1 {
      has_spanning_item = true
      if snapshot.crosses_flexible_track[i] {
        has_flexible_spanning_item = true
      }
      if snapshot.crosses_intrinsic_track[i] {
        has_intrinsic_spanning_item = true
      }
    }
  }
  if !has_spanning_item ||
    (!has_flexible_spanning_item && !has_intrinsic_spanning_item) {
    return None
  }
  compute_max_content_spanning_track_sizes(tracks, snapshot)
}

///|
fn compute_max_content_spanning_track_sizes_for_grid_items(
  tracks : Array[Dimension],
  items : Array[GridItem],
) -> (Array[Double], Double)? {
  compute_max_content_spanning_track_sizes_for_snapshot(
    tracks,
    grid_column_track_sizing_item_snapshot(items),
  )
}

///|
fn compute_max_content_spanning_row_track_sizes_for_grid_items(
  tracks : Array[Dimension],
  items : Array[GridItem],
) -> (Array[Double], Double)? {
  compute_max_content_spanning_track_sizes_for_snapshot(
    tracks,
    grid_row_track_sizing_item_snapshot(items),
  )
}
