import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/core/game_value.dart';

class Score extends PositionComponent {
  Timer? scoreCounter;

  static final mapping = {
    '0': '0️⃣',
    '1': '1️⃣',
    '2': '2️⃣',
    '3': '3️⃣',
    '4': '4️⃣',
    '5': '5️⃣',
    '6': '6️⃣',
    '7': '7️⃣',
    '8': '8️⃣',
    '9': '9️⃣',
  };

  int second = 0;
  List<String> secondStr = [mapping['0'] ?? ''];

  void start() {
    scoreCounter = Timer(
      1,
      repeat: true,
      onTick: () {
        second++;
        for (int i = '$second'.length; i > 0; i--) {
          if (secondStr.length >= i) {
            secondStr[i - 1] = mapping['$second'[i - 1]] ?? '';
          } else {
            secondStr.add(mapping['$second'[i - 1]] ?? '');
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
    secondStr = [mapping['0'] ?? ''];
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
