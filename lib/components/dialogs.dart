import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_retro/api/repos.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/res/text.dart';

Widget newItemBuilder(BuildContext context, Function(String) onSubmit) {
  TextEditingController _controller = new TextEditingController();
  TextField _inputField = new TextField(
    controller: _controller,
    maxLength: 300,
    maxLines: 3,
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
    actions: <Widget>[cancelButton, addButton],
  ).build(context);
}

Widget confirmDeleteBuilder(
    BuildContext context, RetroItemView item, VoidCallback onSubmit) {
  void _onConfirm() {
    onSubmit();
    Navigator.of(context).pop();
  }

  FlatButton cancelButton = new FlatButton(
    child: new Text(CancelAddButton),
    onPressed: () => Navigator.of(context).pop(),
  );
  FlatButton addButton = new FlatButton(
    child: new Text(AddItemButton),
    onPressed: _onConfirm,
  );

  return new AlertDialog(
    title: new Text("Are you sure you want to delete this item?"),
    content: item,
    actions: <Widget>[cancelButton, addButton],
  ).build(context);
}

Widget newRetroBoardBuilder(BuildContext context, Function(String) callback) {
  TextEditingController _controller = new TextEditingController();
  TextField _inputField = new TextField(
    controller: _controller,
    maxLength: 30,
    maxLines: 1,
  );

  void _onNewItem(String text) {
    if (text.length > 0) {
      callback(text);
      Navigator.of(context).pop();
    }
  }

  FlatButton cancelButton = new FlatButton(
    child: new Text(CancelAddButton),
    onPressed: () => Navigator.of(context).pop(),
  );
  FlatButton addButton = new FlatButton(
    child: new Text(CreateRetroBoard),
    onPressed: () => _onNewItem(_controller.text),
  );

  return new AlertDialog(
    title: new Text(NewRetroBoardTitle),
    content: _inputField,
    actions: <Widget>[cancelButton, addButton],
  ).build(context);
}
