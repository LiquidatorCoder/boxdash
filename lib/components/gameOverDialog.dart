import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverDialog extends StatelessWidget {
  final String score;
  GameOverDialog({this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          width: 200,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 0, 4),
                child: Container(
                  width: 160,
                  child: Text(
                    'Game Over! Score - $score',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    shape: StadiumBorder(),
                    color: Color(0xFFE57697),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'RESTART',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
