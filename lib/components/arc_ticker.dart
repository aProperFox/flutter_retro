import 'package:flutter/material.dart';
import 'dart:math';

class ArcTicker extends CustomPainter {
  final Paint arcPaint;
  final double drawnPercent;

  ArcTicker(this.arcPaint, this.drawnPercent);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    canvas.drawArc(
        rect, -pi / 2, (2 * pi * drawnPercent) - (2 * pi), true, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
