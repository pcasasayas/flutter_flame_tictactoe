import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:tictactoe_game/game/game.dart';
import 'package:tictactoe_game/gen/assets.gen.dart';

class TappingBehavior extends TappableBehavior<Cell>
    with HasGameRef<VeryGoodFlameGame> {
  @override
  bool onTapDown(TapDownInfo info) {
    if (parent.isCellAlreadyUsed()) {
      return true;
    }
    parent.playAnimation(
      playerOne: gameRef.isPlayingPlayerOne,
    );
    gameRef.changePlayer();

    gameRef.effectPlayer.play(AssetSource(Assets.audio.effect));
    return false;
  }
}
