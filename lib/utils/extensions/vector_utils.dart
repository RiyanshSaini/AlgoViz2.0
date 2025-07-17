// utils/vector_extensions.dart

// utils/vector_utils.dart
import 'dart:ui';
import 'package:vector_math/vector_math_64.dart';

extension Vector2ToOffset on Vector2 {
  Offset toOffset() => Offset(x, y);
}

extension OffsetToVector2 on Offset {
  Vector2 toVector2() => Vector2(dx, dy);
}