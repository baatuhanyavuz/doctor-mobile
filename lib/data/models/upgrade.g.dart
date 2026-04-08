// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upgrade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpgradeImpl _$$UpgradeImplFromJson(Map<String, dynamic> json) =>
    _$UpgradeImpl(
      type: $enumDecode(_$UpgradeTypeEnumMap, json['type']),
      level: (json['level'] as num?)?.toInt() ?? 0,
      maxLevel: (json['maxLevel'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$UpgradeImplToJson(_$UpgradeImpl instance) =>
    <String, dynamic>{
      'type': _$UpgradeTypeEnumMap[instance.type]!,
      'level': instance.level,
      'maxLevel': instance.maxLevel,
    };

const _$UpgradeTypeEnumMap = {
  UpgradeType.goldenStethoscope: 'goldenStethoscope',
  UpgradeType.fastDevice: 'fastDevice',
  UpgradeType.aiMRI: 'aiMRI',
  UpgradeType.advancedLab: 'advancedLab',
  UpgradeType.comfortKit: 'comfortKit',
};
