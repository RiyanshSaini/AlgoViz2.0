import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/graph.dart';
import '../../../models/node.dart';


class GraphPainter extends CustomPainter {
  final List<Node> nodes;
  final List<Edge> edges;
  final String? selectedNodeId;

  GraphPainter({
    required this.nodes,
    required this.edges,
    required this.selectedNodeId,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final edgePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    final arrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    for (final edge in edges) {
      final source = nodes.firstWhere((n) => n.id == edge.sourceId);
      final target = nodes.firstWhere((n) => n.id == edge.targetId);

      final sourceOffset = source.position;
      final targetOffset = target.position;

      // Draw line
      canvas.drawLine(sourceOffset, targetOffset, edgePaint);

      // Draw edge weight
      final midpoint = Offset(
        (sourceOffset.dx + targetOffset.dx) / 2,
        (sourceOffset.dy + targetOffset.dy) / 2,
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: edge.weight.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(midpoint.dx - textPainter.width / 2, midpoint.dy - textPainter.height / 2),
      );

      // Draw arrowhead for direction
      _drawArrow(canvas, sourceOffset, targetOffset, arrowPaint);
    }

    // Optional: Highlight selected node
    if (selectedNodeId != null) {
      final selected = nodes.firstWhere((n) => n.id == selectedNodeId);
      final paint = Paint()
        ..color = Colors.orange.withOpacity(0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawCircle(selected.position, selected.radius + 4, paint);
    }
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    const arrowSize = 10.0;
    final angle = (end - start).direction;

    final arrowPoint = end;
    final path = Path();
    path.moveTo(arrowPoint.dx, arrowPoint.dy);
    path.lineTo(
      arrowPoint.dx - arrowSize * cos(angle - pi / 6),
      arrowPoint.dy - arrowSize * sin(angle - pi / 6),
    );
    path.lineTo(
      arrowPoint.dx - arrowSize * cos(angle + pi / 6),
      arrowPoint.dy - arrowSize * sin(angle + pi / 6),
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.edges != edges ||
        oldDelegate.selectedNodeId != selectedNodeId;
  }
}
