import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/models/field_model.dart';
import 'package:frenda/src/tools/tool_generator.dart';
import 'package:frenda/src/tools/type_parser.dart';

/// 生成fromJson
class FromJsonGenerator implements ToolGenerator {
  ///
  final ClassDefinition classDefinition;

  ///
  final FrendaConfig config;

  ///
  FromJsonGenerator(this.classDefinition, this.config);

  ///
  @override
  String generate() {
    final buffer = StringBuffer();

    final constructor =
        classDefinition.constructors
            .where((constructor) => constructor.constructorElement.name == 'fromJson')
            .firstOrNull;
    if (constructor != null) {
      if (constructor.constructorElement.documentationComment != null) {
        buffer.writeln(constructor.constructorElement.documentationComment);
      }
      final code = constructor.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.classElement.name, classDefinition.realName));
    } else {
      buffer.writeln('factory ${classDefinition.realName}.fromJson(Map<String, dynamic> json) =>');
      buffer.writeln('${classDefinition.realName}(');
      for (final field in classDefinition.fields) {
        if (field.isIgnore) {
          continue;
        }
        buffer.writeln('${field.fieldElement.name}: ${_generateByField(field)},');
      }
      buffer.writeln(');');
    }
    return buffer.toString();
  }

  String _generateByField(FieldDefinition field) {
    // if (field.fieldElement.type.isDartCoreString) {
    //   final asType = field.isNullable ? 'String?' : 'String';
    //   return 'json["${field.jsonName}"] as $asType';
    // } else if (field.fieldElement.type.isDartCoreInt) {
    //   final asType = field.isNullable ? 'int?' : 'int';
    //   return 'json["${field.jsonName}"] as $asType';
    // } else if (field.fieldElement.type.isDartCoreDouble) {
    //   final asType = field.isNullable ? 'double?' : 'double';
    //   return 'json["${field.jsonName}"] as $asType';
    // } else if (field.fieldElement.type.isDartCoreBool) {
    //   final asType = field.isNullable ? 'bool?' : 'bool';
    //   return 'json["${field.jsonName}"] as $asType';
    // } else if (field.fieldElement.type.isDartCoreNum) {
    //   final asType = field.isNullable ? 'num?' : 'num';
    //   return 'json["${field.jsonName}"] as $asType';
    // }
    return parser.parse(field.type).generateDeserializeCode(field.jsonName, nullable: field.isNullable);
  }
}
