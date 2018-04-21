import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_retro/styles/text.dart';

class TimerText extends StatefulWidget {
  TimerText(this.stopwatch);
  final Stopwatch stopwatch;

  TimerTextState createState() => new TimerTextState(stopwatch);
}

class TimerTextState extends State<TimerText> {

  Timer timer;
  final Stopwatch stopwatch;
  int minutes = 0;
  int seconds = 0;

  TimerTextState(this.stopwatch) {
    timer = new Timer.periodic(new Duration(milliseconds: 200), callback);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    seconds = (stopwatch.elapsedMilliseconds / 1000).truncate();
    minutes = (seconds / 60).truncate();
        super.initState();
  }

  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {
        seconds = (stopwatch.elapsedMilliseconds / 1000).truncate();
        minutes = (seconds / 60).truncate();
      });
    }
  }

  String _truncate(int tick) {
    int modded = (tick % 60);
    return "${modded > 9 ? modded : "0$modded"}";
  }

  @override
  Widget build(BuildContext context) {
    return new Text("${_truncate(minutes)}:${_truncate(seconds)}", style: TimerStyle);
  }
}