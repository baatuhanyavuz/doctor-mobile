import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_reward_result.freezed.dart';
part 'daily_reward_result.g.dart';

@freezed
class DailyRewardResult with _$DailyRewardResult {
  const factory DailyRewardResult({
    @Default(0) int creditsEarned,
    @Default(1) int streakDay,
    @Default(0) int totalStreakDays,
    @Default(0) int newBalance,
    @Default(false) bool isStreakBonusDay,
    @Default(false) bool monthlyBonusEarned,
  }) = _DailyRewardResult;

  factory DailyRewardResult.fromJson(Map<String, dynamic> json) =>
      _$DailyRewardResultFromJson(json);
}
