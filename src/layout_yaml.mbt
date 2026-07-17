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
pub(all) suberror LayoutYamlError {
  EmptyYamlDocument
  MultipleYamlDocuments(Int)
} derive(Debug)

///|
priv struct CompactLayoutDocument {
  document : LayoutDocument
}

///|
fn[T] compact_yaml_error(
  path : @json.JsonPath,
  message : String,
) -> T raise JsonDecodeError {
  raise JsonDecodeError((path, message))
}

///|
fn compact_dimension(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Number(_) => Json::object({ "Length": value })
    String("auto") | String("Auto") => Json::string("Auto")
    String("min-content") | String("MinContent") => Json::string("MinContent")
    String("max-content") | String("MaxContent") => Json::string("MaxContent")
    String(text) =>
      match text.strip_suffix("%") {
        Some(number) =>
          Json::object({
            "Percent": Json::number(@string.parse_double(number) / 100.0),
          }) catch {
            _ => compact_yaml_error(path, "Invalid percentage: \{text}")
          }
        None =>
          match text.strip_suffix("fr") {
            Some(number) =>
              Json::object({ "Fr": Json::number(@string.parse_double(number)) }) catch {
                _ => compact_yaml_error(path, "Invalid fraction: \{text}")
              }
            None => compact_yaml_error(path, "Unsupported dimension: \{text}")
          }
      }
    { .. } => value
    _ => compact_yaml_error(path, "Dimension must be a number or unit string")
  }
}

///|
fn compact_available_space(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Number(_) => value
    String("min-content") | String("MinContent") => Json::string("MinContent")
    String("max-content") | String("MaxContent") => Json::string("MaxContent")
    _ =>
      compact_yaml_error(
        path, "Available space must be a number, min-content, or max-content",
      )
  }
}

///|
fn compact_size(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Array([width, height]) =>
      Json::object({
        "width": compact_dimension(width, path.add_index(0)),
        "height": compact_dimension(height, path.add_index(1)),
      })
    Object(values) => {
      let result : Map[String, Json] = Map([])
      for key, item in values {
        if key != "width" && key != "height" {
          compact_yaml_error(path.add_key(key), "Unknown size field: \{key}")
        }
        result[key] = compact_dimension(item, path.add_key(key))
      }
      Json::object(result)
    }
    _ => compact_yaml_error(path, "Size must be [width, height] or an object")
  }
}

///|
fn compact_rect(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Number(_) | String(_) => {
      let dimension = compact_dimension(value, path)
      Json::object({
        "left": dimension,
        "right": dimension,
        "top": dimension,
        "bottom": dimension,
      })
    }
    Array([vertical_value, horizontal_value]) => {
      let vertical = compact_dimension(vertical_value, path.add_index(0))
      let horizontal = compact_dimension(horizontal_value, path.add_index(1))
      Json::object({
        "left": horizontal,
        "right": horizontal,
        "top": vertical,
        "bottom": vertical,
      })
    }
    Array([top, right, bottom, left]) =>
      Json::object({
        "top": compact_dimension(top, path.add_index(0)),
        "right": compact_dimension(right, path.add_index(1)),
        "bottom": compact_dimension(bottom, path.add_index(2)),
        "left": compact_dimension(left, path.add_index(3)),
      })
    Object(values) => {
      let result : Map[String, Json] = Map([])
      for key, item in values {
        if key != "left" && key != "right" && key != "top" && key != "bottom" {
          compact_yaml_error(path.add_key(key), "Unknown edge: \{key}")
        }
        result[key] = compact_dimension(item, path.add_key(key))
      }
      Json::object(result)
    }
    _ =>
      compact_yaml_error(
        path, "Edges must use one, two, or four values, or an object",
      )
  }
}

///|
fn compact_gap(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Number(_) | String(_) => {
      let dimension = compact_dimension(value, path)
      Json::object({ "width": dimension, "height": dimension })
    }
    Array([row, column]) =>
      Json::object({
        "height": compact_dimension(row, path.add_index(0)),
        "width": compact_dimension(column, path.add_index(1)),
      })
    Object(values) => {
      let result : Map[String, Json] = Map([])
      for key, item in values {
        let canonical_key = match key {
          "x" | "column" | "width" => "width"
          "y" | "row" | "height" => "height"
          _ => compact_yaml_error(path.add_key(key), "Unknown gap axis: \{key}")
        }
        if result.contains(canonical_key) {
          compact_yaml_error(path.add_key(key), "Duplicate gap axis: \{key}")
        }
        result[canonical_key] = compact_dimension(item, path.add_key(key))
      }
      Json::object(result)
    }
    _ => compact_yaml_error(path, "Gap must be a value, pair, or object")
  }
}

///|
fn compact_flow(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  guard value is String(flow) else {
    return compact_yaml_error(path, "Flow must be a string")
  }
  Json::string(
    match flow {
      "row" | "Row" => "Row"
      "column" | "Column" => "Column"
      "row-reverse" | "RowReverse" => "RowReverse"
      "column-reverse" | "ColumnReverse" => "ColumnReverse"
      _ => compact_yaml_error(path, "Unsupported flow: \{flow}")
    },
  )
}

///|
fn compact_align_items(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  guard value is String(align) else {
    return compact_yaml_error(path, "Align must be a string")
  }
  Json::string(
    match align {
      "start" | "Start" => "Start"
      "end" | "End" => "End"
      "flex-start" | "FlexStart" => "FlexStart"
      "flex-end" | "FlexEnd" => "FlexEnd"
      "center" | "Center" => "Center"
      "baseline" | "Baseline" => "Baseline"
      "stretch" | "Stretch" => "Stretch"
      _ => compact_yaml_error(path, "Unsupported alignment: \{align}")
    },
  )
}

///|
fn compact_track_list(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  guard value is Array(values) else {
    return compact_yaml_error(path, "Grid tracks must be an array")
  }
  Json::array(
    values.mapi((index, item) => compact_dimension(item, path.add_index(index))),
  )
}

///|
fn compact_grid_placement(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    Number(number, ..) =>
      Json::object({ "Line": Json::number(number.to_int().to_double()) })
    String("auto") | String("Auto") => Json::string("Auto")
    String(text) =>
      match text.strip_prefix("span ") {
        Some(count) =>
          Json::object({
            "Span": Json::number(@string.parse_int(count).to_double()),
          }) catch {
            _ => compact_yaml_error(path, "Invalid grid span: \{text}")
          }
        None => compact_yaml_error(path, "Unsupported grid placement: \{text}")
      }
    { .. } => value
    _ => compact_yaml_error(path, "Invalid grid placement")
  }
}

///|
fn compact_grid_line(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  guard value is Array([start, end]) else {
    return compact_yaml_error(path, "Grid placement must be [start, end]")
  }
  Json::object({
    "start": compact_grid_placement(start, path.add_index(0)),
    "end": compact_grid_placement(end, path.add_index(1)),
  })
}

///|
fn compact_node_field_allowed(field : String) -> Bool {
  match field {
    "label"
    | "children"
    | "style"
    | "size"
    | "width"
    | "height"
    | "padding"
    | "gap"
    | "flow"
    | "grow"
    | "align"
    | "grid"
    | "place"
    | "absolute" => true
    _ => false
  }
}

///|
fn compact_style_from_node(
  node : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  guard node is Object(fields) else {
    return compact_yaml_error(path, "Node definition must be an object")
  }
  for field, _ in fields {
    if !compact_node_field_allowed(field) {
      compact_yaml_error(path.add_key(field), "Unknown node field: \{field}")
    }
  }
  match node {
    { "style": style, .. } => {
      for field, _ in fields {
        if field != "label" && field != "children" && field != "style" {
          compact_yaml_error(
            path.add_key(field),
            "Compact style fields cannot be mixed with style",
          )
        }
      }
      guard style is { .. } else {
        return compact_yaml_error(
          path.add_key("style"),
          "Style must be an object",
        )
      }
      return style
    }
    _ => ()
  }
  let style : Map[String, Json] = Map([])
  match node {
    { "size": value, "width"? : None, "height"? : None, .. } =>
      style["size"] = compact_size(value, path.add_key("size"))
    { "size": _, .. } =>
      compact_yaml_error(
        path.add_key("size"),
        "Size cannot be combined with width or height",
      )
    { "width"? : width, "height"? : height, .. } => {
      let size : Map[String, Json] = Map([])
      match width {
        Some(value) =>
          size["width"] = compact_dimension(value, path.add_key("width"))
        None => ()
      }
      match height {
        Some(value) =>
          size["height"] = compact_dimension(value, path.add_key("height"))
        None => ()
      }
      if !size.is_empty() {
        style["size"] = Json::object(size)
      }
    }
    _ => abort("unreachable")
  }
  if node is { "padding": value, .. } {
    style["padding"] = compact_rect(value, path.add_key("padding"))
  }
  if node is { "gap": value, .. } {
    style["gap"] = compact_gap(value, path.add_key("gap"))
  }
  if node is { "flow": value, .. } {
    if node is { "grid": _, .. } {
      compact_yaml_error(
        path.add_key("flow"),
        "Flow cannot be combined with grid",
      )
    }
    style["display"] = Json::string("Flex")
    style["flex_direction"] = compact_flow(value, path.add_key("flow"))
  }
  if node is { "grow": value, .. } {
    style["flex_grow"] = value
  }
  if node is { "align": value, .. } {
    style["align_items"] = compact_align_items(value, path.add_key("align"))
  }
  match node {
    { "grid": Object(grid), .. } => {
      style["display"] = Json::string("Grid")
      for field, item in grid {
        match field {
          "columns" =>
            style["grid_template_columns"] = compact_track_list(
              item,
              path.add_key("grid").add_key(field),
            )
          "rows" =>
            style["grid_template_rows"] = compact_track_list(
              item,
              path.add_key("grid").add_key(field),
            )
          _ =>
            compact_yaml_error(
              path.add_key("grid").add_key(field),
              "Unknown grid field: \{field}",
            )
        }
      }
    }
    { "grid": _, .. } =>
      compact_yaml_error(path.add_key("grid"), "Grid must be an object")
    _ => ()
  }
  match node {
    { "place": Object(place), .. } =>
      for field, item in place {
        match field {
          "column" =>
            style["grid_column"] = compact_grid_line(
              item,
              path.add_key("place").add_key(field),
            )
          "row" =>
            style["grid_row"] = compact_grid_line(
              item,
              path.add_key("place").add_key(field),
            )
          _ =>
            compact_yaml_error(
              path.add_key("place").add_key(field),
              "Unknown placement field: \{field}",
            )
        }
      }
    { "place": _, .. } =>
      compact_yaml_error(path.add_key("place"), "Place must be an object")
    _ => ()
  }
  match node {
    { "absolute": true, .. } => style["position"] = Json::string("Absolute")
    { "absolute": { .. } as inset, .. } => {
      style["position"] = Json::string("Absolute")
      style["inset"] = compact_rect(inset, path.add_key("absolute"))
    }
    { "absolute": _, .. } =>
      compact_yaml_error(
        path.add_key("absolute"),
        "Absolute must be true or an inset object",
      )
    _ => ()
  }
  Json::object(style)
}

///|
fn compact_node(
  value : Json,
  path : @json.JsonPath,
) -> Json raise JsonDecodeError {
  match value {
    String(id) =>
      Json::object({
        "id": Json::string(id),
        "label": Json::string(id),
        "style": Json::empty_object(),
        "children": Json::array([]),
      })
    Object(entries) if entries.length() == 1 => {
      let (id, specification) = entries.iter().next().unwrap()
      let definition = match specification {
        Null => Json::empty_object()
        { .. } => specification
        _ =>
          return compact_yaml_error(
            path.add_key(id),
            "Node definition must be an object",
          )
      }
      guard definition
        is { "label"? : label_json, "children"? : children_json, .. } else {
        return compact_yaml_error(
          path.add_key(id),
          "Node definition must be an object",
        )
      }
      let label : String = match label_json {
        Some(value) =>
          @json.from_json(value, path=path.add_key(id).add_key("label"))
        None => id
      }
      let children : Array[Json] = match children_json {
        Some(Array(children)) =>
          children.mapi((index, child) => {
            compact_node(
              child,
              path.add_key(id).add_key("children").add_index(index),
            )
          })
        Some(_) =>
          return compact_yaml_error(
            path.add_key(id).add_key("children"),
            "Children must be an array",
          )
        None => []
      }
      Json::object({
        "id": Json::string(id),
        "label": Json::string(label),
        "style": compact_style_from_node(definition, path.add_key(id)),
        "children": Json::array(children),
      })
    }
    { .. } => compact_yaml_error(path, "A node must contain exactly one id key")
    _ => compact_yaml_error(path, "A node must be a string or object")
  }
}

///|
fn compact_document(
  json : Json,
  path : @json.JsonPath,
) -> LayoutDocument raise JsonDecodeError {
  guard json is { "space"? : space, "layout": layout, .. } else {
    return compact_yaml_error(path, "Compact layout document must be an object")
  }
  guard json is Object(fields) else {
    return compact_yaml_error(path, "Compact layout document must be an object")
  }
  for field, _ in fields {
    if field != "space" && field != "layout" {
      compact_yaml_error(
        path.add_key(field),
        "Unknown document field: \{field}",
      )
    }
  }
  let available_space = match space {
    Some(Array([width, height])) =>
      Json::object({
        "width": compact_available_space(
          width,
          path.add_key("space").add_index(0),
        ),
        "height": compact_available_space(
          height,
          path.add_key("space").add_index(1),
        ),
      })
    Some(_) =>
      return compact_yaml_error(
        path.add_key("space"),
        "Space must be [width, height]",
      )
    None =>
      Json::object({
        "width": Json::string("MaxContent"),
        "height": Json::string("MaxContent"),
      })
  }
  let root = compact_node(layout, path.add_key("layout"))
  LayoutDocument::from_json(
    Json::object({
      "version": Json::number(1.0),
      "available_space": available_space,
      "root": root,
    }),
  )
}

///|
impl @json.FromJson for CompactLayoutDocument with fn from_json(json, path) {
  { document: compact_document(json, path) }
}

///|
pub fn LayoutDocument::from_yaml(source : String) -> LayoutDocument raise {
  let documents = @yaml.Yaml::load_from_string(source)
  if documents.is_empty() || documents[0] is BadValue {
    raise EmptyYamlDocument
  }
  if documents.length() != 1 {
    raise MultipleYamlDocuments(documents.length())
  }
  let json = documents[0].to_json()
  let compact : CompactLayoutDocument = @json.from_json(json)
  compact.document
}

///|
pub fn compute_layout_yaml(input : String) -> String {
  try {
    let document = LayoutDocument::from_yaml(input)
    let result = compute_layout_document(document)
    Json::object({ "ok": Json::boolean(true), "result": result.to_json() }).stringify()
  } catch {
    @yaml.YamlError(mark~, info~) =>
      response_error(
        "parse",
        "line \{mark.line + 1}, column \{mark.col + 1}: \{info}",
      )
    EmptyYamlDocument => response_error("parse", "YAML document is empty")
    MultipleYamlDocuments(count) =>
      response_error("parse", "Expected one YAML document, found \{count}")
    @json.JsonDecodeError((path, message)) =>
      response_error("input", "\{path.to_string()}: \{message}")
    EmptyNodeId => response_error("input", "Node ids must not be empty")
    DuplicateNodeId(id) => response_error("input", "Duplicate node id: \{id}")
    _ => response_error("layout", "Layout computation failed")
  }
}
