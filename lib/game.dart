import 'dart:math';
import 'dart:ui';
import 'package:boxdash/components/bg.dart';
import 'package:boxdash/components/box.dart';
import 'package:boxdash/components/level.dart';
import 'package:boxdash/components/lives.dart';
import 'package:boxdash/components/obstacle.dart';
import 'package:boxdash/components/score.dart';
import 'package:flame/components/particle_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/accelerated_particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flame/particles/moving_particle.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BoxGame extends BaseGame with HorizontalDragDetector {
  int lives;
  Score score;
  Level level;
  Lives livesDisplay;
  int counter = 0;
  var speed = 200.0;
  double multiplier = 1.0;
  double obsMultiplier = 1;
  double speedMultiplier = 1;
  Box box;
  List<Obstacle> obs;
  BoxGame(Size size) {
    lives = 3;
    add(Bg());
    add(box = Box());
    obs = List<Obstacle>();
    score = Score(this);
    level = Level(this);
    livesDisplay = Lives(this);
  }

  @override
  void update(double t) {
    if (box != null) box.update(t);
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
    obs.forEach((element) {
      if (box.x >= element.x - size.width / 9 &&
          box.x <= element.x + size.width * 1 / 3) {
        if (box.y <= element.y + size.width / 18 &&
            box.y + size.width / 9 >= element.y) {
          element.crash();
          if (lives != null) lives--;
        }
      }
    });

    counter++;
    if (counter % 1000 == 0) {
      obsMultiplier++;
    }
    if (counter % 10 == 0) {
      speedMultiplier = speedMultiplier + 2;
    }
    if (score != null) score.update(t);
    if (level != null) level.update(t);
    if (livesDisplay != null) livesDisplay.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    score.render(c);
    level.render(c);
    livesDisplay.render(c);
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
