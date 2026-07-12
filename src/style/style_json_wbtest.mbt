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
