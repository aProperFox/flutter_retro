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
    final newRetroBoard = await retroBoardRepo.addItem(text, _selectedIndex);
    setState(() {
      retroBoard = newRetroBoard;
    });
  }

  @override
  void initState() {
    controller = new PageController(initialPage: 0);
    initItems();
    super.initState();
  }

  void initItems() async {
    retroBoardRepo = LocalRetroBoardRepo(widget.boardId);
    final board = await retroBoardRepo.getRetroBoard();
    setState(() {
      retroBoard = board;
    });
  }

  List<BottomNavigationBarItem> getItems(List<Category> items) {
    return items.map((category) {
      return BottomNavigationBarItem(
        icon: Icon(category.icon),
        title: Text(category.name),
        backgroundColor: category.color,
      );
    }).toList();
  }

  Widget getBottomNavBar() {
    if (retroBoard == null) {
      return null;
    }
    return BottomNavigationBar(
      items: getItems(retroBoard.columns),
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: (int index) => setState(() {
            controller.animateToPage(index,
                duration: new Duration(milliseconds: 300),
                curve: Curves.easeInOut);
            _selectedIndex = index;
          }),
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

  Widget getPageView() {
    if (retroBoard == null) {
      return null;
    }
    return PageView(
      onPageChanged: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      controller: controller,
      children: retroBoard.columns.map((category) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
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
              return itemView;
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
