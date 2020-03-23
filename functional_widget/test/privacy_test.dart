import 'package:test/test.dart';

import 'common.dart';
import 'src/privacy.dart';

void main() {
  test('public generates Public', () {
    expect(Public, isA<Type>());
  });
  test('_private generates Private', () {
    expect(Private, isA<Type>());
  });
  test('__extraPrivate generates _ExtraPrivate', () async {
    await expectLater(compile(r'''
import 'src/privacy.dart';

void main() {
  print(Public);
  print(Private);
}
'''), completes);
    await expectLater(compile(r'''
import 'src/privacy.dart';

void main() {
  print(ExtraPrivate);
}
'''), throwsCompileError);
  });
}
