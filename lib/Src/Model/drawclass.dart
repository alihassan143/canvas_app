import 'package:flutter/material.dart';

class DrawClass {
  List<Offset> paths;
  double strokeWidth;
  Color color;
  BlendMode mode;

  DrawClass(
      {required this.paths,
      required this.strokeWidth,
      required this.color,
      this.mode = BlendMode.srcOver});
}
