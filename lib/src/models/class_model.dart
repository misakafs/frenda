import 'constructor_model.dart';
import 'field_model.dart';
import 'method_model.dart';

///
class ClassDefinition {
  ///
  final String name;

  ///
  final String realName;

  ///
  final String? comment;

  ///
  final List<ConstructorDefinition> constructors;

  ///
  final List<MethodDefinition> methods;

  ///
  final List<FieldDefinition> fields;

  ///
  const ClassDefinition({
    required this.name,
    required this.realName,
    this.comment,
    required this.constructors,
    required this.methods,
    required this.fields,
  });

  ///
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'realName': realName,
      'comment': comment,
      'constructors': constructors,
      'methods': methods.map((method) => method.toJson()).toList(),
      'fields': fields.map((field) => field.toJson()).toList(),
    };
  }
}
