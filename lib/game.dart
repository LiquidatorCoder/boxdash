import 'dart:ui';
import 'package:boxdash/components/box.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';

class BoxGame extends Game {
  Size screenSize;
  double tileSize;
  List<Box> boxes;

  BoxGame() {
    initialize();
  }

  void initialize() async {
    boxes = List<Box>();
    resize(await Flame.util.initialDimensions());
    spawnBox();
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xfff6efa6);
    canvas.drawRect(bgRect, bgPaint);
    boxes.forEach((Box box) => box.render(canvas));
  }

  void update(double t) {
    boxes.forEach((Box box) => box.update(t));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawnBox() {
    boxes.add(Box(this, screenSize.width / 2 - tileSize / 2,
        screenSize.height - tileSize / 2 - 100));
  }
}
