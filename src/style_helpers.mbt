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
  @style.length(value)
}

///|
pub fn percent(value : Double) -> Dimension {
  @style.percent(value)
}

///|
pub fn zero() -> Dimension {
  @style.zero()
}

///|
pub fn auto() -> Dimension {
  @style.auto()
}

///|
pub fn flex(value : Double) -> Dimension {
  @style.flex(value)
}

///|
pub fn fr(value : Double) -> Dimension {
  @style.fr(value)
}

///|
pub fn minmax(min : Dimension, max : Dimension) -> Dimension {
  @style.minmax(min, max)
}

///|
pub fn grid_min_content() -> Dimension {
  @style.grid_min_content()
}

///|
pub fn grid_max_content() -> Dimension {
  @style.grid_max_content()
}

///|
pub fn fit_content(limit : Dimension) -> Dimension {
  @style.fit_content(limit)
}

///|
pub fn repeat_count(count : Int) -> GridTrackRepetition {
  @style.repeat_count(count)
}

///|
pub fn repeat_auto_fill() -> GridTrackRepetition {
  @style.repeat_auto_fill()
}

///|
pub fn repeat_auto_fit() -> GridTrackRepetition {
  @style.repeat_auto_fit()
}

///|
pub fn repeat(
  repetition : GridTrackRepetition,
  tracks : Array[Dimension],
) -> Dimension {
  @style.repeat(repetition, tracks)
}

///|
pub fn evenly_sized_tracks(count : Int) -> Array[Dimension] {
  @style.evenly_sized_tracks(count)
}

///|
pub fn max_track_fixed(value : LengthPercentage) -> MaxTrackSizingFunction {
  @style.max_track_fixed(value)
}

///|
pub fn max_track_min_content() -> MaxTrackSizingFunction {
  @style.max_track_min_content()
}

///|
pub fn max_track_max_content() -> MaxTrackSizingFunction {
  @style.max_track_max_content()
}

///|
pub fn max_track_fit_content(
  value : LengthPercentage,
) -> MaxTrackSizingFunction {
  @style.max_track_fit_content(value)
}

///|
pub fn max_track_auto() -> MaxTrackSizingFunction {
  @style.max_track_auto()
}

///|
pub fn max_track_fraction(value : Double) -> MaxTrackSizingFunction {
  @style.max_track_fraction(value)
}

///|
pub fn min_track_fixed(value : LengthPercentage) -> MinTrackSizingFunction {
  @style.min_track_fixed(value)
}

///|
pub fn min_track_min_content() -> MinTrackSizingFunction {
  @style.min_track_min_content()
}

///|
pub fn min_track_max_content() -> MinTrackSizingFunction {
  @style.min_track_max_content()
}

///|
pub fn min_track_auto() -> MinTrackSizingFunction {
  @style.min_track_auto()
}

///|
pub fn track_sizing_function(
  value : NonRepeatedTrackSizingFunction,
) -> TrackSizingFunction {
  @style.track_sizing_function(value)
}

///|
pub fn repeated_track_sizing_function(
  repetition : GridTrackRepetition,
  tracks : Array[NonRepeatedTrackSizingFunction],
) -> TrackSizingFunction {
  @style.repeated_track_sizing_function(repetition, tracks)
}

///|
pub fn grid_auto_flow_row() -> GridAutoFlow {
  @style.grid_auto_flow_row()
}

///|
pub fn grid_auto_flow_column() -> GridAutoFlow {
  @style.grid_auto_flow_column()
}

///|
pub fn grid_auto_flow_row_dense() -> GridAutoFlow {
  @style.grid_auto_flow_row_dense()
}

///|
pub fn grid_auto_flow_column_dense() -> GridAutoFlow {
  @style.grid_auto_flow_column_dense()
}

///|
pub fn place_auto() -> GridPlacement {
  @style.place_auto()
}

///|
pub fn line(value : Int) -> GridPlacement {
  @style.line(value)
}

///|
pub fn span(value : Int) -> GridPlacement {
  @style.span(value)
}

///|
pub fn available_space_definite(value : Double) -> AvailableSpace {
  @style.available_space_definite(value)
}

///|
pub fn max_content() -> AvailableSpace {
  @style.max_content()
}

///|
pub fn min_content() -> AvailableSpace {
  @style.min_content()
}

///|
pub fn display_flex() -> Display {
  @style.display_flex()
}

///|
pub fn display_grid() -> Display {
  @style.display_grid()
}

///|
pub fn display_block() -> Display {
  @style.display_block()
}

///|
pub fn display_none() -> Display {
  @style.display_none()
}

///|
pub fn position_relative() -> Position {
  @style.position_relative()
}

///|
pub fn position_absolute() -> Position {
  @style.position_absolute()
}

///|
pub fn overflow_visible() -> Overflow {
  @style.overflow_visible()
}

///|
pub fn overflow_clip() -> Overflow {
  @style.overflow_clip()
}

///|
pub fn overflow_hidden() -> Overflow {
  @style.overflow_hidden()
}

///|
pub fn overflow_scroll() -> Overflow {
  @style.overflow_scroll()
}

///|
pub fn flex_direction_row() -> FlexDirection {
  @style.flex_direction_row()
}

///|
pub fn flex_direction_column() -> FlexDirection {
  @style.flex_direction_column()
}

///|
pub fn flex_direction_row_reverse() -> FlexDirection {
  @style.flex_direction_row_reverse()
}

///|
pub fn flex_direction_column_reverse() -> FlexDirection {
  @style.flex_direction_column_reverse()
}

///|
pub fn flex_wrap_no_wrap() -> FlexWrap {
  @style.flex_wrap_no_wrap()
}

///|
pub fn flex_wrap_wrap() -> FlexWrap {
  @style.flex_wrap_wrap()
}

///|
pub fn flex_wrap_wrap_reverse() -> FlexWrap {
  @style.flex_wrap_wrap_reverse()
}

///|
pub fn align_items_start() -> AlignItems {
  @style.align_items_start()
}

///|
pub fn align_items_end() -> AlignItems {
  @style.align_items_end()
}

///|
pub fn align_items_flex_start() -> AlignItems {
  @style.align_items_flex_start()
}

///|
pub fn align_items_flex_end() -> AlignItems {
  @style.align_items_flex_end()
}

///|
pub fn align_items_center() -> AlignItems {
  @style.align_items_center()
}

///|
pub fn align_items_baseline() -> AlignItems {
  @style.align_items_baseline()
}

///|
pub fn align_items_stretch() -> AlignItems {
  @style.align_items_stretch()
}

///|
pub fn align_content_start() -> AlignContent {
  @style.align_content_start()
}

///|
pub fn align_content_end() -> AlignContent {
  @style.align_content_end()
}

///|
pub fn align_content_flex_start() -> AlignContent {
  @style.align_content_flex_start()
}

///|
pub fn align_content_flex_end() -> AlignContent {
  @style.align_content_flex_end()
}

///|
pub fn align_content_center() -> AlignContent {
  @style.align_content_center()
}

///|
pub fn align_content_stretch() -> AlignContent {
  @style.align_content_stretch()
}

///|
pub fn align_content_space_between() -> AlignContent {
  @style.align_content_space_between()
}

///|
pub fn align_content_space_evenly() -> AlignContent {
  @style.align_content_space_evenly()
}

///|
pub fn align_content_space_around() -> AlignContent {
  @style.align_content_space_around()
}

///|
pub fn justify_content_flex_start() -> JustifyContent {
  @style.justify_content_flex_start()
}

///|
pub fn justify_content_center() -> JustifyContent {
  @style.justify_content_center()
}

///|
pub fn justify_content_flex_end() -> JustifyContent {
  @style.justify_content_flex_end()
}

///|
pub fn justify_content_start() -> JustifyContent {
  @style.justify_content_start()
}

///|
pub fn justify_content_end() -> JustifyContent {
  @style.justify_content_end()
}

///|
pub fn justify_content_space_between() -> JustifyContent {
  @style.justify_content_space_between()
}

///|
pub fn justify_content_space_evenly() -> JustifyContent {
  @style.justify_content_space_evenly()
}

///|
pub fn justify_content_space_around() -> JustifyContent {
  @style.justify_content_space_around()
}
