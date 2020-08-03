import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/material.dart';

class Bg extends Component with Resizable {
  Paint bgPaint = Paint()..color = Colors.white;
  @override
  void render(Canvas c) {
    c.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);
  }

  @override
  void update(double t) {}
}
