import 'package:analyzer/dart/constant/value.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:source_gen/source_gen.dart';

FunctionalWidget parseFunctionalWidetAnnotation(ConstantReader reader) {
  return FunctionalWidget(
    widgetType: _parseEnum(
      reader.read('widgetType'),
      FunctionalWidgetType.values,
    ),
    equality: _parseEnum(
      reader.read('equality'),
      FunctionalWidgetEquality.values,
    ),
  );
}

T _parseEnum<T>(ConstantReader reader, List<T> values) {
  if (reader.isNull) return null;
  return _enumValueForDartObject(
    reader.objectValue,
    values,
    (value) => value.toString().split('.')[1],
  );
}

// code from json_serializable
T _enumValueForDartObject<T>(
  DartObject source,
  List<T> items,
  String Function(T) name,
) {
  return items.singleWhere(
    (v) => source.getField(name(v)) != null,
  );
}
