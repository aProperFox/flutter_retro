import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/sub_views.dart';

class ViewTesterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          ColumnConfigItem()
        ],
      ),
    );
  }
}
