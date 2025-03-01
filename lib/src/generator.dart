import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:frenda/src/annotations/annotations.dart';
import 'package:frenda/src/config/config.dart';
import 'package:source_gen/source_gen.dart';

import 'code_generator.dart';
import 'parse_class.dart';

///
class FrendaGenerator extends GeneratorForAnnotation<Frenda> {
  ///
  final FrendaConfig config;

  ///
  FrendaGenerator(this.config);

  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement || element is EnumElement) {
      throw InvalidGenerationSourceError('`@frenda` can only be used on classes.', element: element);
    }

    if (!element.name.startsWith(config.prefix)) {
      // 必须以指定的字符串进行开头
      throw InvalidGenerationSourceError(
        '`@frenda` annotated class ${element.name} must start with the prefix "${config.prefix}".',
        element: element,
      );
    }

    // 提取类的信息
    final classDefinition = await ParseClass(buildStep, element, config).parse();

    // 生成对应的代码
    final result = await CodeGenerator(classDefinition, config).generate();

    return result;
  }
}
