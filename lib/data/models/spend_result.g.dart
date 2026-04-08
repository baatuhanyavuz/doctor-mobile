// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spend_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpendResultImpl _$$SpendResultImplFromJson(Map<String, dynamic> json) =>
    _$SpendResultImpl(
      success: json['success'] as bool? ?? false,
      creditsSpent: (json['creditsSpent'] as num?)?.toInt() ?? 0,
      newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
      transactionId: (json['transactionId'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SpendResultImplToJson(_$SpendResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'creditsSpent': instance.creditsSpent,
      'newBalance': instance.newBalance,
      'transactionId': instance.transactionId,
    };
