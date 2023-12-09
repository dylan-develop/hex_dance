import 'dart:math';

import 'package:flame/game.dart';

class GameValue {
  static double hexSizeLength = 56;
  static double hexCircumradius = hexSizeLength;
  static double hexInradius = sqrt(3) * hexSizeLength / 2;
  static Vector2 firePillarSize = Vector2(141.0, 276.0);
}
