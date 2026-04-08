import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_watch_result.freezed.dart';
part 'ad_watch_result.g.dart';

@freezed
class AdWatchResult with _$AdWatchResult {
  const factory AdWatchResult({
    @Default(0) int creditsEarned,
    @Default(0) int adsWatchedToday,
    @Default(10) int maxAdsPerDay,
    @Default(0) int newBalance,
  }) = _AdWatchResult;

  factory AdWatchResult.fromJson(Map<String, dynamic> json) =>
      _$AdWatchResultFromJson(json);
}
