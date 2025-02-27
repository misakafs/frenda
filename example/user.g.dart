// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

class User implements Serializable {
  final String name;

  /// 覆盖默认构造器
  User({required this.name});

  /// 自定义方法，覆盖生成的toJson方法
  @override
  Map<String, dynamic> toJson() => {'n': name};

  /// 覆盖生成的fromJson
  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['n']);
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
