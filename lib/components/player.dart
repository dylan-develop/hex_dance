import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  PlayerDirection direction = PlayerDirection.right;

  @override
  FutureOr<void> onLoad() async {
    final ui.Image idleImage = await Flame.images.load('player/idle.png');
    final SpriteAnimationData idleData = SpriteAnimationData.sequenced(
      amount: 10,
      stepTime: 0.10,
      textureSize: Vector2(48.0, 48.0),
    );
    idleAnimation = SpriteAnimation.fromFrameData(idleImage, idleData);

    final ui.Image jumpImage = await Flame.images.load('player/jump.png');
    final SpriteAnimationData jumpData = SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.10,
      textureSize: Vector2(48.0, 48.0),
    );
    jumpAnimation = SpriteAnimation.fromFrameData(jumpImage, jumpData);
    anchor = Anchor.center;
    animation = idleAnimation;
    size = GameValue.playerSize;
    // position = Vector2(-size.x / 2, -size.y / 2);
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

  void move(
    Vector2 pos, {
    bool requireFlip = true,
    PlayerDirection movementDirection = PlayerDirection.right,
  }) {
    // Indicate previous movement is not finish
    if (animation == jumpAnimation) {
      return;
    }
    if (requireFlip) {
      if (direction != movementDirection) {
        flipHorizontally();
        direction = movementDirection;
      }
    }

    animation = jumpAnimation;
    add(
      MoveToEffect(
        pos,
        EffectController(
          duration: 0.35,
          curve: Curves.easeOut,
        ),
        onComplete: () {
          animation = idleAnimation;
        },
      ),
    );
  }

  void moveUp() {
    debugPrint('moveUp');
    move(
      Vector2(position.x, position.y - GameValue.hexRadius * 2),
      requireFlip: false,
    );
  }

  void moveDown() {
    debugPrint('moveDown');
    move(
      Vector2(position.x, position.y + GameValue.hexRadius * 2),
      requireFlip: false,
    );
  }

  void moveUpLeft() {
    debugPrint('moveUpLeft');
    move(
      Vector2(
        position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      movementDirection: PlayerDirection.left,
    );
  }

  void moveUpRight() {
    debugPrint('moveUpRight');
    move(
      Vector2(
        position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
    );
  }

  void moveDownLeft() {
    debugPrint('moveDownLeft');
    move(
      Vector2(
        position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      movementDirection: PlayerDirection.left,
    );
  }

  void moveDownRight() {
    debugPrint('moveDownRight');
    move(
      Vector2(
        position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
    );
  }
}

enum PlayerDirection {
  left,
  right;
}
