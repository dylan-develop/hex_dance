import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_dance_game.dart';

class Snowflakes extends SpriteComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  Snowflakes({
    super.position,
  }) : super(
          anchor: Anchor.center,
        );
  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;
    priority = 1;
    final ui.Image image = await Flame.images.load('tile/snowflakes.gif');
    sprite = Sprite(image);

    size = GameValue.snowflakesSize;
    add(
      RectangleHitbox(
        size: Vector2.all(25.0),
        position: Vector2(size.x / 2, size.y - GameValue.hexInradius),
        anchor: Anchor.center,
      ),
    );

    add(RemoveEffect(delay: 0.10 * 14 * 3 - 0.2));
    return super.onLoad();
  }
}
