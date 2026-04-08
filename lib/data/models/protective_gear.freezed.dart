// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protective_gear.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InfectionRisk _$InfectionRiskFromJson(Map<String, dynamic> json) {
  return _InfectionRisk.fromJson(json);
}

/// @nodoc
mixin _$InfectionRisk {
  /// Bulaş riski seviyesi
  InfectionRiskLevel get level => throw _privateConstructorUsedError;

  /// Bulaş tipi açıklaması (ör: "Damlacık yoluyla bulaşır")
  String get description => throw _privateConstructorUsedError;

  /// Bu vaka için zorunlu KKD listesi
  List<GearType> get requiredGear => throw _privateConstructorUsedError;

  /// KKD giyilmezse uygulanacak ceza açıklaması
  String get penaltyDescription => throw _privateConstructorUsedError;

  /// Serializes this InfectionRisk to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InfectionRisk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InfectionRiskCopyWith<InfectionRisk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfectionRiskCopyWith<$Res> {
  factory $InfectionRiskCopyWith(
    InfectionRisk value,
    $Res Function(InfectionRisk) then,
  ) = _$InfectionRiskCopyWithImpl<$Res, InfectionRisk>;
  @useResult
  $Res call({
    InfectionRiskLevel level,
    String description,
    List<GearType> requiredGear,
    String penaltyDescription,
  });
}

/// @nodoc
class _$InfectionRiskCopyWithImpl<$Res, $Val extends InfectionRisk>
    implements $InfectionRiskCopyWith<$Res> {
  _$InfectionRiskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InfectionRisk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? description = null,
    Object? requiredGear = null,
    Object? penaltyDescription = null,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as InfectionRiskLevel,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            requiredGear: null == requiredGear
                ? _value.requiredGear
                : requiredGear // ignore: cast_nullable_to_non_nullable
                      as List<GearType>,
            penaltyDescription: null == penaltyDescription
                ? _value.penaltyDescription
                : penaltyDescription // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InfectionRiskImplCopyWith<$Res>
    implements $InfectionRiskCopyWith<$Res> {
  factory _$$InfectionRiskImplCopyWith(
    _$InfectionRiskImpl value,
    $Res Function(_$InfectionRiskImpl) then,
  ) = __$$InfectionRiskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    InfectionRiskLevel level,
    String description,
    List<GearType> requiredGear,
    String penaltyDescription,
  });
}

/// @nodoc
class __$$InfectionRiskImplCopyWithImpl<$Res>
    extends _$InfectionRiskCopyWithImpl<$Res, _$InfectionRiskImpl>
    implements _$$InfectionRiskImplCopyWith<$Res> {
  __$$InfectionRiskImplCopyWithImpl(
    _$InfectionRiskImpl _value,
    $Res Function(_$InfectionRiskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InfectionRisk
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? description = null,
    Object? requiredGear = null,
    Object? penaltyDescription = null,
  }) {
    return _then(
      _$InfectionRiskImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as InfectionRiskLevel,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        requiredGear: null == requiredGear
            ? _value._requiredGear
            : requiredGear // ignore: cast_nullable_to_non_nullable
                  as List<GearType>,
        penaltyDescription: null == penaltyDescription
            ? _value.penaltyDescription
            : penaltyDescription // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InfectionRiskImpl implements _InfectionRisk {
  const _$InfectionRiskImpl({
    this.level = InfectionRiskLevel.none,
    this.description = '',
    final List<GearType> requiredGear = const [],
    this.penaltyDescription = '',
  }) : _requiredGear = requiredGear;

  factory _$InfectionRiskImpl.fromJson(Map<String, dynamic> json) =>
      _$$InfectionRiskImplFromJson(json);

  /// Bulaş riski seviyesi
  @override
  @JsonKey()
  final InfectionRiskLevel level;

  /// Bulaş tipi açıklaması (ör: "Damlacık yoluyla bulaşır")
  @override
  @JsonKey()
  final String description;

  /// Bu vaka için zorunlu KKD listesi
  final List<GearType> _requiredGear;

  /// Bu vaka için zorunlu KKD listesi
  @override
  @JsonKey()
  List<GearType> get requiredGear {
    if (_requiredGear is EqualUnmodifiableListView) return _requiredGear;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredGear);
  }

  /// KKD giyilmezse uygulanacak ceza açıklaması
  @override
  @JsonKey()
  final String penaltyDescription;

  @override
  String toString() {
    return 'InfectionRisk(level: $level, description: $description, requiredGear: $requiredGear, penaltyDescription: $penaltyDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InfectionRiskImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._requiredGear,
              _requiredGear,
            ) &&
            (identical(other.penaltyDescription, penaltyDescription) ||
                other.penaltyDescription == penaltyDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    level,
    description,
    const DeepCollectionEquality().hash(_requiredGear),
    penaltyDescription,
  );

  /// Create a copy of InfectionRisk
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InfectionRiskImplCopyWith<_$InfectionRiskImpl> get copyWith =>
      __$$InfectionRiskImplCopyWithImpl<_$InfectionRiskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InfectionRiskImplToJson(this);
  }
}

abstract class _InfectionRisk implements InfectionRisk {
  const factory _InfectionRisk({
    final InfectionRiskLevel level,
    final String description,
    final List<GearType> requiredGear,
    final String penaltyDescription,
  }) = _$InfectionRiskImpl;

  factory _InfectionRisk.fromJson(Map<String, dynamic> json) =
      _$InfectionRiskImpl.fromJson;

  /// Bulaş riski seviyesi
  @override
  InfectionRiskLevel get level;

  /// Bulaş tipi açıklaması (ör: "Damlacık yoluyla bulaşır")
  @override
  String get description;

  /// Bu vaka için zorunlu KKD listesi
  @override
  List<GearType> get requiredGear;

  /// KKD giyilmezse uygulanacak ceza açıklaması
  @override
  String get penaltyDescription;

  /// Create a copy of InfectionRisk
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InfectionRiskImplCopyWith<_$InfectionRiskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
