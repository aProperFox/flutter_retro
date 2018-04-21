import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/res/text.dart';
import 'package:flutter_retro/components/dialogs.dart';

class RetroBoardPage extends StatefulWidget {
  final String title;

  RetroBoardPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _RetroBoardPageState();
}

class _RetroBoardPageState extends State<RetroBoardPage> {
  List<Widget> items = [];

  void onItemAdded(String item) {
    print(item);
    setState(() {
      items.add(new RetroItem(item, Colors.blueAccent));
    });
  }

  @override
  void initState() {
    items.add(new RetroItem(
        "This is a test item. I love pancakes.",
        Colors.blueAccent));
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
