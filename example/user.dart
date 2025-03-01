import 'package:frenda/frenda.dart';

part 'user.g.dart';

@frenda
class $User {
  late final String name;

  /// 自定义方法，覆盖生成的toJson方法
  Map<String, dynamic> toJson() => {'n': name};
}
