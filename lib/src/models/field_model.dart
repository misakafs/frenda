///
class FieldDefinition {
  final String name;
  final String jsonName;
  final String? comment;
  final String type;
  final bool isFinal;
  final bool isNested;
  final dynamic defaultValue;

  ///
  const FieldDefinition({
    required this.name,
    required this.jsonName,
    this.comment,
    required this.type,
    required this.isFinal,
    required this.isNested,
    this.defaultValue,
  });

  ///
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'jsonName': jsonName,
      'comment': comment,
      'type': type,
      'isFinal': isFinal,
      'isNested': isNested,
      'defaultValue': defaultValue,
    };
  }

  ///
  String getDefaultValue() {
    if (defaultValue == null) {
      return '';
    }
    if (defaultValue.startsWith('const')) {
      return defaultValue.toString();
    }
    if (defaultValue.startsWith('[')) {
      return 'const ${defaultValue.toString()}';
    }
    if (defaultValue.startsWith('{')) {
      return 'const ${defaultValue.toString()}';
    }
    return defaultValue.toString();
  }
}
