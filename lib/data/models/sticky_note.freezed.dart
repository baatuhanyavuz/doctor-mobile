// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sticky_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StickyNote _$StickyNoteFromJson(Map<String, dynamic> json) {
  return _StickyNote.fromJson(json);
}

/// @nodoc
mixin _$StickyNote {
  /// Benzersiz not ID'si
  String get id => throw _privateConstructorUsedError;

  /// Not metni
  String get text => throw _privateConstructorUsedError;

  /// Not rengi (hex değeri)
  int get color => throw _privateConstructorUsedError; // Sarı
  /// Panodaki X koordinatı
  double get x => throw _privateConstructorUsedError;

  /// Panodaki Y koordinatı
  double get y => throw _privateConstructorUsedError;

  /// Oluşturulma tarihi
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StickyNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StickyNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StickyNoteCopyWith<StickyNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StickyNoteCopyWith<$Res> {
  factory $StickyNoteCopyWith(
    StickyNote value,
    $Res Function(StickyNote) then,
  ) = _$StickyNoteCopyWithImpl<$Res, StickyNote>;
  @useResult
  $Res call({
    String id,
    String text,
    int color,
    double x,
    double y,
    String? createdAt,
  });
}

/// @nodoc
class _$StickyNoteCopyWithImpl<$Res, $Val extends StickyNote>
    implements $StickyNoteCopyWith<$Res> {
  _$StickyNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StickyNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? color = null,
    Object? x = null,
    Object? y = null,
    Object? createdAt = freezed,
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
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as int,
            x: null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                      as double,
            y: null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StickyNoteImplCopyWith<$Res>
    implements $StickyNoteCopyWith<$Res> {
  factory _$$StickyNoteImplCopyWith(
    _$StickyNoteImpl value,
    $Res Function(_$StickyNoteImpl) then,
  ) = __$$StickyNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    int color,
    double x,
    double y,
    String? createdAt,
  });
}

/// @nodoc
class __$$StickyNoteImplCopyWithImpl<$Res>
    extends _$StickyNoteCopyWithImpl<$Res, _$StickyNoteImpl>
    implements _$$StickyNoteImplCopyWith<$Res> {
  __$$StickyNoteImplCopyWithImpl(
    _$StickyNoteImpl _value,
    $Res Function(_$StickyNoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StickyNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? color = null,
    Object? x = null,
    Object? y = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$StickyNoteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as int,
        x: null == x
            ? _value.x
            : x // ignore: cast_nullable_to_non_nullable
                  as double,
        y: null == y
            ? _value.y
            : y // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StickyNoteImpl implements _StickyNote {
  const _$StickyNoteImpl({
    required this.id,
    required this.text,
    this.color = 0xFFFFF9C4,
    this.x = 100,
    this.y = 100,
    this.createdAt,
  });

  factory _$StickyNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$StickyNoteImplFromJson(json);

  /// Benzersiz not ID'si
  @override
  final String id;

  /// Not metni
  @override
  final String text;

  /// Not rengi (hex değeri)
  @override
  @JsonKey()
  final int color;
  // Sarı
  /// Panodaki X koordinatı
  @override
  @JsonKey()
  final double x;

  /// Panodaki Y koordinatı
  @override
  @JsonKey()
  final double y;

  /// Oluşturulma tarihi
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'StickyNote(id: $id, text: $text, color: $color, x: $x, y: $y, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StickyNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, text, color, x, y, createdAt);

  /// Create a copy of StickyNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StickyNoteImplCopyWith<_$StickyNoteImpl> get copyWith =>
      __$$StickyNoteImplCopyWithImpl<_$StickyNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StickyNoteImplToJson(this);
  }
}

abstract class _StickyNote implements StickyNote {
  const factory _StickyNote({
    required final String id,
    required final String text,
    final int color,
    final double x,
    final double y,
    final String? createdAt,
  }) = _$StickyNoteImpl;

  factory _StickyNote.fromJson(Map<String, dynamic> json) =
      _$StickyNoteImpl.fromJson;

  /// Benzersiz not ID'si
  @override
  String get id;

  /// Not metni
  @override
  String get text;

  /// Not rengi (hex değeri)
  @override
  int get color; // Sarı
  /// Panodaki X koordinatı
  @override
  double get x;

  /// Panodaki Y koordinatı
  @override
  double get y;

  /// Oluşturulma tarihi
  @override
  String? get createdAt;

  /// Create a copy of StickyNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StickyNoteImplCopyWith<_$StickyNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
