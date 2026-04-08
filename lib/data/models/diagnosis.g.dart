// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiagnosisImpl _$$DiagnosisImplFromJson(Map<String, dynamic> json) =>
    _$DiagnosisImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String?,
      iconPath: json['iconPath'] as String?,
      description: json['description'] as String?,
      typicalSymptoms:
          (json['typicalSymptoms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      riskFactors:
          (json['riskFactors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      occupation: json['occupation'] as String?,
      differentialNotes: json['differentialNotes'] as String?,
      photoPath: json['photoPath'] as String?,
      biography: json['biography'] as String?,
      personalityTraits: (json['personalityTraits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isCorrectDiagnosis: json['isCorrectDiagnosis'] as bool? ?? false,
      isRuledOut: json['isRuledOut'] as bool? ?? false,
    );

Map<String, dynamic> _$$DiagnosisImplToJson(_$DiagnosisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'iconPath': instance.iconPath,
      'description': instance.description,
      'typicalSymptoms': instance.typicalSymptoms,
      'riskFactors': instance.riskFactors,
      'occupation': instance.occupation,
      'differentialNotes': instance.differentialNotes,
      'photoPath': instance.photoPath,
      'biography': instance.biography,
      'personalityTraits': instance.personalityTraits,
      'isCorrectDiagnosis': instance.isCorrectDiagnosis,
      'isRuledOut': instance.isRuledOut,
    };
