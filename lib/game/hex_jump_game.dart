import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/map/hex_map.dart';

class HexDanceGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    camera = CameraComponent(
      viewport: FixedAspectRatioViewport(
        aspectRatio: 1,
      ),
    );
    // debugMode = true;
    final double maxSide = min(size.x, size.y);

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
