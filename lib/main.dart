import 'package:boxdash/game.dart';
import 'package:flame/flame.dart';
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
  runApp(MaterialApp(
      home: Scaffold(
    body: Container(
      child: Home(score: 0),
    ),
  )));
}

class Home extends StatelessWidget {
  final int score;
  Home({@required this.score});
  @override
  Widget build(BuildContext context) {
    game = BoxGame(size, context);
    return Container(
      color: Color(0xfff6efa6),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text("Play"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GameWrapper(game);
                    },
                  ),
                );
              },
            ),
            score != 0 ? Text("Score = " + score.toString()) : Container(),
          ],
        ),
      ),
    );
  }
}

class GameWrapper extends StatelessWidget {
  final BoxGame game;
  GameWrapper(this.game);
  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}
