import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';

class Bg extends Component with Resizable {
  Paint bgPaint = Paint()..color = Color(0xfff6efa6);
  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
  }

  @override
  void update(double t) {}
}
