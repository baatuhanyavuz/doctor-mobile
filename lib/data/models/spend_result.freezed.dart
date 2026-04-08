// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spend_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SpendResult _$SpendResultFromJson(Map<String, dynamic> json) {
  return _SpendResult.fromJson(json);
}

/// @nodoc
mixin _$SpendResult {
  bool get success => throw _privateConstructorUsedError;
  int get creditsSpent => throw _privateConstructorUsedError;
  int get newBalance => throw _privateConstructorUsedError;
  int get transactionId => throw _privateConstructorUsedError;

  /// Serializes this SpendResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpendResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpendResultCopyWith<SpendResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpendResultCopyWith<$Res> {
  factory $SpendResultCopyWith(
    SpendResult value,
    $Res Function(SpendResult) then,
  ) = _$SpendResultCopyWithImpl<$Res, SpendResult>;
  @useResult
  $Res call({
    bool success,
    int creditsSpent,
    int newBalance,
    int transactionId,
  });
}

/// @nodoc
class _$SpendResultCopyWithImpl<$Res, $Val extends SpendResult>
    implements $SpendResultCopyWith<$Res> {
  _$SpendResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpendResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? creditsSpent = null,
    Object? newBalance = null,
    Object? transactionId = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            creditsSpent: null == creditsSpent
                ? _value.creditsSpent
                : creditsSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            newBalance: null == newBalance
                ? _value.newBalance
                : newBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpendResultImplCopyWith<$Res>
    implements $SpendResultCopyWith<$Res> {
  factory _$$SpendResultImplCopyWith(
    _$SpendResultImpl value,
    $Res Function(_$SpendResultImpl) then,
  ) = __$$SpendResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    int creditsSpent,
    int newBalance,
    int transactionId,
  });
}

/// @nodoc
class __$$SpendResultImplCopyWithImpl<$Res>
    extends _$SpendResultCopyWithImpl<$Res, _$SpendResultImpl>
    implements _$$SpendResultImplCopyWith<$Res> {
  __$$SpendResultImplCopyWithImpl(
    _$SpendResultImpl _value,
    $Res Function(_$SpendResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpendResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? creditsSpent = null,
    Object? newBalance = null,
    Object? transactionId = null,
  }) {
    return _then(
      _$SpendResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        creditsSpent: null == creditsSpent
            ? _value.creditsSpent
            : creditsSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        newBalance: null == newBalance
            ? _value.newBalance
            : newBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpendResultImpl implements _SpendResult {
  const _$SpendResultImpl({
    this.success = false,
    this.creditsSpent = 0,
    this.newBalance = 0,
    this.transactionId = 0,
  });

  factory _$SpendResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpendResultImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final int creditsSpent;
  @override
  @JsonKey()
  final int newBalance;
  @override
  @JsonKey()
  final int transactionId;

  @override
  String toString() {
    return 'SpendResult(success: $success, creditsSpent: $creditsSpent, newBalance: $newBalance, transactionId: $transactionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpendResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.creditsSpent, creditsSpent) ||
                other.creditsSpent == creditsSpent) &&
            (identical(other.newBalance, newBalance) ||
                other.newBalance == newBalance) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    creditsSpent,
    newBalance,
    transactionId,
  );

  /// Create a copy of SpendResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpendResultImplCopyWith<_$SpendResultImpl> get copyWith =>
      __$$SpendResultImplCopyWithImpl<_$SpendResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpendResultImplToJson(this);
  }
}

abstract class _SpendResult implements SpendResult {
  const factory _SpendResult({
    final bool success,
    final int creditsSpent,
    final int newBalance,
    final int transactionId,
  }) = _$SpendResultImpl;

  factory _SpendResult.fromJson(Map<String, dynamic> json) =
      _$SpendResultImpl.fromJson;

  @override
  bool get success;
  @override
  int get creditsSpent;
  @override
  int get newBalance;
  @override
  int get transactionId;

  /// Create a copy of SpendResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpendResultImplCopyWith<_$SpendResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
