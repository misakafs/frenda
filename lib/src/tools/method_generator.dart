import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';

/// 生成method
class MethodGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  MethodGenerator(this.classDefinition, this.config);

  static final List<String> _defaultMethods = ['toString', 'copyWith', 'toJson'];

  ///
  @override
  String generate() {
    final buffer = StringBuffer();
    for (final method in classDefinition.methods) {
      if (_defaultMethods.contains(method.methodElement.name)) {
        continue;
      }
      if (method.methodElement.documentationComment != null) {
        buffer.writeln(method.methodElement.documentationComment);
      }
      buffer.writeln(method.code);
      buffer.writeln();
    }
    return buffer.toString();
  }
}
