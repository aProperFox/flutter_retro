import 'package:flutter/material.dart';
import 'package:flutter_retro/styles/text.dart';
import 'sub_views.dart';

class RetroItem extends StatefulWidget {
  final String text;
  final Color background;

  RetroItem(this.text, this.background);

  @override
  State<StatefulWidget> createState() => new _RetroItemState();
}

class _RetroItemState extends State<RetroItem> {
  int votes;
  RetroItemState status = RetroItemState.UnStarted;
  Stopwatch stopwatch = new Stopwatch();

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Container(
            constraints: new BoxConstraints(minHeight: 80.0),
            color: widget.background,
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
              onTap: onTap,
              splashColor: Colors.lightBlueAccent,
              highlightColor: Colors.white,
              child: getView(),
            ),
          ),
        ),
      )
    ]);
  }

  void onTap() {
    setState(() {
      switch (status) {
        case RetroItemState.UnStarted:
          stopwatch.start();
          status = RetroItemState.InProgress;
          break;
        case RetroItemState.InProgress:
          stopwatch.stop();
          status = RetroItemState.Finished;
          break;
        case RetroItemState.Finished:
          stopwatch.start();
          status = RetroItemState.InProgress;
      }
    });
  }

  Widget getView() {
    switch (status) {
      case RetroItemState.UnStarted:
        return new Text(
          widget.text,
          style: RetroItemStyle,
          softWrap: true,
        );
      case RetroItemState.InProgress:
        return new TimerText(stopwatch);
      case RetroItemState.Finished:
        return new Text(
          widget.text,
          style: RetroItemStyle,
          softWrap: true,
        );
      default:
        return new Text("");
    }
  }
}

enum RetroItemState { UnStarted, InProgress, Finished }
