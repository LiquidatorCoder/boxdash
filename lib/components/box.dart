import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/animation.dart';

class Box extends SpriteComponent with Resizable {
  Box() {
    this.sprite = Sprite('cube.png', width: 1080, height: 1080);
  }
  double speedY = 0.0;

  void reset() {
    this.x = size.width / 2 - size.width / 9 / 2;
    this.y = size.height - size.height / 9 / 2 - 200;
    this.speedY = 0.0;
  }

  void render(Canvas c) {
    this.sprite.renderPosition(
          c,
          Position(this.x, this.y),
          size: Position(size.width / 9, size.width / 9),
        );
  }

  void resize(Size size) {
    super.resize(size);
    reset();
  }

  void spin() {
    print("spinning");
    this.addEffect(
      RotateEffect(
        radians: double.maxFinite,
        speed: 250,
        isInfinite: true,
        curve: Curves.easeIn,
      ),
    );
  }

  void update(double t) {
    super.update(t);
  }
}
