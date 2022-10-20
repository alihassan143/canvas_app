import 'package:flutter/material.dart';

import '../../Model/drawclass.dart';

class LayoutModel {
  List<DrawClass> lines = [];


  LayoutModel({required this.lines, });
  LayoutModel copyWith({List<DrawClass>? oldline, BlendMode? mode}) =>
      LayoutModel(lines: oldline ?? lines,);
}
