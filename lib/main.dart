import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/game/hex_jump_game.dart';
import 'package:hex_dance/overlays/main_menu.dart';

void main() {
  runApp(
    GameWidget<HexDanceGame>.controlled(
      gameFactory: HexDanceGame.new,
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
      },
      // initialActiveOverlays: const ['MainMenu'],
    ),
  );
}
