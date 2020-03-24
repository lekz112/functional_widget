import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart';
import 'package:build_test/build_test.dart';
import 'package:test/test.dart';
import 'package:matcher/matcher.dart';

// from Freezed

final throwsCompileError = throwsA(isA<CompileError>());

Future<void> compile(String src) async {
  final main = await resolveSources({
    'functional_widget|test/main.dart': '''
library main;

$src
    ''',
  }, (r) => r.findLibraryByName('main'));

  final errorResult = await main.getMainErrors();

  final criticalErrors = errorResult.errors
      .where((element) => element.severity == Severity.error)
      .toList();

  if (criticalErrors.isNotEmpty) {
    throw CompileError(criticalErrors);
  }
}

class CompileError extends Error {
  CompileError(this.errors);
  final List<AnalysisError> errors;

  @override
  String toString() {
    return 'CompileError: \n${errors.join('\n')}';
  }
}

final Map<String, Future<LibraryElement>> _resolveCache = {};

/// Wrapper around [resolveSources] to reduce the verbosity and cache the result.
Future<LibraryElement> resolve(String fileName) {
  return _resolveCache.putIfAbsent(fileName, () {
    return resolveSources(
      {
        'functional_widget|test/src/$fileName.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains(fileName)),
    );
  });
}

extension ErrorsX on LibraryElement {
  Future<ErrorsResult> getMainErrors() {
    return session.getErrors('/${source.uri.path}');
  }

  Future<ErrorsResult> getGeneratedErrors() {
    return session.getErrors(
      '/${source.uri.path.replaceFirst('.dart', '.g.dart')}',
    );
  }
}
