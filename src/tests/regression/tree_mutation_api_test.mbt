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
test "tree_mutation: set_children updates parent pointers" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let a = chicle.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let parent1 = chicle.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [a],
  )
  let parent2 = chicle.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [],
  )
  let root = chicle.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_row())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [parent1, parent2],
  )
  chicle.compute_layout(root, Size::max_content())
  let before = chicle.layout(a)
  assert_eq(before.location.x, 0.0)
  assert_eq(before.location.y, 0.0)
  chicle.set_children(parent2, [a])
  chicle.compute_layout(root, Size::max_content())
  let after = chicle.layout(a)
  // If the parent pointer wasn't updated, this would be 100.0 (parent2 is to the right of parent1).
  assert_eq(after.location.x, 0.0)
  assert_eq(after.location.y, 0.0)
}

///|
test "tree_mutation: add_child rejects cycles" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let leaf = chicle.new_leaf(Style::default())
  let root = chicle.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    [leaf],
  )
  let err = try chicle.add_child(leaf, root) catch {
    e => Some(e)
  } noraise {
    _ => None
  }
  match err {
    Some(_) => ()
    _ => panic()
  }
}

///|
test "tree_mutation: new_with_children filters duplicate children" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let leaf = chicle.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let root = chicle.new_with_children(
    Style::default().with_size(Size(width=auto(), height=auto())),
    [leaf, leaf],
  )
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.layout(root).size.width, 10.0)
}

///|
test "tree_mutation: set_children rejects duplicate children" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let leaf = chicle.new_leaf(Style::default())
  let root = chicle.new_with_children(Style::default(), [])
  let failed = try chicle.set_children(root, [leaf, leaf]) catch {
    _ => true
  } noraise {
    _ => false
  }
  assert_eq(failed, true)
}

///|
test "tree_mutation: remove_subtree invalidates nodes" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let leaf = chicle.new_leaf(Style::default())
  let parent = chicle.new_with_children(Style::default(), [leaf])
  let root = chicle.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [parent],
  )
  chicle.compute_layout(root, Size::max_content())
  chicle.remove_subtree(parent)
  let layout_failed = try chicle.layout(leaf) catch {
    _ => true
  } noraise {
    _ => false
  }
  assert_eq(layout_failed, true)
}

///|
test "tree_mutation: dirty tracking" {
  let chicle : ChicleTree[Unit] = ChicleTree()
  let leaf = chicle.new_leaf(Style::default())
  let root = chicle.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    [leaf],
  )
  assert_eq(chicle.dirty(root), true)
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.dirty(root), false)
  chicle.mark_dirty(leaf)
  assert_eq(chicle.dirty(root), true)
  chicle.compute_layout(root, Size::max_content())
  assert_eq(chicle.dirty(root), false)
  chicle.set_node_context(leaf, ())
  assert_eq(chicle.dirty(root), true)
}
