import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成copyWith
class CopyWithGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  CopyWithGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final method = classDefinition.methods.where((method) => method.methodElement.name == 'copyWith').firstOrNull;
    if (method != null) {
      var code = (method.code ?? '').replaceAll(config.prefix, '');
      if (method.methodElement.documentationComment != null) {
        code = '${method.methodElement.documentationComment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    buffer.writeln('${classDefinition.realName} copyWith({');
    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }
      var fieldType = field.isNullable ? field.type : '${field.type}?';
      buffer.writeln('$fieldType ${field.fieldElement.name},');
    }
    buffer.writeln('}) =>');
    buffer.writeln('${classDefinition.realName}(');
    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }
      buffer.writeln('${field.fieldElement.name}: ${field.fieldElement.name} ?? this.${field.fieldElement.name},');
    }
    buffer.writeln(');');
    return buffer.toString();
  }
}
