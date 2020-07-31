import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flutter/painting.dart';

class Score {
  final BoxGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Score(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xff181818),
      fontSize: 50,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') !=
        (game.counter * game.obsMultiplier / 10).round().toString()) {
      painter.text = TextSpan(
        text: (game.counter * game.obsMultiplier / 10).round().toString(),
        style: textStyle,
      );

      painter.layout();

      if (game.size != null) {
        position = Offset(
          (game.size.width / 2) - (painter.width / 2),
          (game.size.height * .15) - (painter.height / 2),
        );
      } else {
        painter.text = TextSpan(text: "");
      }
    }
  }
}
