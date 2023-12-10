import 'package:flutter/material.dart';
import 'package:hex_dance/components/score.dart';
import 'package:hex_dance/game/hex_dance_game.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final HexDanceGame game;

  const MainMenu({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      game.overlays.remove('MainMenu');

                      game.start();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: GradientText(
                      '🎮',
                      style: const TextStyle(
                        fontSize: 32.0,
                      ),
                      colors: const [
                        Colors.red,
                        Colors.blue,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
