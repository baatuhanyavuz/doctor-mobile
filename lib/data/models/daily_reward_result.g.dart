// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reward_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRewardResultImpl _$$DailyRewardResultImplFromJson(
  Map<String, dynamic> json,
) => _$DailyRewardResultImpl(
  creditsEarned: (json['creditsEarned'] as num?)?.toInt() ?? 0,
  streakDay: (json['streakDay'] as num?)?.toInt() ?? 1,
  totalStreakDays: (json['totalStreakDays'] as num?)?.toInt() ?? 0,
  newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
  isStreakBonusDay: json['isStreakBonusDay'] as bool? ?? false,
  monthlyBonusEarned: json['monthlyBonusEarned'] as bool? ?? false,
);

Map<String, dynamic> _$$DailyRewardResultImplToJson(
  _$DailyRewardResultImpl instance,
) => <String, dynamic>{
  'creditsEarned': instance.creditsEarned,
  'streakDay': instance.streakDay,
  'totalStreakDays': instance.totalStreakDays,
  'newBalance': instance.newBalance,
  'isStreakBonusDay': instance.isStreakBonusDay,
  'monthlyBonusEarned': instance.monthlyBonusEarned,
};
