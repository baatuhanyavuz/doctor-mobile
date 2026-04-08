import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_promo_result.freezed.dart';
part 'validate_promo_result.g.dart';

@freezed
class ValidatePromoResult with _$ValidatePromoResult {
  const factory ValidatePromoResult({
    @Default(false) bool valid,
    String? discountType,
    double? discountValue,
    int? originalCredits,
    int? bonusCredits,
    int? finalCredits,
    String? message,
  }) = _ValidatePromoResult;

  factory ValidatePromoResult.fromJson(Map<String, dynamic> json) =>
      _$ValidatePromoResultFromJson(json);
}
