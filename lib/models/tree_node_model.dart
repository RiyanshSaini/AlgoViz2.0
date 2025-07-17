import 'package:flutter/material.dart';

enum NodeState { idle, visiting, visited, found, backtracking }

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;
  ValueNotifier<NodeState> state = ValueNotifier(NodeState.idle); // Node state tracking

  TreeNode(this.value, {this.left, this.right});

  // ✅ Dynamic color getter
  Color get colors {
    switch (state.value) {
      case NodeState.visiting:
        return Colors.blue;
      case NodeState.visited:
        return Colors.green;
      case NodeState.found:
        return Colors.orange;
      case NodeState.backtracking:
        return Colors.red;
      default:
        return Colors.black54;
    }
  }

  // ✅ Reset node to default state
  void reset() {
    state.value = NodeState.idle;
  }

    // ✅ Node updates (No need to update color manually)
    void visit() => state.value = NodeState.visiting;
    void visited() => state.value = NodeState.visited;
    void backtrack() => state.value = NodeState.backtracking;
    void found() => state.value = NodeState.found;
  }

