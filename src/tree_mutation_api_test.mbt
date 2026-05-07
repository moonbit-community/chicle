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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let a = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let parent1 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [a],
  )
  let parent2 = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_column())
    .with_size(Size(width=length(100.0), height=length(100.0))),
    [],
  )
  let root = taffy.new_with_children(
    Style::default()
    .with_flex_direction(flex_direction_row())
    .with_size(Size(width=length(200.0), height=length(100.0))),
    [parent1, parent2],
  )
  taffy.compute_layout(root, Size::max_content())
  let before = taffy.layout(a)
  assert_eq(before.location.x, 0.0)
  assert_eq(before.location.y, 0.0)
  taffy.set_children(parent2, [a])
  taffy.compute_layout(root, Size::max_content())
  let after = taffy.layout(a)
  // If the parent pointer wasn't updated, this would be 100.0 (parent2 is to the right of parent1).
  assert_eq(after.location.x, 0.0)
  assert_eq(after.location.y, 0.0)
}

///|
test "tree_mutation: add_child rejects cycles" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leaf = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    [leaf],
  )
  let err = try taffy.add_child(leaf, root) catch {
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
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leaf = taffy.new_leaf(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
  )
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=auto(), height=auto())),
    [leaf, leaf],
  )
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.layout(root).size.width, 10.0)
}

///|
test "tree_mutation: set_children rejects duplicate children" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leaf = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(Style::default(), [])
  let failed = try taffy.set_children(root, [leaf, leaf]) catch {
    _ => true
  } noraise {
    _ => false
  }
  assert_eq(failed, true)
}

///|
test "tree_mutation: remove_subtree invalidates nodes" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leaf = taffy.new_leaf(Style::default())
  let parent = taffy.new_with_children(Style::default(), [leaf])
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=length(100.0), height=length(100.0))),
    [parent],
  )
  taffy.compute_layout(root, Size::max_content())
  taffy.remove_subtree(parent)
  let layout_failed = try taffy.layout(leaf) catch {
    _ => true
  } noraise {
    _ => false
  }
  assert_eq(layout_failed, true)
}

///|
test "tree_mutation: dirty tracking" {
  let taffy : TaffyTree[Unit] = TaffyTree()
  let leaf = taffy.new_leaf(Style::default())
  let root = taffy.new_with_children(
    Style::default().with_size(Size(width=length(10.0), height=length(10.0))),
    [leaf],
  )
  assert_eq(taffy.dirty(root), true)
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.dirty(root), false)
  taffy.mark_dirty(leaf)
  assert_eq(taffy.dirty(root), true)
  taffy.compute_layout(root, Size::max_content())
  assert_eq(taffy.dirty(root), false)
  taffy.set_node_context(leaf, ())
  assert_eq(taffy.dirty(root), true)
}
