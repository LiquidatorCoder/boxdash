import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

class Obstacle extends SpriteComponent with Resizable {
  double speedY = 0.0;
  double speedX = 0.0;

  Obstacle(double x, double speed, bool advance) {
    Random r = Random();
    var name = advance
        ? 'obstacle' + (r.nextInt(4) + 4).toString() + '.png'
        : 'obstacle' + r.nextInt(4).toString() + '.png';
    this.sprite = Sprite(name, width: 1080, height: 1080);
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
    this.sprite.renderPosition(
          c,
          Position(this.x, this.y),
          size: Position(size.width / 9, size.width / 9),
        );
    this.sprite.renderPosition(
          c,
          Position(this.x + size.width / 9, this.y),
          size: Position(size.width / 9, size.width / 9),
        );
    this.sprite.renderPosition(
          c,
          Position(this.x + size.width * 2 / 9, this.y),
          size: Position(size.width / 9, size.width / 9),
        );
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
