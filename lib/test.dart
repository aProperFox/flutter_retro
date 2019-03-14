import 'package:flutter/material.dart';
import 'package:flutter_retro/pages/splash_page.dart';
import 'package:flutter_retro/pages/test_page.dart';
import 'package:flutter_retro/res/text.dart';

void main() => runApp(new TestApp());

class TestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Test views here",
      theme: new ThemeData(
          primarySwatch: Colors.blue
      ),
      home: new ViewTesterPage(),
    );
  }
}