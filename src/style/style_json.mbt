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
    DimRepeat(_, _) => Json::string("Auto")
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
pub impl ToJson for Style with fn to_json(self) {
  Json::object({
    "box_sizing": self.box_sizing.to_json(),
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
pub impl @json.FromJson for Style with fn from_json(json, path) {
  guard json
    is {
      "box_sizing"? : box_sizing,
      "inset"? : inset,
      "size"? : size,
      "min_size"? : min_size,
      "max_size"? : max_size,
      "margin"? : margin,
      "padding"? : padding,
      "border"? : border,
      "gap"? : gap,
      "grid_row"? : grid_row,
      "grid_column"? : grid_column,
      ..
    } else {
    raise JsonDecodeError((path, "Style: expected object"))
  }
  let mut style = Style::default()
  match box_sizing {
    Some(v) =>
      style = style.with_box_sizing(
        @json.from_json(v, path=path.add_key("box_sizing")),
      )
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
  match gap {
    Some(v) =>
      style = style.with_gap(
        parse_dimension_size_partial(v, style.gap, path.add_key("gap")),
      )
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
  style
}
