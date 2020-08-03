import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Bg extends SpriteComponent with Resizable {
  Paint bgPaint = Paint()..color = Colors.white;

  Bg() {
    this.sprite = Sprite('sky.png', width: 480, height: 800);
  }

  @override
  void render(Canvas c) {
    this.sprite.renderPosition(
          c,
          Position(0, 0),
          size: Position(size.width, size.height),
        );
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
