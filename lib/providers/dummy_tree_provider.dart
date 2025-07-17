import '../models/tree_node_model.dart';
import 'tree_provider.dart';

class DummyTreeProvider extends TreeProvider {
  DummyTreeProvider() : super([
    TreeNode(1),
    TreeNode(4),
    TreeNode(6),
    TreeNode(2),
    TreeNode(8),
    TreeNode(6),
    TreeNode(103),
    TreeNode(24),
    TreeNode(657),
    TreeNode(67),
    // TreeNode(57),
    // TreeNode(65),
    // TreeNode(7),
    // TreeNode(8),
    // TreeNode(10),
    // TreeNode(4),
    // TreeNode(9),
    // TreeNode(10),
    // TreeNode(10),
    // TreeNode(10),
    // TreeNode(6),
  ]);

  @override
  Future<void> performTraversal(TreeNode? node) async {
    if (node == null) return; // Base case for recursion

    await visitNode(node); // ✅ Highlight the node
    await pause(); // ✅ Wait based on speed slider

    if (node.left != null) {
      print("➡️ Going Left to ${node.left!.value}");
      await performTraversal(node.left);
    } else {
      print("❌ No Left Child for ${node.value}");
    }

    if (node.right != null) {
      print("➡️ Going Right to ${node.right!.value}");
      await performTraversal(node.right);
    } else {
      print("❌ No Right Child for ${node.value}");
    }

    print("🔙 Backtracking from: ${node.value}");
  }

  @override
  void resetTree() {
    // ✅ Implement reset logic
    print("Tree Reset!");
    notifyListeners();
  }
}
