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
fn decode_dimension_json(json : Json) -> String raise JsonDecodeError {
  let dimension : Dimension = @json.from_json(json)
  dimension.to_json().stringify()
}

///|
fn decode_dimension_error(json : Json) -> String {
  try decode_dimension_json(json) catch {
    JsonDecodeError((path, message)) => "\{path.to_string()}|\{message}"
  } noraise {
    _ => "ok"
  }
}

///|
test "dimension json variants preserve decoding behavior" {
  let inputs : Array[Json] = [
    "Auto",
    "MinContent",
    "MaxContent",
    { "Length": 12 },
    { "Percent": 0.5 },
    { "Fr": 2 },
    { "Flex": 3 },
    { "FitContent": { "Length": 40 } },
    { "MinMax": [{ "Length": 10 }, { "Fr": 1 }] },
    { "Length": 1, "Percent": 2 },
  ]
  debug_inspect(
    inputs.map(decode_dimension_json),
    content=(
      #|[
      #|  "\"Auto\"",
      #|  "\"MinContent\"",
      #|  "\"MaxContent\"",
      #|  "{\"Length\":12}",
      #|  "{\"Percent\":0.5}",
      #|  "{\"Fr\":2}",
      #|  "{\"Fr\":3}",
      #|  "{\"FitContent\":{\"Length\":40}}",
      #|  "{\"MinMax\":[{\"Length\":10},{\"Fr\":1}]}",
      #|  "{\"Length\":1}",
      #|]
    ),
  )
}

///|
test "dimension json errors preserve messages" {
  debug_inspect(
    [
      decode_dimension_error("unknown"),
      decode_dimension_error({ "MinMax": ["Auto"] }),
      decode_dimension_error({ "MinMax": "Auto" }),
      decode_dimension_error({ "unknown": 1 }),
      decode_dimension_error(true),
    ],
    content=(
      #|[
      #|  "|Dimension: unsupported string",
      #|  "|Dimension: MinMax expects 2 values",
      #|  "|Dimension: MinMax expects array",
      #|  "|Dimension: unsupported object",
      #|  "|Dimension: unsupported json",
      #|]
    ),
  )
}

///|
test "grid placement and box sizing json behavior" {
  let line : GridPlacement = @json.from_json(({ "Line": 4 } : Json))
  let span : GridPlacement = @json.from_json(({ "Span": 2 } : Json))
  let auto : GridPlacement = @json.from_json(("Auto" : Json))
  let border : BoxSizing = @json.from_json(("BorderBox" : Json))
  let content : BoxSizing = @json.from_json(("ContentBox" : Json))
  debug_inspect(
    [
      line.to_json().stringify(),
      span.to_json().stringify(),
      auto.to_json().stringify(),
      border.to_json().stringify(),
      content.to_json().stringify(),
    ],
    content=(
      #|[
      #|  "{\"Line\":4}",
      #|  "{\"Span\":2}",
      #|  "\"Auto\"",
      #|  "\"BorderBox\"",
      #|  "\"ContentBox\"",
      #|]
    ),
  )
}

///|
test "dimension repeat json round trip" {
  let dimension = DimRepeat(RepeatCount(3), [
    DimMinMax(DimLength(80.0), DimFr(1.0)),
    DimAuto,
  ])
  let encoded = dimension.to_json()
  let decoded : Dimension = @json.from_json(encoded)
  assert_eq(decoded.to_json().stringify(), encoded.stringify())
}

///|
test "style json covers every public field" {
  let style : Style = {
    display: DisplayGrid,
    box_sizing: ContentBox,
    overflow: Point(x=OverflowHidden, y=OverflowScroll),
    scrollbar_width: 12.0,
    position: PosAbsolute,
    inset: Rect(
      left=DimLength(1.0),
      right=DimPercent(0.1),
      top=DimAuto,
      bottom=DimLength(4.0),
    ),
    size: Size(width=DimLength(640.0), height=DimPercent(0.5)),
    min_size: Size(width=DimLength(200.0), height=DimMinContent),
    max_size: Size(width=DimMaxContent, height=DimLength(900.0)),
    aspect_ratio: Some(1.5),
    margin: Rect(
      left=DimLength(5.0),
      right=DimLength(6.0),
      top=DimLength(7.0),
      bottom=DimLength(8.0),
    ),
    padding: Rect(
      left=DimLength(9.0),
      right=DimLength(10.0),
      top=DimLength(11.0),
      bottom=DimLength(12.0),
    ),
    border: Rect(
      left=DimLength(1.0),
      right=DimLength(2.0),
      top=DimLength(3.0),
      bottom=DimLength(4.0),
    ),
    align_items: Some(ItemsCenter),
    align_self: Some(ItemsFlexEnd),
    justify_items: Some(ItemsStart),
    justify_self: Some(ItemsStretch),
    align_content: Some(AlignSpaceBetween),
    justify_content: Some(AlignSpaceEvenly),
    gap: Size(width=DimLength(16.0), height=DimPercent(0.02)),
    flex_direction: FlexColumnReverse,
    flex_wrap: FlexWrapReverse,
    flex_basis: DimLength(120.0),
    flex_grow: 2.0,
    flex_shrink: 0.5,
    grid_template_rows: [DimLength(80.0), DimFr(1.0)],
    grid_template_columns: [
      DimRepeat(RepeatAutoFit, [DimMinMax(DimLength(120.0), DimFr(1.0))]),
    ],
    grid_auto_rows: [DimMinContent],
    grid_auto_columns: [DimMaxContent],
    grid_auto_flow: ColumnDense,
    grid_row: Line(start=PlaceLine(2), end=PlaceSpan(3)),
    grid_column: Line(start=PlaceAuto, end=PlaceLine(4)),
    grid_row_start: Some(2),
    grid_column_start: Some(3),
  }
  let encoded = style.to_json()
  let decoded : Style = @json.from_json(encoded)
  assert_eq(decoded.to_json().stringify(), encoded.stringify())
}

///|
test "style json keeps defaults for omitted fields" {
  let style : Style = @json.from_json(
    ({ "display": "Block", "size": { "width": { "Length": 320 } } } : Json),
  )
  assert_true(style.display is DisplayBlock)
  assert_true(style.size.width is DimLength(320.0))
  assert_true(style.size.height is DimAuto)
  assert_true(style.flex_direction is FlexRow)
  assert_eq(style.flex_shrink, 1.0)
}
