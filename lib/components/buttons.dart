import 'package:flutter/material.dart';
import '../styles/text.dart';

class MainButton extends MaterialButton {
  MainButton(String text, VoidCallback onPressed)
      : super(
          child: Text(text, style: ButtonStyle),
          onPressed: onPressed,
          color: Colors.green,
        );
}
