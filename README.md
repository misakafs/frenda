# Frenda

[![pub package](https://img.shields.io/pub/v/frenda.svg)](https://pub.dev/packages/frenda)

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

- `@frenda` | `@Frenda()` 用于标注类
- `@filed` | `@Filed('json序列化的name')` 用于标注字段

## 使用

- [simple.dart](https://github.com/misakafs/frenda/blob/main/example/simple.dart)

```dart
import 'package:frenda/frenda.dart';

/// 必须写part
part 'simple.g.dart';

/// 注解进行标识，类名必须以 $ 开头，如果想要其他开头，需要修改配置
@frenda
class $Simple {
  /// 定义字段
  late String firstField;
  late final int secondField;

  /// 自定义序列化后的字段名
  @Filed('third_field')
  late bool? thirdField;
}
```

- 然后运行生成命令，最终的结果如下:

```dart
// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

class Simple implements Serializable {
  String firstField;
  final int secondField;
  bool? thirdField;

  Simple({
    required this.firstField,
    required this.secondField,
    this.thirdField,
  });

  @override
  Map<String, dynamic> toJson() => {
    'firstField': firstField,
    'secondField': secondField,
    'third_field': thirdField,
  };

  factory Simple.fromJson(Map<String, dynamic> json) => Simple(
    firstField: json['firstField'] as String,
    secondField: json['secondField'] as int,
    thirdField: json['third_field'] as bool?,
  );

  Simple copyWith({String? firstField, int? secondField, bool? thirdField}) =>
      Simple(
        firstField: firstField ?? this.firstField,
        secondField: secondField ?? this.secondField,
        thirdField: thirdField ?? this.thirdField,
      );

  @override
  String toString() =>
      'Simple(firstField: $firstField, secondField: $secondField, third_field: $thirdField)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Simple &&
          runtimeType == other.runtimeType &&
          other.firstField == firstField &&
          other.secondField == secondField &&
          other.thirdField == thirdField);

  @override
  int get hashCode => Object.hash(firstField, secondField, thirdField);
}
```

## 更多例子

[simple](https://github.com/misakafs/frenda/tree/main/example)



