import 'package:boxdash/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  final size = await Flame.util.initialDimensions();
  BoxGame game = BoxGame(size);
  runApp(game.widget);
}
