import 'package:flutter/material.dart';

import '../../GraphMode/graph_mode.dart';
import '../../models/newGraph/edge_model.dart';
import '../../models/newGraph/node_model.dart';


class GraphProvider with ChangeNotifier {
  List<NodeModel> _nodes = [];
  List<EdgeModel> _edges = [];

  GraphMode _mode = GraphMode.idle;
  NodeModel? _pendingEdgeStart;
  GraphMode get mode => _mode;

  Map<String, String?> _previousPath = {}; // backtracking higlights.
  NodeModel? _selectedNode;
  int _nodeCounter = 0;


  NodeModel? get selectedNode => _selectedNode;
  List<NodeModel> get nodes => _nodes;
  List<EdgeModel> get edges => _edges;

  // DFS Stack viz;
  List<String> _dfsStack = [];
  String? _currentStackNode;
  String? _stackOperation; // "push", "pop"

  List<String> get dfsStack => _dfsStack;
  String? get currentStackNode => _currentStackNode;
  String? get stackOperation => _stackOperation;

  // bfs queue vis:
  List<String> _bfsQueue = [];
  String? _bfsCurrentNode;
  String? _bfsOperation;

  List<String> get bfsQueue => _bfsQueue;
  String? get bfsCurrentNode => _bfsCurrentNode;
  String? get bfsOperation => _bfsOperation;

  // priority queue dijkstra:
  List<String> _priorityQueue = [];
  Map<String, int> _distances = {};
  String? _pqCurrentNode;
  String? _pqOperation; // "extract", "update"

  List<String> get priorityQueue => _priorityQueue;
  Map<String, int> get distances => _distances;
  String? get pqCurrentNode => _pqCurrentNode;
  String? get pqOperation => _pqOperation;

  // smart dijkstra traversal
  Set<String> _relaxedNodes = {};
  String? _currentExtractedNode;

  Set<String> get relaxedNodes => _relaxedNodes;
  String? get currentExtractedNode => _currentExtractedNode;




  void setMode(GraphMode mode) {
    _mode = mode;
    _pendingEdgeStart = null; // Reset edge logic if mode changed
    notifyListeners();
  }
  void addNode(Offset position) {
    _nodeCounter++;
    final node = NodeModel(id: _nodeCounter.toString(), position: position);
    _nodes.add(node);
    notifyListeners();
  }


  void updateNodePosition(String nodeId, Offset newPosition) {
    final node = _nodes.firstWhere((n) => n.id == nodeId, orElse: () => NodeModel(id: '', position: Offset.zero));
    if (node.id != '') {
      node.position = newPosition;
      notifyListeners();
    }
  }

  void connectNodes(String fromId, String toId) {
    final edge = EdgeModel(fromNodeId: fromId, toNodeId: toId);
    _edges.add(edge);
    notifyListeners();
  }

  void removeNode(String nodeId) {
    _nodes.removeWhere((node) => node.id == nodeId);
    _edges.removeWhere((edge) => edge.fromNodeId == nodeId || edge.toNodeId == nodeId);
    notifyListeners();
  }

  void resetGraph() {
    _nodes.clear();
    _edges.clear();
    notifyListeners();
  }

  void selectNode(NodeModel tappedNode) {
    switch (_mode) {
      case GraphMode.idle:
        _selectedNode = tappedNode;
        break;

      case GraphMode.connecting:
        if (_pendingEdgeStart == null) {
          _pendingEdgeStart = tappedNode;
        } else {
          if (_pendingEdgeStart!.id != tappedNode.id) {
            connectNodes(_pendingEdgeStart!.id, tappedNode.id);
          }
          _pendingEdgeStart = null;
        }
        break;

      case GraphMode.runningAlgorithm:
        highlightPathTo(tappedNode.id);
        break;
    }

    notifyListeners();
  }


  // DFS
  Future<void> dfs(String startNodeId) async {
    for (final node in _nodes) {
      node.visited = false;
      node.isPath = false;
    }

    _dfsStack.clear();
    _stackOperation = null;
    _currentStackNode = null;
    notifyListeners();

    final visited = <String>{};

    Future<void> _dfs(String nodeId) async {
      if (visited.contains(nodeId)) return;

      visited.add(nodeId);

      // 🔼 Push operation
      _dfsStack.add(nodeId);
      _stackOperation = "push";
      _currentStackNode = nodeId;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 400));

      final node = _nodes.firstWhere((n) => n.id == nodeId);
      node.visited = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));

      final neighbors = _edges
          .where((e) => e.fromNodeId == nodeId || e.toNodeId == nodeId)
          .map((e) => e.fromNodeId == nodeId ? e.toNodeId : e.fromNodeId);

      for (final neighbor in neighbors) {
        await _dfs(neighbor);
      }

      // 🔽 Pop operation
      _stackOperation = "pop";
      _currentStackNode = _dfsStack.removeLast();
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 400));
    }

    await _dfs(startNodeId);

    _stackOperation = null;
    _currentStackNode = null;
    _mode = GraphMode.idle;
    notifyListeners();
  }


  // Reset Button
  void resetTraversal() {
    for (final node in _nodes) {
      node.visited = false;
      node.isPath = false;
    }
    _selectedNode = null;
    _pendingEdgeStart = null;
    _dfsStack.clear();
    _stackOperation = null;
    _currentStackNode = null;
    _mode = GraphMode.idle;

    // clear bfs queue
    _bfsQueue.clear();
    _bfsOperation = null;
    _bfsCurrentNode = null;

    // clear dijkstra priority queue.
    _priorityQueue.clear();
    _distances.clear();
    _pqCurrentNode = null;
    _pqOperation = null;

    _relaxedNodes.clear();
    _currentExtractedNode = null;


    notifyListeners();
  }


  Future<void> bfs(String startNodeId) async {
    for (final node in _nodes) {
      node.visited = false;
      node.isPath = false;
    }
    _bfsQueue.clear();
    _bfsCurrentNode = null;
    _bfsOperation = null;
    notifyListeners();

    final visited = <String>{};
    final queue = <String>[];

    queue.add(startNodeId);
    visited.add(startNodeId);

    _bfsOperation = 'enqueue';
    _bfsCurrentNode = startNodeId;
    _bfsQueue.add(startNodeId);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500)); // Delay AFTER notify

    while (queue.isNotEmpty) {
      final nodeId = queue.removeAt(0);

      _bfsOperation = 'dequeue';
      _bfsCurrentNode = nodeId;
      _bfsQueue.removeAt(0);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 500)); // Delay AFTER pop

      final node = _nodes.firstWhere((n) => n.id == nodeId);
      node.visited = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300)); // Give canvas time

      final neighbors = _edges
          .where((e) => e.fromNodeId == nodeId || e.toNodeId == nodeId)
          .map((e) =>
      e.fromNodeId == nodeId ? e.toNodeId : e.fromNodeId);

      for (final neighbor in neighbors) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);

          _bfsOperation = 'enqueue';
          _bfsCurrentNode = neighbor;
          _bfsQueue.add(neighbor);
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 500)); // Slow enqueue
        }
      }
    }

    _bfsOperation = null;
    _bfsCurrentNode = null;
    _mode = GraphMode.idle;
    notifyListeners();
  }

  void removeEdge(String fromId, String toId) {
    _edges.removeWhere((edge) =>
    (edge.fromNodeId == fromId && edge.toNodeId == toId) ||
        (edge.fromNodeId == toId && edge.toNodeId == fromId));
    notifyListeners();
  }

  Future<void> dijkstra(String startNodeId) async {
    for (final node in _nodes) {
      node.visited = false;
      node.isPath = false;
    }

    _distances.clear();
    _priorityQueue.clear();
    _relaxedNodes.clear();
    _currentExtractedNode = null;
    notifyListeners();

    final dist = <String, int>{};
    final visited = <String>{};
    final previous = <String, String?>{};

    for (var node in _nodes) {
      dist[node.id] = node.id == startNodeId ? 0 : 99999;
      previous[node.id] = null;
    }

    _distances = {...dist};
    _priorityQueue = _nodes.map((n) => n.id).toList();
    notifyListeners();

    while (_priorityQueue.isNotEmpty) {
      _priorityQueue.sort((a, b) => dist[a]!.compareTo(dist[b]!));
      final currentId = _priorityQueue.removeAt(0);

      if (visited.contains(currentId)) continue;

      _currentExtractedNode = currentId;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 600));

      visited.add(currentId);
      final currentNode = _nodes.firstWhere((n) => n.id == currentId);
      currentNode.visited = true;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 300));

      final neighbors = _edges
          .where((e) => e.fromNodeId == currentId || e.toNodeId == currentId)
          .map((e) =>
      e.fromNodeId == currentId ? e.toNodeId : e.fromNodeId);

      for (final neighborId in neighbors) {
        if (visited.contains(neighborId)) continue;

        final alt = dist[currentId]! + 1;
        if (alt < dist[neighborId]!) {
          dist[neighborId] = alt;
          previous[neighborId] = currentId;

          _distances[neighborId] = alt;
          _relaxedNodes.add(neighborId);
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 400));
        }
      }
    }

    _previousPath = previous;
    _mode = GraphMode.idle;
    _relaxedNodes.clear();
    _currentExtractedNode = null;
    notifyListeners();
  }


  // higlight shorted path;
  void highlightPathTo(String destinationId) {
    String? current = destinationId;

    while (current != null) {
      final node = _nodes.firstWhere((n) => n.id == current);
      node.isPath = true;
      current = _previousPath[current];
    }

    notifyListeners();
  }


}
