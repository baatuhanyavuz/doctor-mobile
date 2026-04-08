// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protective_gear.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InfectionRiskImpl _$$InfectionRiskImplFromJson(Map<String, dynamic> json) =>
    _$InfectionRiskImpl(
      level:
          $enumDecodeNullable(_$InfectionRiskLevelEnumMap, json['level']) ??
          InfectionRiskLevel.none,
      description: json['description'] as String? ?? '',
      requiredGear:
          (json['requiredGear'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$GearTypeEnumMap, e))
              .toList() ??
          const [],
      penaltyDescription: json['penaltyDescription'] as String? ?? '',
    );

Map<String, dynamic> _$$InfectionRiskImplToJson(_$InfectionRiskImpl instance) =>
    <String, dynamic>{
      'level': _$InfectionRiskLevelEnumMap[instance.level]!,
      'description': instance.description,
      'requiredGear': instance.requiredGear
          .map((e) => _$GearTypeEnumMap[e]!)
          .toList(),
      'penaltyDescription': instance.penaltyDescription,
    };

const _$InfectionRiskLevelEnumMap = {
  InfectionRiskLevel.none: 'none',
  InfectionRiskLevel.low: 'low',
  InfectionRiskLevel.medium: 'medium',
  InfectionRiskLevel.high: 'high',
};

const _$GearTypeEnumMap = {
  GearType.mask: 'mask',
  GearType.gloves: 'gloves',
  GearType.gown: 'gown',
  GearType.goggles: 'goggles',
  GearType.faceShield: 'faceShield',
};
