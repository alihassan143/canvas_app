import '../../Model/drawclass.dart';

class LayoutModel {
  List<DrawClass> lines = [];
  DrawClass? line;
  bool eraser ;
  LayoutModel({required this.lines, this.line,this.eraser=false});
  LayoutModel copyWith({List<DrawClass>? oldline, DrawClass? line,bool? eraser}) =>
      LayoutModel(lines: oldline ?? lines, line: line ?? this.line,eraser: eraser??this.eraser);
}
