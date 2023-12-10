import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:hex_dance/core/game_value.dart';

import 'package:hex_dance/game/hex_dance_game.dart';

class IceTile extends SpriteComponent with HasGameRef<HexDanceGame> {
  IceTile({
    super.position,
  }) : super(
          anchor: Anchor.topLeft,
        );
  @override
  FutureOr<void> onLoad() async {
    debugMode = true;
    priority = 1;
    final image = await Flame.images.load('ice.png');
    size = Vector2(GameValue.hexRadius * 2, GameValue.hexInradius * 2);
    sprite = Sprite(image);
    add(RemoveEffect(delay: 0.10 * 14 * 3 - 0.1 + 2));
    return super.onLoad();
  }
}
