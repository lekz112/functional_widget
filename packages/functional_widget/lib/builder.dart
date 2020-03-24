import 'package:build/build.dart';
import 'package:functional_widget/src/functional_widget_generator.dart';
import 'package:functional_widget/src/parse_builder_options.dart';
import 'package:source_gen/source_gen.dart';

/// Builds generators for `build_runner` to run
Builder functionalWidget(BuilderOptions rawOptions) {
  final options = parseBuilderOptions(rawOptions);
  return SharedPartBuilder(
    [FunctionalWidgetGenerator(options)],
    'functional_widget',
  );
}
