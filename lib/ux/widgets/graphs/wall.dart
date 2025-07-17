
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';

class Wall extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  Wall({required this.position, required this.size});

  @override
  Body createBody() {
    final shape = PolygonShape();
    shape.setAsBox(size.x/2, size.y/2, Vector2.zero(), 0);
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static,
    );
    return world.createBody(bodyDef)..createFixture(FixtureDef(shape));
  }
}