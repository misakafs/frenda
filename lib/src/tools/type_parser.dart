/// 遍历回调函数类型定义
typedef TypeNodeVisitor = void Function(TypeNode node);

///
class TypeNode {
  /// 类型名称
  final String name;

  /// 类型的子节点列表
  final List<TypeNode> children;

  /// 当前节点的层级，根节点为0
  final int level;

  ///
  TypeNode(this.name, {this.children = const [], this.level = 0});

  /// 判断当前类型是否可空
  bool get isNullable => name.endsWith('?');

  /// 创建子节点，自动设置正确的层级
  TypeNode createChild(String name, [List<TypeNode> children = const []]) {
    return TypeNode(name, children: children, level: level + 1);
  }

  /// 深度优先遍历
  void traverse(TypeNodeVisitor visitor) {
    visitor(this);
    for (var child in children) {
      child.traverse(visitor);
    }
  }

  /// 广度优先遍历
  void traverseBFS(TypeNodeVisitor visitor) {
    List<TypeNode> queue = [this];
    while (queue.isNotEmpty) {
      var node = queue.removeAt(0);
      visitor(node);
      queue.addAll(node.children);
    }
  }

  /// 查找特定名称的所有节点
  List<TypeNode> findByName(String name) {
    List<TypeNode> results = [];
    traverse((node) {
      if (node.name == name) {
        results.add(node);
      }
    });
    return results;
  }

  /// 获取最大嵌套深度
  int get maxDepth {
    if (children.isEmpty) return level;
    return children.map((child) => child.maxDepth).reduce((max, depth) => depth > max ? depth : max);
  }

  /// 是否是叶子节点
  bool get isLeaf => children.isEmpty;

  /// 获取所有叶子节点
  List<TypeNode> get leaves {
    List<TypeNode> results = [];
    traverse((node) {
      if (node.isLeaf) {
        results.add(node);
      }
    });
    return results;
  }

  /// 判断是否是基本类型
  bool get isPrimitiveType {
    final type = (isNullable ? name.substring(0, name.length - 1) : name).toLowerCase();
    return type == 'string' ||
        type == 'int' ||
        type == 'double' ||
        type == 'bool' ||
        type == 'dynamic' ||
        type == 'num';
  }

  /// 生成序列化代码
  /// @param fieldName 要序列化的字段名称
  /// @param nullable 是否顶层可空类型
  String generateSerializeCode(String fieldName, {bool nullable = false}) {
    String nullableStr = nullable ? '?' : '';
    String defaultValue = nullable ? ' ?? []' : '';

    // 基本类型直接返回
    if (children.isEmpty) {
      if (isPrimitiveType) {
        // 基本类型直接返回字段名，不需要任何转换
        return fieldName;
      } else {
        // 非基本类型（自定义类型），需要调用toJson方法
        return '$fieldName$nullableStr.toJson()';
      }
    }

    // 处理List类型
    if (name == 'List') {
      var innerType = children[0];

      if (innerType.children.isEmpty) {
        if (innerType.isPrimitiveType) {
          // 基本类型的List
          return '$fieldName$nullableStr.map((x$level) => x$level).toList()$defaultValue';
        } else {
          // 自定义类型的List
          return '$fieldName$nullableStr.map((x$level) => x$level.toJson()).toList()$defaultValue';
        }
      } else {
        // 嵌套类型的List
        return '$fieldName$nullableStr.map((x$level) => ${innerType.generateSerializeCode("x$level", nullable: innerType.isNullable)}).toList()$defaultValue';
      }
    }

    // 处理Map类型
    if (name == 'Map') {
      var keyType = children[0];
      var valueType = children[1];
      defaultValue = nullable ? ' ?? {}' : '';

      String keyConversion;
      if (keyType.isPrimitiveType) {
        String keyTypeName = keyType.name.toLowerCase().replaceAll('?', '');
        keyConversion = keyTypeName == 'string' ? 'k$level' : 'k$level.toString()';
      } else {
        keyConversion = 'k$level.toString()';
      }

      if (valueType.children.isEmpty) {
        if (valueType.isPrimitiveType) {
          // 基本类型的Map值
          return '$fieldName$nullableStr.map((k$level, v$level) => MapEntry($keyConversion, v$level))$defaultValue';
        } else {
          // 自定义类型的Map值
          return '$fieldName$nullableStr.map((k$level, v$level) => MapEntry($keyConversion, v$level.toJson()))$defaultValue';
        }
      } else {
        // 嵌套类型的Map值
        return '$fieldName$nullableStr.map((k$level, v$level) => MapEntry($keyConversion, ${valueType.generateSerializeCode("v$level", nullable: valueType.isNullable)}))$defaultValue';
      }
    }

    return fieldName;
  }

  /// 生成反序列化代码
  /// @param jsonKey JSON中的键名
  /// @param nullable 是否可空类型
  /// @param inner 是否是内部类型
  String generateDeserializeCode(String jsonKey, {bool nullable = false, bool inner = false}) {
    var valueStr = inner ? jsonKey : "json['$jsonKey']";

    // 基本类型直接返回
    if (children.isEmpty) {
      if (isPrimitiveType) {
        return valueStr;
      } else {
        // 非基本类型，假定为自定义类型
        return '$name.fromJson($valueStr ${nullable ? " ?? {}" : ""})';
      }
    }

    // 处理List类型
    if (name == 'List') {
      var innerType = children[0];
      var nullableStr = nullable ? "?" : '';

      if (innerType.children.isEmpty) {
        if (innerType.isPrimitiveType) {
          // 基本类型的List
          return "($valueStr as List<dynamic>$nullableStr)$nullableStr.map((x$level) => x$level as ${innerType.toString()}${innerType.isNullable ? '?' : ''}).toList()";
        } else {
          // 自定义类型的List
          return "($valueStr as List<dynamic>$nullableStr)$nullableStr.map((x$level) => ${innerType.name}.fromJson(x$level)).toList()";
        }
      } else {
        // 嵌套类型的List
        return "($valueStr as List<dynamic>$nullableStr)$nullableStr.map((x$level) => ${innerType.generateDeserializeCode("x$level", nullable: innerType.isNullable, inner: true)}).toList()";
      }
    }

    // 处理Map类型
    if (name == 'Map') {
      var keyType = children[0];
      var valueType = children[1];
      var nullableStr = nullable ? "?" : '';

      String keyDeserialization;
      String keyTypeName = keyType.name.toLowerCase().replaceAll('?', '');
      switch (keyTypeName) {
        case 'string':
          keyDeserialization = 'k$level';
          break;
        case 'int':
          keyDeserialization = 'int.parse(k$level)';
          break;
        case 'double':
          keyDeserialization = 'double.parse(k$level)';
          break;
        case 'bool':
          keyDeserialization = 'k$level == "true"';
          break;
        default:
          keyDeserialization = 'k$level';
      }

      return '($valueStr as Map<String, ${valueType.isPrimitiveType ? valueType.name : 'dynamic'}>$nullableStr)$nullableStr.map((k$level, v$level) => MapEntry($keyDeserialization, ${valueType.generateDeserializeCode("v$level", nullable: valueType.isNullable, inner: true)}))';
    }

    return valueStr;
  }

  @override
  String toString() {
    if (children.isEmpty) {
      return name;
    }
    return '$name<${children.join(", ")}>';
  }

  /// 打印树形结构
  String toTreeString([String indent = '']) {
    var result = '$indent$name (level: $level)\n';
    for (var i = 0; i < children.length; i++) {
      var isLast = i == children.length - 1;
      var childIndent = '$indent${isLast ? '└── ' : '├── '}';
      var childrenIndent = '$indent${isLast ? '    ' : '│   '}';
      result += children[i].toTreeString(childIndent);
    }
    return result;
  }
}

///
class TypeParser {
  ///
  int position = 0;

  ///
  String input = '';

  ///
  TypeNode parse(String typeString) {
    input = typeString.replaceAll(' ', '');
    position = 0;
    return parseType(0);
  }

  ///
  TypeNode parseType(int level) {
    String name = parseName();
    if (position < input.length && input[position] == '<') {
      position++; // 跳过 '<'
      List<TypeNode> children = [];

      while (position < input.length && input[position] != '>') {
        children.add(parseType(level + 1));
        if (position < input.length && input[position] == ',') {
          position++;
        }
      }

      if (position < input.length && input[position] == '>') {
        position++;
      }

      return TypeNode(name, children: children, level: level);
    }

    return TypeNode(name, level: level);
  }

  ///
  String parseName() {
    StringBuffer name = StringBuffer();
    while (position < input.length) {
      String char = input[position];
      if (char == '<' || char == ',' || char == '>') {
        break;
      }
      name.write(char);
      position++;
    }
    return name.toString();
  }
}

///
final parser = TypeParser();

void main() {
  final r = parser.parse('List<List<Map<String, int>>>?');
  print(r.generateDeserializeCode('h', nullable: false));

  /// output:
  /// (json['h'] as List<dynamic>).map((x0) => (x0 as List<dynamic>).map((x1) => (x1 as Map<String, int>).map((k2, v2) => MapEntry(k2, v2))).toList()).toList()
  /// 正确
}
