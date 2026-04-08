import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan.freezed.dart';
part 'subscription_plan.g.dart';

@freezed
class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    @Default(0) int id,
    @Default('') String name,
    String? description,
    @Default(0) double priceTl,
    @Default(0) int creditsPerPeriod,
    @Default('monthly') String period,
    @Default(0) int bonusCredits,
    @Default(false) bool isAdFree,
    @Default(false) bool hasBadge,
    @Default(false) bool hasPriorityAccess,
    @Default(true) bool isActive,
    @Default(0) int sortOrder,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}
