import 'package:flutter/material.dart';
import 'package:flutter_retro/components/buttons.dart';
import 'package:flutter_retro/components/sub_views.dart';

class RetroItemReviewPage extends StatefulWidget {
  final Color background;
  final String subject;
  final String categoryName;

  RetroItemReviewPage(this.background, this.subject, this.categoryName);

  @override
  RetroItemReviewPageState createState() {
    return new RetroItemReviewPageState();
  }
}

class RetroItemReviewPageState extends State<RetroItemReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.background,
        title: Text(widget.categoryName),
      ),
      body: Material(
        color: widget.background,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: <Widget>[
                    new Expanded(
                      child: Text(
                        widget.subject,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
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
                  MainButton(
                    "Finish",
                    () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
