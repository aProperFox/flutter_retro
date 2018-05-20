import 'package:flutter/material.dart';
import 'package:flutter_retro/components/sub_views.dart';

class RetroItemReviewPage extends StatefulWidget {
  final Color background;
  final String subject;

  RetroItemReviewPage(this.background, this.subject);

  @override
  RetroItemReviewPageState createState() {
    return new RetroItemReviewPageState();
  }
}

class RetroItemReviewPageState extends State<RetroItemReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.background,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                children: <Widget>[
                  new Expanded(
                    child: Text(widget.subject,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: new Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: AnimatedClock(
                    Duration(minutes: 2),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  child: Text(
                    "FINISH",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
