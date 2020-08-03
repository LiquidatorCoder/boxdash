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
  Flame.audio.disableLog();
  Flame.bgm.initialize();
  Flame.bgm.stop();
  Flame.audio.loadAll(['levelup.wav', 'crash.wav', 'bgm.mp3']);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Home(score: 0),
        ),
      )));
}

class Home extends StatefulWidget {
  final int score;

  Home({@required this.score});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int level = 1;
  TextEditingController levelNum = TextEditingController();
  @override
  void initState() {
    levelNum.text = level.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Level  "),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: levelNum,
                    onChanged: (text) {
                      if (text != "") {
                        setState(() {
                          level = int.parse(text);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            RaisedButton(
              child: Text("Play"),
              onPressed: () {
                game = BoxGame(size, level, context);
                TapGestureRecognizer tapper = TapGestureRecognizer();
                tapper.onTapDown = game.onTapDown;
                Flame.util.addGestureRecognizer(tapper);
                Flame.bgm.play('bgm.mp3');
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
            widget.score != 0
                ? Text("Score = " + widget.score.toString())
                : Container(),
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
