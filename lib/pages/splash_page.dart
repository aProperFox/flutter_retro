import 'package:flutter/material.dart';
import 'package:flutter_retro/network/clients.dart';
import 'package:flutter_retro/pages/retro_board_list.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SplashPageState();
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
    ticker.timeout(new Duration(seconds: 1), onTimeout: () {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(
            builder: RetroBoardList.builder,
          ),
          (Route route) => route == null);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                quote,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  height: 1.3,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            new Padding(padding: new EdgeInsets.symmetric(vertical: 8.0)),
            new LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
