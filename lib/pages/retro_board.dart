import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/dialogs.dart';

class RetroBoardPage extends StatefulWidget {
  static RetroBoardPage builder(BuildContext context, String title) =>
      new RetroBoardPage(title: title);

  final String title;

  RetroBoardPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RetroBoardPageState();
}

class _RetroBoardPageState extends State<RetroBoardPage>
    with SingleTickerProviderStateMixin {
  List<Widget> startItems = [];
  List<Widget> stopItems = [];
  List<Widget> continueItems = [];
  List<Widget> actionItems = [];

  BottomNavigationBar navBar;

  List<BottomNavigationBarItem> tabs = [
    new BottomNavigationBarItem(
      icon: new Icon(Icons.timeline),
      title: new Text("Start"),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(Icons.thumb_up),
      title: new Text("Continue"),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(Icons.thumb_down),
      title: new Text("Stop"),
    ),
    new BottomNavigationBarItem(
      icon: new Icon(Icons.add_to_photos),
      title: new Text("Actions"),
    ),
  ];

  void showDeleteDialog(List<Widget>)

  void onItemAdded(String item) {
    print(item);
    setState(() {
      switch(navBar.currentIndex) {
        case 0:
          startItems.add(new RetroItem(item, Colors.blueAccent)
          ..addOnLongPressListener(() => showDeleteDialog()));
          break;
        case 1:
          stopItems.add(new RetroItem(item, Colors.green));
          break;
        case 2:
          continueItems.add(new RetroItem(item, Colors.red));
          break;
        case 3:
          actionItems.add(new RetroItem(item, Colors.deepPurple));
          break;
    }
    });
  }

  @override
  void initState() {
    navBar = new BottomNavigationBar(items: tabs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new PageView(
          children: [
            new Column(
              children: startItems,
            ),
            new Column(
              children: continueItems,
            ),
            new Column(
              children: stopItems,
            ),
            new Column(
              children: actionItems,
            ),
          ],
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
      bottomNavigationBar: navBar,
    );
  }
}
