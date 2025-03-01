import 'package:analyzer/dart/element/element.dart';

///
class MethodDefinition {
  ///
  final MethodElement methodElement;

  ///
  final String? code;

  ///
  const MethodDefinition({required this.methodElement, this.code});
}
