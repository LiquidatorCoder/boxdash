import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/effects/effects.dart';

const GRAVITY = 800.0;

class Box extends PositionComponent with Resizable {
  double speedY = 0.0;
  Rect boxRect;
  Paint boxPaint = Paint()..color = Color(0xffdf5e88);

  void reset() {
    // this.addEffect()
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

  void update(double t) {
    super.update(t);
    // this.y += speedY * t - GRAVITY * t * t / 2;
    // this.speedY += GRAVITY * t;
    // if (size != null) {
    //   if (y < -10) {
    //     reset();
    //   } else if (y > size.height - size.width / 9) {
    //     this.speedY = 0.0;
    //     this.y = size.height - size.width / 9;
    //   }
    // }
  }
}
