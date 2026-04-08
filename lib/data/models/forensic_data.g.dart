// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forensic_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReagentImpl _$$ReagentImplFromJson(Map<String, dynamic> json) =>
    _$ReagentImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '',
      isCorrect: json['isCorrect'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReagentImplToJson(_$ReagentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'isCorrect': instance.isCorrect,
    };

_$ForensicDataImpl _$$ForensicDataImplFromJson(Map<String, dynamic> json) =>
    _$ForensicDataImpl(
      initialImageUrl: json['initialImageUrl'] as String? ?? '',
      resultImageUrl: json['resultImageUrl'] as String? ?? '',
      resultText: json['resultText'] as String? ?? '',
      reagents:
          (json['reagents'] as List<dynamic>?)
              ?.map((e) => Reagent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ForensicDataImplToJson(_$ForensicDataImpl instance) =>
    <String, dynamic>{
      'initialImageUrl': instance.initialImageUrl,
      'resultImageUrl': instance.resultImageUrl,
      'resultText': instance.resultText,
      'reagents': instance.reagents,
    };
