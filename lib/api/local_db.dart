import 'dart:async';
import 'dart:convert';

import 'package:flutter_retro/api/models.dart';
import 'package:flutter_retro/api/repos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb extends RetroRepo {
  static const String _KEY_BOARD_LIST = "key_board_list";
  static const String _KEY_RETRO_BOARD_PREFIX = "key_retro_board_prefix_";

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
        id: id, dueDate: dueDate, teamName: teamName, columns: columns);
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
        .takeWhile((key) => key.startsWith(_KEY_RETRO_BOARD_PREFIX));
    return keys?.map((key) {
          var json = sharedPreferences.getString(key);
          var map = jsonDecode(json);
          RetroBoard.fromJson(map);
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
