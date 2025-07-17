
import 'dart:ui';

class NodeModel{
  final String id;
  Offset position;
  final String? label;
  bool visited;
  bool isPath;

  NodeModel({
    required this.id,
    required this.position,
    this.label,
    this.visited = false,
    this.isPath = false
  });

}
