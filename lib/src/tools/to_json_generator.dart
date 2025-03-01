import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';
import 'package:frenda/src/tools/type_parser.dart';

/// 生成toJson
class ToJsonGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  ToJsonGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final method = classDefinition.methods.where((method) => method.methodElement.name == 'toJson').firstOrNull;
    if (method != null) {
      var code = method.code ?? '';
      code = code.startsWith('@override') ? code : '@override\n$code';
      if (method.methodElement.documentationComment != null) {
        code = '${method.methodElement.documentationComment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    // 生成toJson方法
    buffer.writeln('@override');
    buffer.writeln('Map<String, dynamic> toJson() => {');
    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }

      buffer.writeln(
        "'${field.jsonName}': ${parser.parse(field.type).generateSerializeCode(field.fieldElement.name, nullable: field.isNullable)},",
      );
    }
    buffer.writeln('};');
    return buffer.toString();
  }
}
