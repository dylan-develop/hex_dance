import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class Hexagon extends PolygonComponent {
  Hexagon.relative({
    required double size,
    required int index,
    super.position,
    super.paint,
    super.paintLayers,
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
              text: '$index',
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              anchor: Anchor.center,
              position: Vector2(size, size - 12.0),
            ),
            TextComponent(
              text: '(${position?.x.round()},${position?.y.round()})',
              textRenderer: TextPaint(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                ),
              ),
              anchor: Anchor.center,
              position: Vector2.all(size),
            ),
          ],
        );

  @override
  FutureOr<void> onLoad() async {
    // add(
    // PolygonHitbox(
    //   [
    // Vector2(
    //   GameValue.hexSizeLength,
    //   0,
    // ), // Right
    // Vector2(
    //   GameValue.hexSizeLength / 2,
    //   GameValue.hexInradius,
    // ), // Bottom-right
    // Vector2(
    //   -GameValue.hexSizeLength / 2,
    //   GameValue.hexInradius,
    // ), // Bottom-left
    // Vector2(
    //   -GameValue.hexSizeLength,
    //   0,
    // ), // Left
    // Vector2(
    //   -GameValue.hexSizeLength / 2,
    //   -GameValue.hexInradius,
    // ), // Top-left
    // Vector2(
    //   GameValue.hexSizeLength / 2,
    //   -GameValue.hexInradius,
    // ), // Top-right
    // ],
    // anchor: Anchor.center,
    // position: Vector2(size.x / 2, size.y / 2),
    // ),
    // );

    final image = await Flame.images.load('hex_tiled.png');
    add(SpriteComponent.fromImage(image, size: size));

    return super.onLoad();
  }
}
