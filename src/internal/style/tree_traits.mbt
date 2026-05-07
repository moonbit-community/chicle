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
pub fn[C] TaffyTree::child_ids(
  self : TaffyTree[C],
  parent_node_id : NodeId,
) -> Array[NodeId] raise TaffyError {
  validate_node_alive(self, parent_node_id)
  let result : Array[NodeId] = []
  for child_id in self.nodes[parent_node_id].children {
    result.push(child_id)
  }
  result
}

///|
pub fn[C] TaffyTree::child_count(
  self : TaffyTree[C],
  parent_node_id : NodeId,
) -> Int raise TaffyError {
  validate_node_alive(self, parent_node_id)
  self.nodes[parent_node_id].children.length()
}

///|
pub fn[C] TaffyTree::get_child_id(
  self : TaffyTree[C],
  parent_node_id : NodeId,
  child_index : Int,
) -> NodeId raise TaffyError {
  validate_node_alive(self, parent_node_id)
  match self.nodes[parent_node_id].children.get(child_index) {
    Some(child_id) => child_id
    None => raise ChildNotFound(parent=parent_node_id, child=child_index)
  }
}

///|
pub fn[C] TaffyTree::get_style(
  self : TaffyTree[C],
  node_id : NodeId,
) -> Style raise TaffyError {
  validate_node_alive(self, node_id)
  self.nodes[node_id].style
}

///|
pub fn[C] TaffyTree::set_unrounded_layout(
  self : TaffyTree[C],
  node_id : NodeId,
  layout : Layout,
) -> Unit raise TaffyError {
  validate_node_alive(self, node_id)
  self.nodes[node_id].layout = layout
}

///|
pub fn[C] TaffyTree::get_unrounded_layout(
  self : TaffyTree[C],
  node_id : NodeId,
) -> Layout raise TaffyError {
  validate_node_alive(self, node_id)
  self.nodes[node_id].layout
}

///|
pub fn[C] TaffyTree::set_final_layout(
  self : TaffyTree[C],
  node_id : NodeId,
  layout : Layout,
) -> Unit raise TaffyError {
  self.set_unrounded_layout(node_id, layout)
}

///|
pub fn[C] TaffyTree::get_final_layout(
  self : TaffyTree[C],
  node_id : NodeId,
) -> Layout raise TaffyError {
  self.get_unrounded_layout(node_id)
}
