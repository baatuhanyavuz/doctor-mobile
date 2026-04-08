// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ethical_dilemma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DilemmaChoiceImpl _$$DilemmaChoiceImplFromJson(Map<String, dynamic> json) =>
    _$DilemmaChoiceImpl(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      consequence: json['consequence'] as String? ?? '',
      reputationImpact: (json['reputationImpact'] as num?)?.toInt() ?? 0,
      unlocksEvidenceId: json['unlocksEvidenceId'] as String?,
      removesEvidenceId: json['removesEvidenceId'] as String?,
      alternateEndingNarrative: json['alternateEndingNarrative'] as String?,
      alternateEndingTitle: json['alternateEndingTitle'] as String?,
      alternatePatientFeedback: json['alternatePatientFeedback'] as String?,
      isEthical: json['isEthical'] as bool? ?? false,
    );

Map<String, dynamic> _$$DilemmaChoiceImplToJson(_$DilemmaChoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'consequence': instance.consequence,
      'reputationImpact': instance.reputationImpact,
      'unlocksEvidenceId': instance.unlocksEvidenceId,
      'removesEvidenceId': instance.removesEvidenceId,
      'alternateEndingNarrative': instance.alternateEndingNarrative,
      'alternateEndingTitle': instance.alternateEndingTitle,
      'alternatePatientFeedback': instance.alternatePatientFeedback,
      'isEthical': instance.isEthical,
    };

_$EthicalDilemmaImpl _$$EthicalDilemmaImplFromJson(Map<String, dynamic> json) =>
    _$EthicalDilemmaImpl(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      triggerPoint: json['triggerPoint'] as String? ?? 'before_solution',
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => DilemmaChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      contextInfo: json['contextInfo'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$EthicalDilemmaImplToJson(
  _$EthicalDilemmaImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'triggerPoint': instance.triggerPoint,
  'choices': instance.choices,
  'contextInfo': instance.contextInfo,
  'category': instance.category,
};
