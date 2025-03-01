import 'package:analyzer/dart/element/element.dart';

import 'constructor_model.dart';
import 'field_model.dart';
import 'method_model.dart';

///
class ClassDefinition {
  ///
  final ClassElement classElement;

  ///
  final String realName;

  ///
  final List<ConstructorDefinition> constructors;

  ///
  final List<MethodDefinition> methods;

  ///
  final List<FieldDefinition> fields;

  ///
  const ClassDefinition({
    required this.classElement,
    required this.realName,
    required this.constructors,
    required this.methods,
    required this.fields,
  });
}
