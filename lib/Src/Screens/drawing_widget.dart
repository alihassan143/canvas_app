import 'package:canvasapp/Src/Providers/Mouse%20Region%20Provider/mouse_region_provider.dart';
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
    final mousePostion = ref.watch(mouseRegionProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(layoutProvider.notifier).changeEarser,
        child: Icon(layoutstate.eraser ? Icons.edit : Icons.delete),
      ),
      body: MouseRegion(
        onEnter: (event) =>
            ref.read(mouseRegionProvider.state).state = event.localPosition,
        onExit: (event) => ref.read(layoutProvider.notifier).changeEarser,
        onHover: (event) =>
            ref.read(mouseRegionProvider.state).state = event.localPosition,
        cursor: layoutstate.eraser
            ? SystemMouseCursors.grabbing
            : SystemMouseCursors.cell,
        child: Stack(
          children: [
            RepaintBoundary(
              key: globalkey,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CustomPaint(
                    painter: CustomSkethcer(lines: layoutstate.lines)),
              ),
            ),
            PaintingWidget(),
            if (layoutstate.eraser)
              Positioned(
                left: mousePostion.dx,
                top: mousePostion.dy,
                child: RepaintBoundary(
                    child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                )),
              )
          ],
        ),
      ),
    );
  }
}
