import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_dance_game.dart';

class FirePillar extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  FirePillar({
    super.position,
  }) : super(
          anchor: Anchor.bottomCenter,
        );
  @override
  FutureOr<void> onLoad() async {
    priority = 1;
    final ui.Image image = await Flame.images.load('fire_pillar.png');
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 14,
        stepTime: 0.10,
        textureSize: Vector2(47.0, 92.0),
      ),
    );
    size = GameValue.firePillarSize;
    add(
      RectangleHitbox(
        size: Vector2.all(25.0),
        position: Vector2(size.x / 2, size.y - GameValue.hexInradius),
        anchor: Anchor.center,
      ),
    );
    add(RemoveEffect(delay: 0.10 * 14 * 3 - 0.1));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    // print(other);
    super.onCollisionStart(intersectionPoints, other);
  }
}
