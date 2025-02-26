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
