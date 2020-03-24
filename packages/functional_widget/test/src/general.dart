import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:meta/meta.dart';

import 'flutter.dart';

part 'general.g.dart';

@widget
Widget empty() {
  return const Text('empty', textDirection: TextDirection.ltr);
}

@widget
Widget _context(BuildContext c) {
  assert(c != null);
  return Text('context', textDirection: Directionality.of(c));
}

@widget
Widget _keyTest(Key key) {
  return Text((key != null).toString(), textDirection: TextDirection.ltr);
}

@widget
Widget _contextThenKey(BuildContext c, Key key) {
  assert(c != null);
  return Text((key != null).toString(), textDirection: TextDirection.ltr);
}

@widget
Widget withContextThenOneArg(BuildContext context, int foo) {
  assert(context != null);
  return Text('$foo', textDirection: TextDirection.ltr);
}

@widget
Widget withKeyThenOneArg(Key key, int foo) {
  return Text('${key != null} $foo', textDirection: TextDirection.ltr);
}

@widget
Widget whateverThenContext(int foo, {@required BuildContext context}) {
  assert(context != null);
  return Text('$foo', textDirection: TextDirection.ltr);
}

@widget
Widget _mixt(int a, String b, {@required double c}) {
  assert(c != null);
  return Text(
    'a: $a b: $b c: $c',
    textDirection: TextDirection.ltr,
  );
}

@widget
Widget dartUi(Color color) {
  return Text(color.toString(), textDirection: TextDirection.ltr);
}
