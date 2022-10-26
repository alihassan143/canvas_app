import 'dart:developer';

import 'package:canvasapp/Src/Providers/layoutprovider.dart';
import 'package:canvasapp/Src/Screens/paint_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../CustomSektcher/custom_skether.dart';

class DrawingPage extends ConsumerStatefulWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends ConsumerState<DrawingPage> {
  final GlobalKey globalkey = GlobalKey();
  bool eraser = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final layoutstate = ref.watch(layoutProvider);
    final layoutstateStream = ref.watch(streamLayout);
    // final mousePostion = ref.watch(mouseRegionProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          eraser = !eraser;
        }),
        child: Icon(eraser ? Icons.edit : Icons.delete),
      ),
      body: MouseRegion(
        // onEnter: (event) =>
        //     ref.read(mouseRegionProvider.state).state = event.localPosition,
        // onExit: (event) => ref.read(layoutProvider.notifier).changeEarser,
        // onHover: (event) =>
        //     ref.read(mouseRegionProvider.state).state = event.localPosition,
        cursor: eraser ? SystemMouseCursors.grabbing : SystemMouseCursors.cell,
        child: Stack(
          children: [
            layoutstateStream.when(
                loading: () => RepaintBoundary(
                      key: globalkey,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CustomPaint(
                            painter: CustomSkethcer(lines: layoutstate.lines)),
                      ),
                    ),
                error: (error, ob) {
                  return RepaintBoundary(
                    key: globalkey,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CustomPaint(
                          painter: CustomSkethcer(lines: layoutstate.lines)),
                    ),
                  );
                },
                data: (data) {
           
                  return RepaintBoundary(
                    key: globalkey,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CustomPaint(painter: CustomSkethcer(lines: data)),
                    ),
                  );
                }),
            PaintingWidget(
              eraser: eraser,
            ),
            // if (layoutstate.eraser)
            //   Positioned(
            //     left: mousePostion.dx,
            //     top: mousePostion.dy,
            //     child: RepaintBoundary(
            //         child: Container(
            //       width: 20,
            //       height: 20,
            //       decoration: const BoxDecoration(
            //           color: Colors.grey, shape: BoxShape.circle),
            //     )),
            //   )
          ],
        ),
      ),
    );
  }
}
