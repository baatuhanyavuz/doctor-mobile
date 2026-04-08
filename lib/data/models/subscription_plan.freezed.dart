// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) {
  return _SubscriptionPlan.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPlan {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get priceTl => throw _privateConstructorUsedError;
  int get creditsPerPeriod => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  int get bonusCredits => throw _privateConstructorUsedError;
  bool get isAdFree => throw _privateConstructorUsedError;
  bool get hasBadge => throw _privateConstructorUsedError;
  bool get hasPriorityAccess => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
    SubscriptionPlan value,
    $Res Function(SubscriptionPlan) then,
  ) = _$SubscriptionPlanCopyWithImpl<$Res, SubscriptionPlan>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double priceTl,
    int creditsPerPeriod,
    String period,
    int bonusCredits,
    bool isAdFree,
    bool hasBadge,
    bool hasPriorityAccess,
    bool isActive,
    int sortOrder,
  });
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res, $Val extends SubscriptionPlan>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceTl = null,
    Object? creditsPerPeriod = null,
    Object? period = null,
    Object? bonusCredits = null,
    Object? isAdFree = null,
    Object? hasBadge = null,
    Object? hasPriorityAccess = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceTl: null == priceTl
                ? _value.priceTl
                : priceTl // ignore: cast_nullable_to_non_nullable
                      as double,
            creditsPerPeriod: null == creditsPerPeriod
                ? _value.creditsPerPeriod
                : creditsPerPeriod // ignore: cast_nullable_to_non_nullable
                      as int,
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as String,
            bonusCredits: null == bonusCredits
                ? _value.bonusCredits
                : bonusCredits // ignore: cast_nullable_to_non_nullable
                      as int,
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
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubscriptionPlanImplCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$$SubscriptionPlanImplCopyWith(
    _$SubscriptionPlanImpl value,
    $Res Function(_$SubscriptionPlanImpl) then,
  ) = __$$SubscriptionPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double priceTl,
    int creditsPerPeriod,
    String period,
    int bonusCredits,
    bool isAdFree,
    bool hasBadge,
    bool hasPriorityAccess,
    bool isActive,
    int sortOrder,
  });
}

/// @nodoc
class __$$SubscriptionPlanImplCopyWithImpl<$Res>
    extends _$SubscriptionPlanCopyWithImpl<$Res, _$SubscriptionPlanImpl>
    implements _$$SubscriptionPlanImplCopyWith<$Res> {
  __$$SubscriptionPlanImplCopyWithImpl(
    _$SubscriptionPlanImpl _value,
    $Res Function(_$SubscriptionPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceTl = null,
    Object? creditsPerPeriod = null,
    Object? period = null,
    Object? bonusCredits = null,
    Object? isAdFree = null,
    Object? hasBadge = null,
    Object? hasPriorityAccess = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$SubscriptionPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceTl: null == priceTl
            ? _value.priceTl
            : priceTl // ignore: cast_nullable_to_non_nullable
                  as double,
        creditsPerPeriod: null == creditsPerPeriod
            ? _value.creditsPerPeriod
            : creditsPerPeriod // ignore: cast_nullable_to_non_nullable
                  as int,
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as String,
        bonusCredits: null == bonusCredits
            ? _value.bonusCredits
            : bonusCredits // ignore: cast_nullable_to_non_nullable
                  as int,
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
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionPlanImpl implements _SubscriptionPlan {
  const _$SubscriptionPlanImpl({
    this.id = 0,
    this.name = '',
    this.description,
    this.priceTl = 0,
    this.creditsPerPeriod = 0,
    this.period = 'monthly',
    this.bonusCredits = 0,
    this.isAdFree = false,
    this.hasBadge = false,
    this.hasPriorityAccess = false,
    this.isActive = true,
    this.sortOrder = 0,
  });

  factory _$SubscriptionPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionPlanImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? description;
  @override
  @JsonKey()
  final double priceTl;
  @override
  @JsonKey()
  final int creditsPerPeriod;
  @override
  @JsonKey()
  final String period;
  @override
  @JsonKey()
  final int bonusCredits;
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
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, name: $name, description: $description, priceTl: $priceTl, creditsPerPeriod: $creditsPerPeriod, period: $period, bonusCredits: $bonusCredits, isAdFree: $isAdFree, hasBadge: $hasBadge, hasPriorityAccess: $hasPriorityAccess, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceTl, priceTl) || other.priceTl == priceTl) &&
            (identical(other.creditsPerPeriod, creditsPerPeriod) ||
                other.creditsPerPeriod == creditsPerPeriod) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.bonusCredits, bonusCredits) ||
                other.bonusCredits == bonusCredits) &&
            (identical(other.isAdFree, isAdFree) ||
                other.isAdFree == isAdFree) &&
            (identical(other.hasBadge, hasBadge) ||
                other.hasBadge == hasBadge) &&
            (identical(other.hasPriorityAccess, hasPriorityAccess) ||
                other.hasPriorityAccess == hasPriorityAccess) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    priceTl,
    creditsPerPeriod,
    period,
    bonusCredits,
    isAdFree,
    hasBadge,
    hasPriorityAccess,
    isActive,
    sortOrder,
  );

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      __$$SubscriptionPlanImplCopyWithImpl<_$SubscriptionPlanImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionPlanImplToJson(this);
  }
}

abstract class _SubscriptionPlan implements SubscriptionPlan {
  const factory _SubscriptionPlan({
    final int id,
    final String name,
    final String? description,
    final double priceTl,
    final int creditsPerPeriod,
    final String period,
    final int bonusCredits,
    final bool isAdFree,
    final bool hasBadge,
    final bool hasPriorityAccess,
    final bool isActive,
    final int sortOrder,
  }) = _$SubscriptionPlanImpl;

  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$SubscriptionPlanImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get priceTl;
  @override
  int get creditsPerPeriod;
  @override
  String get period;
  @override
  int get bonusCredits;
  @override
  bool get isAdFree;
  @override
  bool get hasBadge;
  @override
  bool get hasPriorityAccess;
  @override
  bool get isActive;
  @override
  int get sortOrder;

  /// Create a copy of SubscriptionPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionPlanImplCopyWith<_$SubscriptionPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
