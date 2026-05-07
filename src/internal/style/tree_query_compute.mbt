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
  self.node_context_data[node]
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
  let layout = node_ref.final_layout
  match self.parents[node] {
    None => layout
    Some(parent_id) => {
      let parent = match self.nodes.get(parent_id) {
        Some(p) => p
        None => raise InvalidNodeId(parent_id)
      }
      if !parent.alive {
        raise InvalidNodeId(parent_id)
      }
      let parent_layout = parent.final_layout
      {
        ..layout,
        location: Point(
          x=layout.location.x - parent_layout.location.x,
          y=layout.location.y - parent_layout.location.y,
        ),
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
pub fn[C] TaffyTree::enable_rounding(self : TaffyTree[C]) -> Unit {
  self.config.use_rounding = true
}

///|
pub fn[C] TaffyTree::disable_rounding(self : TaffyTree[C]) -> Unit {
  self.config.use_rounding = false
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
  let view : TaffyView[C] = { tree: self, measure_function }
  view.compute_root_layout(root, available_space)
}
