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
test "compute layout json returns generic node geometry" {
  let input =
    #|{
    #|  "version": 1,
    #|  "available_space": { "width": 640, "height": 360 },
    #|  "root": {
    #|    "id": "root",
    #|    "style": {
    #|      "size": { "width": { "Length": 320 }, "height": { "Length": 180 } },
    #|      "padding": { "left": { "Length": 10 }, "right": { "Length": 10 }, "top": { "Length": 10 }, "bottom": { "Length": 10 } },
    #|      "gap": { "width": { "Length": 8 } }
    #|    },
    #|    "children": [
    #|      { "id": "left", "style": { "size": { "width": { "Length": 100 }, "height": { "Length": 80 } } } },
    #|      { "id": "right", "style": { "flex_grow": 1, "size": { "height": { "Length": 80 } } } }
    #|    ]
    #|  }
    #|}
  let response = @json.parse(compute_layout_json(input))
  guard response
    is {
      "ok": True,
      "result": { "root_id": String("root"), "nodes": Array(nodes), .. },
      ..
    } else {
    fail("expected successful layout response")
  }
  assert_eq(nodes.length(), 3)
  guard nodes[0]
    is {
      "id": String("root"),
      "layout": {
        "size": { "width": Number(320.0, ..), "height": Number(180.0, ..), .. },
        ..
      },
      ..
    } else {
    fail("expected root geometry")
  }
}

///|
test "compute layout json reports parse and validation errors" {
  guard @json.parse(compute_layout_json("{"))
    is { "ok": False, "error": { "kind": String("parse"), .. }, .. } else {
    fail("expected parse error")
  }
  let duplicate =
    #|{"root":{"id":"same","children":[{"id":"same"}]}}
  guard @json.parse(compute_layout_json(duplicate))
    is { "ok": False, "error": { "kind": String("input"), .. }, .. } else {
    fail("expected duplicate id error")
  }
}
