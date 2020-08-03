import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/effects/effects.dart';
import 'package:flutter/animation.dart';

class Box extends PositionComponent with Resizable {
  double speedY = 0.0;
  Rect boxRect;
  Paint boxPaint = Paint()..color = Color(0xffdf5e88);

  void reset() {
    this.x = size.width / 2 - size.width / 9 / 2;
    this.y = size.height - size.height / 9 / 2 - 200;
    this.speedY = 0.0;
  }

  void render(Canvas c) {
    boxRect = Rect.fromLTWH(this.x, this.y, size.width / 9, size.width / 9);
    c.drawRect(boxRect, boxPaint);
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
