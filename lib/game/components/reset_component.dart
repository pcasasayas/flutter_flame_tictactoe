import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_game/game/game.dart';

class ResetComponent extends PositionComponent
    with HasGameRef<VeryGoodFlameGame> {
  ResetComponent({
    required super.position,
  }) : super(anchor: Anchor.center);

  late final ButtonComponent button;
  late final TextComponent text;

  @override
  Future<void> onLoad() async {
    await add(
      button = ButtonComponent(
        button: TextComponent(
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 4,
            ),
          ),
          text: 'RESET IDLE',
        ),
        buttonDown: TextComponent(
          anchor: Anchor.center,
          textRenderer: TextPaint(
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 4,
            ),
          ),
          text: 'RESET PRESSED',
        ),
        anchor: Anchor.center,
        onPressed: () {
          log('onPressed');
          gameRef.resetGame();
        },
      ),
    );
  }
}
