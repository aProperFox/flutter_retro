import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_retro/api/local_db.dart';
import 'package:flutter_retro/api/models.dart';
import 'package:flutter_retro/api/repos.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/components/dialogs.dart';
import 'package:flutter_retro/styles/theme.dart';

class RetroBoardPage extends StatefulWidget {
  final String boardId;

  RetroBoardPage(this.boardId);

  @override
  State<StatefulWidget> createState() => new _RetroBoardPageState();
}

class _RetroBoardPageState extends State<RetroBoardPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  RetroBoard retroBoard;

  PageController controller;

  RetroBoardRepo retroBoardRepo;

  void showDeleteDialog(
      RetroItemView item, VoidCallback confirmDeleteCallback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return confirmDeleteBuilder(context, item, confirmDeleteCallback);
        });
  }

  void onItemAdded(String text) async {
    print(text);
    var newRetroBoard = await retroBoardRepo.addItem(text, _selectedIndex);
    setState(() {
      retroBoard = newRetroBoard;
    });
  }

  @override
  void initState() {
    controller = new PageController(initialPage: 0);
    retroBoardRepo = LocalRetroBoardRepo(widget.boardId);
    super.initState();
  }

  Future<List<Category>> getCategories() async {
    retroBoard = await retroBoardRepo.getRetroBoard();
    return retroBoard.columns;
  }

  Future<List<BottomNavigationBarItem>> getItems() async {
    final columns = await getCategories();
    return columns.map((category) {
      return BottomNavigationBarItem(
        icon: Icon(category.icon),
        title: Text(category.name),
        backgroundColor: category.color,
      );
    }).toList();
  }

  FutureBuilder<List<BottomNavigationBarItem>> getBottomNavBar() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavigationBar(
            items: snapshot.data,
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            onTap: (int index) => setState(() {
                  controller.animateToPage(index,
                      duration: new Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  _selectedIndex = index;
                }),
          );
        } else {
          return Container();
        }
      },
      future: getItems(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: Theme.of(context).platform == TargetPlatform.android
          ? androidAppBar
          : iOSAppBar,
      body: getPageView(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  newItemBuilder(context, onItemAdded));
        },
        backgroundColor: getColor(),
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: getBottomNavBar(),
    );
  }

  Color getColor() {
    if (retroBoard != null) {
      return retroBoard.columns[_selectedIndex].color;
    } else {
      return Colors.blue;
    }
  }

  FutureBuilder<List<Category>> getPageView() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return new PageView(
          onPageChanged: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          controller: controller,
          children: snapshot.data.map((category) {
            return Column(
              children: category.items.map((item) {
                var itemView = RetroItemView(
                  item.description,
                  category.color,
                  category.name,
                );
                itemView.addOnLongPressListener(() {
                  showDeleteDialog(itemView, () async {
                    final newRetroBoard = await retroBoardRepo.removeItem(item);
                    setState(() {
                      retroBoard = newRetroBoard;
                    });
                  });
                });
              }).toList(),
            );
          }).toList(),
        );
      },
      future: getCategories(),
    );
  }
}
