import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../../../models/node.dart';
import '../../../providers/graphs/graph_provider_NotUsing.dart';


class NodeBody extends BodyComponent with TapCallbacks, DragCallbacks {
  final Node node;
  final GraphProviderNotUsing graphProvider;
  bool _isDragging = false;
  final Vector2 _initialPosition;
  static const double pixelsPerMeter = 100.0;

  NodeBody({
    required Vector2 initialPosition,
    required this.node,
    required this.graphProvider,
  }) : _initialPosition = initialPosition {
    node.position = Offset(initialPosition.x * pixelsPerMeter, initialPosition.y * pixelsPerMeter);
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 20 / pixelsPerMeter;
    final bodyDef = BodyDef(
      position: _initialPosition,
      type: BodyType.dynamic,
      userData: this,
    );

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.8
      ..density = 1.0
      ..friction = 0.4;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    final selected = graphProvider.selectedNodeId;

    if (selected == null) {
      // No node is selected yet — mark this node as selected
      graphProvider.selectNode(node.id);
    } else if (selected != node.id) {
      // A different node is already selected — create edge and reset
      graphProvider.createEdge(node.id);
      graphProvider.selectNode(null);
    } else {
      // Same node tapped again — unselect it
      graphProvider.selectNode(null);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragging = true;
    body.setType(BodyType.kinematic);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_isDragging) {
      final localCoords = event.localPosition;
      body.setTransform(localCoords, 0);
      node.position = Offset(localCoords.x * pixelsPerMeter, localCoords.y * pixelsPerMeter);
      graphProvider.notifyListeners();
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragging = false;
    body.setType(BodyType.dynamic);
  }

  @override
  void render(Canvas canvas) {
    final isSelected = graphProvider.selectedNodeId == node.id;

    final paint = Paint()
      ..color = isSelected
          ? Colors.green
          : (_isDragging ? Colors.orange : Colors.blue)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, 20, paint);

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
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
}
