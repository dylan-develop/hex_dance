import 'dart:async';

import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/buttons/hex_button.dart';
import 'package:hex_dance/game/hex_dance_game.dart';
import 'package:hexagon/hexagon.dart';

class MainMenu extends StatefulWidget {
  // Reference to parent game.
  final HexDanceGame game;

  const MainMenu({
    required this.game,
    super.key,
  });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final depth = 2;

  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? mainButton(Coordinates coordinates) {
      if (coordinates.x == depth && coordinates.y == -depth) {
        return HexButton(
          onTap: () {
            widget.game.overlays.remove('MainMenu');
            FlameAudio.bgm
                .stop()
                .then((value) => FlameAudio.bgm.play('bgm.wav'));

            widget.game.startGame();
          },
          width: 144.0,
          height: 144.0,
          fontSize: 48.0,
          emoji: '🎮',
          color: Colors.red,
        );
      } else if (coordinates.x == depth - 1 && coordinates.y == -depth) {
        return HexButton(
          onTap: () {
            widget.game.overlays.add('InstructionMenu');
          },
          width: 144.0,
          height: 144.0,
          fontSize: 48.0,
          emoji: '📖',
          color: Colors.blue,
        );
      }
      // } else if (coordinates.x == -1 && coordinates.y == 2) {
      //   return Text('H');
      // } else if (coordinates.x == 0 && coordinates.y == 1) {
      //   return Text('E');
      // } else if (coordinates.x == 1 && coordinates.y == 1) {
      //   return Text('X');
      // } else if (coordinates.x == -2 && coordinates.y == 1) {
      //   return Text('D');
      // } else if (coordinates.x == -1 && coordinates.y == 1) {
      //   return Text('A');
      // } else if (coordinates.x == 0 && coordinates.y == 0) {
      //   return Text('N');
      // } else if (coordinates.x == 1 && coordinates.y == 0) {
      //   return Text('C');
      // } else if (coordinates.x == 2 && coordinates.y == -1) {
      //   return Text('E');
      // }

      return null;
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(24.0),
        child: HexagonGrid.flat(
          depth: depth,
          buildTile: (coordinates) {
            return HexagonWidgetBuilder(
              padding: 4.0,
              cornerRadius: 8.0,
              child: mainButton(coordinates),
              color: (coordinates.x == depth && coordinates.y == -depth) ||
                      (coordinates.x == depth - 1 && coordinates.y == -depth)
                  ? Colors.white
                  : [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.8),
                    ].random(),
            );
          },
        ),
      ),
    );
  }
}
