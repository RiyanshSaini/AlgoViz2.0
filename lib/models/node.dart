import 'dart:ui';
class Node {
  final String id;
  final String value;
  Offset position;
  bool isSelected = false;
  double radius = 20.0; // Explicit size control

  Node({
    required this.id,
    required this.value,
    required this.position,
  });
}