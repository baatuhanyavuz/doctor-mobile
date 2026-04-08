// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActiveSubscription _$ActiveSubscriptionFromJson(Map<String, dynamic> json) {
  return _ActiveSubscription.fromJson(json);
}

/// @nodoc
mixin _$ActiveSubscription {
  int get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  int get planId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get startedAt => throw _privateConstructorUsedError;
  String? get expiresAt => throw _privateConstructorUsedError;
  String? get cancelledAt => throw _privateConstructorUsedError;
  String? get planName => throw _privateConstructorUsedError;
  String? get period => throw _privateConstructorUsedError;
  bool get isAdFree => throw _privateConstructorUsedError;
  bool get hasBadge => throw _privateConstructorUsedError;
  bool get hasPriorityAccess => throw _privateConstructorUsedError;

  /// Serializes this ActiveSubscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveSubscriptionCopyWith<ActiveSubscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSubscriptionCopyWith<$Res> {
  factory $ActiveSubscriptionCopyWith(
    ActiveSubscription value,
    $Res Function(ActiveSubscription) then,
  ) = _$ActiveSubscriptionCopyWithImpl<$Res, ActiveSubscription>;
  @useResult
  $Res call({
    int id,
    String userId,
    int planId,
    String status,
    String? startedAt,
    String? expiresAt,
    String? cancelledAt,
    String? planName,
    String? period,
    bool isAdFree,
    bool hasBadge,
    bool hasPriorityAccess,
  });
}

/// @nodoc
class _$ActiveSubscriptionCopyWithImpl<$Res, $Val extends ActiveSubscription>
    implements $ActiveSubscriptionCopyWith<$Res> {
  _$ActiveSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? expiresAt = freezed,
    Object? cancelledAt = freezed,
    Object? planName = freezed,
    Object? period = freezed,
    Object? isAdFree = null,
    Object? hasBadge = null,
    Object? hasPriorityAccess = null,
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
            planId: null == planId
                ? _value.planId
                : planId // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            planName: freezed == planName
                ? _value.planName
                : planName // ignore: cast_nullable_to_non_nullable
                      as String?,
            period: freezed == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAdFree: null == isAdFree
                ? _value.isAdFree
                : isAdFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasBadge: null == hasBadge
                ? _value.hasBadge
                : hasBadge // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasPriorityAccess: null == hasPriorityAccess
                ? _value.hasPriorityAccess
                : hasPriorityAccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActiveSubscriptionImplCopyWith<$Res>
    implements $ActiveSubscriptionCopyWith<$Res> {
  factory _$$ActiveSubscriptionImplCopyWith(
    _$ActiveSubscriptionImpl value,
    $Res Function(_$ActiveSubscriptionImpl) then,
  ) = __$$ActiveSubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String userId,
    int planId,
    String status,
    String? startedAt,
    String? expiresAt,
    String? cancelledAt,
    String? planName,
    String? period,
    bool isAdFree,
    bool hasBadge,
    bool hasPriorityAccess,
  });
}

/// @nodoc
class __$$ActiveSubscriptionImplCopyWithImpl<$Res>
    extends _$ActiveSubscriptionCopyWithImpl<$Res, _$ActiveSubscriptionImpl>
    implements _$$ActiveSubscriptionImplCopyWith<$Res> {
  __$$ActiveSubscriptionImplCopyWithImpl(
    _$ActiveSubscriptionImpl _value,
    $Res Function(_$ActiveSubscriptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? planId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? expiresAt = freezed,
    Object? cancelledAt = freezed,
    Object? planName = freezed,
    Object? period = freezed,
    Object? isAdFree = null,
    Object? hasBadge = null,
    Object? hasPriorityAccess = null,
  }) {
    return _then(
      _$ActiveSubscriptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        planId: null == planId
            ? _value.planId
            : planId // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        planName: freezed == planName
            ? _value.planName
            : planName // ignore: cast_nullable_to_non_nullable
                  as String?,
        period: freezed == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAdFree: null == isAdFree
            ? _value.isAdFree
            : isAdFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasBadge: null == hasBadge
            ? _value.hasBadge
            : hasBadge // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasPriorityAccess: null == hasPriorityAccess
            ? _value.hasPriorityAccess
            : hasPriorityAccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveSubscriptionImpl implements _ActiveSubscription {
  const _$ActiveSubscriptionImpl({
    this.id = 0,
    this.userId = '',
    this.planId = 0,
    this.status = 'active',
    this.startedAt,
    this.expiresAt,
    this.cancelledAt,
    this.planName,
    this.period,
    this.isAdFree = false,
    this.hasBadge = false,
    this.hasPriorityAccess = false,
  });

  factory _$ActiveSubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveSubscriptionImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final int planId;
  @override
  @JsonKey()
  final String status;
  @override
  final String? startedAt;
  @override
  final String? expiresAt;
  @override
  final String? cancelledAt;
  @override
  final String? planName;
  @override
  final String? period;
  @override
  @JsonKey()
  final bool isAdFree;
  @override
  @JsonKey()
  final bool hasBadge;
  @override
  @JsonKey()
  final bool hasPriorityAccess;

  @override
  String toString() {
    return 'ActiveSubscription(id: $id, userId: $userId, planId: $planId, status: $status, startedAt: $startedAt, expiresAt: $expiresAt, cancelledAt: $cancelledAt, planName: $planName, period: $period, isAdFree: $isAdFree, hasBadge: $hasBadge, hasPriorityAccess: $hasPriorityAccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.isAdFree, isAdFree) ||
                other.isAdFree == isAdFree) &&
            (identical(other.hasBadge, hasBadge) ||
                other.hasBadge == hasBadge) &&
            (identical(other.hasPriorityAccess, hasPriorityAccess) ||
                other.hasPriorityAccess == hasPriorityAccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    planId,
    status,
    startedAt,
    expiresAt,
    cancelledAt,
    planName,
    period,
    isAdFree,
    hasBadge,
    hasPriorityAccess,
  );

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      __$$ActiveSubscriptionImplCopyWithImpl<_$ActiveSubscriptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveSubscriptionImplToJson(this);
  }
}

abstract class _ActiveSubscription implements ActiveSubscription {
  const factory _ActiveSubscription({
    final int id,
    final String userId,
    final int planId,
    final String status,
    final String? startedAt,
    final String? expiresAt,
    final String? cancelledAt,
    final String? planName,
    final String? period,
    final bool isAdFree,
    final bool hasBadge,
    final bool hasPriorityAccess,
  }) = _$ActiveSubscriptionImpl;

  factory _ActiveSubscription.fromJson(Map<String, dynamic> json) =
      _$ActiveSubscriptionImpl.fromJson;

  @override
  int get id;
  @override
  String get userId;
  @override
  int get planId;
  @override
  String get status;
  @override
  String? get startedAt;
  @override
  String? get expiresAt;
  @override
  String? get cancelledAt;
  @override
  String? get planName;
  @override
  String? get period;
  @override
  bool get isAdFree;
  @override
  bool get hasBadge;
  @override
  bool get hasPriorityAccess;

  /// Create a copy of ActiveSubscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveSubscriptionImplCopyWith<_$ActiveSubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
