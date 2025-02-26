// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple.dart';

// **************************************************************************
// FrendaGenerator
// **************************************************************************

class Simple implements Serializable {
  String firstField;
  final int secondField;
  bool? thirdField;

  Simple({
    required this.firstField,
    required this.secondField,
    this.thirdField,
  });

  @override
  Map<String, dynamic> toJson() => {
    'firstField': firstField,
    'secondField': secondField,
    'third_field': thirdField,
  };

  factory Simple.fromJson(Map<String, dynamic> json) => Simple(
    firstField: json['firstField'] as String,
    secondField: json['secondField'] as int,
    thirdField: json['third_field'] as bool?,
  );

  Simple copyWith({String? firstField, int? secondField, bool? thirdField}) =>
      Simple(
        firstField: firstField ?? this.firstField,
        secondField: secondField ?? this.secondField,
        thirdField: thirdField ?? this.thirdField,
      );

  @override
  String toString() =>
      'Simple(firstField: $firstField, secondField: $secondField, third_field: $thirdField)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Simple &&
          runtimeType == other.runtimeType &&
          other.firstField == firstField &&
          other.secondField == secondField &&
          other.thirdField == thirdField);

  @override
  int get hashCode => Object.hash(firstField, secondField, thirdField);
}
