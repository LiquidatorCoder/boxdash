import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';

class Obstacle extends PositionComponent with Resizable {
  double speedY = 0.0;
  Rect obstacleRect;
  Paint obstaclePaint = Paint()..color = Color(0xff8fcfd1);

  Obstacle(double x, double speed) {
    this.x = x;
    this.speedY = speed;
  }

  void reset() {
    this.y = 0;
  }

  void crash() {
    this.speedY = -this.speedY;
    Future.delayed(Duration(milliseconds: 100))
        .then((value) => {this.x = 100000});
    this.destroy();
  }

  bool destroy() {
    return true;
  }

  void render(Canvas c) {
    obstacleRect =
        Rect.fromLTWH(this.x, this.y, size.width * 1 / 3, size.width / 18);
    c.drawRect(obstacleRect, obstaclePaint);
  }

  void resize(Size size) {
    super.resize(size);
    reset();
  }

  void update(double t) {
    super.update(t);
    this.y += speedY * t;
  }
}
