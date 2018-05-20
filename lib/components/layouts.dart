import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import 'dart:async';

/*
class ExpandingCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final String tag;
  Color background;

  ExpandingCard(this.child, this.tag, {Color background: Colors.blueGrey,});

  @override
  State createState() => _ExpandingCardState();
}

class _ExpandingCardState extends State<ExpandingCard>
    with SingleTickerProviderStateMixin {
  Animation<double> _controller;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: Material(
        color: widget.background,
        child: InkWell(
          child: widget.child,
          onTap: widget.onTap,
        ),
      ),
    );
  }

}*/
