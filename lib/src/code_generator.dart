import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/index.dart';

/// 代码生成
class CodeGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  CodeGenerator(this.classDefinition, this.config);

  ///
  Future<String> generate() async {
    final buffer = StringBuffer();

    // 添加必要的导入和类注释
    if (classDefinition.classElement.documentationComment != null) {
      buffer.writeln('${classDefinition.classElement.documentationComment}');
    }

    buffer.writeln('class ${classDefinition.realName} implements Serializable {');
    buffer.writeln();

    List<ToolGenerator> tools = [
      FieldGenerator(classDefinition, config),
      ConstructorGenerator(classDefinition, config),
      MethodGenerator(classDefinition, config),
      ToJsonGenerator(classDefinition, config),
      FromJsonGenerator(classDefinition, config),
      CopyWithGenerator(classDefinition, config),
      ToStringGenerator(classDefinition, config),
      EqualGenerator(classDefinition, config),
      HashCodeGenerator(classDefinition, config),
    ];

    for (var t in tools) {
      buffer.writeln(t.generate());
      buffer.writeln();
    }

    // 闭合类定义
    buffer.writeln('}');

    return buffer.toString();
  }
}
