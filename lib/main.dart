import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _timerValue = "GO!";
  GameState gameState = GameState.readyToStart;
  Color _buttonColor = Color(0xFF40CA88);
  Timer? waitingTimer;
  Timer? stopTimer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF282E3D),
        body: SafeArea(
          child: Stack(children: [
            Container(
              alignment: Alignment(0, -0.8),
              margin: EdgeInsets.only(top: 25),
              child: Text(
                "Test your\nspeed reaction",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 38),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ColoredBox(
                color: Color(0xFF6D6D6D),
                child: SizedBox(
                  width: 300,
                  height: 160,
                  child: Center(
                    child: Text(
                      _timerValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0.8),
              child: GestureDetector(
                onTap: () => setState(() {
                  switch (gameState) {
                    case GameState.readyToStart:
                      gameState = GameState.Waiting;
                      _buttonColor = Color(0xFFE0982D);
                      _timerValue = "Get ready";
                      _startWaitingTimer();
                      break;
                    case GameState.Waiting:
                      gameState = GameState.canBeStop;
                      _buttonColor = Color(0xFFE0982D);
                      break;
                    case GameState.canBeStop:
                      gameState = GameState.readyToStart;
                      _buttonColor = Color(0xFF40CA88);
                      stopTimer?.cancel();
                      break;
                  }
                }),
                child: Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: ColoredBox(
                    color: _buttonColor,
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                          child: Text(
                        _getButtonText(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 38),
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

      case GameState.Waiting:
        return "WAIT";

      case GameState.canBeStop:
        return "STOP";
    }
  }

  void _startWaitingTimer() {
    final int randMill = Random().nextInt(4000) + 1000;
    print(randMill);
    waitingTimer = Timer(Duration(milliseconds: randMill), () {
      setState(() {
        gameState = GameState.canBeStop;
        _buttonColor = Color(0xFFE02D47);
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
    waitingTimer?.cancel();
    stopTimer?.cancel();
    super.dispose();
  }
}

enum GameState { readyToStart, Waiting, canBeStop }
