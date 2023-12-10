import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/fire_pillar.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  PlayerDirection direction = PlayerDirection.right;
  final double normalIdleStepTime = 0.075;
  double normalJumpStepTime = 0.10;
  double stepTimeScale = 1;
  Vector2 playerHexCoordinate = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    await initAnimation();
    anchor = const Anchor(0.5, 0.75);
    size = GameValue.playerSize;
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is FirePillar) {
      game.overlays.add('GameOver');

      game.pause();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  Future<void> initAnimation() async {
    final ui.Image idleImage = await Flame.images.load('player/idle.png');
    final SpriteAnimationData idleData = SpriteAnimationData.sequenced(
      amount: 10,
      stepTime: normalIdleStepTime,
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
    animation = idleAnimation;
  }

  void move(
    Vector2 pos, {
    bool requireFlip = true,
    PlayerDirection playerDirection = PlayerDirection.right,
    MovementDirection movementDirection = MovementDirection.up,
  }) {
    // Indicate previous movement is not finished
    if (animation == jumpAnimation) {
      return;
    }
    final Vector2 nextCoordinate = Vector2(
      playerHexCoordinate.x + movementDirection.dx,
      playerHexCoordinate.y + movementDirection.dy,
    );

    if (nextCoordinate.x.abs() >= GameValue.noOfHexInSide ||
        nextCoordinate.y.abs() >= GameValue.noOfHexInSide ||
        nextCoordinate.x + nextCoordinate.y >= GameValue.noOfHexInSide) {
      return;
    }

    if (requireFlip) {
      if (direction != playerDirection) {
        flipHorizontally();
        direction = playerDirection;
      }
    }

    animation = jumpAnimation..stepTime = normalJumpStepTime * stepTimeScale;
    add(
      MoveToEffect(
        pos,
        EffectController(
          duration: 0.35 * stepTimeScale,
          curve: Curves.easeOut,
        ),
        onComplete: () {
          animation = idleAnimation;
        },
      ),
    );
    Future.delayed(
      Duration(
        milliseconds: 0.35 * stepTimeScale ~/ 2,
      ),
      () {
        playerHexCoordinate.x = nextCoordinate.x;
        playerHexCoordinate.y = nextCoordinate.y;
      },
    );
  }

  void moveUp() {
    move(
      Vector2(position.x, position.y - GameValue.hexRadius * 2),
      requireFlip: false,
    );
  }

  void moveDown() {
    move(
      Vector2(position.x, position.y + GameValue.hexRadius * 2),
      requireFlip: false,
      movementDirection: MovementDirection.down,
    );
  }

  void moveUpLeft() {
    move(
      Vector2(
        position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      playerDirection: PlayerDirection.left,
      movementDirection: MovementDirection.upLeft,
    );
  }

  void moveUpRight() {
    move(
      Vector2(
        position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y - cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      movementDirection: MovementDirection.upRight,
    );
  }

  void moveDownLeft() {
    move(
      Vector2(
        position.x - sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      playerDirection: PlayerDirection.left,
      movementDirection: MovementDirection.downLeft,
    );
  }

  void moveDownRight() {
    move(
      Vector2(
        position.x + sin(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
        position.y + cos(60.0 * (pi / 180.0)) * GameValue.hexRadius * 2,
      ),
      movementDirection: MovementDirection.downRight,
    );
  }
}

enum PlayerDirection {
  left,
  right;
}

enum MovementDirection {
  up(0, -1),
  down(0, 1),
  upLeft(-1, 0),
  upRight(1, -1),
  downLeft(-1, 1),
  downRight(1, 0);

  final double dx;
  final double dy;

  const MovementDirection(this.dx, this.dy);
}
