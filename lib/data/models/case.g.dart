// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VitalsImpl _$$VitalsImplFromJson(Map<String, dynamic> json) => _$VitalsImpl(
  bloodPressure: json['bloodPressure'] as String?,
  heartRate: (json['heartRate'] as num?)?.toInt(),
  temperature: (json['temperature'] as num?)?.toDouble(),
  oxygenSaturation: (json['oxygenSaturation'] as num?)?.toInt(),
  respiratoryRate: (json['respiratoryRate'] as num?)?.toInt(),
);

Map<String, dynamic> _$$VitalsImplToJson(_$VitalsImpl instance) =>
    <String, dynamic>{
      'bloodPressure': instance.bloodPressure,
      'heartRate': instance.heartRate,
      'temperature': instance.temperature,
      'oxygenSaturation': instance.oxygenSaturation,
      'respiratoryRate': instance.respiratoryRate,
    };

_$PatientImpl _$$PatientImplFromJson(Map<String, dynamic> json) =>
    _$PatientImpl(
      name: json['name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      bloodType: json['bloodType'] as String?,
      occupation: json['occupation'] as String?,
      photoPath: json['photoPath'] as String?,
      chronicDiseases:
          (json['chronicDiseases'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentMedications:
          (json['currentMedications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allergies:
          (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      chiefComplaint: json['chiefComplaint'] as String?,
      vitals: json['vitals'] == null
          ? null
          : Vitals.fromJson(json['vitals'] as Map<String, dynamic>),
      biography: json['biography'] as String?,
    );

Map<String, dynamic> _$$PatientImplToJson(_$PatientImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'bloodType': instance.bloodType,
      'occupation': instance.occupation,
      'photoPath': instance.photoPath,
      'chronicDiseases': instance.chronicDiseases,
      'currentMedications': instance.currentMedications,
      'allergies': instance.allergies,
      'chiefComplaint': instance.chiefComplaint,
      'vitals': instance.vitals,
      'biography': instance.biography,
    };

_$CaseImpl _$$CaseImplFromJson(Map<String, dynamic> json) => _$CaseImpl(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  shortDescription: json['shortDescription'] as String? ?? '',
  fullDescription: json['fullDescription'] as String? ?? '',
  coverImage: json['coverImage'] as String? ?? '',
  difficulty:
      $enumDecodeNullable(_$DifficultyEnumMap, json['difficulty']) ??
      Difficulty.easy,
  status:
      $enumDecodeNullable(_$CaseStatusEnumMap, json['status']) ??
      CaseStatus.available,
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  creditPrice: (json['creditPrice'] as num?)?.toInt(),
  estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
  patient: json['patient'] == null
      ? const Patient()
      : Patient.fromJson(json['patient'] as Map<String, dynamic>),
  medicalData:
      (json['medicalData'] as List<dynamic>?)
          ?.map((e) => MedicalData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  diagnoses:
      (json['diagnoses'] as List<dynamic>?)
          ?.map((e) => Diagnosis.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  interviews:
      (json['interviews'] as List<dynamic>?)
          ?.map((e) => Interview.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  solution: json['solution'] == null
      ? const Solution()
      : Solution.fromJson(json['solution'] as Map<String, dynamic>),
  deductions:
      (json['deductions'] as List<dynamic>?)
          ?.map((e) => Deduction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  miniGames:
      (json['miniGames'] as List<dynamic>?)
          ?.map((e) => MiniGameDef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  createdAt: json['createdAt'] as String?,
  playerNotes: json['playerNotes'] as String?,
  progressPercent: (json['progressPercent'] as num?)?.toInt() ?? 0,
  introText: json['introText'] as String?,
  clinic: json['clinic'] as String?,
  nurseReport: json['nurseReport'] as String?,
  infectionRisk: json['infectionRisk'] == null
      ? null
      : InfectionRisk.fromJson(json['infectionRisk'] as Map<String, dynamic>),
  ethicalDilemmas:
      (json['ethicalDilemmas'] as List<dynamic>?)
          ?.map((e) => EthicalDilemma.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  endingData: json['endingData'] == null
      ? null
      : EndingData.fromJson(json['endingData'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$CaseImplToJson(_$CaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'fullDescription': instance.fullDescription,
      'coverImage': instance.coverImage,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'status': _$CaseStatusEnumMap[instance.status]!,
      'price': instance.price,
      'creditPrice': instance.creditPrice,
      'estimatedDuration': instance.estimatedDuration,
      'patient': instance.patient,
      'medicalData': instance.medicalData,
      'diagnoses': instance.diagnoses,
      'interviews': instance.interviews,
      'solution': instance.solution,
      'deductions': instance.deductions,
      'miniGames': instance.miniGames,
      'tags': instance.tags,
      'createdAt': instance.createdAt,
      'playerNotes': instance.playerNotes,
      'progressPercent': instance.progressPercent,
      'introText': instance.introText,
      'clinic': instance.clinic,
      'nurseReport': instance.nurseReport,
      'infectionRisk': instance.infectionRisk,
      'ethicalDilemmas': instance.ethicalDilemmas,
      'endingData': instance.endingData,
    };

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
  Difficulty.tutorial: 'tutorial',
};

const _$CaseStatusEnumMap = {
  CaseStatus.locked: 'locked',
  CaseStatus.available: 'available',
  CaseStatus.inProgress: 'in_progress',
  CaseStatus.solved: 'solved',
  CaseStatus.failed: 'failed',
};

_$CaseListImpl _$$CaseListImplFromJson(Map<String, dynamic> json) =>
    _$CaseListImpl(
      cases:
          (json['cases'] as List<dynamic>?)
              ?.map((e) => Case.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CaseListImplToJson(_$CaseListImpl instance) =>
    <String, dynamic>{'cases': instance.cases};
