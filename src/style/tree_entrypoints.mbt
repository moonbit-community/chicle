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
suberror TaffyError {
  InvalidNodeId(Int)
  CycleDetected(parent~ : Int, child~ : Int)
  ChildNotFound(parent~ : Int, child~ : Int)
}

///|
pub type NodeId = Int

///|
pub struct Layout {
  location : Point[Double]
  size : Size[Double]
}

///|
pub fn Layout::zero() -> Layout {
  Layout::{ location: Point::zero(), size: Size::zero() }
}

///|
priv struct LeafMeasureCacheEntry {
  known_dimensions : Size[Double?]
  available_space : Size[AvailableSpace]
  measured : Size[Double]
}

///|
priv struct NodeLayoutCacheEntry {
  known_dimensions : Size[Double?]
  available_space : Size[AvailableSpace]
  absolute_origin : Point[Double]
  is_layout_root : Bool
  location : Point[Double]
  size : Size[Double]
  effective_margin_top : Double
  effective_margin_bottom : Double
  effective_margin_top_max_pos : Double
  effective_margin_top_min_neg : Double
  effective_margin_bottom_max_pos : Double
  effective_margin_bottom_min_neg : Double
}

///|
struct Node[C] {
  mut style : Style
  children : Array[NodeId]
  mut parent : NodeId?
  mut layout : Layout
  mut context : C?
  leaf_measure_cache : Array[LeafMeasureCacheEntry]
  node_layout_cache : Array[NodeLayoutCacheEntry]
  mut effective_margin_top : Double
  mut effective_margin_bottom : Double
  mut effective_margin_top_max_pos : Double
  mut effective_margin_top_min_neg : Double
  mut effective_margin_bottom_max_pos : Double
  mut effective_margin_bottom_min_neg : Double
  mut alive : Bool
  mut dirty : Bool
}

///|
pub struct TaffyTree[C] {
  priv nodes : Array[Node[C]]
}

///|
pub fn[C] TaffyTree::new() -> TaffyTree[C] {
  TaffyTree::{ nodes: [] }
}

///|
pub fn[C] TaffyTree::with_capacity(_capacity : Int) -> TaffyTree[C] {
  // Array capacity is backend-dependent; keep API surface but ignore the hint for now.
  TaffyTree::new()
}

///|
pub fn[C] TaffyTree::new_leaf(self : TaffyTree[C], style : Style) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children: [],
      parent: None,
      layout: Layout::zero(),
      context: None,
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  id
}

///|
pub fn[C] TaffyTree::new_leaf_with_context(
  self : TaffyTree[C],
  style : Style,
  context : C,
) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children: [],
      parent: None,
      layout: Layout::zero(),
      context: Some(context),
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  id
}

///|
pub fn[C] TaffyTree::new_with_children(
  self : TaffyTree[C],
  style : Style,
  children : Array[NodeId],
) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([
    Node::{
      style,
      children,
      parent: None,
      layout: Layout::zero(),
      context: None,
      leaf_measure_cache: [],
      node_layout_cache: [],
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
      effective_margin_top_max_pos: 0.0,
      effective_margin_top_min_neg: 0.0,
      effective_margin_bottom_max_pos: 0.0,
      effective_margin_bottom_min_neg: 0.0,
      alive: true,
      dirty: true,
    },
  ])
  for child_id in children {
    match self.nodes.get(child_id) {
      Some(_) => {
        if not(self.nodes[child_id].alive) {
          continue
        }
        match self.nodes[child_id].parent {
          Some(old_parent) =>
            if old_parent != id {
              let old_children = self.nodes[old_parent].children
              match old_children.search_by(fn(x) { x == child_id }) {
                Some(idx) => ignore(old_children.remove(idx))
                None => ()
              }
            } else {
              ()
            }
          None => ()
        }
        self.nodes[child_id].parent = Some(id)
      }
      None => ()
    }
  }
  id
}

///|
pub fn[C] TaffyTree::add_child(
  self : TaffyTree[C],
  parent : NodeId,
  child : NodeId,
) -> Unit raise TaffyError {
  match self.nodes.get(parent) {
    Some(_) => ()
    None => raise InvalidNodeId(parent)
  }
  match self.nodes.get(child) {
    Some(_) => ()
    None => raise InvalidNodeId(child)
  }
  if not(self.nodes[parent].alive) {
    raise InvalidNodeId(parent)
  }
  if not(self.nodes[child].alive) {
    raise InvalidNodeId(child)
  }
  if parent == child {
    raise CycleDetected(parent~, child~)
  }
  // Reject cycles: `child` cannot be an ancestor of `parent`.
  let mut cur = self.nodes[parent].parent
  while true {
    match cur {
      None => break
      Some(p) =>
        if p == child {
          raise CycleDetected(parent~, child~)
        } else {
          cur = self.nodes[p].parent
        }
    }
  }
  // Detach child from its old parent, if any.
  match self.nodes[child].parent {
    Some(old_parent) =>
      if old_parent != parent {
        let old_children = self.nodes[old_parent].children
        match old_children.search_by(fn(x) { x == child }) {
          Some(idx) => ignore(old_children.remove(idx))
          None => ()
        }
      } else {
        ()
      }
    None => ()
  }
  self.nodes[child].parent = Some(parent)
  self.nodes[parent].children.push(child)
  self.mark_dirty(parent)
}

///|
pub fn[C] TaffyTree::set_children(
  self : TaffyTree[C],
  parent : NodeId,
  children : Array[NodeId],
) -> Unit raise TaffyError {
  match self.nodes.get(parent) {
    Some(_) => ()
    None => raise InvalidNodeId(parent)
  }
  if not(self.nodes[parent].alive) {
    raise InvalidNodeId(parent)
  }
  // Validate nodes and reject cycles.
  for child_id in children {
    match self.nodes.get(child_id) {
      Some(_) => ()
      None => raise InvalidNodeId(child_id)
    }
    if not(self.nodes[child_id].alive) {
      raise InvalidNodeId(child_id)
    }
    if child_id == parent {
      raise CycleDetected(parent~, child=child_id)
    }
    let mut cur = Some(parent)
    while true {
      match cur {
        None => break
        Some(p) =>
          if p == child_id {
            raise CycleDetected(parent~, child=child_id)
          } else {
            cur = self.nodes[p].parent
          }
      }
    }
  }
  // Detach current children.
  let old_children = self.nodes[parent].children
  for child_id in old_children {
    self.nodes[child_id].parent = None
  }
  old_children.clear()
  // Attach new children (detaching from any previous parents).
  for child_id in children {
    match self.nodes[child_id].parent {
      Some(old_parent) =>
        if old_parent != parent {
          let old_siblings = self.nodes[old_parent].children
          match old_siblings.search_by(fn(x) { x == child_id }) {
            Some(idx) => ignore(old_siblings.remove(idx))
            None => ()
          }
        } else {
          ()
        }
      None => ()
    }
    self.nodes[child_id].parent = Some(parent)
    old_children.push(child_id)
  }
  self.mark_dirty(parent)
}

///|
pub fn[C] TaffyTree::remove_child(
  self : TaffyTree[C],
  parent : NodeId,
  child : NodeId,
) -> NodeId raise TaffyError {
  match self.nodes.get(parent) {
    Some(_) => ()
    None => raise InvalidNodeId(parent)
  }
  match self.nodes.get(child) {
    Some(_) => ()
    None => raise InvalidNodeId(child)
  }
  if not(self.nodes[parent].alive) {
    raise InvalidNodeId(parent)
  }
  if not(self.nodes[child].alive) {
    raise InvalidNodeId(child)
  }
  let siblings = self.nodes[parent].children
  match siblings.search_by(fn(x) { x == child }) {
    Some(idx) => {
      ignore(siblings.remove(idx))
      self.nodes[child].parent = None
      self.mark_dirty(parent)
      child
    }
    None => raise ChildNotFound(parent~, child~)
  }
}

///|
pub fn[C] TaffyTree::mark_dirty(
  self : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if not(self.nodes[node].alive) {
    raise InvalidNodeId(node)
  }
  let mut cur : NodeId? = Some(node)
  while true {
    match cur {
      None => break
      Some(id) => {
        self.nodes[id].dirty = true
        cur = self.nodes[id].parent
      }
    }
  }
}

///|
pub fn[C] TaffyTree::dirty(
  self : TaffyTree[C],
  node : NodeId,
) -> Bool raise TaffyError {
  match self.nodes.get(node) {
    Some(_) =>
      if self.nodes[node].alive {
        self.nodes[node].dirty
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::remove(
  self : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if not(self.nodes[node].alive) {
    raise InvalidNodeId(node)
  }
  // Detach from parent.
  let old_parent = self.nodes[node].parent
  match old_parent {
    Some(parent_id) => {
      let siblings = self.nodes[parent_id].children
      match siblings.search_by(fn(x) { x == node }) {
        Some(idx) => ignore(siblings.remove(idx))
        None => ()
      }
      self.nodes[node].parent = None
    }
    None => ()
  }
  // Orphan children.
  let kids = self.nodes[node].children
  for child_id in kids {
    self.nodes[child_id].parent = None
  }
  kids.clear()
  self.nodes[node].alive = false
  match old_parent {
    Some(p) => self.mark_dirty(p)
    None => ()
  }
}

///|
pub fn[C] TaffyTree::remove_subtree(
  self : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if not(self.nodes[node].alive) {
    raise InvalidNodeId(node)
  }
  // Detach root of subtree from its parent.
  let old_parent = self.nodes[node].parent
  match old_parent {
    Some(parent_id) => {
      let siblings = self.nodes[parent_id].children
      match siblings.search_by(fn(x) { x == node }) {
        Some(idx) => ignore(siblings.remove(idx))
        None => ()
      }
      self.nodes[node].parent = None
    }
    None => ()
  }
  let stack : Array[NodeId] = [node]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if not(self.nodes[cur].alive) {
          continue
        }
        let kids = self.nodes[cur].children
        for child_id in kids {
          stack.push(child_id)
        }
        kids.clear()
        self.nodes[cur].parent = None
        self.nodes[cur].context = None
        self.nodes[cur].leaf_measure_cache.clear()
        self.nodes[cur].node_layout_cache.clear()
        self.nodes[cur].layout = Layout::zero()
        self.nodes[cur].alive = false
      }
    }
  }
  match old_parent {
    Some(p) => self.mark_dirty(p)
    None => ()
  }
}

///|
pub fn[C] TaffyTree::set_node_context(
  self : TaffyTree[C],
  node : NodeId,
  context : C,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) =>
      if self.nodes[node].alive {
        self.nodes[node].context = Some(context)
        self.nodes[node].leaf_measure_cache.clear()
        self.nodes[node].node_layout_cache.clear()
        self.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::clear_node_context(
  self : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) =>
      if self.nodes[node].alive {
        self.nodes[node].context = None
        self.nodes[node].leaf_measure_cache.clear()
        self.nodes[node].node_layout_cache.clear()
        self.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::node_context(
  self : TaffyTree[C],
  node : NodeId,
) -> C? raise TaffyError {
  let node_ref = match self.nodes.get(node) {
    Some(n) => n
    None => raise InvalidNodeId(node)
  }
  if not(node_ref.alive) {
    raise InvalidNodeId(node)
  }
  node_ref.context
}

///|
pub fn[C] TaffyTree::layout(
  self : TaffyTree[C],
  node : NodeId,
) -> Layout raise TaffyError {
  let node_ref = match self.nodes.get(node) {
    Some(n) => n
    None => raise InvalidNodeId(node)
  }
  if not(node_ref.alive) {
    raise InvalidNodeId(node)
  }
  let layout = node_ref.layout
  match node_ref.parent {
    None => layout
    Some(parent_id) => {
      let parent = match self.nodes.get(parent_id) {
        Some(p) => p
        None => raise InvalidNodeId(parent_id)
      }
      if not(parent.alive) {
        raise InvalidNodeId(parent_id)
      }
      let parent_layout = parent.layout
      Layout::{
        location: Point::new(
          x=layout.location.x - parent_layout.location.x,
          y=layout.location.y - parent_layout.location.y,
        ),
        size: layout.size,
      }
    }
  }
}

///|
pub fn[C] TaffyTree::set_style(
  self : TaffyTree[C],
  node : NodeId,
  style : Style,
) -> Unit raise TaffyError {
  match self.nodes.get(node) {
    Some(_) =>
      if self.nodes[node].alive {
        self.nodes[node].style = style
        self.nodes[node].leaf_measure_cache.clear()
        self.nodes[node].node_layout_cache.clear()
        self.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::compute_layout(
  self : TaffyTree[C],
  root : NodeId,
  available_space : Size[AvailableSpace],
) -> Unit raise TaffyError {
  fn default_measure(
    _known_dimensions : Size[Double?],
    _available_space : Size[AvailableSpace],
    _node_id : NodeId,
    _context : C?,
    _style : Style,
  ) -> Size[Double] {
    Size::zero()
  }

  self.compute_layout_with_measure(root, available_space, default_measure)
}

///|
pub fn[C] TaffyTree::compute_layout_with_measure(
  self : TaffyTree[C],
  root : NodeId,
  available_space : Size[AvailableSpace],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Unit raise TaffyError {
  match self.nodes.get(root) {
    Some(_) =>
      if not(self.nodes[root].alive) {
        raise InvalidNodeId(root)
      } else {
        ()
      }
    None => raise InvalidNodeId(root)
  }
  for i in 0..<self.nodes.length() {
    self.nodes[i].leaf_measure_cache.clear()
    self.nodes[i].node_layout_cache.clear()
  }
  compute_node_layout_with_measure(
    self,
    root,
    Size::new(width=None, height=None),
    available_space,
    Point::zero(),
    measure_function,
    true,
  )
  let stack : Array[NodeId] = [root]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if not(self.nodes[cur].alive) {
          continue
        }
        let layout = self.nodes[cur].layout
        let rounded_left = layout.location.x.round()
        let rounded_top = layout.location.y.round()
        let rounded_right = (layout.location.x + layout.size.width).round()
        let rounded_bottom = (layout.location.y + layout.size.height).round()
        self.nodes[cur].layout = Layout::{
          location: Point::new(x=rounded_left, y=rounded_top),
          size: Size::new(
            width=max_double(rounded_right - rounded_left, 0.0),
            height=max_double(rounded_bottom - rounded_top, 0.0),
          ),
        }
        self.nodes[cur].dirty = false
        for child_id in self.nodes[cur].children {
          stack.push(child_id)
        }
      }
    }
  }
}

///|
