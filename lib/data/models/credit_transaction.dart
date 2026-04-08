import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_transaction.freezed.dart';
part 'credit_transaction.g.dart';

@freezed
class CreditTransaction with _$CreditTransaction {
  const factory CreditTransaction({
    @Default(0) int id,
    @Default('') String userId,
    @Default(0) int amount,
    @Default(0) int balanceAfter,
    @Default('') String transactionType,
    String? source,
    String? referenceId,
    String? description,
    String? createdAt,
  }) = _CreditTransaction;

  factory CreditTransaction.fromJson(Map<String, dynamic> json) =>
      _$CreditTransactionFromJson(json);
}
