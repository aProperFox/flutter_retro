import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/dialogs.dart';

class RetroBoardPage extends StatefulWidget {
  static RetroBoardPage builder(BuildContext context, String title) => new RetroBoardPage(title: title);

  final String title;

  RetroBoardPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RetroBoardPageState();
}

class _RetroBoardPageState extends State<RetroBoardPage>
    with SingleTickerProviderStateMixin {
  List<Widget> items = [];

  List<Widget> tabs = [
    new Text(""),
    new Text(""),
    new Text(""),
    new Text(""),
  ];

  TabController controller;

  void onItemAdded(String item) {
    print(item);
    setState(() {
      items.add(new RetroItem(item, Colors.blueAccent));
    });
  }

  @override
  void initState() {
    controller = new TabController(length: tabs.length, vsync: this);
    //items.add(new TabBarView(children: tabs, controller: controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        children: items,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  newItemBuilder(context, onItemAdded));
        },
        child: new Icon(Icons.add),
      ),
    );
  }
}
