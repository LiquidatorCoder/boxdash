import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';

class Obstacle extends PositionComponent with Resizable {
  double speedY = 0.0;
  double speedX = 0.0;
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
    this.destroy();
    this.speedY = -this.speedY;
    this.speedX = 0;
    Future.delayed(Duration(milliseconds: 50))
        .then((value) => {this.y = -100000});
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
    this.x += speedX * t;
    if (this.x > size.width) {
      this.x = -size.width * 1 / 3;
    } else if (this.x + size.width * 1 / 3 < 0) {
      this.x = size.width;
    }
  }
}
