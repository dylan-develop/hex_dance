import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/core/game_value.dart';

class Score extends PositionComponent {
  Timer? scoreCounter;

  int second = 0;
  List<String> secondStr = [GameValue.scoreMapping['0'] ?? ''];

  void start() {
    scoreCounter = Timer(
      1,
      repeat: true,
      onTick: () {
        second++;
        for (int i = '$second'.length; i > 0; i--) {
          if (secondStr.length >= i) {
            secondStr[i - 1] = GameValue.scoreMapping['$second'[i - 1]] ?? '';
          } else {
            secondStr.add(GameValue.scoreMapping['$second'[i - 1]] ?? '');
          }
        }
      },
    );
  }

  void pause() {
    scoreCounter?.pause();
  }

  void reset() {
    second = 0;
    secondStr = [GameValue.scoreMapping['0'] ?? ''];
    scoreCounter
      ?..reset()
      ..start();
  }

  @override
  void update(double dt) {
    scoreCounter?.update(dt);
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() {
    position = Vector2(size.x / 2, size.y / 2);
  }

  @override
  void render(Canvas canvas) {
    final TextPaint textPaint = TextPaint(
      style: const TextStyle(fontSize: 20),
    );
    textPaint.render(
      canvas,
      '⏱️ ${secondStr.join()}',
      Vector2(GameValue.screenSize / 2 - 20, -GameValue.screenSize / 2 + 20),
      anchor: Anchor.centerRight,
    );
    super.render(canvas);
  }
}
