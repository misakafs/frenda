///
class ConstructorDefinition {
  final String name;
  final String? comment;

  final String? code;

  ///
  const ConstructorDefinition({required this.name, this.comment, this.code});

  ///
  Map<String, dynamic> toJson() {
    return {'name': name, 'comment': comment, 'code': code};
  }
}
