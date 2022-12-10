import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';
import 'package:tictactoe_game/game/entities/player/player.dart';
import 'package:tictactoe_game/game/game.dart';
import 'package:tictactoe_game/l10n/l10n.dart';

class VeryGoodFlameGame extends FlameGame with HasTappables {
  VeryGoodFlameGame({
    required this.l10n,
    required this.effectPlayer,
  }) {
    images.prefix = '';
  }

  final AppLocalizations l10n;

  final AudioPlayer effectPlayer;

  int counter = 0;
  
  bool isPlayingPlayerOne = true;

  @override
  Color backgroundColor() => const Color(0xFF2A48DF);

  List<Cell> cellGrid = [];
  late Player player;

  @override
  Future<void> onLoad() async {
    camera.zoom = 8;
    await add(ResetComponent(position: (size / 2)..sub(Vector2(40, 35))));
    await add(player = Player(position: (size / 2)..sub(Vector2(50, 0))));
    // await add(CounterComponent(position: (size / 2)..sub(Vector2(0, 16))));
    // await add(Unicorn(position: size / 2));
    cellGrid = buildGrid();
    for (final cell in cellGrid) {
      await add(cell);
    }
    player.updatePlayer(playerOne: isPlayingPlayerOne);
  }

  void changePlayer() {
    isPlayingPlayerOne = !isPlayingPlayerOne;
    player.updatePlayer(playerOne: isPlayingPlayerOne);
  }

  void resetGame() {
    for (final cell in cellGrid) {
      cell.reset();
    }
  }

  List<Cell> buildGrid() {
    return [
      Cell(position: size / 2),
      Cell(position: size / 2 - Vector2(0, 20)),
      Cell(position: size / 2 - Vector2(0, -20)),
      Cell(position: size / 2 - Vector2(20, 20)),
      Cell(position: size / 2 - Vector2(20, -20)),
      Cell(position: size / 2 - Vector2(-20, 20)),
      Cell(position: size / 2 - Vector2(-20, -20)),
      Cell(position: size / 2 - Vector2(-20, 0)),
      Cell(position: size / 2 - Vector2(20, 0)),
    ];
  }
}
