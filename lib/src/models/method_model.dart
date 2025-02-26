///
class MethodDefinition {
  ///
  final String name;

  ///
  final String? comment;

  ///
  final String? code;

  ///
  const MethodDefinition({required this.name, this.comment, this.code});

  ///
  Map<String, dynamic> toJson() {
    return {'name': name, 'comment': comment, 'code': code};
  }
}
