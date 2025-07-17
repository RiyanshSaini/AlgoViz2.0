import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';

class NodeEntity extends BodyComponent with TapCallbacks, DragCallbacks {
  final Node node;
  final GraphProviderNotUsing graphProvider;
  bool _isDragging = false;
  static const double pixelsPerMeter = 100.0;

  NodeEntity({
    required Vector2 initialPosition,
    required this.node,
    required this.graphProvider,
  }) {
    node.position = Offset(initialPosition.x, initialPosition.y);
  }

  @override
  Body createBody() {
    final worldPosition = Vector2(
      node.position.dx / pixelsPerMeter,
      node.position.dy / pixelsPerMeter,
    );

    final shape = CircleShape()..radius = 20 / pixelsPerMeter;
    final bodyDef = BodyDef(
      position: worldPosition,
      type: BodyType.dynamic,
      userData: this,
    );

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.7
      ..density = 1.0
      ..friction = 0.4;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  void render(Canvas canvas) {
    // Convert physics position to screen coordinates
    final screenPos = Offset(
      body.position.x * pixelsPerMeter,
      body.position.y * pixelsPerMeter,
    );

    // Draw circle
    final paint = Paint()
      ..color = _isDragging ? Colors.orange : Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(screenPos, 20, paint);



    // Draw text
    final textPainter = TextPainter(
      text: TextSpan(
        text: node.value,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        screenPos.dx - textPainter.width / 2,
        screenPos.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragging = true;
    body.setType(BodyType.kinematic);
    body.linearVelocity = Vector2.zero();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_isDragging) {
      final newPosition = event.canvasPosition;
      body.setTransform(
        Vector2(
          newPosition.x / pixelsPerMeter,
          newPosition.y / pixelsPerMeter,
        ),
        0,
      );
      node.position = Offset(newPosition.x, newPosition.y);
      graphProvider.notifyListeners();
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragging = false;
    body.setType(BodyType.dynamic);
  }
}