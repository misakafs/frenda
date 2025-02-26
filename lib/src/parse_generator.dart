import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:frenda/src/models/class_model.dart';
import 'package:frenda/src/models/method_model.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations/annotations.dart';
import 'config/config.dart';
import 'models/constructor_model.dart';
import 'models/field_model.dart';

/// 解析类
class ParseGenerator {
  ///
  final BuildStep buildStep;

  ///
  final ClassElement element;

  ///
  final FrendaConfig config;

  ///
  ParseGenerator(this.buildStep, this.element, this.config);

  ///
  Future<ClassDefinition> parse() async {
    // 获取类名
    final className = element.name;

    final classRealName = className.substring(config.prefix.length);

    // 获取注释
    final classComment = element.documentationComment;

    final constructors = await _getConstructors();

    // 获取所有的自定义方法
    final methods = await _getMethodDefinitions();

    // 获取所有的字段
    final fields = _getFieldDefinitions();

    return ClassDefinition(
      name: className,
      realName: classRealName,
      comment: classComment,
      constructors: constructors,
      methods: methods,
      fields: fields,
    );
  }

  // 获取所有的构造器
  Future<List<ConstructorDefinition>> _getConstructors() async {
    List<ConstructorDefinition> constructors = [];

    for (final constructor in element.constructors) {
      final code = await buildStep.resolver.astNodeFor(constructor, resolve: true).then((value) => value?.toSource());
      var name = constructor.name;
      if (name == '') {
        name = 'default';
      }
      if (code != null) {
        constructors.add(ConstructorDefinition(name: name, comment: constructor.documentationComment, code: code));
      }
    }

    return constructors;
  }

  /// 获取所有的自定义方法
  Future<List<MethodDefinition>> _getMethodDefinitions() async {
    List<MethodDefinition> methods = [];

    for (final method in element.methods) {
      final code = await buildStep.resolver.astNodeFor(method, resolve: true).then((value) => value?.toSource());
      if (code != null) {
        methods.add(MethodDefinition(name: method.name, comment: method.documentationComment, code: code));
      }
    }

    return methods;
  }

  /// 获取字段列表
  List<FieldDefinition> _getFieldDefinitions() {
    return element.fields.map((field) {
      final value = field.hasInitializer ? _getAstFromElement(field).childEntities.last.toString() : null;

      final annotation = _getFiledAnnotation(field);

      var fieldType = field.type.toString();

      var isNested = false;

      if (fieldType.startsWith(config.prefix)) {
        isNested = true;
        fieldType = fieldType.substring(config.prefix.length);
      }

      return FieldDefinition(
        name: field.name,
        jsonName: annotation?.json ?? field.name,
        comment: field.documentationComment,
        type: fieldType,
        isFinal: field.isFinal,
        isNested: isNested,
        defaultValue: value,
      );
    }).toList();
  }

  /// 获取字段注解
  Filed? _getFiledAnnotation(FieldElement field) {
    for (final annotation in field.metadata) {
      final constantValue = annotation.computeConstantValue();
      if (constantValue?.type?.getDisplayString() == 'Filed') {
        final reader = ConstantReader(constantValue);
        return Filed(reader.peek('json')?.stringValue);
      }
    }
    return null;
  }

  AstNode _getAstFromElement(FieldElement field) {
    final parsedLibResult = field.session!.getParsedLibraryByElement(field.library);
    return (parsedLibResult as ParsedLibraryResult).getElementDeclaration(field)!.node;
  }
}
