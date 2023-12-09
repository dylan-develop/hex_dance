import 'package:flame/components.dart';
import 'package:hex_dance/core/game_value.dart';

class Hexagon extends PolygonComponent {
  Hexagon({
    // required List<Vector2> vertices,
    super.anchor = Anchor.topCenter,
    super.position,
  }) : super(
          [
            Vector2(
              GameValue.hexSizeLength,
              0,
            ), // Right
            Vector2(
              GameValue.hexSizeLength / 2,
              GameValue.hexInradius,
            ), // Bottom-right
            Vector2(
              -GameValue.hexSizeLength / 2,
              GameValue.hexInradius,
            ), // Bottom-left
            Vector2(
              -GameValue.hexSizeLength,
              0,
            ), // Left
            Vector2(
              -GameValue.hexSizeLength / 2,
              -GameValue.hexInradius,
            ), // Top-left
            Vector2(
              GameValue.hexSizeLength / 2,
              -GameValue.hexInradius,
            ), // Top-right
          ],
        );
}
