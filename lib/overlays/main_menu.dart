import 'dart:async';

import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hex_dance/components/buttons/hex_button.dart';
import 'package:hex_dance/core/game_value.dart';
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
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (callback) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: HexagonGrid.flat(
              depth: 4,
              buildTile: (coordinates) {
                final colors = [
                  Colors.red,
                  Colors.blue,
                  Colors.white,
                  Colors.white,
                ];
            
                return HexagonWidgetBuilder(
                  padding: 2.0,
                  cornerRadius: 8.0,
                  color: colors.random(),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(GameValue.hexRadius),
              margin: EdgeInsets.only(bottom: GameValue.boardSize / 5),
              width: GameValue.boardSize / 2,
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Center(
                            child: HexButton(
                              onTap: () {
                                widget.game.overlays.remove('MainMenu');
                                widget.game.startGame();
                              },
                              emoji: '🎮',
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: HexButton(
                            onTap: () {
                              widget.game.overlays.add('InstructionMenu');
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
        ],
      ),
    );
  }
}
