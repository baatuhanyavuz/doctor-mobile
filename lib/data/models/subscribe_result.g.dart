// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscribeResultImpl _$$SubscribeResultImplFromJson(
  Map<String, dynamic> json,
) => _$SubscribeResultImpl(
  subscriptionId: (json['subscriptionId'] as num?)?.toInt() ?? 0,
  planName: json['planName'] as String? ?? '',
  period: json['period'] as String? ?? '',
  creditsGranted: (json['creditsGranted'] as num?)?.toInt() ?? 0,
  bonusCredits: (json['bonusCredits'] as num?)?.toInt() ?? 0,
  newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
  expiresAt: json['expiresAt'] as String?,
  promoCodeApplied: json['promoCodeApplied'] as String?,
);

Map<String, dynamic> _$$SubscribeResultImplToJson(
  _$SubscribeResultImpl instance,
) => <String, dynamic>{
  'subscriptionId': instance.subscriptionId,
  'planName': instance.planName,
  'period': instance.period,
  'creditsGranted': instance.creditsGranted,
  'bonusCredits': instance.bonusCredits,
  'newBalance': instance.newBalance,
  'expiresAt': instance.expiresAt,
  'promoCodeApplied': instance.promoCodeApplied,
};
