import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成hashCode
class HashCodeGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  HashCodeGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final buffer = StringBuffer();
    buffer.writeln('@override');

    List<String> fields = [];

    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }
      fields.add(field.fieldElement.name);
    }

    final hashCodeParts = fields.join(',');
    if (classDefinition.fields.length > 1) {
      buffer.writeln('int get hashCode => Object.hash($hashCodeParts);');
    } else {
      buffer.writeln('int get hashCode => $hashCodeParts.hashCode;');
    }
    return buffer.toString();
  }
}
