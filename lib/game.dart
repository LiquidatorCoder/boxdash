import 'dart:ui';
import 'package:boxdash/components/bg.dart';
import 'package:boxdash/components/box.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';

class BoxGame extends BaseGame with TapDetector {
  Box box;
  BoxGame(Size size) {
    add(Bg());
    add(box = Box());
  }

  @override
  void onTap() {
    box.speedY = -500;
    print("Tapped");
  }
}
