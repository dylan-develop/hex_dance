import 'package:flutter/material.dart';
import 'package:hex_dance/components/buttons/hex_button.dart';
import 'package:hex_dance/core/game_value.dart';
import 'package:hex_dance/game/hex_dance_game.dart';

class InstructionMenu extends StatelessWidget {
  // Reference to parent game.
  final HexDanceGame game;

  const InstructionMenu({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(GameValue.hexRadius),
          margin: EdgeInsets.only(bottom: GameValue.boardSize / 5),
          width: GameValue.boardSize,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: ['q', 'w', 'e', 'a', 's', 'd']
                            .map(
                              (k) => HexButton(
                                onTap: () {},
                                child: Image.asset(
                                  'images/keyboard/$k.png',
                                  fit: BoxFit.cover,
                                  width: 24.0,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24.0),
                  child: const Text(
                    '🏆 🟰 ❌ ☠️',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
                const SizedBox(height: 56.0),
                HexButton(
                  onTap: () {
                    game.overlays.remove('InstructionMenu');
                  },
                  emoji: '👋',
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
