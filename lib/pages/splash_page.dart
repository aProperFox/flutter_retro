import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_retro/network/clients.dart';
import 'package:flutter_retro/pages/retro_board.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation colorAnim;
  final QuoteClient client = new QuoteClient();

  String quote = "";

  void getQuote() async {
    String gotQuote = await client.get();
    setState(() {
      quote = gotQuote;
    });
  }

  @override
  void initState() {
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 300),
    );
    colorAnim = new Tween(begin: 0.0, end: 1.0).animate(controller);
    TickerFuture ticker = controller.repeat();
    ticker.timeout(new Duration(seconds: 3),
    onTimeout: () {
      Navigator.of(context).push(new MaterialPageRoute(builder: RetroBoardPage.builder));
    });
    getQuote();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).accentColor,
      child: new Center(
        child: new Column(
          children: <Widget>[
            new LinearProgressIndicator(),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 16.0)),
            new Text(
              quote,
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
