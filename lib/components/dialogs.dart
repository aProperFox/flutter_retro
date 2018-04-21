import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_retro/res/text.dart';

Widget newItemBuilder(BuildContext context, Function(String) onSubmit) {
  TextEditingController _controller =
      new TextEditingController();
  TextField _inputField = new TextField(
    controller: _controller,
    maxLength: 300,
    maxLines: 5,
  );

  void _onNewItem(String text) {
    if (text.length > 0) {
      onSubmit(text);
      Navigator.of(context).pop();
    }
  }

  FlatButton cancelButton = new FlatButton(
    child: new Text(CancelAddButton),
    onPressed: () => Navigator.of(context).pop(),
  );
  FlatButton addButton = new FlatButton(
    child: new Text(AddItemButton),
    onPressed: () => _onNewItem(_controller.text),
  );

  return new AlertDialog(
    title: new Text(NewRetroItemTitle),
    content: _inputField,
    actions: <Widget>[
      cancelButton,
      addButton
    ],
  ).build(context);
}