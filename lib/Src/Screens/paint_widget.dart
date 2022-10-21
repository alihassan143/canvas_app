import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../CustomSektcher/custom_skether.dart';
import '../Providers/layoutprovider.dart';

class PaintingWidget extends ConsumerWidget {
  PaintingWidget({super.key});
  final GlobalKey globalkey = GlobalKey();
  @override
  Widget build(BuildContext context, ref) {
    final layoutstate = ref.watch(layoutProvider);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GestureDetector(
            onPanStart: (detail) => ref
                .read(layoutProvider.notifier)
                .panStart(detail, context: context),
            onPanUpdate: (detail) => ref
                .read(layoutProvider.notifier)
                .onPanUpdate(detail, context: context),
            onPanEnd: (detail) => ref
                .read(layoutProvider.notifier)
                .onPanEnd(detail, context: context),
            child: RepaintBoundary(
              key: globalkey,
              child: CustomPaint(
                  painter: CustomSkethcer(
                      lines:
                          layoutstate.line != null ? [layoutstate.line!] : [])),
            )));
  }
}
