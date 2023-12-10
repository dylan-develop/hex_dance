import 'package:flutter/material.dart';
import 'package:hex_dance/components/buttons/hex_button.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class GameOver extends StatelessWidget {
  // Reference to parent game.
  final HexDanceGame game;

  const GameOver({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scorePrefixIcon = game.scoreCounter.second < 60 * 5
        ? '🪦'
        : game.scoreCounter.second < 60 * 5
            ? '🎖️'
            : '🏆';
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(GameValue.hexRadius),
          margin: EdgeInsets.only(bottom: GameValue.boardSize / 5),
          width: GameValue.boardSize / 1.5,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    scorePrefixIcon,
                    style: const TextStyle(
                      fontSize: 48.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    '⏱️ ${game.scoreCounter.secondStr.join()}',
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: HexButton(
                          onTap: () {
                            game.reset();
                            game.overlays.remove('GameOver');
                          },
                          emoji: '🎮',
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      child: HexButton(
                        onTap: () {
                          game.overlays.add('InstructionMenu');
                        },
                        emoji: '📖',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
