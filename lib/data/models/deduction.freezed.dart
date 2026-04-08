// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deduction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Deduction _$DeductionFromJson(Map<String, dynamic> json) {
  return _Deduction.fromJson(json);
}

/// @nodoc
mixin _$Deduction {
  /// Benzersiz çıkarım ID'si
  String get id => throw _privateConstructorUsedError;

  /// Bu çıkarımı tetiklemek için birleşmesi gereken tıbbi veri ID'leri
  List<String> get requiredEvidenceIds => throw _privateConstructorUsedError;

  /// Birleşme başarılı olursa gösterilecek sonuç metni
  String get resultText => throw _privateConstructorUsedError;

  /// Çıkarımın kısa başlığı
  String? get title => throw _privateConstructorUsedError;

  /// Çıkarımın önemi (1-10)
  int get importance => throw _privateConstructorUsedError;

  /// (Opsiyonel) Bu birleşme sonucunda açılan yeni tıbbi veri ID'si
  String? get rewardEvidenceId => throw _privateConstructorUsedError;

  /// Çıkarım bulundu mu?
  bool get isFound => throw _privateConstructorUsedError;

  /// Bu çıkarım bir çelişki çözümü mü?
  /// (Hasta yanıltıcı cevap verdiğinde, tıbbi veri ile çelişki birleştirilerek gerçek ortaya çıkar)
  bool get isContradiction => throw _privateConstructorUsedError;

  /// Serializes this Deduction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeductionCopyWith<Deduction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeductionCopyWith<$Res> {
  factory $DeductionCopyWith(Deduction value, $Res Function(Deduction) then) =
      _$DeductionCopyWithImpl<$Res, Deduction>;
  @useResult
  $Res call({
    String id,
    List<String> requiredEvidenceIds,
    String resultText,
    String? title,
    int importance,
    String? rewardEvidenceId,
    bool isFound,
    bool isContradiction,
  });
}

/// @nodoc
class _$DeductionCopyWithImpl<$Res, $Val extends Deduction>
    implements $DeductionCopyWith<$Res> {
  _$DeductionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requiredEvidenceIds = null,
    Object? resultText = null,
    Object? title = freezed,
    Object? importance = null,
    Object? rewardEvidenceId = freezed,
    Object? isFound = null,
    Object? isContradiction = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            requiredEvidenceIds: null == requiredEvidenceIds
                ? _value.requiredEvidenceIds
                : requiredEvidenceIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            resultText: null == resultText
                ? _value.resultText
                : resultText // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            importance: null == importance
                ? _value.importance
                : importance // ignore: cast_nullable_to_non_nullable
                      as int,
            rewardEvidenceId: freezed == rewardEvidenceId
                ? _value.rewardEvidenceId
                : rewardEvidenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFound: null == isFound
                ? _value.isFound
                : isFound // ignore: cast_nullable_to_non_nullable
                      as bool,
            isContradiction: null == isContradiction
                ? _value.isContradiction
                : isContradiction // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeductionImplCopyWith<$Res>
    implements $DeductionCopyWith<$Res> {
  factory _$$DeductionImplCopyWith(
    _$DeductionImpl value,
    $Res Function(_$DeductionImpl) then,
  ) = __$$DeductionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    List<String> requiredEvidenceIds,
    String resultText,
    String? title,
    int importance,
    String? rewardEvidenceId,
    bool isFound,
    bool isContradiction,
  });
}

/// @nodoc
class __$$DeductionImplCopyWithImpl<$Res>
    extends _$DeductionCopyWithImpl<$Res, _$DeductionImpl>
    implements _$$DeductionImplCopyWith<$Res> {
  __$$DeductionImplCopyWithImpl(
    _$DeductionImpl _value,
    $Res Function(_$DeductionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requiredEvidenceIds = null,
    Object? resultText = null,
    Object? title = freezed,
    Object? importance = null,
    Object? rewardEvidenceId = freezed,
    Object? isFound = null,
    Object? isContradiction = null,
  }) {
    return _then(
      _$DeductionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        requiredEvidenceIds: null == requiredEvidenceIds
            ? _value._requiredEvidenceIds
            : requiredEvidenceIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        resultText: null == resultText
            ? _value.resultText
            : resultText // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        importance: null == importance
            ? _value.importance
            : importance // ignore: cast_nullable_to_non_nullable
                  as int,
        rewardEvidenceId: freezed == rewardEvidenceId
            ? _value.rewardEvidenceId
            : rewardEvidenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFound: null == isFound
            ? _value.isFound
            : isFound // ignore: cast_nullable_to_non_nullable
                  as bool,
        isContradiction: null == isContradiction
            ? _value.isContradiction
            : isContradiction // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeductionImpl implements _Deduction {
  const _$DeductionImpl({
    this.id = '',
    required final List<String> requiredEvidenceIds,
    this.resultText = '',
    this.title,
    this.importance = 5,
    this.rewardEvidenceId,
    this.isFound = false,
    this.isContradiction = false,
  }) : _requiredEvidenceIds = requiredEvidenceIds;

  factory _$DeductionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeductionImplFromJson(json);

  /// Benzersiz çıkarım ID'si
  @override
  @JsonKey()
  final String id;

  /// Bu çıkarımı tetiklemek için birleşmesi gereken tıbbi veri ID'leri
  final List<String> _requiredEvidenceIds;

  /// Bu çıkarımı tetiklemek için birleşmesi gereken tıbbi veri ID'leri
  @override
  List<String> get requiredEvidenceIds {
    if (_requiredEvidenceIds is EqualUnmodifiableListView)
      return _requiredEvidenceIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredEvidenceIds);
  }

  /// Birleşme başarılı olursa gösterilecek sonuç metni
  @override
  @JsonKey()
  final String resultText;

  /// Çıkarımın kısa başlığı
  @override
  final String? title;

  /// Çıkarımın önemi (1-10)
  @override
  @JsonKey()
  final int importance;

  /// (Opsiyonel) Bu birleşme sonucunda açılan yeni tıbbi veri ID'si
  @override
  final String? rewardEvidenceId;

  /// Çıkarım bulundu mu?
  @override
  @JsonKey()
  final bool isFound;

  /// Bu çıkarım bir çelişki çözümü mü?
  /// (Hasta yanıltıcı cevap verdiğinde, tıbbi veri ile çelişki birleştirilerek gerçek ortaya çıkar)
  @override
  @JsonKey()
  final bool isContradiction;

  @override
  String toString() {
    return 'Deduction(id: $id, requiredEvidenceIds: $requiredEvidenceIds, resultText: $resultText, title: $title, importance: $importance, rewardEvidenceId: $rewardEvidenceId, isFound: $isFound, isContradiction: $isContradiction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeductionImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(
              other._requiredEvidenceIds,
              _requiredEvidenceIds,
            ) &&
            (identical(other.resultText, resultText) ||
                other.resultText == resultText) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.rewardEvidenceId, rewardEvidenceId) ||
                other.rewardEvidenceId == rewardEvidenceId) &&
            (identical(other.isFound, isFound) || other.isFound == isFound) &&
            (identical(other.isContradiction, isContradiction) ||
                other.isContradiction == isContradiction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    const DeepCollectionEquality().hash(_requiredEvidenceIds),
    resultText,
    title,
    importance,
    rewardEvidenceId,
    isFound,
    isContradiction,
  );

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeductionImplCopyWith<_$DeductionImpl> get copyWith =>
      __$$DeductionImplCopyWithImpl<_$DeductionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeductionImplToJson(this);
  }
}

abstract class _Deduction implements Deduction {
  const factory _Deduction({
    final String id,
    required final List<String> requiredEvidenceIds,
    final String resultText,
    final String? title,
    final int importance,
    final String? rewardEvidenceId,
    final bool isFound,
    final bool isContradiction,
  }) = _$DeductionImpl;

  factory _Deduction.fromJson(Map<String, dynamic> json) =
      _$DeductionImpl.fromJson;

  /// Benzersiz çıkarım ID'si
  @override
  String get id;

  /// Bu çıkarımı tetiklemek için birleşmesi gereken tıbbi veri ID'leri
  @override
  List<String> get requiredEvidenceIds;

  /// Birleşme başarılı olursa gösterilecek sonuç metni
  @override
  String get resultText;

  /// Çıkarımın kısa başlığı
  @override
  String? get title;

  /// Çıkarımın önemi (1-10)
  @override
  int get importance;

  /// (Opsiyonel) Bu birleşme sonucunda açılan yeni tıbbi veri ID'si
  @override
  String? get rewardEvidenceId;

  /// Çıkarım bulundu mu?
  @override
  bool get isFound;

  /// Bu çıkarım bir çelişki çözümü mü?
  /// (Hasta yanıltıcı cevap verdiğinde, tıbbi veri ile çelişki birleştirilerek gerçek ortaya çıkar)
  @override
  bool get isContradiction;

  /// Create a copy of Deduction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeductionImplCopyWith<_$DeductionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
