import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'flutter.dart';

part 'hook.g.dart';

@hwidget
Widget example() {
  return Text(
    'hook',
    textDirection: Directionality.of(useContext()),
  );
}