import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/map/hexagon.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_jump_game.dart';

class HexMap extends PolygonComponent with HasGameRef<HexDanceGame> {
  HexMap.relative(
    super.relation, {
    required super.parentSize,
    required super.position,
  }) : super.relative(anchor: Anchor.topLeft);

  @override
  FutureOr<void> onLoad() async {
    paint = Paint()..color = Colors.black;

    const int n = 5; // Number of Hex in one side

    // Upper
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i + 1; j++) {
        final double firstHexX = size.x / 2 - i * GameValue.hexInradius * 2;
        add(
          Hexagon.relative(
            size: GameValue.hexRadius,
            position: Vector2(
              firstHexX + j * GameValue.hexInradius * 4,
              GameValue.hexRadius * 3 / 2 + i * GameValue.hexRadius,
            ),
          ),
        );
      }
    }

    // Middle
    const int middleColumnTotal = 2 * (n - 1) - 1;
    for (int i = 0; i < middleColumnTotal; i++) {
      int rowIteration;
      if (i.isEven) {
        rowIteration = n - 1;
      } else {
        rowIteration = n;
      }
      for (int j = 0; j < rowIteration; j++) {
        final double firstHexX =
            size.x / 2 - (rowIteration - 1) * GameValue.hexInradius * 2;
        add(
          Hexagon.relative(
            size: GameValue.hexRadius,
            position: Vector2(
              firstHexX + j * GameValue.hexInradius * 4,
              GameValue.hexRadius * 3 / 2 + (n + i) * GameValue.hexRadius,
            ),
          ),
        );
      }
    }

    // Bottom
    for (int i = 0; i < n; i++) {
      for (int j = n; j > i; j--) {
        final double firstHexX =
            size.x / 2 - (n + 1 + i) * GameValue.hexInradius * 2;
        add(
          Hexagon.relative(
            size: GameValue.hexRadius,
            position: Vector2(
              firstHexX + j * GameValue.hexInradius * 4,
              GameValue.hexRadius * 3 / 2 +
                  (n + middleColumnTotal + i) * GameValue.hexRadius,
            ),
          ),
        );
      }
    }

    return super.onLoad();
  }
}
