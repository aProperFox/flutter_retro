import 'package:flutter/material.dart';

TextTheme getTextTheme() {
  return new TextTheme(
    display1: RetroItemStyle,
    display2: TimerStyle,
    display3: VotesStyle
  );
}

const TextStyle RetroItemStyle = const TextStyle(
  color: Colors.white,
  fontStyle: FontStyle.normal,
  fontSize: 20.0
);

const TextStyle RetroItemStyleDone = const TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.normal,
    fontSize: 20.0
);

const TextStyle TimerStyle = const TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontSize: 40.0
);

const TextStyle VotesStyle = const TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.normal,
    fontSize: 12.0
);