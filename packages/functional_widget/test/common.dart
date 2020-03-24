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

  final errorResult =
      await main.session.getErrors('/functional_widget/test/main.dart');
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
