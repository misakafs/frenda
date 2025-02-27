import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:frenda/src/annotations/annotations.dart';
import 'package:frenda/src/config/config.dart';
import 'package:source_gen/source_gen.dart';

import 'code_generator.dart';
import 'parse_generator.dart';

///
class FrendaGenerator extends GeneratorForAnnotation<Frenda> {
  ///
  final FrendaConfig config;

  ///
  FrendaGenerator(this.config);

  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('`@frenda` can only be applied on classes.', element: element);
    }

    // 提取类的信息
    final classDefinition = await ParseGenerator(buildStep, element, config).parse();

    // 生成对应的代码
    final result = await CodeGenerator(classDefinition, config).generate();

    return result;
  }
}
