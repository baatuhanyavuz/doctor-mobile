// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreditBalance _$CreditBalanceFromJson(Map<String, dynamic> json) {
  return _CreditBalance.fromJson(json);
}

/// @nodoc
mixin _$CreditBalance {
  int get balance => throw _privateConstructorUsedError;
  int get totalEarned => throw _privateConstructorUsedError;
  int get totalSpent => throw _privateConstructorUsedError;
  bool get hasActiveSubscription => throw _privateConstructorUsedError;
  String? get subscriptionPlanName => throw _privateConstructorUsedError;

  /// Serializes this CreditBalance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditBalanceCopyWith<CreditBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditBalanceCopyWith<$Res> {
  factory $CreditBalanceCopyWith(
    CreditBalance value,
    $Res Function(CreditBalance) then,
  ) = _$CreditBalanceCopyWithImpl<$Res, CreditBalance>;
  @useResult
  $Res call({
    int balance,
    int totalEarned,
    int totalSpent,
    bool hasActiveSubscription,
    String? subscriptionPlanName,
  });
}

/// @nodoc
class _$CreditBalanceCopyWithImpl<$Res, $Val extends CreditBalance>
    implements $CreditBalanceCopyWith<$Res> {
  _$CreditBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? hasActiveSubscription = null,
    Object? subscriptionPlanName = freezed,
  }) {
    return _then(
      _value.copyWith(
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as int,
            totalEarned: null == totalEarned
                ? _value.totalEarned
                : totalEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            totalSpent: null == totalSpent
                ? _value.totalSpent
                : totalSpent // ignore: cast_nullable_to_non_nullable
                      as int,
            hasActiveSubscription: null == hasActiveSubscription
                ? _value.hasActiveSubscription
                : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
                      as bool,
            subscriptionPlanName: freezed == subscriptionPlanName
                ? _value.subscriptionPlanName
                : subscriptionPlanName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditBalanceImplCopyWith<$Res>
    implements $CreditBalanceCopyWith<$Res> {
  factory _$$CreditBalanceImplCopyWith(
    _$CreditBalanceImpl value,
    $Res Function(_$CreditBalanceImpl) then,
  ) = __$$CreditBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int balance,
    int totalEarned,
    int totalSpent,
    bool hasActiveSubscription,
    String? subscriptionPlanName,
  });
}

/// @nodoc
class __$$CreditBalanceImplCopyWithImpl<$Res>
    extends _$CreditBalanceCopyWithImpl<$Res, _$CreditBalanceImpl>
    implements _$$CreditBalanceImplCopyWith<$Res> {
  __$$CreditBalanceImplCopyWithImpl(
    _$CreditBalanceImpl _value,
    $Res Function(_$CreditBalanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? totalEarned = null,
    Object? totalSpent = null,
    Object? hasActiveSubscription = null,
    Object? subscriptionPlanName = freezed,
  }) {
    return _then(
      _$CreditBalanceImpl(
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as int,
        totalEarned: null == totalEarned
            ? _value.totalEarned
            : totalEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        totalSpent: null == totalSpent
            ? _value.totalSpent
            : totalSpent // ignore: cast_nullable_to_non_nullable
                  as int,
        hasActiveSubscription: null == hasActiveSubscription
            ? _value.hasActiveSubscription
            : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
                  as bool,
        subscriptionPlanName: freezed == subscriptionPlanName
            ? _value.subscriptionPlanName
            : subscriptionPlanName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditBalanceImpl implements _CreditBalance {
  const _$CreditBalanceImpl({
    this.balance = 0,
    this.totalEarned = 0,
    this.totalSpent = 0,
    this.hasActiveSubscription = false,
    this.subscriptionPlanName,
  });

  factory _$CreditBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditBalanceImplFromJson(json);

  @override
  @JsonKey()
  final int balance;
  @override
  @JsonKey()
  final int totalEarned;
  @override
  @JsonKey()
  final int totalSpent;
  @override
  @JsonKey()
  final bool hasActiveSubscription;
  @override
  final String? subscriptionPlanName;

  @override
  String toString() {
    return 'CreditBalance(balance: $balance, totalEarned: $totalEarned, totalSpent: $totalSpent, hasActiveSubscription: $hasActiveSubscription, subscriptionPlanName: $subscriptionPlanName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditBalanceImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.totalEarned, totalEarned) ||
                other.totalEarned == totalEarned) &&
            (identical(other.totalSpent, totalSpent) ||
                other.totalSpent == totalSpent) &&
            (identical(other.hasActiveSubscription, hasActiveSubscription) ||
                other.hasActiveSubscription == hasActiveSubscription) &&
            (identical(other.subscriptionPlanName, subscriptionPlanName) ||
                other.subscriptionPlanName == subscriptionPlanName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    balance,
    totalEarned,
    totalSpent,
    hasActiveSubscription,
    subscriptionPlanName,
  );

  /// Create a copy of CreditBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditBalanceImplCopyWith<_$CreditBalanceImpl> get copyWith =>
      __$$CreditBalanceImplCopyWithImpl<_$CreditBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditBalanceImplToJson(this);
  }
}

abstract class _CreditBalance implements CreditBalance {
  const factory _CreditBalance({
    final int balance,
    final int totalEarned,
    final int totalSpent,
    final bool hasActiveSubscription,
    final String? subscriptionPlanName,
  }) = _$CreditBalanceImpl;

  factory _CreditBalance.fromJson(Map<String, dynamic> json) =
      _$CreditBalanceImpl.fromJson;

  @override
  int get balance;
  @override
  int get totalEarned;
  @override
  int get totalSpent;
  @override
  bool get hasActiveSubscription;
  @override
  String? get subscriptionPlanName;

  /// Create a copy of CreditBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditBalanceImplCopyWith<_$CreditBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
