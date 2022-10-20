import 'package:canvasapp/Src/Model/drawclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/layout_model.dart';

final layoutProvider = StateNotifierProvider<LayOutNotifier, LayoutModel>(
    (ref) => LayOutNotifier());

class LayOutNotifier extends StateNotifier<LayoutModel> {
  LayOutNotifier() : super(LayoutModel(lines: []));
  DrawClass? line;
  bool erase = false;
  void panStart(DragStartDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    line = DrawClass(
        paths: [offset],
        strokeWidth: 2,
        color: Colors.red,
        mode: erase ? BlendMode.clear : BlendMode.srcOver);
  }

  void onPanUpdate(DragUpdateDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    LayoutModel model = state.copyWith();
    List<Offset> path = List.from(line!.paths)..add(offset);
    line = DrawClass(
        paths: path,
        strokeWidth: 2,
        color: Colors.red,
        mode: erase ? BlendMode.clear : BlendMode.srcOver);
    model.lines = model.lines..add(line!);
    state = model;
  }

  void onPanEnd(DragEndDetails details, {required BuildContext context}) {
    line = null;
  }
}
