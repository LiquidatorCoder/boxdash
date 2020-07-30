import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flame/components/component.dart';

class Box extends Component {
  Rect boxRect;
  final BoxGame game;
  Paint boxPaint;
  Box(this.game, double x, double y) {
    boxRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    boxPaint = Paint();
    boxPaint.color = Color(0xffdf5e88);
  }
  void render(Canvas c) {
    c.drawRect(boxRect, boxPaint);
  }

  void update(double t) {}
}
