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
struct Node[C] {
  mut style : Style
  children : Array[NodeId]
  mut parent : NodeId?
  mut layout : Layout
  mut context : C?
  mut effective_margin_top : Double
  mut effective_margin_bottom : Double
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
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
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
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
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
      effective_margin_top: 0.0,
      effective_margin_bottom: 0.0,
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
        self.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
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
      DimAuto => min_c
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
        sizes[i] = 0.0
        min_sizes[i] = 0.0
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
          sizes[i] = flex_fraction * w
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
      let denom = if sum_fr < 1.0 { 1.0 } else { sum_fr }
      let flex_fraction = free / denom
      let total_fr_space = if sum_fr < 1.0 { free * sum_fr } else { free }
      if is_near_int(total_fr_space) {
        let total_int = total_fr_space.floor().to_int()
        let fr_indices : Array[Int] = []
        let fr_ints : Array[Int] = []
        let fr_fracs : Array[Double] = []
        let mut sum_ints = 0
        for i in 0..<count {
          if fr_weights[i] > 0.0 {
            let raw = flex_fraction * fr_weights[i]
            let base = raw.floor().to_int()
            fr_indices.push(i)
            fr_ints.push(base)
            fr_fracs.push(raw - base.to_double())
            sum_ints = sum_ints + base
          }
        }
        let mut remainder = total_int - sum_ints
        while remainder > 0 {
          let mut best_j = 0
          let mut best_frac = -1.0
          for j in 0..<fr_fracs.length() {
            let f = fr_fracs[j]
            if f > best_frac {
              best_frac = f
              best_j = j
            }
          }
          fr_ints[best_j] = fr_ints[best_j] + 1
          fr_fracs[best_j] = -1.0
          remainder = remainder - 1
        }
        for j in 0..<fr_indices.length() {
          let idx = fr_indices[j]
          sizes[idx] = sizes[idx] + fr_ints[j].to_double()
        }
      } else {
        for i in 0..<count {
          if fr_weights[i] > 0.0 {
            sizes[i] = sizes[i] + flex_fraction * fr_weights[i]
          }
        }
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
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  match node.style.display {
    DisplayNone => compute_hidden_layout(tree, node_id, absolute_origin)
    DisplayGrid =>
      compute_grid_layout_with_measure(
        tree, node_id, known_dimensions, available_space, absolute_origin, measure_function,
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
  match node.style.position {
    PosRelative => {
      let inset = node.style.inset
      let dx = match
        resolve_optional_dimension(inset.left, available_space.width) {
        Some(v) => v
        None =>
          match resolve_optional_dimension(inset.right, available_space.width) {
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
  let horiz_inset = resolved_padding.left +
    resolved_padding.right +
    resolved_border.left +
    resolved_border.right
  let vert_inset = resolved_padding.top +
    resolved_padding.bottom +
    resolved_border.top +
    resolved_border.bottom
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
  let measure_known_dimensions = Size::new(
    width=match known_width {
      Some(w) => Some(w)
      None => specified_width
    },
    height=match known_height {
      Some(h) => Some(h)
      None => specified_height
    },
  )
  let measured = measure_function(
    measure_known_dimensions,
    available_space,
    node_id,
    node.context,
    node.style,
  )
  let raw_width = match known_width {
    Some(w) => max_double(w, horiz_inset)
    None =>
      match specified_width {
        Some(w) => max_double(w, horiz_inset)
        None => max_double(measured.width + horiz_inset, horiz_inset)
      }
  }
  let raw_height = match known_height {
    Some(h) => max_double(h, vert_inset)
    None =>
      match specified_height {
        Some(h) => max_double(h, vert_inset)
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
      horiz_inset,
    ),
    height=max_double(
      clamp_dimension(
        raw_border_box.height,
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      ),
      vert_inset,
    ),
  )
  // aspect-ratio: when width is auto and height is constrained by min/max,
  // prefer deriving the width from the clamped height.
  match node.style.aspect_ratio {
    Some(ratio) =>
      if ratio > 0.0 {
        let width_is_auto = known_width is None && specified_width is None
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
  tree.nodes[node_id].effective_margin_top = resolved_margin.top
  tree.nodes[node_id].effective_margin_bottom = resolved_margin.bottom
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

///|
fn[C] compute_grid_layout_with_measure(
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
  fn origin_zero_line(value : Int, explicit_track_count : Int) -> Int? {
    if value == 0 {
      None
    } else if value > 0 {
      Some(value - 1)
    } else {
      // Negative indices count back from the end of the explicit grid.
      let explicit_line_count = explicit_track_count + 1
      Some(value + explicit_line_count)
    }
  }

  fn merged_placement_line(
    placement : Line[GridPlacement],
    legacy_start : Int?,
  ) -> Line[GridPlacement] {
    match legacy_start {
      Some(v) => Line::new(start=PlaceLine(v), end=placement.end)
      None => placement
    }
  }

  fn placement_span_value(span : Int) -> Int {
    if span > 0 {
      span
    } else {
      1
    }
  }

  fn axis_resolve_start_line_and_span(
    placement : Line[GridPlacement],
    explicit_track_count : Int,
  ) -> (Int?, Int) {
    let start_line = match placement.start {
      PlaceLine(v) => origin_zero_line(v, explicit_track_count)
      _ => None
    }
    let end_line = match placement.end {
      PlaceLine(v) => origin_zero_line(v, explicit_track_count)
      _ => None
    }
    let explicit_span = match placement.start {
      PlaceSpan(s) => Some(placement_span_value(s))
      _ =>
        match placement.end {
          PlaceSpan(s) => Some(placement_span_value(s))
          _ => None
        }
    }
    match explicit_span {
      Some(span) =>
        match (start_line, end_line) {
          (Some(sl), _) => (Some(sl), span)
          (None, Some(el)) => (Some(el - span), span)
          _ => (None, span)
        }
      None =>
        match (start_line, end_line) {
          (Some(sl), Some(el)) => {
            let span = if el > sl { el - sl } else { 1 }
            (Some(sl), span)
          }
          (Some(sl), None) => (Some(sl), 1)
          (None, Some(el)) => (Some(el - 1), 1)
          _ => (None, 1)
        }
    }
  }

  fn axis_auto_track_list(auto_tracks : Array[Dimension]) -> Array[Dimension] {
    if auto_tracks.length() == 0 {
      [DimAuto]
    } else {
      auto_tracks
    }
  }

  fn negative_auto_track_at(
    auto_tracks : Array[Dimension],
    offset_from_explicit : Int,
  ) -> Dimension {
    let len = auto_tracks.length()
    if len == 0 {
      DimAuto
    } else {
      // `offset_from_explicit` is 1-based: 1 means the track adjacent to the explicit grid.
      let m = offset_from_explicit % len
      let idx = (len - m) % len
      auto_tracks[idx]
    }
  }

  let padding = resolve_rect_width_basis(node.style.padding, available_space)
  let border = resolve_rect_width_basis(node.style.border, available_space)
  let scrollbar_w = node.style.scrollbar_width
  let scrollbar_x = match node.style.overflow.x {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let scrollbar_y = match node.style.overflow.y {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  // Overflow::Scroll reserves scrollbar space inside the border box.
  // Horizontal scrollbar consumes cross (vertical) space; vertical scrollbar consumes main (horizontal) space.
  let horiz_inset = padding.left +
    padding.right +
    border.left +
    border.right +
    scrollbar_y
  let vert_inset = padding.top +
    padding.bottom +
    border.top +
    border.bottom +
    scrollbar_x
  let style_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let style_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let specified_width = match known_dimensions.width {
    Some(w) => Some(w)
    None => style_width
  }
  let specified_height = match known_dimensions.height {
    Some(h) => Some(h)
    None => style_height
  }

  // If the container size is definite, resolve track sizing against the content box.
  // Otherwise fall back to a simplified "fixed only" resolution.
  let mut content_width = 0.0
  let mut content_height = 0.0
  let mut border_box_width = 0.0
  let mut border_box_height = 0.0
  match specified_width {
    Some(w) => {
      border_box_width = clamp_dimension(
        max_double(w, horiz_inset),
        node.style.min_size.width,
        node.style.max_size.width,
        available_space.width,
      )
      content_width = max_double(border_box_width - horiz_inset, 0.0)
    }
    None => ()
  }
  match specified_height {
    Some(h) => {
      border_box_height = clamp_dimension(
        max_double(h, vert_inset),
        node.style.min_size.height,
        node.style.max_size.height,
        available_space.height,
      )
      content_height = max_double(border_box_height - vert_inset, 0.0)
    }
    None => ()
  }

  // Grid gaps: treat `gap.width` as column gap, and `gap.height` as row gap.
  // For `percent` gaps, follow CSS semantics and resolve against the container's inline content size (width).
  // If that basis is not yet known (intrinsic sizing), percent gaps are deferred and handled after sizing.
  let gap_width_percent = match node.style.gap.width {
    DimPercent(p) => Some(p)
    _ => None
  }
  let gap_height_percent = match node.style.gap.height {
    DimPercent(p) => Some(p)
    _ => None
  }
  let gap_inline_basis = match specified_width {
    Some(_) => content_width
    None =>
      match available_space.width {
        AvailDefinite(v) => max_double(v - horiz_inset, 0.0)
        _ => 0.0
      }
  }
  let mut col_gap = match gap_width_percent {
    Some(p) => gap_inline_basis * p
    None => resolve_dimension(node.style.gap.width, available_space.width)
  }
  let mut row_gap = match gap_height_percent {
    Some(p) => gap_inline_basis * p
    None => resolve_dimension(node.style.gap.height, available_space.height)
  }

  // Expand `repeat(...)` in grid templates.
  let col_expanded = expand_grid_template_axis(
    node.style.grid_template_columns,
    content_width,
    col_gap,
  )
  let row_expanded = expand_grid_template_axis(
    node.style.grid_template_rows,
    content_height,
    row_gap,
  )
  let mut explicit_col_template = col_expanded.0
  let mut explicit_row_template = row_expanded.0
  let mut non_auto_fit_col_count = col_expanded.1
  let has_auto_fit_cols = col_expanded.2
  let mut non_auto_fit_row_count = row_expanded.1
  let has_auto_fit_rows = row_expanded.2

  // If an axis has no explicit tracks, treat it as having a single implicit `auto` track.
  // This matches upstream behavior for column-only/row-only templates.
  if explicit_col_template.length() == 0 {
    explicit_col_template = [DimAuto]
    non_auto_fit_col_count = 1
  }
  if explicit_row_template.length() == 0 {
    explicit_row_template = [DimAuto]
    non_auto_fit_row_count = 1
  }
  let explicit_col_count = explicit_col_template.length()
  let explicit_row_count = explicit_row_template.length()

  // Compute implicit track counts required by definite placements (negative/positive implicit tracks).
  let mut min_col_line = 0
  let mut max_col_line = 0
  let mut min_row_line = 0
  let mut max_row_line = 0
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let col_line = merged_placement_line(
      child.style.grid_column,
      child.style.grid_column_start,
    )
    let row_line = merged_placement_line(
      child.style.grid_row,
      child.style.grid_row_start,
    )
    let col_res = axis_resolve_start_line_and_span(col_line, explicit_col_count)
    match col_res.0 {
      Some(sl) => {
        if sl < min_col_line {
          min_col_line = sl
        }
        let end = sl + col_res.1
        if end > max_col_line {
          max_col_line = end
        }
      }
      None => ()
    }
    let row_res = axis_resolve_start_line_and_span(row_line, explicit_row_count)
    match row_res.0 {
      Some(sl) => {
        if sl < min_row_line {
          min_row_line = sl
        }
        let end = sl + row_res.1
        if end > max_row_line {
          max_row_line = end
        }
      }
      None => ()
    }
  }
  let negative_cols = if min_col_line < 0 { -min_col_line } else { 0 }
  let positive_cols = if max_col_line > explicit_col_count {
    max_col_line - explicit_col_count
  } else {
    0
  }
  let negative_rows = if min_row_line < 0 { -min_row_line } else { 0 }
  let positive_rows = if max_row_line > explicit_row_count {
    max_row_line - explicit_row_count
  } else {
    0
  }

  // Build an initial implicit grid from templates + auto tracks.
  let auto_cols = axis_auto_track_list(node.style.grid_auto_columns)
  let auto_rows = axis_auto_track_list(node.style.grid_auto_rows)
  let mut col_tracks : Array[Dimension] = []
  for i in 0..<negative_cols {
    let offset = negative_cols - i
    col_tracks.push(negative_auto_track_at(auto_cols, offset))
  }
  for t in explicit_col_template {
    col_tracks.push(t)
  }
  for i in 0..<positive_cols {
    col_tracks.push(auto_cols[i % auto_cols.length()])
  }
  let mut row_tracks : Array[Dimension] = []
  for i in 0..<negative_rows {
    let offset = negative_rows - i
    row_tracks.push(negative_auto_track_at(auto_rows, offset))
  }
  for t in explicit_row_template {
    row_tracks.push(t)
  }
  for i in 0..<positive_rows {
    row_tracks.push(auto_rows[i % auto_rows.length()])
  }
  fn matrix_make(rows : Int, cols : Int) -> Array[Array[Bool]] {
    let m : Array[Array[Bool]] = []
    for _r in 0..<rows {
      m.push(Array::make(cols, false))
    }
    m
  }

  let placement_count = node.children.length()
  let placed : Array[Bool] = Array::make(placement_count, false)
  let placed_row : Array[Int] = Array::make(placement_count, 0)
  let placed_col : Array[Int] = Array::make(placement_count, 0)
  let placed_row_span : Array[Int] = Array::make(placement_count, 1)
  let placed_col_span : Array[Int] = Array::make(placement_count, 1)
  let occ = matrix_make(row_tracks.length(), col_tracks.length())
  fn ensure_cols(
    occ : Array[Array[Bool]],
    col_tracks : Array[Dimension],
    auto_cols : Array[Dimension],
    negative_cols : Int,
    explicit_cols : Int,
    target_col : Int,
  ) -> Unit {
    while col_tracks.length() <= target_col {
      let pos_existing = col_tracks.length() - negative_cols - explicit_cols
      let dim = auto_cols[pos_existing % auto_cols.length()]
      col_tracks.push(dim)
      for r in 0..<occ.length() {
        occ[r].push(false)
      }
    }
  }

  fn ensure_rows(
    occ : Array[Array[Bool]],
    row_tracks : Array[Dimension],
    auto_rows : Array[Dimension],
    negative_rows : Int,
    explicit_rows : Int,
    target_row : Int,
  ) -> Unit {
    while row_tracks.length() <= target_row {
      let pos_existing = row_tracks.length() - negative_rows - explicit_rows
      let dim = auto_rows[pos_existing % auto_rows.length()]
      row_tracks.push(dim)
      occ.push(Array::make(occ[0].length(), false))
    }
  }

  fn region_is_free(
    occ : Array[Array[Bool]],
    row : Int,
    col : Int,
    row_span : Int,
    col_span : Int,
  ) -> Bool {
    for r in row..<(row + row_span) {
      for c in col..<(col + col_span) {
        if occ[r][c] {
          return false
        }
      }
    }
    true
  }

  fn mark_placed(
    placed : Array[Bool],
    placed_row : Array[Int],
    placed_col : Array[Int],
    placed_row_span : Array[Int],
    placed_col_span : Array[Int],
    occ : Array[Array[Bool]],
    row_tracks : Array[Dimension],
    col_tracks : Array[Dimension],
    auto_rows : Array[Dimension],
    auto_cols : Array[Dimension],
    negative_rows : Int,
    negative_cols : Int,
    explicit_rows : Int,
    explicit_cols : Int,
    idx : Int,
    row : Int,
    col : Int,
    row_span : Int,
    col_span : Int,
  ) -> Unit {
    let row_end = row + row_span - 1
    let col_end = col + col_span - 1
    ensure_rows(
      occ, row_tracks, auto_rows, negative_rows, explicit_rows, row_end,
    )
    ensure_cols(
      occ, col_tracks, auto_cols, negative_cols, explicit_cols, col_end,
    )
    for r in row..<(row + row_span) {
      for c in col..<(col + col_span) {
        occ[r][c] = true
      }
    }
    placed[idx] = true
    placed_row[idx] = row
    placed_col[idx] = col
    placed_row_span[idx] = row_span
    placed_col_span[idx] = col_span
  }

  fn axis_start_index_and_span(
    placement : Line[GridPlacement],
    legacy_start : Int?,
    explicit_track_count : Int,
    negative_implicit : Int,
  ) -> (Int?, Int) {
    let merged = merged_placement_line(placement, legacy_start)
    let resolved = axis_resolve_start_line_and_span(
      merged, explicit_track_count,
    )
    let start = match resolved.0 {
      Some(sl) => Some(sl + negative_implicit)
      None => None
    }
    (start, resolved.1)
  }

  fn child_start_indexes_and_spans(
    child_style : Style,
    explicit_cols : Int,
    explicit_rows : Int,
    negative_cols : Int,
    negative_rows : Int,
  ) -> (Int?, Int, Int?, Int) {
    let col = axis_start_index_and_span(
      child_style.grid_column,
      child_style.grid_column_start,
      explicit_cols,
      negative_cols,
    )
    let row = axis_start_index_and_span(
      child_style.grid_row,
      child_style.grid_row_start,
      explicit_rows,
      negative_rows,
    )
    (row.0, row.1, col.0, col.1)
  }

  // Placement algorithm: very small subset of CSS Grid (enough for upstream implicit/auto tracks tests).
  let primary_is_col = match node.style.grid_auto_flow {
    Row | RowDense => true
    Column | ColumnDense => false
  }
  let dense = match node.style.grid_auto_flow {
    RowDense | ColumnDense => true
    _ => false
  }

  // Pass 1: both axes definite.
  for i in 0..<placement_count {
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
        )
        match (def.0, def.2) {
          (Some(r), Some(c)) =>
            mark_placed(
              placed,
              placed_row,
              placed_col,
              placed_row_span,
              placed_col_span,
              occ,
              row_tracks,
              col_tracks,
              auto_rows,
              auto_cols,
              negative_rows,
              negative_cols,
              explicit_row_count,
              explicit_col_count,
              i,
              r,
              c,
              def.1,
              def.3,
            )
          _ => ()
        }
      }
    }
  }

  // Pass 2: definite in secondary axis only.
  for i in 0..<placement_count {
    if placed[i] {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
        )
        if primary_is_col {
          // Flow rows: primary axis is columns, secondary axis is rows.
          match (def.0, def.2) {
            (Some(r), None) => {
              let row_span = def.1
              let col_span = def.3
              let mut c = 0
              while true {
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  r + row_span - 1,
                )
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  c + col_span - 1,
                )
                if region_is_free(occ, r, c, row_span, col_span) {
                  mark_placed(
                    placed, placed_row, placed_col, placed_row_span, placed_col_span,
                    occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                    negative_cols, explicit_row_count, explicit_col_count, i, r,
                    c, row_span, col_span,
                  )
                  break
                }
                c = c + 1
              }
            }
            _ => ()
          }
        } else {
          // Flow columns: primary axis is rows, secondary axis is columns.
          match (def.0, def.2) {
            (None, Some(c)) => {
              let row_span = def.1
              let col_span = def.3
              let mut r = 0
              while true {
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  r + row_span - 1,
                )
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  c + col_span - 1,
                )
                if region_is_free(occ, r, c, row_span, col_span) {
                  mark_placed(
                    placed, placed_row, placed_col, placed_row_span, placed_col_span,
                    occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                    negative_cols, explicit_row_count, explicit_col_count, i, r,
                    c, row_span, col_span,
                  )
                  break
                }
                r = r + 1
              }
            }
            _ => ()
          }
        }
      }
    }
  }

  // Pass 3: remaining items (auto-placement in the flow direction).
  // Dense: restart the scan for each item, filling earlier holes.
  // Sparse: resume placement from the last cursor position.
  let mut cursor_sec = 0
  let mut cursor_prim = 0
  for i in 0..<placement_count {
    if placed[i] {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ => {
        let def = child_start_indexes_and_spans(
          child.style,
          explicit_col_count,
          explicit_row_count,
          negative_cols,
          negative_rows,
        )
        let row_span = def.1
        let col_span = def.3
        let mut sec = if dense { 0 } else { cursor_sec }
        while true {
          if primary_is_col {
            // Auto-flow rows: scan row-by-row
            let fixed_col = def.2
            match fixed_col {
              Some(c0) =>
                while true {
                  if not(dense) && sec == cursor_sec && c0 < cursor_prim {
                    sec = sec + 1
                  }
                  ensure_rows(
                    occ,
                    row_tracks,
                    auto_rows,
                    negative_rows,
                    explicit_row_count,
                    sec + row_span - 1,
                  )
                  ensure_cols(
                    occ,
                    col_tracks,
                    auto_cols,
                    negative_cols,
                    explicit_col_count,
                    c0 + col_span - 1,
                  )
                  if region_is_free(occ, sec, c0, row_span, col_span) {
                    mark_placed(
                      placed, placed_row, placed_col, placed_row_span, placed_col_span,
                      occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                      negative_cols, explicit_row_count, explicit_col_count, i, sec,
                      c0, row_span, col_span,
                    )
                    if not(dense) {
                      cursor_sec = sec
                      cursor_prim = c0 + col_span
                      if cursor_prim >= col_tracks.length() {
                        cursor_sec = cursor_sec + 1
                        cursor_prim = 0
                      }
                    }
                    sec = -1
                    break
                  }
                  sec = sec + 1
                }
              None => {
                ensure_cols(
                  occ,
                  col_tracks,
                  auto_cols,
                  negative_cols,
                  explicit_col_count,
                  col_span - 1,
                )
                while true {
                  ensure_rows(
                    occ,
                    row_tracks,
                    auto_rows,
                    negative_rows,
                    explicit_row_count,
                    sec + row_span - 1,
                  )
                  let mut prim = if dense || sec != cursor_sec {
                    0
                  } else {
                    cursor_prim
                  }
                  let max_prim = col_tracks.length() - col_span + 1
                  let mut found = false
                  while prim < max_prim {
                    if region_is_free(occ, sec, prim, row_span, col_span) {
                      mark_placed(
                        placed, placed_row, placed_col, placed_row_span, placed_col_span,
                        occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                        negative_cols, explicit_row_count, explicit_col_count, i,
                        sec, prim, row_span, col_span,
                      )
                      if not(dense) {
                        cursor_sec = sec
                        cursor_prim = prim + col_span
                        if cursor_prim >= col_tracks.length() {
                          cursor_sec = cursor_sec + 1
                          cursor_prim = 0
                        }
                      }
                      found = true
                      break
                    }
                    prim = prim + 1
                  }
                  if found {
                    sec = -1
                    break
                  }
                  sec = sec + 1
                }
              }
            }
            if sec == -1 {
              break
            }
          } else {
            // Auto-flow columns: scan col-by-col
            let fixed_row = def.0
            match fixed_row {
              Some(r0) =>
                while true {
                  if not(dense) && sec == cursor_sec && r0 < cursor_prim {
                    sec = sec + 1
                  }
                  ensure_cols(
                    occ,
                    col_tracks,
                    auto_cols,
                    negative_cols,
                    explicit_col_count,
                    sec + col_span - 1,
                  )
                  ensure_rows(
                    occ,
                    row_tracks,
                    auto_rows,
                    negative_rows,
                    explicit_row_count,
                    r0 + row_span - 1,
                  )
                  if region_is_free(occ, r0, sec, row_span, col_span) {
                    mark_placed(
                      placed, placed_row, placed_col, placed_row_span, placed_col_span,
                      occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                      negative_cols, explicit_row_count, explicit_col_count, i, r0,
                      sec, row_span, col_span,
                    )
                    if not(dense) {
                      cursor_sec = sec
                      cursor_prim = r0 + row_span
                      if cursor_prim >= row_tracks.length() {
                        cursor_sec = cursor_sec + 1
                        cursor_prim = 0
                      }
                    }
                    sec = -1
                    break
                  }
                  sec = sec + 1
                }
              None => {
                ensure_rows(
                  occ,
                  row_tracks,
                  auto_rows,
                  negative_rows,
                  explicit_row_count,
                  row_span - 1,
                )
                while true {
                  ensure_cols(
                    occ,
                    col_tracks,
                    auto_cols,
                    negative_cols,
                    explicit_col_count,
                    sec + col_span - 1,
                  )
                  let mut prim = if dense || sec != cursor_sec {
                    0
                  } else {
                    cursor_prim
                  }
                  let max_prim = row_tracks.length() - row_span + 1
                  let mut found = false
                  while prim < max_prim {
                    if region_is_free(occ, prim, sec, row_span, col_span) {
                      mark_placed(
                        placed, placed_row, placed_col, placed_row_span, placed_col_span,
                        occ, row_tracks, col_tracks, auto_rows, auto_cols, negative_rows,
                        negative_cols, explicit_row_count, explicit_col_count, i,
                        prim, sec, row_span, col_span,
                      )
                      if not(dense) {
                        cursor_sec = sec
                        cursor_prim = prim + row_span
                        if cursor_prim >= row_tracks.length() {
                          cursor_sec = cursor_sec + 1
                          cursor_prim = 0
                        }
                      }
                      found = true
                      break
                    }
                    prim = prim + 1
                  }
                  if found {
                    sec = -1
                    break
                  }
                  sec = sec + 1
                }
              }
            }
            if sec == -1 {
              break
            }
          }
        }
      }
    }
  }
  let mut col_count = col_tracks.length()
  let mut row_count = row_tracks.length()

  // Compute min-content and max-content contributions for each track.
  let col_min_contrib : Array[Double] = Array::make(col_count, 0.0)
  let col_max_contrib : Array[Double] = Array::make(col_count, 0.0)
  let row_min_contrib : Array[Double] = Array::make(row_count, 0.0)
  let row_max_contrib : Array[Double] = Array::make(row_count, 0.0)
  for i in 0..<placement_count {
    if not(placed[i]) {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c0) => c0
      None => raise InvalidNodeId(child_id)
    }
    let c = placed_col[i]
    let col_span = placed_col_span[i]
    let gap_total = col_gap * (col_span - 1).to_double()

    // Max-content contribution in the column axis
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      Size::new(width=AvailMaxContent, height=AvailMaxContent),
      Point::zero(),
      measure_function,
      false,
    )
    let max_sz = tree.nodes[child_id].layout.size
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      Size::new(width=AvailMaxContent, height=AvailMaxContent),
    )
    let max_needed = max_double(
      max_sz.width + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    let max_share = max_needed / col_span.to_double()
    for j in c..<(c + col_span) {
      if max_share > col_max_contrib[j] {
        col_max_contrib[j] = max_share
      }
    }

    // Min-content contribution in the column axis
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      Size::new(width=AvailMinContent, height=AvailMaxContent),
      Point::zero(),
      measure_function,
      false,
    )
    let min_col = tree.nodes[child_id].layout.size.width
    let min_needed = max_double(
      min_col + resolved_margin.left + resolved_margin.right - gap_total,
      0.0,
    )
    let min_share = min_needed / col_span.to_double()
    for j in c..<(c + col_span) {
      if min_share > col_min_contrib[j] {
        col_min_contrib[j] = min_share
      }
    }
  }
  fn track_basis_fit_content(
    min_c : Double,
    max_c : Double,
    limit : Dimension,
    available : Double,
  ) -> Double {
    match limit {
      DimPercent(_) => max_c
      _ => {
        let lim = resolve_track_dimension(limit, available)
        let preferred = if max_c < lim { max_c } else { lim }
        if preferred < min_c {
          min_c
        } else {
          preferred
        }
      }
    }
  }

  fn axis_min_content_basis(
    tracks : Array[Dimension],
    min_contrib : Array[Double],
    max_contrib : Array[Double],
    gap : Double,
  ) -> Double {
    let mut total = 0.0
    let mut fr_sum = 0.0
    let mut fr_fraction = 0.0
    for i in 0..<tracks.length() {
      let min_c = min_contrib[i]
      let max_c = max_contrib[i]
      match tracks[i] {
        DimFr(w) =>
          if w > 0.0 {
            fr_sum = fr_sum + w
            let ratio = min_c / w
            if ratio > fr_fraction {
              fr_fraction = ratio
            }
          } else {
            ()
          }
        _ =>
          total = total +
            (match tracks[i] {
              DimLength(v) => v
              DimAuto => min_c
              DimPercent(_) => min_c
              DimMinContent => min_c
              DimMaxContent => max_c
              DimFitContent(limit) =>
                track_basis_fit_content(min_c, max_c, limit, 0.0)
              DimMinMax(min_d, _max_d) =>
                // Conservative: use the min sizing function where possible.
                match min_d {
                  DimAuto | DimMinContent => min_c
                  DimMaxContent => max_c
                  _ => resolve_track_dimension(min_d, 0.0)
                }
              _ => 0.0
            })
      }
    }
    total = total + fr_fraction * fr_sum
    if tracks.length() > 1 {
      total = total + gap * (tracks.length() - 1).to_double()
    }
    total
  }

  fn axis_max_content_basis(
    tracks : Array[Dimension],
    min_contrib : Array[Double],
    max_contrib : Array[Double],
    gap : Double,
  ) -> Double {
    let mut total = 0.0
    let mut fr_sum = 0.0
    let mut fr_fraction = 0.0
    for i in 0..<tracks.length() {
      let min_c = min_contrib[i]
      let max_c = max_contrib[i]
      match tracks[i] {
        DimFr(w) =>
          if w > 0.0 {
            fr_sum = fr_sum + w
            let ratio = max_c / w
            if ratio > fr_fraction {
              fr_fraction = ratio
            }
          } else {
            ()
          }
        _ =>
          total = total +
            (match tracks[i] {
              DimLength(v) => v
              DimAuto => max_c
              DimPercent(_) => max_c
              DimMinContent => min_c
              DimMaxContent => max_c
              DimFitContent(limit) =>
                track_basis_fit_content(min_c, max_c, limit, 0.0)
              DimMinMax(_min_d, max_d) =>
                match max_d {
                  DimAuto | DimMaxContent => max_c
                  DimMinContent => min_c
                  DimFitContent(limit) =>
                    track_basis_fit_content(min_c, max_c, limit, 0.0)
                  _ => resolve_track_dimension(max_d, 0.0)
                }
              _ => 0.0
            })
      }
    }
    total = total + fr_fraction * fr_sum
    if tracks.length() > 1 {
      total = total + gap * (tracks.length() - 1).to_double()
    }
    total
  }

  fn available_inset_or_basis(
    available : AvailableSpace,
    inset : Double,
    min_basis : Double,
    max_basis : Double,
  ) -> Double {
    match available {
      AvailDefinite(v) => max_double(v - inset, 0.0)
      AvailMinContent => min_basis
      AvailMaxContent => max_basis
    }
  }

  let col_min_basis = axis_min_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let col_max_basis = axis_max_content_basis(
    col_tracks, col_min_contrib, col_max_contrib, col_gap,
  )
  let col_available = match specified_width {
    Some(_) => content_width
    None =>
      available_inset_or_basis(
        available_space.width,
        horiz_inset,
        col_min_basis,
        col_max_basis,
      )
  }
  let col_available_base = col_available
  let mut col_sizes : Array[Double] = compute_grid_track_sizes_with_contributions(
    col_tracks,
    col_available,
    col_gap,
    col_min_contrib,
    col_max_contrib,
    specified_width is Some(_),
  )

  // Compute row contributions with the resolved column widths as a constraint.
  for i in 0..<placement_count {
    if not(placed[i]) {
      continue
    }
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c0) => c0
      None => raise InvalidNodeId(child_id)
    }
    let c = placed_col[i]
    let col_span = placed_col_span[i]
    let r = placed_row[i]
    let row_span = placed_row_span[i]
    let mut col_w = 0.0
    for j in c..<(c + col_span) {
      col_w = col_w + col_sizes[j]
    }
    if col_span > 1 {
      col_w = col_w + col_gap * (col_span - 1).to_double()
    }
    let row_gap_total = row_gap * (row_span - 1).to_double()

    // Max-content contribution in the row axis under the column width constraint.
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=Some(col_w), height=None),
      Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
      Point::zero(),
      measure_function,
      false,
    )
    let max_h = tree.nodes[child_id].layout.size.height
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
    )
    let max_needed = max_double(
      max_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
      0.0,
    )
    let max_share = max_needed / row_span.to_double()
    for j in r..<(r + row_span) {
      if max_share > row_max_contrib[j] {
        row_max_contrib[j] = max_share
      }
    }

    // Min-content contribution in the row axis under the column width constraint.
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=Some(col_w), height=None),
      Size::new(width=AvailDefinite(col_w), height=AvailMinContent),
      Point::zero(),
      measure_function,
      false,
    )
    let min_h = tree.nodes[child_id].layout.size.height
    let min_needed = max_double(
      min_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
      0.0,
    )
    let min_share = min_needed / row_span.to_double()
    for j in r..<(r + row_span) {
      if min_share > row_min_contrib[j] {
        row_min_contrib[j] = min_share
      }
    }
  }
  let row_min_basis = axis_min_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let row_max_basis = axis_max_content_basis(
    row_tracks, row_min_contrib, row_max_contrib, row_gap,
  )
  let row_available = match specified_height {
    Some(_) => content_height
    None =>
      available_inset_or_basis(
        available_space.height,
        vert_inset,
        row_min_basis,
        row_max_basis,
      )
  }
  let row_available_base = row_available
  let mut row_sizes : Array[Double] = compute_grid_track_sizes_with_contributions(
    row_tracks,
    row_available,
    row_gap,
    row_min_contrib,
    row_max_contrib,
    specified_height is Some(_),
  )
  let mut used_cols = 0.0
  for w in col_sizes {
    used_cols = used_cols + w
  }
  if col_count > 1 {
    used_cols = used_cols + col_gap * (col_count - 1).to_double()
  }
  let mut used_rows = 0.0
  for h in row_sizes {
    used_rows = used_rows + h
  }
  if row_count > 1 {
    used_rows = used_rows + row_gap * (row_count - 1).to_double()
  }

  // Container sizing (border-box). If width/height are not specified, size to tracks.
  if specified_width is None {
    let intrinsic_cols = match available_space.width {
      AvailMaxContent => col_max_basis
      AvailMinContent => col_min_basis
      AvailDefinite(_) => used_cols
    }
    border_box_width = clamp_dimension(
      max_double(intrinsic_cols + horiz_inset, horiz_inset),
      node.style.min_size.width,
      node.style.max_size.width,
      available_space.width,
    )
    content_width = max_double(border_box_width - horiz_inset, 0.0)
  }
  if specified_height is None {
    let intrinsic_rows = match available_space.height {
      AvailMaxContent => row_max_basis
      AvailMinContent => row_min_basis
      AvailDefinite(_) => used_rows
    }
    border_box_height = clamp_dimension(
      max_double(intrinsic_rows + vert_inset, vert_inset),
      node.style.min_size.height,
      node.style.max_size.height,
      available_space.height,
    )
    content_height = max_double(border_box_height - vert_inset, 0.0)
  }

  // Deferred percentage gaps: if the container inline size was unknown during intrinsic sizing,
  // re-resolve percentage gaps against the computed inline content size and recompute track sizes.
  let mut rerun_track_sizing = false
  match gap_width_percent {
    Some(p) =>
      if col_gap == 0.0 && content_width > 0.0 {
        col_gap = content_width * p
        rerun_track_sizing = true
      }
    None => ()
  }
  match gap_height_percent {
    Some(p) =>
      if row_gap == 0.0 && content_width > 0.0 {
        row_gap = content_width * p
        rerun_track_sizing = true
      }
    None => ()
  }
  if rerun_track_sizing {
    // Recompute contributions with the updated gap values.
    for i in 0..<col_count {
      col_min_contrib[i] = 0.0
      col_max_contrib[i] = 0.0
    }
    for i in 0..<row_count {
      row_min_contrib[i] = 0.0
      row_max_contrib[i] = 0.0
    }
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let child_id = node.children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c0) => c0
        None => raise InvalidNodeId(child_id)
      }
      let c = placed_col[i]
      let col_span = placed_col_span[i]
      let gap_total = col_gap * (col_span - 1).to_double()
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=None, height=None),
        Size::new(width=AvailMaxContent, height=AvailMaxContent),
        Point::zero(),
        measure_function,
        false,
      )
      let max_sz = tree.nodes[child_id].layout.size
      let resolved_margin = resolve_rect_width_basis(
        child.style.margin,
        Size::new(width=AvailMaxContent, height=AvailMaxContent),
      )
      let max_needed = max_double(
        max_sz.width + resolved_margin.left + resolved_margin.right - gap_total,
        0.0,
      )
      let max_share = max_needed / col_span.to_double()
      for j in c..<(c + col_span) {
        if max_share > col_max_contrib[j] {
          col_max_contrib[j] = max_share
        }
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=None, height=None),
        Size::new(width=AvailMinContent, height=AvailMaxContent),
        Point::zero(),
        measure_function,
        false,
      )
      let min_col = tree.nodes[child_id].layout.size.width
      let min_needed = max_double(
        min_col + resolved_margin.left + resolved_margin.right - gap_total,
        0.0,
      )
      let min_share = min_needed / col_span.to_double()
      for j in c..<(c + col_span) {
        if min_share > col_min_contrib[j] {
          col_min_contrib[j] = min_share
        }
      }
    }
    col_sizes = compute_grid_track_sizes_with_contributions(
      col_tracks,
      col_available_base,
      col_gap,
      col_min_contrib,
      col_max_contrib,
      specified_width is Some(_),
    )
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let child_id = node.children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c0) => c0
        None => raise InvalidNodeId(child_id)
      }
      let c = placed_col[i]
      let col_span = placed_col_span[i]
      let r = placed_row[i]
      let row_span = placed_row_span[i]
      let mut col_w = 0.0
      for j in c..<(c + col_span) {
        col_w = col_w + col_sizes[j]
      }
      if col_span > 1 {
        col_w = col_w + col_gap * (col_span - 1).to_double()
      }
      let row_gap_total = row_gap * (row_span - 1).to_double()
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=Some(col_w), height=None),
        Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
        Point::zero(),
        measure_function,
        false,
      )
      let max_h = tree.nodes[child_id].layout.size.height
      let resolved_margin = resolve_rect_width_basis(
        child.style.margin,
        Size::new(width=AvailDefinite(col_w), height=AvailMaxContent),
      )
      let max_needed = max_double(
        max_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
        0.0,
      )
      let max_share = max_needed / row_span.to_double()
      for j in r..<(r + row_span) {
        if max_share > row_max_contrib[j] {
          row_max_contrib[j] = max_share
        }
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=Some(col_w), height=None),
        Size::new(width=AvailDefinite(col_w), height=AvailMinContent),
        Point::zero(),
        measure_function,
        false,
      )
      let min_h = tree.nodes[child_id].layout.size.height
      let min_needed = max_double(
        min_h + resolved_margin.top + resolved_margin.bottom - row_gap_total,
        0.0,
      )
      let min_share = min_needed / row_span.to_double()
      for j in r..<(r + row_span) {
        if min_share > row_min_contrib[j] {
          row_min_contrib[j] = min_share
        }
      }
    }
    row_sizes = compute_grid_track_sizes_with_contributions(
      row_tracks,
      row_available_base,
      row_gap,
      row_min_contrib,
      row_max_contrib,
      specified_height is Some(_),
    )
    used_cols = 0.0
    for w in col_sizes {
      used_cols = used_cols + w
    }
    if col_count > 1 {
      used_cols = used_cols + col_gap * (col_count - 1).to_double()
    }
    used_rows = 0.0
    for h in row_sizes {
      used_rows = used_rows + h
    }
    if row_count > 1 {
      used_rows = used_rows + row_gap * (row_count - 1).to_double()
    }
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }

  // Track alignment within the container's content box.
  let align_content = match node.style.align_content {
    Some(v) => v
    None => AlignStart
  }
  let justify_content = match node.style.justify_content {
    Some(v) => v
    None => AlignStart
  }

  // `repeat(auto-fit, ...)` collapses empty tracks.
  if has_auto_fit_cols || has_auto_fit_rows {
    let mut max_row_used = 0
    let mut max_col_used = 0
    for i in 0..<placement_count {
      if not(placed[i]) {
        continue
      }
      let row = placed_row[i]
      let col = placed_col[i]
      let row_end = row + placed_row_span[i] - 1
      let col_end = col + placed_col_span[i] - 1
      if row_end > max_row_used {
        max_row_used = row_end
      }
      if col_end > max_col_used {
        max_col_used = col_end
      }
    }
    if has_auto_fit_cols {
      let needed = max_col_used + 1
      let keep = if needed > non_auto_fit_col_count {
        needed
      } else {
        non_auto_fit_col_count
      }
      if keep > 0 && keep < col_count {
        col_count = keep
        let truncated : Array[Double] = Array::make(col_count, 0.0)
        for i in 0..<col_count {
          truncated[i] = col_sizes[i]
        }
        col_sizes = truncated
        let truncated_tracks : Array[Dimension] = Array::make(
          col_count,
          DimAuto,
        )
        for i in 0..<col_count {
          truncated_tracks[i] = col_tracks[i]
        }
        col_tracks = truncated_tracks
        used_cols = 0.0
        for w in col_sizes {
          used_cols = used_cols + w
        }
        if col_count > 1 {
          used_cols = used_cols + col_gap * (col_count - 1).to_double()
        }
      }
    }
    if has_auto_fit_rows {
      let needed = max_row_used + 1
      let keep = if needed > non_auto_fit_row_count {
        needed
      } else {
        non_auto_fit_row_count
      }
      if keep > 0 && keep < row_count {
        row_count = keep
        let truncated : Array[Double] = Array::make(row_count, 0.0)
        for i in 0..<row_count {
          truncated[i] = row_sizes[i]
        }
        row_sizes = truncated
        let truncated_tracks : Array[Dimension] = Array::make(
          row_count,
          DimAuto,
        )
        for i in 0..<row_count {
          truncated_tracks[i] = row_tracks[i]
        }
        row_tracks = truncated_tracks
        used_rows = 0.0
        for h in row_sizes {
          used_rows = used_rows + h
        }
        if row_count > 1 {
          used_rows = used_rows + row_gap * (row_count - 1).to_double()
        }
      }
    }
  }
  let leftover_x = content_width - used_cols
  let leftover_y = content_height - used_rows
  let mut start_x = 0.0
  let mut col_gap_effective = col_gap
  match justify_content {
    AlignCenter => start_x = leftover_x / 2.0
    AlignFlexEnd | AlignEnd => start_x = leftover_x
    AlignFlexStart | AlignStart => ()
    AlignSpaceBetween =>
      if col_count > 1 && leftover_x > 0.0 {
        col_gap_effective = col_gap_effective +
          leftover_x / (col_count - 1).to_double()
      }
    AlignSpaceAround =>
      if col_count > 0 && leftover_x > 0.0 {
        let extra = leftover_x / col_count.to_double()
        if is_near_int(leftover_x) {
          let gap_extra_floor = extra.floor()
          let gap_extra = if extra > gap_extra_floor {
            gap_extra_floor + 1.0
          } else {
            gap_extra_floor
          }
          col_gap_effective = col_gap_effective + gap_extra
          start_x = (extra / 2.0).floor()
        } else {
          col_gap_effective = col_gap_effective + extra
          start_x = extra / 2.0
        }
      }
    AlignSpaceEvenly =>
      if col_count > 0 && leftover_x > 0.0 {
        let spaces = (col_count + 1).to_double()
        let extra = leftover_x / spaces
        if leftover_x > 0.0 && is_near_int(leftover_x) {
          let start_extra = extra.floor()
          let gap_extra = if extra > start_extra {
            start_extra + 1.0
          } else {
            start_extra
          }
          col_gap_effective = col_gap_effective + gap_extra
          start_x = start_extra
        } else {
          col_gap_effective = col_gap_effective + extra
          start_x = extra
        }
      }
    AlignStretch =>
      if col_count > 0 {
        let extra = leftover_x / col_count.to_double()
        for i in 0..<col_count {
          let v = col_sizes[i] + extra
          col_sizes[i] = if v > 0.0 { v } else { 0.0 }
        }
      }
  }
  let mut start_y = 0.0
  let mut row_gap_effective = row_gap
  match align_content {
    AlignCenter => start_y = leftover_y / 2.0
    AlignFlexEnd | AlignEnd => start_y = leftover_y
    AlignFlexStart | AlignStart => ()
    AlignSpaceBetween =>
      if row_count > 1 && leftover_y > 0.0 {
        row_gap_effective = row_gap_effective +
          leftover_y / (row_count - 1).to_double()
      }
    AlignSpaceAround =>
      if row_count > 0 && leftover_y > 0.0 {
        let extra = leftover_y / row_count.to_double()
        if is_near_int(leftover_y) {
          let gap_extra_floor = extra.floor()
          let gap_extra = if extra > gap_extra_floor {
            gap_extra_floor + 1.0
          } else {
            gap_extra_floor
          }
          row_gap_effective = row_gap_effective + gap_extra
          start_y = (extra / 2.0).floor()
        } else {
          row_gap_effective = row_gap_effective + extra
          start_y = extra / 2.0
        }
      }
    AlignSpaceEvenly =>
      if row_count > 0 && leftover_y > 0.0 {
        let spaces = (row_count + 1).to_double()
        let extra = leftover_y / spaces
        if leftover_y > 0.0 && is_near_int(leftover_y) {
          let start_extra = extra.floor()
          let gap_extra = if extra > start_extra {
            start_extra + 1.0
          } else {
            start_extra
          }
          row_gap_effective = row_gap_effective + gap_extra
          start_y = start_extra
        } else {
          row_gap_effective = row_gap_effective + extra
          start_y = extra
        }
      }
    AlignStretch =>
      if row_count > 0 {
        let extra = leftover_y / row_count.to_double()
        for i in 0..<row_count {
          let v = row_sizes[i] + extra
          row_sizes[i] = if v > 0.0 { v } else { 0.0 }
        }
      }
  }
  let base_x = absolute_origin.x + border.left + padding.left
  let base_y = absolute_origin.y + border.top + padding.top
  let default_align_items = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let default_justify_items = match node.style.justify_items {
    Some(v) => v
    None => ItemsStretch
  }
  for i in 0..<placement_count {
    let child_id = node.children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
      _ => {
        let row = placed_row[i]
        let col = placed_col[i]
        let row_span = placed_row_span[i]
        let col_span = placed_col_span[i]
        let row_end = row + row_span - 1
        let col_end = col + col_span - 1
        if row < 0 || col < 0 || row_end >= row_count || col_end >= col_count {
          continue
        }
        let mut x = start_x
        for c in 0..<col {
          x = x + col_sizes[c] + col_gap_effective
        }
        let mut y = start_y
        for r in 0..<row {
          y = y + row_sizes[r] + row_gap_effective
        }
        let mut cell_w = 0.0
        for c in col..<(col + col_span) {
          cell_w = cell_w + col_sizes[c]
        }
        if col_span > 1 {
          cell_w = cell_w + col_gap_effective * (col_span - 1).to_double()
        }
        let mut cell_h = 0.0
        for r in row..<(row + row_span) {
          cell_h = cell_h + row_sizes[r]
        }
        if row_span > 1 {
          cell_h = cell_h + row_gap_effective * (row_span - 1).to_double()
        }
        let child_available = Size::new(
          width=AvailDefinite(cell_w),
          height=AvailDefinite(cell_h),
        )
        // Grid item margins apply inside the cell and contribute to track sizing.
        let resolved_margin = resolve_rect_width_basis(
          child.style.margin,
          child_available,
        )
        let available_w_for_item = max_double(
          cell_w - resolved_margin.left - resolved_margin.right,
          0.0,
        )
        let available_h_for_item = max_double(
          cell_h - resolved_margin.top - resolved_margin.bottom,
          0.0,
        )
        let item_available = Size::new(
          width=AvailDefinite(available_w_for_item),
          height=AvailDefinite(available_h_for_item),
        )
        let justify = match child.style.justify_self {
          Some(v) => v
          None => default_justify_items
        }
        let align = match child.style.align_self {
          Some(v) => v
          None => default_align_items
        }
        let known_w = match justify {
          ItemsStretch =>
            if child.style.size.width is DimAuto {
              Some(available_w_for_item)
            } else {
              None
            }
          _ => None
        }
        let known_h = match align {
          ItemsStretch =>
            if child.style.size.height is DimAuto {
              Some(available_h_for_item)
            } else {
              None
            }
          _ => None
        }

        // First pass: compute the item's intrinsic size within the cell constraints.
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=known_w, height=known_h),
          item_available,
          Point::zero(),
          measure_function,
          false,
        )
        let intrinsic = tree.nodes[child_id].layout.size
        let offset_x = match justify {
          ItemsEnd | ItemsFlexEnd => available_w_for_item - intrinsic.width
          ItemsCenter => (available_w_for_item - intrinsic.width) / 2.0
          _ => 0.0
        }
        let offset_y = match align {
          ItemsEnd | ItemsFlexEnd => available_h_for_item - intrinsic.height
          ItemsCenter => (available_h_for_item - intrinsic.height) / 2.0
          _ => 0.0
        }

        // Second pass: position the item within the cell.
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=known_w, height=known_h),
          item_available,
          Point::new(
            x=base_x + x + resolved_margin.left + offset_x,
            y=base_y + y + resolved_margin.top + offset_y,
          ),
          measure_function,
          false,
        )
      }
    }
  }
  let resolved_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  tree.nodes[node_id].effective_margin_top = resolved_margin.top
  tree.nodes[node_id].effective_margin_bottom = resolved_margin.bottom
}

///|
fn[C] compute_block_layout_with_measure(
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
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let padding = resolve_rect_width_basis(node.style.padding, available_space)
  let border = resolve_rect_width_basis(node.style.border, available_space)
  let scrollbar_w = node.style.scrollbar_width
  let scrollbar_x = match node.style.overflow.x {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  let scrollbar_y = match node.style.overflow.y {
    OverflowScroll => scrollbar_w
    _ => 0.0
  }
  // Overflow::Scroll reserves scrollbar space inside the border box.
  // Horizontal scrollbar consumes cross (vertical) space; vertical scrollbar consumes main (horizontal) space.
  let horiz_inset = padding.left +
    padding.right +
    border.left +
    border.right +
    scrollbar_y
  let vert_inset = padding.top +
    padding.bottom +
    border.top +
    border.bottom +
    scrollbar_x
  let style_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let style_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let specified_width = match known_dimensions.width {
    Some(w) => Some(w)
    None => style_width
  }
  let specified_height = match known_dimensions.height {
    Some(h) => Some(h)
    None => style_height
  }
  let width_definite = match specified_width {
    Some(_) => true
    None =>
      match available_space.width {
        AvailDefinite(_) => true
        _ => false
      }
  }

  // Minimal block sizing: border-box.
  let raw_width = match specified_width {
    Some(w) => max_double(w, horiz_inset)
    None =>
      match available_space.width {
        AvailDefinite(v) => max_double(v, horiz_inset)
        _ => horiz_inset
      }
  }
  let raw_height = match specified_height {
    Some(h) => max_double(h, vert_inset)
    None => vert_inset
  }
  let border_box_width = max_double(
    clamp_dimension(
      raw_width,
      node.style.min_size.width,
      node.style.max_size.width,
      available_space.width,
    ),
    horiz_inset,
  )
  let border_box_height = max_double(
    clamp_dimension(
      raw_height,
      node.style.min_size.height,
      node.style.max_size.height,
      available_space.height,
    ),
    vert_inset,
  )
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }

  // Containing block for in-flow positioning: content box (padding box minus padding).
  let padding_origin = Point::new(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let content_origin = Point::new(
    x=padding_origin.x + padding.left,
    y=padding_origin.y + padding.top,
  )
  let content_width = max_double(border_box_width - horiz_inset, 0.0)
  let content_height = max_double(border_box_height - vert_inset, 0.0)
  let flow_available = Size::new(
    width=match width_definite {
      true => AvailDefinite(content_width)
      false => available_space.width
    },
    height=match specified_height {
      Some(_) => AvailDefinite(content_height)
      None => AvailMaxContent
    },
  )
  let margin_basis_width = match available_space.width {
    AvailDefinite(v) => v
    _ =>
      match specified_width {
        Some(w) => max_double(w - horiz_inset, 0.0)
        None => 0.0
      }
  }
  let margin_basis_available = Size::new(
    width=AvailDefinite(margin_basis_width),
    height=flow_available.height,
  )
  fn collapse_state_add(
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

  fn collapse_state_value(state : (Double, Double)) -> Double {
    state.0 + state.1
  }

  fn collapse_state_from(margin : Double) -> (Double, Double) {
    collapse_state_add((0.0, 0.0), margin)
  }

  fn has_in_flow_children(
    tree : TaffyTree[C],
    children : Array[NodeId],
  ) -> Bool raise TaffyError {
    for child_id in children {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => ()
        _ =>
          match child.style.position {
            PosRelative => return true
            PosAbsolute => ()
          }
      }
    }
    false
  }

  fn can_collapse_through_child(
    tree : TaffyTree[C],
    child : Node[C],
    child_size : Size[Double],
  ) -> Bool raise TaffyError {
    match child.style.display {
      DisplayBlock => ()
      _ => return false
    }
    if child_size.height != 0.0 {
      return false
    } else {
      ()
    }
    match child.context {
      Some(_) => return false
      None => ()
    }
    let overflow_visible = match
      (child.style.overflow.x, child.style.overflow.y) {
      (OverflowVisible, OverflowVisible) => true
      _ => false
    }
    if not(overflow_visible) {
      return false
    } else {
      ()
    }
    if has_in_flow_children(tree, child.children) {
      return false
    } else {
      ()
    }
    true
  }

  let resolved_own_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  let own_margin_top = resolved_own_margin.top
  let own_margin_bottom = resolved_own_margin.bottom
  let parent_overflow_visible = match
    (node.style.overflow.x, node.style.overflow.y) {
    (OverflowVisible, OverflowVisible) => true
    _ => false
  }
  let mut first_in_flow_child : NodeId? = None
  let mut last_in_flow_child : NodeId? = None
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => ()
      _ =>
        match child.style.position {
          PosRelative => {
            match first_in_flow_child {
              None => first_in_flow_child = Some(child_id)
              Some(_) => ()
            }
            last_in_flow_child = Some(child_id)
          }
          PosAbsolute => ()
        }
    }
  }
  let collapse_with_children = not(is_layout_root) &&
    parent_overflow_visible &&
    specified_height is None
  let first_child_allows_parent_child_collapse = match first_in_flow_child {
    Some(child_id) => {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      child.style.display is DisplayBlock
    }
    None => false
  }
  let last_child_allows_parent_child_collapse = match last_in_flow_child {
    Some(child_id) => {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      child.style.display is DisplayBlock
    }
    None => false
  }
  let collapse_top_with_child = collapse_with_children &&
    padding.top == 0.0 &&
    border.top == 0.0 &&
    first_child_allows_parent_child_collapse
  let collapse_bottom_with_child = collapse_with_children &&
    padding.bottom == 0.0 &&
    border.bottom == 0.0 &&
    last_child_allows_parent_child_collapse
  let abs_child_ids : Array[NodeId] = []
  let abs_child_static_y : Array[Double] = []
  let mut flow_anchor_border_bottom : Double = 0.0
  let mut flow_margin_collapse : (Double, Double) = (0.0, 0.0)
  let mut max_flow_child_width = 0.0
  let content_width_definite = match flow_available.width {
    AvailDefinite(_) => true
    _ => false
  }
  let content_width_for_flow = match flow_available.width {
    AvailDefinite(v) => v
    _ => 0.0
  }
  let mut is_first_in_flow = true
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
      _ =>
        match child.style.position {
          PosAbsolute => {
            abs_child_ids.push(child_id)
            abs_child_static_y.push(
              flow_anchor_border_bottom +
              collapse_state_value(flow_margin_collapse),
            )
          }
          PosRelative => {
            // Minimal normal flow: stack children vertically.
            let margin = child.style.margin
            let margin_left_auto = match margin.left {
              DimAuto => true
              _ => false
            }
            let margin_right_auto = match margin.right {
              DimAuto => true
              _ => false
            }
            let margin_top_auto = match margin.top {
              DimAuto => true
              _ => false
            }
            let resolved_margin = resolve_rect_width_basis(
              margin, margin_basis_available,
            )
            let fixed_margin_left = if margin_left_auto {
              0.0
            } else {
              resolved_margin.left
            }
            let fixed_margin_right = if margin_right_auto {
              0.0
            } else {
              resolved_margin.right
            }
            let fixed_margin_top = if margin_top_auto {
              0.0
            } else {
              resolved_margin.top
            }
            let child_width_auto = match child.style.size.width {
              DimAuto => true
              _ => false
            }
            let aspect_ratio = child.style.aspect_ratio
            let width_from_aspect = match
              (aspect_ratio, child.style.size.width) {
              (Some(ratio), DimAuto) =>
                match
                  resolve_optional_dimension(
                    child.style.size.height,
                    flow_available.height,
                  ) {
                  Some(h) if ratio > 0.0 => Some((h * ratio).round())
                  _ => None
                }
              _ => None
            }
            let mut target_width = match width_from_aspect {
              Some(w) => Some(w)
              None =>
                if content_width_definite && child_width_auto {
                  Some(
                    max_double(
                      content_width_for_flow -
                      fixed_margin_left -
                      fixed_margin_right,
                      0.0,
                    ),
                  )
                } else {
                  None
                }
            }
            match target_width {
              Some(w) => {
                let mut min_width = resolve_optional_dimension(
                  child.style.min_size.width,
                  flow_available.width,
                )
                let mut max_width = resolve_optional_dimension(
                  child.style.max_size.width,
                  flow_available.width,
                )
                match aspect_ratio {
                  Some(ratio) =>
                    if ratio > 0.0 {
                      match
                        (
                          min_width,
                          resolve_optional_dimension(
                            child.style.min_size.height,
                            flow_available.height,
                          ),
                        ) {
                        (None, Some(h)) => min_width = Some((h * ratio).round())
                        _ => ()
                      }
                      match
                        (
                          max_width,
                          resolve_optional_dimension(
                            child.style.max_size.height,
                            flow_available.height,
                          ),
                        ) {
                        (None, Some(h)) => max_width = Some((h * ratio).round())
                        _ => ()
                      }
                    } else {
                      ()
                    }
                  None => ()
                }
                let mut clamped = w
                match min_width {
                  Some(m) => clamped = max_double(clamped, m)
                  None => ()
                }
                match max_width {
                  Some(m) => if clamped > m { clamped = m } else { () }
                  None => ()
                }
                target_width = Some(clamped)
              }
              None => ()
            }
            let is_last_in_flow = match last_in_flow_child {
              Some(v) => v == child_id
              None => false
            }
            let top_used_base = if collapse_top_with_child && is_first_in_flow {
              0.0
            } else {
              fixed_margin_top
            }
            let used_before_base = collapse_state_value(
              collapse_state_add(flow_margin_collapse, top_used_base),
            )
            let mut child_y_rel_static = flow_anchor_border_bottom +
              used_before_base
            compute_node_layout_with_measure(
              tree,
              child_id,
              Size::new(width=target_width, height=None),
              margin_basis_available,
              Point::new(
                x=content_origin.x + fixed_margin_left,
                y=content_origin.y + child_y_rel_static,
              ),
              measure_function,
              false,
            )
            let child_size = tree.nodes[child_id].layout.size
            let effective_top = tree.nodes[child_id].effective_margin_top
            let top_used_effective = if collapse_top_with_child &&
              is_first_in_flow {
              0.0
            } else {
              effective_top
            }
            let used_before_effective = collapse_state_value(
              collapse_state_add(flow_margin_collapse, top_used_effective),
            )
            let delta_y = used_before_effective - used_before_base
            if delta_y != 0.0 {
              offset_subtree(tree, child_id, 0.0, delta_y)
              child_y_rel_static = child_y_rel_static + delta_y
            } else {
              ()
            }
            let remaining = if content_width_definite {
              content_width_for_flow -
              fixed_margin_left -
              fixed_margin_right -
              child_size.width
            } else {
              0.0
            }
            let mut auto_left = 0.0
            let mut auto_right = 0.0
            if content_width_definite {
              if margin_left_auto && margin_right_auto {
                if remaining > 0.0 {
                  auto_left = remaining / 2.0
                  auto_right = remaining / 2.0
                } else {
                  auto_left = 0.0
                  auto_right = 0.0
                }
              } else if margin_left_auto {
                auto_left = if remaining > 0.0 { remaining } else { 0.0 }
              } else if margin_right_auto {
                auto_right = if remaining > 0.0 { remaining } else { 0.0 }
              } else {
                ()
              }
              if auto_left != 0.0 {
                offset_subtree(tree, child_id, auto_left, 0.0)
              } else {
                ()
              }
            } else {
              ()
            }
            let effective_bottom_raw = tree.nodes[child_id].effective_margin_bottom
            let bottom_used_effective = if collapse_bottom_with_child &&
              is_last_in_flow {
              0.0
            } else {
              effective_bottom_raw
            }
            let through = can_collapse_through_child(tree, child, child_size)
            if through {
              flow_margin_collapse = collapse_state_add(
                collapse_state_add(flow_margin_collapse, top_used_effective),
                bottom_used_effective,
              )
            } else {
              flow_anchor_border_bottom = child_y_rel_static + child_size.height
              flow_margin_collapse = collapse_state_from(bottom_used_effective)
            }
            is_first_in_flow = false
            let child_outer_width = fixed_margin_left +
              auto_left +
              child_size.width +
              fixed_margin_right +
              auto_right
            if child_outer_width > max_flow_child_width {
              max_flow_child_width = child_outer_width
            } else {
              ()
            }
          }
        }
    }
  }

  // Auto sizing from in-flow children.
  let final_border_box_width = match width_definite {
    true => border_box_width
    false =>
      max_double(
        clamp_dimension(
          max_double(horiz_inset + max_flow_child_width, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        ),
        horiz_inset,
      )
  }
  let mut final_border_box_height = match specified_height {
    Some(_) => border_box_height
    None =>
      max_double(
        clamp_dimension(
          max_double(
            vert_inset +
            flow_anchor_border_bottom +
            collapse_state_value(flow_margin_collapse),
            vert_inset,
          ),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        ),
        vert_inset,
      )
  }
  // Taffy block layout computes container width first, then performs final in-flow layout with that width.
  // When this container's width is auto, do a second layout pass so that in-flow children can stretch
  // (e.g. auto-width block children) and so that absolute children's static y positions are correct.
  if not(width_definite) {
    let final_content_width_for_flow = max_double(
      final_border_box_width - horiz_inset,
      0.0,
    )
    let final_content_height_for_flow = max_double(
      final_border_box_height - vert_inset,
      0.0,
    )
    let flow_available2 = Size::new(
      width=AvailDefinite(final_content_width_for_flow),
      height=match specified_height {
        Some(_) => AvailDefinite(final_content_height_for_flow)
        None => AvailMaxContent
      },
    )
    let margin_basis_available2 = Size::new(
      width=AvailDefinite(final_content_width_for_flow),
      height=flow_available2.height,
    )
    abs_child_ids.clear()
    abs_child_static_y.clear()
    flow_anchor_border_bottom = 0.0
    flow_margin_collapse = (0.0, 0.0)
    max_flow_child_width = 0.0
    let content_width_for_flow2 = final_content_width_for_flow
    let mut is_first_in_flow2 = true
    for child_id in node.children {
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      match child.style.display {
        DisplayNone => compute_hidden_layout(tree, child_id, Point::zero())
        _ =>
          match child.style.position {
            PosAbsolute => {
              abs_child_ids.push(child_id)
              abs_child_static_y.push(
                flow_anchor_border_bottom +
                collapse_state_value(flow_margin_collapse),
              )
            }
            PosRelative => {
              let margin = child.style.margin
              let margin_left_auto = margin.left is DimAuto
              let margin_right_auto = margin.right is DimAuto
              let margin_top_auto = margin.top is DimAuto
              let resolved_margin = resolve_rect_width_basis(
                margin, margin_basis_available2,
              )
              let fixed_margin_left = if margin_left_auto {
                0.0
              } else {
                resolved_margin.left
              }
              let fixed_margin_right = if margin_right_auto {
                0.0
              } else {
                resolved_margin.right
              }
              let fixed_margin_top = if margin_top_auto {
                0.0
              } else {
                resolved_margin.top
              }
              let child_width_auto = child.style.size.width is DimAuto
              let aspect_ratio = child.style.aspect_ratio
              let width_from_aspect = match
                (aspect_ratio, child.style.size.width) {
                (Some(ratio), DimAuto) =>
                  match
                    resolve_optional_dimension(
                      child.style.size.height,
                      flow_available2.height,
                    ) {
                    Some(h) if ratio > 0.0 => Some((h * ratio).round())
                    _ => None
                  }
                _ => None
              }
              let mut target_width = match width_from_aspect {
                Some(w) => Some(w)
                None =>
                  if child_width_auto {
                    Some(
                      max_double(
                        content_width_for_flow2 -
                        fixed_margin_left -
                        fixed_margin_right,
                        0.0,
                      ),
                    )
                  } else {
                    None
                  }
              }
              match target_width {
                Some(w) => {
                  let mut min_width = resolve_optional_dimension(
                    child.style.min_size.width,
                    flow_available2.width,
                  )
                  let mut max_width = resolve_optional_dimension(
                    child.style.max_size.width,
                    flow_available2.width,
                  )
                  match aspect_ratio {
                    Some(ratio) =>
                      if ratio > 0.0 {
                        match
                          (
                            min_width,
                            resolve_optional_dimension(
                              child.style.min_size.height,
                              flow_available2.height,
                            ),
                          ) {
                          (None, Some(h)) =>
                            min_width = Some((h * ratio).round())
                          _ => ()
                        }
                        match
                          (
                            max_width,
                            resolve_optional_dimension(
                              child.style.max_size.height,
                              flow_available2.height,
                            ),
                          ) {
                          (None, Some(h)) =>
                            max_width = Some((h * ratio).round())
                          _ => ()
                        }
                      } else {
                        ()
                      }
                    None => ()
                  }
                  let mut clamped = w
                  match min_width {
                    Some(m) => clamped = max_double(clamped, m)
                    None => ()
                  }
                  match max_width {
                    Some(m) => if clamped > m { clamped = m } else { () }
                    None => ()
                  }
                  target_width = Some(clamped)
                }
                None => ()
              }
              let is_last_in_flow = match last_in_flow_child {
                Some(v) => v == child_id
                None => false
              }
              let top_used_base = if collapse_top_with_child &&
                is_first_in_flow2 {
                0.0
              } else {
                fixed_margin_top
              }
              let used_before_base = collapse_state_value(
                collapse_state_add(flow_margin_collapse, top_used_base),
              )
              let mut child_y_rel_static = flow_anchor_border_bottom +
                used_before_base
              compute_node_layout_with_measure(
                tree,
                child_id,
                Size::new(width=target_width, height=None),
                flow_available2,
                Point::new(
                  x=content_origin.x + fixed_margin_left,
                  y=content_origin.y + child_y_rel_static,
                ),
                measure_function,
                false,
              )
              let child_size = tree.nodes[child_id].layout.size
              let effective_top = tree.nodes[child_id].effective_margin_top
              let top_used_effective = if collapse_top_with_child &&
                is_first_in_flow2 {
                0.0
              } else {
                effective_top
              }
              let used_before_effective = collapse_state_value(
                collapse_state_add(flow_margin_collapse, top_used_effective),
              )
              let delta_y = used_before_effective - used_before_base
              if delta_y != 0.0 {
                offset_subtree(tree, child_id, 0.0, delta_y)
                child_y_rel_static = child_y_rel_static + delta_y
              } else {
                ()
              }
              let remaining = content_width_for_flow2 -
                fixed_margin_left -
                fixed_margin_right -
                child_size.width
              let mut auto_left = 0.0
              let mut auto_right = 0.0
              if margin_left_auto && margin_right_auto {
                if remaining > 0.0 {
                  auto_left = remaining / 2.0
                  auto_right = remaining / 2.0
                } else {
                  auto_left = 0.0
                  auto_right = 0.0
                }
              } else if margin_left_auto {
                auto_left = if remaining > 0.0 { remaining } else { 0.0 }
              } else if margin_right_auto {
                auto_right = if remaining > 0.0 { remaining } else { 0.0 }
              } else {
                ()
              }
              if auto_left != 0.0 {
                offset_subtree(tree, child_id, auto_left, 0.0)
              } else {
                ()
              }
              let effective_bottom_raw = tree.nodes[child_id].effective_margin_bottom
              let bottom_used_effective = if collapse_bottom_with_child &&
                is_last_in_flow {
                0.0
              } else {
                effective_bottom_raw
              }
              let through = can_collapse_through_child(tree, child, child_size)
              if through {
                flow_margin_collapse = collapse_state_add(
                  collapse_state_add(flow_margin_collapse, top_used_effective),
                  bottom_used_effective,
                )
              } else {
                flow_anchor_border_bottom = child_y_rel_static +
                  child_size.height
                flow_margin_collapse = collapse_state_from(
                  bottom_used_effective,
                )
              }
              is_first_in_flow2 = false
              let child_outer_width = fixed_margin_left +
                auto_left +
                child_size.width +
                fixed_margin_right +
                auto_right
              if child_outer_width > max_flow_child_width {
                max_flow_child_width = child_outer_width
              } else {
                ()
              }
            }
          }
      }
    }
    // Update auto height after reflow.
    final_border_box_height = match specified_height {
      Some(_) => final_border_box_height
      None =>
        max_double(
          clamp_dimension(
            max_double(
              vert_inset +
              flow_anchor_border_bottom +
              collapse_state_value(flow_margin_collapse),
              vert_inset,
            ),
            node.style.min_size.height,
            node.style.max_size.height,
            available_space.height,
          ),
          vert_inset,
        )
    }
  }
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(
      width=final_border_box_width,
      height=final_border_box_height,
    ),
  }

  // Absolute children: positioned relative to the final padding box.
  let final_padding_box_width = max_double(
    final_border_box_width - border.left - border.right,
    0.0,
  )
  let final_padding_box_height = max_double(
    final_border_box_height - border.top - border.bottom,
    0.0,
  )
  let abs_available = Size::new(
    width=AvailDefinite(final_padding_box_width),
    height=AvailDefinite(final_padding_box_height),
  )
  for i in 0..<abs_child_ids.length() {
    let child_id = abs_child_ids[i]
    let static_y = abs_child_static_y[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let margin = child.style.margin
    // CSS compatibility: margin percentages are resolved against the width.
    let margin_left_auto = match margin.left {
      DimAuto => true
      _ => false
    }
    let margin_right_auto = match margin.right {
      DimAuto => true
      _ => false
    }
    let margin_top_auto = match margin.top {
      DimAuto => true
      _ => false
    }
    let margin_bottom_auto = match margin.bottom {
      DimAuto => true
      _ => false
    }
    let margin_left_fixed = resolve_dimension_width_basis(
      margin.left,
      final_padding_box_width,
    )
    let margin_right_fixed = resolve_dimension_width_basis(
      margin.right,
      final_padding_box_width,
    )
    let margin_top_fixed = resolve_dimension_width_basis(
      margin.top,
      final_padding_box_width,
    )
    let margin_bottom_fixed = resolve_dimension_width_basis(
      margin.bottom,
      final_padding_box_width,
    )
    let inset = child.style.inset
    let left = resolve_optional_dimension(inset.left, abs_available.width)
    let right = resolve_optional_dimension(inset.right, abs_available.width)
    let top = resolve_optional_dimension(inset.top, abs_available.height)
    let bottom = resolve_optional_dimension(inset.bottom, abs_available.height)

    // Compute the used size for absolutely positioned items.
    let mut used_width = resolve_optional_dimension(
      child.style.size.width,
      abs_available.width,
    )
    let mut used_height = resolve_optional_dimension(
      child.style.size.height,
      abs_available.height,
    )
    let width_was_auto = match used_width {
      Some(_) => false
      None => true
    }
    let height_was_auto = match used_height {
      Some(_) => false
      None => true
    }
    let mut width_from_inset = false
    let mut height_from_inset = false
    // If size is auto and both insets are definite, the size is determined by the inset constraints.
    match used_width {
      Some(_) => ()
      None =>
        match (left, right) {
          (Some(l), Some(r)) =>
            used_width = Some(
              max_double(
                final_padding_box_width -
                l -
                r -
                margin_left_fixed -
                margin_right_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match used_height {
      Some(_) => ()
      None =>
        match (top, bottom) {
          (Some(t), Some(b)) =>
            used_height = Some(
              max_double(
                final_padding_box_height -
                t -
                b -
                margin_top_fixed -
                margin_bottom_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match (used_width, used_height) {
      (Some(_), _) =>
        if width_was_auto {
          match (left, right) {
            (Some(_), Some(_)) => width_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    match (used_width, used_height) {
      (_, Some(_)) =>
        if height_was_auto {
          match (top, bottom) {
            (Some(_), Some(_)) => height_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    // Apply aspect ratio when only one axis is known.
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (used_width, used_height) {
            (Some(w), None) => used_height = Some((w / ratio).round())
            (None, Some(h)) => used_width = Some((h * ratio).round())
            (Some(w), Some(_h)) =>
              if width_was_auto &&
                height_was_auto &&
                width_from_inset &&
                height_from_inset {
                used_height = Some((w / ratio).round())
              } else {
                ()
              }
            _ => ()
          }
        }
      None => ()
    }

    // Apply aspect ratio to min/max constraints (taffy 0.5 behavior).
    let mut min_width = resolve_optional_dimension(
      child.style.min_size.width,
      abs_available.width,
    )
    let mut min_height = resolve_optional_dimension(
      child.style.min_size.height,
      abs_available.height,
    )
    let mut max_width = resolve_optional_dimension(
      child.style.max_size.width,
      abs_available.width,
    )
    let mut max_height = resolve_optional_dimension(
      child.style.max_size.height,
      abs_available.height,
    )
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (min_width, min_height) {
            (None, Some(h)) => min_width = Some((h * ratio).round())
            (Some(w), None) => min_height = Some((w / ratio).round())
            _ => ()
          }
          match (max_width, max_height) {
            (None, Some(h)) => max_width = Some((h * ratio).round())
            (Some(w), None) => max_height = Some((w / ratio).round())
            _ => ()
          }
        } else {
          ()
        }
      None => ()
    }

    // First pass: determine intrinsic size under the containing block constraints, if needed.
    let intrinsic = match (used_width, used_height) {
      (Some(w), Some(h)) => Size::new(width=w, height=h)
      _ => {
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=None, height=None),
          abs_available,
          Point::zero(),
          measure_function,
          false,
        )
        tree.nodes[child_id].layout.size
      }
    }
    let final_width = match used_width {
      Some(w) => w
      None => intrinsic.width
    }
    let final_height = match used_height {
      Some(h) => h
      None => intrinsic.height
    }
    let mut clamped_final_width = final_width
    let mut clamped_final_height = final_height
    match min_width {
      Some(m) => clamped_final_width = max_double(clamped_final_width, m)
      None => ()
    }
    match max_width {
      Some(m) =>
        if clamped_final_width > m {
          clamped_final_width = m
        } else {
          ()
        }
      None => ()
    }
    match min_height {
      Some(m) => clamped_final_height = max_double(clamped_final_height, m)
      None => ()
    }
    match max_height {
      Some(m) =>
        if clamped_final_height > m {
          clamped_final_height = m
        } else {
          ()
        }
      None => ()
    }

    // Second pass: compute final size (may be clamped by min/max).
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(
        width=Some(clamped_final_width),
        height=Some(clamped_final_height),
      ),
      abs_available,
      Point::zero(),
      measure_function,
      false,
    )
    let final_size = tree.nodes[child_id].layout.size
    let mut final_margin_left = if margin_left_auto {
      0.0
    } else {
      margin_left_fixed
    }
    let mut final_margin_right = if margin_right_auto {
      0.0
    } else {
      margin_right_fixed
    }
    let mut final_margin_top = if margin_top_auto {
      0.0
    } else {
      margin_top_fixed
    }
    let mut final_margin_bottom = if margin_bottom_auto {
      0.0
    } else {
      margin_bottom_fixed
    }

    // Absolute auto margins: distribute remaining space when both inset sides are definite.
    match (left, right) {
      (Some(l), Some(r)) => {
        let fixed = (if margin_left_auto { 0.0 } else { final_margin_left }) +
          (if margin_right_auto { 0.0 } else { final_margin_right })
        let remaining = final_padding_box_width -
          l -
          r -
          final_size.width -
          fixed
        let auto_count = (if margin_left_auto { 1 } else { 0 }) +
          (if margin_right_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_left = remaining / 2.0
              final_margin_right = remaining / 2.0
            } else {
              final_margin_left = 0.0
              final_margin_right = 0.0
            }
          1 =>
            if margin_left_auto {
              final_margin_left = remaining
            } else {
              final_margin_right = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }
    match (top, bottom) {
      (Some(t), Some(b)) => {
        let fixed = (if margin_top_auto { 0.0 } else { final_margin_top }) +
          (if margin_bottom_auto { 0.0 } else { final_margin_bottom })
        let remaining = final_padding_box_height -
          t -
          b -
          final_size.height -
          fixed
        let auto_count = (if margin_top_auto { 1 } else { 0 }) +
          (if margin_bottom_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_top = remaining / 2.0
              final_margin_bottom = remaining / 2.0
            } else {
              final_margin_top = 0.0
              final_margin_bottom = 0.0
            }
          1 =>
            if margin_top_auto {
              final_margin_top = remaining
            } else {
              final_margin_bottom = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }
    let x_in_padding = match left {
      Some(v) => v + final_margin_left
      None =>
        match right {
          Some(v) =>
            final_padding_box_width - v - final_margin_right - final_size.width
          None => padding.left + final_margin_left
        }
    }
    let y_in_padding = match top {
      Some(v) => v + final_margin_top
      None =>
        match bottom {
          Some(v) =>
            final_padding_box_height -
            v -
            final_margin_bottom -
            final_size.height
          None => padding.top + static_y + final_margin_top
        }
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=Some(final_size.width), height=Some(final_size.height)),
      abs_available,
      Point::new(
        x=padding_origin.x + x_in_padding,
        y=padding_origin.y + y_in_padding,
      ),
      measure_function,
      false,
    )
  }
  let effective_margin_top = if collapse_top_with_child {
    let first_id = match first_in_flow_child {
      Some(v) => v
      None => node_id
    }
    collapse_state_value(
      collapse_state_add(
        collapse_state_add((0.0, 0.0), own_margin_top),
        tree.nodes[first_id].effective_margin_top,
      ),
    )
  } else {
    own_margin_top
  }
  let effective_margin_bottom = if collapse_bottom_with_child {
    let last_id = match last_in_flow_child {
      Some(v) => v
      None => node_id
    }
    collapse_state_value(
      collapse_state_add(
        collapse_state_add((0.0, 0.0), own_margin_bottom),
        tree.nodes[last_id].effective_margin_bottom,
      ),
    )
  } else {
    own_margin_bottom
  }
  tree.nodes[node_id].effective_margin_top = effective_margin_top
  tree.nodes[node_id].effective_margin_bottom = effective_margin_bottom
}

///|
fn[C] baseline_offset_y(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Double raise TaffyError {
  let node = match tree.nodes.get(node_id) {
    Some(n) => n
    None => raise InvalidNodeId(node_id)
  }
  let node_layout = node.layout
  match node.style.display {
    DisplayBlock | DisplayGrid => node_layout.size.height
    _ =>
      if node.children.length() == 0 {
        node_layout.size.height
      } else {
        for child_id in node.children {
          let child = match tree.nodes.get(child_id) {
            Some(c) => c
            None => raise InvalidNodeId(child_id)
          }
          match child.style.display {
            DisplayNone => ()
            _ =>
              match child.style.position {
                PosAbsolute => ()
                PosRelative => {
                  let child_layout = child.layout
                  return child_layout.location.y -
                    node_layout.location.y +
                    baseline_offset_y(tree, child_id)
                }
              }
          }
        }
        node_layout.size.height
      }
  }
}

///|
fn[C] compute_flex_layout_with_measure(
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
  let padding = resolve_rect_width_basis(node.style.padding, available_space)
  let border = resolve_rect_width_basis(node.style.border, available_space)
  let horiz_inset = padding.left + padding.right + border.left + border.right
  let vert_inset = padding.top + padding.bottom + border.top + border.bottom
  let is_col = is_column(node.style.flex_direction)
  let style_width = resolve_optional_dimension(
    node.style.size.width,
    available_space.width,
  )
  let style_height = resolve_optional_dimension(
    node.style.size.height,
    available_space.height,
  )
  let specified_width = match known_dimensions.width {
    Some(w) => Some(w)
    None => style_width
  }
  let specified_height = match known_dimensions.height {
    Some(h) => Some(h)
    None => style_height
  }
  let width_def_for_percent = known_dimensions.width is Some(_) ||
    style_width is Some(_)
  let height_def_for_percent = known_dimensions.height is Some(_) ||
    style_height is Some(_)
  let tentative_border_box_width = match specified_width {
    Some(w) => max_double(w, horiz_inset)
    None => horiz_inset
  }
  let tentative_border_box_height = match specified_height {
    Some(h) => max_double(h, vert_inset)
    None => vert_inset
  }
  let tentative_content_width = max_double(
    tentative_border_box_width - horiz_inset,
    0.0,
  )
  let tentative_content_height = max_double(
    tentative_border_box_height - vert_inset,
    0.0,
  )
  let parent_available_for_children = Size::new(
    width=resolve_available_for_percent(
      width_def_for_percent, tentative_content_width,
    ),
    height=resolve_available_for_percent(
      height_def_for_percent, tentative_content_height,
    ),
  )
  let flow_children : Array[NodeId] = []
  let abs_children : Array[NodeId] = []
  let hidden_children : Array[NodeId] = []
  for child_id in node.children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    match child.style.display {
      DisplayNone => hidden_children.push(child_id)
      _ =>
        match child.style.position {
          PosAbsolute => abs_children.push(child_id)
          PosRelative => flow_children.push(child_id)
        }
    }
  }
  let flow_count = flow_children.length()
  let default_align_items = match node.style.align_items {
    Some(v) => v
    None => ItemsStretch
  }
  let base_sizes : Array[Size[Double]] = Array::make(flow_count, Size::zero())
  let cross_is_auto : Array[Bool] = Array::make(flow_count, true)
  let flex_grow : Array[Double] = Array::make(flow_count, 0.0)
  let flex_shrink : Array[Double] = Array::make(flow_count, 1.0)
  let margin_main_start : Array[Double] = Array::make(flow_count, 0.0)
  let margin_main_end : Array[Double] = Array::make(flow_count, 0.0)
  let margin_cross_start : Array[Double] = Array::make(flow_count, 0.0)
  let margin_cross_end : Array[Double] = Array::make(flow_count, 0.0)
  let align_for_flow : Array[AlignItems] = Array::make(
    flow_count, default_align_items,
  )
  let baseline_offsets : Array[Double] = Array::make(flow_count, 0.0)
  let base_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let min_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
  let max_main_sizes : Array[Double?] = Array::make(flow_count, None)
  let mut total_base_main = 0.0
  let mut total_base_margin_main = 0.0
  let mut max_cross = 0.0
  let main_available_pre = if is_col {
    parent_available_for_children.height
  } else {
    parent_available_for_children.width
  }
  let cross_available_pre = if is_col {
    parent_available_for_children.width
  } else {
    parent_available_for_children.height
  }
  let gap_main_pre = resolve_gap_main(
    node.style.gap,
    is_col,
    main_available_pre,
  )
  let gap_cross_pre = resolve_gap_cross(
    node.style.gap,
    is_col,
    cross_available_pre,
  )
  let total_gap_main_pre = if flow_count > 1 {
    gap_main_pre * (flow_count - 1).to_double()
  } else {
    0.0
  }
  let total_gap_cross_pre = if flow_count > 1 {
    gap_cross_pre * (flow_count - 1).to_double()
  } else {
    0.0
  }
  let intrinsic_available_for_children = if is_col {
    Size::new(width=parent_available_for_children.width, height=AvailMaxContent)
  } else {
    Size::new(
      width=AvailMaxContent,
      height=parent_available_for_children.height,
    )
  }
  for i in 0..<flow_count {
    let child_id = flow_children[i]
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let align = match child.style.align_self {
      Some(v) => v
      None => default_align_items
    }
    align_for_flow[i] = align
    let resolved_margin = resolve_rect_width_basis(
      child.style.margin,
      parent_available_for_children,
    )
    let main_margin_start = if is_col {
      resolved_margin.top
    } else {
      resolved_margin.left
    }
    let main_margin_end = if is_col {
      resolved_margin.bottom
    } else {
      resolved_margin.right
    }
    let cross_margin_start = if is_col {
      resolved_margin.left
    } else {
      resolved_margin.top
    }
    let cross_margin_end = if is_col {
      resolved_margin.right
    } else {
      resolved_margin.bottom
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      intrinsic_available_for_children,
      Point::zero(),
      measure_function,
      false,
    )
    let child_layout = tree.layout(child_id)
    let main_axis_available = main_available_pre
    let cross_axis_available = cross_available_pre
    let basis = resolve_optional_dimension(
      child.style.flex_basis,
      main_axis_available,
    )
    let main_from_size = if is_col {
      resolve_optional_dimension(child.style.size.height, main_axis_available)
    } else {
      resolve_optional_dimension(child.style.size.width, main_axis_available)
    }
    let max_from_style = if is_col {
      resolve_optional_dimension(
        child.style.max_size.height,
        main_axis_available,
      )
    } else {
      resolve_optional_dimension(
        child.style.max_size.width,
        main_axis_available,
      )
    }
    let main = match basis {
      Some(v) => v
      None =>
        match main_from_size {
          Some(v) => v
          None =>
            if is_col {
              child_layout.size.height
            } else {
              child_layout.size.width
            }
        }
    }
    base_main_sizes[i] = main
    max_main_sizes[i] = max_from_style
    let cross_from_size = if is_col {
      resolve_optional_dimension(child.style.size.width, cross_axis_available)
    } else {
      resolve_optional_dimension(child.style.size.height, cross_axis_available)
    }
    let cross = match cross_from_size {
      Some(v) => v
      None =>
        if is_col {
          child_layout.size.width
        } else {
          child_layout.size.height
        }
    }
    base_sizes[i] = make_size_from_main_cross(main, cross, is_col)
    cross_is_auto[i] = match cross_from_size {
      Some(_) => false
      None => true
    }
    flex_grow[i] = child.style.flex_grow
    flex_shrink[i] = child.style.flex_shrink
    margin_main_start[i] = main_margin_start
    margin_main_end[i] = main_margin_end
    margin_cross_start[i] = cross_margin_start
    margin_cross_end[i] = cross_margin_end
    total_base_main = total_base_main + main
    total_base_margin_main = total_base_margin_main +
      main_margin_start +
      main_margin_end
    max_cross = max_double(
      max_cross,
      cross + cross_margin_start + cross_margin_end,
    )
    if !is_col {
      match align {
        ItemsBaseline => baseline_offsets[i] = baseline_offset_y(tree, child_id)
        _ => ()
      }
    }
    let min_from_style = if is_col {
      resolve_optional_dimension(
        child.style.min_size.height,
        main_axis_available,
      )
    } else {
      resolve_optional_dimension(
        child.style.min_size.width,
        main_axis_available,
      )
    }
    let overflow_main = if is_col {
      child.style.overflow.y
    } else {
      child.style.overflow.x
    }
    let min_from_style = match min_from_style {
      Some(v) => Some(v)
      None =>
        match overflow_main {
          OverflowVisible => None
          _ => Some(0.0)
        }
    }
    let resolved_min_main = match min_from_style {
      Some(v) => v
      None => {
        let original_style = tree.nodes[child_id].style
        let original_layout = tree.nodes[child_id].layout
        let cleared_size = if is_col {
          Size::new(width=original_style.size.width, height=DimAuto)
        } else {
          Size::new(width=DimAuto, height=original_style.size.height)
        }
        tree.nodes[child_id].style = { ..original_style, size: cleared_size }
        let min_content_space = if is_col {
          Size::new(
            width=parent_available_for_children.width,
            height=AvailMinContent,
          )
        } else {
          Size::new(
            width=AvailMinContent,
            height=parent_available_for_children.height,
          )
        }
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=None, height=None),
          min_content_space,
          Point::zero(),
          measure_function,
          false,
        )
        let min_layout = tree.layout(child_id)
        let min_content_main = if is_col {
          min_layout.size.height
        } else {
          min_layout.size.width
        }
        tree.nodes[child_id].style = original_style
        tree.nodes[child_id].layout = original_layout
        let mut clamped = min_content_main
        match main_from_size {
          Some(v) => clamped = min_double(clamped, v)
          None => ()
        }
        match max_from_style {
          Some(v) => clamped = min_double(clamped, v)
          None => ()
        }
        let resolved_padding = resolve_rect_width_basis(
          original_style.padding,
          parent_available_for_children,
        )
        let resolved_border = resolve_rect_width_basis(
          original_style.border,
          parent_available_for_children,
        )
        let padding_main_sum = if is_col {
          resolved_padding.top + resolved_padding.bottom
        } else {
          resolved_padding.left + resolved_padding.right
        }
        let border_main_sum = if is_col {
          resolved_border.top + resolved_border.bottom
        } else {
          resolved_border.left + resolved_border.right
        }
        max_double(clamped, padding_main_sum + border_main_sum)
      }
    }
    min_main_sizes[i] = max_double(resolved_min_main, 0.0)
  }
  if !is_col {
    let mut baseline_before_max = 0.0
    let mut baseline_after_max = 0.0
    for i in 0..<flow_count {
      match align_for_flow[i] {
        ItemsBaseline => {
          let cross = get_cross(base_sizes[i], is_col)
          let baseline = baseline_offsets[i]
          let after_inner = cross - baseline
          let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
          let before = margin_cross_start[i] + baseline
          let after = margin_cross_end[i] + after_inner
          baseline_before_max = max_double(baseline_before_max, before)
          baseline_after_max = max_double(baseline_after_max, after)
        }
        _ => ()
      }
    }
    max_cross = max_double(max_cross, baseline_before_max + baseline_after_max)
  }
  let total_base_outer_main = total_base_main + total_base_margin_main

  // Container sizing (border-box)
  let raw_width = match specified_width {
    Some(w) => max_double(w, horiz_inset)
    None =>
      if is_col {
        max_double(max_cross + total_gap_cross_pre + horiz_inset, horiz_inset)
      } else {
        max_double(
          total_base_outer_main + total_gap_main_pre + horiz_inset,
          horiz_inset,
        )
      }
  }
  let raw_height = match specified_height {
    Some(h) => max_double(h, vert_inset)
    None =>
      if is_col {
        max_double(
          total_base_outer_main + total_gap_main_pre + vert_inset,
          vert_inset,
        )
      } else {
        max_double(max_cross + total_gap_cross_pre + vert_inset, vert_inset)
      }
  }
  let mut border_box_width = clamp_dimension(
    raw_width,
    node.style.min_size.width,
    node.style.max_size.width,
    available_space.width,
  )
  let mut border_box_height = clamp_dimension(
    raw_height,
    node.style.min_size.height,
    node.style.max_size.height,
    available_space.height,
  )
  tree.nodes[node_id].layout = Layout::{
    location: absolute_origin,
    size: Size::new(width=border_box_width, height=border_box_height),
  }
  let mut content_width = max_double(border_box_width - horiz_inset, 0.0)
  let mut content_height = max_double(border_box_height - vert_inset, 0.0)

  // Resolve gaps again now that the container's content size is known
  let main_available_final = if is_col {
    resolve_available_for_percent(height_def_for_percent, content_height)
  } else {
    resolve_available_for_percent(width_def_for_percent, content_width)
  }
  let cross_available_final = if is_col {
    resolve_available_for_percent(width_def_for_percent, content_width)
  } else {
    resolve_available_for_percent(height_def_for_percent, content_height)
  }
  let gap_main = resolve_gap_main(node.style.gap, is_col, main_available_final)
  let gap_cross = resolve_gap_cross(
    node.style.gap,
    is_col,
    cross_available_final,
  )
  let justify = match node.style.justify_content {
    Some(j) => j
    None => AlignFlexStart
  }
  let is_reverse = match node.style.flex_direction {
    FlexRowReverse | FlexColumnReverse => true
    _ => false
  }
  let base_x = absolute_origin.x + border.left + padding.left
  let base_y = absolute_origin.y + border.top + padding.top
  let mut container_main = if is_col { content_height } else { content_width }
  let mut container_cross = if is_col { content_width } else { content_height }
  let is_wrap = match node.style.flex_wrap {
    FlexNoWrap => false
    _ => true
  }
  let main_is_definite = if is_col {
    specified_height is Some(_)
  } else {
    specified_width is Some(_)
  }
  let cross_is_auto_container = if is_col {
    specified_width is None
  } else {
    specified_height is None
  }
  if is_wrap && main_is_definite && flow_count > 0 {
    // Build flex lines (single pass, simplified).
    let lines : Array[Array[Int]] = []
    let line_crosses : Array[Double] = []
    let line_baseline_befores : Array[Double] = []
    let mut current_line : Array[Int] = []
    let mut current_outer_main = 0.0
    let mut current_cross = 0.0
    let mut current_baseline_before = 0.0
    let mut current_baseline_after = 0.0
    for i in 0..<flow_count {
      let main = get_main(base_sizes[i], is_col)
      let cross = get_cross(base_sizes[i], is_col)
      let outer_main = margin_main_start[i] + main + margin_main_end[i]
      let outer_cross = margin_cross_start[i] + cross + margin_cross_end[i]
      let mut item_before = 0.0
      let mut item_after = 0.0
      if !is_col {
        match align_for_flow[i] {
          ItemsBaseline => {
            let baseline = baseline_offsets[i]
            let after_inner = cross - baseline
            let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
            item_before = margin_cross_start[i] + baseline
            item_after = margin_cross_end[i] + after_inner
          }
          _ => ()
        }
      }
      if current_line.length() == 0 {
        current_line.push(i)
        current_outer_main = outer_main
        current_cross = outer_cross
        current_baseline_before = item_before
        current_baseline_after = item_after
        current_cross = max_double(
          current_cross,
          current_baseline_before + current_baseline_after,
        )
      } else {
        let tentative = current_outer_main + gap_main + outer_main
        if tentative > container_main {
          lines.push(current_line)
          line_crosses.push(current_cross)
          line_baseline_befores.push(current_baseline_before)
          current_line = []
          current_line.push(i)
          current_outer_main = outer_main
          current_cross = outer_cross
          current_baseline_before = item_before
          current_baseline_after = item_after
          current_cross = max_double(
            current_cross,
            current_baseline_before + current_baseline_after,
          )
        } else {
          current_line.push(i)
          current_outer_main = tentative
          current_cross = max_double(current_cross, outer_cross)
          current_baseline_before = max_double(
            current_baseline_before, item_before,
          )
          current_baseline_after = max_double(
            current_baseline_after, item_after,
          )
          current_cross = max_double(
            current_cross,
            current_baseline_before + current_baseline_after,
          )
        }
      }
    }
    if current_line.length() > 0 {
      lines.push(current_line)
      line_crosses.push(current_cross)
      line_baseline_befores.push(current_baseline_before)
    }
    let line_count = lines.length()
    let mut total_lines_cross = 0.0
    for c in line_crosses {
      total_lines_cross = total_lines_cross + c
    }
    let total_cross_gaps = if line_count > 1 {
      gap_cross * (line_count - 1).to_double()
    } else {
      0.0
    }
    total_lines_cross = total_lines_cross + total_cross_gaps

    // If the container's cross size is auto, compute it from wrapped line sizes.
    if cross_is_auto_container {
      if is_col {
        border_box_width = clamp_dimension(
          max_double(total_lines_cross + horiz_inset, horiz_inset),
          node.style.min_size.width,
          node.style.max_size.width,
          available_space.width,
        )
        content_width = max_double(border_box_width - horiz_inset, 0.0)
      } else {
        border_box_height = clamp_dimension(
          max_double(total_lines_cross + vert_inset, vert_inset),
          node.style.min_size.height,
          node.style.max_size.height,
          available_space.height,
        )
        content_height = max_double(border_box_height - vert_inset, 0.0)
      }
      tree.nodes[node_id].layout = Layout::{
        location: absolute_origin,
        size: Size::new(width=border_box_width, height=border_box_height),
      }
      container_main = if is_col { content_height } else { content_width }
      container_cross = if is_col { content_width } else { content_height }
    }
    let align_content = match node.style.align_content {
      Some(v) => v
      None => AlignStretch
    }
    let leftover_cross = container_cross - total_lines_cross
    let leftover_cross = if leftover_cross > 0.0 { leftover_cross } else { 0.0 }
    let extra_per_line = match align_content {
      AlignStretch =>
        if line_count > 0 {
          leftover_cross / line_count.to_double()
        } else {
          0.0
        }
      _ => 0.0
    }
    let mut start_cross = 0.0
    let mut extra_gap_cross = 0.0
    match align_content {
      AlignStretch => ()
      AlignCenter => start_cross = leftover_cross / 2.0
      AlignFlexEnd | AlignEnd => start_cross = leftover_cross
      AlignSpaceBetween =>
        if line_count > 1 {
          extra_gap_cross = leftover_cross / (line_count - 1).to_double()
        }
      AlignSpaceAround =>
        if line_count > 0 {
          extra_gap_cross = leftover_cross / line_count.to_double()
          start_cross = extra_gap_cross / 2.0
        }
      AlignSpaceEvenly =>
        if line_count > 0 {
          extra_gap_cross = leftover_cross / (line_count + 1).to_double()
          start_cross = extra_gap_cross
        }
      _ => ()
    }
    let line_cross_sizes : Array[Double] = Array::make(line_count, 0.0)
    for li in 0..<line_count {
      line_cross_sizes[li] = line_crosses[li] + extra_per_line
    }
    let line_offsets : Array[Double] = Array::make(line_count, 0.0)
    let mut cross_cursor = start_cross
    for li in 0..<line_count {
      line_offsets[li] = cross_cursor
      cross_cursor = cross_cursor +
        line_cross_sizes[li] +
        gap_cross +
        extra_gap_cross
    }
    let child_available_for_final = Size::new(
      width=resolve_available_for_percent(width_def_for_percent, content_width),
      height=resolve_available_for_percent(
        height_def_for_percent, content_height,
      ),
    )
    for li in 0..<line_count {
      let indices = lines[li]
      let count = indices.length()
      let line_cross = line_cross_sizes[li]
      let line_offset = line_offsets[li]
      let baseline_before_max = line_baseline_befores[li]
      let mut line_used = 0.0
      for idx in indices {
        let main = get_main(base_sizes[idx], is_col)
        line_used = line_used +
          margin_main_start[idx] +
          main +
          margin_main_end[idx]
      }
      if count > 1 {
        line_used = line_used + gap_main * (count - 1).to_double()
      }
      let line_leftover = container_main - line_used
      let line_leftover = if line_leftover > 0.0 { line_leftover } else { 0.0 }
      let mut extra_between = 0.0
      let start_main = match justify {
        AlignCenter => line_leftover / 2.0
        AlignFlexEnd | AlignEnd => line_leftover
        AlignSpaceBetween =>
          if count > 1 {
            extra_between = line_leftover / (count - 1).to_double()
            0.0
          } else {
            0.0
          }
        AlignSpaceAround =>
          if count > 0 {
            extra_between = line_leftover / count.to_double()
            extra_between / 2.0
          } else {
            0.0
          }
        AlignSpaceEvenly =>
          if count > 0 {
            extra_between = line_leftover / (count + 1).to_double()
            extra_between
          } else {
            0.0
          }
        _ => 0.0
      }
      let actual_gap_main = gap_main + extra_between
      let mut main_cursor = if is_reverse {
        container_main - start_main
      } else {
        start_main
      }
      for idx in indices {
        let child_id = flow_children[idx]
        let child = match tree.nodes.get(child_id) {
          Some(c) => c
          None => raise InvalidNodeId(child_id)
        }
        let main_size = get_main(base_sizes[idx], is_col)
        let align = match child.style.align_self {
          Some(v) => v
          None =>
            match node.style.align_items {
              Some(v) => v
              None => ItemsStretch
            }
        }
        let intrinsic_cross = get_cross(base_sizes[idx], is_col)
        let available_cross_for_item = max_double(
          line_cross - margin_cross_start[idx] - margin_cross_end[idx],
          0.0,
        )
        let cross_size = match align {
          ItemsStretch =>
            if cross_is_auto[idx] {
              available_cross_for_item
            } else {
              intrinsic_cross
            }
          _ => intrinsic_cross
        }
        let cross_pos_in_available = match align {
          ItemsBaseline =>
            if !is_col {
              baseline_before_max -
              margin_cross_start[idx] -
              baseline_offsets[idx]
            } else {
              0.0
            }
          ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
          ItemsCenter => (available_cross_for_item - cross_size) / 2.0
          _ => 0.0
        }
        let cross_offset = line_offset +
          margin_cross_start[idx] +
          cross_pos_in_available
        let main_pos = if is_reverse {
          main_cursor = main_cursor - margin_main_end[idx] - main_size
          let pos = main_cursor + margin_main_start[idx]
          main_cursor = main_cursor - margin_main_start[idx] - actual_gap_main
          pos
        } else {
          let pos = main_cursor + margin_main_start[idx]
          main_cursor = main_cursor +
            margin_main_start[idx] +
            main_size +
            margin_main_end[idx] +
            actual_gap_main
          pos
        }
        let child_size = make_size_from_main_cross(
          main_size, cross_size, is_col,
        )
        let child_origin = if is_col {
          Point::new(x=base_x + cross_offset, y=base_y + main_pos)
        } else {
          Point::new(x=base_x + main_pos, y=base_y + cross_offset)
        }
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(
            width=Some(child_size.width),
            height=Some(child_size.height),
          ),
          child_available_for_final,
          child_origin,
          measure_function,
          false,
        )
      }
    }
  } else {
    // Single-line flex layout
    let total_gap_main = if flow_count > 1 {
      gap_main * (flow_count - 1).to_double()
    } else {
      0.0
    }

    // Flex grow/shrink (single-line, simplified)
    let final_main_sizes : Array[Double] = Array::make(flow_count, 0.0)
    let frozen : Array[Bool] = Array::make(flow_count, false)
    let violations : Array[Double] = Array::make(flow_count, 0.0)
    for i in 0..<flow_count {
      final_main_sizes[i] = base_main_sizes[i]
    }
    while true {
      let mut all_frozen = true
      for i in 0..<flow_count {
        if !frozen[i] {
          all_frozen = false
        }
      }
      if all_frozen {
        break
      }
      let mut used = total_gap_main
      for i in 0..<flow_count {
        used = used +
          margin_main_start[i] +
          margin_main_end[i] +
          (if frozen[i] { final_main_sizes[i] } else { base_main_sizes[i] })
      }
      let free_space = container_main - used
      let mut sum_grow = 0.0
      let mut sum_shrink = 0.0
      let mut sum_scaled_shrink = 0.0
      for i in 0..<flow_count {
        if !frozen[i] {
          sum_grow = sum_grow + flex_grow[i]
          sum_shrink = sum_shrink + flex_shrink[i]
          sum_scaled_shrink = sum_scaled_shrink +
            base_main_sizes[i] * flex_shrink[i]
        }
      }
      for i in 0..<flow_count {
        if !frozen[i] {
          let base_main = base_main_sizes[i]
          if free_space > 0.0 && sum_grow > 0.0 {
            final_main_sizes[i] = base_main +
              free_space * (flex_grow[i] / sum_grow)
          } else if free_space < 0.0 &&
            sum_shrink > 0.0 &&
            sum_scaled_shrink > 0.0 {
            let scaled = base_main * flex_shrink[i]
            final_main_sizes[i] = base_main +
              free_space * (scaled / sum_scaled_shrink)
          } else {
            final_main_sizes[i] = base_main
          }
        }
      }
      let mut total_violation = 0.0
      for i in 0..<flow_count {
        if !frozen[i] {
          let unclamped = final_main_sizes[i]
          let min_main = min_main_sizes[i]
          let max_main = max_main_sizes[i]
          let mut clamped = unclamped
          if clamped < min_main {
            clamped = min_main
          }
          match max_main {
            Some(v) => if clamped > v { clamped = v }
            None => ()
          }
          if clamped < 0.0 {
            clamped = 0.0
          }
          violations[i] = clamped - unclamped
          final_main_sizes[i] = clamped
          total_violation = total_violation + violations[i]
        }
      }
      for i in 0..<flow_count {
        if !frozen[i] {
          if total_violation > 0.0 {
            frozen[i] = violations[i] > 0.0
          } else if total_violation < 0.0 {
            frozen[i] = violations[i] < 0.0
          } else {
            frozen[i] = true
          }
        }
      }
    }

    // Justify content (single-line)
    let mut used_main = 0.0
    for i in 0..<flow_count {
      used_main = used_main +
        final_main_sizes[i] +
        margin_main_start[i] +
        margin_main_end[i]
    }
    let leftover = container_main - used_main - total_gap_main
    let leftover = if leftover > 0.0 { leftover } else { 0.0 }
    let mut extra_between = 0.0
    let start_main = match justify {
      AlignCenter => leftover / 2.0
      AlignFlexEnd | AlignEnd => leftover
      AlignSpaceBetween =>
        if flow_count > 1 {
          extra_between = leftover / (flow_count - 1).to_double()
          0.0
        } else {
          0.0
        }
      AlignSpaceAround =>
        if flow_count > 0 {
          extra_between = leftover / flow_count.to_double()
          extra_between / 2.0
        } else {
          0.0
        }
      AlignSpaceEvenly =>
        if flow_count > 0 {
          extra_between = leftover / (flow_count + 1).to_double()
          extra_between
        } else {
          0.0
        }
      _ => 0.0
    }
    let actual_gap_main = gap_main + extra_between
    let child_available_for_final = Size::new(
      width=resolve_available_for_percent(width_def_for_percent, content_width),
      height=resolve_available_for_percent(
        height_def_for_percent, content_height,
      ),
    )
    let mut baseline_before_max = 0.0
    if !is_col {
      let mut baseline_after_max = 0.0
      for i in 0..<flow_count {
        match align_for_flow[i] {
          ItemsBaseline => {
            let cross = get_cross(base_sizes[i], is_col)
            let baseline = baseline_offsets[i]
            let after_inner = cross - baseline
            let after_inner = if after_inner > 0.0 { after_inner } else { 0.0 }
            let before = margin_cross_start[i] + baseline
            let after = margin_cross_end[i] + after_inner
            baseline_before_max = max_double(baseline_before_max, before)
            baseline_after_max = max_double(baseline_after_max, after)
          }
          _ => ()
        }
      }
    }
    let mut cursor = if is_reverse {
      container_main - start_main
    } else {
      start_main
    }
    for i in 0..<flow_count {
      let child_id = flow_children[i]
      let child = match tree.nodes.get(child_id) {
        Some(c) => c
        None => raise InvalidNodeId(child_id)
      }
      let main_size = final_main_sizes[i]
      let align = match child.style.align_self {
        Some(v) => v
        None =>
          match node.style.align_items {
            Some(v) => v
            None => ItemsStretch
          }
      }
      let intrinsic_cross = get_cross(base_sizes[i], is_col)
      let available_cross_for_item = max_double(
        container_cross - margin_cross_start[i] - margin_cross_end[i],
        0.0,
      )
      let cross_size = match align {
        ItemsStretch =>
          if cross_is_auto[i] {
            available_cross_for_item
          } else {
            intrinsic_cross
          }
        _ => intrinsic_cross
      }
      let cross_pos_in_available = match align {
        ItemsBaseline =>
          if !is_col {
            baseline_before_max - margin_cross_start[i] - baseline_offsets[i]
          } else {
            0.0
          }
        ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
        ItemsCenter => (available_cross_for_item - cross_size) / 2.0
        _ => 0.0
      }
      let cross_offset = margin_cross_start[i] + cross_pos_in_available
      let main_pos = if is_reverse {
        cursor = cursor - margin_main_end[i] - main_size
        let pos = cursor + margin_main_start[i]
        cursor = cursor - margin_main_start[i] - actual_gap_main
        pos
      } else {
        let pos = cursor + margin_main_start[i]
        cursor = cursor +
          margin_main_start[i] +
          main_size +
          margin_main_end[i] +
          actual_gap_main
        pos
      }
      let child_size = make_size_from_main_cross(main_size, cross_size, is_col)
      let child_origin = if is_col {
        Point::new(x=base_x + cross_offset, y=base_y + main_pos)
      } else {
        Point::new(x=base_x + main_pos, y=base_y + cross_offset)
      }
      compute_node_layout_with_measure(
        tree,
        child_id,
        Size::new(width=Some(child_size.width), height=Some(child_size.height)),
        child_available_for_final,
        child_origin,
        measure_function,
        false,
      )
    }
  }

  // Absolute positioned children: compute after container size is known, and do not affect flow layout.
  // Follow the same sizing rules as the block layout absolute-positioning pass:
  // inset constraints can determine auto sizes, and aspect-ratio participates in sizing.
  let padding_origin = Point::new(
    x=absolute_origin.x + border.left,
    y=absolute_origin.y + border.top,
  )
  let padding_box_width = max_double(
    border_box_width - border.left - border.right,
    0.0,
  )
  let padding_box_height = max_double(
    border_box_height - border.top - border.bottom,
    0.0,
  )
  let abs_available = Size::new(
    width=AvailDefinite(padding_box_width),
    height=AvailDefinite(padding_box_height),
  )
  for child_id in abs_children {
    let child = match tree.nodes.get(child_id) {
      Some(c) => c
      None => raise InvalidNodeId(child_id)
    }
    let margin = child.style.margin
    // CSS compatibility: margin percentages are resolved against the width.
    let margin_left_auto = margin.left is DimAuto
    let margin_right_auto = margin.right is DimAuto
    let margin_top_auto = margin.top is DimAuto
    let margin_bottom_auto = margin.bottom is DimAuto
    let margin_left_fixed = resolve_dimension_width_basis(
      margin.left,
      padding_box_width,
    )
    let margin_right_fixed = resolve_dimension_width_basis(
      margin.right,
      padding_box_width,
    )
    let margin_top_fixed = resolve_dimension_width_basis(
      margin.top,
      padding_box_width,
    )
    let margin_bottom_fixed = resolve_dimension_width_basis(
      margin.bottom,
      padding_box_width,
    )
    let inset = child.style.inset
    let left = resolve_optional_dimension(inset.left, abs_available.width)
    let right = resolve_optional_dimension(inset.right, abs_available.width)
    let top = resolve_optional_dimension(inset.top, abs_available.height)
    let bottom = resolve_optional_dimension(inset.bottom, abs_available.height)

    // Compute the used size for absolutely positioned items.
    let mut used_width = resolve_optional_dimension(
      child.style.size.width,
      abs_available.width,
    )
    let mut used_height = resolve_optional_dimension(
      child.style.size.height,
      abs_available.height,
    )
    let width_was_auto = used_width is None
    let height_was_auto = used_height is None
    let mut width_from_inset = false
    let mut height_from_inset = false
    // If size is auto and both insets are definite, the size is determined by the inset constraints.
    match used_width {
      Some(_) => ()
      None =>
        match (left, right) {
          (Some(l), Some(r)) =>
            used_width = Some(
              max_double(
                padding_box_width -
                l -
                r -
                margin_left_fixed -
                margin_right_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match used_height {
      Some(_) => ()
      None =>
        match (top, bottom) {
          (Some(t), Some(b)) =>
            used_height = Some(
              max_double(
                padding_box_height -
                t -
                b -
                margin_top_fixed -
                margin_bottom_fixed,
                0.0,
              ),
            )
          _ => ()
        }
    }
    match (used_width, used_height) {
      (Some(_), _) =>
        if width_was_auto {
          match (left, right) {
            (Some(_), Some(_)) => width_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    match (used_width, used_height) {
      (_, Some(_)) =>
        if height_was_auto {
          match (top, bottom) {
            (Some(_), Some(_)) => height_from_inset = true
            _ => ()
          }
        } else {
          ()
        }
      _ => ()
    }
    // Apply aspect ratio when only one axis is known.
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (used_width, used_height) {
            (Some(w), None) => used_height = Some((w / ratio).round())
            (None, Some(h)) => used_width = Some((h * ratio).round())
            (Some(w), Some(_h)) =>
              if width_was_auto &&
                height_was_auto &&
                width_from_inset &&
                height_from_inset {
                used_height = Some((w / ratio).round())
              } else {
                ()
              }
            _ => ()
          }
        }
      None => ()
    }

    // Apply aspect ratio to min/max constraints (taffy 0.5 behavior).
    let mut min_width = resolve_optional_dimension(
      child.style.min_size.width,
      abs_available.width,
    )
    let mut min_height = resolve_optional_dimension(
      child.style.min_size.height,
      abs_available.height,
    )
    let mut max_width = resolve_optional_dimension(
      child.style.max_size.width,
      abs_available.width,
    )
    let mut max_height = resolve_optional_dimension(
      child.style.max_size.height,
      abs_available.height,
    )
    match child.style.aspect_ratio {
      Some(ratio) =>
        if ratio > 0.0 {
          match (min_width, min_height) {
            (None, Some(h)) => min_width = Some((h * ratio).round())
            (Some(w), None) => min_height = Some((w / ratio).round())
            _ => ()
          }
          match (max_width, max_height) {
            (None, Some(h)) => max_width = Some((h * ratio).round())
            (Some(w), None) => max_height = Some((w / ratio).round())
            _ => ()
          }
        } else {
          ()
        }
      None => ()
    }

    // First pass: determine intrinsic size under the containing block constraints, if needed.
    let intrinsic = match (used_width, used_height) {
      (Some(w), Some(h)) => Size::new(width=w, height=h)
      _ => {
        compute_node_layout_with_measure(
          tree,
          child_id,
          Size::new(width=None, height=None),
          abs_available,
          Point::zero(),
          measure_function,
          false,
        )
        tree.nodes[child_id].layout.size
      }
    }
    let final_width = match used_width {
      Some(w) => w
      None => intrinsic.width
    }
    let final_height = match used_height {
      Some(h) => h
      None => intrinsic.height
    }
    let mut clamped_final_width = final_width
    let mut clamped_final_height = final_height
    match min_width {
      Some(m) => clamped_final_width = max_double(clamped_final_width, m)
      None => ()
    }
    match max_width {
      Some(m) =>
        if clamped_final_width > m {
          clamped_final_width = m
        } else {
          ()
        }
      None => ()
    }
    match min_height {
      Some(m) => clamped_final_height = max_double(clamped_final_height, m)
      None => ()
    }
    match max_height {
      Some(m) =>
        if clamped_final_height > m {
          clamped_final_height = m
        } else {
          ()
        }
      None => ()
    }

    // Second pass: compute final size (may be clamped by min/max).
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(
        width=Some(clamped_final_width),
        height=Some(clamped_final_height),
      ),
      abs_available,
      Point::zero(),
      measure_function,
      false,
    )
    let final_size = tree.nodes[child_id].layout.size
    let mut final_margin_left = if margin_left_auto {
      0.0
    } else {
      margin_left_fixed
    }
    let mut final_margin_right = if margin_right_auto {
      0.0
    } else {
      margin_right_fixed
    }
    let mut final_margin_top = if margin_top_auto {
      0.0
    } else {
      margin_top_fixed
    }
    let mut final_margin_bottom = if margin_bottom_auto {
      0.0
    } else {
      margin_bottom_fixed
    }

    // Absolute auto margins: distribute remaining space when both inset sides are definite.
    match (left, right) {
      (Some(l), Some(r)) => {
        let fixed = (if margin_left_auto { 0.0 } else { final_margin_left }) +
          (if margin_right_auto { 0.0 } else { final_margin_right })
        let remaining = padding_box_width - l - r - final_size.width - fixed
        let auto_count = (if margin_left_auto { 1 } else { 0 }) +
          (if margin_right_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_left = remaining / 2.0
              final_margin_right = remaining / 2.0
            } else {
              final_margin_left = 0.0
              final_margin_right = 0.0
            }
          1 =>
            if margin_left_auto {
              final_margin_left = remaining
            } else {
              final_margin_right = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }
    match (top, bottom) {
      (Some(t), Some(b)) => {
        let fixed = (if margin_top_auto { 0.0 } else { final_margin_top }) +
          (if margin_bottom_auto { 0.0 } else { final_margin_bottom })
        let remaining = padding_box_height - t - b - final_size.height - fixed
        let auto_count = (if margin_top_auto { 1 } else { 0 }) +
          (if margin_bottom_auto { 1 } else { 0 })
        match auto_count {
          2 =>
            if remaining >= 0.0 {
              final_margin_top = remaining / 2.0
              final_margin_bottom = remaining / 2.0
            } else {
              final_margin_top = 0.0
              final_margin_bottom = 0.0
            }
          1 =>
            if margin_top_auto {
              final_margin_top = remaining
            } else {
              final_margin_bottom = remaining
            }
          _ => ()
        }
      }
      _ => ()
    }

    // Static position fallback when no inset is specified on an axis.
    let main_margin_start = if is_col {
      final_margin_top
    } else {
      final_margin_left
    }
    let main_margin_end = if is_col {
      final_margin_bottom
    } else {
      final_margin_right
    }
    let cross_margin_start = if is_col {
      final_margin_left
    } else {
      final_margin_top
    }
    let cross_margin_end = if is_col {
      final_margin_right
    } else {
      final_margin_bottom
    }
    let main_size = if is_col { final_size.height } else { final_size.width }
    let cross_size = if is_col { final_size.width } else { final_size.height }
    let outer_main = main_margin_start + main_size + main_margin_end
    let leftover_main = container_main - outer_main
    let leftover_main = if leftover_main > 0.0 { leftover_main } else { 0.0 }
    let static_start_main = match justify {
      AlignCenter => leftover_main / 2.0
      AlignFlexEnd | AlignEnd => leftover_main
      _ => 0.0
    }
    let static_main = static_start_main + main_margin_start
    let align = match child.style.align_self {
      Some(v) => v
      None =>
        match node.style.align_items {
          Some(v) => v
          None => ItemsStretch
        }
    }
    let available_cross_for_item = max_double(
      container_cross - cross_margin_start - cross_margin_end,
      0.0,
    )
    let cross_pos_in_available = match align {
      ItemsEnd | ItemsFlexEnd => available_cross_for_item - cross_size
      ItemsCenter => (available_cross_for_item - cross_size) / 2.0
      _ => 0.0
    }
    let static_cross = cross_margin_start + cross_pos_in_available
    let x_in_padding = match left {
      Some(v) => v + final_margin_left
      None =>
        match right {
          Some(v) =>
            padding_box_width - v - final_margin_right - final_size.width
          None =>
            padding.left + (if is_col { static_cross } else { static_main })
        }
    }
    let y_in_padding = match top {
      Some(v) => v + final_margin_top
      None =>
        match bottom {
          Some(v) =>
            padding_box_height - v - final_margin_bottom - final_size.height
          None =>
            padding.top + (if is_col { static_main } else { static_cross })
        }
    }
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=Some(final_size.width), height=Some(final_size.height)),
      abs_available,
      Point::new(
        x=padding_origin.x + x_in_padding,
        y=padding_origin.y + y_in_padding,
      ),
      measure_function,
      false,
    )
  }

  // Ensure `display: none` children get laid out (to zero) as well.
  for child_id in hidden_children {
    compute_node_layout_with_measure(
      tree,
      child_id,
      Size::new(width=None, height=None),
      abs_available,
      Point::new(x=base_x, y=base_y),
      measure_function,
      false,
    )
  }
  let resolved_margin = resolve_rect_width_basis(
    node.style.margin,
    available_space,
  )
  tree.nodes[node_id].effective_margin_top = resolved_margin.top
  tree.nodes[node_id].effective_margin_bottom = resolved_margin.bottom
}
