import 'dart:async';
import 'package:flutter/material.dart';
import '../ux/widgets/tree_traversals/animated_tree_vis.dart';
import '../models/sort_model.dart';
import '../models/tree_node_model.dart';
import 'base_providers.dart';


abstract class TreeProvider extends BaseProvider {
  late TreeNode root; // ✅ Non-nullable root
  bool _isTraversing = false;
  List<TreeNode> nodes; // ✅ Non-nullable nodes list

  bool get isTraversing => _isTraversing;

  // ✅ Default constructor ensures non-empty nodes list
  TreeProvider(List<TreeNode> initialNodes)
      : nodes = initialNodes.isEmpty ? [TreeNode(-1)] : initialNodes {
    root = buildTree(nodes);
  }

  // ✅ Add TreeNode dynamically
  void addNode(TreeNode node) {
    nodes.add(node);
    root = buildTree(nodes);
    notifyListeners();
  }

  // ✅ Reset tree and ensure nodes list is not empty
  void clearNodes() {
    nodes = [TreeNode(-1)];
    root = nodes.first;
    notifyListeners();
  }

  // ✅ Start traversal
  Future<void> startTraversal() async {
    if (_isTraversing) return;

    _isTraversing = true;
    render();

    try {
      await performTraversal(root);
    } finally {
      _isTraversing = false;
      render();
    }
  }

  @protected
  Future<void> performTraversal(TreeNode node);

  @protected
  Future<void> visitNode(TreeNode node) async {
    node.visit();
    render();
    await pause();
  }

  @protected
  Future<void> completeNode(TreeNode node) async {
    node.visited();
    render();
    await pause();
  }

  @protected
  Future<void> backtrackNode(TreeNode node) async {
    node.backtrack();
    render();
    await pause();
  }


  // ✅ Build tree from List<TreeNode>
  TreeNode buildTree(List<TreeNode> nodes) {
    nodes.sort((a, b) => a.value.compareTo(b.value)); // ✅ Ensure sorted order
    return _buildBST(nodes, 0, nodes.length - 1);
  }

  TreeNode _buildBST(List<TreeNode> nodes, int start, int end) {
    if (start > end) return TreeNode(-1); // ✅ Return a default TreeNode

    int mid = (start + end) ~/ 2;
    TreeNode node = nodes[mid];

    node.left = _buildBST(nodes, start, mid - 1);
    node.right = _buildBST(nodes, mid + 1, end);

    return node;
  }
}
