import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  String _timerValue = "GO!";
  GameState gameState = GameState.readyToStart;
  Color _buttonColor = Colors.green;
  Timer waitingTimer;
  Timer stopTimer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF2d3436),
        body: SafeArea(
          child: Stack(children: [
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 25),
              child: Text(
                "Test your\nspeed reaction",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 28),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ColoredBox(
                color: Color(0xFFb2bec3),
                child: SizedBox(
                  width: 300,
                  height: 160,
                  child: Center(
                    child: Text(
                      _timerValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => setState(() {
                  switch (gameState) {
                    case GameState.readyToStart:
                      gameState = GameState.Waiting;
                      _buttonColor = Colors.yellow;
                      _timerValue = "Get ready";
                      _startWaitingTimer();
                      break;
                    case GameState.Waiting:
                      gameState = GameState.canBeStop;
                      _buttonColor = Colors.red;

                      break;
                    case GameState.canBeStop:
                      gameState = GameState.readyToStart;
                      _buttonColor = Colors.green;
                      stopTimer.cancel();

                      break;
                  }
                }),
                child: Container(
                  margin: EdgeInsets.only(bottom: 35),
                  color: Colors.amber,
                  child: ColoredBox(
                    color: _buttonColor,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                          child: Text(
                        _getButtonText(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      )),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  String _getButtonText() {
    switch (gameState) {
      case GameState.readyToStart:
        return "START";
        break;
      case GameState.Waiting:
        return "WAIT";
        break;
      case GameState.canBeStop:
        return "STOP";
        break;
    }
    return "";
  }

  void _startWaitingTimer() {
    final int randMill = Random().nextInt(4000) + 1000;
    print(randMill);
    waitingTimer = Timer(Duration(milliseconds: randMill), () {
      setState(() {
        gameState = GameState.canBeStop;
        _buttonColor = Colors.red;
        _startPerTimer();
      });
    });
  }

  void _startPerTimer() {
    stopTimer = Timer.periodic(Duration(microseconds: 16), (timer) {
      setState(() {
        _timerValue = "${timer.tick * 16} ms";
      });
    });
  }

  @override
  void dispose() {
    waitingTimer.cancel();
    stopTimer.cancel();
    super.dispose();
  }
}

enum GameState { readyToStart, Waiting, canBeStop }
