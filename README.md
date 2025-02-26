# Frenda

**Frenda** 是一个旨在提升开发效率的工具，它能够自动生成包含 `toJson`、`fromJson`、`copyWith`、`toString`、`operator ==` 以及 `hashCode` 方法的 Dart 类。

## 安装

```shell
flutter pub add frenda
```

## 运行

```shell
dart run build_runner build --delete-conflicting-outputs
```

## 配置

- 在自己的根项目下创建一个 `build.yaml` 文件，全部配置如下:

```yaml
targets:
  $default:
    builders:
      frenda:    
        options:
          # 用于标识类的前缀
          prefix: "$"
```

## 注解

- `@frenda` | `@Frenda()`

用于标注类

- `@filed` | `@Filed('json序列化的name')`

用于标注字段

## 示例

- [user.dart](example/user.dart)

定义字段

```dart
import 'package:frenda/frenda.dart';

part 'user.g.dart';

@frenda
class $User {
  late final String name;

  $User({required this.name});

  Map<String, dynamic> toJson() => {'name': name};

  factory $User.fromJson(Map<String, dynamic> json) {
    return $User(name: json['name']);
  }
}
```

- 生成后的 [user.g.dart](example/user.g.dart)

```dart
// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

class User implements Serializable {
  final String name;

  User({required this.name});

  @override
  Map<String, dynamic> toJson() => {'name': name};

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name']);
  }

  User copyWith({String? name}) => User(name: name ?? this.name);

  @override
  String toString() => 'User(name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User && runtimeType == other.runtimeType && other.name == name);

  @override
  int get hashCode => name.hashCode;
}
```

- 使用

```dart
import 'user.dart';

void main() {
  final user = User(name: 'test');

  print(user.toJson());
  print(user.hashCode);
}
```

