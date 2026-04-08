// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActiveSubscriptionImpl _$$ActiveSubscriptionImplFromJson(
  Map<String, dynamic> json,
) => _$ActiveSubscriptionImpl(
  id: (json['id'] as num?)?.toInt() ?? 0,
  userId: json['userId'] as String? ?? '',
  planId: (json['planId'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? 'active',
  startedAt: json['startedAt'] as String?,
  expiresAt: json['expiresAt'] as String?,
  cancelledAt: json['cancelledAt'] as String?,
  planName: json['planName'] as String?,
  period: json['period'] as String?,
  isAdFree: json['isAdFree'] as bool? ?? false,
  hasBadge: json['hasBadge'] as bool? ?? false,
  hasPriorityAccess: json['hasPriorityAccess'] as bool? ?? false,
);

Map<String, dynamic> _$$ActiveSubscriptionImplToJson(
  _$ActiveSubscriptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'planId': instance.planId,
  'status': instance.status,
  'startedAt': instance.startedAt,
  'expiresAt': instance.expiresAt,
  'cancelledAt': instance.cancelledAt,
  'planName': instance.planName,
  'period': instance.period,
  'isAdFree': instance.isAdFree,
  'hasBadge': instance.hasBadge,
  'hasPriorityAccess': instance.hasPriorityAccess,
};
