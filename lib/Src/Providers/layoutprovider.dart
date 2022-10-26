import 'package:canvasapp/Src/Model/drawclass.dart';
import 'package:canvasapp/Src/Providers/stream_broadcaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Model/layout_model.dart';

final layoutProvider = StateNotifierProvider<LayOutNotifier, LayoutModel>(
    (ref) => LayOutNotifier(ref: ref));
final streamLayout = StreamProvider<List<DrawClass>>(
    (ref) => ref.read(broadCastProvider).streamLines.stream);
final singleStreamLayout = StreamProvider<DrawClass>(
    (ref) => ref.read(broadCastProvider).streamSingleLine.stream);

class LayOutNotifier extends StateNotifier<LayoutModel> {
  LayOutNotifier({required this.ref}) : super(LayoutModel(lines: []));
  final Ref ref;
  void panStart(DragStartDetails details,
      {required BuildContext context, required bool eraser}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    // ref.read(mouseRegionProvider.state).state = offset;
    LayoutModel model = state.copyWith();
    DrawClass line = DrawClass(
        paths: [offset],
        strokeWidth: eraser ? 20 : 18,
        color: eraser ? Colors.white : Colors.red,
        mode: eraser ? BlendMode.clear : BlendMode.srcOver);

    model.line = line;

    state = model;
    ref.read(broadCastProvider).streamSingleLine.add(line);
  }

  // void changeEarser() {
  //   LayoutModel model = state.copyWith();
  //   model.eraser = !model.eraser;
  //   state = model;
  // }

  void onPanUpdate(DragUpdateDetails details,
      {required BuildContext context, required bool eraser}) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset offset = renderBox.globalToLocal(details.globalPosition);
    // ref.read(mouseRegionProvider.state).state = offset;
    LayoutModel model = state.copyWith();
    List<Offset> path = List.from(model.line!.paths)..add(offset);
    DrawClass line = DrawClass(
        paths: path,
        strokeWidth: eraser ? 20 : 18,
        color: eraser ? Colors.white : Colors.red,
        mode: eraser ? BlendMode.clear : BlendMode.srcOver);

    ref.read(broadCastProvider).streamSingleLine.add(line);

    model.line = line;
    state = model;
  }

  void onPanEnd(DragEndDetails details, {required BuildContext context}) {
    LayoutModel model = state.copyWith();
    model.lines = List.from(model.lines)..add(model.line!);
    ref.read(broadCastProvider).streamLines.add(model.lines);
    // List<DrawClass> lines = model.lines..add(model.line!);
    // model.lines = lines;
    state = model;
  }
}
