import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../models/graph.dart';
import '../../models/node.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import '../../models/graph.dart';
import '../../models/node.dart';

class GraphProviderNotUsing with ChangeNotifier {
  List<Node> _nodes = [];
  List<Edge> _edges = [];
  List<String> _visitedNodes = [];
  List<String> _currentPath = [];
  Map<String, double> _distances = {};
  String? _selectedNodeId;
  String? _algorithmState;

  // Getters
  List<Node> get nodes => _nodes;
  List<Edge> get edges => _edges;
  List<String> get visitedNodes => _visitedNodes;
  List<String> get currentPath => _currentPath;
  Map<String, double> get distances => _distances;
  String? get selectedNodeId => _selectedNodeId;
  String? get algorithmState => _algorithmState;

  // Add new node
  void addNode(Node node) {
    _nodes.add(node);
    notifyListeners();
  }

  // Add edge only if it doesn't already exist
  void addEdge(Edge edge) {
    bool alreadyExists = _edges.any((e) =>
    (e.sourceId == edge.sourceId && e.targetId == edge.targetId) ||
        (e.sourceId == edge.targetId && e.targetId == edge.sourceId) // For undirected graph
    );

    if (!alreadyExists) {
      _edges.add(edge);
      notifyListeners();
    }
  }

  // Select node for edge creation
  void selectNode(String? id) {
    _selectedNodeId = id;
    notifyListeners();
  }

  // Update node position (for dragging)
  void updateNodePosition(String id, Offset position) {
    final node = _nodes.firstWhere((n) => n.id == id);
    node.position = position;
    notifyListeners();
  }

  // Set algorithm state (e.g., running, idle, done)
  void setAlgorithmState(String state) {
    _algorithmState = state;
    notifyListeners();
  }

  // Set visited nodes (for DFS/BFS/Dijkstra)
  void setVisitedNodes(List<String> nodes) {
    _visitedNodes = nodes;
    notifyListeners();
  }

  // Set current path (for Dijkstra/Floyd etc.)
  void setCurrentPath(List<String> path) {
    _currentPath = path;
    notifyListeners();
  }

  // Set distance map (for shortest path algos)
  void setDistances(Map<String, double> distances) {
    _distances = distances;
    notifyListeners();
  }

  // Trigger edge creation logic
  void createEdge(String toNodeId) {
    if (_selectedNodeId == null || _selectedNodeId == toNodeId) return;

    final newEdge = Edge(
      sourceId: _selectedNodeId!,
      targetId: toNodeId,
      weight: 1,
    );

    addEdge(newEdge); // Will prevent duplicates automatically
    _selectedNodeId = null;
  }

  // Manually clear selected node
  void clearSelectedNode() {
    _selectedNodeId = null;
    notifyListeners();
  }
}
