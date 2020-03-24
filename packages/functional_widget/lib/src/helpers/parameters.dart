import 'package:analyzer/dart/element/element.dart';
import 'package:meta/meta.dart';

/// Utility to deal with passing parameters
class Parameters {
  Parameters({
    @required this.requiredPositionalParameters,
    @required this.namedParameters,
  });

  factory Parameters.fromParameterElements(List<ParameterElement> parameters) {
    return Parameters(
      requiredPositionalParameters:
          parameters.where((p) => p.isRequiredPositional).toList(),
      namedParameters: parameters.where((p) => p.isNamed).toList(),
    );
  }

  final List<ParameterElement> requiredPositionalParameters;
  final List<ParameterElement> namedParameters;

  Iterable<ParameterElement> get all sync* {
    yield* requiredPositionalParameters;
    yield* namedParameters;
  }

  String call(String valueForParameter(ParameterElement parameter)) {
    String writeParameter(ParameterElement parameter) {
      var res = '';
      if (parameter.isNamed) {
        res = '${parameter.name}:';
      }
      res = '$res ${valueForParameter(parameter)}';
      return res;
    }

    final buffer = StringBuffer()
      ..writeAll(
        requiredPositionalParameters.map<String>(writeParameter),
        ', ',
      );

    if (buffer.isNotEmpty && namedParameters.isNotEmpty) {
      buffer.write(', ');
    }
    if (namedParameters.isNotEmpty) {
      buffer.writeAll(namedParameters.map<String>(writeParameter), ', ');
    }

    return buffer.toString();
  }
}
