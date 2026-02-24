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
fn resolve_dimension(d : Dimension, available : AvailableSpace) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) =>
      match available {
        AvailDefinite(v) => v * p
        AvailMinContent => 0.0
        AvailMaxContent => 0.0
      }
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_dimension(max, available)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(_) => 0.0
    DimRepeat(_, _) => 0.0
  }
}

///|
fn max_double(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

///|
fn min_double(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

///|
fn resolve_optional_dimension(
  d : Dimension,
  available : AvailableSpace,
) -> Double? {
  match d {
    DimAuto => None
    DimLength(v) => Some(v)
    DimPercent(p) =>
      match available {
        AvailDefinite(v) => Some(v * p)
        _ => None
      }
    DimFr(_) => None
    DimMinMax(_, max) => resolve_optional_dimension(max, available)
    DimMinContent => None
    DimMaxContent => None
    DimFitContent(_) => None
    DimRepeat(_, _) => None
  }
}

///|
fn clamp_dimension(
  value : Double,
  min_size : Dimension,
  max_size : Dimension,
  available : AvailableSpace,
) -> Double {
  let min_v = resolve_optional_dimension(min_size, available)
  let max_v0 = resolve_optional_dimension(max_size, available)
  let max_v = match (min_v, max_v0) {
    (Some(min_v), Some(max_v)) =>
      if max_v < min_v {
        Some(min_v)
      } else {
        Some(max_v)
      }
    _ => max_v0
  }
  let v0 = match min_v {
    Some(min_v) => max_double(value, min_v)
    None => value
  }
  match max_v {
    Some(max_v) => if v0 > max_v { max_v } else { v0 }
    None => v0
  }
}

///|
fn resolve_dimension_width_basis(d : Dimension, basis_width : Double) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) => basis_width * p
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_dimension_width_basis(max, basis_width)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(_) => 0.0
    DimRepeat(_, _) => 0.0
  }
}

///|
fn resolve_rect_width_basis(
  rect : Rect[Dimension],
  available : Size[AvailableSpace],
) -> Rect[Double] {
  let basis_width = match available.width {
    AvailDefinite(v) => v
    _ => 0.0
  }
  Rect::new(
    left=resolve_dimension_width_basis(rect.left, basis_width),
    right=resolve_dimension_width_basis(rect.right, basis_width),
    top=resolve_dimension_width_basis(rect.top, basis_width),
    bottom=resolve_dimension_width_basis(rect.bottom, basis_width),
  )
}

///|
fn abs_double(v : Double) -> Double {
  if v < 0.0 {
    -v
  } else {
    v
  }
}

///|
fn margin_collapse_state_add_margin(
  state : (Double, Double),
  margin : Double,
) -> (Double, Double) {
  let mut max_pos = state.0
  let mut min_neg = state.1
  if margin > 0.0 {
    if margin > max_pos {
      max_pos = margin
    } else {
      ()
    }
  } else if margin < 0.0 {
    if margin < min_neg {
      min_neg = margin
    } else {
      ()
    }
  } else {
    ()
  }
  (max_pos, min_neg)
}

///|
fn margin_collapse_state_from(margin : Double) -> (Double, Double) {
  margin_collapse_state_add_margin((0.0, 0.0), margin)
}

///|
fn margin_collapse_state_value(state : (Double, Double)) -> Double {
  state.0 + state.1
}

///|
fn[C] set_effective_margin_states(
  tree : TaffyTree[C],
  node_id : NodeId,
  top_state : (Double, Double),
  bottom_state : (Double, Double),
) -> Unit {
  tree.nodes[node_id].effective_margin_top_max_pos = top_state.0
  tree.nodes[node_id].effective_margin_top_min_neg = top_state.1
  tree.nodes[node_id].effective_margin_bottom_max_pos = bottom_state.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = bottom_state.1
  tree.nodes[node_id].effective_margin_top = margin_collapse_state_value(
    top_state,
  )
  tree.nodes[node_id].effective_margin_bottom = margin_collapse_state_value(
    bottom_state,
  )
}

///|
fn double_approx_equal(a : Double, b : Double) -> Bool {
  abs_double(a - b) <= 0.000001
}

///|
fn optional_double_equal(a : Double?, b : Double?) -> Bool {
  match (a, b) {
    (None, None) => true
    (Some(x), Some(y)) => double_approx_equal(x, y)
    _ => false
  }
}

///|
fn available_space_equal(a : AvailableSpace, b : AvailableSpace) -> Bool {
  match (a, b) {
    (AvailDefinite(x), AvailDefinite(y)) => double_approx_equal(x, y)
    (AvailMinContent, AvailMinContent) => true
    (AvailMaxContent, AvailMaxContent) => true
    _ => false
  }
}

///|
fn known_dimensions_equal(a : Size[Double?], b : Size[Double?]) -> Bool {
  optional_double_equal(a.width, b.width) &&
  optional_double_equal(a.height, b.height)
}

///|
fn available_size_equal(
  a : Size[AvailableSpace],
  b : Size[AvailableSpace],
) -> Bool {
  available_space_equal(a.width, b.width) &&
  available_space_equal(a.height, b.height)
}

///|
fn point_equal(a : Point[Double], b : Point[Double]) -> Bool {
  double_approx_equal(a.x, b.x) && double_approx_equal(a.y, b.y)
}

///|
fn find_leaf_measure_cache(
  cache : Array[LeafMeasureCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
) -> Size[Double]? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) {
      return Some(entry.measured)
    }
  }
  None
}

///|
fn find_node_layout_cache(
  cache : Array[NodeLayoutCacheEntry],
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  is_layout_root : Bool,
) -> NodeLayoutCacheEntry? {
  for entry in cache {
    if known_dimensions_equal(entry.known_dimensions, known_dimensions) &&
      available_size_equal(entry.available_space, available_space) &&
      point_equal(entry.absolute_origin, absolute_origin) &&
      entry.is_layout_root == is_layout_root {
      return Some(entry)
    }
  }
  None
}

///|
fn resolve_track_dimension(d : Dimension, available : Double) -> Double {
  match d {
    DimAuto => 0.0
    DimLength(v) => v
    DimPercent(p) => available * p
    DimFr(_) => 0.0
    DimMinMax(_, max) => resolve_track_dimension(max, available)
    DimMinContent => 0.0
    DimMaxContent => 0.0
    DimFitContent(limit) => resolve_track_dimension(limit, available)
    DimRepeat(_, _) => 0.0
  }
}

///|
fn is_near_int(v : Double) -> Bool {
  abs_double(v - v.floor()) < 0.000001
}

///|

///|
fn compute_grid_track_sizes_with_contributions(
  tracks : Array[Dimension],
  available : Double,
  gap : Double,
  min_contrib : Array[Double],
  max_contrib : Array[Double],
  expand_to_fill : Bool,
) -> Array[Double] {
  let count = tracks.length()
  let sizes : Array[Double] = Array::make(count, 0.0)
  let min_sizes : Array[Double] = Array::make(count, 0.0)
  let fr_weights : Array[Double] = Array::make(count, 0.0)
  let is_auto : Array[Bool] = Array::make(count, false)
  let max_limits : Array[Double] = Array::make(count, 0.0)
  let inf = 1.0e30
  fn clamp_minmax(v : Double, lo : Double, hi : Double) -> Double {
    let v = if v < lo { lo } else { v }
    if v > hi {
      hi
    } else {
      v
    }
  }

  fn min_function_value(
    d : Dimension,
    available : Double,
    min_c : Double,
    max_c : Double,
  ) -> Double {
    match d {
      DimAuto => 0.0
      DimMinContent => min_c
      DimMaxContent => max_c
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let max_limited = if max_c < lim { max_c } else { lim }
        if max_limited < min_c {
          min_c
        } else {
          max_limited
        }
      }
      DimFr(_) => 0.0
      DimRepeat(_, _) => 0.0
      _ => {
        let v = resolve_track_dimension(d, available)
        if v > 0.0 {
          v
        } else {
          0.0
        }
      }
    }
  }

  fn max_function_value_and_limit(
    d : Dimension,
    available : Double,
    min_c : Double,
    max_c : Double,
    inf : Double,
  ) -> (Double, Double, Double) {
    match d {
      DimAuto => (max_c, inf, 0.0)
      DimMinContent => (min_c, inf, 0.0)
      DimMaxContent => (max_c, inf, 0.0)
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        let preferred = if preferred < min_c { min_c } else { preferred }
        (preferred, preferred, 0.0)
      }
      DimFr(w) => (0.0, inf, if w > 0.0 { w } else { 0.0 })
      DimRepeat(_, _) => (0.0, inf, 0.0)
      _ => {
        let v = resolve_track_dimension(d, available)
        let v = if v > 0.0 { v } else { 0.0 }
        (v, v, 0.0)
      }
    }
  }

  for i in 0..<count {
    let min_c = if i < min_contrib.length() { min_contrib[i] } else { 0.0 }
    let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
    match tracks[i] {
      DimAuto => {
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimMinContent => {
        min_sizes[i] = min_c
        sizes[i] = min_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimMaxContent => {
        min_sizes[i] = max_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
      DimFitContent(limit) => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        let preferred = if preferred < min_c { min_c } else { preferred }
        min_sizes[i] = min_c
        sizes[i] = preferred
        max_limits[i] = preferred
        is_auto[i] = true
      }
      DimLength(v) => {
        sizes[i] = v
        min_sizes[i] = v
        max_limits[i] = v
      }
      DimPercent(p) => {
        let v = available * p
        sizes[i] = v
        min_sizes[i] = v
        max_limits[i] = v
      }
      DimFr(w) => {
        fr_weights[i] = if w > 0.0 { w } else { 0.0 }
        let base = if w > 0.0 { min_c } else { max_c }
        sizes[i] = base
        min_sizes[i] = base
        max_limits[i] = inf
      }
      DimMinMax(min_d, max_d) => {
        let min_v = min_function_value(min_d, available, min_c, max_c)
        let max_r = max_function_value_and_limit(
          max_d, available, min_c, max_c, inf,
        )
        let max_v = max_r.0
        let max_lim = max_r.1
        let fr_w = max_r.2
        min_sizes[i] = min_v
        if fr_w > 0.0 {
          fr_weights[i] = fr_w
          sizes[i] = min_v
          max_limits[i] = inf
        } else {
          let preferred = if max_v < min_v { min_v } else { max_v }
          sizes[i] = preferred
          max_limits[i] = if max_lim < min_v { min_v } else { max_lim }
          is_auto[i] = match max_d {
            DimAuto | DimMinContent | DimMaxContent | DimFitContent(_) => true
            _ => false
          }
        }
      }
      DimRepeat(_, _) => {
        // Expanded earlier; treat as auto when encountered.
        min_sizes[i] = min_c
        sizes[i] = max_c
        max_limits[i] = inf
        is_auto[i] = true
      }
    }
  }

  // Intrinsic sizing for flexible tracks: derive a flex fraction from content contributions.
  // This matches taffy 0.5 behavior for `fr` tracks under indefinite available space.
  if not(expand_to_fill) {
    let mut flex_fraction = 0.0
    for i in 0..<count {
      let w = fr_weights[i]
      if w > 0.0 {
        let max_c = if i < max_contrib.length() { max_contrib[i] } else { 0.0 }
        let ratio = max_c / w
        if ratio > flex_fraction {
          flex_fraction = ratio
        }
      }
    }
    if flex_fraction > 0.0 {
      for i in 0..<count {
        let w = fr_weights[i]
        if w > 0.0 {
          let flex_size = flex_fraction * w
          sizes[i] = if flex_size < min_sizes[i] {
            min_sizes[i]
          } else {
            flex_size
          }
          min_sizes[i] = if i < min_contrib.length() {
            min_contrib[i]
          } else {
            0.0
          }
          max_limits[i] = inf
          is_auto[i] = true
        }
      }
    }
  }

  // Shrink tracks down to their min-content contributions if the sum of preferred sizes overflows.
  let mut used = 0.0
  for s in sizes {
    used = used + s
  }
  if count > 1 {
    used = used + gap * (count - 1).to_double()
  }
  if used > available {
    let eps = 0.000001
    let mut over = used - available
    let mut shrinkable : Array[Int] = []
    for i in 0..<count {
      if sizes[i] > min_sizes[i] + eps {
        shrinkable.push(i)
      }
    }
    while over > eps && shrinkable.length() > 0 {
      let per = over / shrinkable.length().to_double()
      let mut shrunk = 0.0
      let next : Array[Int] = []
      for idx in shrinkable {
        let can = sizes[idx] - min_sizes[idx]
        let s = if can < per { can } else { per }
        if s > 0.0 {
          sizes[idx] = sizes[idx] - s
          shrunk = shrunk + s
        }
        if sizes[idx] > min_sizes[idx] + eps {
          next.push(idx)
        }
      }
      if shrunk <= 0.0 {
        break
      }
      over = over - shrunk
      shrinkable = next
    }
  }

  // Distribute any remaining free space (only when the grid container has a definite size).
  used = 0.0
  for s in sizes {
    used = used + s
  }
  if count > 1 {
    used = used + gap * (count - 1).to_double()
  }
  let free = available - used
  if expand_to_fill && free > 0.0 {
    let mut sum_fr = 0.0
    for w in fr_weights {
      sum_fr = sum_fr + w
    }
    if sum_fr > 0.0 {
      let mut fixed_used = 0.0
      for i in 0..<count {
        if fr_weights[i] <= 0.0 {
          fixed_used = fixed_used + sizes[i]
        }
      }
      let mut remaining_for_fr = max_double(available - fixed_used, 0.0)
      let mut unresolved : Array[Int] = []
      for i in 0..<count {
        if fr_weights[i] > 0.0 {
          unresolved.push(i)
          sizes[i] = min_sizes[i]
        }
      }
      while unresolved.length() > 0 {
        let mut unresolved_sum = 0.0
        for idx in unresolved {
          unresolved_sum = unresolved_sum + fr_weights[idx]
        }
        let denom = if unresolved_sum < 1.0 { 1.0 } else { unresolved_sum }
        let flex_fraction = remaining_for_fr / denom
        let mut froze_any = false
        let next_unresolved : Array[Int] = []
        for idx in unresolved {
          let proposed = flex_fraction * fr_weights[idx]
          if proposed + 0.000001 < min_sizes[idx] {
            sizes[idx] = min_sizes[idx]
            remaining_for_fr = max_double(
              remaining_for_fr - min_sizes[idx],
              0.0,
            )
            froze_any = true
          } else {
            next_unresolved.push(idx)
          }
        }
        if not(froze_any) {
          let total_fr_space = if unresolved_sum < 1.0 {
            remaining_for_fr * unresolved_sum
          } else {
            remaining_for_fr
          }
          if is_near_int(total_fr_space) {
            let total_int = total_fr_space.floor().to_int()
            let raw_bases : Array[Int] = []
            let raw_fracs : Array[Double] = []
            let mut sum_bases = 0
            for idx in unresolved {
              let raw = flex_fraction * fr_weights[idx]
              let base = raw.floor().to_int()
              raw_bases.push(base)
              raw_fracs.push(raw - base.to_double())
              sum_bases = sum_bases + base
            }
            let mut remainder = total_int - sum_bases
            while remainder > 0 {
              let mut best_j = 0
              let mut best_frac = -1.0
              for j in 0..<raw_fracs.length() {
                if raw_fracs[j] > best_frac {
                  best_frac = raw_fracs[j]
                  best_j = j
                }
              }
              raw_bases[best_j] = raw_bases[best_j] + 1
              raw_fracs[best_j] = -1.0
              remainder = remainder - 1
            }
            for j in 0..<unresolved.length() {
              sizes[unresolved[j]] = raw_bases[j].to_double()
            }
          } else {
            for idx in unresolved {
              sizes[idx] = flex_fraction * fr_weights[idx]
            }
          }
          break
        }
        unresolved = next_unresolved
      }
    } else {
      // Distribute remaining free space evenly to auto-like tracks, respecting fit-content/minmax caps.
      let mut remaining = free
      let mut growable : Array[Int] = []
      for i in 0..<count {
        if is_auto[i] && sizes[i] + 0.000001 < max_limits[i] {
          growable.push(i)
        }
      }
      while remaining > 0.000001 && growable.length() > 0 {
        let extra = remaining / growable.length().to_double()
        let mut used_extra = 0.0
        let next : Array[Int] = []
        for idx in growable {
          let cap = max_limits[idx] - sizes[idx]
          let inc = if cap < extra { cap } else { extra }
          if inc > 0.0 {
            sizes[idx] = sizes[idx] + inc
            used_extra = used_extra + inc
          }
          if sizes[idx] + 0.000001 < max_limits[idx] {
            next.push(idx)
          }
        }
        if used_extra <= 0.0 {
          break
        }
        remaining = remaining - used_extra
        growable = next
      }
    }
  }

  // Ensure no track is below its min size.
  for i in 0..<count {
    sizes[i] = clamp_minmax(sizes[i], min_sizes[i], inf)
  }
  sizes
}

///|
fn[C] compute_node_layout_with_measure(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
  is_layout_root : Bool,
) -> Unit raise TaffyError {
  ignore(is_layout_root)
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let can_use_layout_cache = node.children.length() <= 1 &&
    double_approx_equal(absolute_origin.x, 0.0) &&
    double_approx_equal(absolute_origin.y, 0.0)
  if can_use_layout_cache {
    match
      find_node_layout_cache(
        node.node_layout_cache,
        known_dimensions,
        available_space,
        absolute_origin,
        is_layout_root,
      ) {
      Some(entry) => {
        tree.nodes[node_id].layout = Layout::{
          location: entry.location,
          size: entry.size,
        }
        tree.nodes[node_id].effective_margin_top = entry.effective_margin_top
        tree.nodes[node_id].effective_margin_bottom = entry.effective_margin_bottom
        tree.nodes[node_id].effective_margin_top_max_pos = entry.effective_margin_top_max_pos
        tree.nodes[node_id].effective_margin_top_min_neg = entry.effective_margin_top_min_neg
        tree.nodes[node_id].effective_margin_bottom_max_pos = entry.effective_margin_bottom_max_pos
        tree.nodes[node_id].effective_margin_bottom_min_neg = entry.effective_margin_bottom_min_neg
        return
      }
      None => ()
    }
  }
  match node.style.display {
    DisplayNone => compute_hidden_layout(tree, node_id, absolute_origin)
    DisplayGrid =>
      compute_grid_layout_with_measure(
        tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        is_layout_root,
      )
    DisplayBlock =>
      if node.children.length() == 0 {
        compute_leaf_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      } else {
        compute_block_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
          is_layout_root,
        )
      }
    _ =>
      if node.children.length() == 0 {
        compute_leaf_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      } else {
        compute_flex_layout_with_measure(
          tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
        )
      }
  }

  // Position::Relative: apply inset as a final offset without affecting sibling layout.
  // `display: none` nodes must remain at zero-size/zero-offset.
  if !(node.style.display is DisplayNone) {
    match node.style.position {
      PosRelative => {
        let inset = node.style.inset
        let dx = match
          resolve_optional_dimension(inset.left, available_space.width) {
          Some(v) => v
          None =>
            match
              resolve_optional_dimension(inset.right, available_space.width) {
              Some(v) => -v
              None => 0.0
            }
        }
        let dy = match
          resolve_optional_dimension(inset.top, available_space.height) {
          Some(v) => v
          None =>
            match
              resolve_optional_dimension(inset.bottom, available_space.height) {
              Some(v) => -v
              None => 0.0
            }
        }
        if dx != 0.0 || dy != 0.0 {
          offset_subtree(tree, node_id, dx, dy)
        }
      }
      PosAbsolute => ()
    }
  }
  if can_use_layout_cache {
    let layout = tree.nodes[node_id].layout
    tree.nodes[node_id].node_layout_cache.push(NodeLayoutCacheEntry::{
      known_dimensions,
      available_space,
      absolute_origin,
      is_layout_root,
      location: layout.location,
      size: layout.size,
      effective_margin_top: tree.nodes[node_id].effective_margin_top,
      effective_margin_bottom: tree.nodes[node_id].effective_margin_bottom,
      effective_margin_top_max_pos: tree.nodes[node_id].effective_margin_top_max_pos,
      effective_margin_top_min_neg: tree.nodes[node_id].effective_margin_top_min_neg,
      effective_margin_bottom_max_pos: tree.nodes[node_id].effective_margin_bottom_max_pos,
      effective_margin_bottom_min_neg: tree.nodes[node_id].effective_margin_bottom_min_neg,
    })
  }
}

///|
fn[C] compute_hidden_layout(
  tree : TaffyTree[C],
  node_id : NodeId,
  absolute_origin : Point[Double],
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::zero(),
  }
  tree.nodes[node_id].effective_margin_top = 0.0
  tree.nodes[node_id].effective_margin_bottom = 0.0
  tree.nodes[node_id].effective_margin_top_max_pos = 0.0
  tree.nodes[node_id].effective_margin_top_min_neg = 0.0
  tree.nodes[node_id].effective_margin_bottom_max_pos = 0.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = 0.0
  for child_id in node.children {
    compute_hidden_layout(tree, child_id, absolute_origin)
  }
}

///|
fn[C] offset_subtree(
  tree : TaffyTree[C],
  node_id : NodeId,
  dx : Double,
  dy : Double,
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let layout = node.layout
  tree.nodes[node_id].layout = Layout::{
    location: Point::{ x: layout.location.x + dx, y: layout.location.y + dy },
    size: layout.size,
  }
  for child_id in node.children {
    offset_subtree(tree, child_id, dx, dy)
  }
}

///|
fn[C] subtree_has_measure_context(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Bool raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  if node.context is Some(_) {
    return true
  }
  for child_id in node.children {
    if subtree_has_measure_context(tree, child_id) {
      return true
    }
  }
  false
}

///|
fn[C] compute_leaf_layout_with_measure(
  tree : TaffyTree[C],
  node_id : NodeId,
  known_dimensions : Size[Double?],
  available_space : Size[AvailableSpace],
  absolute_origin : Point[Double],
  measure_function : (Size[Double?], Size[AvailableSpace], NodeId, C?, Style) -> Size[
    Double,
  ],
) -> Unit raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  // CSS compatibility: vertical padding/border percentages are resolved against the width.
  let resolved_padding = resolve_rect_width_basis(
    node.style.padding,
    available_space,
  )
  let resolved_border = resolve_rect_width_basis(
    node.style.border,
    available_space,
  )
  let scrollbar_w = node.style.scrollbar_width
  let scrollbar_x = match node.style.overflow.x {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let scrollbar_y = match node.style.overflow.y {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let horiz_non_scroll_inset = resolved_padding.left +
    resolved_padding.right +
    resolved_border.left +
    resolved_border.right
  let vert_non_scroll_inset = resolved_padding.top +
    resolved_padding.bottom +
    resolved_border.top +
    resolved_border.bottom
  let horiz_inset = horiz_non_scroll_inset + scrollbar_y
  let vert_inset = vert_non_scroll_inset + scrollbar_x
  let mut specified_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let mut specified_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let known_width = known_dimensions.width
  let known_height = known_dimensions.height

  // aspect-ratio: apply to the node's preferred size (not to known_dimensions).
  match node.style.aspect_ratio {
    Some(ratio) =>
      if ratio > 0.0 {
        match (specified_width, specified_height) {
          (Some(w), None) => specified_height = Some((w / ratio).round())
          (None, Some(h)) => specified_width = Some((h * ratio).round())
          _ => ()
        }
      }
    None => ()
  }
  let mut measure_known_dimensions = Size::new(
    width=match known_width {
      Some(w) => Some(w)
      None => specified_width
    },
    height=match known_height {
      Some(h) => Some(h)
      None => specified_height
    },
  )
  let resolved_max_width = resolve_optional_dimension(
    node.style.max_size.width,
    available_space.width,
  )
  let resolved_max_height = resolve_optional_dimension(
    node.style.max_size.height,
    available_space.height,
  )
  fn clamp_opt_to_max(v : Double?, max_v : Double?) -> Double? {
    match (v, max_v) {
      (Some(v0), Some(max0)) => Some(if v0 > max0 { max0 } else { v0 })
      _ => v
    }
  }
  measure_known_dimensions = Size::new(
    width=clamp_opt_to_max(measure_known_dimensions.width, resolved_max_width),
    height=clamp_opt_to_max(
      measure_known_dimensions.height,
      resolved_max_height,
    ),
  )
  let measure_available_space = Size::new(
    width=match (available_space.width, resolved_max_width) {
      (AvailDefinite(v), Some(max0)) =>
        AvailDefinite(if v > max0 { max0 } else { v })
      _ => available_space.width
    },
    height=match (available_space.height, resolved_max_height) {
      (AvailDefinite(v), Some(max0)) =>
        AvailDefinite(if v > max0 { max0 } else { v })
      _ => available_space.height
    },
  )
  let measured = match
    find_leaf_measure_cache(
      node.leaf_measure_cache,
      measure_known_dimensions,
      measure_available_space,
    ) {
    Some(v) => v
    None => {
      let m = measure_function(
        measure_known_dimensions,
        measure_available_space,
        node_id,
        node.context,
        node.style,
      )
      tree.nodes[node_id].leaf_measure_cache.push(LeafMeasureCacheEntry::{
        known_dimensions: measure_known_dimensions,
        available_space: measure_available_space,
        measured: m,
      })
      m
    }
  }
  let raw_width = match known_width {
    Some(w) => w
    None =>
      match specified_width {
        Some(w) => w
        None => max_double(measured.width + horiz_inset, horiz_inset)
      }
  }
  let raw_height = match known_height {
    Some(h) => h
    None =>
      match specified_height {
        Some(h) => h
        None => max_double(measured.height + vert_inset, vert_inset)
      }
  }
  let raw_border_box = Size::new(width=raw_width, height=raw_height)
  let mut border_box_size = Size::new(
    width=max_double(
      clamp_dimension(
        raw_border_box.width,
        node.style.min_size.width,
        node.style.max_size.width,
        available_space.width,
      ),
      horiz_non_scroll_inset,
    ),
    height=max_double(
      clamp_dimension(
        raw_border_box.height,
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      ),
      vert_non_scroll_inset,
    ),
  )
  // aspect-ratio: when width is auto and height is constrained by min/max,
  // prefer deriving the width from the clamped height.
  match node.style.aspect_ratio {
    Some(ratio) =>
      if ratio > 0.0 {
        let width_is_auto = known_width is None && specified_width is None
        let height_is_auto = known_height is None && specified_height is None
        let resolved_min_height = resolve_optional_dimension(
          node.style.min_size.height,
          available_space.height,
        )
        let resolved_max_height = resolve_optional_dimension(
          node.style.max_size.height,
          available_space.height,
        )
        let height_is_definite = known_height is Some(_) ||
          specified_height is Some(_) ||
          (match resolved_min_height {
            Some(min_h) => raw_border_box.height <= min_h
            None => false
          }) ||
          (match resolved_max_height {
            Some(max_h) => raw_border_box.height >= max_h
            None => false
          })
        if width_is_auto && height_is_definite {
          let ratio_width = max_double(
            (border_box_size.height * ratio).round(),
            horiz_inset,
          )
          border_box_size = Size::new(
            width=max_double(
              clamp_dimension(
                ratio_width,
                node.style.min_size.width,
                node.style.max_size.width,
                available_space.width,
              ),
              horiz_inset,
            ),
            height=border_box_size.height,
          )
        } else {
          ()
        }
        if height_is_auto {
          let min_height = max_double(
            (border_box_size.width / ratio).round(),
            vert_inset,
          )
          if min_height > border_box_size.height {
            border_box_size = Size::new(
              width=border_box_size.width,
              height=min_height,
            )
          } else {
            ()
          }
        } else {
          ()
        }
        border_box_size = Size::new(
          width=max_double(
            clamp_dimension(
              border_box_size.width,
              node.style.min_size.width,
              node.style.max_size.width,
              available_space.width,
            ),
            horiz_non_scroll_inset,
          ),
          height=max_double(
            clamp_dimension(
              border_box_size.height,
              node.style.min_size.height,
              node.style.max_size.height,
              available_space.height,
            ),
            vert_non_scroll_inset,
          ),
        )
      }
    None => ()
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: border_box_size,
  }
  let resolved_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  set_effective_margin_states(
    tree,
    node_id,
    margin_collapse_state_from(resolved_margin.top),
    margin_collapse_state_from(resolved_margin.bottom),
  )
}

///|
fn is_column(direction : FlexDirection) -> Bool {
  match direction {
    FlexRow => false
    FlexRowReverse => false
    FlexColumn => true
    FlexColumnReverse => true
  }
}

///|
fn get_main(size : Size[Double], is_col : Bool) -> Double {
  if is_col {
    size.height
  } else {
    size.width
  }
}

///|
fn get_cross(size : Size[Double], is_col : Bool) -> Double {
  if is_col {
    size.width
  } else {
    size.height
  }
}

///|
fn make_size_from_main_cross(
  main : Double,
  cross : Double,
  is_col : Bool,
) -> Size[Double] {
  if is_col {
    Size::new(width=cross, height=main)
  } else {
    Size::new(width=main, height=cross)
  }
}

///|
fn resolve_gap_main(
  gap : Size[Dimension],
  is_col : Bool,
  available_main : AvailableSpace,
) -> Double {
  if is_col {
    resolve_dimension(gap.height, available_main)
  } else {
    resolve_dimension(gap.width, available_main)
  }
}

///|
fn resolve_gap_cross(
  gap : Size[Dimension],
  is_col : Bool,
  available_cross : AvailableSpace,
) -> Double {
  if is_col {
    resolve_dimension(gap.width, available_cross)
  } else {
    resolve_dimension(gap.height, available_cross)
  }
}

///|
fn resolve_available_for_percent(
  is_definite : Bool,
  value : Double,
) -> AvailableSpace {
  if is_definite {
    AvailDefinite(value)
  } else {
    AvailMaxContent
  }
}

///|
fn resolve_justify_start_main(
  justify : AlignContent,
  leftover_main : Double,
  is_reverse : Bool,
) -> Double {
  match justify {
    AlignCenter => leftover_main / 2.0
    AlignStart => if is_reverse { leftover_main } else { 0.0 }
    AlignEnd => if is_reverse { 0.0 } else { leftover_main }
    AlignFlexEnd => leftover_main
    _ => 0.0
  }
}

///|
fn expand_grid_template_axis(
  template : Array[Dimension],
  content_size : Double,
  gap : Double,
) -> (Array[Dimension], Int, Bool) {
  let expanded : Array[Dimension] = []
  let mut used = 0.0
  let mut first = true
  let mut non_auto_fit_count = 0
  let mut has_auto_fit = false
  fn push_track(
    expanded : Array[Dimension],
    track : Dimension,
    content_size : Double,
    gap : Double,
    used : Double,
    first : Bool,
  ) -> (Double, Bool) {
    let mut u = used
    if not(first) {
      u = u + gap
    }
    u = u + resolve_track_dimension(track, content_size)
    expanded.push(track)
    (u, false)
  }

  for item in template {
    match item {
      DimRepeat(rep, tracks) => {
        if tracks.length() == 0 {
          continue
        }
        match rep {
          RepeatCount(n) => {
            let count = if n > 0 { n } else { 0 }
            for _i in 0..<count {
              for t in tracks {
                let r = push_track(expanded, t, content_size, gap, used, first)
                used = r.0
                first = r.1
                non_auto_fit_count = non_auto_fit_count + 1
              }
            }
          }
          RepeatAutoFill | RepeatAutoFit => {
            let is_auto_fit = rep is RepeatAutoFit
            if is_auto_fit {
              has_auto_fit = true
            }
            let mut reps = 0
            while true {
              // Try appending one full track-list.
              let mut u_try = used
              let mut first_try = first
              for t in tracks {
                if not(first_try) {
                  u_try = u_try + gap
                }
                u_try = u_try + resolve_track_dimension(t, content_size)
                first_try = false
              }
              let fits = u_try <= content_size + 0.000001
              if reps > 0 && not(fits) {
                break
              }
              // Always append at least once.
              for t in tracks {
                let r = push_track(expanded, t, content_size, gap, used, first)
                used = r.0
                first = r.1
                if not(is_auto_fit) {
                  non_auto_fit_count = non_auto_fit_count + 1
                }
              }
              reps = reps + 1
              if not(fits) {
                break
              }
            }
          }
        }
      }
      _ => {
        let r = push_track(expanded, item, content_size, gap, used, first)
        used = r.0
        first = r.1
        non_auto_fit_count = non_auto_fit_count + 1
      }
    }
  }
  (expanded, non_auto_fit_count, has_auto_fit)
}
