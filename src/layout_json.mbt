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
pub(all) suberror LayoutDocumentError {
  EmptyNodeId
  DuplicateNodeId(String)
} derive(Debug)

///|
pub(all) struct LayoutNode {
  id : String
  label : String
  style : @style.Style
  children : Array[LayoutNode]
}

///|
pub(all) struct LayoutDocument {
  version : Int
  available_space : @geometry.Size[@geometry.AvailableSpace]
  root : LayoutNode
}

///|
pub(all) struct LayoutResultNode {
  id : String
  label : String
  parent_id : String?
  depth : Int
  layout : @tree.Layout
}

///|
pub(all) struct LayoutResult {
  root_id : String
  nodes : Array[LayoutResultNode]
}

///|
priv struct BuiltNode {
  id : String
  label : String
  parent_id : String?
  depth : Int
  tree_id : @tree.NodeId
}

///|
fn available_space_from_json(
  json : Json,
  path : @json.JsonPath,
) -> @geometry.AvailableSpace raise JsonDecodeError {
  match json {
    String("MinContent") => AvailMinContent
    String("MaxContent") => AvailMaxContent
    String(_) =>
      raise JsonDecodeError((path, "AvailableSpace: unsupported string"))
    _ => {
      let value : Double = @json.from_json(json, path~)
      AvailDefinite(value)
    }
  }
}

///|
fn available_space_to_json(space : @geometry.AvailableSpace) -> Json {
  match space {
    AvailDefinite(value) => Json::number(value)
    AvailMinContent => Json::string("MinContent")
    AvailMaxContent => Json::string("MaxContent")
  }
}

///|
fn available_size_from_json(
  json : Json,
  path : @json.JsonPath,
) -> @geometry.Size[@geometry.AvailableSpace] raise JsonDecodeError {
  guard json is { "width"? : width, "height"? : height, .. } else {
    raise JsonDecodeError((path, "AvailableSpace size: expected object"))
  }
  let parsed_width = match width {
    Some(value) => available_space_from_json(value, path.add_key("width"))
    None => AvailMaxContent
  }
  let parsed_height = match height {
    Some(value) => available_space_from_json(value, path.add_key("height"))
    None => AvailMaxContent
  }
  Size(width=parsed_width, height=parsed_height)
}

///|
fn available_size_to_json(
  size : @geometry.Size[@geometry.AvailableSpace],
) -> Json {
  Json::object({
    "width": available_space_to_json(size.width),
    "height": available_space_to_json(size.height),
  })
}

///|
pub impl @json.FromJson for LayoutNode with fn from_json(json, path) {
  guard json
    is {
      "id": id_json,
      "label"? : label_json,
      "style"? : style_json,
      "children"? : children_json,
      ..
    } else {
    raise JsonDecodeError((path, "LayoutNode: expected object with id"))
  }
  let id : String = @json.from_json(id_json, path=path.add_key("id"))
  let label : String = match label_json {
    Some(value) => @json.from_json(value, path=path.add_key("label"))
    None => id
  }
  let style : @style.Style = match style_json {
    Some(value) => @json.from_json(value, path=path.add_key("style"))
    None => @style.Style::default()
  }
  let children : Array[LayoutNode] = match children_json {
    Some(value) => @json.from_json(value, path=path.add_key("children"))
    None => []
  }
  { id, label, style, children }
}

///|
pub impl ToJson for LayoutNode with fn to_json(self) {
  Json::object({
    "id": Json::string(self.id),
    "label": Json::string(self.label),
    "style": self.style.to_json(),
    "children": Json::array(self.children.map(fn(child) { child.to_json() })),
  })
}

///|
pub impl @json.FromJson for LayoutDocument with fn from_json(json, path) {
  guard json
    is {
      "version"? : version_json,
      "available_space"? : available_space_json,
      "root": root_json,
      ..
    } else {
    raise JsonDecodeError((path, "LayoutDocument: expected object with root"))
  }
  let version : Int = match version_json {
    Some(value) => @json.from_json(value, path=path.add_key("version"))
    None => 1
  }
  if version != 1 {
    raise JsonDecodeError(
      (path.add_key("version"), "Only version 1 is supported"),
    )
  }
  let available_space = match available_space_json {
    Some(value) =>
      available_size_from_json(value, path.add_key("available_space"))
    None => @geometry.Size::max_content()
  }
  let root : LayoutNode = @json.from_json(root_json, path=path.add_key("root"))
  { version, available_space, root }
}

///|
pub impl ToJson for LayoutDocument with fn to_json(self) {
  Json::object({
    "version": Json::number(self.version.to_double()),
    "available_space": available_size_to_json(self.available_space),
    "root": self.root.to_json(),
  })
}

///|
pub fn LayoutDocument::from_json(
  json : Json,
) -> LayoutDocument raise JsonDecodeError {
  @json.from_json(json)
}

///|
fn point_to_json(point : @geometry.Point[Double]) -> Json {
  Json::object({ "x": Json::number(point.x), "y": Json::number(point.y) })
}

///|
fn size_to_json(size : @geometry.Size[Double]) -> Json {
  Json::object({
    "width": Json::number(size.width),
    "height": Json::number(size.height),
  })
}

///|
fn rect_to_json(rect : @geometry.Rect[Double]) -> Json {
  Json::object({
    "left": Json::number(rect.left),
    "right": Json::number(rect.right),
    "top": Json::number(rect.top),
    "bottom": Json::number(rect.bottom),
  })
}

///|
fn layout_to_json(layout : @tree.Layout) -> Json {
  Json::object({
    "order": Json::number(layout.order.to_double()),
    "location": point_to_json(layout.location),
    "size": size_to_json(layout.size),
    "content_size": size_to_json(layout.content_size),
    "scrollbar_size": size_to_json(layout.scrollbar_size),
    "border": rect_to_json(layout.border),
    "padding": rect_to_json(layout.padding),
  })
}

///|
fn optional_string_to_json(value : String?) -> Json {
  match value {
    Some(value) => Json::string(value)
    None => Json::null()
  }
}

///|
pub impl ToJson for LayoutResultNode with fn to_json(self) {
  Json::object({
    "id": Json::string(self.id),
    "label": Json::string(self.label),
    "parent_id": optional_string_to_json(self.parent_id),
    "depth": Json::number(self.depth.to_double()),
    "layout": layout_to_json(self.layout),
  })
}

///|
pub impl ToJson for LayoutResult with fn to_json(self) {
  Json::object({
    "root_id": Json::string(self.root_id),
    "nodes": Json::array(self.nodes.map(fn(node) { node.to_json() })),
  })
}

///|
pub fn LayoutResult::to_json(self : LayoutResult) -> Json {
  (self : &ToJson).to_json()
}

///|
fn build_document_node(
  tree : @tree.ChicleTree[Unit],
  node : LayoutNode,
  parent_id : String?,
  depth : Int,
  seen : Map[String, Bool],
  built : Array[BuiltNode],
) -> @tree.NodeId raise {
  if node.id == "" {
    raise EmptyNodeId
  }
  if seen.contains(node.id) {
    raise DuplicateNodeId(node.id)
  }
  seen[node.id] = true
  let tree_id = tree.new_leaf(node.style)
  built.push({ id: node.id, label: node.label, parent_id, depth, tree_id })
  let child_ids : Array[@tree.NodeId] = []
  for child in node.children {
    child_ids.push(
      build_document_node(tree, child, Some(node.id), depth + 1, seen, built),
    )
  }
  tree.set_children(tree_id, child_ids)
  tree_id
}

///|
pub fn compute_layout_document(document : LayoutDocument) -> LayoutResult raise {
  let tree : @tree.ChicleTree[Unit] = ChicleTree()
  let seen : Map[String, Bool] = Map([])
  let built : Array[BuiltNode] = []
  let root_tree_id = build_document_node(
    tree,
    document.root,
    None,
    0,
    seen,
    built,
  )
  tree.compute_layout(root_tree_id, document.available_space)
  let nodes : Array[LayoutResultNode] = []
  for node in built {
    nodes.push({
      id: node.id,
      label: node.label,
      parent_id: node.parent_id,
      depth: node.depth,
      layout: tree.layout(node.tree_id),
    })
  }
  { root_id: document.root.id, nodes }
}

///|
fn response_error(kind : String, message : String) -> String {
  Json::object({
    "ok": Json::boolean(false),
    "error": Json::object({
      "kind": Json::string(kind),
      "message": Json::string(message),
    }),
  }).stringify()
}

///|
pub fn compute_layout_json(input : String) -> String {
  if !@json.valid(input) {
    return response_error("parse", "Invalid JSON")
  }
  try {
    let document = LayoutDocument::from_json(@json.parse(input))
    let result = compute_layout_document(document)
    Json::object({ "ok": Json::boolean(true), "result": result.to_json() }).stringify()
  } catch {
    @json.JsonDecodeError((path, message)) =>
      response_error("input", "\{path.to_string()}: \{message}")
    EmptyNodeId => response_error("input", "Node ids must not be empty")
    DuplicateNodeId(id) => response_error("input", "Duplicate node id: \{id}")
    _ => response_error("layout", "Layout computation failed")
  }
}
