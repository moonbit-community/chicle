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
fn grid_items_placed(items : Array[GridItem]) -> Array[Bool] {
  let values : Array[Bool] = []
  for item in items {
    ignore(item.source_order)
    values.push(item.placed)
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
fn grid_items_column(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.column)
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
fn grid_items_column_span(items : Array[GridItem]) -> Array[Int] {
  let values : Array[Int] = []
  for item in items {
    values.push(item.column_span)
  }
  values
}
