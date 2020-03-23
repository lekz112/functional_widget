import 'package:test/test.dart';

import 'common.dart';

void main() {
  group('compile utility', () {
    test('compiles', () async {
      await expectLater(compile(r'''
import 'compiles_test.dart';

void main() {
  final test = MyClass();
}
'''), completes);
    });
    test('does not compile', () async {
      await expectLater(compile(r'''
import 'compiles_test.dart';

void main() {
  final test = 
}
'''), throwsCompileError);
    });
  });
}

class MyClass {}