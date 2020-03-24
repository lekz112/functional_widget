import 'package:build_test/build_test.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() async {
  test('DartUi does not resolve to dynamic', () async {
    await expectLater(compile(r'''
import 'src/general.dart';
import 'src/flutter.dart';

void main() {
  DartUi(Color());
}
'''), completes);
    await expectLater(compile(r'''
import 'src/general.dart';
import 'src/flutter.dart';

void main() {
  DartUi(42);
}
'''), throwsCompileError);
  });
  test('adds documentation to class and constructor', () async {
    final generalLibraryElement = await resolve('general');


    var errorResult = await generalLibraryElement.getMainErrors();
  });
}
