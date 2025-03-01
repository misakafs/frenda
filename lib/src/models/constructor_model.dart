import 'package:analyzer/dart/element/element.dart';

///
class ConstructorDefinition {
  ///
  final ConstructorElement constructorElement;

  ///
  final String? code;

  ///
  const ConstructorDefinition({required this.constructorElement, this.code});
}
