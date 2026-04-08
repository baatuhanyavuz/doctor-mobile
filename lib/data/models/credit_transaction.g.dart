// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditTransactionImpl _$$CreditTransactionImplFromJson(
  Map<String, dynamic> json,
) => _$CreditTransactionImpl(
  id: (json['id'] as num?)?.toInt() ?? 0,
  userId: json['userId'] as String? ?? '',
  amount: (json['amount'] as num?)?.toInt() ?? 0,
  balanceAfter: (json['balanceAfter'] as num?)?.toInt() ?? 0,
  transactionType: json['transactionType'] as String? ?? '',
  source: json['source'] as String?,
  referenceId: json['referenceId'] as String?,
  description: json['description'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$CreditTransactionImplToJson(
  _$CreditTransactionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'amount': instance.amount,
  'balanceAfter': instance.balanceAfter,
  'transactionType': instance.transactionType,
  'source': instance.source,
  'referenceId': instance.referenceId,
  'description': instance.description,
  'createdAt': instance.createdAt,
};
