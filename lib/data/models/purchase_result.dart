import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_result.freezed.dart';
part 'purchase_result.g.dart';

@freezed
class PurchaseResult with _$PurchaseResult {
  const factory PurchaseResult({
    @Default(0) int baseCredits,
    @Default(0) int bonusCredits,
    @Default(0) int promoCredits,
    @Default(0) int totalCreditsGranted,
    @Default(0) int newBalance,
    @Default(0) int transactionId,
    String? promoCodeApplied,
  }) = _PurchaseResult;

  factory PurchaseResult.fromJson(Map<String, dynamic> json) =>
      _$PurchaseResultFromJson(json);
}
