import 'package:flutter/material.dart';
import 'package:flutter_retro/pages/retro_board.dart';
import 'package:flutter_retro/styles/text.dart';
import 'package:flutter_retro/styles/theme.dart';
import 'sub_views.dart';
import 'package:flutter_retro/pages/retro_item_review.dart';

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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RetroItemReviewPage(widget.background, widget.text);
                    },
                  ),
                );
              },
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
          style: RetroItemStyleDone,
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
  final Widget subtitle;
  final Function() onTap;

  RetroBoardItem(this.title, this.id, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Material(
            color: Colors.lightBlue,
            child: new InkWell(
              onTap: onTap,
              child: new Container(
                alignment: Alignment.topLeft,
                constraints: new BoxConstraints(minHeight: 80.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    new Text(
                      title,
                      style: RetroBoardTitleStyle,
                      softWrap: true,
                    ),
                    subtitle,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
