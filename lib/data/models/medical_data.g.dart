// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicalDataImpl _$$MedicalDataImplFromJson(Map<String, dynamic> json) =>
    _$MedicalDataImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type:
          $enumDecodeNullable(_$MedicalDataTypeEnumMap, json['type']) ??
          MedicalDataType.unknown,
      filePath: json['filePath'] as String? ?? '',
      thumbnailPath: json['thumbnailPath'] as String?,
      source: json['source'] as String?,
      location: json['location'] as String?,
      dateTime: json['dateTime'] as String?,
      discoveredAt: json['discoveredAt'] as String?,
      notes: json['notes'] as String?,
      isUnlocked: json['isUnlocked'] as bool? ?? true,
      isLocked: json['isLocked'] as bool? ?? false,
      unlockCode: json['unlockCode'] as String?,
      lockedHint: json['lockedHint'] as String?,
      hasHiddenLayer: json['hasHiddenLayer'] as bool? ?? false,
      hiddenLayerUrl: json['hiddenLayerUrl'] as String?,
      phoneData: json['phoneData'] == null
          ? null
          : PhoneData.fromJson(json['phoneData'] as Map<String, dynamic>),
      labAnalysisData: json['labAnalysisData'] == null
          ? null
          : ForensicData.fromJson(
              json['labAnalysisData'] as Map<String, dynamic>,
            ),
      isExamined: json['isExamined'] as bool? ?? false,
      referenceRange: json['referenceRange'] as String?,
      resultValue: json['resultValue'] as String?,
      isAbnormal: json['isAbnormal'] as bool? ?? false,
      isRequestable: json['isRequestable'] as bool? ?? false,
      requestDurationSeconds:
          (json['requestDurationSeconds'] as num?)?.toInt() ?? 0,
      requestCreditCost: (json['requestCreditCost'] as num?)?.toInt() ?? 0,
      isPotentiallySwapped: json['isPotentiallySwapped'] as bool? ?? false,
      correctValue: json['correctValue'] as String?,
      retestCost: (json['retestCost'] as num?)?.toInt() ?? 15,
      nurseNote: json['nurseNote'] as String?,
      nurseNoteInconsistency: json['nurseNoteInconsistency'] as String?,
      isRetested: json['isRetested'] as bool? ?? false,
    );

Map<String, dynamic> _$$MedicalDataImplToJson(_$MedicalDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$MedicalDataTypeEnumMap[instance.type]!,
      'filePath': instance.filePath,
      'thumbnailPath': instance.thumbnailPath,
      'source': instance.source,
      'location': instance.location,
      'dateTime': instance.dateTime,
      'discoveredAt': instance.discoveredAt,
      'notes': instance.notes,
      'isUnlocked': instance.isUnlocked,
      'isLocked': instance.isLocked,
      'unlockCode': instance.unlockCode,
      'lockedHint': instance.lockedHint,
      'hasHiddenLayer': instance.hasHiddenLayer,
      'hiddenLayerUrl': instance.hiddenLayerUrl,
      'phoneData': instance.phoneData,
      'labAnalysisData': instance.labAnalysisData,
      'isExamined': instance.isExamined,
      'referenceRange': instance.referenceRange,
      'resultValue': instance.resultValue,
      'isAbnormal': instance.isAbnormal,
      'isRequestable': instance.isRequestable,
      'requestDurationSeconds': instance.requestDurationSeconds,
      'requestCreditCost': instance.requestCreditCost,
      'isPotentiallySwapped': instance.isPotentiallySwapped,
      'correctValue': instance.correctValue,
      'retestCost': instance.retestCost,
      'nurseNote': instance.nurseNote,
      'nurseNoteInconsistency': instance.nurseNoteInconsistency,
      'isRetested': instance.isRetested,
    };

const _$MedicalDataTypeEnumMap = {
  MedicalDataType.imaging: 'imaging',
  MedicalDataType.labResult: 'labResult',
  MedicalDataType.physicalExam: 'physicalExam',
  MedicalDataType.document: 'document',
  MedicalDataType.phone: 'phone',
  MedicalDataType.labSample: 'labSample',
  MedicalDataType.audio: 'audio',
  MedicalDataType.photo: 'photo',
  MedicalDataType.video: 'video',
  MedicalDataType.object: 'object',
  MedicalDataType.toxicology: 'toxicology',
  MedicalDataType.policeReport: 'policeReport',
  MedicalDataType.trainingLog: 'trainingLog',
  MedicalDataType.lifestyleData: 'lifestyleData',
  MedicalDataType.anatomicalImaging: 'anatomicalImaging',
  MedicalDataType.unknown: 'unknown',
};
