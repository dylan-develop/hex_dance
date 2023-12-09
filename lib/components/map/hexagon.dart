import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/core/game_value.dart';

class Hexagon extends PolygonComponent {
  Hexagon({
    // required List<Vector2> vertices,
    super.anchor = Anchor.topCenter,
    super.position,
  }) : super(
          [
            Vector2(
              GameValue.hexRadius,
              0,
            ), // Right
            Vector2(
              GameValue.hexRadius / 2,
              GameValue.hexInradius,
            ), // Bottom-right
            Vector2(
              -GameValue.hexRadius / 2,
              GameValue.hexInradius,
            ), // Bottom-left
            Vector2(
              -GameValue.hexRadius,
              0,
            ), // Left
            Vector2(
              -GameValue.hexRadius / 2,
              -GameValue.hexInradius,
            ), // Top-left
            Vector2(
              GameValue.hexRadius / 2,
              -GameValue.hexInradius,
            ), // Top-right
          ],
        );

  Hexagon.relative({
    required double size,
    super.position,
    super.paint,
    super.key,
  }) : super.relative(
          [
            Vector2(1, 0), // Right
            Vector2(1 / 2, sqrt(3) * 1 / 2), // Bottom-right
            Vector2(-1 / 2, sqrt(3) * 1 / 2), // Bottom-left
            Vector2(-1, 0), // Left
            Vector2(-1 / 2, -sqrt(3) * 1 / 2), // Top-left
            Vector2(1 / 2, -sqrt(3) * 1 / 2),
          ],
          parentSize: Vector2.all(size * 2),
          anchor: Anchor.center,
          children: [
            TextComponent(
              text: '(${position?.x.round()},${position?.y.round()})',
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              ),
              anchor: Anchor.center,
              position: Vector2.all(size),
            ),
          ],
        );
}
