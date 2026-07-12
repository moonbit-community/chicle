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
fn[C] compute_hidden_layout(
  tree : TaffyTree[C],
  node_id : NodeId,
  absolute_origin : Point[Double],
) -> Unit raise TaffyError {
  match tree.nodes.get(node_id) {
    Some(_) => ()
    None => raise InvalidNodeId(node_id)
  }
  tree.nodes[node_id].cache.clear()
  tree.set_unrounded_layout(node_id, {
    ..Layout::zero(),
    location: absolute_origin,
    size: Size::zero(),
  })
  tree.nodes[node_id].effective_margin_top = 0.0
  tree.nodes[node_id].effective_margin_bottom = 0.0
  tree.nodes[node_id].effective_margin_top_max_pos = 0.0
  tree.nodes[node_id].effective_margin_top_min_neg = 0.0
  tree.nodes[node_id].effective_margin_bottom_max_pos = 0.0
  tree.nodes[node_id].effective_margin_bottom_min_neg = 0.0
  for child_id in tree.children[node_id] {
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
  let layout = node.unrounded_layout
  tree.set_unrounded_layout(node_id, {
    ..layout,
    location: { x: layout.location.x + dx, y: layout.location.y + dy },
  })
  for child_id in tree.children[node_id] {
    offset_subtree(tree, child_id, dx, dy)
  }
}

///|
fn[C] subtree_has_measure_context(
  tree : TaffyTree[C],
  node_id : NodeId,
) -> Bool raise TaffyError {
  match tree.nodes.get(node_id) {
    Some(_) => ()
    None => raise InvalidNodeId(node_id)
  }
  if tree.node_context_data[node_id] is Some(_) {
    return true
  }
  for child_id in tree.children[node_id] {
    if subtree_has_measure_context(tree, child_id) {
      return true
    }
  }
  false
}
