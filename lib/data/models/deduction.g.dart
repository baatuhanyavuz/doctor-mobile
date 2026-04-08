// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deduction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeductionImpl _$$DeductionImplFromJson(Map<String, dynamic> json) =>
    _$DeductionImpl(
      id: json['id'] as String? ?? '',
      requiredEvidenceIds: (json['requiredEvidenceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      resultText: json['resultText'] as String? ?? '',
      title: json['title'] as String?,
      importance: (json['importance'] as num?)?.toInt() ?? 5,
      rewardEvidenceId: json['rewardEvidenceId'] as String?,
      isFound: json['isFound'] as bool? ?? false,
      isContradiction: json['isContradiction'] as bool? ?? false,
    );

Map<String, dynamic> _$$DeductionImplToJson(_$DeductionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requiredEvidenceIds': instance.requiredEvidenceIds,
      'resultText': instance.resultText,
      'title': instance.title,
      'importance': instance.importance,
      'rewardEvidenceId': instance.rewardEvidenceId,
      'isFound': instance.isFound,
      'isContradiction': instance.isContradiction,
    };
