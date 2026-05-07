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
priv struct GridItem {
  node : NodeId
  source_order : Int
  style : Style
  mut placed : Bool
  mut row : Int
  mut column : Int
  mut row_span : Int
  mut column_span : Int
  mut column_minimum_contribution : Double
  mut column_min_content_contribution : Double
  mut column_max_content_contribution : Double
  mut row_minimum_contribution : Double
  mut row_max_content_contribution : Double
  mut baseline : Double
  mut baseline_shim : Double
  mut crosses_flexible_row : Bool
  mut crosses_flexible_column : Bool
  mut crosses_intrinsic_row : Bool
  mut crosses_intrinsic_column : Bool
  mut y_position : Double
  mut height : Double
}

///|
fn GridItem::GridItem(
  node~ : NodeId,
  source_order~ : Int,
  style~ : Style,
) -> GridItem {
  {
    node,
    source_order,
    style,
    placed: false,
    row: 0,
    column: 0,
    row_span: 1,
    column_span: 1,
    column_minimum_contribution: 0.0,
    column_min_content_contribution: 0.0,
    column_max_content_contribution: 0.0,
    row_minimum_contribution: 0.0,
    row_max_content_contribution: 0.0,
    baseline: 0.0,
    baseline_shim: 0.0,
    crosses_flexible_row: false,
    crosses_flexible_column: false,
    crosses_intrinsic_row: false,
    crosses_intrinsic_column: false,
    y_position: 0.0,
    height: 0.0,
  }
}

///|
fn GridItem::place(
  self : GridItem,
  row~ : Int,
  column~ : Int,
  row_span~ : Int,
  column_span~ : Int,
) -> Unit {
  self.placed = true
  self.row = row
  self.column = column
  self.row_span = row_span
  self.column_span = column_span
}

///|
fn[C] make_grid_items(
  tree : TaffyTree[C],
  children : Array[NodeId],
) -> Array[GridItem] raise TaffyError {
  let items : Array[GridItem] = []
  for i, node in children {
    let node_data = match tree.nodes.get(node) {
      Some(data) => data
      None => raise InvalidNodeId(node)
    }
    items.push(GridItem(node~, source_order=i, style=node_data.style))
  }
  items
}

///|
fn GridItem::participates_in_grid(self : GridItem) -> Bool {
  !(self.style.display is DisplayNone) && self.style.position is PosRelative
}

///|
fn GridItem::placement_indexes_and_spans(
  self : GridItem,
  explicit_cols : Int,
  explicit_rows : Int,
  negative_cols : Int,
  negative_rows : Int,
) -> (Int?, Int, Int?, Int) {
  child_start_indexes_and_spans(
    self.style,
    explicit_cols,
    explicit_rows,
    negative_cols,
    negative_rows,
  )
}

///|
fn GridItem::set_column_contributions(
  self : GridItem,
  minimum~ : Double,
  min_content~ : Double,
  max_content~ : Double,
) -> Unit {
  self.column_minimum_contribution = minimum
  self.column_min_content_contribution = min_content
  self.column_max_content_contribution = max_content
}

///|
fn GridItem::set_row_contributions(
  self : GridItem,
  minimum~ : Double,
  max_content~ : Double,
) -> Unit {
  self.row_minimum_contribution = minimum
  self.row_max_content_contribution = max_content
}

///|
fn GridItem::set_baseline(self : GridItem, baseline~ : Double) -> Unit {
  self.baseline = baseline
}

///|
fn GridItem::set_baseline_shim(
  self : GridItem,
  row_baseline_before_max : Array[Double],
  resolved_margin : Rect[Double],
) -> Unit {
  self.baseline_shim = self.baseline_alignment_offset(
    row_baseline_before_max, resolved_margin,
  )
}

///|
fn GridItem::set_final_area(
  self : GridItem,
  y_position~ : Double,
  height~ : Double,
) -> Unit {
  self.y_position = y_position
  self.height = height
}

///|
fn GridItem::set_track_crossings(
  self : GridItem,
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
) -> Unit {
  let mut crosses_flexible_column = false
  let mut crosses_intrinsic_column = false
  for i in self.column..<(self.column + self.column_span) {
    let track = col_tracks[i]
    if track_has_flexible_max(track) {
      crosses_flexible_column = true
    }
    if track_min_sizing_kind(track) != 0 {
      crosses_intrinsic_column = true
    }
  }
  let mut crosses_flexible_row = false
  let mut crosses_intrinsic_row = false
  for i in self.row..<(self.row + self.row_span) {
    let track = row_tracks[i]
    if track_has_flexible_max(track) {
      crosses_flexible_row = true
    }
    if track_min_sizing_kind(track) != 0 {
      crosses_intrinsic_row = true
    }
  }
  self.crosses_flexible_column = crosses_flexible_column
  self.crosses_intrinsic_column = crosses_intrinsic_column
  self.crosses_flexible_row = crosses_flexible_row
  self.crosses_intrinsic_row = crosses_intrinsic_row
}

///|
fn initialize_grid_item_track_crossings(
  items : Array[GridItem],
  col_tracks : Array[Dimension],
  row_tracks : Array[Dimension],
) -> Unit {
  for item in items {
    if item.placed {
      item.set_track_crossings(col_tracks, row_tracks)
    }
  }
}

///|
fn grid_items_first_row_baseline(items : Array[GridItem]) -> Double? {
  let mut first_row = -1
  for item in items {
    if item.placed && item.is_relative_grid_child() {
      if first_row == -1 || item.row < first_row {
        first_row = item.row
      }
    }
  }
  if first_row == -1 {
    return None
  }
  let mut chosen : GridItem? = None
  for item in items {
    if item.placed && item.is_relative_grid_child() && item.row == first_row {
      match chosen {
        None => chosen = Some(item)
        Some(existing) =>
          if item.style.align_self is Some(ItemsBaseline) &&
            !(existing.style.align_self is Some(ItemsBaseline)) {
            chosen = Some(item)
          }
      }
    }
  }
  match chosen {
    Some(item) => {
      let baseline = if item.baseline > 0.0 {
        item.baseline
      } else {
        item.height
      }
      Some(item.y_position + baseline)
    }
    None => None
  }
}

///|
fn GridItem::is_in_bounds(
  self : GridItem,
  row_count : Int,
  col_count : Int,
) -> Bool {
  if !self.placed {
    false
  } else {
    let row_end = self.row + self.row_span - 1
    let col_end = self.column + self.column_span - 1
    self.row >= 0 &&
    self.column >= 0 &&
    row_end < row_count &&
    col_end < col_count
  }
}

///|
fn GridItem::is_relative_grid_child(self : GridItem) -> Bool {
  !(self.style.display is DisplayNone) && self.style.position is PosRelative
}

///|
fn GridItem::baseline_alignment_offset(
  self : GridItem,
  row_baseline_before_max : Array[Double],
  resolved_margin : Rect[Double],
) -> Double {
  if self.row_span == 1 {
    if self.baseline_shim == 0.0 {
      row_baseline_before_max[self.row] - resolved_margin.top - self.baseline
    } else {
      self.baseline_shim
    }
  } else {
    0.0
  }
}

///|
fn GridItem::apply_column_contributions(
  self : GridItem,
  col_tracks : Array[Dimension],
  col_min_contrib : Array[Double],
  col_max_contrib : Array[Double],
) -> Unit {
  apply_col_contribution(
    col_tracks,
    self.column,
    self.column_span,
    self.column_minimum_contribution,
    col_min_contrib,
  )
  apply_col_contribution(
    col_tracks,
    self.column,
    self.column_span,
    self.column_max_content_contribution,
    col_max_contrib,
  )
}

///|
fn GridItem::apply_row_contributions(
  self : GridItem,
  row_min_contrib : Array[Double],
  row_max_contrib : Array[Double],
) -> Unit {
  let min_share = self.row_minimum_contribution / self.row_span.to_double()
  let max_share = self.row_max_content_contribution / self.row_span.to_double()
  for j in self.row..<(self.row + self.row_span) {
    if min_share > row_min_contrib[j] {
      row_min_contrib[j] = min_share
    }
    if max_share > row_max_contrib[j] {
      row_max_contrib[j] = max_share
    }
  }
}

///|
fn grid_items_placed(items : Array[GridItem]) -> Array[Bool] {
  let values : Array[Bool] = []
  for item in items {
    ignore(item.source_order)
    values.push(item.placed)
  }
  values
}

///|
fn grid_items_column_minimum_contribution(
  items : Array[GridItem],
) -> Array[Double] {
  let values : Array[Double] = []
  for item in items {
    values.push(item.column_minimum_contribution)
  }
  values
}

///|
fn grid_items_column_min_content_contribution(
  items : Array[GridItem],
) -> Array[Double] {
  let values : Array[Double] = []
  for item in items {
    values.push(item.column_min_content_contribution)
  }
  values
}

///|
fn grid_items_column_max_content_contribution(
  items : Array[GridItem],
) -> Array[Double] {
  let values : Array[Double] = []
  for item in items {
    values.push(item.column_max_content_contribution)
  }
  values
}

///|
fn compute_max_content_spanning_track_sizes_for_grid_items(
  tracks : Array[Dimension],
  items : Array[GridItem],
) -> (Array[Double], Double)? {
  let mut has_spanning_item = false
  let mut has_flexible_spanning_item = false
  let mut has_intrinsic_spanning_item = false
  for item in items {
    if item.placed && item.column_span > 1 {
      has_spanning_item = true
      if item.crosses_flexible_column {
        has_flexible_spanning_item = true
      }
      if item.crosses_intrinsic_column {
        has_intrinsic_spanning_item = true
      }
    }
  }
  if !has_spanning_item ||
    (!has_flexible_spanning_item && !has_intrinsic_spanning_item) {
    return None
  }
  compute_max_content_spanning_track_sizes(
    tracks,
    grid_items_column(items),
    grid_items_column_span(items),
    grid_items_column_minimum_contribution(items),
    grid_items_column_min_content_contribution(items),
    grid_items_column_max_content_contribution(items),
    grid_items_placed(items),
  )
}

///|
fn compute_max_content_spanning_row_track_sizes_for_grid_items(
  tracks : Array[Dimension],
  items : Array[GridItem],
) -> (Array[Double], Double)? {
  let mut has_spanning_item = false
  let mut has_flexible_spanning_item = false
  let mut has_intrinsic_spanning_item = false
  for item in items {
    if item.placed && item.row_span > 1 {
      has_spanning_item = true
      if item.crosses_flexible_row {
        has_flexible_spanning_item = true
      }
      if item.crosses_intrinsic_row {
        has_intrinsic_spanning_item = true
      }
    }
  }
  if !has_spanning_item ||
    (!has_flexible_spanning_item && !has_intrinsic_spanning_item) {
    return None
  }
  compute_max_content_spanning_track_sizes(
    tracks,
    grid_items_row(items),
    grid_items_row_span(items),
    grid_items_row_minimum_contribution(items),
    grid_items_row_minimum_contribution(items),
    grid_items_row_max_content_contribution(items),
    grid_items_placed(items),
  )
}

///|
fn grid_items_column(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.column)
  }
  values
}

///|
fn grid_items_row(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.row)
  }
  values
}

///|
fn grid_items_row_span(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.row_span)
  }
  values
}

///|
fn grid_items_row_minimum_contribution(
  items : Array[GridItem],
) -> Array[Double] {
  let values : Array[Double] = []
  for item in items {
    values.push(item.row_minimum_contribution)
  }
  values
}

///|
fn grid_items_row_max_content_contribution(
  items : Array[GridItem],
) -> Array[Double] {
  let values : Array[Double] = []
  for item in items {
    values.push(item.row_max_content_contribution)
  }
  values
}

///|
fn grid_items_column_span(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.column_span)
  }
  values
}
