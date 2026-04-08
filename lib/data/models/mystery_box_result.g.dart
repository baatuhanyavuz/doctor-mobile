// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mystery_box_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MysteryBoxResultImpl _$$MysteryBoxResultImplFromJson(
  Map<String, dynamic> json,
) => _$MysteryBoxResultImpl(
  creditsEarned: (json['creditsEarned'] as num?)?.toInt() ?? 0,
  newBalance: (json['newBalance'] as num?)?.toInt() ?? 0,
  rarity: json['rarity'] as String? ?? 'common',
);

Map<String, dynamic> _$$MysteryBoxResultImplToJson(
  _$MysteryBoxResultImpl instance,
) => <String, dynamic>{
  'creditsEarned': instance.creditsEarned,
  'newBalance': instance.newBalance,
  'rarity': instance.rarity,
};
