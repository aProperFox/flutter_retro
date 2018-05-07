import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_retro/components/arc_ticker.dart';
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
    return new Text(
      "${_truncate(minutes)}:${_truncate(seconds)}",
      style: Theme.of(context).platform == TargetPlatform.android
          ? TimerStyle
          : iTimerStyle,
      textAlign: TextAlign.center,
    );
  }
}

class SteppedColorAnimation extends Animation<Color> {
  final Animation<double> parent;
  final List<double> steps;
  final List<Color> stepColors;

  SteppedColorAnimation(this.parent, this.steps, this.stepColors) {
    // ignore: unrelated_type_equality_checks
    //assert(steps.length == stepColors);
  }

  @override
  Color get value =>
      stepColors[steps.indexWhere((value) => value > parent.value)];

  @override
  void addListener(VoidCallback listener) {
    parent.addListener(listener);
  }

  @override
  void addStatusListener(AnimationStatusListener listener) {
    parent.addStatusListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    parent.removeListener(listener);
  }

  @override
  void removeStatusListener(AnimationStatusListener listener) {}

  @override
  AnimationStatus get status => parent.status;
}

class AnimatedClock extends StatefulWidget {
  final Duration limit;

  AnimatedClock(
    this.limit, {
    this.fullColor: Colors.green,
    this.warningColor: Colors.yellow,
    this.overflowColor: Colors.red,
    this.warningTime: const Duration(seconds: 10),
  });

  Color fullColor;
  Color warningColor;
  Color overflowColor;
  Duration warningTime;

  @override
  State<StatefulWidget> createState() => new AnimatedClockState();
}

class AnimatedClockState extends State<AnimatedClock>
    with SingleTickerProviderStateMixin {
  //double progress;
  AnimationController controller;
  Animation<double> progress;
  SteppedColorAnimation color;

  //Ticker ticker;

  @override
  void initState() {
    controller = new AnimationController(vsync: this, duration: widget.limit);
    progress =
        new Tween<double>(begin: 0.0, end: widget.limit.inSeconds.toDouble())
            .animate(controller);
    /*ticker = createTicker((Duration duration) {
      progress = 
    });*/
    color = new SteppedColorAnimation(
        controller,
        [double.negativeInfinity, 0.0, 10.0],
        [widget.overflowColor, widget.warningColor, widget.fullColor]);
    super.initState();
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
        aspectRatio: 1.0,
        child: new Container(
          constraints: new BoxConstraints(
              minWidth: 50.0,
              minHeight: 50.0,
              maxWidth: 100.0,
              maxHeight: 100.0),
          decoration: new ShapeDecoration(
            shape: new CircleBorder(
              side: new BorderSide(
                color: Colors.blueGrey,
                width: 8.0,
              ),
            ),
          ),
          child: new CustomPaint(
            painter:
                new ArcTicker(new Paint()..color = color.value, progress.value / widget.limit.inSeconds.toDouble()),
          ),
        ));
  }
}
