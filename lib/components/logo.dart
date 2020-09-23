import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Logo extends SpriteComponent with Resizable {
  Paint bgPaint = Paint()..color = Colors.white;

  Logo() {
    this.y = 100;
    this.sprite = Sprite('logo.png', width: 1042, height: 1042);
  }

  @override
  void render(Canvas c) {
    this.sprite.renderPosition(
          c,
          Position(size.width / 2 - 125, y),
          size: Position(250, 250),
        );
  }

  @override
  void update(double t) {
    super.update(t);
  }
}
