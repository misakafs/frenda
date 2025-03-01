import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

///
class FieldDefinition {
  ///
  final FieldElement fieldElement;

  ///
  final String jsonName;

  ///
  final String type;

  ///
  final dynamic defaultValue;

  ///
  final String code;

  ///
  const FieldDefinition({
    required this.fieldElement,
    required this.jsonName,
    required this.type,
    this.defaultValue,
    required this.code,
  });

  /// 是否是显式定义的getter
  bool get isCustomGetting => !fieldElement.getter!.isSynthetic;

  /// 类型是否为空
  bool get isNullable => fieldElement.type.nullabilitySuffix == NullabilitySuffix.question;

  /// 构造器是否需要忽略的字段
  bool get isIgnore => isCustomGetting || fieldElement.isStatic || fieldElement.isPrivate;

  /// info
  void printInfo() {
    final m = {
      'name': fieldElement.name,
      'isStatic': fieldElement.isStatic,
      'isConst': fieldElement.isConst,
      'isConstantEvaluated': fieldElement.isConstantEvaluated,
      'isFinal': fieldElement.isFinal,
      'hasInitializer': fieldElement.hasInitializer,
      'isPrivate': fieldElement.isPrivate,
      'isPublic': fieldElement.isPublic,
      'nullabilitySuffix': fieldElement.type.nullabilitySuffix,
      'type': fieldElement.type.toString(),
      'getter': !fieldElement.getter!.isSynthetic,
      'code': code,
    };
    print(m);
  }

  ///
  String getDefaultValue() {
    if (defaultValue == null) {
      return '';
    }
    if (defaultValue.startsWith('const')) {
      return defaultValue.toString();
    }
    if (defaultValue.startsWith('[')) {
      return 'const ${defaultValue.toString()}';
    }
    if (defaultValue.startsWith('{')) {
      return 'const ${defaultValue.toString()}';
    }
    return defaultValue.toString();
  }
}
