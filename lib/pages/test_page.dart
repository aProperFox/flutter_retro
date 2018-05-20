import 'package:flutter/material.dart';
import 'package:flutter_retro/components/dialogs.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/sub_views.dart';

class ViewTesterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new RetroItem(
          "Look, a retro item!",
          Colors.deepPurple,
        ),
        new RetroBoardItem(
          "Look, a retro board item!",
          "Not displayed",
          new Text("This is a subtitle"),
          () {},
        ),
        new TimerText(new Stopwatch()..start()),
        new Padding(padding: new EdgeInsets.all(8.0)),
        new AnimatedClock(new Duration(seconds: 120)),
      ],
    );
  }
}
