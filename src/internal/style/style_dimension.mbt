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
pub enum AvailableSpace {
  AvailDefinite(Double)
  AvailMinContent
  AvailMaxContent
}

///|
pub enum Dimension {
  DimAuto
  DimLength(Double)
  DimPercent(Double)
  DimFr(Double)
  DimMinMax(Dimension, Dimension)
  DimMinContent
  DimMaxContent
  DimFitContent(Dimension)
  DimRepeat(GridTrackRepetition, Array[Dimension])
}

///|
pub fn AvailableSpace::is_definite(self : AvailableSpace) -> Bool {
  self is AvailDefinite(_)
}

///|
pub fn AvailableSpace::into_option(self : AvailableSpace) -> Double? {
  match self {
    AvailDefinite(value) => Some(value)
    _ => None
  }
}

///|
pub fn AvailableSpace::unwrap_or(
  self : AvailableSpace,
  default : Double,
) -> Double {
  match self {
    AvailDefinite(value) => value
    _ => default
  }
}

///|
pub fn AvailableSpace::or(
  self : AvailableSpace,
  default : AvailableSpace,
) -> AvailableSpace {
  match self {
    AvailDefinite(_) => self
    _ => default
  }
}

///|
pub fn AvailableSpace::maybe_set(
  self : AvailableSpace,
  value : Double?,
) -> AvailableSpace {
  match value {
    Some(value) => AvailDefinite(value)
    None => self
  }
}

///|
pub fn Dimension::into_option(self : Dimension) -> Double? {
  match self {
    DimLength(value) => Some(value)
    _ => None
  }
}

///|
pub enum LengthPercentage {
  LengthPercentageLength(Double)
  LengthPercentagePercent(Double)
}

///|
pub enum LengthPercentageAuto {
  LengthPercentageAutoLength(Double)
  LengthPercentageAutoPercent(Double)
  LengthPercentageAutoAuto
}

///|
pub fn length_percentage_length(value : Double) -> LengthPercentage {
  LengthPercentageLength(value)
}

///|
pub fn length_percentage_percent(value : Double) -> LengthPercentage {
  LengthPercentagePercent(value)
}

///|
pub fn length_percentage_auto_length(value : Double) -> LengthPercentageAuto {
  LengthPercentageAutoLength(value)
}

///|
pub fn length_percentage_auto_percent(value : Double) -> LengthPercentageAuto {
  LengthPercentageAutoPercent(value)
}

///|
pub fn length_percentage_auto_auto() -> LengthPercentageAuto {
  LengthPercentageAutoAuto
}

///|
pub fn LengthPercentageAuto::resolve_to_option(
  self : LengthPercentageAuto,
  context : Double,
) -> Double? {
  match self {
    LengthPercentageAutoLength(value) => Some(value)
    LengthPercentageAutoPercent(percent) => Some(context * percent)
    LengthPercentageAutoAuto => None
  }
}

///|
pub fn LengthPercentageAuto::is_auto(self : LengthPercentageAuto) -> Bool {
  self is LengthPercentageAutoAuto
}
