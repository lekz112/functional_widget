import 'package:analyzer/dart/element/element.dart';
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
  test('functions', () async {
    await expectLater(compile(r'''
import 'src/general.dart';
import 'src/flutter.dart';

void main() {
  TypedefFunction(() {});
  InlineFunction(() {});
}
'''), completes);
    await expectLater(compile(r'''
import 'src/general.dart';
import 'src/flutter.dart';

void main() {
  TypedefFunction((int a) {});
}
'''), throwsCompileError);
    await expectLater(compile(r'''
import 'src/general.dart';
import 'src/flutter.dart';

void main() {
  InlineFunction((int a) {});
}
'''), throwsCompileError);
  });
  test('adds documentation to class and constructor', () async {
    final main = await resolve('general');

    final classElement = main.topLevelElements
        .firstWhere((e) => e.name == 'Documentation') as ClassElement;

    expect(classElement.documentationComment, '''
/// Hello
/// World''');

    expect(classElement.constructors.single.documentationComment, '''
/// Hello
/// World''');
  });
  test('transpose parameters annotations to the class', () async {
    final main = await resolve('general');

    final classElement = main.topLevelElements
        .firstWhere((e) => e.name == 'Annotation') as ClassElement;

    var parameter = classElement.constructors.single.parameters
        .firstWhere((e) => e.name == 'foo');

    expect(parameter.hasRequired, isTrue);
    expect(parameter.hasDeprecated, isTrue);
  });
}
