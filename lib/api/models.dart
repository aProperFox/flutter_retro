import 'package:flutter/material.dart';
import '../util/icons_helper.dart';
import 'package:collection/collection.dart';

enum Role { Admin, Leader, Contributor, Spectator }

class Team {
  final String id;
  final String name;
  final List<Member> members;
  final List<RetroBoard> retros;

  Team({this.id, this.name, this.members, this.retros});

  Team.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.members = (json['members'] as List)
                ?.map((i) => Member.fromJson(i))
                ?.toList() ??
            List(),
        this.retros = (json['retros'] as List)
                ?.map((i) => RetroBoard.fromJson(i))
                ?.toList() ??
            List();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['members'] = this.members?.map((i) => i.toJson())?.toList() ?? List();
    data['retros'] = this.retros?.map((i) => i.toJson())?.toList() ?? List();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Team &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          ListEquality().equals(members, other.members) &&
          ListEquality().equals(retros, other.retros);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ members.hashCode ^ retros.hashCode;
}

class Member {
  final Role role;
  final User user;

  Member({this.role, this.user});

  Member.fromJson(Map<String, dynamic> json)
      : this.role = json['role'],
        this.user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['user'] = this.user.toJson();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          role == other.role &&
          user == other.user;

  @override
  int get hashCode => role.hashCode ^ user.hashCode;
}

class RetroBoard {
  final String id;
  final DateTime dueDate;
  final String teamName;
  final List<Category> columns;
  final String name;

  RetroBoard({this.id, this.dueDate, this.teamName, this.columns, this.name});

  RetroBoard.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.dueDate = DateTime.parse(json['dueDate']),
        this.teamName = json['teamName'],
        this.columns = (json['columns'] as List)
                ?.map((i) => Category.fromJson(i))
                ?.toList() ??
            List(),
        this.name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dueDate'] = this.dueDate.toIso8601String();
    data['teamName'] = this.teamName;
    data['columns'] = this.columns?.map((i) => i.toJson())?.toList() ?? List();
    data['name'] = this.name;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetroBoard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          dueDate == other.dueDate &&
          teamName == other.teamName &&
          ListEquality().equals(columns, other.columns) &&
          name == other.name;

  @override
  int get hashCode =>
      id.hashCode ^ dueDate.hashCode ^ teamName.hashCode ^ columns.hashCode;
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final bool isVerified;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.avatarUrl,
      this.isVerified});

  User.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.firstName = json['firstName'],
        this.lastName = json['lastName'],
        this.email = json['email'],
        this.avatarUrl = json['avatarUrl'],
        this.isVerified = json['isVerified'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['avatarUrl'] = this.avatarUrl;
    data['isVerified'] = this.isVerified;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          email == other.email &&
          avatarUrl == other.avatarUrl &&
          isVerified == other.isVerified;

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      avatarUrl.hashCode ^
      isVerified.hashCode;
}

class Category {
  final String name;
  final IconData icon;
  final List<RetroItem> items;

  Category({this.name, this.icon, this.items});

  Category.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.icon = getIconFromName(json['icon']),
        this.items = (json['items'] as List)
                ?.map((i) => RetroItem.fromJson(i))
                ?.toList() ??
            List();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = getNameFromIcon(this.icon);
    data['items'] = this.items?.map((i) => i.toJson())?.toList() ?? List();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          icon == other.icon &&
          ListEquality().equals(items, other.items);

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ items.hashCode;
}

class RetroItem {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int votes;
  final User user;
  final List<Comment> comments;

  RetroItem(
      {this.id,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.votes,
      this.user,
      this.comments});

  RetroItem.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.description = json['description'],
        this.createdAt = DateTime.parse(json['createdAt']),
        this.updatedAt = DateTime.parse(json['updatedAt']),
        this.votes = json['votes'],
        this.user = json['user'] != null ? User.fromJson(json['user']) : null,
        this.comments = (json['comments'] as List)
                ?.map((i) => Comment.fromJson(i))
                ?.toList() ??
            List();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt.toIso8601String();
    data['updatedAt'] = this.updatedAt.toIso8601String();
    data['votes'] = this.votes;
    data['user'] = this.user?.toJson();
    data['comments'] =
        this.comments?.map((i) => i.toJson())?.toList() ?? List();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetroItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          votes == other.votes &&
          user == other.user &&
          ListEquality().equals(comments, other.comments);

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      votes.hashCode ^
      user.hashCode ^
      comments.hashCode;
}

class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Comment({this.id, this.content, this.createdAt, this.updatedAt, this.user});

  Comment.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.content = json['content'],
        this.createdAt = DateTime.parse(json['createdAt']),
        this.updatedAt = DateTime.parse(json['updatedAt']),
        this.user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt.toIso8601String();
    data['updatedAt'] = this.updatedAt.toIso8601String();
    data['user'] = this.user.toJson();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          user == other.user;

  @override
  int get hashCode =>
      id.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      user.hashCode;
}
