import 'package:frenda/frenda.dart';

part 'demo.g.dart';

@frenda
class $Demo {
  late final String? a;
  late final String a1 = 'a1';
  late String? b;
  late String b1 = 'b1';

  static String c = 'c';
  static const String c1 = 'c1';
  static final String c2 = 'c2';

  String get d => 'd';

  final String _e = '';

  late final List<String> g;
  late List<String>? g1;
  late List<List<int>>? g2;
  late List<List<Map<String, int>>>? g3;
  late Map<String, List<int>> h;
  late List<Map<int, double>>? h1;
}
