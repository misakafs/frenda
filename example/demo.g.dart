// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

class Demo implements Serializable {
  final String? a;

  final String a1;

  String? b;

  String b1;

  static String c = 'c';

  static const String c1 = 'c1';

  static final String c2 = 'c2';

  final String _e = '';

  final List<String> g;

  List<String>? g1;

  List<List<int>>? g2;

  List<List<Map<String, int>>>? g3;

  Map<String, List<int>> h;

  List<Map<int, double>>? h1;

  String get d => 'd';

  Demo({
    this.a,
    this.a1 = 'a1',
    this.b,
    this.b1 = 'b1',
    required this.g,
    this.g1,
    this.g2,
    this.g3,
    required this.h,
    this.h1,
  });

  @override
  Map<String, dynamic> toJson() => {
    'a': a,
    'a1': a1,
    'b': b,
    'b1': b1,
    'g': g.map((x0) => x0).toList(),
    'g1': g1?.map((x0) => x0).toList() ?? [],
    'g2': g2?.map((x0) => x0.map((x1) => x1).toList()).toList() ?? [],
    'g3':
        g3
            ?.map(
              (x0) =>
                  x0.map((x1) => x1.map((k2, v2) => MapEntry(k2, v2))).toList(),
            )
            .toList() ??
        [],
    'h': h.map((k0, v0) => MapEntry(k0, v0.map((x1) => x1).toList())),
    'h1':
        h1
            ?.map((x0) => x0.map((k1, v1) => MapEntry(k1.toString(), v1)))
            .toList() ??
        [],
  };

  factory Demo.fromJson(Map<String, dynamic> json) => Demo(
    a: json['a'],
    a1: json['a1'],
    b: json['b'],
    b1: json['b1'],
    g: (json['g'] as List<dynamic>).map((x0) => x0 as String).toList(),
    g1: (json['g1'] as List<dynamic>?)?.map((x0) => x0 as String).toList(),
    g2:
        (json['g2'] as List<dynamic>?)
            ?.map((x0) => (x0 as List<dynamic>).map((x1) => x1 as int).toList())
            .toList(),
    g3:
        (json['g3'] as List<dynamic>?)
            ?.map(
              (x0) =>
                  (x0 as List<dynamic>)
                      .map(
                        (x1) => (x1 as Map<String, int>).map(
                          (k2, v2) => MapEntry(k2, v2),
                        ),
                      )
                      .toList(),
            )
            .toList(),
    h: (json['h'] as Map<String, dynamic>).map(
      (k0, v0) =>
          MapEntry(k0, (v0 as List<dynamic>).map((x1) => x1 as int).toList()),
    ),
    h1:
        (json['h1'] as List<dynamic>?)
            ?.map(
              (x0) => (x0 as Map<String, double>).map(
                (k1, v1) => MapEntry(int.parse(k1), v1),
              ),
            )
            .toList(),
  );

  Demo copyWith({
    String? a,
    String? a1,
    String? b,
    String? b1,
    List<String>? g,
    List<String>? g1,
    List<List<int>>? g2,
    List<List<Map<String, int>>>? g3,
    Map<String, List<int>>? h,
    List<Map<int, double>>? h1,
  }) => Demo(
    a: a ?? this.a,
    a1: a1 ?? this.a1,
    b: b ?? this.b,
    b1: b1 ?? this.b1,
    g: g ?? this.g,
    g1: g1 ?? this.g1,
    g2: g2 ?? this.g2,
    g3: g3 ?? this.g3,
    h: h ?? this.h,
    h1: h1 ?? this.h1,
  );

  @override
  String toString() =>
      'Demo(a: $a, a1: $a1, b: $b, b1: $b1, g: $g, g1: $g1, g2: $g2, g3: $g3, h: $h, h1: $h1)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Demo &&
          runtimeType == other.runtimeType &&
          other.a == a &&
          other.a1 == a1 &&
          other.b == b &&
          other.b1 == b1 &&
          other.g == g &&
          other.g1 == g1 &&
          other.g2 == g2 &&
          other.g3 == g3 &&
          other.h == h &&
          other.h1 == h1);

  @override
  int get hashCode => Object.hash(a, a1, b, b1, g, g1, g2, g3, h, h1);
}
