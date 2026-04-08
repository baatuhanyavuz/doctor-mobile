import 'package:freezed_annotation/freezed_annotation.dart';

part 'mystery_box_result.freezed.dart';
part 'mystery_box_result.g.dart';

@freezed
class MysteryBoxResult with _$MysteryBoxResult {
  const factory MysteryBoxResult({
    @Default(0) int creditsEarned,
    @Default(0) int newBalance,
    @Default('common') String rarity,
  }) = _MysteryBoxResult;

  factory MysteryBoxResult.fromJson(Map<String, dynamic> json) =>
      _$MysteryBoxResultFromJson(json);
}
