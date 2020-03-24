import 'package:build/build.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

const _kKnownOptionsName = ['widgetType', 'equality', 'debugFillProperties'];

FunctionalWidget parseBuilderOptions(BuilderOptions options) {
  final unknownOption = options?.config?.keys?.firstWhere(
      (key) => !_kKnownOptionsName.contains(key),
      orElse: () => null);

  if (unknownOption != null) {
    throw ArgumentError(
        'Unknown option `$unknownOption`: ${options.config[unknownOption]}');
  }
  final widgetType = _parseWidgetType(options.config['widgetType']);
  final debugFillProperties =
      _parseDebugFillProperties(options.config['debugFillProperties']);
  final equality = _parseEquality(options.config['equality']);
  return FunctionalWidget(
    widgetType: widgetType,
    debugFillProperties: debugFillProperties,
    equality: equality,
  );
}

bool _parseDebugFillProperties(dynamic value) {
  if (value == null) {
    // ignore: avoid_returning_null
    return null;
  }
  if (value is bool) {
    return value;
  }
  throw ArgumentError.value(value, 'debugFillProperties',
      'Invalid value. Potential values are `true` or `false`');
}

FunctionalWidgetEquality _parseEquality(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    switch (value) {
      case 'none':
        return FunctionalWidgetEquality.none;
      case 'equal':
        return FunctionalWidgetEquality.equal;
      case 'identical':
        return FunctionalWidgetEquality.identical;
    }
  }
  throw ArgumentError.value(value, 'widgetType',
      'Invalid value. Potential values are `none`/`equal`/`identical`');
}

FunctionalWidgetType _parseWidgetType(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    switch (value) {
      case 'hook':
        return FunctionalWidgetType.hook;
      case 'stateless':
        return FunctionalWidgetType.stateless;
    }
  }
  throw ArgumentError.value(value, 'widgetType',
      'Invalid value. Potential values are `hook` or `stateless`');
}
