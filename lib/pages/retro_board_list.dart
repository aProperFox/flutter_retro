import 'package:flutter/material.dart';
import 'package:flutter_retro/components/list_items.dart';
import 'package:flutter_retro/network/clients.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_retro/pages/retro_board.dart';
import 'package:flutter_retro/res/text.dart';
import 'package:flutter_retro/styles/text.dart';
import 'package:flutter_retro/styles/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

final googleSignIn = new GoogleSignIn();

class RetroBoardList extends StatefulWidget {
  static RetroBoardList builder(BuildContext context) => new RetroBoardList();

  @override
  State<StatefulWidget> createState() => new _RetroBoardListState();
}

class _RetroBoardListState extends State<RetroBoardList> {
  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) {
      await googleSignIn.signIn();
    }
  }

  @override
  void initState() {
    //_ensureLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: androidAppBar,
      body: getList(),
    );
  }

  static Widget boardsToTitles(Stream<QuerySnapshot> snapshots) {
    return new StreamBuilder(
        stream: snapshots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new Text(snapshot.data.documents.fold(null,
              (String current, DocumentSnapshot document) {
            return "${current == null ? "" :
                current + ", "}${document['name']}";
          }),
          style: RetroBoardSubStyle,);
        });
  }

  Widget getList() {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('teams').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView(
          padding: new EdgeInsets.only(top: 8.0),
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new RetroBoardItem(
                document['name'],
                document['id'],
                boardsToTitles(
                    document.reference.collection('boards').snapshots),
                () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => RetroBoardPage.builder(
                        context, AppTitle, themeProvider(context)))));
          }).toList(),
        );
      },
    );
  }
}
