import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class Level {
  final BoxGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  Level(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = GoogleFonts.pressStart2p(
      color: Color(0xfff6ab6c),
      fontSize: 15,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.layout();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') !=
        "Level " + game.obsMultiplier.round().toString()) {
      painter.text = TextSpan(
        text: "Level " + game.obsMultiplier.round().toString(),
        style: textStyle,
      );

      painter.layout();

      if (game.size != null) {
        position = Offset(
          (game.size.width / 2) - (painter.width / 2),
          (game.size.height * .19) - (painter.height / 2),
        );
      } else {
        painter.text = TextSpan(text: "");
      }
    }
  }
}
