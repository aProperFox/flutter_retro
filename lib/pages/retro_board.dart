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

  BottomNavigationBar navBar;

  PageController controller;

  List<BottomNavigationBarItem> tabs;

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

  ThemeData theme;

  @override
  void initState() {
    initItems();
    controller = new PageController(initialPage: 0);
    super.initState();
    theme = Theme.of(context);
  }

  void initItems() async {
    retroBoardRepo = LocalRetroBoardRepo(widget.boardId);
    retroBoard = await retroBoardRepo.getRetroBoard();
    setState(() {
      tabs = retroBoard.columns.map((category) {
        BottomNavigationBarItem(
          icon: Icon(category.icon),
          title: Text(category.name),
          backgroundColor: category.color,
        );
      }).toList();
    });
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
        children: getColumns(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  newItemBuilder(context, onItemAdded));
        },
        backgroundColor: retroBoard.columns[_selectedIndex].color,
        child: new Icon(Icons.add),
      ),
      bottomNavigationBar: navBar,
    );
  }

  List<Widget> getColumns() {
    return retroBoard.columns.map((category) {
      Column(
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
    }).toList();
  }
}
