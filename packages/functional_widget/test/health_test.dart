import 'package:analyzer/error/error.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() {
  test('privacy.dart lint', () async {
    final main = await resolve('privacy');
    print(
        'Librayr ${main.exportNamespace} ${main.publicNamespace} ${main.getExtendedDisplayName('a')}');

    var errorResult = await main.getGeneratedErrors();

    expect(errorResult.errors, [
      isA<AnalysisError>().having((s) => s.errorCode.uniqueName,
          '_ExtraPrivate', 'HintCode.UNUSED_ELEMENT')
    ]);
    errorResult = await main.getMainErrors();

    expect(errorResult.errors, isEmpty);
  });

  test('parameters.dart lint', () async {
    final main = await resolve('general');

    var errorResult = await main.getGeneratedErrors();
    expect(errorResult.errors, isEmpty);

    errorResult = await main.getMainErrors();
    expect(errorResult.errors, isEmpty);
  });
  test('hook.dart lint', () async {
    final main = await resolve('hook');

    var errorResult = await main.getGeneratedErrors();
    expect(errorResult.errors, isEmpty);

    errorResult = await main.getMainErrors();
    expect(errorResult.errors, isEmpty);
  });
}
