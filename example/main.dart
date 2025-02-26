import 'simple.dart';

void main() {
  final simple = Simple(firstField: 'first');
  print(simple.toString());

  /// output:
  /// Simple(firstField: first, secondField: 10, third_field: null)
}
