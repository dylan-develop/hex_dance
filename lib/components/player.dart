import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_jump_game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  @override
  FutureOr<void> onLoad() async {
    final ui.Image image = await Flame.images.load('player.png');
    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 8,
        amountPerRow: 4,
        stepTime: 0.10,
        textureSize: Vector2(250.0, 250.0),
      ),
    );
    size = Vector2(50, 50);
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

  void moveUp() {
    debugPrint('moveUp');
    position = Vector2(position.x, position.y - GameValue.hexCircumradius * 2);
  }

  void moveDown() {
    debugPrint('moveDown');
    position = Vector2(position.x, position.y + GameValue.hexCircumradius * 2);
  }

  void moveUpLeft() {
    debugPrint('moveUpLeft');
    position = Vector2(
      position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
      position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
    );
  }

  void moveUpRight() {
    debugPrint('moveUpRight');
    position = Vector2(
      position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
      position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
    );
  }

  void moveDownLeft() {
    debugPrint('moveDownLeft');
    position = Vector2(
      position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
      position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
    );
  }

  void moveDownRight() {
    debugPrint('moveDownRight');
    position = Vector2(
      position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
      position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexCircumradius * 2,
    );
  }
}
