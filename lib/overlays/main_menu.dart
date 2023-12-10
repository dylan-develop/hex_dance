import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/buttons/hex_button.dart';
import 'package:hex_dance/game/hex_dance_game.dart';
import 'package:hexagon/hexagon.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final HexDanceGame game;

  const MainMenu({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const depth = 2;

    Widget? mainButton(Coordinates coordinates) {
      if (coordinates.x == depth && coordinates.y == -depth) {
        return HexButton(
          onTap: () {
            game.overlays.remove('MainMenu');
            FlameAudio.bgm
                .stop()
                .then((value) => FlameAudio.bgm.play('bgm.wav'));

            game.startGame();
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
            game.overlays.add('InstructionMenu');
          },
          width: 144.0,
          height: 144.0,
          fontSize: 48.0,
          emoji: '📖',
          color: Colors.blue,
        );
      }
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
              padding: 2.0,
              cornerRadius: 8.0,
              child: mainButton(coordinates),
            );
          },
        ),
      ),
    );
  }
}
