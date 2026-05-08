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
pub using @style {
  type Point,
  type Size,
  type Rect,
  type Line,
  type AbsoluteAxis,
  type AbstractAxis,
  type AvailableSpace,
  type GridTrackRepetition,
  type GridAutoFlow,
  type GridPlacement,
  type MaxTrackSizingFunction,
  type MinTrackSizingFunction,
  type NonRepeatedTrackSizingFunction,
  type TrackSizingFunction,
  type Dimension,
  type LengthPercentage,
  type LengthPercentageAuto,
  type Display,
  type Position,
  type Overflow,
  type BoxSizing,
  type FlexDirection,
  type FlexWrap,
  type AlignItems,
  type JustifyItems,
  type AlignSelf,
  type JustifySelf,
  type AlignContent,
  type JustifyContent,
  type Style,
  type NodeId,
  type Layout,
  type LayoutInput,
  type LayoutOutput,
  type RunMode,
  type SizingMode,
  type RequestedAxis,
  type TaffyError,
  type TaffyTree,
}

///|
pub fn abstract_axis_inline() -> AbstractAxis {
  @style.abstract_axis_inline()
}

///|
pub fn abstract_axis_block() -> AbstractAxis {
  @style.abstract_axis_block()
}

///|
pub fn length_percentage_length(value : Double) -> LengthPercentage {
  @style.length_percentage_length(value)
}

///|
pub fn length_percentage_percent(value : Double) -> LengthPercentage {
  @style.length_percentage_percent(value)
}

///|
pub fn length_percentage_auto_length(value : Double) -> LengthPercentageAuto {
  @style.length_percentage_auto_length(value)
}

///|
pub fn length_percentage_auto_percent(value : Double) -> LengthPercentageAuto {
  @style.length_percentage_auto_percent(value)
}

///|
pub fn length_percentage_auto_auto() -> LengthPercentageAuto {
  @style.length_percentage_auto_auto()
}
