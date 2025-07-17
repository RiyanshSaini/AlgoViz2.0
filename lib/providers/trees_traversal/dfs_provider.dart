import '../../models/tree_node_model.dart';
import '../tree_provider.dart';

class DFSProvider extends TreeProvider {
  DFSProvider() : super([
    // TreeNode(1),
    // TreeNode(4),
    // TreeNode(6),
    // TreeNode(2),
    // TreeNode(8),
  ]); // Pass initial nodes to the constructor
  // ✅ No List<int>, only TreeNode

  @override
  Future<void> performTraversal(TreeNode node) async {
    print("Visiting node: ${node.value}"); // ✅ Debug log

    await visitNode(node);
    await pause();

    if (node.left != null) {
      print("Going left: ${node.left!.value}");
      await performTraversal(node.left!);
      await backtrackNode(node);
      await pause();
    }

    if (node.right != null) {
      print("Going right: ${node.right!.value}");
      await performTraversal(node.right!);
      await backtrackNode(node);
      await pause();
    }

    await completeNode(node);
    await pause();
  }

}
