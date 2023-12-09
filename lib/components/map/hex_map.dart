import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/map/hexagon.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class HexMap extends PolygonComponent with HasGameRef<HexDanceGame> {
  HexMap.relative(
    super.relation, {
    required super.parentSize,
    required super.position,
  }) : super.relative(anchor: Anchor.topLeft);

  Timer? interval;
  int second = 0;

  List<int> fireTiles = [];
  List<int> iceTiles = [];

  @override
  FutureOr<void> onLoad() async {
    paint = Paint()..color = Colors.black;

    const int n = 5; // Number of Hex in one side

    interval = Timer(
      1,
      repeat: true,
      onTick: () {
        second++;
        if (second >= 2) {
          final hexList = children.query<Hexagon>();

          // get fire tile random position
          final List<int> fireTilesRandom =
              hexList.map(hexList.indexOf).toList();
          fireTilesRandom.shuffle();

          // clear previous fire tiles
          for (int i = 0; i < fireTiles.length; i++) {
            hexList[fireTiles[i]].paint = Paint()..color = Colors.white;
          }

          // paint new fire tiles
          fireTiles = fireTilesRandom.getRange(0, 10).toList();
          for (int i = 0; i < fireTiles.length; i++) {
            hexList[fireTiles[i]].paint = Paint()..color = Colors.pink;
          }

          // get ice tile random position
          final iceTilesRandom = [...fireTilesRandom]
            ..removeWhere((element) => fireTiles.contains(element))
            ..shuffle();

          // clear previous ice tiles
          for (int i = 0; i < iceTiles.length; i++) {
            // hexList[iceTiles[i]].paint = Paint()..color = Colors.white;
          }

          // paint new ice tiles
          iceTiles = iceTilesRandom.getRange(0, 10).toList();
          for (int i = 0; i < iceTiles.length; i++) {
            hexList[iceTiles[i]].paint = Paint()..color = Colors.blue;
          }

          second = 0;
        }
      },
    );

    // Upper
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i + 1; j++) {
        final double firstHexX = size.x / 2 - i * GameValue.hexInradius * 2;

        final posX = firstHexX + j * GameValue.hexInradius * 4;
        final posY = GameValue.hexRadius / 2 + i * GameValue.hexRadius;

        add(
          Hexagon.relative(
            key: ComponentKey.named('($posX, $posY)'),
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

  @override
  void update(double dt) {
    interval?.update(dt);
  }
}
