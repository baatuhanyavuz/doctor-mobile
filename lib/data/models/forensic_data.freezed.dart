// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forensic_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Reagent _$ReagentFromJson(Map<String, dynamic> json) {
  return _Reagent.fromJson(json);
}

/// @nodoc
mixin _$Reagent {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError; // Hex code
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this Reagent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Reagent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReagentCopyWith<Reagent> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReagentCopyWith<$Res> {
  factory $ReagentCopyWith(Reagent value, $Res Function(Reagent) then) =
      _$ReagentCopyWithImpl<$Res, Reagent>;
  @useResult
  $Res call({String id, String name, String color, bool isCorrect});
}

/// @nodoc
class _$ReagentCopyWithImpl<$Res, $Val extends Reagent>
    implements $ReagentCopyWith<$Res> {
  _$ReagentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Reagent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReagentImplCopyWith<$Res> implements $ReagentCopyWith<$Res> {
  factory _$$ReagentImplCopyWith(
    _$ReagentImpl value,
    $Res Function(_$ReagentImpl) then,
  ) = __$$ReagentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String color, bool isCorrect});
}

/// @nodoc
class __$$ReagentImplCopyWithImpl<$Res>
    extends _$ReagentCopyWithImpl<$Res, _$ReagentImpl>
    implements _$$ReagentImplCopyWith<$Res> {
  __$$ReagentImplCopyWithImpl(
    _$ReagentImpl _value,
    $Res Function(_$ReagentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Reagent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? isCorrect = null,
  }) {
    return _then(
      _$ReagentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReagentImpl implements _Reagent {
  const _$ReagentImpl({
    this.id = '',
    this.name = '',
    this.color = '',
    this.isCorrect = false,
  });

  factory _$ReagentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReagentImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String color;
  // Hex code
  @override
  @JsonKey()
  final bool isCorrect;

  @override
  String toString() {
    return 'Reagent(id: $id, name: $name, color: $color, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReagentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, color, isCorrect);

  /// Create a copy of Reagent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReagentImplCopyWith<_$ReagentImpl> get copyWith =>
      __$$ReagentImplCopyWithImpl<_$ReagentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReagentImplToJson(this);
  }
}

abstract class _Reagent implements Reagent {
  const factory _Reagent({
    final String id,
    final String name,
    final String color,
    final bool isCorrect,
  }) = _$ReagentImpl;

  factory _Reagent.fromJson(Map<String, dynamic> json) = _$ReagentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get color; // Hex code
  @override
  bool get isCorrect;

  /// Create a copy of Reagent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReagentImplCopyWith<_$ReagentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForensicData _$ForensicDataFromJson(Map<String, dynamic> json) {
  return _ForensicData.fromJson(json);
}

/// @nodoc
mixin _$ForensicData {
  String get initialImageUrl => throw _privateConstructorUsedError;
  String get resultImageUrl => throw _privateConstructorUsedError;
  String get resultText => throw _privateConstructorUsedError;
  List<Reagent> get reagents => throw _privateConstructorUsedError;

  /// Serializes this ForensicData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForensicData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForensicDataCopyWith<ForensicData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForensicDataCopyWith<$Res> {
  factory $ForensicDataCopyWith(
    ForensicData value,
    $Res Function(ForensicData) then,
  ) = _$ForensicDataCopyWithImpl<$Res, ForensicData>;
  @useResult
  $Res call({
    String initialImageUrl,
    String resultImageUrl,
    String resultText,
    List<Reagent> reagents,
  });
}

/// @nodoc
class _$ForensicDataCopyWithImpl<$Res, $Val extends ForensicData>
    implements $ForensicDataCopyWith<$Res> {
  _$ForensicDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForensicData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialImageUrl = null,
    Object? resultImageUrl = null,
    Object? resultText = null,
    Object? reagents = null,
  }) {
    return _then(
      _value.copyWith(
            initialImageUrl: null == initialImageUrl
                ? _value.initialImageUrl
                : initialImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            resultImageUrl: null == resultImageUrl
                ? _value.resultImageUrl
                : resultImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            resultText: null == resultText
                ? _value.resultText
                : resultText // ignore: cast_nullable_to_non_nullable
                      as String,
            reagents: null == reagents
                ? _value.reagents
                : reagents // ignore: cast_nullable_to_non_nullable
                      as List<Reagent>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForensicDataImplCopyWith<$Res>
    implements $ForensicDataCopyWith<$Res> {
  factory _$$ForensicDataImplCopyWith(
    _$ForensicDataImpl value,
    $Res Function(_$ForensicDataImpl) then,
  ) = __$$ForensicDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String initialImageUrl,
    String resultImageUrl,
    String resultText,
    List<Reagent> reagents,
  });
}

/// @nodoc
class __$$ForensicDataImplCopyWithImpl<$Res>
    extends _$ForensicDataCopyWithImpl<$Res, _$ForensicDataImpl>
    implements _$$ForensicDataImplCopyWith<$Res> {
  __$$ForensicDataImplCopyWithImpl(
    _$ForensicDataImpl _value,
    $Res Function(_$ForensicDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForensicData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialImageUrl = null,
    Object? resultImageUrl = null,
    Object? resultText = null,
    Object? reagents = null,
  }) {
    return _then(
      _$ForensicDataImpl(
        initialImageUrl: null == initialImageUrl
            ? _value.initialImageUrl
            : initialImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        resultImageUrl: null == resultImageUrl
            ? _value.resultImageUrl
            : resultImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        resultText: null == resultText
            ? _value.resultText
            : resultText // ignore: cast_nullable_to_non_nullable
                  as String,
        reagents: null == reagents
            ? _value._reagents
            : reagents // ignore: cast_nullable_to_non_nullable
                  as List<Reagent>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForensicDataImpl implements _ForensicData {
  const _$ForensicDataImpl({
    this.initialImageUrl = '',
    this.resultImageUrl = '',
    this.resultText = '',
    final List<Reagent> reagents = const [],
  }) : _reagents = reagents;

  factory _$ForensicDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForensicDataImplFromJson(json);

  @override
  @JsonKey()
  final String initialImageUrl;
  @override
  @JsonKey()
  final String resultImageUrl;
  @override
  @JsonKey()
  final String resultText;
  final List<Reagent> _reagents;
  @override
  @JsonKey()
  List<Reagent> get reagents {
    if (_reagents is EqualUnmodifiableListView) return _reagents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reagents);
  }

  @override
  String toString() {
    return 'ForensicData(initialImageUrl: $initialImageUrl, resultImageUrl: $resultImageUrl, resultText: $resultText, reagents: $reagents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForensicDataImpl &&
            (identical(other.initialImageUrl, initialImageUrl) ||
                other.initialImageUrl == initialImageUrl) &&
            (identical(other.resultImageUrl, resultImageUrl) ||
                other.resultImageUrl == resultImageUrl) &&
            (identical(other.resultText, resultText) ||
                other.resultText == resultText) &&
            const DeepCollectionEquality().equals(other._reagents, _reagents));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    initialImageUrl,
    resultImageUrl,
    resultText,
    const DeepCollectionEquality().hash(_reagents),
  );

  /// Create a copy of ForensicData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForensicDataImplCopyWith<_$ForensicDataImpl> get copyWith =>
      __$$ForensicDataImplCopyWithImpl<_$ForensicDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForensicDataImplToJson(this);
  }
}

abstract class _ForensicData implements ForensicData {
  const factory _ForensicData({
    final String initialImageUrl,
    final String resultImageUrl,
    final String resultText,
    final List<Reagent> reagents,
  }) = _$ForensicDataImpl;

  factory _ForensicData.fromJson(Map<String, dynamic> json) =
      _$ForensicDataImpl.fromJson;

  @override
  String get initialImageUrl;
  @override
  String get resultImageUrl;
  @override
  String get resultText;
  @override
  List<Reagent> get reagents;

  /// Create a copy of ForensicData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForensicDataImplCopyWith<_$ForensicDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
