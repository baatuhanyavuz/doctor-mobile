// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Consumable _$ConsumableFromJson(Map<String, dynamic> json) {
  return _Consumable.fromJson(json);
}

/// @nodoc
mixin _$Consumable {
  ConsumableType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ConsumableCategory get category => throw _privateConstructorUsedError;
  int get creditCost => throw _privateConstructorUsedError;
  String get iconName => throw _privateConstructorUsedError;

  /// Serializes this Consumable to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Consumable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConsumableCopyWith<Consumable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumableCopyWith<$Res> {
  factory $ConsumableCopyWith(
    Consumable value,
    $Res Function(Consumable) then,
  ) = _$ConsumableCopyWithImpl<$Res, Consumable>;
  @useResult
  $Res call({
    ConsumableType type,
    String name,
    String description,
    ConsumableCategory category,
    int creditCost,
    String iconName,
  });
}

/// @nodoc
class _$ConsumableCopyWithImpl<$Res, $Val extends Consumable>
    implements $ConsumableCopyWith<$Res> {
  _$ConsumableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Consumable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? creditCost = null,
    Object? iconName = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ConsumableType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ConsumableCategory,
            creditCost: null == creditCost
                ? _value.creditCost
                : creditCost // ignore: cast_nullable_to_non_nullable
                      as int,
            iconName: null == iconName
                ? _value.iconName
                : iconName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConsumableImplCopyWith<$Res>
    implements $ConsumableCopyWith<$Res> {
  factory _$$ConsumableImplCopyWith(
    _$ConsumableImpl value,
    $Res Function(_$ConsumableImpl) then,
  ) = __$$ConsumableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ConsumableType type,
    String name,
    String description,
    ConsumableCategory category,
    int creditCost,
    String iconName,
  });
}

/// @nodoc
class __$$ConsumableImplCopyWithImpl<$Res>
    extends _$ConsumableCopyWithImpl<$Res, _$ConsumableImpl>
    implements _$$ConsumableImplCopyWith<$Res> {
  __$$ConsumableImplCopyWithImpl(
    _$ConsumableImpl _value,
    $Res Function(_$ConsumableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Consumable
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? creditCost = null,
    Object? iconName = null,
  }) {
    return _then(
      _$ConsumableImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ConsumableType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ConsumableCategory,
        creditCost: null == creditCost
            ? _value.creditCost
            : creditCost // ignore: cast_nullable_to_non_nullable
                  as int,
        iconName: null == iconName
            ? _value.iconName
            : iconName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumableImpl implements _Consumable {
  const _$ConsumableImpl({
    required this.type,
    this.name = '',
    this.description = '',
    this.category = ConsumableCategory.protection,
    this.creditCost = 0,
    this.iconName = '',
  });

  factory _$ConsumableImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumableImplFromJson(json);

  @override
  final ConsumableType type;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final ConsumableCategory category;
  @override
  @JsonKey()
  final int creditCost;
  @override
  @JsonKey()
  final String iconName;

  @override
  String toString() {
    return 'Consumable(type: $type, name: $name, description: $description, category: $category, creditCost: $creditCost, iconName: $iconName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumableImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.creditCost, creditCost) ||
                other.creditCost == creditCost) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    name,
    description,
    category,
    creditCost,
    iconName,
  );

  /// Create a copy of Consumable
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumableImplCopyWith<_$ConsumableImpl> get copyWith =>
      __$$ConsumableImplCopyWithImpl<_$ConsumableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumableImplToJson(this);
  }
}

abstract class _Consumable implements Consumable {
  const factory _Consumable({
    required final ConsumableType type,
    final String name,
    final String description,
    final ConsumableCategory category,
    final int creditCost,
    final String iconName,
  }) = _$ConsumableImpl;

  factory _Consumable.fromJson(Map<String, dynamic> json) =
      _$ConsumableImpl.fromJson;

  @override
  ConsumableType get type;
  @override
  String get name;
  @override
  String get description;
  @override
  ConsumableCategory get category;
  @override
  int get creditCost;
  @override
  String get iconName;

  /// Create a copy of Consumable
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConsumableImplCopyWith<_$ConsumableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
