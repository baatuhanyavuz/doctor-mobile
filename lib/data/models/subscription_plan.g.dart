// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionPlanImpl _$$SubscriptionPlanImplFromJson(
  Map<String, dynamic> json,
) => _$SubscriptionPlanImpl(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  description: json['description'] as String?,
  priceTl: (json['priceTl'] as num?)?.toDouble() ?? 0,
  creditsPerPeriod: (json['creditsPerPeriod'] as num?)?.toInt() ?? 0,
  period: json['period'] as String? ?? 'monthly',
  bonusCredits: (json['bonusCredits'] as num?)?.toInt() ?? 0,
  isAdFree: json['isAdFree'] as bool? ?? false,
  hasBadge: json['hasBadge'] as bool? ?? false,
  hasPriorityAccess: json['hasPriorityAccess'] as bool? ?? false,
  isActive: json['isActive'] as bool? ?? true,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SubscriptionPlanImplToJson(
  _$SubscriptionPlanImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'priceTl': instance.priceTl,
  'creditsPerPeriod': instance.creditsPerPeriod,
  'period': instance.period,
  'bonusCredits': instance.bonusCredits,
  'isAdFree': instance.isAdFree,
  'hasBadge': instance.hasBadge,
  'hasPriorityAccess': instance.hasPriorityAccess,
  'isActive': instance.isActive,
  'sortOrder': instance.sortOrder,
};
