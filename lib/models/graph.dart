import 'node.dart';

class Edge {
  final String sourceId;
  final String targetId;
  final int weight;

  Edge({
    required this.sourceId,
    required this.targetId,
    this.weight = 1,
  });
}

class Graph {
  final List<Node> _nodes = [];
  final List<Edge> _edges = [];

  List<Node> get nodes => _nodes;
  List<Edge> get edges => _edges;

  void addNode(Node node) => _nodes.add(node);
  void addEdge(Edge edge) => _edges.add(edge);
}