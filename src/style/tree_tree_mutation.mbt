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
  if !self.nodes[parent].alive {
    raise InvalidNodeId(parent)
  }
  if !self.nodes[child].alive {
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
  if !self.nodes[parent].alive {
    raise InvalidNodeId(parent)
  }
  // Validate nodes and reject cycles.
  for child_id in children {
    match self.nodes.get(child_id) {
      Some(_) => ()
      None => raise InvalidNodeId(child_id)
    }
    if !self.nodes[child_id].alive {
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
  if !self.nodes[parent].alive {
    raise InvalidNodeId(parent)
  }
  if !self.nodes[child].alive {
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
  if !self.nodes[node].alive {
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
  if !self.nodes[node].alive {
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
  if !self.nodes[node].alive {
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
        if !self.nodes[cur].alive {
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
