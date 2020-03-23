// ignore_for_file: implicit_dynamic_parameter

import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:meta/meta.dart' as meta;
import 'fake_flutter.dart';

@widget
Widget namedDefault({int foo = 42}) => Container();

/// Hello
/// World
@widget
Widget documentation(int foo) => Container();

@widget
Widget annotated({@meta.required int foo}) => Container();

@widget
// ignore: undefined_class
Widget undefinedType({Color foo}) => Container();

@widget
// ignore: undefined_class
Widget annotatedUndefinedType({@meta.required Color foo}) => Container();

@hwidget
Widget hookExample() => Container();

typedef Typedef = void Function();

@widget
Widget typedefFunction(Typedef t) => Container();

@widget
Widget inlineFunction(void t()) => Container();

@widget
Widget inlineFunction2(void Function() t) => Container();

@widget
Widget nestedFunction(void Function(void Function(int a), int b) t) =>
    Container();

@widget
// ignore: undefined_class
Widget unknownTypeFunction(Color Function() t) => Container();

@widget
Widget generic<T>(T foo) => Container();

@widget
Widget genericMultiple<T, S>(T foo, S bar) => Container();

@widget
Widget genericExtends<T extends Container>(T foo) => Container();

@widget
Widget genericClass<T>(T Function() foo) => Container();

typedef T _GenericFunction<T>(T foo);

@widget
Widget genericFunction(_GenericFunction<int> foo) => Container();

typedef _GenericFunction2 = T Function<T>(T foo);

@widget
Widget genericFunction2(_GenericFunction2 foo) => Container();
