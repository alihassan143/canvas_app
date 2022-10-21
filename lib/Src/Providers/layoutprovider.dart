import 'package:canvasapp/Src/Model/drawclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/layout_model.dart';
import 'Mouse Region Provider/mouse_region_provider.dart';

final layoutProvider = StateNotifierProvider<LayOutNotifier, LayoutModel>(
    (ref) => LayOutNotifier(ref: ref));

class LayOutNotifier extends StateNotifier<LayoutModel> {
  LayOutNotifier({required this.ref}) : super(LayoutModel(lines: []));
  final Ref ref;
  void panStart(DragStartDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    ref.read(mouseRegionProvider.state).state = offset;
    LayoutModel model = state.copyWith();
    DrawClass line = DrawClass(
        paths: [offset],
        strokeWidth: model.eraser ? 20 : 2,
        color: model.eraser ? Colors.white : Colors.red,
        mode: model.eraser ? BlendMode.clear : BlendMode.srcOver);

    model.line = line;
    state = model;
  }

  void changeEarser() {
    LayoutModel model = state.copyWith();
    model.eraser = !model.eraser;
    state = model;
  }

  void onPanUpdate(DragUpdateDetails details, {required BuildContext context}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    ref.read(mouseRegionProvider.state).state = offset;
    LayoutModel model = state.copyWith();
    List<Offset> path = List.from(model.line!.paths)..add(offset);
    DrawClass line = DrawClass(
        paths: path,
        strokeWidth: model.eraser ? 20 : 2,
        color: model.eraser ? Colors.white : Colors.red,
        mode: model.eraser ? BlendMode.clear : BlendMode.srcOver);
    List<DrawClass> lines = model.lines..add(line);
    model.lines = lines;
    model.line = line;
    state = model;
  }

  void onPanEnd(DragEndDetails details, {required BuildContext context}) {
    LayoutModel model = state.copyWith();

    // List<DrawClass> lines = model.lines..add(model.line!);
    // model.lines = lines;
    model.line = null;
    state = model;
  }
}
