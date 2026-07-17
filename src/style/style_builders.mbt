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
pub fn Style::with_size(self : Style, size : Size[Dimension]) -> Style {
  { ..self, size, }
}

///|
pub fn Style::with_padding(self : Style, padding : Rect[Dimension]) -> Style {
  { ..self, padding, }
}

///|
pub fn Style::with_border(self : Style, border : Rect[Dimension]) -> Style {
  { ..self, border, }
}

///|
pub fn Style::with_justify_content(
  self : Style,
  justify_content : JustifyContent,
) -> Style {
  { ..self, justify_content: Some(justify_content) }
}

///|
pub fn Style::with_display(self : Style, display : Display) -> Style {
  { ..self, display, }
}

///|
pub fn Style::with_box_sizing(self : Style, box_sizing : BoxSizing) -> Style {
  { ..self, box_sizing, }
}

///|
pub fn Style::with_position(self : Style, position : Position) -> Style {
  { ..self, position, }
}

///|
pub fn Style::with_overflow(self : Style, overflow : Point[Overflow]) -> Style {
  { ..self, overflow, }
}

///|
pub fn Style::with_scrollbar_width(
  self : Style,
  scrollbar_width : Double,
) -> Style {
  { ..self, scrollbar_width, }
}

///|
pub fn Style::with_inset(self : Style, inset : Rect[Dimension]) -> Style {
  { ..self, inset, }
}

///|
pub fn Style::with_margin(self : Style, margin : Rect[Dimension]) -> Style {
  { ..self, margin, }
}

///|
pub fn Style::with_min_size(self : Style, min_size : Size[Dimension]) -> Style {
  { ..self, min_size, }
}

///|
pub fn Style::with_max_size(self : Style, max_size : Size[Dimension]) -> Style {
  { ..self, max_size, }
}

///|
pub fn Style::with_aspect_ratio(self : Style, aspect_ratio : Double) -> Style {
  { ..self, aspect_ratio: Some(aspect_ratio) }
}

///|
pub fn Style::with_align_items(self : Style, align_items : AlignItems) -> Style {
  { ..self, align_items: Some(align_items) }
}

///|
pub fn Style::with_align_self(self : Style, align_self : AlignSelf) -> Style {
  { ..self, align_self: Some(align_self) }
}

///|
pub fn Style::with_justify_items(
  self : Style,
  justify_items : JustifyItems,
) -> Style {
  { ..self, justify_items: Some(justify_items) }
}

///|
pub fn Style::with_justify_self(
  self : Style,
  justify_self : JustifySelf,
) -> Style {
  { ..self, justify_self: Some(justify_self) }
}

///|
pub fn Style::with_align_content(
  self : Style,
  align_content : AlignContent,
) -> Style {
  { ..self, align_content: Some(align_content) }
}

///|
pub fn Style::with_gap(self : Style, gap : Size[Dimension]) -> Style {
  { ..self, gap, }
}

///|
pub fn Style::with_flex_direction(
  self : Style,
  flex_direction : FlexDirection,
) -> Style {
  { ..self, flex_direction, }
}

///|
pub fn Style::with_flex_wrap(self : Style, flex_wrap : FlexWrap) -> Style {
  { ..self, flex_wrap, }
}

///|
pub fn Style::with_flex_basis(self : Style, flex_basis : Dimension) -> Style {
  { ..self, flex_basis, }
}

///|
pub fn Style::with_flex_grow(self : Style, flex_grow : Double) -> Style {
  { ..self, flex_grow, }
}

///|
pub fn Style::with_flex_shrink(self : Style, flex_shrink : Double) -> Style {
  { ..self, flex_shrink, }
}

///|
pub fn Style::with_grid_template_rows(
  self : Style,
  grid_template_rows : Array[Dimension],
) -> Style {
  { ..self, grid_template_rows, }
}

///|
pub fn Style::with_grid_template_rows_chicle(
  self : Style,
  grid_template_rows : Array[TrackSizingFunction],
) -> Style {
  {
    ..self,
    grid_template_rows: track_sizing_functions_to_dimensions(grid_template_rows),
  }
}

///|
pub fn Style::with_grid_template_columns(
  self : Style,
  grid_template_columns : Array[Dimension],
) -> Style {
  { ..self, grid_template_columns, }
}

///|
pub fn Style::with_grid_template_columns_chicle(
  self : Style,
  grid_template_columns : Array[TrackSizingFunction],
) -> Style {
  {
    ..self,
    grid_template_columns: track_sizing_functions_to_dimensions(
      grid_template_columns,
    ),
  }
}

///|
pub fn Style::with_grid_auto_rows(
  self : Style,
  grid_auto_rows : Array[Dimension],
) -> Style {
  { ..self, grid_auto_rows, }
}

///|
pub fn Style::with_grid_auto_rows_chicle(
  self : Style,
  grid_auto_rows : Array[NonRepeatedTrackSizingFunction],
) -> Style {
  { ..self, grid_auto_rows: non_repeated_tracks_to_dimensions(grid_auto_rows) }
}

///|
pub fn Style::with_grid_auto_columns(
  self : Style,
  grid_auto_columns : Array[Dimension],
) -> Style {
  { ..self, grid_auto_columns, }
}

///|
pub fn Style::with_grid_auto_columns_chicle(
  self : Style,
  grid_auto_columns : Array[NonRepeatedTrackSizingFunction],
) -> Style {
  {
    ..self,
    grid_auto_columns: non_repeated_tracks_to_dimensions(grid_auto_columns),
  }
}

///|
pub fn Style::with_grid_auto_flow(
  self : Style,
  grid_auto_flow : GridAutoFlow,
) -> Style {
  { ..self, grid_auto_flow, }
}

///|
pub fn Style::with_grid_row(
  self : Style,
  grid_row : Line[GridPlacement],
) -> Style {
  { ..self, grid_row, }
}

///|
pub fn Style::with_grid_column(
  self : Style,
  grid_column : Line[GridPlacement],
) -> Style {
  { ..self, grid_column, }
}

///|
pub fn Style::with_grid_row_start(self : Style, start : Int) -> Style {
  {
    ..self,
    grid_row_start: Some(start),
    grid_row: Line(start=PlaceLine(start), end=PlaceAuto),
  }
}

///|
pub fn Style::with_grid_column_start(self : Style, start : Int) -> Style {
  {
    ..self,
    grid_column_start: Some(start),
    grid_column: Line(start=PlaceLine(start), end=PlaceAuto),
  }
}

///|
fn track_sizing_functions_to_dimensions(
  tracks : Array[TrackSizingFunction],
) -> Array[Dimension] {
  let dimensions : Array[Dimension] = []
  for track in tracks {
    for dimension in track.to_dimensions() {
      dimensions.push(dimension)
    }
  }
  dimensions
}

///|
fn non_repeated_tracks_to_dimensions(
  tracks : Array[NonRepeatedTrackSizingFunction],
) -> Array[Dimension] {
  let dimensions : Array[Dimension] = []
  for track in tracks {
    dimensions.push(track.to_dimension())
  }
  dimensions
}
