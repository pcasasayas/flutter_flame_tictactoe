import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_game/game/entities/cell/behaviors/tapping_behavior.dart';
import 'package:tictactoe_game/gen/assets.gen.dart';

class Cell extends Entity with HasGameRef {
  Cell({
    required super.position,
  }) : super(
    anchor: Anchor.center,
    size: Vector2.all(16),
    behaviors: [
      TappingBehavior(),
    ],
  );

  @visibleForTesting
  Cell.test({
    required super.position,
    super.behaviors,
  }) : super(size: Vector2.all(32));

  SpriteAnimation? _animationX;
  SpriteAnimation? _animationO;
  SpriteAnimationComponent? _spriteComponent;

  bool _used = false;

  @override
  Future<void> onLoad() async {
    _animationX = await gameRef.loadSpriteAnimation(
      Assets.images.playerOneSprite.path,
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
    _animationO = await gameRef.loadSpriteAnimation(
      Assets.images.playerTwoSprite.path,
      SpriteAnimationData.sequenced(
        amount: 8,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );

    final paint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
    final square = RectangleComponent.square(
      size: size.x,
      position: Vector2(0, 0),
      paint: paint,
    );
    await add(square);
  }

  @visibleForTesting
  SpriteAnimation get animationX => _animationX!;
  SpriteAnimation get animationO => _animationO!;

  /// Set the animation to the first frame by tricking the animation
  /// into thinking it finished the last frame.
  void reset() {
    resetAnimations();
    if (_spriteComponent != null) {
      remove(_spriteComponent!);
      _spriteComponent = null;
    }
    _used = false;
  }

  /// Set the animation to the first frame by tricking the animation
  /// into thinking it finished the last frame.
  void resetAnimations() {
    _animationO!.reset();
    _animationX!.reset();
  }

  /// Plays the animation.
  Future<void> playAnimation({required bool playerOne}) async {
    _used = true;
    if (playerOne) {
      await add(_spriteComponent = SpriteAnimationComponent(
        animation: _animationX, 
        size: size,
      ),);
      return;
    }
    await add(_spriteComponent = SpriteAnimationComponent(
      animation: _animationO, 
      size: size,
    ),);
  }
  
  /// Returns whether the cell is played or not.
  bool isCellAlreadyUsed() => _used;
}
