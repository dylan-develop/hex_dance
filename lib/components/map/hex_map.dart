import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/map/hexagon.dart';
import 'package:hex_dance/components/tile/fire_pillar.dart';
import 'package:hex_dance/components/tile/fire_tile.dart';
import 'package:hex_dance/components/tile/ice_tile.dart';
import 'package:hex_dance/components/tile/snowflakes.dart';
import 'package:hex_dance/core/game_state.dart';
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

  void start() {
    interval = Timer(
      1,
      repeat: true,
      onTick: () async {
        if (game.gameState != GameState.running) {
          return;
        }

        second++;
        if (second % 7 == 0 || second == 1) {
          final hexList = children.query<Hexagon>();

          // get fire tile random position
          final List<int> fireTilesRandom =
              hexList.map(hexList.indexOf).toList();
          fireTilesRandom.shuffle();

          // clear previous fire tiles
          for (int i = 0; i < fireTiles.length; i++) {
            hexList[fireTiles[i]].paint = Paint()..color = Colors.white;
          }
          // clear previous ice tiles
          for (int i = 0; i < iceTiles.length; i++) {
            hexList[iceTiles[i]].paint = Paint()..color = Colors.white;
          }

          // paint new fire tiles
          fireTiles = fireTilesRandom
              .getRange(
                0,
                min(
                  GameValue.fireTilesTotal + (second / 20).floor(),
                  fireTilesRandom.length ~/ 2,
                ),
              )
              .toList();
          for (int i = 0; i < fireTiles.length; i++) {
            hexList[fireTiles[i]].paint = Paint()..color = Colors.pink;
            hexList[fireTiles[i]].add(FireTile());
            Future.delayed(const Duration(seconds: 2), () {
              hexList[fireTiles[i]].add(
                FirePillar(
                  position: Vector2(
                    GameValue.hexRadius,
                    GameValue.hexInradius * 2,
                  ),
                ),
              );
            });
          }

          // get ice tile random position
          final iceTilesRandom = [...fireTilesRandom]
            ..removeWhere((element) => fireTiles.contains(element))
            ..shuffle();

          // paint new ice tiles
          iceTiles =
              iceTilesRandom.getRange(0, GameValue.iceTilesTotal).toList();
          for (int i = 0; i < iceTiles.length; i++) {
            hexList[iceTiles[i]].paint = Paint()..color = Colors.white;
            hexList[iceTiles[i]].add(IceTile());
            hexList[iceTiles[i]].paint = Paint()..color = Colors.white;
            hexList[iceTiles[i]].add(
              Snowflakes(
                position: Vector2(
                  GameValue.hexRadius,
                  GameValue.hexInradius,
                ),
              ),
            );
          }
        }
      },
    );
  }

  @override
  FutureOr<void> onLoad() async {
    paint = Paint()..color = Colors.black;

    final int n = GameValue.noOfHexInSide; // Number of Hex in one side

    // Upper
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < i + 1; j++) {
        final double firstHexX = size.x / 2 - i * GameValue.hexInradius * 2;

        add(
          Hexagon.relative(
            index: children.query<Hexagon>().length,
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
    final int middleColumnTotal = 2 * (n - 1) - 1;
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
            index: children.query<Hexagon>().length,
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
            index: children.query<Hexagon>().length,
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

  void pause() {
    interval?.pause();
  }

  void reset() {
    final List<Hexagon> hexList = children.query<Hexagon>();
    for (final int fireTile in fireTiles) {
      hexList[fireTile].paint = Paint()..color = Colors.white;
      if (hexList[fireTile].children.query<FirePillar>().isNotEmpty) {
        hexList[fireTile].remove(
          hexList[fireTile].children.query<FirePillar>().first,
        );
      }
      if (hexList[fireTile].children.query<FireTile>().isNotEmpty) {
        hexList[fireTile].remove(
          hexList[fireTile].children.query<FireTile>().first,
        );
      }
    }
    for (final int iceTile in iceTiles) {
      hexList[iceTile].paint = Paint()..color = Colors.white;
      if (hexList[iceTile].children.query<IceTile>().isNotEmpty) {
        hexList[iceTile].remove(
          hexList[iceTile].children.query<IceTile>().first,
        );
      }
      if (hexList[iceTile].children.query<Snowflakes>().isNotEmpty) {
        hexList[iceTile].remove(
          hexList[iceTile].children.query<Snowflakes>().first,
        );
      }
    }
    second = 0;
    fireTiles = [];
    iceTiles = [];
    interval?.reset();

    start();
  }
}
