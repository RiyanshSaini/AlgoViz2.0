import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

import '../../../models/node.dart';

class PhysicsSimulator {
  final World world;
  final List<Body> bodies = [];
  final Map<String, Body> _nodeBodies = {};

  PhysicsSimulator() : world = World() {
    // Set zero gravity
    world.gravity = Vector2(0, 0);
  }

  void addNode(Node node) {
    final shape = CircleShape()..radius = 20 / 100;
    final bodyDef = BodyDef(
      position: Vector2(node.position.dx / 100, node.position.dy / 100),
      type: BodyType.dynamic,
      userData: node.id,
    );
    final body = world.createBody(bodyDef)..createFixture(FixtureDef(shape));
    bodies.add(body);
    _nodeBodies[node.id] = body;
  }

  void update(List<Node> nodes) {
    world.stepDt(1 / 60);
    for (var node in nodes) {
      final body = _nodeBodies[node.id];
      if (body != null) {
        node.position = Offset(
          body.position.x * 100,
          body.position.y * 100,
        );
      }
    }
  }

  void dragNode(String nodeId, Offset position) {
    final body = _nodeBodies[nodeId];
    if (body != null) {
      body.setTransform(Vector2(position.dx / 100, position.dy / 100), 0);
      body.linearVelocity = Vector2.zero(); // Stop momentum
    }
  }
}