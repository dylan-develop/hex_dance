import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/fire_pillar.dart';
import 'package:hex_dance/components/tile/fire_tile.dart';
import 'package:hex_dance/components/tile/ice_tile.dart';
import 'package:hex_dance/components/tile/snowflakes.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class Player extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HexDanceGame> {
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  // late SpriteAnimation deathAnimation;

  PlayerDirection direction = PlayerDirection.right;
  final double normalIdleStepTime = 0.15;
  double normalJumpStepTime = 0.20;
  double stepTimeScale = 1;
  Vector2 playerHexCoordinate = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    await initAnimation();
    anchor = const Anchor(0.5, 0.75);
    size = GameValue.playerSize;
    add(
      RectangleHitbox(
        size: Vector2(size.x / 2, size.y),
        position: Vector2(size.x / 4, 0),
      ),
    );
    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is FireTile) {
    } else if (other is IceTile) {
      FlameAudio.play('ice.mp3');
    } else if (other is FirePillar) {
      FlameAudio.play('fire.mp3');
      game.gameover();
      // animation = deathAnimation;
    } else if (other is Snowflakes) {
      stepTimeScale = 5;
      decorator.addLast(
        PaintDecorator.tint(
          const Color.fromARGB(80, 33, 150, 235),
        ),
      );
      Future.delayed(
        const Duration(seconds: 5),
        () {
          stepTimeScale = 1;
          if (!decorator.isLastDecorator) {
            decorator.removeLast();
          }
        },
      );
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  Future<void> initAnimation() async {
    final ui.Image idleImage = await Flame.images.load('player/idle.png');
    final SpriteAnimationData idleData = SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: normalIdleStepTime,
      textureSize: Vector2(16.0, 24.0),
    );
    idleAnimation = SpriteAnimation.fromFrameData(idleImage, idleData);

    final ui.Image runImage = await Flame.images.load('player/run.png');
    final SpriteAnimationData runData = SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.10,
      textureSize: Vector2(16.0, 24.0),
    );
    runAnimation = SpriteAnimation.fromFrameData(runImage, runData);

    // final ui.Image deathImage = await Flame.images.load('player/death.png');
    // final SpriteAnimationData deathData = SpriteAnimationData.sequenced(
    //   amount: 10,
    //   stepTime: 0.10,
    //   textureSize: Vector2(64.0, 64.0),
    //   loop: false,
    // );
    // deathAnimation = SpriteAnimation.fromFrameData(deathImage, deathData);
    animation = idleAnimation;
  }

  void move(
    Vector2 pos, {
    bool requireFlip = true,
    PlayerDirection playerDirection = PlayerDirection.right,
    MovementDirection movementDirection = MovementDirection.up,
  }) {
    // Indicate previous movement is not finished
    if (animation == runAnimation) {
      return;
    }
    final Vector2 nextCoordinate = Vector2(
      playerHexCoordinate.x + movementDirection.dx,
      playerHexCoordinate.y + movementDirection.dy,
    );

    if (nextCoordinate.x.abs() >= GameValue.noOfHexInSide ||
        nextCoordinate.y.abs() >= GameValue.noOfHexInSide ||
        (nextCoordinate.x + nextCoordinate.y).abs() >=
            GameValue.noOfHexInSide) {
      return;
    }

    if (requireFlip) {
      if (direction != playerDirection) {
        flipHorizontally();
        direction = playerDirection;
      }
    }

    animation = runAnimation..stepTime = normalJumpStepTime * stepTimeScale;
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

  void reset() {
    stepTimeScale = 1;
    playerHexCoordinate = Vector2.zero();
    if (direction == PlayerDirection.left) {
      flipHorizontally();
    }
    direction = PlayerDirection.right;
    animation = idleAnimation;
    position = Vector2.zero();
    if (!decorator.isLastDecorator) {
      decorator.removeLast();
    }
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
