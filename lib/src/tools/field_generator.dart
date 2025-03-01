import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成Field
class FieldGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  FieldGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final buffer = StringBuffer();
    for (final field in classDefinition.fields) {
      buffer.writeln();
      if (field.fieldElement.documentationComment != null) {
        buffer.writeln(field.fieldElement.documentationComment);
      }

      if (field.isCustomGetting) {
        buffer.writeln(field.code);
        continue;
      }
      if (field.fieldElement.isStatic) {
        buffer.writeln('static ${field.code};');
        continue;
      }
      if (field.fieldElement.isPrivate) {
        buffer.writeln('${field.code};');
        continue;
      }

      if (field.fieldElement.isFinal) {
        buffer.writeln('final ${field.type} ${field.fieldElement.name};');
        continue;
      }
      buffer.writeln('${field.type} ${field.fieldElement.name};');
    }
    return buffer.toString();
  }
}
