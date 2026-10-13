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
fn matrix_make(rows : Int32, cols : Int32) -> Array[Array[Bool]] {
  let m : Array[Array[Bool]] = []
  for _r in 0..<rows {
    m.push(Array::make(cols, false))
  }
  m
}

///|
fn ensure_cols(
  occ : Array[Array[Bool]],
  col_tracks : Array[Dimension],
  auto_cols : Array[Dimension],
  negative_cols : Int32,
  explicit_cols : Int32,
  target_col : Int32,
) -> Unit {
  while col_tracks.length() <= target_col {
    let pos_existing = col_tracks.length() - negative_cols - explicit_cols
    let dim = auto_cols[pos_existing % auto_cols.length()]
    col_tracks.push(dim)
    for r in 0..<occ.length() {
      occ[r].push(false)
    }
  }
}

///|
fn ensure_rows(
  occ : Array[Array[Bool]],
  row_tracks : Array[Dimension],
  auto_rows : Array[Dimension],
  negative_rows : Int32,
  explicit_rows : Int32,
  target_row : Int32,
) -> Unit {
  while row_tracks.length() <= target_row {
    let pos_existing = row_tracks.length() - negative_rows - explicit_rows
    let dim = auto_rows[pos_existing % auto_rows.length()]
    row_tracks.push(dim)
    occ.push(Array::make(occ[0].length(), false))
  }
}

///|
fn region_is_free(
  occ : Array[Array[Bool]],
  row : Int32,
  col : Int32,
  row_span : Int32,
  col_span : Int32,
) -> Bool {
  for r in row..<(row + row_span) {
    for c in col..<(col + col_span) {
      if occ[r][c] {
        return false
      }
    }
  }
  true
}

///|
fn mark_grid_item_placed(
  items : Array[GridItem],
  occ : Array[Array[Bool]],
  row_tracks : Array[Dimension],
  col_tracks : Array[Dimension],
  auto_rows : Array[Dimension],
  auto_cols : Array[Dimension],
  negative_rows : Int32,
  negative_cols : Int32,
  explicit_rows : Int32,
  explicit_cols : Int32,
  idx : Int32,
  row : Int32,
  col : Int32,
  row_span : Int32,
  col_span : Int32,
) -> Unit {
  let row_end = row + row_span - 1
  let col_end = col + col_span - 1
  ensure_rows(occ, row_tracks, auto_rows, negative_rows, explicit_rows, row_end)
  ensure_cols(occ, col_tracks, auto_cols, negative_cols, explicit_cols, col_end)
  for r in row..<(row + row_span) {
    for c in col..<(col + col_span) {
      occ[r][c] = true
    }
  }
  items[idx].place(row~, column=col, row_span~, column_span=col_span)
}
