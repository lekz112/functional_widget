import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

void main() {
  test('privacy.dart lint', () async {
    final main = await resolveSources(
      {
        'functional_widget|test/src/privacy.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('privacy')),
    );

    var errorResult = await main.session
        .getErrors('/functional_widget/test/src/privacy.g.dart');
    expect(errorResult.errors, isEmpty);
    errorResult = await main.session
        .getErrors('/functional_widget/test/src/privacy.dart');
  });

  test('parameters.dart lint', () async {
    final main = await resolveSources(
      {
        'functional_widget|test/src/parameters.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('parameters')),
    );

    var errorResult = await main.session
        .getErrors('/functional_widget/test/src/parameters.g.dart');
    expect(errorResult.errors, isEmpty);
    errorResult = await main.session
        .getErrors('/functional_widget/test/src/parameters.dart');
  });
  test('hook.dart lint', () async {
    final main = await resolveSources(
      {
        'functional_widget|test/src/hook.dart': useAssetReader,
      },
      (r) => r.libraries.firstWhere(
          (element) => element.source.toString().contains('hook')),
    );

    var errorResult = await main.session
        .getErrors('/functional_widget/test/src/hook.g.dart');
    expect(errorResult.errors, isEmpty);
    errorResult = await main.session
        .getErrors('/functional_widget/test/src/hook.dart');
  });
}
