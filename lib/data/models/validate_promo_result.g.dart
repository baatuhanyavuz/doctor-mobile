// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_promo_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidatePromoResultImpl _$$ValidatePromoResultImplFromJson(
  Map<String, dynamic> json,
) => _$ValidatePromoResultImpl(
  valid: json['valid'] as bool? ?? false,
  discountType: json['discountType'] as String?,
  discountValue: (json['discountValue'] as num?)?.toDouble(),
  originalCredits: (json['originalCredits'] as num?)?.toInt(),
  bonusCredits: (json['bonusCredits'] as num?)?.toInt(),
  finalCredits: (json['finalCredits'] as num?)?.toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$$ValidatePromoResultImplToJson(
  _$ValidatePromoResultImpl instance,
) => <String, dynamic>{
  'valid': instance.valid,
  'discountType': instance.discountType,
  'discountValue': instance.discountValue,
  'originalCredits': instance.originalCredits,
  'bonusCredits': instance.bonusCredits,
  'finalCredits': instance.finalCredits,
  'message': instance.message,
};
