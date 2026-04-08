// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhoneContact _$PhoneContactFromJson(Map<String, dynamic> json) {
  return _PhoneContact.fromJson(json);
}

/// @nodoc
mixin _$PhoneContact {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String? get avatarPath => throw _privateConstructorUsedError;

  /// Serializes this PhoneContact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneContactCopyWith<PhoneContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneContactCopyWith<$Res> {
  factory $PhoneContactCopyWith(
    PhoneContact value,
    $Res Function(PhoneContact) then,
  ) = _$PhoneContactCopyWithImpl<$Res, PhoneContact>;
  @useResult
  $Res call({String id, String name, String phoneNumber, String? avatarPath});
}

/// @nodoc
class _$PhoneContactCopyWithImpl<$Res, $Val extends PhoneContact>
    implements $PhoneContactCopyWith<$Res> {
  _$PhoneContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? avatarPath = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarPath: freezed == avatarPath
                ? _value.avatarPath
                : avatarPath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhoneContactImplCopyWith<$Res>
    implements $PhoneContactCopyWith<$Res> {
  factory _$$PhoneContactImplCopyWith(
    _$PhoneContactImpl value,
    $Res Function(_$PhoneContactImpl) then,
  ) = __$$PhoneContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String phoneNumber, String? avatarPath});
}

/// @nodoc
class __$$PhoneContactImplCopyWithImpl<$Res>
    extends _$PhoneContactCopyWithImpl<$Res, _$PhoneContactImpl>
    implements _$$PhoneContactImplCopyWith<$Res> {
  __$$PhoneContactImplCopyWithImpl(
    _$PhoneContactImpl _value,
    $Res Function(_$PhoneContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhoneContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? avatarPath = freezed,
  }) {
    return _then(
      _$PhoneContactImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarPath: freezed == avatarPath
            ? _value.avatarPath
            : avatarPath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneContactImpl implements _PhoneContact {
  const _$PhoneContactImpl({
    this.id = '',
    this.name = '',
    this.phoneNumber = '',
    this.avatarPath,
  });

  factory _$PhoneContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneContactImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phoneNumber;
  @override
  final String? avatarPath;

  @override
  String toString() {
    return 'PhoneContact(id: $id, name: $name, phoneNumber: $phoneNumber, avatarPath: $avatarPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneContactImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.avatarPath, avatarPath) ||
                other.avatarPath == avatarPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, phoneNumber, avatarPath);

  /// Create a copy of PhoneContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneContactImplCopyWith<_$PhoneContactImpl> get copyWith =>
      __$$PhoneContactImplCopyWithImpl<_$PhoneContactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneContactImplToJson(this);
  }
}

abstract class _PhoneContact implements PhoneContact {
  const factory _PhoneContact({
    final String id,
    final String name,
    final String phoneNumber,
    final String? avatarPath,
  }) = _$PhoneContactImpl;

  factory _PhoneContact.fromJson(Map<String, dynamic> json) =
      _$PhoneContactImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String? get avatarPath;

  /// Create a copy of PhoneContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneContactImplCopyWith<_$PhoneContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhoneMessage _$PhoneMessageFromJson(Map<String, dynamic> json) {
  return _PhoneMessage.fromJson(json);
}

/// @nodoc
mixin _$PhoneMessage {
  String get text => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// true = kullanıcı gönderdi, false = karşı taraf gönderdi
  bool get isFromMe => throw _privateConstructorUsedError;

  /// Serializes this PhoneMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneMessageCopyWith<PhoneMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneMessageCopyWith<$Res> {
  factory $PhoneMessageCopyWith(
    PhoneMessage value,
    $Res Function(PhoneMessage) then,
  ) = _$PhoneMessageCopyWithImpl<$Res, PhoneMessage>;
  @useResult
  $Res call({String text, String timestamp, bool isFromMe});
}

/// @nodoc
class _$PhoneMessageCopyWithImpl<$Res, $Val extends PhoneMessage>
    implements $PhoneMessageCopyWith<$Res> {
  _$PhoneMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? timestamp = null,
    Object? isFromMe = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            isFromMe: null == isFromMe
                ? _value.isFromMe
                : isFromMe // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhoneMessageImplCopyWith<$Res>
    implements $PhoneMessageCopyWith<$Res> {
  factory _$$PhoneMessageImplCopyWith(
    _$PhoneMessageImpl value,
    $Res Function(_$PhoneMessageImpl) then,
  ) = __$$PhoneMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String timestamp, bool isFromMe});
}

/// @nodoc
class __$$PhoneMessageImplCopyWithImpl<$Res>
    extends _$PhoneMessageCopyWithImpl<$Res, _$PhoneMessageImpl>
    implements _$$PhoneMessageImplCopyWith<$Res> {
  __$$PhoneMessageImplCopyWithImpl(
    _$PhoneMessageImpl _value,
    $Res Function(_$PhoneMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhoneMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? timestamp = null,
    Object? isFromMe = null,
  }) {
    return _then(
      _$PhoneMessageImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        isFromMe: null == isFromMe
            ? _value.isFromMe
            : isFromMe // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneMessageImpl implements _PhoneMessage {
  const _$PhoneMessageImpl({
    this.text = '',
    this.timestamp = '',
    this.isFromMe = false,
  });

  factory _$PhoneMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneMessageImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final String timestamp;

  /// true = kullanıcı gönderdi, false = karşı taraf gönderdi
  @override
  @JsonKey()
  final bool isFromMe;

  @override
  String toString() {
    return 'PhoneMessage(text: $text, timestamp: $timestamp, isFromMe: $isFromMe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isFromMe, isFromMe) ||
                other.isFromMe == isFromMe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, timestamp, isFromMe);

  /// Create a copy of PhoneMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneMessageImplCopyWith<_$PhoneMessageImpl> get copyWith =>
      __$$PhoneMessageImplCopyWithImpl<_$PhoneMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneMessageImplToJson(this);
  }
}

abstract class _PhoneMessage implements PhoneMessage {
  const factory _PhoneMessage({
    final String text,
    final String timestamp,
    final bool isFromMe,
  }) = _$PhoneMessageImpl;

  factory _PhoneMessage.fromJson(Map<String, dynamic> json) =
      _$PhoneMessageImpl.fromJson;

  @override
  String get text;
  @override
  String get timestamp;

  /// true = kullanıcı gönderdi, false = karşı taraf gönderdi
  @override
  bool get isFromMe;

  /// Create a copy of PhoneMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneMessageImplCopyWith<_$PhoneMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhoneChat _$PhoneChatFromJson(Map<String, dynamic> json) {
  return _PhoneChat.fromJson(json);
}

/// @nodoc
mixin _$PhoneChat {
  String get contactId => throw _privateConstructorUsedError;
  String get contactName => throw _privateConstructorUsedError;
  String? get contactAvatar => throw _privateConstructorUsedError;
  List<PhoneMessage> get messages => throw _privateConstructorUsedError;

  /// Serializes this PhoneChat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneChatCopyWith<PhoneChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneChatCopyWith<$Res> {
  factory $PhoneChatCopyWith(PhoneChat value, $Res Function(PhoneChat) then) =
      _$PhoneChatCopyWithImpl<$Res, PhoneChat>;
  @useResult
  $Res call({
    String contactId,
    String contactName,
    String? contactAvatar,
    List<PhoneMessage> messages,
  });
}

/// @nodoc
class _$PhoneChatCopyWithImpl<$Res, $Val extends PhoneChat>
    implements $PhoneChatCopyWith<$Res> {
  _$PhoneChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
    Object? contactName = null,
    Object? contactAvatar = freezed,
    Object? messages = null,
  }) {
    return _then(
      _value.copyWith(
            contactId: null == contactId
                ? _value.contactId
                : contactId // ignore: cast_nullable_to_non_nullable
                      as String,
            contactName: null == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String,
            contactAvatar: freezed == contactAvatar
                ? _value.contactAvatar
                : contactAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<PhoneMessage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhoneChatImplCopyWith<$Res>
    implements $PhoneChatCopyWith<$Res> {
  factory _$$PhoneChatImplCopyWith(
    _$PhoneChatImpl value,
    $Res Function(_$PhoneChatImpl) then,
  ) = __$$PhoneChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String contactId,
    String contactName,
    String? contactAvatar,
    List<PhoneMessage> messages,
  });
}

/// @nodoc
class __$$PhoneChatImplCopyWithImpl<$Res>
    extends _$PhoneChatCopyWithImpl<$Res, _$PhoneChatImpl>
    implements _$$PhoneChatImplCopyWith<$Res> {
  __$$PhoneChatImplCopyWithImpl(
    _$PhoneChatImpl _value,
    $Res Function(_$PhoneChatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhoneChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactId = null,
    Object? contactName = null,
    Object? contactAvatar = freezed,
    Object? messages = null,
  }) {
    return _then(
      _$PhoneChatImpl(
        contactId: null == contactId
            ? _value.contactId
            : contactId // ignore: cast_nullable_to_non_nullable
                  as String,
        contactName: null == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String,
        contactAvatar: freezed == contactAvatar
            ? _value.contactAvatar
            : contactAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<PhoneMessage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneChatImpl implements _PhoneChat {
  const _$PhoneChatImpl({
    this.contactId = '',
    this.contactName = '',
    this.contactAvatar,
    final List<PhoneMessage> messages = const [],
  }) : _messages = messages;

  factory _$PhoneChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneChatImplFromJson(json);

  @override
  @JsonKey()
  final String contactId;
  @override
  @JsonKey()
  final String contactName;
  @override
  final String? contactAvatar;
  final List<PhoneMessage> _messages;
  @override
  @JsonKey()
  List<PhoneMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'PhoneChat(contactId: $contactId, contactName: $contactName, contactAvatar: $contactAvatar, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneChatImpl &&
            (identical(other.contactId, contactId) ||
                other.contactId == contactId) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactAvatar, contactAvatar) ||
                other.contactAvatar == contactAvatar) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    contactId,
    contactName,
    contactAvatar,
    const DeepCollectionEquality().hash(_messages),
  );

  /// Create a copy of PhoneChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneChatImplCopyWith<_$PhoneChatImpl> get copyWith =>
      __$$PhoneChatImplCopyWithImpl<_$PhoneChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneChatImplToJson(this);
  }
}

abstract class _PhoneChat implements PhoneChat {
  const factory _PhoneChat({
    final String contactId,
    final String contactName,
    final String? contactAvatar,
    final List<PhoneMessage> messages,
  }) = _$PhoneChatImpl;

  factory _PhoneChat.fromJson(Map<String, dynamic> json) =
      _$PhoneChatImpl.fromJson;

  @override
  String get contactId;
  @override
  String get contactName;
  @override
  String? get contactAvatar;
  @override
  List<PhoneMessage> get messages;

  /// Create a copy of PhoneChat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneChatImplCopyWith<_$PhoneChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhoneCall _$PhoneCallFromJson(Map<String, dynamic> json) {
  return _PhoneCall.fromJson(json);
}

/// @nodoc
mixin _$PhoneCall {
  String get contactName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  CallStatus get status => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;

  /// Serializes this PhoneCall to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneCallCopyWith<PhoneCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneCallCopyWith<$Res> {
  factory $PhoneCallCopyWith(PhoneCall value, $Res Function(PhoneCall) then) =
      _$PhoneCallCopyWithImpl<$Res, PhoneCall>;
  @useResult
  $Res call({
    String contactName,
    String? phoneNumber,
    String timestamp,
    CallStatus status,
    String? duration,
  });
}

/// @nodoc
class _$PhoneCallCopyWithImpl<$Res, $Val extends PhoneCall>
    implements $PhoneCallCopyWith<$Res> {
  _$PhoneCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactName = null,
    Object? phoneNumber = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? duration = freezed,
  }) {
    return _then(
      _value.copyWith(
            contactName: null == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CallStatus,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhoneCallImplCopyWith<$Res>
    implements $PhoneCallCopyWith<$Res> {
  factory _$$PhoneCallImplCopyWith(
    _$PhoneCallImpl value,
    $Res Function(_$PhoneCallImpl) then,
  ) = __$$PhoneCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String contactName,
    String? phoneNumber,
    String timestamp,
    CallStatus status,
    String? duration,
  });
}

/// @nodoc
class __$$PhoneCallImplCopyWithImpl<$Res>
    extends _$PhoneCallCopyWithImpl<$Res, _$PhoneCallImpl>
    implements _$$PhoneCallImplCopyWith<$Res> {
  __$$PhoneCallImplCopyWithImpl(
    _$PhoneCallImpl _value,
    $Res Function(_$PhoneCallImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhoneCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contactName = null,
    Object? phoneNumber = freezed,
    Object? timestamp = null,
    Object? status = null,
    Object? duration = freezed,
  }) {
    return _then(
      _$PhoneCallImpl(
        contactName: null == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CallStatus,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneCallImpl implements _PhoneCall {
  const _$PhoneCallImpl({
    this.contactName = '',
    this.phoneNumber,
    this.timestamp = '',
    this.status = CallStatus.unknown,
    this.duration,
  });

  factory _$PhoneCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneCallImplFromJson(json);

  @override
  @JsonKey()
  final String contactName;
  @override
  final String? phoneNumber;
  @override
  @JsonKey()
  final String timestamp;
  @override
  @JsonKey()
  final CallStatus status;
  @override
  final String? duration;

  @override
  String toString() {
    return 'PhoneCall(contactName: $contactName, phoneNumber: $phoneNumber, timestamp: $timestamp, status: $status, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneCallImpl &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    contactName,
    phoneNumber,
    timestamp,
    status,
    duration,
  );

  /// Create a copy of PhoneCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneCallImplCopyWith<_$PhoneCallImpl> get copyWith =>
      __$$PhoneCallImplCopyWithImpl<_$PhoneCallImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneCallImplToJson(this);
  }
}

abstract class _PhoneCall implements PhoneCall {
  const factory _PhoneCall({
    final String contactName,
    final String? phoneNumber,
    final String timestamp,
    final CallStatus status,
    final String? duration,
  }) = _$PhoneCallImpl;

  factory _PhoneCall.fromJson(Map<String, dynamic> json) =
      _$PhoneCallImpl.fromJson;

  @override
  String get contactName;
  @override
  String? get phoneNumber;
  @override
  String get timestamp;
  @override
  CallStatus get status;
  @override
  String? get duration;

  /// Create a copy of PhoneCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneCallImplCopyWith<_$PhoneCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhoneData _$PhoneDataFromJson(Map<String, dynamic> json) {
  return _PhoneData.fromJson(json);
}

/// @nodoc
mixin _$PhoneData {
  /// Kişiler
  List<PhoneContact> get contacts => throw _privateConstructorUsedError;

  /// Sohbetler
  List<PhoneChat> get chats => throw _privateConstructorUsedError;

  /// Arama geçmişi
  List<PhoneCall> get callHistory => throw _privateConstructorUsedError;

  /// Galeri fotoğrafları
  List<String> get galleryImages => throw _privateConstructorUsedError;

  /// Telefon duvar kağıdı
  String? get wallpaper => throw _privateConstructorUsedError;

  /// Telefon sahibinin adı
  String? get ownerName => throw _privateConstructorUsedError;

  /// Serializes this PhoneData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhoneData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhoneDataCopyWith<PhoneData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneDataCopyWith<$Res> {
  factory $PhoneDataCopyWith(PhoneData value, $Res Function(PhoneData) then) =
      _$PhoneDataCopyWithImpl<$Res, PhoneData>;
  @useResult
  $Res call({
    List<PhoneContact> contacts,
    List<PhoneChat> chats,
    List<PhoneCall> callHistory,
    List<String> galleryImages,
    String? wallpaper,
    String? ownerName,
  });
}

/// @nodoc
class _$PhoneDataCopyWithImpl<$Res, $Val extends PhoneData>
    implements $PhoneDataCopyWith<$Res> {
  _$PhoneDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhoneData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
    Object? chats = null,
    Object? callHistory = null,
    Object? galleryImages = null,
    Object? wallpaper = freezed,
    Object? ownerName = freezed,
  }) {
    return _then(
      _value.copyWith(
            contacts: null == contacts
                ? _value.contacts
                : contacts // ignore: cast_nullable_to_non_nullable
                      as List<PhoneContact>,
            chats: null == chats
                ? _value.chats
                : chats // ignore: cast_nullable_to_non_nullable
                      as List<PhoneChat>,
            callHistory: null == callHistory
                ? _value.callHistory
                : callHistory // ignore: cast_nullable_to_non_nullable
                      as List<PhoneCall>,
            galleryImages: null == galleryImages
                ? _value.galleryImages
                : galleryImages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            wallpaper: freezed == wallpaper
                ? _value.wallpaper
                : wallpaper // ignore: cast_nullable_to_non_nullable
                      as String?,
            ownerName: freezed == ownerName
                ? _value.ownerName
                : ownerName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhoneDataImplCopyWith<$Res>
    implements $PhoneDataCopyWith<$Res> {
  factory _$$PhoneDataImplCopyWith(
    _$PhoneDataImpl value,
    $Res Function(_$PhoneDataImpl) then,
  ) = __$$PhoneDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PhoneContact> contacts,
    List<PhoneChat> chats,
    List<PhoneCall> callHistory,
    List<String> galleryImages,
    String? wallpaper,
    String? ownerName,
  });
}

/// @nodoc
class __$$PhoneDataImplCopyWithImpl<$Res>
    extends _$PhoneDataCopyWithImpl<$Res, _$PhoneDataImpl>
    implements _$$PhoneDataImplCopyWith<$Res> {
  __$$PhoneDataImplCopyWithImpl(
    _$PhoneDataImpl _value,
    $Res Function(_$PhoneDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PhoneData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contacts = null,
    Object? chats = null,
    Object? callHistory = null,
    Object? galleryImages = null,
    Object? wallpaper = freezed,
    Object? ownerName = freezed,
  }) {
    return _then(
      _$PhoneDataImpl(
        contacts: null == contacts
            ? _value._contacts
            : contacts // ignore: cast_nullable_to_non_nullable
                  as List<PhoneContact>,
        chats: null == chats
            ? _value._chats
            : chats // ignore: cast_nullable_to_non_nullable
                  as List<PhoneChat>,
        callHistory: null == callHistory
            ? _value._callHistory
            : callHistory // ignore: cast_nullable_to_non_nullable
                  as List<PhoneCall>,
        galleryImages: null == galleryImages
            ? _value._galleryImages
            : galleryImages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        wallpaper: freezed == wallpaper
            ? _value.wallpaper
            : wallpaper // ignore: cast_nullable_to_non_nullable
                  as String?,
        ownerName: freezed == ownerName
            ? _value.ownerName
            : ownerName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhoneDataImpl implements _PhoneData {
  const _$PhoneDataImpl({
    final List<PhoneContact> contacts = const [],
    final List<PhoneChat> chats = const [],
    final List<PhoneCall> callHistory = const [],
    final List<String> galleryImages = const [],
    this.wallpaper,
    this.ownerName,
  }) : _contacts = contacts,
       _chats = chats,
       _callHistory = callHistory,
       _galleryImages = galleryImages;

  factory _$PhoneDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhoneDataImplFromJson(json);

  /// Kişiler
  final List<PhoneContact> _contacts;

  /// Kişiler
  @override
  @JsonKey()
  List<PhoneContact> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// Sohbetler
  final List<PhoneChat> _chats;

  /// Sohbetler
  @override
  @JsonKey()
  List<PhoneChat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  /// Arama geçmişi
  final List<PhoneCall> _callHistory;

  /// Arama geçmişi
  @override
  @JsonKey()
  List<PhoneCall> get callHistory {
    if (_callHistory is EqualUnmodifiableListView) return _callHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_callHistory);
  }

  /// Galeri fotoğrafları
  final List<String> _galleryImages;

  /// Galeri fotoğrafları
  @override
  @JsonKey()
  List<String> get galleryImages {
    if (_galleryImages is EqualUnmodifiableListView) return _galleryImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_galleryImages);
  }

  /// Telefon duvar kağıdı
  @override
  final String? wallpaper;

  /// Telefon sahibinin adı
  @override
  final String? ownerName;

  @override
  String toString() {
    return 'PhoneData(contacts: $contacts, chats: $chats, callHistory: $callHistory, galleryImages: $galleryImages, wallpaper: $wallpaper, ownerName: $ownerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneDataImpl &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            const DeepCollectionEquality().equals(
              other._callHistory,
              _callHistory,
            ) &&
            const DeepCollectionEquality().equals(
              other._galleryImages,
              _galleryImages,
            ) &&
            (identical(other.wallpaper, wallpaper) ||
                other.wallpaper == wallpaper) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_contacts),
    const DeepCollectionEquality().hash(_chats),
    const DeepCollectionEquality().hash(_callHistory),
    const DeepCollectionEquality().hash(_galleryImages),
    wallpaper,
    ownerName,
  );

  /// Create a copy of PhoneData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneDataImplCopyWith<_$PhoneDataImpl> get copyWith =>
      __$$PhoneDataImplCopyWithImpl<_$PhoneDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneDataImplToJson(this);
  }
}

abstract class _PhoneData implements PhoneData {
  const factory _PhoneData({
    final List<PhoneContact> contacts,
    final List<PhoneChat> chats,
    final List<PhoneCall> callHistory,
    final List<String> galleryImages,
    final String? wallpaper,
    final String? ownerName,
  }) = _$PhoneDataImpl;

  factory _PhoneData.fromJson(Map<String, dynamic> json) =
      _$PhoneDataImpl.fromJson;

  /// Kişiler
  @override
  List<PhoneContact> get contacts;

  /// Sohbetler
  @override
  List<PhoneChat> get chats;

  /// Arama geçmişi
  @override
  List<PhoneCall> get callHistory;

  /// Galeri fotoğrafları
  @override
  List<String> get galleryImages;

  /// Telefon duvar kağıdı
  @override
  String? get wallpaper;

  /// Telefon sahibinin adı
  @override
  String? get ownerName;

  /// Create a copy of PhoneData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneDataImplCopyWith<_$PhoneDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
