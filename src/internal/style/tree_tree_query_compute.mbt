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
pub fn[C] TaffyTree::node_context(
  self : TaffyTree[C],
  node : NodeId,
) -> C? raise TaffyError {
  let node_ref = match self.nodes.get(node) {
    Some(n) => n
    None => raise InvalidNodeId(node)
  }
  if !node_ref.alive {
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
  if !node_ref.alive {
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
      if !parent.alive {
        raise InvalidNodeId(parent_id)
      }
      let parent_layout = parent.layout
      Layout::{
        location: Point(
          x=layout.location.x - parent_layout.location.x,
          y=layout.location.y - parent_layout.location.y,
        ),
        size: layout.size,
      }
    }
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
      if !self.nodes[root].alive {
        raise InvalidNodeId(root)
      } else {
        ()
      }
    None => raise InvalidNodeId(root)
  }
  clear_transient_layout_caches(self)
  compute_node_layout_with_measure(
    self,
    root,
    Size(width=None, height=None),
    available_space,
    Point::zero(),
    measure_function,
    true,
  )
  round_layout_tree_and_mark_clean(self, root)
}

///|
fn[C] clear_transient_layout_caches(tree : TaffyTree[C]) -> Unit {
  for i in 0..<tree.nodes.length() {
    tree.nodes[i].leaf_measure_cache.clear()
    tree.nodes[i].node_layout_cache.clear()
  }
}

///|
fn[C] round_layout_tree_and_mark_clean(
  tree : TaffyTree[C],
  root : NodeId,
) -> Unit {
  let stack : Array[NodeId] = [root]
  while true {
    match stack.pop() {
      None => break
      Some(cur) => {
        if !tree.nodes[cur].alive {
          continue
        }
        let layout = tree.nodes[cur].layout
        let rounded_left = layout.location.x.round()
        let rounded_top = layout.location.y.round()
        let rounded_right = (layout.location.x + layout.size.width).round()
        let rounded_bottom = (layout.location.y + layout.size.height).round()
        tree.nodes[cur].layout = Layout::{
          location: Point(x=rounded_left, y=rounded_top),
          size: Size(
            width=max_double(rounded_right - rounded_left, 0.0),
            height=max_double(rounded_bottom - rounded_top, 0.0),
          ),
        }
        tree.nodes[cur].dirty = false
        for child_id in tree.nodes[cur].children {
          stack.push(child_id)
        }
      }
    }
  }
}
