import 'package:frenda/src/config/config.dart';
import 'package:frenda/src/models/class_model.dart';

///
const Map<String, bool> overrides = {
  // 默认构造器
  'default': false,
  'fromJson': false,
  'toJson': true,
  'copyWith': false,
  'toString': true,
};

/// 代码生成
class CodeGenerator {
  final ClassDefinition classDefinition;
  final FrendaConfig config;

  ///
  CodeGenerator(this.classDefinition, this.config);

  ///
  Future<String> generate() async {
    final buffer = StringBuffer();

    // 添加必要的导入和类注释
    if (classDefinition.comment != null) {
      buffer.writeln('${classDefinition.comment}');
    }

    buffer.writeln('class ${classDefinition.realName} implements Serializable {');
    buffer.writeln();

    buffer.writeln(genFields());
    buffer.writeln();
    buffer.writeln(genConstructor());
    buffer.writeln();
    buffer.writeln(genMethods());
    buffer.writeln();
    buffer.writeln(genToJson());
    buffer.writeln();
    buffer.writeln(genFromJson());
    buffer.writeln();
    buffer.writeln(genCopyWith());
    buffer.writeln();
    buffer.writeln(genToString());
    buffer.writeln();
    buffer.writeln(genEqual());
    buffer.writeln();
    buffer.writeln(genHashCode());
    buffer.writeln();

    // 闭合类定义
    buffer.writeln('}');

    return buffer.toString();
  }

  /// 生成字段
  String genFields() {
    final buffer = StringBuffer();
    for (final field in classDefinition.fields) {
      if (field.comment != null) {
        buffer.writeln(field.comment);
      }
      buffer.writeln('${field.isFinal ? 'final' : ''} ${field.type} ${field.name};');
    }
    return buffer.toString();
  }

  /// 生成构造器
  String genConstructor() {
    final buffer = StringBuffer();

    final constructor1 = classDefinition.constructors.where((constructor) => constructor.name == 'default').firstOrNull;
    if (constructor1 != null) {
      if (constructor1.comment != null) {
        buffer.writeln(constructor1.comment);
      }
      final code = constructor1.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.name, classDefinition.realName));
      buffer.writeln();
    } else {
      buffer.write('${classDefinition.realName}({');
      final params = classDefinition.fields
          .map((field) {
            if (field.defaultValue != null) {
              return 'this.${field.name} = ${field.getDefaultValue()}';
            } else if (field.type.endsWith('?')) {
              return 'this.${field.name}';
            } else {
              return 'required this.${field.name}';
            }
          })
          .join(', ');
      buffer.write(params);
      buffer.writeln('});');
      buffer.writeln();
    }

    for (final constructor in classDefinition.constructors) {
      if (overrides.containsKey(constructor.name)) {
        continue;
      }
      if (constructor.comment != null) {
        buffer.writeln(constructor.comment);
      }
      final code = constructor.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.name, classDefinition.realName));
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// 生成自定义方法
  String genMethods() {
    final buffer = StringBuffer();
    for (final method in classDefinition.methods) {
      if (overrides.containsKey(method.name)) {
        continue;
      }
      if (method.comment != null) {
        buffer.writeln(method.comment);
      }
      buffer.writeln(method.code);
      buffer.writeln();
    }
    return buffer.toString();
  }

  /// 生成toJson
  String genToJson() {
    final method = classDefinition.methods.where((method) => method.name == 'toJson').firstOrNull;
    if (method != null) {
      var code = method.code ?? '';
      code = code.startsWith('@override') ? code : '@override\n$code';
      if (method.comment != null) {
        code = '${method.comment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    // 生成toJson方法
    buffer.writeln('@override');
    buffer.writeln('Map<String, dynamic> toJson() => {');
    for (final field in classDefinition.fields) {
      buffer.writeln("'${field.jsonName}': ${field.name},");
    }
    buffer.writeln('};');
    return buffer.toString();
  }

  /// 生成fromJson
  String genFromJson() {
    final buffer = StringBuffer();

    final constructor = classDefinition.constructors.where((constructor) => constructor.name == 'fromJson').firstOrNull;
    if (constructor != null) {
      if (constructor.comment != null) {
        buffer.writeln(constructor.comment);
      }
      final code = constructor.code ?? '';
      buffer.writeln(code.replaceAll(classDefinition.name, classDefinition.realName));
    } else {
      buffer.writeln('factory ${classDefinition.realName}.fromJson(Map<String, dynamic> json) =>');
      buffer.writeln('${classDefinition.realName}(');
      for (final field in classDefinition.fields) {
        if (field.isNested) {
          if (field.type.endsWith('?')) {
            final fieldType = field.type.substring(0, field.type.length - 1);
            buffer.writeln(
              '${field.name}: json[\'${field.jsonName}\'] == null ? null : $fieldType.fromJson(json[\'${field.jsonName}\']),',
            );
          } else {
            buffer.writeln('${field.name}: ${field.type}.fromJson(json[\'${field.jsonName}\']),');
          }
        } else {
          buffer.writeln('${field.name}: json[\'${field.jsonName}\'] as ${field.type},');
        }
      }
      buffer.writeln(');');
    }
    return buffer.toString();
  }

  /// 生成copyWith
  String genCopyWith() {
    final method = classDefinition.methods.where((method) => method.name == 'copyWith').firstOrNull;
    if (method != null) {
      var code = (method.code ?? '').replaceAll(config.prefix, '');
      if (method.comment != null) {
        code = '${method.comment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    buffer.writeln('${classDefinition.realName} copyWith({');
    for (final field in classDefinition.fields) {
      var fieldType = field.type.endsWith('?') ? field.type : '${field.type}?';
      buffer.writeln('$fieldType ${field.name},');
    }
    buffer.writeln('}) =>');
    buffer.writeln('${classDefinition.realName}(');
    for (final field in classDefinition.fields) {
      buffer.writeln('${field.name}: ${field.name} ?? this.${field.name},');
    }
    buffer.writeln(');');
    return buffer.toString();
  }

  /// 生成toString
  String genToString() {
    final method = classDefinition.methods.where((method) => method.name == 'toString').firstOrNull;
    if (method != null) {
      var code = method.code ?? '';
      code = code.startsWith('@override') ? code : '@override\n$code';
      if (method.comment != null) {
        code = '${method.comment}\n$code';
      }
      return code;
    }
    final buffer = StringBuffer();
    buffer.write('  @override\n  String toString() => \'${classDefinition.realName}(');
    final toStringParams = classDefinition.fields.map((field) => '${field.jsonName}: \$${field.name}').join(', ');
    buffer.writeln('$toStringParams)\';');
    return buffer.toString();
  }

  /// 生成operator ==
  String genEqual() {
    final buffer = StringBuffer();
    buffer.writeln('@override');
    buffer.writeln('bool operator ==(Object other) =>');
    buffer.writeln('identical(this, other) ||');
    buffer.writeln('(other is ${classDefinition.realName} &&');
    buffer.writeln('runtimeType == other.runtimeType &&');
    final equalityChecks = classDefinition.fields.map((field) => 'other.${field.name} == ${field.name}').join('&&\n');
    buffer.writeln('$equalityChecks);');
    return buffer.toString();
  }

  /// 生成hashCode
  String genHashCode() {
    final buffer = StringBuffer();
    buffer.writeln('@override');
    final hashCodeParts = classDefinition.fields.map((field) => field.name).join(', ');
    if (classDefinition.fields.length > 1) {
      buffer.writeln('int get hashCode => Object.hash($hashCodeParts);');
    } else {
      buffer.writeln('int get hashCode => $hashCodeParts.hashCode;');
    }
    return buffer.toString();
  }
}
