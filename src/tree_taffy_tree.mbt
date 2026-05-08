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
fn[C] validate_node_alive(
  tree : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(n) => if !n.alive { raise InvalidNodeId(node) }
    None => raise InvalidNodeId(node)
  }
}

///|
fn array_contains_node(children : Array[NodeId], child : NodeId) -> Bool {
  children.search_by(fn(x) { x == child }) is Some(_)
}

///|
fn array_contains_node_before(children : Array[NodeId], child : NodeId) -> Bool {
  let mut seen = false
  for item in children {
    if item == child {
      if seen {
        return true
      }
      seen = true
    }
  }
  false
}

///|
fn[C] reject_child_cycle(
  tree : TaffyTree[C],
  parent : NodeId,
  child : NodeId,
) -> Unit raise TaffyError {
  if parent == child {
    raise CycleDetected(parent~, child~)
  }
  let mut cur = Some(parent)
  while true {
    match cur {
      None => break
      Some(id) =>
        if id == child {
          raise CycleDetected(parent~, child~)
        } else {
          cur = tree.parents[id]
        }
    }
  }
}

///|
fn[C] detach_from_parent(
  tree : TaffyTree[C],
  child : NodeId,
  new_parent : NodeId,
) -> Unit {
  match tree.parents[child] {
    Some(old_parent) =>
      if old_parent != new_parent {
        let old_children = tree.children[old_parent]
        match old_children.search_by(fn(x) { x == child }) {
          Some(idx) => ignore(old_children.remove(idx))
          None => ()
        }
        tree.nodes[old_parent].cache.clear()
      }
    None => ()
  }
}

///|
fn[C] attach_children_unchecked(
  tree : TaffyTree[C],
  parent : NodeId,
  children : Array[NodeId],
) -> Unit {
  let parent_children = tree.children[parent]
  for child in children {
    detach_from_parent(tree, child, parent)
    tree.parents[child] = Some(parent)
    parent_children.push(child)
  }
}

///|
pub fn[C] TaffyTree::add_child(
  tree : TaffyTree[C],
  parent : NodeId,
  child : NodeId,
) -> Unit raise TaffyError {
  validate_node_alive(tree, parent)
  validate_node_alive(tree, child)
  reject_child_cycle(tree, parent, child)
  let parent_children = tree.children[parent]
  if array_contains_node(parent_children, child) {
    return
  }
  detach_from_parent(tree, child, parent)
  tree.parents[child] = Some(parent)
  parent_children.push(child)
  tree.mark_dirty(parent)
}

///|
pub fn[C] TaffyTree::set_children(
  tree : TaffyTree[C],
  parent : NodeId,
  children : Array[NodeId],
) -> Unit raise TaffyError {
  validate_node_alive(tree, parent)
  for child_id in children {
    validate_node_alive(tree, child_id)
    reject_child_cycle(tree, parent, child_id)
    if array_contains_node_before(children, child_id) {
      raise DuplicateChild(parent~, child=child_id)
    }
  }
  let old_children = tree.children[parent]
  for child_id in old_children {
    tree.parents[child_id] = None
  }
  old_children.clear()
  attach_children_unchecked(tree, parent, children)
  tree.mark_dirty(parent)
}

///|
pub fn[C] TaffyTree::remove_child(
  tree : TaffyTree[C],
  parent : NodeId,
  child : NodeId,
) -> NodeId raise TaffyError {
  match tree.nodes.get(parent) {
    Some(_) => ()
    None => raise InvalidNodeId(parent)
  }
  match tree.nodes.get(child) {
    Some(_) => ()
    None => raise InvalidNodeId(child)
  }
  if !tree.nodes[parent].alive {
    raise InvalidNodeId(parent)
  }
  if !tree.nodes[child].alive {
    raise InvalidNodeId(child)
  }
  let siblings = tree.children[parent]
  match siblings.search_by(fn(x) { x == child }) {
    Some(idx) => {
      ignore(siblings.remove(idx))
      tree.parents[child] = None
      tree.mark_dirty(parent)
      child
    }
    None => raise ChildNotFound(parent~, child~)
  }
}

///|
pub fn[C] TaffyTree::mark_dirty(
  tree : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if !tree.nodes[node].alive {
    raise InvalidNodeId(node)
  }
  let mut cur : NodeId? = Some(node)
  while true {
    match cur {
      None => break
      Some(id) => {
        tree.nodes[id].dirty = true
        tree.nodes[id].cache.clear()
        cur = tree.parents[id]
      }
    }
  }
}

///|
pub fn[C] TaffyTree::dirty(
  tree : TaffyTree[C],
  node : NodeId,
) -> Bool raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) =>
      if tree.nodes[node].alive {
        tree.nodes[node].dirty
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::remove(
  tree : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if !tree.nodes[node].alive {
    raise InvalidNodeId(node)
  }
  // Detach from parent.
  let old_parent = tree.parents[node]
  match old_parent {
    Some(parent_id) => {
      let siblings = tree.children[parent_id]
      match siblings.search_by(fn(x) { x == node }) {
        Some(idx) => ignore(siblings.remove(idx))
        None => ()
      }
      tree.parents[node] = None
    }
    None => ()
  }
  // Orphan children.
  let kids = tree.children[node]
  for child_id in kids {
    tree.parents[child_id] = None
  }
  kids.clear()
  tree.nodes[node].alive = false
  match old_parent {
    Some(p) => tree.mark_dirty(p)
    None => ()
  }
}

///|
pub fn[C] TaffyTree::remove_subtree(
  tree : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) => ()
    None => raise InvalidNodeId(node)
  }
  if !tree.nodes[node].alive {
    raise InvalidNodeId(node)
  }
  // Detach root of subtree from its parent.
  let old_parent = tree.parents[node]
  match old_parent {
    Some(parent_id) => {
      let siblings = tree.children[parent_id]
      match siblings.search_by(fn(x) { x == node }) {
        Some(idx) => ignore(siblings.remove(idx))
        None => ()
      }
      tree.parents[node] = None
    }
    None => ()
  }
  let stack : Array[NodeId] = [node]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if !tree.nodes[cur].alive {
          continue
        }
        let kids = tree.children[cur]
        for child_id in kids {
          stack.push(child_id)
        }
        kids.clear()
        tree.parents[cur] = None
        tree.node_context_data[cur] = None
        tree.nodes[cur].cache.clear()
        tree.nodes[cur].unrounded_layout = Layout::zero()
        tree.nodes[cur].alive = false
      }
    }
  }
  match old_parent {
    Some(p) => tree.mark_dirty(p)
    None => ()
  }
}

///|
pub fn[C] TaffyTree::set_node_context(
  tree : TaffyTree[C],
  node : NodeId,
  context : C,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) =>
      if tree.nodes[node].alive {
        tree.node_context_data[node] = Some(context)
        tree.nodes[node].cache.clear()
        tree.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::clear_node_context(
  tree : TaffyTree[C],
  node : NodeId,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) =>
      if tree.nodes[node].alive {
        tree.node_context_data[node] = None
        tree.nodes[node].cache.clear()
        tree.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}

///|
pub fn[C] TaffyTree::set_style(
  tree : TaffyTree[C],
  node : NodeId,
  style : Style,
) -> Unit raise TaffyError {
  match tree.nodes.get(node) {
    Some(_) =>
      if tree.nodes[node].alive {
        tree.nodes[node].style = style
        tree.nodes[node].cache.clear()
        tree.mark_dirty(node)
      } else {
        raise InvalidNodeId(node)
      }
    None => raise InvalidNodeId(node)
  }
}
