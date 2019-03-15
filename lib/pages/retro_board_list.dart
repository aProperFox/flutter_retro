import 'package:flutter/material.dart';
import 'package:flutter_retro/api/local_db.dart';
import 'package:flutter_retro/api/models.dart';
import 'package:flutter_retro/api/repos.dart';
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

  RetroRepo retroRepo;

  @override
  void initState() {
    //_ensureLoggedIn();
    retroRepo = LocalDb.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: androidAppBar,
      body: getList(),
    );
  }

  Widget getList() {
    return new FutureBuilder(
      future: retroRepo.getRetroBoards(""),
      builder: (BuildContext context, AsyncSnapshot<List<RetroBoard>> snapshot) {
        return new ListView(
          padding: new EdgeInsets.only(top: 8.0),
          children: snapshot.data.map((RetroBoard retroBoard) {
            return new RetroBoardItem(
                retroBoard.name,
                retroBoard.id,
                null,
                () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => RetroBoardPage.builder(
                        context, AppTitle, themeProvider(context)))));
          }).toList(),
        );
      },
    );
  }
}
