import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/tree_node_model.dart';


// 📌 Custom Painter for drawing edges
class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  LinePainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) =>
      oldDelegate.start != start || oldDelegate.end != end;
}