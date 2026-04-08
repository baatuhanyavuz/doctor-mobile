// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DangerousTreatmentImpl _$$DangerousTreatmentImplFromJson(
  Map<String, dynamic> json,
) => _$DangerousTreatmentImpl(
  treatmentName: json['treatmentName'] as String? ?? '',
  reason: json['reason'] as String? ?? '',
  consequence: json['consequence'] as String? ?? '',
);

Map<String, dynamic> _$$DangerousTreatmentImplToJson(
  _$DangerousTreatmentImpl instance,
) => <String, dynamic>{
  'treatmentName': instance.treatmentName,
  'reason': instance.reason,
  'consequence': instance.consequence,
};

_$SolutionImpl _$$SolutionImplFromJson(Map<String, dynamic> json) =>
    _$SolutionImpl(
      correctDiagnosisId: json['correctDiagnosisId'] as String? ?? '',
      correctTreatment: json['correctTreatment'] as String? ?? '',
      explanation: json['explanation'] as String? ?? '',
      treatmentOptions:
          (json['treatmentOptions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      educationalNote: json['educationalNote'] as String? ?? '',
      scoreReward: (json['scoreReward'] as num?)?.toInt() ?? 100,
      dangerousTreatments:
          (json['dangerousTreatments'] as List<dynamic>?)
              ?.map(
                (e) => DangerousTreatment.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      guiltyIdLegacy: json['guiltyId'] as String?,
      correctMotiveLegacy: json['correctMotive'] as String?,
      motiveOptionsLegacy: (json['motiveOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SolutionImplToJson(_$SolutionImpl instance) =>
    <String, dynamic>{
      'correctDiagnosisId': instance.correctDiagnosisId,
      'correctTreatment': instance.correctTreatment,
      'explanation': instance.explanation,
      'treatmentOptions': instance.treatmentOptions,
      'educationalNote': instance.educationalNote,
      'scoreReward': instance.scoreReward,
      'dangerousTreatments': instance.dangerousTreatments,
      'guiltyId': instance.guiltyIdLegacy,
      'correctMotive': instance.correctMotiveLegacy,
      'motiveOptions': instance.motiveOptionsLegacy,
    };

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      selectedDiagnosisId: json['selectedDiagnosisId'] as String? ?? '',
      selectedTreatment: json['selectedTreatment'] as String? ?? '',
      isCorrect: json['isCorrect'] as bool? ?? false,
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'selectedDiagnosisId': instance.selectedDiagnosisId,
      'selectedTreatment': instance.selectedTreatment,
      'isCorrect': instance.isCorrect,
      'submittedAt': instance.submittedAt?.toIso8601String(),
    };
