import 'package:frenda/frenda.dart';

part 'simple.g.dart';

@frenda
class $Simple {
  late String firstField;
  late final int secondField;

  @Filed('third_field')
  late bool? thirdField;
}
