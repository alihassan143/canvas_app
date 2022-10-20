import 'package:canvasapp/Src/Providers/layoutprovider.dart';
import 'package:canvasapp/Src/Screens/paint_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../CustomSektcher/custom_skether.dart';

class DrawingPage extends ConsumerWidget {
  DrawingPage({Key? key}) : super(key: key);
  final GlobalKey globalkey = GlobalKey();

  @override
  Widget build(BuildContext context, ref) {
    final layoutstate = ref.watch(layoutProvider);

    return Scaffold(
      body: Stack(
        children: [
          RepaintBoundary(
            key: globalkey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                  painter: CustomSkethcer(lines: layoutstate.lines)),
            ),
          ),
          const PaintingWidget(),
        ],
      ),
    );
  }
}
