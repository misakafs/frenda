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

  late List<$User>? users1;

  late Map<String, $User> users2;

  late Set<$User> users3;

  /// 嵌入其他的类型
  late $User user1;

  late $User? user2;

  static const name = 'example';

  /// 自定义方法
  String getString() {
    return "example";
  }
}
