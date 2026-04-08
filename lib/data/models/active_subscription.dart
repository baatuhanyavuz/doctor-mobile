import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_subscription.freezed.dart';
part 'active_subscription.g.dart';

@freezed
class ActiveSubscription with _$ActiveSubscription {
  const factory ActiveSubscription({
    @Default(0) int id,
    @Default('') String userId,
    @Default(0) int planId,
    @Default('active') String status,
    String? startedAt,
    String? expiresAt,
    String? cancelledAt,
    String? planName,
    String? period,
    @Default(false) bool isAdFree,
    @Default(false) bool hasBadge,
    @Default(false) bool hasPriorityAccess,
  }) = _ActiveSubscription;

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) =>
      _$ActiveSubscriptionFromJson(json);
}
