import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/game/hex_dance_game.dart';
import 'package:hex_dance/overlays/game_over_menu.dart';
import 'package:hex_dance/overlays/main_menu.dart';

void main() {
  runApp(
    GameWidget<HexDanceGame>.controlled(
      gameFactory: HexDanceGame.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
        'GameOver': (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const ['GameOver'],
    ),
  );
}
