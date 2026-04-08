// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MiniGameDefImpl _$$MiniGameDefImplFromJson(
  Map<String, dynamic> json,
) => _$MiniGameDefImpl(
  id: json['id'] as String? ?? '',
  type: json['type'] as String? ?? '',
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  trigger: json['trigger'] as String?,
  sceneImage: json['sceneImage'] as String?,
  timeLimitSeconds: (json['timeLimitSeconds'] as num?)?.toInt(),
  correctX: (json['correctX'] as num?)?.toDouble(),
  correctY: (json['correctY'] as num?)?.toDouble(),
  correctAngle: (json['correctAngle'] as num?)?.toDouble(),
  tolerance: (json['tolerance'] as num?)?.toDouble(),
  targetArea: json['targetArea'] as Map<String, dynamic>?,
  hints:
      (json['hints'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  patientName: json['patientName'] as String?,
  patientImage: json['patientImage'] as String?,
  initialComfort: (json['initialComfort'] as num?)?.toInt(),
  comfortThreshold: (json['comfortThreshold'] as num?)?.toInt(),
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => ExaminationQuestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  criticalQuestions:
      (json['criticalQuestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  optimalOrder:
      (json['optimalOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  toxinName: json['toxinName'] as String?,
  toxinDescription: json['toxinDescription'] as String?,
  toxinSymptoms:
      (json['toxinSymptoms'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  toxicologyOptions:
      (json['toxicologyOptions'] as List<dynamic>?)
          ?.map((e) => ToxicologyOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  toxinSeverity: (json['toxinSeverity'] as num?)?.toInt() ?? 5,
  ekgAnomalyType: json['ekgAnomalyType'] as String?,
  ekgAnomalyStartX: (json['ekgAnomalyStartX'] as num?)?.toDouble(),
  ekgAnomalyEndX: (json['ekgAnomalyEndX'] as num?)?.toDouble(),
  ekgDiagnosisOptions:
      (json['ekgDiagnosisOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  ekgCorrectDiagnosis: json['ekgCorrectDiagnosis'] as String?,
  auscultationFindings:
      (json['auscultationFindings'] as List<dynamic>?)
          ?.map((e) => AuscultationFinding.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  auscultationDiagnosisOptions:
      (json['auscultationDiagnosisOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  auscultationCorrectDiagnosis: json['auscultationCorrectDiagnosis'] as String?,
  targetBPM: (json['targetBPM'] as num?)?.toInt() ?? 110,
  compressionCount: (json['compressionCount'] as num?)?.toInt() ?? 30,
  bpmTolerance: (json['bpmTolerance'] as num?)?.toInt() ?? 10,
  drugName: json['drugName'] as String?,
  drugDoseRange: json['drugDoseRange'] as String?,
  patientWeight: (json['patientWeight'] as num?)?.toDouble(),
  patientAge: (json['patientAge'] as num?)?.toInt(),
  patientGFR: (json['patientGFR'] as num?)?.toDouble(),
  correctDoseMg: (json['correctDoseMg'] as num?)?.toDouble(),
  correctIVRate: json['correctIVRate'] as String?,
  doseTolerancePercent:
      (json['doseTolerancePercent'] as num?)?.toDouble() ?? 10,
  maxDailyDoseMg: (json['maxDailyDoseMg'] as num?)?.toDouble(),
  kidneyAdjustmentNeeded: json['kidneyAdjustmentNeeded'] as bool? ?? false,
  microscopeType: json['microscopeType'] as String?,
  abnormalCellCount: (json['abnormalCellCount'] as num?)?.toInt(),
  abnormalCellType: json['abnormalCellType'] as String?,
  microscopeDiagnosisOptions:
      (json['microscopeDiagnosisOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  microscopeCorrectDiagnosis: json['microscopeCorrectDiagnosis'] as String?,
  impactPoint: json['impactPoint'] as Map<String, dynamic>?,
  bulletTrajectoryAngle: (json['bulletTrajectoryAngle'] as num?)?.toDouble(),
  suspectName: json['suspectName'] as String?,
  suspectImage: json['suspectImage'] as String?,
  initialStress: (json['initialStress'] as num?)?.toInt(),
  stressThreshold: (json['stressThreshold'] as num?)?.toInt(),
);

Map<String, dynamic> _$$MiniGameDefImplToJson(_$MiniGameDefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'trigger': instance.trigger,
      'sceneImage': instance.sceneImage,
      'timeLimitSeconds': instance.timeLimitSeconds,
      'correctX': instance.correctX,
      'correctY': instance.correctY,
      'correctAngle': instance.correctAngle,
      'tolerance': instance.tolerance,
      'targetArea': instance.targetArea,
      'hints': instance.hints,
      'patientName': instance.patientName,
      'patientImage': instance.patientImage,
      'initialComfort': instance.initialComfort,
      'comfortThreshold': instance.comfortThreshold,
      'questions': instance.questions,
      'criticalQuestions': instance.criticalQuestions,
      'optimalOrder': instance.optimalOrder,
      'toxinName': instance.toxinName,
      'toxinDescription': instance.toxinDescription,
      'toxinSymptoms': instance.toxinSymptoms,
      'toxicologyOptions': instance.toxicologyOptions,
      'toxinSeverity': instance.toxinSeverity,
      'ekgAnomalyType': instance.ekgAnomalyType,
      'ekgAnomalyStartX': instance.ekgAnomalyStartX,
      'ekgAnomalyEndX': instance.ekgAnomalyEndX,
      'ekgDiagnosisOptions': instance.ekgDiagnosisOptions,
      'ekgCorrectDiagnosis': instance.ekgCorrectDiagnosis,
      'auscultationFindings': instance.auscultationFindings,
      'auscultationDiagnosisOptions': instance.auscultationDiagnosisOptions,
      'auscultationCorrectDiagnosis': instance.auscultationCorrectDiagnosis,
      'targetBPM': instance.targetBPM,
      'compressionCount': instance.compressionCount,
      'bpmTolerance': instance.bpmTolerance,
      'drugName': instance.drugName,
      'drugDoseRange': instance.drugDoseRange,
      'patientWeight': instance.patientWeight,
      'patientAge': instance.patientAge,
      'patientGFR': instance.patientGFR,
      'correctDoseMg': instance.correctDoseMg,
      'correctIVRate': instance.correctIVRate,
      'doseTolerancePercent': instance.doseTolerancePercent,
      'maxDailyDoseMg': instance.maxDailyDoseMg,
      'kidneyAdjustmentNeeded': instance.kidneyAdjustmentNeeded,
      'microscopeType': instance.microscopeType,
      'abnormalCellCount': instance.abnormalCellCount,
      'abnormalCellType': instance.abnormalCellType,
      'microscopeDiagnosisOptions': instance.microscopeDiagnosisOptions,
      'microscopeCorrectDiagnosis': instance.microscopeCorrectDiagnosis,
      'impactPoint': instance.impactPoint,
      'bulletTrajectoryAngle': instance.bulletTrajectoryAngle,
      'suspectName': instance.suspectName,
      'suspectImage': instance.suspectImage,
      'initialStress': instance.initialStress,
      'stressThreshold': instance.stressThreshold,
    };

_$ExaminationQuestionImpl _$$ExaminationQuestionImplFromJson(
  Map<String, dynamic> json,
) => _$ExaminationQuestionImpl(
  id: json['id'] as String? ?? '',
  text: json['text'] as String? ?? '',
  stressImpact: (json['stressImpact'] as num?)?.toInt() ?? 0,
  response: json['response'] as String? ?? '',
  revealsInfo: json['revealsInfo'] as String?,
  isCritical: json['isCritical'] as bool? ?? false,
);

Map<String, dynamic> _$$ExaminationQuestionImplToJson(
  _$ExaminationQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'stressImpact': instance.stressImpact,
  'response': instance.response,
  'revealsInfo': instance.revealsInfo,
  'isCritical': instance.isCritical,
};

_$ToxicologyOptionImpl _$$ToxicologyOptionImplFromJson(
  Map<String, dynamic> json,
) => _$ToxicologyOptionImpl(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  isCorrect: json['isCorrect'] as bool? ?? false,
  wrongConsequence: json['wrongConsequence'] as String?,
  dosage: json['dosage'] as String?,
);

Map<String, dynamic> _$$ToxicologyOptionImplToJson(
  _$ToxicologyOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'isCorrect': instance.isCorrect,
  'wrongConsequence': instance.wrongConsequence,
  'dosage': instance.dosage,
};

_$AuscultationFindingImpl _$$AuscultationFindingImplFromJson(
  Map<String, dynamic> json,
) => _$AuscultationFindingImpl(
  pointId: json['pointId'] as String? ?? '',
  isAbnormal: json['isAbnormal'] as bool? ?? false,
  soundType: json['soundType'] as String? ?? 'normal',
);

Map<String, dynamic> _$$AuscultationFindingImplToJson(
  _$AuscultationFindingImpl instance,
) => <String, dynamic>{
  'pointId': instance.pointId,
  'isAbnormal': instance.isAbnormal,
  'soundType': instance.soundType,
};

_$MiniGameResultImpl _$$MiniGameResultImplFromJson(Map<String, dynamic> json) =>
    _$MiniGameResultImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      caseId: json['caseId'] as String? ?? '',
      miniGameId: json['miniGameId'] as String? ?? '',
      miniGameType: json['miniGameType'] as String? ?? '',
      score: (json['score'] as num?)?.toInt() ?? 0,
      xpEarned: (json['xpEarned'] as num?)?.toInt() ?? 0,
      totalXp: (json['totalXp'] as num?)?.toInt() ?? 0,
      newLevel: (json['newLevel'] as num?)?.toInt() ?? 0,
      leveledUp: json['leveledUp'] as bool? ?? false,
      verdict: json['verdict'] as String? ?? '',
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MiniGameResultImplToJson(
  _$MiniGameResultImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'caseId': instance.caseId,
  'miniGameId': instance.miniGameId,
  'miniGameType': instance.miniGameType,
  'score': instance.score,
  'xpEarned': instance.xpEarned,
  'totalXp': instance.totalXp,
  'newLevel': instance.newLevel,
  'leveledUp': instance.leveledUp,
  'verdict': instance.verdict,
  'details': instance.details,
};
