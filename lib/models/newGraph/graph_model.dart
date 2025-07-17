import 'dart:ui';

import 'node_model.dart';
import 'edge_model.dart';

class GraphModel {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;

  GraphModel({
    List<NodeModel>? nodes,
    List<EdgeModel>? edges,
  })  : nodes = nodes ?? [],
        edges = edges ?? [];

  void addNodes(NodeModel node) {
    nodes.add(node);
  }

  void connectNodes({
    required String fromNodeId,
    required String toNodeId,
    double? weight,
    bool isDirected = false,
  }) {
    edges.add(EdgeModel(
        fromNodeId: fromNodeId,
        toNodeId: toNodeId,
        weight: weight,
        isDirected: isDirected));
  }

  void removeNodes(String nodeId){
    nodes.removeWhere((node) => node.id == nodeId);
    edges.removeWhere((edge) =>
    edge.fromNodeId == nodeId || edge.toNodeId == nodeId);
  }
}
