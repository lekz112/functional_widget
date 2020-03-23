import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:functional_widget/src/helpers/parameters.dart';
import 'package:functional_widget/src/parse_functional_widget_annotation.dart';
import 'package:functional_widget/src/parse_generator.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

class _Data {
  _Data({
    @required this.name,
    @required this.widgetType,
    @required this.parameters,
  }) : outputName = _parseOutputName(name);

  static String _parseOutputName(String name) {
    final public = name.startsWith('_') ? name.substring(1) : name;

    return public.replaceFirstMapped(RegExp('[a-zA-Z]'), (match) {
      return match.group(0).toUpperCase();
    });
  }

  final String name;
  final String outputName;
  final FunctionalWidgetType widgetType;
  final Parameters parameters;
}

class FunctionalWidgetGenerator
    extends ParserGenerator<void, _Data, FunctionalWidget> {
  FunctionalWidgetGenerator(this.defaultOptions);

  final FunctionalWidget defaultOptions;

  @override
  Iterable<Object> generateForData(void globalData, _Data data) sync* {
    yield functionToClass(data);
  }

  @override
  _Data parseElement(
    void globalData,
    Element rawElement,
    ConstantReader annotation,
  ) {
    FunctionElement element;
    if (rawElement is! FunctionElement) {
      // TODO:
      throw InvalidGenerationSourceError(
        '@FunctionalWidget annotation used on a something other than a function',
      );
    }
    element = rawElement as FunctionElement;

    final functionalWidget = parseFunctionalWidetAnnotation(annotation);
    return _Data(
      name: element.name,
      widgetType: functionalWidget.widgetType ?? defaultOptions.widgetType,
      parameters: Parameters.fromParameterElements(element.parameters),
    );
  }

  @override
  void parseGlobalData(LibraryElement library) {}

  String functionToClass(_Data data) {
    final buildParameters = data.parameters.call((parameter) {
      if (parameter.type != null) {
        if (parameter.type.isBuildContext) {
          return 'context';
        }
        if (parameter.type.isKey) {
          return 'key';
        }
      }
      return '_${parameter.name}';
    });

    bool isNotKeyOrContext(ParameterElement p) {
      if (p.type != null && (p.type.isBuildContext || p.type.isKey)) {
        return false;
      }
      return true;
    }

    final parametersToCompute =
        data.parameters.all.where(isNotKeyOrContext).toList();

    final properties =
        parametersToCompute.map((p) => 'final ${p.type} _${p.name};');

    final constructorPositionalParameters = parametersToCompute
        .where((p) => p.isPositional)
        .map((e) => '${e.type} ${e.name},');

    final constructorNamedParameters = [
      'Key key,',
      ...parametersToCompute.where((p) => p.isNamed).map((p) {
        var res = p.hasRequired ? '@required' : '';

        return '$res ${p.type} ${p.name},';
      }),
    ];

    final constructorInitializers = parametersToCompute.map((p) {
      return '_${p.name} = ${p.name},';
    });

    return '''
class ${data.outputName} extends ${data.widgetType.superClass} {
  const ${data.outputName}(${constructorPositionalParameters.join()}{${constructorNamedParameters.join()}}): ${constructorInitializers.join()} super(key: key);

  ${properties.join()}

  @override
  Widget build(BuildContext context) {
    return ${data.name}($buildParameters);
  }
}
''';
  }
}

extension on DartType {
  bool get isBuildContext {
    return getDisplayString() == 'BuildContext';
  }

  bool get isKey {
    return getDisplayString() == 'Key';
  }
}

extension on FunctionalWidgetType {
  String get superClass {
    switch (this) {
      case FunctionalWidgetType.hook:
        return 'HookWidget';
      case FunctionalWidgetType.stateless:
      default:
        return 'StatelessWidget';
    }
  }
}
