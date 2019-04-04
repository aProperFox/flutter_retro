import 'package:flutter/material.dart';
import 'package:flutter_retro/styles/text.dart';
import 'package:flutter_retro/util/icons_helper.dart';
import 'sub_views.dart';
import 'package:flutter_retro/pages/retro_item_review.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import '../styles/colors.dart' as AppColors;

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
                    Text(
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

  String getName() {
  }

  Color getColor() {

  }

  IconData getIcon() {

  }
}

class _ColumnConfigItemState extends State<ColumnConfigItem> {
  TextEditingController nameController = TextEditingController();

  Color selectedColor = AppColors.blue;
  IconData selectedIcon = Icons.add;

  static const List<Color> colors = [
    AppColors.blue,
    AppColors.green,
    AppColors.red,
    AppColors.purple,
    AppColors.yellow,
  ];

  Widget buildTextInput() => Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: nameController,
            maxLength: 32,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: AppColors.grey3,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey3),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
        ),
      );

  Widget buildColorButton() => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            height: 56.0,
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: selectedColor,
                shape: BoxShape.circle,
              ),
              width: 36.0,
              height: 36.0,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select a color'),
                      content: SingleChildScrollView(
                        child: BlockPicker(
                          availableColors: colors,
                          pickerColor: selectedColor,
                          onColorChanged: (color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                      ),
                    );
                  });
            },
            splashColor: AppColors.grey3,
          ),
        ),
      );

  Widget buildIconPicker() => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            height: 56.0,
            color: Colors.white,
            child: Icon(
              selectedIcon,
              color: AppColors.grey,
              size: 24.0,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select a color'),
                      content: SingleChildScrollView(
                          child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        children: IconsMap.values.map((iconData) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIcon = iconData;
                              });
                            },
                            child: Icon(
                              iconData,
                              color: AppColors.grey,
                              size: 24.0,
                            ),
                          );
                        }).toList(),
                      )),
                    );
                  });
            },
            splashColor: AppColors.grey3,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildTextInput(),
        buildColorButton(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(onPressed: () {}),
        ),
      ],
    );
  }
}
