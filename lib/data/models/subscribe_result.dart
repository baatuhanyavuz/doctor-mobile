import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscribe_result.freezed.dart';
part 'subscribe_result.g.dart';

@freezed
class SubscribeResult with _$SubscribeResult {
  const factory SubscribeResult({
    @Default(0) int subscriptionId,
    @Default('') String planName,
    @Default('') String period,
    @Default(0) int creditsGranted,
    @Default(0) int bonusCredits,
    @Default(0) int newBalance,
    String? expiresAt,
    String? promoCodeApplied,
  }) = _SubscribeResult;

  factory SubscribeResult.fromJson(Map<String, dynamic> json) =>
      _$SubscribeResultFromJson(json);
}
