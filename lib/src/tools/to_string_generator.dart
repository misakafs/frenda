import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成toString
class ToStringGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  ToStringGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final method = classDefinition.methods.where((method) => method.methodElement.name == 'toString').firstOrNull;
    if (method != null) {
      var code = method.code ?? '';
      code = code.startsWith('@override') ? code : '@override\n$code';
      if (method.methodElement.documentationComment != null) {
        code = '${method.methodElement.documentationComment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    buffer.write('  @override\n  String toString() => \'${classDefinition.realName}(');

    List<String> fields = [];

    for (final field in classDefinition.fields) {
      if (field.isIgnore) {
        continue;
      }
      fields.add('${field.fieldElement.name}: \$${field.fieldElement.name}');
    }

    buffer.writeln('${fields.join(', ')})\';');
    return buffer.toString();
  }
}
