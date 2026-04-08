// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DialogueNodeImpl _$$DialogueNodeImplFromJson(Map<String, dynamic> json) =>
    _$DialogueNodeImpl(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      options: (json['options'] as List<dynamic>)
          .map((e) => DialogueOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEnd: json['isEnd'] as bool? ?? false,
    );

Map<String, dynamic> _$$DialogueNodeImplToJson(_$DialogueNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'options': instance.options,
      'isEnd': instance.isEnd,
    };

_$DialogueOptionImpl _$$DialogueOptionImplFromJson(Map<String, dynamic> json) =>
    _$DialogueOptionImpl(
      text: json['text'] as String? ?? '',
      nextNodeId: json['nextNodeId'] as String?,
    );

Map<String, dynamic> _$$DialogueOptionImplToJson(
  _$DialogueOptionImpl instance,
) => <String, dynamic>{
  'text': instance.text,
  'nextNodeId': instance.nextNodeId,
};

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      isPlayer: json['isPlayer'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isPlayer': instance.isPlayer,
      'timestamp': instance.timestamp.toIso8601String(),
    };
