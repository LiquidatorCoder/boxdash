import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class StartButton with Resizable {
  final BoxGame game;
  Rect rect;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  StartButton(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = GoogleFonts.pressStart2p(
      color: Color(0xfff6ab6c),
      fontSize: 40,
    );

    position = Offset.zero;
  }

  void render(Canvas c) {
    // c.drawRect(rect, Paint()..color = Color(0xffffffff));
    painter.layout();
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != "START") {
      painter.text = TextSpan(
        text: "START",
        style: textStyle,
      );

      painter.layout();

      if (game.size != null) {
        rect = Rect.fromLTWH(
          game.size.width / 2 - (painter.width / 2),
          (game.size.height * .75) - (painter.height / 2),
          game.size.width / 9 * 4,
          game.size.width / 9,
        );
        position = Offset(
          (game.size.width / 2) - (painter.width / 2),
          (game.size.height * .75) - (painter.height / 2),
        );
      } else {
        painter.text = TextSpan(text: "");
      }
    }
  }
}
