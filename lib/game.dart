import 'dart:math';
import 'dart:ui';
import 'package:boxdash/components/bg.dart';
import 'package:boxdash/components/box.dart';
import 'package:boxdash/components/obstacle.dart';
import 'package:boxdash/components/score.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';

class BoxGame extends BaseGame with HorizontalDragDetector {
  Score score;
  int counter = 0;
  var speed = 200.0;
  double multiplier = 1.0;
  double obsMultiplier = 1;
  double speedMultiplier = 1;
  Box box;
  List<Obstacle> obs;
  BoxGame(Size size) {
    add(Bg());
    add(box = Box());
    obs = List<Obstacle>();
    score = Score(this);
  }

  @override
  void update(double t) {
    if (size != null && counter % ((40 / obsMultiplier) + 10).round() == 0) {
      var r = Random.secure();
      var position = r.nextInt(3);
      var delta = r.nextDouble() * 50;
      switch (position) {
        case 0:
          obs.add(Obstacle(0 + delta, speed + speedMultiplier));
          add(obs.last);
          break;
        case 1:
          obs.add(Obstacle(size.width / 3 + delta, speed + speedMultiplier));
          add(obs.last);
          break;
        case 2:
          obs.add(
              Obstacle(size.width * 2 / 3 + delta, speed + speedMultiplier));
          add(obs.last);
          break;
      }
    }
    if (obs.length != 0) {
      obs.forEach((element) {
        element.update(t);
      });
    }
    counter++;
    if (counter % 1000 == 0) {
      obsMultiplier++;
    }
    if (counter % 10 == 0) {
      speedMultiplier = speedMultiplier + 2;
    }
    if (score != null) score.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    score.render(c);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails d) {
    box.x += d.delta.dx * multiplier;
    if (box.x > size.width - size.width / 9) {
      box.x = size.width - size.width / 9;
    } else if (box.x < 0) {
      box.x = 0;
    }
    if (box.x > size.width * 2 / 3) {
      multiplier = 3.0;
    } else if (box.x < size.width / 3) {
      multiplier = 3.0;
    } else {
      multiplier = 1.0;
    }
  }
}
