import 'package:flutter/material.dart';
import 'package:flutter_retro/pages/retro_board.dart';
import 'package:flutter_retro/res/text.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: AppTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RetroBoardPage(title: AppTitle),
    );
  }
}