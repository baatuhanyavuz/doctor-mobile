// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditBalanceImpl _$$CreditBalanceImplFromJson(Map<String, dynamic> json) =>
    _$CreditBalanceImpl(
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      totalEarned: (json['totalEarned'] as num?)?.toInt() ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toInt() ?? 0,
      hasActiveSubscription: json['hasActiveSubscription'] as bool? ?? false,
      subscriptionPlanName: json['subscriptionPlanName'] as String?,
    );

Map<String, dynamic> _$$CreditBalanceImplToJson(_$CreditBalanceImpl instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'totalEarned': instance.totalEarned,
      'totalSpent': instance.totalSpent,
      'hasActiveSubscription': instance.hasActiveSubscription,
      'subscriptionPlanName': instance.subscriptionPlanName,
    };
