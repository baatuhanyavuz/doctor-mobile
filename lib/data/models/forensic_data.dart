import 'package:freezed_annotation/freezed_annotation.dart';

part 'forensic_data.freezed.dart';
part 'forensic_data.g.dart';

@freezed
class Reagent with _$Reagent {
  const factory Reagent({
    @Default('') String id,
    @Default('') String name,
    @Default('') String color, // Hex code
    @Default(false) bool isCorrect,
  }) = _Reagent;

  factory Reagent.fromJson(Map<String, dynamic> json) => _$ReagentFromJson(json);
}

@freezed
class ForensicData with _$ForensicData {
  const factory ForensicData({
    @Default('') String initialImageUrl,
    @Default('') String resultImageUrl,
    @Default('') String resultText,
    @Default([]) List<Reagent> reagents,
  }) = _ForensicData;

  factory ForensicData.fromJson(Map<String, dynamic> json) => _$ForensicDataFromJson(json);
}
