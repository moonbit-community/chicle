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
    grid_auto_flow: Row,
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

///|
pub impl ToJson for Dimension with to_json(self) {
  match self {
    DimAuto => Json::string("Auto")
    DimLength(v) => Json::object({ "Length": Json::number(v) })
    DimPercent(v) => Json::object({ "Percent": Json::number(v) })
    DimFr(v) => Json::object({ "Fr": Json::number(v) })
    DimMinContent => Json::string("MinContent")
    DimMaxContent => Json::string("MaxContent")
    DimFitContent(limit) => Json::object({ "FitContent": limit.to_json() })
    DimMinMax(min, max) =>
      Json::object({ "MinMax": Json::array([min.to_json(), max.to_json()]) })
    DimRepeat(_, _) => Json::string("Auto")
  }
}

///|
pub impl @json.FromJson for Dimension with from_json(json, path) {
  match json {
    String(s) =>
      match s {
        "Auto" => DimAuto
        "MinContent" => DimMinContent
        "MaxContent" => DimMaxContent
        _ =>
          raise @json.JsonDecodeError((path, "Dimension: unsupported string"))
      }
    Object(obj) =>
      match obj.get("Length") {
        Some(v) => DimLength(@json.from_json(v, path=path.add_key("Length")))
        None =>
          match obj.get("Percent") {
            Some(v) =>
              DimPercent(@json.from_json(v, path=path.add_key("Percent")))
            None =>
              match obj.get("Fr") {
                Some(v) => DimFr(@json.from_json(v, path=path.add_key("Fr")))
                None =>
                  match obj.get("Flex") {
                    Some(v) =>
                      DimFr(@json.from_json(v, path=path.add_key("Flex")))
                    None =>
                      match obj.get("FitContent") {
                        Some(v) =>
                          DimFitContent(
                            @json.from_json(v, path=path.add_key("FitContent")),
                          )
                        None =>
                          match obj.get("MinMax") {
                            Some(v) =>
                              match v {
                                Array(arr) =>
                                  if arr.length() == 2 {
                                    DimMinMax(
                                      @json.from_json(
                                        arr[0],
                                        path=path.add_key("MinMax").add_index(0),
                                      ),
                                      @json.from_json(
                                        arr[1],
                                        path=path.add_key("MinMax").add_index(1),
                                      ),
                                    )
                                  } else {
                                    raise @json.JsonDecodeError(
                                      (
                                        path, "Dimension: MinMax expects 2 values",
                                      ),
                                    )
                                  }
                                _ =>
                                  raise @json.JsonDecodeError(
                                    (path, "Dimension: MinMax expects array"),
                                  )
                              }
                            None =>
                              raise @json.JsonDecodeError(
                                (path, "Dimension: unsupported object"),
                              )
                          }
                      }
                  }
              }
          }
      }
    _ => raise @json.JsonDecodeError((path, "Dimension: unsupported json"))
  }
}

///|
pub impl ToJson for GridPlacement with to_json(self) {
  match self {
    PlaceAuto => Json::string("Auto")
    PlaceLine(v) => Json::object({ "Line": Json::number(v.to_double()) })
    PlaceSpan(v) => Json::object({ "Span": Json::number(v.to_double()) })
  }
}

///|
pub impl @json.FromJson for GridPlacement with from_json(json, path) {
  match json {
    String(s) =>
      match s {
        "Auto" => PlaceAuto
        _ =>
          raise @json.JsonDecodeError(
            (path, "GridPlacement: unsupported string"),
          )
      }
    Object(obj) =>
      match obj.get("Line") {
        Some(v) => PlaceLine(@json.from_json(v, path=path.add_key("Line")))
        None =>
          match obj.get("Span") {
            Some(v) => PlaceSpan(@json.from_json(v, path=path.add_key("Span")))
            None =>
              raise @json.JsonDecodeError(
                (path, "GridPlacement: unsupported object"),
              )
          }
      }
    _ => raise @json.JsonDecodeError((path, "GridPlacement: unsupported json"))
  }
}

///|
fn parse_dimension_rect_partial(
  json : Json,
  base : Rect[Dimension],
  path : @json.JsonPath,
) -> Rect[Dimension] raise @json.JsonDecodeError {
  guard json is Object(obj) else {
    raise @json.JsonDecodeError((path, "Rect<Dimension>: expected object"))
  }
  let mut out = base
  match obj.get("left") {
    Some(v) =>
      out = { ..out, left: @json.from_json(v, path=path.add_key("left")) }
    None => ()
  }
  match obj.get("right") {
    Some(v) =>
      out = { ..out, right: @json.from_json(v, path=path.add_key("right")) }
    None => ()
  }
  match obj.get("top") {
    Some(v) =>
      out = { ..out, top: @json.from_json(v, path=path.add_key("top")) }
    None => ()
  }
  match obj.get("bottom") {
    Some(v) =>
      out = { ..out, bottom: @json.from_json(v, path=path.add_key("bottom")) }
    None => ()
  }
  out
}

///|
fn parse_dimension_size_partial(
  json : Json,
  base : Size[Dimension],
  path : @json.JsonPath,
) -> Size[Dimension] raise @json.JsonDecodeError {
  guard json is Object(obj) else {
    raise @json.JsonDecodeError((path, "Size<Dimension>: expected object"))
  }
  let mut out = base
  match obj.get("width") {
    Some(v) =>
      out = { ..out, width: @json.from_json(v, path=path.add_key("width")) }
    None => ()
  }
  match obj.get("height") {
    Some(v) =>
      out = { ..out, height: @json.from_json(v, path=path.add_key("height")) }
    None => ()
  }
  out
}

///|
fn parse_grid_line_partial(
  json : Json,
  base : Line[GridPlacement],
  path : @json.JsonPath,
) -> Line[GridPlacement] raise @json.JsonDecodeError {
  guard json is Object(obj) else {
    raise @json.JsonDecodeError((path, "Line<GridPlacement>: expected object"))
  }
  let mut out = base
  match obj.get("start") {
    Some(v) =>
      out = { ..out, start: @json.from_json(v, path=path.add_key("start")) }
    None => ()
  }
  match obj.get("end") {
    Some(v) =>
      out = { ..out, end: @json.from_json(v, path=path.add_key("end")) }
    None => ()
  }
  out
}

///|
pub impl ToJson for Style with to_json(self) {
  Json::object({
    "inset": Json::object({
      "left": self.inset.left.to_json(),
      "right": self.inset.right.to_json(),
      "top": self.inset.top.to_json(),
      "bottom": self.inset.bottom.to_json(),
    }),
    "size": Json::object({
      "width": self.size.width.to_json(),
      "height": self.size.height.to_json(),
    }),
    "min_size": Json::object({
      "width": self.min_size.width.to_json(),
      "height": self.min_size.height.to_json(),
    }),
    "max_size": Json::object({
      "width": self.max_size.width.to_json(),
      "height": self.max_size.height.to_json(),
    }),
    "margin": Json::object({
      "left": self.margin.left.to_json(),
      "right": self.margin.right.to_json(),
      "top": self.margin.top.to_json(),
      "bottom": self.margin.bottom.to_json(),
    }),
    "padding": Json::object({
      "left": self.padding.left.to_json(),
      "right": self.padding.right.to_json(),
      "top": self.padding.top.to_json(),
      "bottom": self.padding.bottom.to_json(),
    }),
    "border": Json::object({
      "left": self.border.left.to_json(),
      "right": self.border.right.to_json(),
      "top": self.border.top.to_json(),
      "bottom": self.border.bottom.to_json(),
    }),
    "gap": Json::object({
      "width": self.gap.width.to_json(),
      "height": self.gap.height.to_json(),
    }),
    "grid_row": Json::object({
      "start": self.grid_row.start.to_json(),
      "end": self.grid_row.end.to_json(),
    }),
    "grid_column": Json::object({
      "start": self.grid_column.start.to_json(),
      "end": self.grid_column.end.to_json(),
    }),
  })
}

///|
pub impl @json.FromJson for Style with from_json(json, path) {
  guard json is Object(obj) else {
    raise @json.JsonDecodeError((path, "Style: expected object"))
  }
  let mut style = Style::default()
  match obj.get("inset") {
    Some(v) =>
      style = style.with_inset(
        parse_dimension_rect_partial(v, style.inset, path.add_key("inset")),
      )
    None => ()
  }
  match obj.get("size") {
    Some(v) =>
      style = style.with_size(
        parse_dimension_size_partial(v, style.size, path.add_key("size")),
      )
    None => ()
  }
  match obj.get("min_size") {
    Some(v) =>
      style = style.with_min_size(
        parse_dimension_size_partial(
          v,
          style.min_size,
          path.add_key("min_size"),
        ),
      )
    None => ()
  }
  match obj.get("max_size") {
    Some(v) =>
      style = style.with_max_size(
        parse_dimension_size_partial(
          v,
          style.max_size,
          path.add_key("max_size"),
        ),
      )
    None => ()
  }
  match obj.get("margin") {
    Some(v) =>
      style = style.with_margin(
        parse_dimension_rect_partial(v, style.margin, path.add_key("margin")),
      )
    None => ()
  }
  match obj.get("padding") {
    Some(v) =>
      style = style.with_padding(
        parse_dimension_rect_partial(v, style.padding, path.add_key("padding")),
      )
    None => ()
  }
  match obj.get("border") {
    Some(v) =>
      style = style.with_border(
        parse_dimension_rect_partial(v, style.border, path.add_key("border")),
      )
    None => ()
  }
  match obj.get("gap") {
    Some(v) =>
      style = style.with_gap(
        parse_dimension_size_partial(v, style.gap, path.add_key("gap")),
      )
    None => ()
  }
  match obj.get("grid_row") {
    Some(v) =>
      style = style.with_grid_row(
        parse_grid_line_partial(v, style.grid_row, path.add_key("grid_row")),
      )
    None => ()
  }
  match obj.get("grid_column") {
    Some(v) =>
      style = style.with_grid_column(
        parse_grid_line_partial(
          v,
          style.grid_column,
          path.add_key("grid_column"),
        ),
      )
    None => ()
  }
  style
}
