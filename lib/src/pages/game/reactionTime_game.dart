import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ReactionTime extends StatefulWidget {
  ReactionTime({Key key}) : super(key: key);

  @override
  _ReactionTimeState createState() => _ReactionTimeState();
}

class _ReactionTimeState extends State<ReactionTime> {
  String statusGame = "Start";
  var stopwatch = new Stopwatch();

  Random rnd = new Random();
  int min = 1, max = 20;
  Timer _timer;

  String _score;

  @override
  void initState() {
    super.initState();
  }

  void initGame() {
    int _counter = min + rnd.nextInt(max - min);
    if (_timer == null || _timer.isActive == false) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        print(_counter);
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          setState(() {
            this.statusGame = "PressNow";
            startCount();
          });
        }
      });
    } else {
      _timer.cancel();
    }
  }

  void startCount() {
    this.stopwatch.start();
  }

  void stopCount() {
    if (stopwatch.isRunning) {
      this._score = (stopwatch.elapsedMilliseconds).toString();
      stopwatch.stop();
      stopwatch.reset();
      setState(() {
        this.statusGame = "End";
      });
    }
  }

  void tooSoon() {
    _timer.cancel();
    setState(() {
      statusGame = "TooSoon";
    });
  }

  void changeColor() {
    setState(() {
      this.statusGame = "InProcess";
      initGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Reaction time game"),
          centerTitle: true,
        ),
        body: Builder(builder: (BuildContext context) {
          if (statusGame == "Start") {
            return GestureDetector(
              onTap: () {
                changeColor();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "Reaction Time Test",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "When the red box turns green, click as quickly as you can.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Click anywhere to start.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          } else if (statusGame == "InProcess") {
            return GestureDetector(
              onTap: () {
                tooSoon();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "Wait for the color to change",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          } else if (statusGame == "End") {
            return GestureDetector(
              onTap: () {
                changeColor();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "$_score ms",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Click anywhere to retry.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          } else if (statusGame == "PressNow") {
            return GestureDetector(
              onTap: () {
                stopCount();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "Click Now!!!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Check your time!!!x",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                changeColor();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_late,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      "Too soon!!!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Click anywhere to retry.",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }
        }));
  }
}
