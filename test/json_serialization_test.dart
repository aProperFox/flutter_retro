import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_retro/api/models.dart';

void main() {
  final user = User(
    id: "asdffg234er",
    avatarUrl: null,
    firstName: "John",
    lastName: "Doe",
    email: "john@doe.com",
    isVerified: true,
  );
  final comment = Comment(
    id: "abcd1234",
    content: "Look, a comment",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    user: user,
  );
  final retroItem = RetroItem(
      id: "njkasdf789",
      updatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      comments: [comment],
      user: user,
      description: "I want more biscuits",
      votes: 1);
  final column = Category(
    name: "Do more",
    color: Colors.green,
    icon: Icons.thumb_up,
    items: [retroItem],
  );
  final retroBoard = RetroBoard(
      id: "laa89fa",
      dueDate: DateTime.now(),
      columns: [column],
      teamName: "Team One");
  final member = Member(role: Role.Contributor, user: user);
  final team = Team(
    id: "89asdfjk",
    members: [member],
    retros: [retroBoard],
    name: "Team One",
  );
  test('Comment serialization/deserialization should return the same value',
      () {
    final json = comment.toJson();
    final deserialized = Comment.fromJson(json);

    expect(deserialized, comment);
  });
  test('User serialization/deserialization should return the same value', () {
    final json = user.toJson();
    final deserialized = User.fromJson(json);

    expect(deserialized, user);
  });
  test('Member serialization/deserialization should return the same value', () {
    final json = member.toJson();
    final deserialized = Member.fromJson(json);

    expect(deserialized, member);
  });
  test('Team serialization/deserialization should return the same value', () {
    final json = team.toJson();
    final deserialized = Team.fromJson(json);

    expect(deserialized, team);
  });
  test('Category serialization/deserialization should return the same value',
      () {
    final json = column.toJson();
    final deserialized = Category.fromJson(json);

    expect(deserialized, column);
  });
  test('RetroItem serialization/deserialization should return the same value',
      () {
    final json = retroItem.toJson();
    final deserialized = RetroItem.fromJson(json);

    expect(deserialized, retroItem);
  });
  test('RetroBoard serialization/deserialization should return the same value',
      () {
    final json = retroBoard.toJson();
    final deserialized = RetroBoard.fromJson(json);

    expect(deserialized, retroBoard);
  });
}
