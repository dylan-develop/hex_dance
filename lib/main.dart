import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hex_jump/game/hex_jump_game.dart';

void main() {
  runApp(
    GameWidget(
      game: HexJumpGame(),
    ),
  );
}
