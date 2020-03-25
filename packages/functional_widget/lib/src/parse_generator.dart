import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Copied from Freezed
abstract class ParserGenerator<GlobalData, Data, Annotation>
    extends GeneratorForAnnotation<Annotation> {
  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = StringBuffer();

    final globalData = parseGlobalData(library.element);
    var didGenerateForAll = false;

    for (var annotatedElement in library.annotatedWith(typeChecker)) {
      if (!didGenerateForAll) {
        didGenerateForAll = true;
        for (final value
            in generateForAll(globalData).map((e) => e.toString())) {
          assert(value == null || (value.length == value.trim().length));
          values.writeln(value);
        }
      }
      final data = parseElement(
        globalData,
        annotatedElement.element,
        annotatedElement.annotation,
      );
      if (data == null) continue;

      for (final value
          in generateForData(globalData, data).map((e) => e.toString())) {
        assert(value == null || (value.length == value.trim().length));
        values.writeln(value);
      }
    }

    return values.toString();
  }

  Iterable<Object> generateForAll(GlobalData globalData) sync* {}

  GlobalData parseGlobalData(LibraryElement library);

  Data parseElement(
    GlobalData globalData,
    Element rawElement,
    ConstantReader annotation,
  );

  Iterable<Object> generateForData(GlobalData globalData, Data data);

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    // implemented for source_gen_test – otherwise unused
    final globalData = parseGlobalData(element.library);
    final data = parseElement(globalData, element, annotation);
    if (data == null) return;
    yield* generateForData(globalData, data)
        .map((element) => element.toString());
  }
}
