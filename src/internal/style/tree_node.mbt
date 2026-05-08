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
pub fn[C] TaffyTree::TaffyTree() -> TaffyTree[C] {
  {
    nodes: [],
    children: [],
    parents: [],
    node_context_data: [],
    config: TaffyConfig(),
  }
}

///|
pub fn[C] TaffyTree::with_capacity(_capacity : Int) -> TaffyTree[C] {
  TaffyTree()
}

///|
fn[C] NodeData::new(style : Style, context : C?) -> NodeData {
  ignore(context)
  {
    style,
    unrounded_layout: Layout::zero(),
    final_layout: Layout::zero(),
    first_baselines: Point(x=None, y=None),
    cache: Cache(),
    effective_margin_top: 0.0,
    effective_margin_bottom: 0.0,
    effective_margin_top_max_pos: 0.0,
    effective_margin_top_min_neg: 0.0,
    effective_margin_bottom_max_pos: 0.0,
    effective_margin_bottom_min_neg: 0.0,
    alive: true,
    dirty: true,
  }
}

///|
fn[C] TaffyTree::push_node(
  self : TaffyTree[C],
  style : Style,
  children : Array[NodeId],
  context : C?,
) -> NodeId {
  let id = self.nodes.length()
  self.nodes.append([NodeData::new(style, context)])
  self.children.append([children])
  self.parents.append([None])
  self.node_context_data.append([context])
  id
}

///|
pub fn[C] TaffyTree::new_leaf(self : TaffyTree[C], style : Style) -> NodeId {
  self.push_node(style, [], None)
}

///|
pub fn[C] TaffyTree::new_leaf_with_context(
  self : TaffyTree[C],
  style : Style,
  context : C,
) -> NodeId {
  self.push_node(style, [], Some(context))
}

///|
pub fn[C] TaffyTree::new_with_children(
  self : TaffyTree[C],
  style : Style,
  children : Array[NodeId],
) -> NodeId {
  let attached_children : Array[NodeId] = []
  for child_id in children {
    match self.nodes.get(child_id) {
      Some(child) =>
        if child.alive && !array_contains_node(attached_children, child_id) {
          attached_children.push(child_id)
        }
      None => ()
    }
  }
  let id = self.push_node(style, [], None)
  attach_children_unchecked(self, id, attached_children)
  id
}
