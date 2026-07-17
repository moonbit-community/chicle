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
test "compact YAML matches canonical JSON layout" {
  let yaml =
    #|space: [640, 360]
    #|layout:
    #|  root:
    #|    size: [320, 180]
    #|    padding: 10
    #|    gap: [0, 8]
    #|    children:
    #|      - left:
    #|          size: [100, 80]
    #|      - right:
    #|          height: 80
    #|          grow: 1
  let canonical =
    #|{
    #|  "available_space": { "width": 640, "height": 360 },
    #|  "root": {
    #|    "id": "root",
    #|    "style": {
    #|      "size": { "width": { "Length": 320 }, "height": { "Length": 180 } },
    #|      "padding": { "left": { "Length": 10 }, "right": { "Length": 10 }, "top": { "Length": 10 }, "bottom": { "Length": 10 } },
    #|      "gap": { "width": { "Length": 8 }, "height": { "Length": 0 } }
    #|    },
    #|    "children": [
    #|      { "id": "left", "style": { "size": { "width": { "Length": 100 }, "height": { "Length": 80 } } } },
    #|      { "id": "right", "style": { "flex_grow": 1, "size": { "height": { "Length": 80 } } } }
    #|    ]
    #|  }
    #|}
  assert_eq(
    @json.parse(compute_layout_yaml(yaml)),
    @json.parse(compute_layout_json(canonical)),
  )
}

///|
test "compact YAML supports grid and absolute positioning" {
  let input =
    #|space: [800, 600]
    #|layout:
    #|  page:
    #|    size: [500, 300]
    #|    grid:
    #|      columns: [180, 1fr]
    #|      rows: [70, 1fr]
    #|    children:
    #|      - header:
    #|          place:
    #|            column: [1, 3]
    #|            row: [1, 2]
    #|      - badge:
    #|          size: [80, 32]
    #|          absolute:
    #|            right: 12
    #|            top: 10
  guard @json.parse(compute_layout_yaml(input))
    is { "ok": True, "result": { "nodes": Array(nodes), .. }, .. } else {
    fail("expected successful compact YAML layout")
  }
  assert_eq(nodes.length(), 3)
}

///|
test "compact YAML reports parser and authoring errors" {
  guard @json.parse(compute_layout_yaml("layout: ["))
    is { "ok": False, "error": { "kind": String("parse"), .. }, .. } else {
    fail("expected YAML parse error")
  }
  let unknown =
    #|layout:
    #|  root:
    #|    pading: 12
  guard @json.parse(compute_layout_yaml(unknown))
    is {
      "ok": False,
      "error": { "kind": String("input"), "message": String(message), .. },
      ..
    } else {
    fail("expected compact YAML input error")
  }
  assert_true(message.contains("pading"))
}
