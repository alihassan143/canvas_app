import 'dart:async';

import 'package:canvasapp/Src/Model/drawclass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final broadCastProvider =
    Provider<StreamBroadcaster>((ref) => StreamBroadcaster());

class StreamBroadcaster {
  StreamController<List<DrawClass>> streamLines =
      StreamController<List<DrawClass>>.broadcast();
  StreamController<DrawClass> streamSingleLine =
      StreamController<DrawClass>.broadcast();
}
