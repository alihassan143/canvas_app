import 'package:canvasapp/Src/Model/drawclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/layout_model.dart';

final layoutProvider = StateNotifierProvider<LayOutNotifier, LayoutModel>(
    (ref) => LayOutNotifier());

class LayOutNotifier extends StateNotifier<LayoutModel> {
  LayOutNotifier() : super(LayoutModel(lines: []));

  void panStart(DragStartDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    DrawClass line =
        DrawClass(paths: [offset], strokeWidth: 2, color: Colors.red);
    LayoutModel model = state.copyWith();
    model.line = line;
    state = model;
  }

  void onPanUpdate(DragUpdateDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    LayoutModel model = state.copyWith();
    List<Offset> path = List.from(model.line!.paths)..add(offset);
    DrawClass line = DrawClass(paths: path, strokeWidth: 2, color: Colors.red);
    model.line = line;
    state = model;
  }

  void onPanEnd(DragEndDetails details, {required BuildContext context}) {
    LayoutModel model = state.copyWith();

    List<DrawClass> lines = model.lines..add(model.line!);
    model.lines = lines;
    model.line = null;
    state = model;
  }
}