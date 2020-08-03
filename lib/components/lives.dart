import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class Lives {
  final BoxGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Lives(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    textStyle = GoogleFonts.pressStart2p(
      color: Color(0xfff6ab6c),
      fontSize: 25,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != '❤' * game.lives) {
      painter.text = TextSpan(
        text: '❤' * game.lives,
        style: textStyle,
      );

      painter.layout();

      if (game.size != null) {
        position = Offset(
          10,
          (30) - (painter.height / 2),
        );
      } else {
        painter.text = TextSpan(text: "");
      }
    }
  }
}
