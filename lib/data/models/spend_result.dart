import 'package:freezed_annotation/freezed_annotation.dart';

part 'spend_result.freezed.dart';
part 'spend_result.g.dart';

@freezed
class SpendResult with _$SpendResult {
  const factory SpendResult({
    @Default(false) bool success,
    @Default(0) int creditsSpent,
    @Default(0) int newBalance,
    @Default(0) int transactionId,
  }) = _SpendResult;

  factory SpendResult.fromJson(Map<String, dynamic> json) =>
      _$SpendResultFromJson(json);
}
