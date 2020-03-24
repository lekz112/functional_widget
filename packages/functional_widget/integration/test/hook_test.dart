import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration/hook.dart';

void main() {
  testWidgets('can use hooks', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Example(),
      ),
    );

    expect(find.text('hook'), findsOneWidget);
  });
}
