import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hex_dance/components/map/hex_map.dart';
import 'package:hex_dance/components/player.dart';

class HexDanceGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Player player = Player();

  @override
  Future<void> onLoad() async {
    final double maxSide = min(size.x, size.y);
    final CameraComponent cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: maxSide,
      height: maxSide,
      // height: ,
      // viewport: FixedAspectRatioViewport(
      //   aspectRatio: 1,
      // ),

      // width: maxSide,
      // height: maxSide,
    );
    await addAll([
      world,
      cameraComponent,
    ]);

    await world.addAll([
      HexMap(
        vertices: [
          Vector2(0, 0), // Right
          Vector2(0, maxSide), // Bottom-right
          Vector2(maxSide, maxSide), // Bottom-left
          Vector2(maxSide, 0), // L
        ],
      ),
      player,
    ]);
    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xFFDADADA);

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
}
