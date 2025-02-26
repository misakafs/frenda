import 'package:frenda/frenda.dart';

/// 必须写part
part 'simple.g.dart';

/// 注解进行标识，类名必须以 $ 开头，如果想要其他开头，需要修改配置
@frenda
class $Simple {
  /// 定义字段
  late String firstField;

  /// 设置默认值
  late final int secondField = 10;

  /// 自定义序列化后的字段名
  @Filed('third_field')
  late bool? thirdField;
}
