// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumableImpl _$$ConsumableImplFromJson(Map<String, dynamic> json) =>
    _$ConsumableImpl(
      type: $enumDecode(_$ConsumableTypeEnumMap, json['type']),
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category:
          $enumDecodeNullable(_$ConsumableCategoryEnumMap, json['category']) ??
          ConsumableCategory.protection,
      creditCost: (json['creditCost'] as num?)?.toInt() ?? 0,
      iconName: json['iconName'] as String? ?? '',
    );

Map<String, dynamic> _$$ConsumableImplToJson(_$ConsumableImpl instance) =>
    <String, dynamic>{
      'type': _$ConsumableTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'category': _$ConsumableCategoryEnumMap[instance.category]!,
      'creditCost': instance.creditCost,
      'iconName': instance.iconName,
    };

const _$ConsumableTypeEnumMap = {
  ConsumableType.disposableGloves: 'disposableGloves',
  ConsumableType.surgicalMask: 'surgicalMask',
  ConsumableType.n95Mask: 'n95Mask',
  ConsumableType.painKiller: 'painKiller',
  ConsumableType.sedative: 'sedative',
  ConsumableType.tea: 'tea',
  ConsumableType.blanket: 'blanket',
};

const _$ConsumableCategoryEnumMap = {
  ConsumableCategory.protection: 'protection',
  ConsumableCategory.comfort: 'comfort',
};
