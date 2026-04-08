// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CreditPackage _$CreditPackageFromJson(Map<String, dynamic> json) {
  return _CreditPackage.fromJson(json);
}

/// @nodoc
mixin _$CreditPackage {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get priceTl => throw _privateConstructorUsedError;
  int get baseCredits => throw _privateConstructorUsedError;
  int get bonusCredits => throw _privateConstructorUsedError;
  int get totalCredits => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this CreditPackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditPackageCopyWith<CreditPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditPackageCopyWith<$Res> {
  factory $CreditPackageCopyWith(
    CreditPackage value,
    $Res Function(CreditPackage) then,
  ) = _$CreditPackageCopyWithImpl<$Res, CreditPackage>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double priceTl,
    int baseCredits,
    int bonusCredits,
    int totalCredits,
    bool isActive,
    int sortOrder,
  });
}

/// @nodoc
class _$CreditPackageCopyWithImpl<$Res, $Val extends CreditPackage>
    implements $CreditPackageCopyWith<$Res> {
  _$CreditPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceTl = null,
    Object? baseCredits = null,
    Object? bonusCredits = null,
    Object? totalCredits = null,
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
            baseCredits: null == baseCredits
                ? _value.baseCredits
                : baseCredits // ignore: cast_nullable_to_non_nullable
                      as int,
            bonusCredits: null == bonusCredits
                ? _value.bonusCredits
                : bonusCredits // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCredits: null == totalCredits
                ? _value.totalCredits
                : totalCredits // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$CreditPackageImplCopyWith<$Res>
    implements $CreditPackageCopyWith<$Res> {
  factory _$$CreditPackageImplCopyWith(
    _$CreditPackageImpl value,
    $Res Function(_$CreditPackageImpl) then,
  ) = __$$CreditPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    double priceTl,
    int baseCredits,
    int bonusCredits,
    int totalCredits,
    bool isActive,
    int sortOrder,
  });
}

/// @nodoc
class __$$CreditPackageImplCopyWithImpl<$Res>
    extends _$CreditPackageCopyWithImpl<$Res, _$CreditPackageImpl>
    implements _$$CreditPackageImplCopyWith<$Res> {
  __$$CreditPackageImplCopyWithImpl(
    _$CreditPackageImpl _value,
    $Res Function(_$CreditPackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceTl = null,
    Object? baseCredits = null,
    Object? bonusCredits = null,
    Object? totalCredits = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$CreditPackageImpl(
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
        baseCredits: null == baseCredits
            ? _value.baseCredits
            : baseCredits // ignore: cast_nullable_to_non_nullable
                  as int,
        bonusCredits: null == bonusCredits
            ? _value.bonusCredits
            : bonusCredits // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCredits: null == totalCredits
            ? _value.totalCredits
            : totalCredits // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$CreditPackageImpl implements _CreditPackage {
  const _$CreditPackageImpl({
    this.id = 0,
    this.name = '',
    this.description,
    this.priceTl = 0,
    this.baseCredits = 0,
    this.bonusCredits = 0,
    this.totalCredits = 0,
    this.isActive = true,
    this.sortOrder = 0,
  });

  factory _$CreditPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditPackageImplFromJson(json);

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
  final int baseCredits;
  @override
  @JsonKey()
  final int bonusCredits;
  @override
  @JsonKey()
  final int totalCredits;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'CreditPackage(id: $id, name: $name, description: $description, priceTl: $priceTl, baseCredits: $baseCredits, bonusCredits: $bonusCredits, totalCredits: $totalCredits, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditPackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceTl, priceTl) || other.priceTl == priceTl) &&
            (identical(other.baseCredits, baseCredits) ||
                other.baseCredits == baseCredits) &&
            (identical(other.bonusCredits, bonusCredits) ||
                other.bonusCredits == bonusCredits) &&
            (identical(other.totalCredits, totalCredits) ||
                other.totalCredits == totalCredits) &&
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
    baseCredits,
    bonusCredits,
    totalCredits,
    isActive,
    sortOrder,
  );

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditPackageImplCopyWith<_$CreditPackageImpl> get copyWith =>
      __$$CreditPackageImplCopyWithImpl<_$CreditPackageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditPackageImplToJson(this);
  }
}

abstract class _CreditPackage implements CreditPackage {
  const factory _CreditPackage({
    final int id,
    final String name,
    final String? description,
    final double priceTl,
    final int baseCredits,
    final int bonusCredits,
    final int totalCredits,
    final bool isActive,
    final int sortOrder,
  }) = _$CreditPackageImpl;

  factory _CreditPackage.fromJson(Map<String, dynamic> json) =
      _$CreditPackageImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  double get priceTl;
  @override
  int get baseCredits;
  @override
  int get bonusCredits;
  @override
  int get totalCredits;
  @override
  bool get isActive;
  @override
  int get sortOrder;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditPackageImplCopyWith<_$CreditPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
