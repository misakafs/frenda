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
class ParseClass {
  ///
  final BuildStep buildStep;

  ///
  final ClassElement element;

  ///
  final FrendaConfig config;

  ///
  ParseClass(this.buildStep, this.element, this.config);

  ///
  Future<ClassDefinition> parse() async {
    // 获取类名
    final className = element.name;

    final classRealName = className.substring(config.prefix.length);

    // 获取构造器，覆盖生成的构造器，暂时不支持，会有很多问题
    // final constructors = await _getConstructors();
    final List<ConstructorDefinition> constructors = [];

    // 获取所有的自定义方法
    final methods = await _getMethodDefinitions();

    // 获取所有的字段
    final fields = await _getFieldDefinitions();

    return ClassDefinition(
      classElement: element,
      realName: classRealName,
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
      if (code != null) {
        constructors.add(ConstructorDefinition(constructorElement: constructor, code: code));
      }
    }

    return constructors;
  }

  /// 获取所有的自定义方法
  Future<List<MethodDefinition>> _getMethodDefinitions() async {
    List<MethodDefinition> methods = [];

    const whites = ['copyWith'];

    for (final method in element.methods) {
      if (whites.contains(method.name)) {
        continue;
      }
      final code = await buildStep.resolver.astNodeFor(method, resolve: true).then((value) => value?.toSource());
      if (code != null) {
        methods.add(MethodDefinition(methodElement: method, code: code));
      }
    }

    return methods;
  }

  /// 获取字段列表
  Future<List<FieldDefinition>> _getFieldDefinitions() async {
    List<FieldDefinition> fields = [];

    for (final field in element.fields) {
      final value = field.hasInitializer ? _getAstFromElement(field).childEntities.last.toString() : null;

      final annotation = _getFiledAnnotation(field);

      var fieldType = field.type.toString();

      if (fieldType.contains(config.prefix)) {
        fieldType = fieldType.replaceAll(config.prefix, '');
      }
      String? code;
      if (field.getter != null && !field.getter!.isSynthetic) {
        code = await buildStep.resolver.astNodeFor(field.getter!, resolve: true).then((value) => value?.toSource());
      } else {
        code = await buildStep.resolver.astNodeFor(field, resolve: true).then((value) => value?.parent?.toSource());
      }

      fields.add(
        FieldDefinition(
          fieldElement: field,
          jsonName: annotation?.json ?? field.name,
          type: fieldType,
          defaultValue: value,
          code: code ?? '',
        ),
      );
    }

    return fields;
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
