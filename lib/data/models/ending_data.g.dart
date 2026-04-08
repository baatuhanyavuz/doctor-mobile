// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ending_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EndingDataImpl _$$EndingDataImplFromJson(Map<String, dynamic> json) =>
    _$EndingDataImpl(
      title: json['title'] as String? ?? '',
      narrative: json['narrative'] as String? ?? '',
      patientFeedback: json['patientFeedback'] as String? ?? '',
      patientImage: json['patientImage'] as String?,
      educationalNote: json['educationalNote'] as String?,
      alternateNarratives:
          (json['alternateNarratives'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      reputationThreshold: (json['reputationThreshold'] as num?)?.toInt(),
      lowReputationNarrative: json['lowReputationNarrative'] as String?,
      lowReputationFeedback: json['lowReputationFeedback'] as String?,
      killerConfessionLegacy: json['killerConfession'] as String?,
      killerImageLegacy: json['killerImage'] as String?,
    );

Map<String, dynamic> _$$EndingDataImplToJson(_$EndingDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'narrative': instance.narrative,
      'patientFeedback': instance.patientFeedback,
      'patientImage': instance.patientImage,
      'educationalNote': instance.educationalNote,
      'alternateNarratives': instance.alternateNarratives,
      'reputationThreshold': instance.reputationThreshold,
      'lowReputationNarrative': instance.lowReputationNarrative,
      'lowReputationFeedback': instance.lowReputationFeedback,
      'killerConfession': instance.killerConfessionLegacy,
      'killerImage': instance.killerImageLegacy,
    };
