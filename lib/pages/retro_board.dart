import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/dialogs.dart';
import 'package:flutter_retro/styles/theme.dart';

class RetroBoardPage extends StatefulWidget {
  static RetroBoardPage builder(BuildContext context, String title, ThemeData data) =>
      new RetroBoardPage(title: title, theme: data,);

  final ThemeData theme;
  final String title;

  RetroBoardPage({Key key, this.title, this.theme}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RetroBoardPageState();
}

class _RetroBoardPageState extends State<RetroBoardPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  List<Widget> startItems;
  List<Widget> continueItems;
  List<Widget> stopItems;
  List<Widget> actionItems;

  BottomNavigationBar navBar;

  PageController controller;

  List<BottomNavigationBarItem> tabs;

  void showDeleteDialog(RetroItem item, VoidCallback confirmDeleteCallback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return confirmDeleteBuilder(context, item, confirmDeleteCallback);
        });
  }

  void onItemAdded(String text) {
    print(text);
    setState(() {
      var item = new RetroItem(text, getColor(_selectedIndex));
      switch (_selectedIndex) {
        case 0:
          item.addOnLongPressListener(() => showDeleteDialog(item, () {
                startItems.remove(item);
              }));
          startItems.add(item);
          break;
        case 1:
          item.addOnLongPressListener(() => showDeleteDialog(item, () {
                continueItems.remove(item);
              }));
          continueItems.add(item);
          break;
        case 2:
          item.addOnLongPressListener(() => showDeleteDialog(item, () {
                stopItems.remove(item);
              }));
          stopItems.add(item);
          break;
        case 3:
          item.addOnLongPressListener(() => showDeleteDialog(item, () {
                actionItems.remove(item);
              }));
          actionItems.add(item);
          break;
      }
    });
  }


  @override
  void initState() {
    initItems();
    controller = new PageController(initialPage: 0);
    super.initState();
  }

  void initItems() {
    tabs = [
      new BottomNavigationBarItem(
          icon: new Icon(
            Icons.timeline,
          ),
          title: new Text("Start"),
          backgroundColor: getColor(0)),
      new BottomNavigationBarItem(
          icon: new Icon(
            Icons.thumb_up,
          ),
          title: new Text("Continue"),
          backgroundColor: getColor(1)),
      new BottomNavigationBarItem(
          icon: new Icon(
            Icons.thumb_down,
          ),
          title: new Text("Stop"),
          backgroundColor: getColor(2)),
      new BottomNavigationBarItem(
          icon: new Icon(
            Icons.add_to_photos,
          ),
          title: new Text("Actions"),
          backgroundColor: getColor(3)),
    ];

    startItems = [
      new Padding(padding: new EdgeInsets.only(top: 8.0)),
      new RetroItem("Start using Flutter!", getColor(0)),
    ];
    continueItems = [
      new Padding(padding: new EdgeInsets.only(top: 8.0)),
      new RetroItem("Continue building awesome apps", getColor(1)),
    ];
    stopItems = [
      new Padding(padding: new EdgeInsets.only(top: 8.0)),
      new RetroItem("Stop use React Native", getColor(2)),
    ];
    actionItems = [
      new Padding(padding: new EdgeInsets.only(top: 8.0)),
      new RetroItem(
          "Tyler will keep pestering people about Flutter", getColor(3)),
    ];
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return widget.theme.primaryColor;
      case 1:
        return widget.theme.primaryColorLight;
      case 2: 
        return widget.theme.primaryColorDark;
      case 3:
        return widget.theme.disabledColor;
      default:
        return Colors.black;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navBar = new BottomNavigationBar(
      items: tabs,
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: (int index) => setState(() {
            controller.animateToPage(index,
                duration: new Duration(milliseconds: 300),
                curve: Curves.easeInOut);
            _selectedIndex = index;
          }),
    );
    return new Scaffold(
      appBar: Theme.of(context).platform == TargetPlatform.android
          ? androidAppBar
          : iOSAppBar,
      body: new PageView(
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        controller: controller,
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
        backgroundColor: getColor(_selectedIndex),
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: navBar,
    );
  }
}
