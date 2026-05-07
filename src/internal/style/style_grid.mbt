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
pub enum MaxTrackSizingFunction {
  MaxTrackFixed(LengthPercentage)
  MaxTrackMinContent
  MaxTrackMaxContent
  MaxTrackFitContent(LengthPercentage)
  MaxTrackAuto
  MaxTrackFraction(Double)
}

///|
pub enum MinTrackSizingFunction {
  MinTrackFixed(LengthPercentage)
  MinTrackMinContent
  MinTrackMaxContent
  MinTrackAuto
}

///|
pub struct NonRepeatedTrackSizingFunction {
  min : MinTrackSizingFunction
  max : MaxTrackSizingFunction
}

///|
pub fn NonRepeatedTrackSizingFunction::NonRepeatedTrackSizingFunction(
  min~ : MinTrackSizingFunction,
  max~ : MaxTrackSizingFunction,
) -> NonRepeatedTrackSizingFunction {
  { min, max }
}

///|
pub enum TrackSizingFunction {
  Single(NonRepeatedTrackSizingFunction)
  Repeat(GridTrackRepetition, Array[NonRepeatedTrackSizingFunction])
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

///|
pub fn MaxTrackSizingFunction::is_intrinsic(
  self : MaxTrackSizingFunction,
) -> Bool {
  match self {
    MaxTrackMinContent
    | MaxTrackMaxContent
    | MaxTrackFitContent(_)
    | MaxTrackAuto => true
    MaxTrackFixed(_) | MaxTrackFraction(_) => false
  }
}

///|
pub fn MaxTrackSizingFunction::is_max_content_alike(
  self : MaxTrackSizingFunction,
) -> Bool {
  match self {
    MaxTrackMaxContent | MaxTrackFitContent(_) | MaxTrackAuto => true
    _ => false
  }
}

///|
pub fn MaxTrackSizingFunction::is_flexible(
  self : MaxTrackSizingFunction,
) -> Bool {
  self is MaxTrackFraction(_)
}

///|
pub fn MaxTrackSizingFunction::definite_value(
  self : MaxTrackSizingFunction,
  parent_size : Double?,
) -> Double? {
  match self {
    MaxTrackFixed(LengthPercentageLength(size)) => Some(size)
    MaxTrackFixed(LengthPercentagePercent(fraction)) =>
      parent_size.map(fn(size) { size * fraction })
    _ => None
  }
}

///|
pub fn MaxTrackSizingFunction::definite_limit(
  self : MaxTrackSizingFunction,
  parent_size : Double?,
) -> Double? {
  match self {
    MaxTrackFitContent(LengthPercentageLength(size)) => Some(size)
    MaxTrackFitContent(LengthPercentagePercent(fraction)) =>
      parent_size.map(fn(size) { size * fraction })
    _ => self.definite_value(parent_size)
  }
}

///|
pub fn MaxTrackSizingFunction::resolved_percentage_size(
  self : MaxTrackSizingFunction,
  parent_size : Double,
) -> Double? {
  match self {
    MaxTrackFixed(LengthPercentagePercent(fraction)) =>
      Some(parent_size * fraction)
    _ => None
  }
}

///|
pub fn MaxTrackSizingFunction::uses_percentage(
  self : MaxTrackSizingFunction,
) -> Bool {
  match self {
    MaxTrackFixed(LengthPercentagePercent(_))
    | MaxTrackFitContent(LengthPercentagePercent(_)) => true
    _ => false
  }
}

///|
pub fn MinTrackSizingFunction::is_intrinsic(
  self : MinTrackSizingFunction,
) -> Bool {
  match self {
    MinTrackMinContent | MinTrackMaxContent | MinTrackAuto => true
    MinTrackFixed(_) => false
  }
}

///|
pub fn MinTrackSizingFunction::definite_value(
  self : MinTrackSizingFunction,
  parent_size : Double?,
) -> Double? {
  match self {
    MinTrackFixed(LengthPercentageLength(size)) => Some(size)
    MinTrackFixed(LengthPercentagePercent(fraction)) =>
      parent_size.map(fn(size) { size * fraction })
    _ => None
  }
}

///|
pub fn MinTrackSizingFunction::resolved_percentage_size(
  self : MinTrackSizingFunction,
  parent_size : Double,
) -> Double? {
  match self {
    MinTrackFixed(LengthPercentagePercent(fraction)) =>
      Some(parent_size * fraction)
    _ => None
  }
}

///|
pub fn MinTrackSizingFunction::uses_percentage(
  self : MinTrackSizingFunction,
) -> Bool {
  self is MinTrackFixed(LengthPercentagePercent(_))
}

///|
pub fn MaxTrackSizingFunction::to_dimension(
  self : MaxTrackSizingFunction,
) -> Dimension {
  match self {
    MaxTrackFixed(LengthPercentageLength(value)) => DimLength(value)
    MaxTrackFixed(LengthPercentagePercent(value)) => DimPercent(value)
    MaxTrackMinContent => DimMinContent
    MaxTrackMaxContent => DimMaxContent
    MaxTrackFitContent(LengthPercentageLength(value)) =>
      DimFitContent(DimLength(value))
    MaxTrackFitContent(LengthPercentagePercent(value)) =>
      DimFitContent(DimPercent(value))
    MaxTrackAuto => DimAuto
    MaxTrackFraction(value) => DimFr(value)
  }
}

///|
pub fn MinTrackSizingFunction::to_dimension(
  self : MinTrackSizingFunction,
) -> Dimension {
  match self {
    MinTrackFixed(LengthPercentageLength(value)) => DimLength(value)
    MinTrackFixed(LengthPercentagePercent(value)) => DimPercent(value)
    MinTrackMinContent => DimMinContent
    MinTrackMaxContent => DimMaxContent
    MinTrackAuto => DimAuto
  }
}

///|
pub fn NonRepeatedTrackSizingFunction::min_sizing_function(
  self : NonRepeatedTrackSizingFunction,
) -> MinTrackSizingFunction {
  self.min
}

///|
pub fn NonRepeatedTrackSizingFunction::max_sizing_function(
  self : NonRepeatedTrackSizingFunction,
) -> MaxTrackSizingFunction {
  self.max
}

///|
pub fn NonRepeatedTrackSizingFunction::has_fixed_component(
  self : NonRepeatedTrackSizingFunction,
) -> Bool {
  self.min is MinTrackFixed(_) || self.max is MaxTrackFixed(_)
}

///|
pub fn NonRepeatedTrackSizingFunction::to_dimension(
  self : NonRepeatedTrackSizingFunction,
) -> Dimension {
  match (self.min, self.max) {
    (MinTrackAuto, max) => max.to_dimension()
    (min, MaxTrackAuto) => min.to_dimension()
    (min, max) => DimMinMax(min.to_dimension(), max.to_dimension())
  }
}

///|
pub fn TrackSizingFunction::to_dimensions(
  self : TrackSizingFunction,
) -> Array[Dimension] {
  match self {
    Single(track) => [track.to_dimension()]
    Repeat(repetition, tracks) => {
      let dimensions : Array[Dimension] = []
      for track in tracks {
        dimensions.push(track.to_dimension())
      }
      [DimRepeat(repetition, dimensions)]
    }
  }
}
