import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_jump/components/map/hex_map.dart';

class HexJumpGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    debugMode = true;
    final double maxSide = min(size.x, size.y);
    final CameraComponent cameraComponent = CameraComponent(
      world: world,
      viewport: FixedAspectRatioViewport(
        aspectRatio: 1,
      ),

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
    ]);
    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xFFDADADA);
}
