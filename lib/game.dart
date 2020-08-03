import 'dart:math';
import 'dart:ui';
import 'package:boxdash/components/animatedParticles.dart';
import 'package:boxdash/components/bg.dart';
import 'package:boxdash/components/box.dart';
import 'package:boxdash/components/level.dart';
import 'package:boxdash/components/lives.dart';
import 'package:boxdash/components/obstacle.dart';
import 'package:boxdash/components/score.dart';
import 'package:boxdash/main.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/particles/translated_particle.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxGame extends BaseGame with HorizontalDragDetector {
  final r = Random.secure();
  final Random rnd = Random();
  final particles = acceleratedParticles();
  double fpsRate;
  int lives;
  Score score;
  Level level;
  Lives livesDisplay;
  BuildContext context;
  int obsMultiplier = 1;
  int counter = 0;
  double speed = 200;
  double multiplier = 1.0;
  int speedMultiplier = 1;
  Box box;
  List<Obstacle> obs;
  final TextConfig fpsTextConfig = TextConfig(
    color: const Color(0xFF000000),
  );
  BoxGame(Size size, levelNum, context) {
    if (levelNum > 26) {
      levelNum = 26;
    }
    if (levelNum == 1) {
      speedMultiplier = 1;
      obsMultiplier = 1;
    } else {
      counter = ((levelNum - 1) * 1000).round();
      speedMultiplier = ((levelNum - 1) * 200).round();
      obsMultiplier = levelNum;
    }
    counter = 0;
    this.context = context;
    lives = 3;
    add(Bg());
    add(box = Box());
    obs = List<Obstacle>();
    // Timer.periodic(
    //   Duration(milliseconds: 100),
    //   (_) => spawnParticles(),
    // );

    score = Score(this);
    level = Level(this);
    livesDisplay = Lives(this);
  }

  void spawnParticles() {
    add(
      TranslatedParticle(
        lifespan: 0.1,
        offset: Offset(size.width / 2, size.height - 200),
        child: particles,
      ).asComponent(),
    );
  }

  @override
  void update(double t) {
    fpsRate = (1 / t);
    // spawning obstacles
    if (box != null) box.update(t);
    if (size != null && counter % ((40 / obsMultiplier) + 10).round() == 0) {
      var position = r.nextInt(3);
      var delta = r.nextDouble() * 50;
      var val = [-1, 1];
      var mover = r.nextInt(3);
      var choice = r.nextInt(2);
      delta = delta * val[choice];
      switch (position) {
        case 0:
          // first obstacle
          obs.add(Obstacle(0 + delta, speed + speedMultiplier,
              obsMultiplier >= 4 ? true : false)
            ..speedX = obsMultiplier >= 4 ? mover == 0 ? delta * 5 : 0 : 0);
          add(obs.last);
          break;
        case 1:
          // second obstacle
          obs.add(Obstacle(size.width / 3 + delta, speed + speedMultiplier,
              obsMultiplier >= 4 ? true : false)
            ..speedX = obsMultiplier >= 4 ? mover == 1 ? delta * 5 : 0 : 0);
          add(obs.last);
          break;
        case 2:
          // third obstacle
          obs.add(Obstacle(size.width * 2 / 3 + delta, speed + speedMultiplier,
              obsMultiplier >= 4 ? true : false)
            ..speedX = obsMultiplier >= 4 ? mover == 2 ? delta * 5 : 0 : 0);
          add(obs.last);
          break;
      }
    }
    // update obstacle
    if (obs.length != 0) {
      obs.forEach((element) {
        element.update(t);
      });
    }
    obs.forEach((element) {
      if (lives != null) if (lives == 0) {
        // game over
        Flame.bgm.stop();
        this.pauseEngine();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                body: Container(
                  child: Home(score: (counter * obsMultiplier / 10).round()),
                ),
              );
            },
          ),
        );
      }
      // detecting collisions
      if (box.x >= element.x - size.width / 9 &&
          box.x <= element.x + size.width * 1 / 3) {
        if (box.y <= element.y + size.width / 18 &&
            box.y + size.width / 9 >= element.y) {
          element.crash();
          HapticFeedback.vibrate();
          Flame.audio.play('crash.wav', volume: 0.25);
          if (lives != null) lives--;
        }
      }
    });
// score counter
    counter++;
    if (counter % 1000 == 0) {
      // level up
      obsMultiplier++;
      print("Level $obsMultiplier, speed $speedMultiplier, counter $counter");
      Flame.audio.play('levelup.wav', volume: 0.25);
    }
    if (counter % 10 == 0) {
      // increasing game speed
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
    // fpsTextConfig.render(
    //     c, '${fpsRate.toStringAsFixed(2)}fps', Position(0, size.height - 24));
  }

  @override
  void onHorizontalDragCancel() {
    box.clearEffects();
  }

  @override
  void onHorizontalDragStart(DragStartDetails d) {
    box.spin();
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails d) {
    // controlling player
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
