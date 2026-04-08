// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_watch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdWatchResultImpl _$$AdWatchResultImplFromJson(Map<String, dynamic> json) =>
    _$AdWatchResultImpl(
      creditsEarned: (json['creditsEarned'] as num?)?.toInt() ?? 0,
      adsWatchedToday: (json['adsWatchedToday'] as num?)?.toInt() ?? 0,
      maxAdsPerDay: (json['maxAdsPerDay'] as num?)?.toInt() ?? 10,
      newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdWatchResultImplToJson(_$AdWatchResultImpl instance) =>
    <String, dynamic>{
      'creditsEarned': instance.creditsEarned,
      'adsWatchedToday': instance.adsWatchedToday,
      'maxAdsPerDay': instance.maxAdsPerDay,
      'newBalance': instance.newBalance,
    };
