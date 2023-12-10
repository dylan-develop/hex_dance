import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_dance_game.dart';

class Snowflakes extends PositionComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  Snowflakes({
    super.position,
  }) : super(
          anchor: Anchor.center,
        );
  @override
  FutureOr<void> onLoad() async {
    priority = 1;
    size = GameValue.snowflakesSize;
    add(
      RectangleHitbox(
        size: Vector2.all(25.0),
        position: Vector2(size.x / 2, size.y - GameValue.hexInradius),
        anchor: Anchor.center,
      ),
    );
    add(RemoveEffect(delay: 5.8));
    return super.onLoad();
  }
}
