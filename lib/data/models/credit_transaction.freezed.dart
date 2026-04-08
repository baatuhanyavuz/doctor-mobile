// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreditTransaction _$CreditTransactionFromJson(Map<String, dynamic> json) {
  return _CreditTransaction.fromJson(json);
}

/// @nodoc
mixin _$CreditTransaction {
  int get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get balanceAfter => throw _privateConstructorUsedError;
  String get transactionType => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CreditTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditTransactionCopyWith<CreditTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditTransactionCopyWith<$Res> {
  factory $CreditTransactionCopyWith(
    CreditTransaction value,
    $Res Function(CreditTransaction) then,
  ) = _$CreditTransactionCopyWithImpl<$Res, CreditTransaction>;
  @useResult
  $Res call({
    int id,
    String userId,
    int amount,
    int balanceAfter,
    String transactionType,
    String? source,
    String? referenceId,
    String? description,
    String? createdAt,
  });
}

/// @nodoc
class _$CreditTransactionCopyWithImpl<$Res, $Val extends CreditTransaction>
    implements $CreditTransactionCopyWith<$Res> {
  _$CreditTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? transactionType = null,
    Object? source = freezed,
    Object? referenceId = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as int,
            transactionType: null == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                      as String,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CreditTransactionImplCopyWith<$Res>
    implements $CreditTransactionCopyWith<$Res> {
  factory _$$CreditTransactionImplCopyWith(
    _$CreditTransactionImpl value,
    $Res Function(_$CreditTransactionImpl) then,
  ) = __$$CreditTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String userId,
    int amount,
    int balanceAfter,
    String transactionType,
    String? source,
    String? referenceId,
    String? description,
    String? createdAt,
  });
}

/// @nodoc
class __$$CreditTransactionImplCopyWithImpl<$Res>
    extends _$CreditTransactionCopyWithImpl<$Res, _$CreditTransactionImpl>
    implements _$$CreditTransactionImplCopyWith<$Res> {
  __$$CreditTransactionImplCopyWithImpl(
    _$CreditTransactionImpl _value,
    $Res Function(_$CreditTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? balanceAfter = null,
    Object? transactionType = null,
    Object? source = freezed,
    Object? referenceId = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CreditTransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as int,
        transactionType: null == transactionType
            ? _value.transactionType
            : transactionType // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$CreditTransactionImpl implements _CreditTransaction {
  const _$CreditTransactionImpl({
    this.id = 0,
    this.userId = '',
    this.amount = 0,
    this.balanceAfter = 0,
    this.transactionType = '',
    this.source,
    this.referenceId,
    this.description,
    this.createdAt,
  });

  factory _$CreditTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditTransactionImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final int balanceAfter;
  @override
  @JsonKey()
  final String transactionType;
  @override
  final String? source;
  @override
  final String? referenceId;
  @override
  final String? description;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'CreditTransaction(id: $id, userId: $userId, amount: $amount, balanceAfter: $balanceAfter, transactionType: $transactionType, source: $source, referenceId: $referenceId, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    amount,
    balanceAfter,
    transactionType,
    source,
    referenceId,
    description,
    createdAt,
  );

  /// Create a copy of CreditTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditTransactionImplCopyWith<_$CreditTransactionImpl> get copyWith =>
      __$$CreditTransactionImplCopyWithImpl<_$CreditTransactionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditTransactionImplToJson(this);
  }
}

abstract class _CreditTransaction implements CreditTransaction {
  const factory _CreditTransaction({
    final int id,
    final String userId,
    final int amount,
    final int balanceAfter,
    final String transactionType,
    final String? source,
    final String? referenceId,
    final String? description,
    final String? createdAt,
  }) = _$CreditTransactionImpl;

  factory _CreditTransaction.fromJson(Map<String, dynamic> json) =
      _$CreditTransactionImpl.fromJson;

  @override
  int get id;
  @override
  String get userId;
  @override
  int get amount;
  @override
  int get balanceAfter;
  @override
  String get transactionType;
  @override
  String? get source;
  @override
  String? get referenceId;
  @override
  String? get description;
  @override
  String? get createdAt;

  /// Create a copy of CreditTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditTransactionImplCopyWith<_$CreditTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
