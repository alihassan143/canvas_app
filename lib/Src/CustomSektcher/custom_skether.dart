import 'package:flutter/material.dart';

import '../Model/drawclass.dart';

class CustomSkethcer extends CustomPainter {
  final List<DrawClass> lines;

  const CustomSkethcer({
    required this.lines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (var mainLines in lines) {
      Paint paint = Paint();

      paint.blendMode = mainLines.mode;

      paint.strokeWidth = mainLines.strokeWidth;
      paint.color = mainLines.color;

      paint.strokeWidth = mainLines.strokeWidth;
      for (int j = 0; j < mainLines.paths.length - 1; j++) {
        canvas.drawLine(mainLines.paths[j], mainLines.paths[j + 1], paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
