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
pub(all) enum Display {
  DisplayBlock
  DisplayFlex
  DisplayGrid
  DisplayNone
}

///|
pub(all) enum Position {
  PosRelative
  PosAbsolute
}

///|
pub(all) enum Overflow {
  OverflowVisible
  OverflowClip
  OverflowHidden
  OverflowScroll
}

///|
pub(all) enum BoxSizing {
  BorderBox
  ContentBox
}

///|
pub(all) struct Style {
  display : Display
  box_sizing : BoxSizing
  overflow : Point[Overflow]
  scrollbar_width : Double
  position : Position
  inset : Rect[Dimension]
  size : Size[Dimension]
  min_size : Size[Dimension]
  max_size : Size[Dimension]
  aspect_ratio : Double?
  margin : Rect[Dimension]
  padding : Rect[Dimension]
  border : Rect[Dimension]
  align_items : AlignItems?
  align_self : AlignSelf?
  justify_items : JustifyItems?
  justify_self : JustifySelf?
  align_content : AlignContent?
  justify_content : JustifyContent?
  gap : Size[Dimension]
  flex_direction : FlexDirection
  flex_wrap : FlexWrap
  flex_basis : Dimension
  flex_grow : Double
  flex_shrink : Double
  grid_template_rows : Array[Dimension]
  grid_template_columns : Array[Dimension]
  grid_auto_rows : Array[Dimension]
  grid_auto_columns : Array[Dimension]
  grid_auto_flow : GridAutoFlow
  grid_row : Line[GridPlacement]
  grid_column : Line[GridPlacement]
  grid_row_start : Int?
  grid_column_start : Int?
}

///|
pub fn Style::default() -> Style {
  {
    display: DisplayFlex,
    box_sizing: BorderBox,
    overflow: { x: OverflowVisible, y: OverflowVisible },
    scrollbar_width: 0.0,
    position: PosRelative,
    inset: Rect(left=DimAuto, right=DimAuto, top=DimAuto, bottom=DimAuto),
    size: Size(width=DimAuto, height=DimAuto),
    min_size: Size(width=DimAuto, height=DimAuto),
    max_size: Size(width=DimAuto, height=DimAuto),
    aspect_ratio: None,
    margin: Rect(
      left=DimLength(0.0),
      right=DimLength(0.0),
      top=DimLength(0.0),
      bottom=DimLength(0.0),
    ),
    padding: Rect(
      left=DimLength(0.0),
      right=DimLength(0.0),
      top=DimLength(0.0),
      bottom=DimLength(0.0),
    ),
    border: Rect(
      left=DimLength(0.0),
      right=DimLength(0.0),
      top=DimLength(0.0),
      bottom=DimLength(0.0),
    ),
    align_items: None,
    align_self: None,
    justify_items: None,
    justify_self: None,
    align_content: None,
    justify_content: None,
    gap: Size(width=DimLength(0.0), height=DimLength(0.0)),
    flex_direction: FlexRow,
    flex_wrap: FlexNoWrap,
    flex_basis: DimAuto,
    flex_grow: 0.0,
    flex_shrink: 1.0,
    grid_template_rows: [],
    grid_template_columns: [],
    grid_auto_rows: [],
    grid_auto_columns: [],
    grid_auto_flow: Row,
    grid_row: Line(start=PlaceAuto, end=PlaceAuto),
    grid_column: Line(start=PlaceAuto, end=PlaceAuto),
    grid_row_start: None,
    grid_column_start: None,
  }
}
