import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成equal
class EqualGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  EqualGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final buffer = StringBuffer();
    buffer.writeln('@override');
    buffer.writeln('bool operator ==(Object other) =>');
    buffer.writeln('identical(this, other) ||');
    buffer.writeln('(other is ${classDefinition.realName} &&');
    buffer.writeln('runtimeType == other.runtimeType &&');

    List<String> fields = [];

    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }
      fields.add('other.${field.fieldElement.name} == ${field.fieldElement.name}');
    }

    buffer.writeln('${fields.join('&&\n')});');
    return buffer.toString();
  }
}
