
import '../../models/tree_node_model.dart';
import '../base_providers.dart';
import '../tree_provider.dart';
 // Import TreeProvider

import '../tree_provider2.dart';
 // Import TreeProvider

class BFSDFSProvider extends BaseProvider implements TreeProvider2 {
  late List<TreeNode> nodes;
  late TreeNode root; // Root of the tree

  BFSDFSProvider() : super() {
    final values = [100, 4, 6, 2, 8, 6, 103, 24, 657, 67];
    root = buildTreeFromList(values)!; // Build the tree
    nodes = _flattenTree(root); // Flatten the tree into a list of nodes
  }

  /// Flattens the tree into a list of nodes (optional, if you need a list of nodes).
  List<TreeNode> _flattenTree(TreeNode root) {
    final List<TreeNode> nodes = [];
    final queue = [root];

    while (queue.isNotEmpty) {
      final currentNode = queue.removeAt(0);
      nodes.add(currentNode);

      if (currentNode.left != null) queue.add(currentNode.left!);
      if (currentNode.right != null) queue.add(currentNode.right!);
    }

    return nodes;
  }

  @override
  Future<void> performTraversal2(TreeNode node, {required bool isBFS}) async {
    if (isBFS) {
      await _performBFS(node);
    } else {
      await _performDFS(node);
    }
  }

  // DFS Implementation
  Future<void> _performDFS(TreeNode? node) async {
    if (node == null) return; // Base case for recursion

    await visitNode(node); // ✅ Highlight the node
    await pause(); // ✅ Wait based on speed slider

    if (node.left != null) {
      print("➡️ Going Left to ${node.left!.value}");
      await _performDFS(node.left!);
    } else {
      print("❌ No Left Child for ${node.value}");
    }

    if (node.right != null) {
      print("➡️ Going Right to ${node.right!.value}");
      await _performDFS(node.right!);
    } else {
      print("❌ No Right Child for ${node.value}");
    }

    print("🔙 Backtracking from: ${node.value}");
  }

  // BFS Implementation
  Future<void> _performBFS(TreeNode root) async {
    final queue = [root]; // Queue for BFS traversal

    while (queue.isNotEmpty) {
      final currentNode = queue.removeAt(0); // Dequeue the first node

      // Visiting the current node
      print("✅ Visiting Node: ${currentNode.value}");
      currentNode.visit(); // Set state to "visiting" (blue)
      render(); // Notify listeners
      await pause(); // Delay for visualization

      // Enqueue left child
      if (currentNode.left != null) {
        print("➡️ Adding Left Child: ${currentNode.left!.value}");
        queue.add(currentNode.left!);
      }

      // Enqueue right child
      if (currentNode.right != null) {
        print("➡️ Adding Right Child: ${currentNode.right!.value}");
        queue.add(currentNode.right!);
      }

      // Mark the current node as "visited" (green) after processing
      currentNode.visited(); // Set state to "visited"
      render(); // Notify listeners
      await pause(); // Delay for visualization
    }
  }

  @override
  void resetTree() {
    // ✅ Implement reset logic
    print("Tree Reset!");
    for (var node in nodes) {
      node.reset(); // Reset all nodes
    }
    render(); // Notify listeners
  }

  @override
  Future<void> visitNode(TreeNode node) async {
    // Implement node visit logic (e.g., change color)
    node.visit(); // Set state to "visiting"
    render(); // Notify listeners
  }

  @override
  Future<void> backtrackNode(TreeNode node) async {
    // Implement backtrack logic (e.g., change color)
    node.backtrack(); // Set state to "backtracking"
    render(); // Notify listeners
  }

  @override
  Future<void> completeNode(TreeNode node) async {
    // Implement completion logic (e.g., change color)
    node.visited(); // Set state to "completed"
    render(); // Notify listeners
  }

  /// Builds a binary tree from a list of values.
  /// The tree is constructed in a level-order (breadth-first) manner.
  TreeNode? buildTreeFromList(List<int> values) {
    if (values.isEmpty) return null;

    // Create the root node
    final root = TreeNode(values[0]);
    final queue = [root]; // Queue to help with level-order construction

    int index = 1; // Start from the second value in the list

    while (queue.isNotEmpty && index < values.length) {
      final currentNode = queue.removeAt(0); // Dequeue the current node

      // Assign left child
      if (index < values.length && values[index] != null) {
        currentNode.left = TreeNode(values[index]);
        queue.add(currentNode.left!); // Enqueue the left child
      }
      index++;

      // Assign right child
      if (index < values.length && values[index] != null) {
        currentNode.right = TreeNode(values[index]);
        queue.add(currentNode.right!); // Enqueue the right child
      }
      index++;
    }

    return root;
  }
}