import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mouseRegionProvider = StateProvider<Offset>((ref) => const Offset(0, 0));
