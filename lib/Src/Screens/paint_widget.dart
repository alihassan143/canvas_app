import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../CustomSektcher/custom_skether.dart';
import '../Providers/layoutprovider.dart';

class PaintingWidget extends ConsumerWidget {
  final bool eraser;
  PaintingWidget({Key? key, required this.eraser}) : super(key: key);
  final GlobalKey globalkey = GlobalKey();
  @override
  Widget build(BuildContext context, ref) {
    final layoutstate = ref.watch(layoutProvider);
    final layoutstateStream = ref.watch(singleStreamLayout);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
            onPanStart: (detail) => ref
                .read(layoutProvider.notifier)
                .panStart(detail, context: context, eraser: eraser),
            onPanUpdate: (detail) => ref
                .read(layoutProvider.notifier)
                .onPanUpdate(detail, context: context, eraser: eraser),
            onPanEnd: (detail) => ref
                .read(layoutProvider.notifier)
                .onPanEnd(detail, context: context),
            child: RepaintBoundary(
              key: globalkey,
              child: layoutstateStream.when(
                  data: (data) {
                    return CustomPaint(painter: CustomSkethcer(lines: [data]));
                  },
                  error: (data, erro) => CustomPaint(
                      painter: CustomSkethcer(
                          lines: layoutstate.line != null
                              ? [layoutstate.line!]
                              : [])),
                  loading: () => CustomPaint(
                      painter: CustomSkethcer(
                          lines: layoutstate.line != null
                              ? [layoutstate.line!]
                              : []))),
            )));
  }
}
