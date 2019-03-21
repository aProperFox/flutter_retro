import 'package:flutter/material.dart';
import 'package:flutter_retro/styles/text.dart';
import 'package:flutter_retro/util/icons_helper.dart';
import 'sub_views.dart';
import 'package:flutter_retro/pages/retro_item_review.dart';

class RetroItemView extends StatefulWidget {
  final String text;
  final Color background;
  final String categoryName;

  RetroItemView(this.text, this.background, this.categoryName);

  VoidCallback callback;

  void addOnLongPressListener(VoidCallback callback) {
    this.callback = callback;
  }

  @override
  State<StatefulWidget> createState() => new _RetroItemState();
}

class _RetroItemState extends State<RetroItemView> {
  int votes;
  RetroItemState status;
  Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Material(
            color: widget.background,
            child: new InkWell(
              onLongPress: widget.callback,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return RetroItemReviewPage(
                          widget.background, widget.text, widget.categoryName);
                    },
                  ),
                );
              },
              child: new Container(
                constraints: new BoxConstraints(minHeight: 80.0),
                padding: const EdgeInsets.all(8.0),
                child: getView(),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  @override
  void initState() {
    status = RetroItemState.UnStarted;
    stopwatch = new Stopwatch();
    super.initState();
  }

  void onTap() {
    setState(() {
      switch (status) {
        case RetroItemState.UnStarted:
          stopwatch.start();
          status = RetroItemState.InProgress;
          break;
        case RetroItemState.InProgress:
          stopwatch.stop();
          status = RetroItemState.Finished;
          break;
        case RetroItemState.Finished:
          stopwatch.start();
          status = RetroItemState.InProgress;
      }
    });
  }

  Widget getView() {
    switch (status) {
      case RetroItemState.UnStarted:
        return new Text(
          widget.text,
          style: RetroItemStyle,
          softWrap: true,
        );
      case RetroItemState.InProgress:
        return new TimerText(stopwatch);
      case RetroItemState.Finished:
        return new Text(
          widget.text,
          style: RetroItemStyleDone,
          softWrap: true,
        );
      default:
        return new Text("");
    }
  }
}

enum RetroItemState { UnStarted, InProgress, Finished }

class RetroBoardItem extends StatelessWidget {
  final String title;
  final String id;
  final Widget subtitle;
  final Function() onTap;

  RetroBoardItem(this.title, this.id, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: new Material(
            color: Colors.lightBlue,
            child: new InkWell(
              onTap: onTap,
              child: new Container(
                alignment: Alignment.topLeft,
                constraints: new BoxConstraints(minHeight: 80.0),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    new Text(
                      title,
                      style: RetroBoardTitleStyle,
                      softWrap: true,
                    ),
                    subtitle,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ColumnConfigItem extends StatefulWidget {
  @override
  _ColumnConfigItemState createState() => _ColumnConfigItemState();
}

class _ColumnConfigItemState extends State<ColumnConfigItem> {
  TextEditingController _nameController = TextEditingController();

  Color selectedColor = Colors.blue;
  IconData selectedIcon = Icons.add;

  static const List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.brown
  ];

  DropdownMenuItem<Color> buildCircle(Color color) {
    return DropdownMenuItem<Color>(
      value: color,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: CircleBorder(),
          color: color,
        ),
        child: Container(
          width: 24.0,
          height: 24.0,
        ),
      ),
    );
  }

  DropdownMenuItem<IconData> buildIconDropDown(IconData icon) {
    return DropdownMenuItem<IconData>(
      value: icon,
      child: Icon(
        icon,
        size: 24.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              maxLength: 16,
              maxLines: 1,
              decoration: InputDecoration(
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: DropdownButton(
              iconSize: 24.0,
              value: selectedColor,
              items: colors.map((color) => buildCircle(color)).toList(),
              onChanged: (color) => setState(() => selectedColor = color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            value: selectedIcon,
            items:
                IconsMap.values.map((icon) => buildIconDropDown(icon)).toList(),
            onChanged: (icon) {
              setState(() {
                selectedIcon = icon;
              });
            },
          ),
        ),
      ],
    );
  }
}
