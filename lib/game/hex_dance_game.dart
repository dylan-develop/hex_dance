import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex_dance/components/map/hex_map.dart';
import 'package:hex_dance/components/player.dart';
import 'package:hex_dance/components/score.dart';
import 'package:hex_dance/core/game_value.dart';

class HexDanceGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Player player = Player();
  final Score scoreCounter = Score();
  final HexMap map = HexMap.relative(
    [
      Vector2(0, 1),
      Vector2(sqrt(3) * 1 / 2, 1 / 2),
      Vector2(sqrt(3) * 1 / 2, -1 / 2),
      Vector2(0, -1),
      Vector2(-sqrt(3) * 1 / 2, -1 / 2),
      Vector2(-sqrt(3) * 1 / 2, 1 / 2),
    ],
    position: Vector2(
      -(sqrt(3) * 1 / 2 * GameValue.boardSize / 2),
      -GameValue.boardSize / 2,
    ),
    parentSize: Vector2.all(
      GameValue.boardSize,
    ),
  );

  @override
  Future<void> onLoad() async {
    camera = CameraComponent.withFixedResolution(
      world: world,
      width: GameValue.screenSize,
      height: GameValue.screenSize,
    );
    await add(world);

    world.addAll([
      map,
      player,
      scoreCounter,
    ]);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final bool isKeyW = keysPressed.contains(LogicalKeyboardKey.keyW);
    final bool isKeyS = keysPressed.contains(LogicalKeyboardKey.keyS);
    final bool isKeyQ = keysPressed.contains(LogicalKeyboardKey.keyQ);
    final bool isKeyE = keysPressed.contains(LogicalKeyboardKey.keyE);
    final bool isKeyA = keysPressed.contains(LogicalKeyboardKey.keyA);
    final bool isKeyD = keysPressed.contains(LogicalKeyboardKey.keyD);

    if (isKeyDown) {
      if (isKeyW) {
        player.moveUp();
        return KeyEventResult.handled;
      } else if (isKeyS) {
        player.moveDown();
        return KeyEventResult.handled;
      } else if (isKeyQ) {
        player.moveUpLeft();
        return KeyEventResult.handled;
      } else if (isKeyE) {
        player.moveUpRight();
        return KeyEventResult.handled;
      } else if (isKeyA) {
        player.moveDownLeft();
        return KeyEventResult.handled;
      } else if (isKeyD) {
        player.moveDownRight();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  @override
  Color backgroundColor() => Colors.grey;

  void start() {
    map.start();
    scoreCounter.start();
  }

  void pause() {
    map.pause();
    scoreCounter.pause();
  }

  void reset() {
    // map.pause();
    scoreCounter.reset();
  }
}
