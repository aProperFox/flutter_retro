import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_retro/res/text.dart';

ThemeData AndroidTheme = new ThemeData(
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  primaryColorLight: Colors.green,
  primaryColorDark: Colors.red,
  disabledColor: Colors.pink
);

ThemeData iOSTheme = new ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.blueGrey,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.white,
  disabledColor: Colors.white
);

ThemeData themeProvider(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.android) {
    return AndroidTheme;
  } else {
    return iOSTheme;
  }
}

AppBar iOSAppBar = new AppBar(
  title: new Text(AppTitle, textAlign: TextAlign.center,),
);

AppBar androidAppBar = new AppBar(
  title: new Text(AppTitle, textAlign: TextAlign.left,),
);