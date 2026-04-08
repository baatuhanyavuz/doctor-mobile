// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseResultImpl _$$PurchaseResultImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseResultImpl(
      baseCredits: (json['baseCredits'] as num?)?.toInt() ?? 0,
      bonusCredits: (json['bonusCredits'] as num?)?.toInt() ?? 0,
      promoCredits: (json['promoCredits'] as num?)?.toInt() ?? 0,
      totalCreditsGranted: (json['totalCreditsGranted'] as num?)?.toInt() ?? 0,
      newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
      transactionId: (json['transactionId'] as num?)?.toInt() ?? 0,
      promoCodeApplied: json['promoCodeApplied'] as String?,
    );

Map<String, dynamic> _$$PurchaseResultImplToJson(
  _$PurchaseResultImpl instance,
) => <String, dynamic>{
  'baseCredits': instance.baseCredits,
  'bonusCredits': instance.bonusCredits,
  'promoCredits': instance.promoCredits,
  'totalCreditsGranted': instance.totalCreditsGranted,
  'newBalance': instance.newBalance,
  'transactionId': instance.transactionId,
  'promoCodeApplied': instance.promoCodeApplied,
};
