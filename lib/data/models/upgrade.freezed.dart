// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upgrade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Upgrade _$UpgradeFromJson(Map<String, dynamic> json) {
  return _Upgrade.fromJson(json);
}

/// @nodoc
mixin _$Upgrade {
  UpgradeType get type => throw _privateConstructorUsedError;
  int get level =>
      throw _privateConstructorUsedError; // 0 = satın alınmamış, 1-3 = seviye
  int get maxLevel => throw _privateConstructorUsedError;

  /// Serializes this Upgrade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Upgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpgradeCopyWith<Upgrade> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpgradeCopyWith<$Res> {
  factory $UpgradeCopyWith(Upgrade value, $Res Function(Upgrade) then) =
      _$UpgradeCopyWithImpl<$Res, Upgrade>;
  @useResult
  $Res call({UpgradeType type, int level, int maxLevel});
}

/// @nodoc
class _$UpgradeCopyWithImpl<$Res, $Val extends Upgrade>
    implements $UpgradeCopyWith<$Res> {
  _$UpgradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Upgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? level = null,
    Object? maxLevel = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as UpgradeType,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            maxLevel: null == maxLevel
                ? _value.maxLevel
                : maxLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UpgradeImplCopyWith<$Res> implements $UpgradeCopyWith<$Res> {
  factory _$$UpgradeImplCopyWith(
    _$UpgradeImpl value,
    $Res Function(_$UpgradeImpl) then,
  ) = __$$UpgradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UpgradeType type, int level, int maxLevel});
}

/// @nodoc
class __$$UpgradeImplCopyWithImpl<$Res>
    extends _$UpgradeCopyWithImpl<$Res, _$UpgradeImpl>
    implements _$$UpgradeImplCopyWith<$Res> {
  __$$UpgradeImplCopyWithImpl(
    _$UpgradeImpl _value,
    $Res Function(_$UpgradeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Upgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? level = null,
    Object? maxLevel = null,
  }) {
    return _then(
      _$UpgradeImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as UpgradeType,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        maxLevel: null == maxLevel
            ? _value.maxLevel
            : maxLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UpgradeImpl implements _Upgrade {
  const _$UpgradeImpl({required this.type, this.level = 0, this.maxLevel = 3});

  factory _$UpgradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpgradeImplFromJson(json);

  @override
  final UpgradeType type;
  @override
  @JsonKey()
  final int level;
  // 0 = satın alınmamış, 1-3 = seviye
  @override
  @JsonKey()
  final int maxLevel;

  @override
  String toString() {
    return 'Upgrade(type: $type, level: $level, maxLevel: $maxLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpgradeImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.maxLevel, maxLevel) ||
                other.maxLevel == maxLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, level, maxLevel);

  /// Create a copy of Upgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpgradeImplCopyWith<_$UpgradeImpl> get copyWith =>
      __$$UpgradeImplCopyWithImpl<_$UpgradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpgradeImplToJson(this);
  }
}

abstract class _Upgrade implements Upgrade {
  const factory _Upgrade({
    required final UpgradeType type,
    final int level,
    final int maxLevel,
  }) = _$UpgradeImpl;

  factory _Upgrade.fromJson(Map<String, dynamic> json) = _$UpgradeImpl.fromJson;

  @override
  UpgradeType get type;
  @override
  int get level; // 0 = satın alınmamış, 1-3 = seviye
  @override
  int get maxLevel;

  /// Create a copy of Upgrade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpgradeImplCopyWith<_$UpgradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
