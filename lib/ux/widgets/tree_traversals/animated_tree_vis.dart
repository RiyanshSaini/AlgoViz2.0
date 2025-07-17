import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Import your TreeNode model and LinePainter
import 'package:algo_visualizer/ux/widgets/tree_traversals/custom_line_painter.dart';
import '../../../models/tree_node_model.dart';

class AnimatedTreeVisualizer extends StatefulWidget {
  final TreeNode root; // ✅ Non-nullable root

  const AnimatedTreeVisualizer({required super.key, required this.root});

  @override
  AnimatedTreeVisualizerState createState() => AnimatedTreeVisualizerState();
}

class AnimatedTreeVisualizerState extends State<AnimatedTreeVisualizer>
    with SingleTickerProviderStateMixin {
  final Map<TreeNode, Offset> nodePositions = {};
  final double nodeSize = 50.0;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.root != widget.root) {
      nodePositions.clear(); // Clear existing positions
      _calculatePositions(widget.root); // Recalculate positions
      if (mounted) setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePositions(widget.root);
      if (mounted) setState(() {});
    });
  }

  // Calculate tree depth
  num _calculateTreeDepth(TreeNode? node) {
    if (node == null) return 0;
    return 1 + max(_calculateTreeDepth(node.left), _calculateTreeDepth(node.right));
  }

  // DFS Animation Function
  Future<void> _animateDFS(TreeNode? node) async {
    if (node == null) {
      print("🚨 Node is null, returning!");
      return;
    }

    // Visiting the current node
    print("✅ Visiting Node: ${node.value}");
    node.visit(); // Set state to "visiting" (blue)
    if (mounted) setState(() {}); // Update UI
    await Future.delayed(const Duration(milliseconds: 400)); // Delay for visualization

    // Traverse left subtree
    if (node.left != null) {
      print("➡️ Going Left to ${node.left!.value}");
      await _animateDFS(node.left);
    } else {
      print("❌ No Left Child for ${node.value}");
    }

    // Mark the current node as "visited" (green) after visiting the left subtree
    node.visited(); // Set state to "visited"
    if (mounted) setState(() {}); // Update UI
    await Future.delayed(const Duration(milliseconds: 400)); // Delay for visualization

    // Traverse right subtree
    if (node.right != null) {
      print("➡️ Going Right to ${node.right!.value}");
      await _animateDFS(node.right);
    } else {
      print("❌ No Right Child for ${node.value}");
    }

    // Mark the current node as "backtracking" (red) after visiting both subtrees
    node.backtrack(); // Set state to "backtracking"
    if (mounted) setState(() {}); // Update UI
    await Future.delayed(const Duration(milliseconds: 400)); // Delay for visualization

    print("🔙 Backtracking from: ${node.value}");
  }

  // Calculate node positions
  void _calculatePositions(TreeNode node) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final aspectRatio = screenWidth / screenHeight;
    double startX = 0.88 * (screenWidth / 2);

    double verticalSpacing = screenHeight * 0.1;
    double horizontalSpacing = screenWidth * 0.1;

    if (aspectRatio > 1.8) {
      horizontalSpacing = screenWidth * 0.15;
    }

    final treeDepth = _calculateTreeDepth(node);
    double initialOffsetX = (screenWidth / 2) / pow(aspectRatio > 1.8 ? 1.8 : 1.1, treeDepth - 1);

    _calculateNodePositions(
      node,
      x: startX,
      y: 50,
      offsetX: initialOffsetX,
      verticalSpacing: verticalSpacing,
    );
  }

  // Recursive position calculation
  void _calculateNodePositions(
      TreeNode node, {
        required double x,
        required double y,
        required double offsetX,
        required double verticalSpacing,
      }) {
    if (node.value == -1) return;

    nodePositions[node] = Offset(x, y);
    double newOffsetX = offsetX * 0.6;

    if (node.left != null) {
      _calculateNodePositions(
        node.left!,
        x: x - newOffsetX,
        y: y + verticalSpacing,
        offsetX: newOffsetX,
        verticalSpacing: verticalSpacing,
      );
    }

    if (node.right != null) {
      _calculateNodePositions(
        node.right!,
        x: x + newOffsetX,
        y: y + verticalSpacing,
        offsetX: newOffsetX,
        verticalSpacing: verticalSpacing,
      );
    }
  }

  // Reset the tree
  void resetTree() {
    print("Resetting tree");
    _resetNodes(widget.root); // Reset all nodes
    nodePositions.clear(); // Clear positions
    _calculatePositions(widget.root); // Recalculate positions
    if (mounted) setState(() {}); // Trigger UI update
  }

  // Recursively reset nodes
  void _resetNodes(TreeNode node) {
    node.reset(); // Reset the current node
    if (node.left != null) _resetNodes(node.left!);
    if (node.right != null) _resetNodes(node.right!);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.root.value == -1) {
      return const Center(child: Text("Tree is Empty"));
    }

    return Stack(children: _buildTree(widget.root)); // ✅ No more Scaffold or FAB
  }

  // Build tree structure
  List<Widget> _buildTree(TreeNode node) {
    if (!nodePositions.containsKey(node)) return [];

    List<Widget> widgets = [];
    if (node.left != null) widgets.add(_buildEdge(node, node.left!));
    if (node.right != null) widgets.add(_buildEdge(node, node.right!));
    widgets.add(_buildNode(node));
    if (node.left != null) widgets.addAll(_buildTree(node.left!));
    if (node.right != null) widgets.addAll(_buildTree(node.right!));

    return widgets;
  }

  // Build animated edge
  Widget _buildEdge(TreeNode parent, TreeNode child) {
    if (!nodePositions.containsKey(parent) || !nodePositions.containsKey(child)) {
      return Container();
    }

    final parentPos = nodePositions[parent]!;
    final childPos = nodePositions[child]!;
    final endX = childPos.dx - parentPos.dx;
    final endY = childPos.dy - parentPos.dy;

    return Positioned(
      left: parentPos.dx + nodeSize / 2,
      top: parentPos.dy + nodeSize / 2,
      child: CustomPaint(
        size: Size((endX).abs(), (endY).abs()),
        painter: LinePainter(Offset.zero, Offset(endX, endY)),
      ),
    );
  }

  // Build animated node
  Widget _buildNode(TreeNode node) {
    return ValueListenableBuilder<NodeState>(
      valueListenable: node.state,
      builder: (context, state, _) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: nodePositions[node]!.dx,
          top: nodePositions[node]!.dy,
          child: GestureDetector(
            onTap: () {
              print("🎯 Tap detected on Node ${node.value}");
              _animateDFS(node); // Start DFS from this node
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: nodeSize,
              height: nodeSize,
              decoration: BoxDecoration(
                color: node.colors, // Use the dynamic color getter
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                node.value.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}