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
pub type Point[T] = @style.Point[T]

///|
pub type Size[T] = @style.Size[T]

///|
pub type Rect[T] = @style.Rect[T]

///|
pub type Line[T] = @style.Line[T]

///|
pub type AbsoluteAxis = @style.AbsoluteAxis

///|
pub type AbstractAxis = @style.AbstractAxis

///|
pub type AvailableSpace = @style.AvailableSpace

///|
pub type GridTrackRepetition = @style.GridTrackRepetition

///|
pub type GridAutoFlow = @style.GridAutoFlow

///|
pub type GridPlacement = @style.GridPlacement

///|
pub type MaxTrackSizingFunction = @style.MaxTrackSizingFunction

///|
pub type MinTrackSizingFunction = @style.MinTrackSizingFunction

///|
pub type NonRepeatedTrackSizingFunction = @style.NonRepeatedTrackSizingFunction

///|
pub type TrackSizingFunction = @style.TrackSizingFunction

///|
pub type Dimension = @style.Dimension

///|
pub type LengthPercentage = @style.LengthPercentage

///|
pub type LengthPercentageAuto = @style.LengthPercentageAuto

///|
pub type Display = @style.Display

///|
pub type Position = @style.Position

///|
pub type Overflow = @style.Overflow

///|
pub type FlexDirection = @style.FlexDirection

///|
pub type FlexWrap = @style.FlexWrap

///|
pub type AlignItems = @style.AlignItems

///|
pub type JustifyItems = @style.JustifyItems

///|
pub type AlignSelf = @style.AlignSelf

///|
pub type JustifySelf = @style.JustifySelf

///|
pub type AlignContent = @style.AlignContent

///|
pub type JustifyContent = @style.JustifyContent

///|
pub type Style = @style.Style

///|
pub type NodeId = @style.NodeId

///|
pub type Layout = @style.Layout

///|
pub type LayoutInput = @style.LayoutInput

///|
pub type LayoutOutput = @style.LayoutOutput

///|
pub type RunMode = @style.RunMode

///|
pub type SizingMode = @style.SizingMode

///|
pub type RequestedAxis = @style.RequestedAxis

///|
pub type TaffyError = @style.TaffyError

///|
pub type TaffyTree[C] = @style.TaffyTree[C]

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
