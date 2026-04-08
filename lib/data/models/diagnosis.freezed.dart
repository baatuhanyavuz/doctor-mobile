// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagnosis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) {
  return _Diagnosis.fromJson(json);
}

/// @nodoc
mixin _$Diagnosis {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Tıbbi kategori (Kardiyoloji, Göğüs Hastalıkları, Nöroloji vb.)
  String? get category => throw _privateConstructorUsedError;

  /// Hastalık ikonu/illüstrasyon yolu
  String? get iconPath => throw _privateConstructorUsedError;

  /// Hastalık açıklaması
  String? get description => throw _privateConstructorUsedError;

  /// Tipik semptomlar
  List<String> get typicalSymptoms => throw _privateConstructorUsedError;

  /// Risk faktörleri
  List<String> get riskFactors => throw _privateConstructorUsedError;

  /// Meslek / alt branş
  String? get occupation => throw _privateConstructorUsedError;

  /// Ayırıcı tanıda dikkat edilecekler
  String? get differentialNotes => throw _privateConstructorUsedError;

  /// Hastalık fotoğrafı/illüstrasyon yolu
  String? get photoPath => throw _privateConstructorUsedError;

  /// Detaylı açıklama (biyografi)
  String? get biography => throw _privateConstructorUsedError;

  /// Semptom/kişilik özellikleri gösterimi
  List<String>? get personalityTraits => throw _privateConstructorUsedError;

  /// Doğru teşhis mi (JSON'da saklanır, UI'da gösterilmez)
  bool get isCorrectDiagnosis => throw _privateConstructorUsedError;

  /// Elenmiş mi (oyuncu tarafından)
  bool get isRuledOut => throw _privateConstructorUsedError;

  /// Serializes this Diagnosis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiagnosisCopyWith<Diagnosis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagnosisCopyWith<$Res> {
  factory $DiagnosisCopyWith(Diagnosis value, $Res Function(Diagnosis) then) =
      _$DiagnosisCopyWithImpl<$Res, Diagnosis>;
  @useResult
  $Res call({
    String id,
    String name,
    String? category,
    String? iconPath,
    String? description,
    List<String> typicalSymptoms,
    List<String> riskFactors,
    String? occupation,
    String? differentialNotes,
    String? photoPath,
    String? biography,
    List<String>? personalityTraits,
    bool isCorrectDiagnosis,
    bool isRuledOut,
  });
}

/// @nodoc
class _$DiagnosisCopyWithImpl<$Res, $Val extends Diagnosis>
    implements $DiagnosisCopyWith<$Res> {
  _$DiagnosisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? iconPath = freezed,
    Object? description = freezed,
    Object? typicalSymptoms = null,
    Object? riskFactors = null,
    Object? occupation = freezed,
    Object? differentialNotes = freezed,
    Object? photoPath = freezed,
    Object? biography = freezed,
    Object? personalityTraits = freezed,
    Object? isCorrectDiagnosis = null,
    Object? isRuledOut = null,
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
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            iconPath: freezed == iconPath
                ? _value.iconPath
                : iconPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            typicalSymptoms: null == typicalSymptoms
                ? _value.typicalSymptoms
                : typicalSymptoms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            riskFactors: null == riskFactors
                ? _value.riskFactors
                : riskFactors // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as String?,
            differentialNotes: freezed == differentialNotes
                ? _value.differentialNotes
                : differentialNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoPath: freezed == photoPath
                ? _value.photoPath
                : photoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            biography: freezed == biography
                ? _value.biography
                : biography // ignore: cast_nullable_to_non_nullable
                      as String?,
            personalityTraits: freezed == personalityTraits
                ? _value.personalityTraits
                : personalityTraits // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            isCorrectDiagnosis: null == isCorrectDiagnosis
                ? _value.isCorrectDiagnosis
                : isCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRuledOut: null == isRuledOut
                ? _value.isRuledOut
                : isRuledOut // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiagnosisImplCopyWith<$Res>
    implements $DiagnosisCopyWith<$Res> {
  factory _$$DiagnosisImplCopyWith(
    _$DiagnosisImpl value,
    $Res Function(_$DiagnosisImpl) then,
  ) = __$$DiagnosisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? category,
    String? iconPath,
    String? description,
    List<String> typicalSymptoms,
    List<String> riskFactors,
    String? occupation,
    String? differentialNotes,
    String? photoPath,
    String? biography,
    List<String>? personalityTraits,
    bool isCorrectDiagnosis,
    bool isRuledOut,
  });
}

/// @nodoc
class __$$DiagnosisImplCopyWithImpl<$Res>
    extends _$DiagnosisCopyWithImpl<$Res, _$DiagnosisImpl>
    implements _$$DiagnosisImplCopyWith<$Res> {
  __$$DiagnosisImplCopyWithImpl(
    _$DiagnosisImpl _value,
    $Res Function(_$DiagnosisImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = freezed,
    Object? iconPath = freezed,
    Object? description = freezed,
    Object? typicalSymptoms = null,
    Object? riskFactors = null,
    Object? occupation = freezed,
    Object? differentialNotes = freezed,
    Object? photoPath = freezed,
    Object? biography = freezed,
    Object? personalityTraits = freezed,
    Object? isCorrectDiagnosis = null,
    Object? isRuledOut = null,
  }) {
    return _then(
      _$DiagnosisImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        iconPath: freezed == iconPath
            ? _value.iconPath
            : iconPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        typicalSymptoms: null == typicalSymptoms
            ? _value._typicalSymptoms
            : typicalSymptoms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        riskFactors: null == riskFactors
            ? _value._riskFactors
            : riskFactors // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        occupation: freezed == occupation
            ? _value.occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as String?,
        differentialNotes: freezed == differentialNotes
            ? _value.differentialNotes
            : differentialNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoPath: freezed == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        biography: freezed == biography
            ? _value.biography
            : biography // ignore: cast_nullable_to_non_nullable
                  as String?,
        personalityTraits: freezed == personalityTraits
            ? _value._personalityTraits
            : personalityTraits // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        isCorrectDiagnosis: null == isCorrectDiagnosis
            ? _value.isCorrectDiagnosis
            : isCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRuledOut: null == isRuledOut
            ? _value.isRuledOut
            : isRuledOut // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiagnosisImpl implements _Diagnosis {
  const _$DiagnosisImpl({
    this.id = '',
    this.name = '',
    this.category,
    this.iconPath,
    this.description,
    final List<String> typicalSymptoms = const [],
    final List<String> riskFactors = const [],
    this.occupation,
    this.differentialNotes,
    this.photoPath,
    this.biography,
    final List<String>? personalityTraits,
    this.isCorrectDiagnosis = false,
    this.isRuledOut = false,
  }) : _typicalSymptoms = typicalSymptoms,
       _riskFactors = riskFactors,
       _personalityTraits = personalityTraits;

  factory _$DiagnosisImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiagnosisImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;

  /// Tıbbi kategori (Kardiyoloji, Göğüs Hastalıkları, Nöroloji vb.)
  @override
  final String? category;

  /// Hastalık ikonu/illüstrasyon yolu
  @override
  final String? iconPath;

  /// Hastalık açıklaması
  @override
  final String? description;

  /// Tipik semptomlar
  final List<String> _typicalSymptoms;

  /// Tipik semptomlar
  @override
  @JsonKey()
  List<String> get typicalSymptoms {
    if (_typicalSymptoms is EqualUnmodifiableListView) return _typicalSymptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typicalSymptoms);
  }

  /// Risk faktörleri
  final List<String> _riskFactors;

  /// Risk faktörleri
  @override
  @JsonKey()
  List<String> get riskFactors {
    if (_riskFactors is EqualUnmodifiableListView) return _riskFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskFactors);
  }

  /// Meslek / alt branş
  @override
  final String? occupation;

  /// Ayırıcı tanıda dikkat edilecekler
  @override
  final String? differentialNotes;

  /// Hastalık fotoğrafı/illüstrasyon yolu
  @override
  final String? photoPath;

  /// Detaylı açıklama (biyografi)
  @override
  final String? biography;

  /// Semptom/kişilik özellikleri gösterimi
  final List<String>? _personalityTraits;

  /// Semptom/kişilik özellikleri gösterimi
  @override
  List<String>? get personalityTraits {
    final value = _personalityTraits;
    if (value == null) return null;
    if (_personalityTraits is EqualUnmodifiableListView)
      return _personalityTraits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Doğru teşhis mi (JSON'da saklanır, UI'da gösterilmez)
  @override
  @JsonKey()
  final bool isCorrectDiagnosis;

  /// Elenmiş mi (oyuncu tarafından)
  @override
  @JsonKey()
  final bool isRuledOut;

  @override
  String toString() {
    return 'Diagnosis(id: $id, name: $name, category: $category, iconPath: $iconPath, description: $description, typicalSymptoms: $typicalSymptoms, riskFactors: $riskFactors, occupation: $occupation, differentialNotes: $differentialNotes, photoPath: $photoPath, biography: $biography, personalityTraits: $personalityTraits, isCorrectDiagnosis: $isCorrectDiagnosis, isRuledOut: $isRuledOut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagnosisImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._typicalSymptoms,
              _typicalSymptoms,
            ) &&
            const DeepCollectionEquality().equals(
              other._riskFactors,
              _riskFactors,
            ) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.differentialNotes, differentialNotes) ||
                other.differentialNotes == differentialNotes) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            const DeepCollectionEquality().equals(
              other._personalityTraits,
              _personalityTraits,
            ) &&
            (identical(other.isCorrectDiagnosis, isCorrectDiagnosis) ||
                other.isCorrectDiagnosis == isCorrectDiagnosis) &&
            (identical(other.isRuledOut, isRuledOut) ||
                other.isRuledOut == isRuledOut));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    iconPath,
    description,
    const DeepCollectionEquality().hash(_typicalSymptoms),
    const DeepCollectionEquality().hash(_riskFactors),
    occupation,
    differentialNotes,
    photoPath,
    biography,
    const DeepCollectionEquality().hash(_personalityTraits),
    isCorrectDiagnosis,
    isRuledOut,
  );

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      __$$DiagnosisImplCopyWithImpl<_$DiagnosisImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiagnosisImplToJson(this);
  }
}

abstract class _Diagnosis implements Diagnosis {
  const factory _Diagnosis({
    final String id,
    final String name,
    final String? category,
    final String? iconPath,
    final String? description,
    final List<String> typicalSymptoms,
    final List<String> riskFactors,
    final String? occupation,
    final String? differentialNotes,
    final String? photoPath,
    final String? biography,
    final List<String>? personalityTraits,
    final bool isCorrectDiagnosis,
    final bool isRuledOut,
  }) = _$DiagnosisImpl;

  factory _Diagnosis.fromJson(Map<String, dynamic> json) =
      _$DiagnosisImpl.fromJson;

  @override
  String get id;
  @override
  String get name;

  /// Tıbbi kategori (Kardiyoloji, Göğüs Hastalıkları, Nöroloji vb.)
  @override
  String? get category;

  /// Hastalık ikonu/illüstrasyon yolu
  @override
  String? get iconPath;

  /// Hastalık açıklaması
  @override
  String? get description;

  /// Tipik semptomlar
  @override
  List<String> get typicalSymptoms;

  /// Risk faktörleri
  @override
  List<String> get riskFactors;

  /// Meslek / alt branş
  @override
  String? get occupation;

  /// Ayırıcı tanıda dikkat edilecekler
  @override
  String? get differentialNotes;

  /// Hastalık fotoğrafı/illüstrasyon yolu
  @override
  String? get photoPath;

  /// Detaylı açıklama (biyografi)
  @override
  String? get biography;

  /// Semptom/kişilik özellikleri gösterimi
  @override
  List<String>? get personalityTraits;

  /// Doğru teşhis mi (JSON'da saklanır, UI'da gösterilmez)
  @override
  bool get isCorrectDiagnosis;

  /// Elenmiş mi (oyuncu tarafından)
  @override
  bool get isRuledOut;

  /// Create a copy of Diagnosis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiagnosisImplCopyWith<_$DiagnosisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
