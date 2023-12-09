import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_jump_game.dart';

class FirePillar extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  FirePillar()
      : super(
          anchor: Anchor.bottomCenter,
        );
  @override
  FutureOr<void> onLoad() async {
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
    add(RectangleHitbox(size: size));
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
