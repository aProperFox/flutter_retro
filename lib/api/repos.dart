import 'dart:async';
import 'models.dart';

abstract class RetroRepo {
  Future<RetroBoard> getRetroBoard(String id);

  Future<List<RetroBoard>> getRetroBoards(String teamId);

  Future<RetroBoard> createRetroBoard(
    String name,
    List<Category> columns,
    DateTime dueDate,
    String teamId,
  );

  Future<RetroBoard> updateRetroBoard(RetroBoard retro);

  Future deleteRetroBoard(String id);
}
