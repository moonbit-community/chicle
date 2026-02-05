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
pub enum GridTrackRepetition {
  RepeatCount(Int)
  RepeatAutoFill
  RepeatAutoFit
}

///|
pub enum GridAutoFlow {
  AutoFlowRow
  AutoFlowColumn
  AutoFlowRowDense
  AutoFlowColumnDense
}

///|
pub enum GridPlacement {
  PlaceAuto
  PlaceLine(Int)
  PlaceSpan(Int)
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
pub enum Display {
  DisplayBlock
  DisplayFlex
  DisplayGrid
  DisplayNone
}

///|
pub enum Position {
  PosRelative
  PosAbsolute
}

///|
pub enum Overflow {
  OverflowVisible
  OverflowClip
  OverflowHidden
  OverflowScroll
}

///|
pub enum FlexDirection {
  FlexRow
  FlexRowReverse
  FlexColumn
  FlexColumnReverse
}

///|
pub enum FlexWrap {
  FlexNoWrap
  FlexWrap
  FlexWrapReverse
}

///|
pub enum AlignItems {
  ItemsStart
  ItemsEnd
  ItemsFlexStart
  ItemsFlexEnd
  ItemsCenter
  ItemsBaseline
  ItemsStretch
}

///|
pub type JustifyItems = AlignItems

///|
pub type AlignSelf = AlignItems

///|
pub type JustifySelf = AlignItems

///|
pub enum AlignContent {
  AlignStart
  AlignEnd
  AlignFlexStart
  AlignFlexEnd
  AlignCenter
  AlignStretch
  AlignSpaceBetween
  AlignSpaceEvenly
  AlignSpaceAround
}

///|
pub type JustifyContent = AlignContent

///|
pub struct Style {
  display : Display
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
  Style::{
    display: DisplayFlex,
    overflow: Point::{ x: OverflowVisible, y: OverflowVisible },
    scrollbar_width: 0.0,
    position: PosRelative,
    inset: Rect::new(left=DimAuto, right=DimAuto, top=DimAuto, bottom=DimAuto),
    size: Size::new(width=DimAuto, height=DimAuto),
    min_size: Size::new(width=DimAuto, height=DimAuto),
    max_size: Size::new(width=DimAuto, height=DimAuto),
    aspect_ratio: None,
    margin: Rect::new(
      left=DimLength(0.0),
      right=DimLength(0.0),
      top=DimLength(0.0),
      bottom=DimLength(0.0),
    ),
    padding: Rect::new(
      left=DimLength(0.0),
      right=DimLength(0.0),
      top=DimLength(0.0),
      bottom=DimLength(0.0),
    ),
    border: Rect::new(
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
    gap: Size::new(width=DimLength(0.0), height=DimLength(0.0)),
    flex_direction: FlexRow,
    flex_wrap: FlexNoWrap,
    flex_basis: DimAuto,
    flex_grow: 0.0,
    flex_shrink: 1.0,
    grid_template_rows: [],
    grid_template_columns: [],
    grid_auto_rows: [],
    grid_auto_columns: [],
    grid_auto_flow: AutoFlowRow,
    grid_row: Line::new(start=PlaceAuto, end=PlaceAuto),
    grid_column: Line::new(start=PlaceAuto, end=PlaceAuto),
    grid_row_start: None,
    grid_column_start: None,
  }
}

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
pub fn Style::with_position(self : Style, position : Position) -> Style {
  { ..self, position, }
}

///|
pub fn Style::with_overflow(self : Style, overflow : Point[Overflow]) -> Style {
  { ..self, overflow, }
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
pub fn Style::with_grid_template_columns(
  self : Style,
  grid_template_columns : Array[Dimension],
) -> Style {
  { ..self, grid_template_columns, }
}

///|
pub fn Style::with_grid_auto_rows(
  self : Style,
  grid_auto_rows : Array[Dimension],
) -> Style {
  { ..self, grid_auto_rows, }
}

///|
pub fn Style::with_grid_auto_columns(
  self : Style,
  grid_auto_columns : Array[Dimension],
) -> Style {
  { ..self, grid_auto_columns, }
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
    grid_row: Line::new(start=PlaceLine(start), end=PlaceAuto),
  }
}

///|
pub fn Style::with_grid_column_start(self : Style, start : Int) -> Style {
  {
    ..self,
    grid_column_start: Some(start),
    grid_column: Line::new(start=PlaceLine(start), end=PlaceAuto),
  }
}
