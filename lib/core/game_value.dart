import 'dart:math';

import 'package:flame/components.dart';

class GameValue {
  static double hexRadius = 32;
  static double hexInradius = sqrt(3) * 1 / 2 * hexRadius;

  static double screenSize = 640.0;
  static double boardSize = 560.0;

  static List<Vector2> hexRelativeVector2 = [
    Vector2(1, 0), // Right
    Vector2(1 / 2, sqrt(3) * 1 / 2), // Bottom-right
    Vector2(-1 / 2, sqrt(3) * 1 / 2), // Bottom-left
    Vector2(-1, 0), // Left
    Vector2(-1 / 2, -sqrt(3) * 1 / 2), // Top-left
    Vector2(1 / 2, -sqrt(3) * 1 / 2),
  ];
}
