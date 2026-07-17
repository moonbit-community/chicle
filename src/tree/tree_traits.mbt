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
fn[C] ChicleTree::unrounded_layout(
  self : ChicleTree[C],
  node : NodeId,
) -> Layout raise ChicleError {
  let node_ref = match self.nodes.get(node) {
    Some(n) => n
    None => raise InvalidNodeId(node)
  }
  if !node_ref.alive {
    raise InvalidNodeId(node)
  }
  let layout = node_ref.unrounded_layout
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
      let parent_layout = parent.unrounded_layout
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
