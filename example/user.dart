import 'package:frenda/frenda.dart';

part 'user.g.dart';

@frenda
class $User {
  late final String name;

  /// 覆盖默认构造器
  $User({required this.name});

  /// 自定义方法，覆盖生成的toJson方法
  Map<String, dynamic> toJson() => {'n': name};

  /// 覆盖生成的fromJson
  factory $User.fromJson(Map<String, dynamic> json) {
    return $User(name: json['n']);
  }
}
