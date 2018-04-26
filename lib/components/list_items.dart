import 'package:flutter/material.dart';
import 'package:flutter_retro/pages/retro_board.dart';
import 'package:flutter_retro/styles/text.dart';
import 'package:flutter_retro/styles/theme.dart';
import 'sub_views.dart';

class RetroItem extends StatefulWidget {
  final String text;
  final Color background;

  RetroItem(this.text, this.background);

  VoidCallback callback;

  void addOnLongPressListener(VoidCallback callback) {
    this.callback = callback;
  }

  @override
  State<StatefulWidget> createState() => new _RetroItemState();
}

class _RetroItemState extends State<RetroItem> {
  int votes;
  RetroItemState status;
  Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Material(
            color: widget.background,
            child: new InkWell(
              onLongPress: widget.callback,
              onTap: onTap,
              child: new Container(
                constraints: new BoxConstraints(minHeight: 80.0),
                padding: const EdgeInsets.all(8.0),
                child: getView(),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  @override
  void initState() {
    status = RetroItemState.UnStarted;
    stopwatch = new Stopwatch();
    super.initState();
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
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    switch (status) {
      case RetroItemState.UnStarted:
        return new Text(
          widget.text,
          style: isAndroid ? RetroItemStyle : iRetroItemStyle,
          softWrap: true,
        );
      case RetroItemState.InProgress:
        return new TimerText(stopwatch);
      case RetroItemState.Finished:
        return new Text(
          widget.text,
          style: isAndroid ? RetroItemStyleDone : iRetroItemStyleDone,
          softWrap: true,
        );
      default:
        return new Text("");
    }
  }
}

enum RetroItemState { UnStarted, InProgress, Finished }

class RetroBoardItem extends StatelessWidget {
  final String title;
  final String id;

  RetroBoardItem(this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Container(
            constraints: new BoxConstraints(minHeight: 80.0),
            color: Colors.lightBlue,
            padding: const EdgeInsets.all(8.0),
            child: new InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          RetroBoardPage.builder(context, title, themeProvider(context))));
                },
                splashColor: Colors.lightBlueAccent,
                highlightColor: Colors.white,
                child: new Text(
                  title,
                  style: RetroItemStyle,
                  softWrap: true,
                )),
          ),
        ),
      ),
    ]);
  }
}
