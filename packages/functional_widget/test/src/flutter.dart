// Mock of Flutter classes to make the code compile

abstract class Widget {}

abstract class HookWidget {
  const HookWidget({this.key});

  final Key key;

  Widget build(BuildContext context);
}

abstract class StatelessWidget {
  const StatelessWidget({this.key});

  final Key key;

  Widget build(BuildContext context);
}

abstract class BuildContext {}

class Text implements Widget {
  const Text(this.text, {this.textDirection});

  final String text;
  final TextDirection textDirection;
}

enum TextDirection { ltr }

class Directionality implements Widget {
  const Directionality({this.child, this.textDirection});

  static TextDirection of(BuildContext context) => TextDirection.ltr;

  final Widget child;
  final TextDirection textDirection;
}

BuildContext useContext() {
  return null;
}

class Key {}

class Color {}

class Container implements Widget {}
