// ignore_for_file: implicit_dynamic_parameter

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:meta/meta.dart' as meta;
import 'fake_flutter.dart';

@widget
Widget namedDefault({int foo = 42}) => Container();
