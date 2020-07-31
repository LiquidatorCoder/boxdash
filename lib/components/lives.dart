import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flutter/painting.dart';

class Lives {
  final BoxGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Lives(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xfff6ab6c),
      fontSize: 30,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.lives.toString()) {
      painter.text = TextSpan(
        text: game.lives.toString(),
        style: textStyle,
      );

      painter.layout();

      if (game.size != null) {
        position = Offset(
          (30) - (painter.width / 2),
          (30) - (painter.height / 2),
        );
      } else {
        painter.text = TextSpan(text: "");
      }
    }
  }
}
