
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration/parameters.dart';

void main() {
  testWidgets('no parameter', (tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(
      Empty(key: key),
    );

    expect(find.text('empty'), findsOneWidget);
    expect(key.currentContext, isNotNull);
  });
  testWidgets('_context', (tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Context(key: key),
      ),
    );

    expect(find.text('context'), findsOneWidget);
    expect(key.currentContext, isNotNull);
  });
  testWidgets('dartUI', (tester) async {
    await tester.pumpWidget(
      DartUi(Colors.red),
    );

    expect(find.text(Colors.red.toString()), findsOneWidget);

// TODO:
    // final main = await resolveSources(
    //   {
    //     'functional_widget|test/integration/parameters_test.dart':
    //         useAssetReader,
    //   },
    //   (r) => r.libraries.firstWhere(
    //       (element) => element.source.toString().contains('parameters_test')),
    // );

    // var errorResult = await main.session.getErrors(
    //     '/functional_widget/test/integration/parameters_test.g.dart');
    // expect(errorResult.errors, isEmpty);
    // errorResult = await main.session
    //     .getErrors('/functional_widget/test/integration/parameters_test.dart');
  });
  testWidgets('whateverThenContext', (tester) async {
    await tester.pumpWidget(
      const WhateverThenContext(42),
    );

    expect(find.text('42'), findsOneWidget);
  });
  testWidgets('withContextThenOneArg', (tester) async {
    await tester.pumpWidget(
      const WithContextThenOneArg(42),
    );

    expect(find.text('42'), findsOneWidget);
  });
  testWidgets('withKeyThenOneArg', (tester) async {
    await tester.pumpWidget(
      const WithKeyThenOneArg(42),
    );

    expect(find.text('false 42'), findsOneWidget);

    final key = GlobalKey();

    await tester.pumpWidget(
      WithKeyThenOneArg(42, key: key),
    );

    expect(find.text('true 42'), findsOneWidget);
    expect(key.currentContext, isNotNull);
  });
  testWidgets('_key', (tester) async {
    await tester.pumpWidget(
      const KeyTest(),
    );

    expect(find.text('false'), findsOneWidget);

    final key = GlobalKey();

    await tester.pumpWidget(
      KeyTest(key: key),
    );

    expect(find.text('true'), findsOneWidget);
    expect(key.currentContext, isNotNull);
  });
  testWidgets('_contextThenKey', (tester) async {
    await tester.pumpWidget(
      const ContextThenKey(),
    );

    expect(find.text('false'), findsOneWidget);

    final key = GlobalKey();

    await tester.pumpWidget(
      ContextThenKey(key: key),
    );

    expect(find.text('true'), findsOneWidget);
    expect(key.currentContext, isNotNull);
  });
  testWidgets('_mixt', (tester) async {
    await tester.pumpWidget(
      const Mixt(42, '42', c: 42.0),
    );

    expect(find.text('a: 42 b: 42 c: 42.0'), findsOneWidget);
  });
}
