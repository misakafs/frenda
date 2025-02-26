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

- [example.dart](example/example.dart)

定义字段

```dart
import 'package:frenda/frenda.dart';

import 'user.dart';

part 'example.g.dart';

/// 测试例子
@frenda
class $Example {
  late int field1;

  /// 自定义序列化后的字段名
  @Filed('field_2')
  late String field2;

  /// 设置默认值
  bool field3 = true;

  /// 设置不可变
  late final double field4;

  late List<int> field5;

  List<String> field6 = ['one', 'two'];

  late List<bool>? field7;

  late List<double> field8;

  late Map<String, dynamic> field9;

  late Map<String, int> field10;

  late Map<String, String> field11;

  late Map<String, bool> field12;

  Map<String, double> field13 = const {"three": 3.0};

  late Map<int, dynamic> field14;

  /// 嵌入其他的类型
  late $User user1;

  late $User? user2;

  /// 自定义方法
  String getString() {
    return "example";
  }
}
```

- 生成后的 [example.g.dart](example/example.g.dart)



