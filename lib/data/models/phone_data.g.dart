// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhoneContactImpl _$$PhoneContactImplFromJson(Map<String, dynamic> json) =>
    _$PhoneContactImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      avatarPath: json['avatarPath'] as String?,
    );

Map<String, dynamic> _$$PhoneContactImplToJson(_$PhoneContactImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'avatarPath': instance.avatarPath,
    };

_$PhoneMessageImpl _$$PhoneMessageImplFromJson(Map<String, dynamic> json) =>
    _$PhoneMessageImpl(
      text: json['text'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      isFromMe: json['isFromMe'] as bool? ?? false,
    );

Map<String, dynamic> _$$PhoneMessageImplToJson(_$PhoneMessageImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'timestamp': instance.timestamp,
      'isFromMe': instance.isFromMe,
    };

_$PhoneChatImpl _$$PhoneChatImplFromJson(Map<String, dynamic> json) =>
    _$PhoneChatImpl(
      contactId: json['contactId'] as String? ?? '',
      contactName: json['contactName'] as String? ?? '',
      contactAvatar: json['contactAvatar'] as String?,
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => PhoneMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PhoneChatImplToJson(_$PhoneChatImpl instance) =>
    <String, dynamic>{
      'contactId': instance.contactId,
      'contactName': instance.contactName,
      'contactAvatar': instance.contactAvatar,
      'messages': instance.messages,
    };

_$PhoneCallImpl _$$PhoneCallImplFromJson(Map<String, dynamic> json) =>
    _$PhoneCallImpl(
      contactName: json['contactName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      timestamp: json['timestamp'] as String? ?? '',
      status:
          $enumDecodeNullable(_$CallStatusEnumMap, json['status']) ??
          CallStatus.unknown,
      duration: json['duration'] as String?,
    );

Map<String, dynamic> _$$PhoneCallImplToJson(_$PhoneCallImpl instance) =>
    <String, dynamic>{
      'contactName': instance.contactName,
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'status': _$CallStatusEnumMap[instance.status]!,
      'duration': instance.duration,
    };

const _$CallStatusEnumMap = {
  CallStatus.incoming: 'incoming',
  CallStatus.outgoing: 'outgoing',
  CallStatus.missed: 'missed',
  CallStatus.unknown: 'unknown',
};

_$PhoneDataImpl _$$PhoneDataImplFromJson(Map<String, dynamic> json) =>
    _$PhoneDataImpl(
      contacts:
          (json['contacts'] as List<dynamic>?)
              ?.map((e) => PhoneContact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      chats:
          (json['chats'] as List<dynamic>?)
              ?.map((e) => PhoneChat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      callHistory:
          (json['callHistory'] as List<dynamic>?)
              ?.map((e) => PhoneCall.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      galleryImages:
          (json['galleryImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      wallpaper: json['wallpaper'] as String?,
      ownerName: json['ownerName'] as String?,
    );

Map<String, dynamic> _$$PhoneDataImplToJson(_$PhoneDataImpl instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'chats': instance.chats,
      'callHistory': instance.callHistory,
      'galleryImages': instance.galleryImages,
      'wallpaper': instance.wallpaper,
      'ownerName': instance.ownerName,
    };
