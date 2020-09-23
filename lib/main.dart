import 'dart:ui';
import 'package:boxdash/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';

BoxGame game;
Size size;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  size = await Flame.util.initialDimensions();
  Flame.bgm.initialize();
  Flame.audio.disableLog();
  Flame.bgm.stop();
  Flame.audio.loadAll(['levelup.wav', 'crash.wav', 'bgm.mp3']);
  game = BoxGame(
    size,
    1,
  );
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  Flame.util.addGestureRecognizer(tapper);
  runApp(GameWrapper(game));
}

class GameWrapper extends StatelessWidget {
  final BoxGame game;
  GameWrapper(this.game);
  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
