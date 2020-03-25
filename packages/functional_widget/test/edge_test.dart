import 'package:analyzer/dart/element/element.dart';
import 'package:test/test.dart';

import 'common.dart';

void main() async {
  test('Generates dynamic properties if the type could not be resolved',
      () async {
    final main = await resolve('edge');

    final classElement = main.topLevelElements
        .firstWhere((e) => e.name == 'UndefinedType') as ClassElement;

    var parameter = classElement.constructors.single.parameters.firstWhere((e) => e.name == 'foo');

    expect(parameter.type.isDynamic, true);
  });
}
