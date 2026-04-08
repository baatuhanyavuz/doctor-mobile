import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_balance.freezed.dart';
part 'credit_balance.g.dart';

@freezed
class CreditBalance with _$CreditBalance {
  const factory CreditBalance({
    @Default(0) int balance,
    @Default(0) int totalEarned,
    @Default(0) int totalSpent,
    @Default(false) bool hasActiveSubscription,
    String? subscriptionPlanName,
  }) = _CreditBalance;

  factory CreditBalance.fromJson(Map<String, dynamic> json) =>
      _$CreditBalanceFromJson(json);
}
