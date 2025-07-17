import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/graph.dart';
import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';


class GraphInteraction {
  static Node? _selectedNode;
  static Function(Node)? onNodeSelected;
  static Function(Edge)? onEdgeCreated;

  static void handleNodeTap(Node node) {
    debugPrint("Node tapped: ${node.value}");
  }

  static void handleNodeLongPress(Node node) {
    if (_selectedNode == null) {
      _selectedNode = node;
      debugPrint("Selected node: ${node.value}");
      onNodeSelected?.call(node);
    } else if (_selectedNode != node) {
      final edge = Edge(
        sourceId: _selectedNode!.id,
        targetId: node.id,
        weight: 1,
      );
      debugPrint("Created edge between ${_selectedNode!.value} and ${node.value}");
      onEdgeCreated?.call(edge);
      _selectedNode = null;
    }
  }
}