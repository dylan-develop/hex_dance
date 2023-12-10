import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex_dance/components/map/hex_map.dart';
import 'package:hex_dance/components/player.dart';
import 'package:hex_dance/components/score.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/enum/game_state.dart';

class HexDanceGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  GameState gameState = GameState.initial;
  final Player player = Player();
  final Score scoreCounter = Score();
  late final HexMap hexMap;

  @override
  Future<void> onLoad() async {
    await FlameAudio.audioCache.loadAll([
      'bgm.wav',
      'fire.mp3',
      'ice.mp3',
      'gameover.wav',
    ]);

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: GameValue.screenSize,
      height: GameValue.screenSize,
    );
    await add(world);
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (gameState != GameState.running) {
      return KeyEventResult.ignored;
    }

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
  Color backgroundColor() => Colors.black;

  void pause() {
    hexMap.pause();
    scoreCounter.pause();
  }

  void startGame() {
    hexMap = HexMap.relative(
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
    scoreCounter.start();
    hexMap.start();

    world.addAll([
      hexMap,
      player,
      scoreCounter,
    ]);

    gameState = GameState.running;
  }

  void gameover() {
    gameState = GameState.gameover;
    pause();
    FlameAudio.bgm.stop().then((value) => FlameAudio.play('gameover.wav'));
    overlays.add('GameOver');
  }

  void reset() {
    scoreCounter.reset();
    player.reset();
    hexMap.reset();
    gameState = GameState.running;
  }
}
