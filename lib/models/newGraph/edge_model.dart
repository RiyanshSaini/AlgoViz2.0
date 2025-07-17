import 'dart:ui';

class EdgeModel{
  final String fromNodeId;
  final String toNodeId;
  final double? weight;
  final bool isDirected;

  EdgeModel({
    required this.fromNodeId,
    required this.toNodeId,
    this.weight,
    this.isDirected = false,
  });

}
