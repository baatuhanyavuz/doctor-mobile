// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mystery_box_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MysteryBoxResult _$MysteryBoxResultFromJson(Map<String, dynamic> json) {
  return _MysteryBoxResult.fromJson(json);
}

/// @nodoc
mixin _$MysteryBoxResult {
  int get creditsEarned => throw _privateConstructorUsedError;
  int get newBalance => throw _privateConstructorUsedError;
  String get rarity => throw _privateConstructorUsedError;

  /// Serializes this MysteryBoxResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MysteryBoxResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MysteryBoxResultCopyWith<MysteryBoxResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MysteryBoxResultCopyWith<$Res> {
  factory $MysteryBoxResultCopyWith(
    MysteryBoxResult value,
    $Res Function(MysteryBoxResult) then,
  ) = _$MysteryBoxResultCopyWithImpl<$Res, MysteryBoxResult>;
  @useResult
  $Res call({int creditsEarned, int newBalance, String rarity});
}

/// @nodoc
class _$MysteryBoxResultCopyWithImpl<$Res, $Val extends MysteryBoxResult>
    implements $MysteryBoxResultCopyWith<$Res> {
  _$MysteryBoxResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MysteryBoxResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditsEarned = null,
    Object? newBalance = null,
    Object? rarity = null,
  }) {
    return _then(
      _value.copyWith(
            creditsEarned: null == creditsEarned
                ? _value.creditsEarned
                : creditsEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            newBalance: null == newBalance
                ? _value.newBalance
                : newBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            rarity: null == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MysteryBoxResultImplCopyWith<$Res>
    implements $MysteryBoxResultCopyWith<$Res> {
  factory _$$MysteryBoxResultImplCopyWith(
    _$MysteryBoxResultImpl value,
    $Res Function(_$MysteryBoxResultImpl) then,
  ) = __$$MysteryBoxResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int creditsEarned, int newBalance, String rarity});
}

/// @nodoc
class __$$MysteryBoxResultImplCopyWithImpl<$Res>
    extends _$MysteryBoxResultCopyWithImpl<$Res, _$MysteryBoxResultImpl>
    implements _$$MysteryBoxResultImplCopyWith<$Res> {
  __$$MysteryBoxResultImplCopyWithImpl(
    _$MysteryBoxResultImpl _value,
    $Res Function(_$MysteryBoxResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MysteryBoxResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? creditsEarned = null,
    Object? newBalance = null,
    Object? rarity = null,
  }) {
    return _then(
      _$MysteryBoxResultImpl(
        creditsEarned: null == creditsEarned
            ? _value.creditsEarned
            : creditsEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        newBalance: null == newBalance
            ? _value.newBalance
            : newBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        rarity: null == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MysteryBoxResultImpl implements _MysteryBoxResult {
  const _$MysteryBoxResultImpl({
    this.creditsEarned = 0,
    this.newBalance = 0,
    this.rarity = 'common',
  });

  factory _$MysteryBoxResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MysteryBoxResultImplFromJson(json);

  @override
  @JsonKey()
  final int creditsEarned;
  @override
  @JsonKey()
  final int newBalance;
  @override
  @JsonKey()
  final String rarity;

  @override
  String toString() {
    return 'MysteryBoxResult(creditsEarned: $creditsEarned, newBalance: $newBalance, rarity: $rarity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MysteryBoxResultImpl &&
            (identical(other.creditsEarned, creditsEarned) ||
                other.creditsEarned == creditsEarned) &&
            (identical(other.newBalance, newBalance) ||
                other.newBalance == newBalance) &&
            (identical(other.rarity, rarity) || other.rarity == rarity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, creditsEarned, newBalance, rarity);

  /// Create a copy of MysteryBoxResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MysteryBoxResultImplCopyWith<_$MysteryBoxResultImpl> get copyWith =>
      __$$MysteryBoxResultImplCopyWithImpl<_$MysteryBoxResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MysteryBoxResultImplToJson(this);
  }
}

abstract class _MysteryBoxResult implements MysteryBoxResult {
  const factory _MysteryBoxResult({
    final int creditsEarned,
    final int newBalance,
    final String rarity,
  }) = _$MysteryBoxResultImpl;

  factory _MysteryBoxResult.fromJson(Map<String, dynamic> json) =
      _$MysteryBoxResultImpl.fromJson;

  @override
  int get creditsEarned;
  @override
  int get newBalance;
  @override
  String get rarity;

  /// Create a copy of MysteryBoxResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MysteryBoxResultImplCopyWith<_$MysteryBoxResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
