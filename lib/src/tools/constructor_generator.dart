import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成Constructor
class ConstructorGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  ConstructorGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final buffer = StringBuffer();

    // 默认构造器
    final constructor1 =
        classDefinition.constructors
            .where(
              (constructor) =>
                  (constructor.constructorElement.isGenerative && constructor.constructorElement.name.isEmpty),
            )
            .firstOrNull;
    if (constructor1 != null) {
      if (constructor1.constructorElement.documentationComment != null) {
        buffer.writeln(constructor1.constructorElement.documentationComment);
      }
      final code = constructor1.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.classElement.name, classDefinition.realName));
      buffer.writeln();
    } else {
      buffer.write('${classDefinition.realName}({');

      List<String> fields = [];

      for (final field in classDefinition.fields) {
        if (field.isIgnore) {
          continue;
        }
        if (field.defaultValue != null) {
          fields.add('this.${field.fieldElement.name} = ${field.getDefaultValue()}');
          continue;
        }
        if (field.isNullable) {
          fields.add('this.${field.fieldElement.name}');
          continue;
        }
        fields.add('required this.${field.fieldElement.name}');
      }
      buffer.write(fields.join(','));
      buffer.writeln('});');
      buffer.writeln();
    }

    // 其他自定义构造器
    for (final constructor in classDefinition.constructors) {
      if ((constructor.constructorElement.isGenerative && constructor.constructorElement.name.isEmpty) ||
          constructor.constructorElement.name == 'fromJson') {
        continue;
      }
      if (constructor.constructorElement.documentationComment != null) {
        buffer.writeln(constructor.constructorElement.documentationComment);
      }
      final code = constructor.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.classElement.name, classDefinition.realName));
      buffer.writeln();
    }

    return buffer.toString();
  }
}
