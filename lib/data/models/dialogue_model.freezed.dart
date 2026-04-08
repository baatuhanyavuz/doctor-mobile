// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dialogue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DialogueNode _$DialogueNodeFromJson(Map<String, dynamic> json) {
  return _DialogueNode.fromJson(json);
}

/// @nodoc
mixin _$DialogueNode {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError; // Hastanın söylediği
  List<DialogueOption> get options => throw _privateConstructorUsedError;
  bool get isEnd => throw _privateConstructorUsedError;

  /// Serializes this DialogueNode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogueNodeCopyWith<DialogueNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogueNodeCopyWith<$Res> {
  factory $DialogueNodeCopyWith(
    DialogueNode value,
    $Res Function(DialogueNode) then,
  ) = _$DialogueNodeCopyWithImpl<$Res, DialogueNode>;
  @useResult
  $Res call({String id, String text, List<DialogueOption> options, bool isEnd});
}

/// @nodoc
class _$DialogueNodeCopyWithImpl<$Res, $Val extends DialogueNode>
    implements $DialogueNodeCopyWith<$Res> {
  _$DialogueNodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? options = null,
    Object? isEnd = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<DialogueOption>,
            isEnd: null == isEnd
                ? _value.isEnd
                : isEnd // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DialogueNodeImplCopyWith<$Res>
    implements $DialogueNodeCopyWith<$Res> {
  factory _$$DialogueNodeImplCopyWith(
    _$DialogueNodeImpl value,
    $Res Function(_$DialogueNodeImpl) then,
  ) = __$$DialogueNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, List<DialogueOption> options, bool isEnd});
}

/// @nodoc
class __$$DialogueNodeImplCopyWithImpl<$Res>
    extends _$DialogueNodeCopyWithImpl<$Res, _$DialogueNodeImpl>
    implements _$$DialogueNodeImplCopyWith<$Res> {
  __$$DialogueNodeImplCopyWithImpl(
    _$DialogueNodeImpl _value,
    $Res Function(_$DialogueNodeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? options = null,
    Object? isEnd = null,
  }) {
    return _then(
      _$DialogueNodeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<DialogueOption>,
        isEnd: null == isEnd
            ? _value.isEnd
            : isEnd // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DialogueNodeImpl implements _DialogueNode {
  const _$DialogueNodeImpl({
    this.id = '',
    this.text = '',
    required final List<DialogueOption> options,
    this.isEnd = false,
  }) : _options = options;

  factory _$DialogueNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogueNodeImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String text;
  // Hastanın söylediği
  final List<DialogueOption> _options;
  // Hastanın söylediği
  @override
  List<DialogueOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final bool isEnd;

  @override
  String toString() {
    return 'DialogueNode(id: $id, text: $text, options: $options, isEnd: $isEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogueNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.isEnd, isEnd) || other.isEnd == isEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    const DeepCollectionEquality().hash(_options),
    isEnd,
  );

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogueNodeImplCopyWith<_$DialogueNodeImpl> get copyWith =>
      __$$DialogueNodeImplCopyWithImpl<_$DialogueNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogueNodeImplToJson(this);
  }
}

abstract class _DialogueNode implements DialogueNode {
  const factory _DialogueNode({
    final String id,
    final String text,
    required final List<DialogueOption> options,
    final bool isEnd,
  }) = _$DialogueNodeImpl;

  factory _DialogueNode.fromJson(Map<String, dynamic> json) =
      _$DialogueNodeImpl.fromJson;

  @override
  String get id;
  @override
  String get text; // Hastanın söylediği
  @override
  List<DialogueOption> get options;
  @override
  bool get isEnd;

  /// Create a copy of DialogueNode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DialogueNodeImplCopyWith<_$DialogueNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DialogueOption _$DialogueOptionFromJson(Map<String, dynamic> json) {
  return _DialogueOption.fromJson(json);
}

/// @nodoc
mixin _$DialogueOption {
  String get text => throw _privateConstructorUsedError; // Seçenek metni
  String? get nextNodeId => throw _privateConstructorUsedError;

  /// Serializes this DialogueOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DialogueOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DialogueOptionCopyWith<DialogueOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogueOptionCopyWith<$Res> {
  factory $DialogueOptionCopyWith(
    DialogueOption value,
    $Res Function(DialogueOption) then,
  ) = _$DialogueOptionCopyWithImpl<$Res, DialogueOption>;
  @useResult
  $Res call({String text, String? nextNodeId});
}

/// @nodoc
class _$DialogueOptionCopyWithImpl<$Res, $Val extends DialogueOption>
    implements $DialogueOptionCopyWith<$Res> {
  _$DialogueOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DialogueOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? nextNodeId = freezed}) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            nextNodeId: freezed == nextNodeId
                ? _value.nextNodeId
                : nextNodeId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DialogueOptionImplCopyWith<$Res>
    implements $DialogueOptionCopyWith<$Res> {
  factory _$$DialogueOptionImplCopyWith(
    _$DialogueOptionImpl value,
    $Res Function(_$DialogueOptionImpl) then,
  ) = __$$DialogueOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? nextNodeId});
}

/// @nodoc
class __$$DialogueOptionImplCopyWithImpl<$Res>
    extends _$DialogueOptionCopyWithImpl<$Res, _$DialogueOptionImpl>
    implements _$$DialogueOptionImplCopyWith<$Res> {
  __$$DialogueOptionImplCopyWithImpl(
    _$DialogueOptionImpl _value,
    $Res Function(_$DialogueOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DialogueOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? nextNodeId = freezed}) {
    return _then(
      _$DialogueOptionImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        nextNodeId: freezed == nextNodeId
            ? _value.nextNodeId
            : nextNodeId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DialogueOptionImpl implements _DialogueOption {
  const _$DialogueOptionImpl({this.text = '', this.nextNodeId});

  factory _$DialogueOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogueOptionImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  // Seçenek metni
  @override
  final String? nextNodeId;

  @override
  String toString() {
    return 'DialogueOption(text: $text, nextNodeId: $nextNodeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogueOptionImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.nextNodeId, nextNodeId) ||
                other.nextNodeId == nextNodeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, nextNodeId);

  /// Create a copy of DialogueOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogueOptionImplCopyWith<_$DialogueOptionImpl> get copyWith =>
      __$$DialogueOptionImplCopyWithImpl<_$DialogueOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogueOptionImplToJson(this);
  }
}

abstract class _DialogueOption implements DialogueOption {
  const factory _DialogueOption({final String text, final String? nextNodeId}) =
      _$DialogueOptionImpl;

  factory _DialogueOption.fromJson(Map<String, dynamic> json) =
      _$DialogueOptionImpl.fromJson;

  @override
  String get text; // Seçenek metni
  @override
  String? get nextNodeId;

  /// Create a copy of DialogueOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DialogueOptionImplCopyWith<_$DialogueOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  bool get isPlayer =>
      throw _privateConstructorUsedError; // true: Doktor, false: Hasta
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({String id, String text, bool isPlayer, DateTime timestamp});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isPlayer = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            isPlayer: null == isPlayer
                ? _value.isPlayer
                : isPlayer // ignore: cast_nullable_to_non_nullable
                      as bool,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, bool isPlayer, DateTime timestamp});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? isPlayer = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$ChatMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        isPlayer: null == isPlayer
            ? _value.isPlayer
            : isPlayer // ignore: cast_nullable_to_non_nullable
                  as bool,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl({
    this.id = '',
    this.text = '',
    required this.isPlayer,
    required this.timestamp,
  });

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String text;
  @override
  final bool isPlayer;
  // true: Doktor, false: Hasta
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, isPlayer: $isPlayer, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isPlayer, isPlayer) ||
                other.isPlayer == isPlayer) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, isPlayer, timestamp);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    final String id,
    final String text,
    required final bool isPlayer,
    required final DateTime timestamp,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  bool get isPlayer; // true: Doktor, false: Hasta
  @override
  DateTime get timestamp;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
