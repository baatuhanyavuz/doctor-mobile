// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionAnswerImpl _$$QuestionAnswerImplFromJson(Map<String, dynamic> json) =>
    _$QuestionAnswerImpl(
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
      isClue: json['isClue'] as bool? ?? false,
      isContradiction: json['isContradiction'] as bool? ?? false,
      truthReveal: json['truthReveal'] as String?,
      contradictionEvidenceId: json['contradictionEvidenceId'] as String?,
    );

Map<String, dynamic> _$$QuestionAnswerImplToJson(
  _$QuestionAnswerImpl instance,
) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
  'isClue': instance.isClue,
  'isContradiction': instance.isContradiction,
  'truthReveal': instance.truthReveal,
  'contradictionEvidenceId': instance.contradictionEvidenceId,
};

_$InterviewImpl _$$InterviewImplFromJson(Map<String, dynamic> json) =>
    _$InterviewImpl(
      id: json['id'] as String? ?? '',
      personId: json['personId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      personName: json['personName'] as String?,
      personType:
          $enumDecodeNullable(
            _$InterviewPersonTypeEnumMap,
            json['personType'],
          ) ??
          InterviewPersonType.patient,
      personPhotoPath: json['personPhotoPath'] as String?,
      dateTime: json['dateTime'] as String?,
      transcript:
          (json['transcript'] as List<dynamic>?)
              ?.map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      audioPath: json['audioPath'] as String?,
      summary: json['summary'] as String?,
      keyFindings: (json['keyFindings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isUnlocked: json['isUnlocked'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isInteractive: json['isInteractive'] as bool? ?? false,
      dialogueTree: (json['dialogueTree'] as List<dynamic>?)
          ?.map((e) => DialogueNode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InterviewImplToJson(_$InterviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'personId': instance.personId,
      'title': instance.title,
      'personName': instance.personName,
      'personType': _$InterviewPersonTypeEnumMap[instance.personType]!,
      'personPhotoPath': instance.personPhotoPath,
      'dateTime': instance.dateTime,
      'transcript': instance.transcript,
      'audioPath': instance.audioPath,
      'summary': instance.summary,
      'keyFindings': instance.keyFindings,
      'isUnlocked': instance.isUnlocked,
      'isCompleted': instance.isCompleted,
      'isInteractive': instance.isInteractive,
      'dialogueTree': instance.dialogueTree,
    };

const _$InterviewPersonTypeEnumMap = {
  InterviewPersonType.patient: 'patient',
  InterviewPersonType.relative: 'relative',
  InterviewPersonType.nurse: 'nurse',
  InterviewPersonType.other: 'other',
};
