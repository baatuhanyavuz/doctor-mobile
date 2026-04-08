import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_data.freezed.dart';
part 'phone_data.g.dart';

/// Telefon kişisi
@freezed
class PhoneContact with _$PhoneContact {
  const factory PhoneContact({
    @Default('') String id,
    @Default('') String name,
    @Default('') String phoneNumber,
    String? avatarPath,
  }) = _PhoneContact;

  factory PhoneContact.fromJson(Map<String, dynamic> json) =>
      _$PhoneContactFromJson(json);
}

/// Telefon mesajı
@freezed
class PhoneMessage with _$PhoneMessage {
  const factory PhoneMessage({
    @Default('') String text,
    @Default('') String timestamp,
    /// true = kullanıcı gönderdi, false = karşı taraf gönderdi
    @Default(false) bool isFromMe,
  }) = _PhoneMessage;

  factory PhoneMessage.fromJson(Map<String, dynamic> json) =>
      _$PhoneMessageFromJson(json);
}

/// Telefon sohbeti
@freezed
class PhoneChat with _$PhoneChat {
  const factory PhoneChat({
    @Default('') String contactId,
    @Default('') String contactName,
    String? contactAvatar,
    @Default([]) List<PhoneMessage> messages,
  }) = _PhoneChat;

  factory PhoneChat.fromJson(Map<String, dynamic> json) =>
      _$PhoneChatFromJson(json);
}

/// Arama durumu
enum CallStatus {
  @JsonValue('incoming')
  incoming,     // Gelen
  @JsonValue('outgoing')
  outgoing,     // Giden
  @JsonValue('missed')
  missed,       // Cevapsız
  @JsonValue('unknown')
  unknown,
}

/// Telefon araması
@freezed
class PhoneCall with _$PhoneCall {
  const factory PhoneCall({
    @Default('') String contactName,
    String? phoneNumber,
    @Default('') String timestamp,
    @Default(CallStatus.unknown) CallStatus status,
    String? duration,
  }) = _PhoneCall;

  factory PhoneCall.fromJson(Map<String, dynamic> json) =>
      _$PhoneCallFromJson(json);
}

/// Telefon verisi (tüm içerik)
@freezed
class PhoneData with _$PhoneData {
  const factory PhoneData({
    /// Kişiler
    @Default([]) List<PhoneContact> contacts,
    /// Sohbetler
    @Default([]) List<PhoneChat> chats,
    /// Arama geçmişi
    @Default([]) List<PhoneCall> callHistory,
    /// Galeri fotoğrafları
    @Default([]) List<String> galleryImages,
    /// Telefon duvar kağıdı
    String? wallpaper,
    /// Telefon sahibinin adı
    String? ownerName,
  }) = _PhoneData;

  factory PhoneData.fromJson(Map<String, dynamic> json) =>
      _$PhoneDataFromJson(json);
}
