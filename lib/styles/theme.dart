import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_retro/res/text.dart';
import 'colors.dart' as AppColors;

ThemeData AndroidTheme = ThemeData(
  primaryColor: AppColors.primary,
  accentColor: AppColors.primary2,
  primaryColorLight: AppColors.primary3,
  primaryColorDark: AppColors.grey,
  disabledColor: AppColors.grey3,
  textTheme: TextTheme().apply(fontFamily: 'Lato'),
);

ThemeData iOSTheme = new ThemeData(
    primaryColor: AppColors.primary4,
    accentColor: AppColors.primary,
    primaryColorLight: AppColors.grey4,
    primaryColorDark: AppColors.grey,
    disabledColor: AppColors.grey3);

ThemeData themeProvider(BuildContext context) {
  if (Theme.of(context).platform == TargetPlatform.android) {
    return AndroidTheme;
  } else {
    return iOSTheme;
  }
}

AppBar iOSAppBar = new AppBar(
  title: new Text(
    AppTitle,
    textAlign: TextAlign.center,
  ),
);

AppBar androidAppBar = new AppBar(
  title: new Text(
    AppTitle,
    textAlign: TextAlign.left,
  ),
);
