import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/map/hex_map.dart';
import 'package:hex_dance/core/game_value.dart';

class HexDanceGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    // debugMode = true;

    camera = CameraComponent(
      viewport: FixedAspectRatioViewport(
        aspectRatio: 1,
      ),
    );

    add(
      HexMap.relative(
        [
          Vector2(0, 1),
          Vector2(sqrt(3) * 1 / 2, 1 / 2),
          Vector2(sqrt(3) * 1 / 2, -1 / 2),
          Vector2(0, -1),
          Vector2(-sqrt(3) * 1 / 2, -1 / 2),
          Vector2(-sqrt(3) * 1 / 2, 1 / 2),
        ],
        position: Vector2(
          size.x / 2,
          size.y / 2 - GameValue.boardSize / 2,
        ),
        parentSize: Vector2.all(GameValue.boardSize),
      ),
    );

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.grey;
}
