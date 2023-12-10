import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_dance_game.dart';

class IceTile extends SpriteComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  IceTile({
    super.position,
  }) : super(
          anchor: Anchor.topLeft,
        );
  @override
  FutureOr<void> onLoad() async {
    // debugMode = true;
    priority = 1;
    final image = await Flame.images.load('tile/ice.png');
    size = Vector2(GameValue.hexRadius * 2, GameValue.hexInradius * 2);
    sprite = Sprite(image);

    add(
      RectangleHitbox(
        size: Vector2.all(25.0),
        position: Vector2(size.x / 2, size.y - GameValue.hexInradius),
        anchor: Anchor.center,
      ),
    );

    add(RemoveEffect(delay: 0.10 * 14 * 3 - 0.1 + 2));
    return super.onLoad();
  }
}
