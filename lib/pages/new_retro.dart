import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import '../api/repos.dart';
import '../api/models.dart';
import '../util/icons_helper.dart';

class NewRetroPage extends StatefulWidget {
  TextEditingController _nameController;
  TextField _nameInputField;
  TextEditingController _dateController;
  TextField _dateInputField;

  NewRetroPage() {
    _nameController = new TextEditingController();
    _nameInputField = new TextField(
      controller: _nameController,
      maxLength: 30,
      maxLines: 1,
    );
    _dateController = TextEditingController();
    _dateInputField = new TextField(
      controller: _dateController,
      maxLines: 1,
      style: TextStyle(fontSize: 24.0),
    );
  }

  @override
  NewRetroPageState createState() {
    return new NewRetroPageState();
  }
}

class NewRetroPageState extends State<NewRetroPage> {
  List<ColumnConfigItem> columns = List();

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget._nameInputField,
      ),
    ];
    children.addAll(columns);
    children.add(FlatButton(
        onPressed: () {
          setState(() {
            columns.add(ColumnConfigItem());
          });
        },
        child: Text("Add Column")));
    children.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget._dateInputField,
    ));
    children.add(MaterialButton(
      onPressed: () {},
      child: Text("Create Retro"),
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new retro"),
      ),
      body: Column(children: children),
    );
  }
}
