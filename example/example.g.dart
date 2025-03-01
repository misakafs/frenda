// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

/// 测试例子
class Example implements Serializable {
  int field1;

  /// 自定义序列化后的字段名
  String field2;

  /// 设置默认值
  bool field3;

  /// 设置不可变
  final double field4;

  List<int> field5;

  List<String> field6;

  List<bool>? field7;

  List<double> field8;

  Map<String, dynamic> field9;

  Map<String, int> field10;

  Map<String, String> field11;

  Map<String, bool> field12;

  Map<String, double> field13;

  Map<int, dynamic> field14;

  List<User>? users1;

  Map<String, User> users2;

  Set<User> users3;

  /// 嵌入其他的类型
  User user1;

  User? user2;

  static const name = 'example';

  Example({
    required this.field1,
    required this.field2,
    this.field3 = true,
    required this.field4,
    required this.field5,
    this.field6 = const ['one', 'two'],
    this.field7,
    required this.field8,
    required this.field9,
    required this.field10,
    required this.field11,
    required this.field12,
    this.field13 = const {"three": 3.0},
    required this.field14,
    this.users1,
    required this.users2,
    required this.users3,
    required this.user1,
    this.user2,
  });

  /// 自定义方法
  String getString() {
    return "example";
  }

  @override
  Map<String, dynamic> toJson() => {
    'field1': field1,
    'field_2': field2,
    'field3': field3,
    'field4': field4,
    'field5': field5.map((x0) => x0).toList(),
    'field6': field6.map((x0) => x0).toList(),
    'field7': field7?.map((x0) => x0).toList() ?? [],
    'field8': field8.map((x0) => x0).toList(),
    'field9': field9.map((k0, v0) => MapEntry(k0, v0)),
    'field10': field10.map((k0, v0) => MapEntry(k0, v0)),
    'field11': field11.map((k0, v0) => MapEntry(k0, v0)),
    'field12': field12.map((k0, v0) => MapEntry(k0, v0)),
    'field13': field13.map((k0, v0) => MapEntry(k0, v0)),
    'field14': field14.map((k0, v0) => MapEntry(k0.toString(), v0)),
    'users1': users1?.map((x0) => x0.toJson()).toList() ?? [],
    'users2': users2.map((k0, v0) => MapEntry(k0, v0.toJson())),
    'users3': users3,
    'user1': user1.toJson(),
    'user2': user2?.toJson(),
  };

  factory Example.fromJson(Map<String, dynamic> json) => Example(
    field1: json['field1'],
    field2: json['field_2'],
    field3: json['field3'],
    field4: json['field4'],
    field5: (json['field5'] as List<dynamic>).map((x0) => x0 as int).toList(),
    field6:
        (json['field6'] as List<dynamic>).map((x0) => x0 as String).toList(),
    field7:
        (json['field7'] as List<dynamic>?)?.map((x0) => x0 as bool).toList(),
    field8:
        (json['field8'] as List<dynamic>).map((x0) => x0 as double).toList(),
    field9: (json['field9'] as Map<String, dynamic>).map(
      (k0, v0) => MapEntry(k0, v0),
    ),
    field10: (json['field10'] as Map<String, int>).map(
      (k0, v0) => MapEntry(k0, v0),
    ),
    field11: (json['field11'] as Map<String, String>).map(
      (k0, v0) => MapEntry(k0, v0),
    ),
    field12: (json['field12'] as Map<String, bool>).map(
      (k0, v0) => MapEntry(k0, v0),
    ),
    field13: (json['field13'] as Map<String, double>).map(
      (k0, v0) => MapEntry(k0, v0),
    ),
    field14: (json['field14'] as Map<String, dynamic>).map(
      (k0, v0) => MapEntry(int.parse(k0), v0),
    ),
    users1:
        (json['users1'] as List<dynamic>?)
            ?.map((x0) => User.fromJson(x0))
            .toList(),
    users2: (json['users2'] as Map<String, dynamic>).map(
      (k0, v0) => MapEntry(k0, User.fromJson(v0)),
    ),
    users3: json['users3'],
    user1: User.fromJson(json['user1']),
    user2: User?.fromJson(json['user2'] ?? {}),
  );

  Example copyWith({
    int? field1,
    String? field2,
    bool? field3,
    double? field4,
    List<int>? field5,
    List<String>? field6,
    List<bool>? field7,
    List<double>? field8,
    Map<String, dynamic>? field9,
    Map<String, int>? field10,
    Map<String, String>? field11,
    Map<String, bool>? field12,
    Map<String, double>? field13,
    Map<int, dynamic>? field14,
    List<User>? users1,
    Map<String, User>? users2,
    Set<User>? users3,
    User? user1,
    User? user2,
  }) => Example(
    field1: field1 ?? this.field1,
    field2: field2 ?? this.field2,
    field3: field3 ?? this.field3,
    field4: field4 ?? this.field4,
    field5: field5 ?? this.field5,
    field6: field6 ?? this.field6,
    field7: field7 ?? this.field7,
    field8: field8 ?? this.field8,
    field9: field9 ?? this.field9,
    field10: field10 ?? this.field10,
    field11: field11 ?? this.field11,
    field12: field12 ?? this.field12,
    field13: field13 ?? this.field13,
    field14: field14 ?? this.field14,
    users1: users1 ?? this.users1,
    users2: users2 ?? this.users2,
    users3: users3 ?? this.users3,
    user1: user1 ?? this.user1,
    user2: user2 ?? this.user2,
  );

  @override
  String toString() =>
      'Example(field1: $field1, field2: $field2, field3: $field3, field4: $field4, field5: $field5, field6: $field6, field7: $field7, field8: $field8, field9: $field9, field10: $field10, field11: $field11, field12: $field12, field13: $field13, field14: $field14, users1: $users1, users2: $users2, users3: $users3, user1: $user1, user2: $user2)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Example &&
          runtimeType == other.runtimeType &&
          other.field1 == field1 &&
          other.field2 == field2 &&
          other.field3 == field3 &&
          other.field4 == field4 &&
          other.field5 == field5 &&
          other.field6 == field6 &&
          other.field7 == field7 &&
          other.field8 == field8 &&
          other.field9 == field9 &&
          other.field10 == field10 &&
          other.field11 == field11 &&
          other.field12 == field12 &&
          other.field13 == field13 &&
          other.field14 == field14 &&
          other.users1 == users1 &&
          other.users2 == users2 &&
          other.users3 == users3 &&
          other.user1 == user1 &&
          other.user2 == user2);

  @override
  int get hashCode => Object.hash(
    field1,
    field2,
    field3,
    field4,
    field5,
    field6,
    field7,
    field8,
    field9,
    field10,
    field11,
    field12,
    field13,
    field14,
    users1,
    users2,
    users3,
    user1,
    user2,
  );
}
