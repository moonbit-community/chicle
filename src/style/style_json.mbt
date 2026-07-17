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
type JsonDecodeError = @json.JsonDecodeError

///|
pub impl ToJson for Dimension with fn to_json(self) {
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
    DimRepeat(repetition, tracks) =>
      Json::object({
        "Repeat": Json::object({
          "repetition": repetition.to_json(),
          "tracks": Json::array(tracks.map(fn(track) { track.to_json() })),
        }),
      })
  }
}

///|
pub impl @json.FromJson for Dimension with fn from_json(json, path) {
  match json {
    String("Auto") => DimAuto
    String("MinContent") => DimMinContent
    String("MaxContent") => DimMaxContent
    String(_) => raise JsonDecodeError((path, "Dimension: unsupported string"))
    { "Length": value, .. } =>
      DimLength(@json.from_json(value, path=path.add_key("Length")))
    { "Percent": value, .. } =>
      DimPercent(@json.from_json(value, path=path.add_key("Percent")))
    { "Fr": value, .. } =>
      DimFr(@json.from_json(value, path=path.add_key("Fr")))
    { "Flex": value, .. } =>
      DimFr(@json.from_json(value, path=path.add_key("Flex")))
    { "FitContent": value, .. } =>
      DimFitContent(@json.from_json(value, path=path.add_key("FitContent")))
    { "Repeat": { "repetition": repetition, "tracks": tracks, .. }, .. } =>
      DimRepeat(
        @json.from_json(
          repetition,
          path=path.add_key("Repeat").add_key("repetition"),
        ),
        @json.from_json(tracks, path=path.add_key("Repeat").add_key("tracks")),
      )
    { "MinMax": Array([min, max]), .. } =>
      DimMinMax(
        @json.from_json(min, path=path.add_key("MinMax").add_index(0)),
        @json.from_json(max, path=path.add_key("MinMax").add_index(1)),
      )
    { "MinMax": Array(_), .. } =>
      raise JsonDecodeError((path, "Dimension: MinMax expects 2 values"))
    { "MinMax": _, .. } =>
      raise JsonDecodeError((path, "Dimension: MinMax expects array"))
    Object(_) => raise JsonDecodeError((path, "Dimension: unsupported object"))
    _ => raise JsonDecodeError((path, "Dimension: unsupported json"))
  }
}

///|
pub impl ToJson for GridPlacement with fn to_json(self) {
  match self {
    PlaceAuto => Json::string("Auto")
    PlaceLine(v) => Json::object({ "Line": Json::number(v.to_double()) })
    PlaceSpan(v) => Json::object({ "Span": Json::number(v.to_double()) })
  }
}

///|
pub impl @json.FromJson for GridPlacement with fn from_json(json, path) {
  match json {
    String("Auto") => PlaceAuto
    String(_) =>
      raise JsonDecodeError((path, "GridPlacement: unsupported string"))
    { "Line": value, .. } =>
      PlaceLine(@json.from_json(value, path=path.add_key("Line")))
    { "Span": value, .. } =>
      PlaceSpan(@json.from_json(value, path=path.add_key("Span")))
    Object(_) =>
      raise JsonDecodeError((path, "GridPlacement: unsupported object"))
    _ => raise JsonDecodeError((path, "GridPlacement: unsupported json"))
  }
}

///|
pub impl ToJson for BoxSizing with fn to_json(self) {
  match self {
    BorderBox => Json::string("BorderBox")
    ContentBox => Json::string("ContentBox")
  }
}

///|
pub impl @json.FromJson for BoxSizing with fn from_json(json, path) {
  match json {
    String("BorderBox") => BorderBox
    String("ContentBox") => ContentBox
    String(_) => raise JsonDecodeError((path, "BoxSizing: unsupported string"))
    _ => raise JsonDecodeError((path, "BoxSizing: expected string"))
  }
}

///|
pub impl ToJson for GridTrackRepetition with fn to_json(self) {
  match self {
    RepeatCount(count) =>
      Json::object({ "Count": Json::number(count.to_double()) })
    RepeatAutoFill => Json::string("AutoFill")
    RepeatAutoFit => Json::string("AutoFit")
  }
}

///|
pub impl @json.FromJson for GridTrackRepetition with fn from_json(json, path) {
  match json {
    String("AutoFill") => RepeatAutoFill
    String("AutoFit") => RepeatAutoFit
    { "Count": value, .. } =>
      RepeatCount(@json.from_json(value, path=path.add_key("Count")))
    String(_) =>
      raise JsonDecodeError((path, "GridTrackRepetition: unsupported string"))
    _ =>
      raise JsonDecodeError(
        (path, "GridTrackRepetition: expected string or object"),
      )
  }
}

///|
pub impl ToJson for Display with fn to_json(self) {
  Json::string(
    match self {
      DisplayBlock => "Block"
      DisplayFlex => "Flex"
      DisplayGrid => "Grid"
      DisplayNone => "None"
    },
  )
}

///|
pub impl @json.FromJson for Display with fn from_json(json, path) {
  match json {
    String("Block") => DisplayBlock
    String("Flex") => DisplayFlex
    String("Grid") => DisplayGrid
    String("None") => DisplayNone
    String(_) => raise JsonDecodeError((path, "Display: unsupported string"))
    _ => raise JsonDecodeError((path, "Display: expected string"))
  }
}

///|
pub impl ToJson for Position with fn to_json(self) {
  Json::string(
    match self {
      PosRelative => "Relative"
      PosAbsolute => "Absolute"
    },
  )
}

///|
pub impl @json.FromJson for Position with fn from_json(json, path) {
  match json {
    String("Relative") => PosRelative
    String("Absolute") => PosAbsolute
    String(_) => raise JsonDecodeError((path, "Position: unsupported string"))
    _ => raise JsonDecodeError((path, "Position: expected string"))
  }
}

///|
pub impl ToJson for Overflow with fn to_json(self) {
  Json::string(
    match self {
      OverflowVisible => "Visible"
      OverflowClip => "Clip"
      OverflowHidden => "Hidden"
      OverflowScroll => "Scroll"
    },
  )
}

///|
pub impl @json.FromJson for Overflow with fn from_json(json, path) {
  match json {
    String("Visible") => OverflowVisible
    String("Clip") => OverflowClip
    String("Hidden") => OverflowHidden
    String("Scroll") => OverflowScroll
    String(_) => raise JsonDecodeError((path, "Overflow: unsupported string"))
    _ => raise JsonDecodeError((path, "Overflow: expected string"))
  }
}

///|
pub impl ToJson for AlignItems with fn to_json(self) {
  Json::string(
    match self {
      ItemsStart => "Start"
      ItemsEnd => "End"
      ItemsFlexStart => "FlexStart"
      ItemsFlexEnd => "FlexEnd"
      ItemsCenter => "Center"
      ItemsBaseline => "Baseline"
      ItemsStretch => "Stretch"
    },
  )
}

///|
pub impl @json.FromJson for AlignItems with fn from_json(json, path) {
  match json {
    String("Start") => ItemsStart
    String("End") => ItemsEnd
    String("FlexStart") => ItemsFlexStart
    String("FlexEnd") => ItemsFlexEnd
    String("Center") => ItemsCenter
    String("Baseline") => ItemsBaseline
    String("Stretch") => ItemsStretch
    String(_) => raise JsonDecodeError((path, "AlignItems: unsupported string"))
    _ => raise JsonDecodeError((path, "AlignItems: expected string"))
  }
}

///|
pub impl ToJson for AlignContent with fn to_json(self) {
  Json::string(
    match self {
      AlignStart => "Start"
      AlignEnd => "End"
      AlignFlexStart => "FlexStart"
      AlignFlexEnd => "FlexEnd"
      AlignCenter => "Center"
      AlignStretch => "Stretch"
      AlignSpaceBetween => "SpaceBetween"
      AlignSpaceEvenly => "SpaceEvenly"
      AlignSpaceAround => "SpaceAround"
    },
  )
}

///|
pub impl @json.FromJson for AlignContent with fn from_json(json, path) {
  match json {
    String("Start") => AlignStart
    String("End") => AlignEnd
    String("FlexStart") => AlignFlexStart
    String("FlexEnd") => AlignFlexEnd
    String("Center") => AlignCenter
    String("Stretch") => AlignStretch
    String("SpaceBetween") => AlignSpaceBetween
    String("SpaceEvenly") => AlignSpaceEvenly
    String("SpaceAround") => AlignSpaceAround
    String(_) =>
      raise JsonDecodeError((path, "AlignContent: unsupported string"))
    _ => raise JsonDecodeError((path, "AlignContent: expected string"))
  }
}

///|
pub impl ToJson for FlexDirection with fn to_json(self) {
  Json::string(
    match self {
      FlexRow => "Row"
      FlexRowReverse => "RowReverse"
      FlexColumn => "Column"
      FlexColumnReverse => "ColumnReverse"
    },
  )
}

///|
pub impl @json.FromJson for FlexDirection with fn from_json(json, path) {
  match json {
    String("Row") => FlexRow
    String("RowReverse") => FlexRowReverse
    String("Column") => FlexColumn
    String("ColumnReverse") => FlexColumnReverse
    String(_) =>
      raise JsonDecodeError((path, "FlexDirection: unsupported string"))
    _ => raise JsonDecodeError((path, "FlexDirection: expected string"))
  }
}

///|
pub impl ToJson for FlexWrap with fn to_json(self) {
  Json::string(
    match self {
      FlexNoWrap => "NoWrap"
      FlexWrap => "Wrap"
      FlexWrapReverse => "WrapReverse"
    },
  )
}

///|
pub impl @json.FromJson for FlexWrap with fn from_json(json, path) {
  match json {
    String("NoWrap") => FlexNoWrap
    String("Wrap") => FlexWrap
    String("WrapReverse") => FlexWrapReverse
    String(_) => raise JsonDecodeError((path, "FlexWrap: unsupported string"))
    _ => raise JsonDecodeError((path, "FlexWrap: expected string"))
  }
}

///|
pub impl ToJson for GridAutoFlow with fn to_json(self) {
  Json::string(
    match self {
      Row => "Row"
      Column => "Column"
      RowDense => "RowDense"
      ColumnDense => "ColumnDense"
    },
  )
}

///|
pub impl @json.FromJson for GridAutoFlow with fn from_json(json, path) {
  match json {
    String("Row") => Row
    String("Column") => Column
    String("RowDense") => RowDense
    String("ColumnDense") => ColumnDense
    String(_) =>
      raise JsonDecodeError((path, "GridAutoFlow: unsupported string"))
    _ => raise JsonDecodeError((path, "GridAutoFlow: expected string"))
  }
}

///|
fn parse_dimension_rect_partial(
  json : Json,
  base : Rect[Dimension],
  path : @json.JsonPath,
) -> Rect[Dimension] raise JsonDecodeError {
  guard json
    is {
      "left"? : left,
      "right"? : right,
      "top"? : top,
      "bottom"? : bottom,
      ..
    } else {
    raise JsonDecodeError((path, "Rect<Dimension>: expected object"))
  }
  let mut out = base
  match left {
    Some(v) =>
      out = { ..out, left: @json.from_json(v, path=path.add_key("left")) }
    None => ()
  }
  match right {
    Some(v) =>
      out = { ..out, right: @json.from_json(v, path=path.add_key("right")) }
    None => ()
  }
  match top {
    Some(v) =>
      out = { ..out, top: @json.from_json(v, path=path.add_key("top")) }
    None => ()
  }
  match bottom {
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
) -> Size[Dimension] raise JsonDecodeError {
  guard json is { "width"? : width, "height"? : height, .. } else {
    raise JsonDecodeError((path, "Size<Dimension>: expected object"))
  }
  let mut out = base
  match width {
    Some(v) =>
      out = { ..out, width: @json.from_json(v, path=path.add_key("width")) }
    None => ()
  }
  match height {
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
) -> Line[GridPlacement] raise JsonDecodeError {
  guard json is { "start"? : start, "end"? : end, .. } else {
    raise JsonDecodeError((path, "Line<GridPlacement>: expected object"))
  }
  let mut out = base
  match start {
    Some(v) =>
      out = { ..out, start: @json.from_json(v, path=path.add_key("start")) }
    None => ()
  }
  match end {
    Some(v) =>
      out = { ..out, end: @json.from_json(v, path=path.add_key("end")) }
    None => ()
  }
  out
}

///|
fn parse_overflow_point_partial(
  json : Json,
  base : Point[Overflow],
  path : @json.JsonPath,
) -> Point[Overflow] raise JsonDecodeError {
  guard json is { "x"? : x, "y"? : y, .. } else {
    raise JsonDecodeError((path, "Point<Overflow>: expected object"))
  }
  let mut out = base
  match x {
    Some(v) => out = { ..out, x: @json.from_json(v, path=path.add_key("x")) }
    None => ()
  }
  match y {
    Some(v) => out = { ..out, y: @json.from_json(v, path=path.add_key("y")) }
    None => ()
  }
  out
}

///|
fn[T : ToJson] optional_to_json(value : T?) -> Json {
  match value {
    Some(value) => value.to_json()
    None => Json::null()
  }
}

///|
fn[T : @json.FromJson] nullable_from_json(
  json : Json,
  path : @json.JsonPath,
) -> T? raise JsonDecodeError {
  match json {
    Null => None
    _ => Some(@json.from_json(json, path~))
  }
}

///|
fn[T : ToJson] array_to_json(values : Array[T]) -> Json {
  Json::array(values.map(fn(value) { value.to_json() }))
}

///|
pub impl ToJson for Style with fn to_json(self) {
  Json::object({
    "display": self.display.to_json(),
    "box_sizing": self.box_sizing.to_json(),
    "overflow": Json::object({
      "x": self.overflow.x.to_json(),
      "y": self.overflow.y.to_json(),
    }),
    "scrollbar_width": Json::number(self.scrollbar_width),
    "position": self.position.to_json(),
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
    "aspect_ratio": optional_to_json(self.aspect_ratio),
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
    "align_items": optional_to_json(self.align_items),
    "align_self": optional_to_json(self.align_self),
    "justify_items": optional_to_json(self.justify_items),
    "justify_self": optional_to_json(self.justify_self),
    "align_content": optional_to_json(self.align_content),
    "justify_content": optional_to_json(self.justify_content),
    "gap": Json::object({
      "width": self.gap.width.to_json(),
      "height": self.gap.height.to_json(),
    }),
    "flex_direction": self.flex_direction.to_json(),
    "flex_wrap": self.flex_wrap.to_json(),
    "flex_basis": self.flex_basis.to_json(),
    "flex_grow": Json::number(self.flex_grow),
    "flex_shrink": Json::number(self.flex_shrink),
    "grid_template_rows": array_to_json(self.grid_template_rows),
    "grid_template_columns": array_to_json(self.grid_template_columns),
    "grid_auto_rows": array_to_json(self.grid_auto_rows),
    "grid_auto_columns": array_to_json(self.grid_auto_columns),
    "grid_auto_flow": self.grid_auto_flow.to_json(),
    "grid_row": Json::object({
      "start": self.grid_row.start.to_json(),
      "end": self.grid_row.end.to_json(),
    }),
    "grid_column": Json::object({
      "start": self.grid_column.start.to_json(),
      "end": self.grid_column.end.to_json(),
    }),
    "grid_row_start": optional_to_json(self.grid_row_start),
    "grid_column_start": optional_to_json(self.grid_column_start),
  })
}

///|
pub impl @json.FromJson for Style with fn from_json(json, path) {
  guard json
    is {
      "display"? : display,
      "box_sizing"? : box_sizing,
      "overflow"? : overflow,
      "scrollbar_width"? : scrollbar_width,
      "position"? : position,
      "inset"? : inset,
      "size"? : size,
      "min_size"? : min_size,
      "max_size"? : max_size,
      "aspect_ratio"? : aspect_ratio,
      "margin"? : margin,
      "padding"? : padding,
      "border"? : border,
      "align_items"? : align_items,
      "align_self"? : align_self,
      "justify_items"? : justify_items,
      "justify_self"? : justify_self,
      "align_content"? : align_content,
      "justify_content"? : justify_content,
      "gap"? : gap,
      "flex_direction"? : flex_direction,
      "flex_wrap"? : flex_wrap,
      "flex_basis"? : flex_basis,
      "flex_grow"? : flex_grow,
      "flex_shrink"? : flex_shrink,
      "grid_template_rows"? : grid_template_rows,
      "grid_template_columns"? : grid_template_columns,
      "grid_auto_rows"? : grid_auto_rows,
      "grid_auto_columns"? : grid_auto_columns,
      "grid_auto_flow"? : grid_auto_flow,
      "grid_row"? : grid_row,
      "grid_column"? : grid_column,
      "grid_row_start"? : grid_row_start,
      "grid_column_start"? : grid_column_start,
      ..
    } else {
    raise JsonDecodeError((path, "Style: expected object"))
  }
  let mut style = Style::default()
  match display {
    Some(v) =>
      style = {
        ..style,
        display: @json.from_json(v, path=path.add_key("display")),
      }
    None => ()
  }
  match box_sizing {
    Some(v) =>
      style = {
        ..style,
        box_sizing: @json.from_json(v, path=path.add_key("box_sizing")),
      }
    None => ()
  }
  match overflow {
    Some(v) =>
      style = {
        ..style,
        overflow: parse_overflow_point_partial(
          v,
          style.overflow,
          path.add_key("overflow"),
        ),
      }
    None => ()
  }
  match scrollbar_width {
    Some(v) =>
      style = {
        ..style,
        scrollbar_width: @json.from_json(
          v,
          path=path.add_key("scrollbar_width"),
        ),
      }
    None => ()
  }
  match position {
    Some(v) =>
      style = {
        ..style,
        position: @json.from_json(v, path=path.add_key("position")),
      }
    None => ()
  }
  match inset {
    Some(v) =>
      style = style.with_inset(
        parse_dimension_rect_partial(v, style.inset, path.add_key("inset")),
      )
    None => ()
  }
  match size {
    Some(v) =>
      style = style.with_size(
        parse_dimension_size_partial(v, style.size, path.add_key("size")),
      )
    None => ()
  }
  match min_size {
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
  match max_size {
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
  match aspect_ratio {
    Some(v) =>
      style = {
        ..style,
        aspect_ratio: nullable_from_json(v, path.add_key("aspect_ratio")),
      }
    None => ()
  }
  match margin {
    Some(v) =>
      style = style.with_margin(
        parse_dimension_rect_partial(v, style.margin, path.add_key("margin")),
      )
    None => ()
  }
  match padding {
    Some(v) =>
      style = style.with_padding(
        parse_dimension_rect_partial(v, style.padding, path.add_key("padding")),
      )
    None => ()
  }
  match border {
    Some(v) =>
      style = style.with_border(
        parse_dimension_rect_partial(v, style.border, path.add_key("border")),
      )
    None => ()
  }
  match align_items {
    Some(v) =>
      style = {
        ..style,
        align_items: nullable_from_json(v, path.add_key("align_items")),
      }
    None => ()
  }
  match align_self {
    Some(v) =>
      style = {
        ..style,
        align_self: nullable_from_json(v, path.add_key("align_self")),
      }
    None => ()
  }
  match justify_items {
    Some(v) =>
      style = {
        ..style,
        justify_items: nullable_from_json(v, path.add_key("justify_items")),
      }
    None => ()
  }
  match justify_self {
    Some(v) =>
      style = {
        ..style,
        justify_self: nullable_from_json(v, path.add_key("justify_self")),
      }
    None => ()
  }
  match align_content {
    Some(v) =>
      style = {
        ..style,
        align_content: nullable_from_json(v, path.add_key("align_content")),
      }
    None => ()
  }
  match justify_content {
    Some(v) =>
      style = {
        ..style,
        justify_content: nullable_from_json(v, path.add_key("justify_content")),
      }
    None => ()
  }
  match gap {
    Some(v) =>
      style = style.with_gap(
        parse_dimension_size_partial(v, style.gap, path.add_key("gap")),
      )
    None => ()
  }
  match flex_direction {
    Some(v) =>
      style = {
        ..style,
        flex_direction: @json.from_json(v, path=path.add_key("flex_direction")),
      }
    None => ()
  }
  match flex_wrap {
    Some(v) =>
      style = {
        ..style,
        flex_wrap: @json.from_json(v, path=path.add_key("flex_wrap")),
      }
    None => ()
  }
  match flex_basis {
    Some(v) =>
      style = {
        ..style,
        flex_basis: @json.from_json(v, path=path.add_key("flex_basis")),
      }
    None => ()
  }
  match flex_grow {
    Some(v) =>
      style = {
        ..style,
        flex_grow: @json.from_json(v, path=path.add_key("flex_grow")),
      }
    None => ()
  }
  match flex_shrink {
    Some(v) =>
      style = {
        ..style,
        flex_shrink: @json.from_json(v, path=path.add_key("flex_shrink")),
      }
    None => ()
  }
  match grid_template_rows {
    Some(v) =>
      style = {
        ..style,
        grid_template_rows: @json.from_json(
          v,
          path=path.add_key("grid_template_rows"),
        ),
      }
    None => ()
  }
  match grid_template_columns {
    Some(v) =>
      style = {
        ..style,
        grid_template_columns: @json.from_json(
          v,
          path=path.add_key("grid_template_columns"),
        ),
      }
    None => ()
  }
  match grid_auto_rows {
    Some(v) =>
      style = {
        ..style,
        grid_auto_rows: @json.from_json(v, path=path.add_key("grid_auto_rows")),
      }
    None => ()
  }
  match grid_auto_columns {
    Some(v) =>
      style = {
        ..style,
        grid_auto_columns: @json.from_json(
          v,
          path=path.add_key("grid_auto_columns"),
        ),
      }
    None => ()
  }
  match grid_auto_flow {
    Some(v) =>
      style = {
        ..style,
        grid_auto_flow: @json.from_json(v, path=path.add_key("grid_auto_flow")),
      }
    None => ()
  }
  match grid_row {
    Some(v) =>
      style = style.with_grid_row(
        parse_grid_line_partial(v, style.grid_row, path.add_key("grid_row")),
      )
    None => ()
  }
  match grid_column {
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
  match grid_row_start {
    Some(v) =>
      style = {
        ..style,
        grid_row_start: nullable_from_json(v, path.add_key("grid_row_start")),
      }
    None => ()
  }
  match grid_column_start {
    Some(v) =>
      style = {
        ..style,
        grid_column_start: nullable_from_json(
          v,
          path.add_key("grid_column_start"),
        ),
      }
    None => ()
  }
  style
}
