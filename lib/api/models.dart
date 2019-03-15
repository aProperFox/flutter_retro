import 'package:flutter/material.dart';

enum Role { Admin, Leader, Contributor, Spectator }

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isVerified;
  final String avatarUrl;

  String get displayName {
    return "$firstName ${lastName[0]}.";
  }

  User(this.id, this.firstName, this.lastName, this.email, this.isVerified,
      this.avatarUrl);
}

class Member {
  final User user;
  final Role role;

  Member(this.user, this.role);
}

class Column {
  final IconData icon;
  final String name;
  final List<Item> items;

  Column(this.icon, this.name, this.items);
}

class Comment {
  final String id;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Item item;

  Comment(this.id, this.user, this.createdAt, this.updatedAt, this.item);
}

class Item {
  final String id;
  final String description;
  final int votes;
  final List<Comment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Item(this.id, this.description, this.votes, this.comments, this.createdAt,
      this.updatedAt, this.user);
}

class Team {
  final String id;
  final String name;
  final List<Retro> retros;
  final List<Member> members;

  Team(this.id, this.name, this.retros, this.members);
}

class Retro {
  final String id;
  final String name;
  final List<Column> columns;
  final DateTime dueDate;
  final String teamName;

  Retro(this.id, this.name, this.columns, this.dueDate, this.teamName);
}
