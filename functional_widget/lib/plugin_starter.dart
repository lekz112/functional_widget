import 'dart:isolate';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/starter.dart';
import 'package:functional_widget/src/plugin/plugin.dart';

/// Starts the analyzer plugin
void start(List<String> args, SendPort sendPort) {
  print("Hello World");
  ServerPluginStarter(
          FunctionWidgetAnalyzerPlugin(PhysicalResourceProvider.INSTANCE))
      .start(sendPort);
}
