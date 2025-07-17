import 'package:flutter/material.dart';

import '../../../models/newGraph/edge_model.dart';
import '../../../models/newGraph/node_model.dart';


class EdgePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;

  EdgePainter(this.nodes, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2.0;

    for (final edge in edges) {
      final fromNode = nodes.firstWhere((n) => n.id == edge.fromNodeId, orElse: () => NodeModel(id: '', position: Offset.zero));
      final toNode = nodes.firstWhere((n) => n.id == edge.toNodeId, orElse: () => NodeModel(id: '', position: Offset.zero));

      if (fromNode.id != '' && toNode.id != '') {
        canvas.drawLine(fromNode.position + Offset(25, 25), toNode.position + Offset(25, 25), paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
