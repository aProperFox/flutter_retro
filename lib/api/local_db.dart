import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_retro/api/models.dart';
import 'package:flutter_retro/api/repos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/colors.dart' as AppColors;

const String _KEY_BOARD_LIST = "key_board_list";
const String _KEY_RETRO_BOARD_PREFIX = "key_retro_board_prefix_";

class LocalDb extends RetroRepo {
  static final LocalDb _instance = LocalDb._internal();

  LocalDb._internal();

  factory LocalDb.getInstance() {
    return _instance;
  }

  static final List<Category> _defaultColumns = [
    Category(
        name: "Continue",
        icon: Icons.thumb_up,
        color: AppColors.green,
        items: []),
    Category(
        name: "Stop", icon: Icons.thumb_down, color: AppColors.red, items: []),
    Category(
        name: "Start", icon: Icons.timeline, color: AppColors.blue, items: []),
    Category(
        name: "Actions",
        icon: Icons.fast_forward,
        color: AppColors.purple,
        items: []),
  ];

  @override
  Future<RetroBoard> createRetroBoard(
    String name,
    List<Category> columns,
    DateTime dueDate,
    String teamName,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final id = DateTime.now().toIso8601String();
    final retroBoard = RetroBoard(
        id: id, dueDate: dueDate, teamName: teamName, columns: columns, name: name);
    String json = jsonEncode(retroBoard.toJson());
    print("Creating retro board:\n$json");
    final key = _buildKey(id);
    await sharedPreferences.setString(key, json);
    _updateIndex(key);
    return retroBoard;
  }

  @override
  Future<RetroBoard> createDefaultRetroBoard(String title) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final id = DateTime.now().toIso8601String();
    final retroBoard = RetroBoard(
        id: id,
        dueDate: DateTime(3000),
        teamName: null,
        columns: _defaultColumns,
        name: title);
    String json = jsonEncode(retroBoard.toJson());
    print("Creating retro board:\n$json");
    final key = _buildKey(id);
    await sharedPreferences.setString(key, json);
    _updateIndex(key);
    return retroBoard;
  }

  @override
  Future deleteRetroBoard(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = _buildKey(id);
    await sharedPreferences.remove(key);
    _updateIndex(key);
  }

  @override
  Future<RetroBoard> getRetroBoard(String id) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = _buildKey(id);
    var json = sharedPreferences.getString(key);
    var map = jsonDecode(json);
    return RetroBoard.fromJson(map);
  }

  @override
  Future<List<RetroBoard>> getRetroBoards(String teamId) async {
    print("Warning: Team index is not yet implemented. Getting all boards");
    final sharedPreferences = await SharedPreferences.getInstance();
    final keys = sharedPreferences
        .getKeys()
        .takeWhile((key) => key.startsWith(_KEY_RETRO_BOARD_PREFIX))
        .toList();
    return keys?.map((key) {
          var json = sharedPreferences.getString(key);
          var map = jsonDecode(json);
          return RetroBoard.fromJson(map);
        })?.toList() ??
        List();
  }

  @override
  Future<RetroBoard> updateRetroBoard(RetroBoard retro) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = _buildKey(retro.id);
    String json = jsonEncode(retro.toJson());
    print("Updating retro board:\n$json");

    await sharedPreferences.setString(key, json);
    return retro;
  }

  String _buildKey(String id) {
    return "$_KEY_RETRO_BOARD_PREFIX$id";
  }

  void _updateIndex(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final boardList =
        sharedPreferences.getStringList(_KEY_BOARD_LIST) ?? List();

    var isAddition = sharedPreferences.getString(key) != null;
    if (isAddition) {
      boardList.add(key);
    } else {
      boardList.remove(key);
    }
    await sharedPreferences.setStringList(_KEY_BOARD_LIST, boardList);
  }
}

class LocalRetroBoardRepo extends RetroBoardRepo {
  @override
  final String id;

  LocalRetroBoardRepo(this.id) : super(id);

  final LocalDb localDb = LocalDb.getInstance();

  @override
  Future<RetroBoard> addItem(String text, int categoryIndex) async {
    var retroBoard = await localDb.getRetroBoard(id);
    var column = retroBoard.columns[categoryIndex];
    var time = DateTime.now();
    var retroItem = RetroItem(
        id: time.toIso8601String(),
        description: text,
        createdAt: time,
        updatedAt: time,
        votes: 0,
        comments: List());
    column.items.add(retroItem);
    retroBoard.columns[categoryIndex] = column;
    return await localDb.updateRetroBoard(retroBoard);
  }

  @override
  Future<RetroBoard> getRetroBoard() async {
    return await localDb.getRetroBoard(id);
  }

  @override
  Future<RetroBoard> removeItem(RetroItem item) async {
    var retroBoard = await localDb.getRetroBoard(id);
    final categoryIndex = await getItemCategoryIndex(item);
    var column = retroBoard.columns[categoryIndex];
    column.items.remove(item);
    retroBoard.columns[categoryIndex] = column;
    return await localDb.updateRetroBoard(retroBoard);
  }

  @override
  Future<RetroBoard> updateItem(RetroItem item) async {
    var retroBoard = await localDb.getRetroBoard(id);
    final categoryIndex = await getItemCategoryIndex(item);
    var column = retroBoard.columns[categoryIndex];
    final itemIndex = column.items.indexWhere((child) => child.id == item.id);
    column.items[itemIndex] = item;
    retroBoard.columns[categoryIndex] = column;
    return await localDb.updateRetroBoard(retroBoard);
  }

  Future<int> getItemCategoryIndex(RetroItem item) async {
    final retroBoard = await localDb.getRetroBoard(id);
    return retroBoard.columns.indexWhere((category) =>
        category.items
            .singleWhere((child) => child.id == item.id, orElse: null) !=
        null);
  }
}
