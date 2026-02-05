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
pub fn length(value : Double) -> Dimension {
  DimLength(value)
}

///|
pub fn percent(value : Double) -> Dimension {
  DimPercent(value)
}

///|
pub fn auto() -> Dimension {
  DimAuto
}

///|
pub fn fr(value : Double) -> Dimension {
  DimFr(value)
}

///|
pub fn minmax(min : Dimension, max : Dimension) -> Dimension {
  DimMinMax(min, max)
}

///|
pub fn grid_min_content() -> Dimension {
  DimMinContent
}

///|
pub fn grid_max_content() -> Dimension {
  DimMaxContent
}

///|
pub fn fit_content(limit : Dimension) -> Dimension {
  DimFitContent(limit)
}

///|
pub fn repeat_count(count : Int) -> GridTrackRepetition {
  RepeatCount(count)
}

///|
pub fn repeat_auto_fill() -> GridTrackRepetition {
  RepeatAutoFill
}

///|
pub fn repeat_auto_fit() -> GridTrackRepetition {
  RepeatAutoFit
}

///|
pub fn repeat(
  repetition : GridTrackRepetition,
  tracks : Array[Dimension],
) -> Dimension {
  DimRepeat(repetition, tracks)
}

///|
pub fn grid_auto_flow_row() -> GridAutoFlow {
  AutoFlowRow
}

///|
pub fn grid_auto_flow_column() -> GridAutoFlow {
  AutoFlowColumn
}

///|
pub fn place_auto() -> GridPlacement {
  PlaceAuto
}

///|
pub fn line(value : Int) -> GridPlacement {
  PlaceLine(value)
}

///|
pub fn span(value : Int) -> GridPlacement {
  PlaceSpan(value)
}

///|
pub fn available_space_definite(value : Double) -> AvailableSpace {
  AvailDefinite(value)
}

///|
pub fn max_content() -> AvailableSpace {
  AvailMaxContent
}

///|
pub fn min_content() -> AvailableSpace {
  AvailMinContent
}

///|
pub fn display_flex() -> Display {
  DisplayFlex
}

///|
pub fn display_grid() -> Display {
  DisplayGrid
}

///|
pub fn display_block() -> Display {
  DisplayBlock
}

///|
pub fn display_none() -> Display {
  DisplayNone
}

///|
pub fn position_relative() -> Position {
  PosRelative
}

///|
pub fn position_absolute() -> Position {
  PosAbsolute
}

///|
pub fn overflow_visible() -> Overflow {
  OverflowVisible
}

///|
pub fn overflow_clip() -> Overflow {
  OverflowClip
}

///|
pub fn overflow_hidden() -> Overflow {
  OverflowHidden
}

///|
pub fn overflow_scroll() -> Overflow {
  OverflowScroll
}

///|
pub fn flex_direction_row() -> FlexDirection {
  FlexRow
}

///|
pub fn flex_direction_column() -> FlexDirection {
  FlexColumn
}

///|
pub fn flex_direction_row_reverse() -> FlexDirection {
  FlexRowReverse
}

///|
pub fn flex_direction_column_reverse() -> FlexDirection {
  FlexColumnReverse
}

///|
pub fn flex_wrap_no_wrap() -> FlexWrap {
  FlexNoWrap
}

///|
pub fn flex_wrap_wrap() -> FlexWrap {
  FlexWrap
}

///|
pub fn flex_wrap_wrap_reverse() -> FlexWrap {
  FlexWrapReverse
}

///|
pub fn align_items_start() -> AlignItems {
  ItemsStart
}

///|
pub fn align_items_end() -> AlignItems {
  ItemsEnd
}

///|
pub fn align_items_flex_start() -> AlignItems {
  ItemsFlexStart
}

///|
pub fn align_items_flex_end() -> AlignItems {
  ItemsFlexEnd
}

///|
pub fn align_items_center() -> AlignItems {
  ItemsCenter
}

///|
pub fn align_items_baseline() -> AlignItems {
  ItemsBaseline
}

///|
pub fn align_items_stretch() -> AlignItems {
  ItemsStretch
}

///|
pub fn align_content_start() -> AlignContent {
  AlignStart
}

///|
pub fn align_content_end() -> AlignContent {
  AlignEnd
}

///|
pub fn align_content_flex_start() -> AlignContent {
  AlignFlexStart
}

///|
pub fn align_content_flex_end() -> AlignContent {
  AlignFlexEnd
}

///|
pub fn align_content_center() -> AlignContent {
  AlignCenter
}

///|
pub fn align_content_stretch() -> AlignContent {
  AlignStretch
}

///|
pub fn align_content_space_between() -> AlignContent {
  AlignSpaceBetween
}

///|
pub fn align_content_space_evenly() -> AlignContent {
  AlignSpaceEvenly
}

///|
pub fn align_content_space_around() -> AlignContent {
  AlignSpaceAround
}

///|
pub fn justify_content_flex_start() -> JustifyContent {
  AlignFlexStart
}

///|
pub fn justify_content_center() -> JustifyContent {
  AlignCenter
}

///|
pub fn justify_content_flex_end() -> JustifyContent {
  AlignFlexEnd
}

///|
pub fn justify_content_start() -> JustifyContent {
  AlignStart
}

///|
pub fn justify_content_end() -> JustifyContent {
  AlignEnd
}

///|
pub fn justify_content_stretch() -> JustifyContent {
  AlignStretch
}

///|
pub fn justify_content_space_between() -> JustifyContent {
  AlignSpaceBetween
}

///|
pub fn justify_content_space_evenly() -> JustifyContent {
  AlignSpaceEvenly
}

///|
pub fn justify_content_space_around() -> JustifyContent {
  AlignSpaceAround
}

///|
pub fn Size::max_content() -> Size[AvailableSpace] {
  Size::new(width=AvailMaxContent, height=AvailMaxContent)
}
