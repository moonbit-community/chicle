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
pub enum GridTrackRepetition {
  RepeatCount(Int)
  RepeatAutoFill
  RepeatAutoFit
}

///|
pub enum GridAutoFlow {
  Row
  Column
  RowDense
  ColumnDense
}

///|
pub enum GridPlacement {
  PlaceAuto
  PlaceLine(Int)
  PlaceSpan(Int)
}

///|
pub fn GridAutoFlow::is_dense(self : GridAutoFlow) -> Bool {
  match self {
    Row | Column => false
    RowDense | ColumnDense => true
  }
}

///|
pub fn GridAutoFlow::primary_axis(self : GridAutoFlow) -> AbsoluteAxis {
  match self {
    Row | RowDense => Horizontal
    Column | ColumnDense => Vertical
  }
}

///|
pub fn GridPlacement::indefinite_span(self : Line[GridPlacement]) -> Int {
  match (self.start, self.end) {
    (PlaceLine(_), PlaceAuto) => 1
    (PlaceAuto, PlaceLine(_)) => 1
    (PlaceAuto, PlaceAuto) => 1
    (PlaceLine(_), PlaceSpan(span)) => span
    (PlaceSpan(span), PlaceLine(_)) => span
    (PlaceSpan(span), PlaceAuto) => span
    (PlaceAuto, PlaceSpan(span)) => span
    (PlaceSpan(span), PlaceSpan(_)) => span
    (PlaceLine(_), PlaceLine(_)) => 1
  }
}

///|
pub fn GridPlacement::is_definite(self : Line[GridPlacement]) -> Bool {
  match (self.start, self.end) {
    (PlaceLine(line), _) if line != 0 => true
    (_, PlaceLine(line)) if line != 0 => true
    _ => false
  }
}
