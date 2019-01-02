import 'dart:isolate';

import 'package:functional_widget/plugin_starter.dart';

void main(List<String> args, SendPort sendPort) {
  print("Hello World");
  start(args, sendPort);
}
