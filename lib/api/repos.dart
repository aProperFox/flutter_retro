import 'dart:async';
import 'models.dart';

abstract class RetroRepo {
  Future<RetroBoard> getRetroBoard(String id);

  Future<List<RetroBoard>> getRetroBoards(String teamId);

  Future<RetroBoard> createRetroBoard(
    String name,
    List<Category> columns,
    DateTime dueDate,
    String teamName,
  );

  Future<RetroBoard> updateRetroBoard(RetroBoard retro);

  Future deleteRetroBoard(String id);
}

abstract class RetroBoardRepo {
  final String id;
  RetroBoardRepo(this.id);

  Future<RetroBoard> getRetroBoard();
  Future<RetroBoard> addItem(String text, int categoryIndex);
  Future<RetroBoard> removeItem(RetroItem item);
  Future<RetroBoard> updateItem(RetroItem item);
}
