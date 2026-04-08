// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticky_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StickyNoteImpl _$$StickyNoteImplFromJson(Map<String, dynamic> json) =>
    _$StickyNoteImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      color: (json['color'] as num?)?.toInt() ?? 0xFFFFF9C4,
      x: (json['x'] as num?)?.toDouble() ?? 100,
      y: (json['y'] as num?)?.toDouble() ?? 100,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$StickyNoteImplToJson(_$StickyNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'color': instance.color,
      'x': instance.x,
      'y': instance.y,
      'createdAt': instance.createdAt,
    };
