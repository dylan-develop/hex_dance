import 'dart:math';

import 'package:flame/game.dart';

class GameValue {
  static int noOfHexInSide = 5;
  static double hexRadius = 32;
  static double hexInradius = sqrt(3) * 1 / 2 * hexRadius;

  static double screenSize = 640.0;
  static double boardSize = 608.0;

  static List<Vector2> hexRelativeVector2 = [
    Vector2(1, 0), // Right
    Vector2(1 / 2, sqrt(3) * 1 / 2), // Bottom-right
    Vector2(-1 / 2, sqrt(3) * 1 / 2), // Bottom-left
    Vector2(-1, 0), // Left
    Vector2(-1 / 2, -sqrt(3) * 1 / 2), // Top-left
    Vector2(1 / 2, -sqrt(3) * 1 / 2),
  ];

  static Vector2 playerSize = Vector2(48.0, 48.0);
  static Vector2 firePillarSize = Vector2(70.5, 138.0);

  static int fireTilesTotal = 10;
  static int iceTilesTotal = 10;
}
