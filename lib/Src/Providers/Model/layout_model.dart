import '../../Model/drawclass.dart';

class LayoutModel {
  List<DrawClass> lines = [];
  DrawClass? line;
  
  LayoutModel({required this.lines, this.line,});
  LayoutModel copyWith({List<DrawClass>? oldline, DrawClass? line,bool? eraser}) =>
      LayoutModel(lines: oldline ?? lines, line: line ?? this.line,);
}
