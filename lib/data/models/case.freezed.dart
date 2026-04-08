// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vitals _$VitalsFromJson(Map<String, dynamic> json) {
  return _Vitals.fromJson(json);
}

/// @nodoc
mixin _$Vitals {
  String? get bloodPressure => throw _privateConstructorUsedError;
  int? get heartRate => throw _privateConstructorUsedError;
  double? get temperature => throw _privateConstructorUsedError;
  int? get oxygenSaturation => throw _privateConstructorUsedError;
  int? get respiratoryRate => throw _privateConstructorUsedError;

  /// Serializes this Vitals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vitals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VitalsCopyWith<Vitals> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VitalsCopyWith<$Res> {
  factory $VitalsCopyWith(Vitals value, $Res Function(Vitals) then) =
      _$VitalsCopyWithImpl<$Res, Vitals>;
  @useResult
  $Res call({
    String? bloodPressure,
    int? heartRate,
    double? temperature,
    int? oxygenSaturation,
    int? respiratoryRate,
  });
}

/// @nodoc
class _$VitalsCopyWithImpl<$Res, $Val extends Vitals>
    implements $VitalsCopyWith<$Res> {
  _$VitalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vitals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bloodPressure = freezed,
    Object? heartRate = freezed,
    Object? temperature = freezed,
    Object? oxygenSaturation = freezed,
    Object? respiratoryRate = freezed,
  }) {
    return _then(
      _value.copyWith(
            bloodPressure: freezed == bloodPressure
                ? _value.bloodPressure
                : bloodPressure // ignore: cast_nullable_to_non_nullable
                      as String?,
            heartRate: freezed == heartRate
                ? _value.heartRate
                : heartRate // ignore: cast_nullable_to_non_nullable
                      as int?,
            temperature: freezed == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double?,
            oxygenSaturation: freezed == oxygenSaturation
                ? _value.oxygenSaturation
                : oxygenSaturation // ignore: cast_nullable_to_non_nullable
                      as int?,
            respiratoryRate: freezed == respiratoryRate
                ? _value.respiratoryRate
                : respiratoryRate // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VitalsImplCopyWith<$Res> implements $VitalsCopyWith<$Res> {
  factory _$$VitalsImplCopyWith(
    _$VitalsImpl value,
    $Res Function(_$VitalsImpl) then,
  ) = __$$VitalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? bloodPressure,
    int? heartRate,
    double? temperature,
    int? oxygenSaturation,
    int? respiratoryRate,
  });
}

/// @nodoc
class __$$VitalsImplCopyWithImpl<$Res>
    extends _$VitalsCopyWithImpl<$Res, _$VitalsImpl>
    implements _$$VitalsImplCopyWith<$Res> {
  __$$VitalsImplCopyWithImpl(
    _$VitalsImpl _value,
    $Res Function(_$VitalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vitals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bloodPressure = freezed,
    Object? heartRate = freezed,
    Object? temperature = freezed,
    Object? oxygenSaturation = freezed,
    Object? respiratoryRate = freezed,
  }) {
    return _then(
      _$VitalsImpl(
        bloodPressure: freezed == bloodPressure
            ? _value.bloodPressure
            : bloodPressure // ignore: cast_nullable_to_non_nullable
                  as String?,
        heartRate: freezed == heartRate
            ? _value.heartRate
            : heartRate // ignore: cast_nullable_to_non_nullable
                  as int?,
        temperature: freezed == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double?,
        oxygenSaturation: freezed == oxygenSaturation
            ? _value.oxygenSaturation
            : oxygenSaturation // ignore: cast_nullable_to_non_nullable
                  as int?,
        respiratoryRate: freezed == respiratoryRate
            ? _value.respiratoryRate
            : respiratoryRate // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VitalsImpl implements _Vitals {
  const _$VitalsImpl({
    this.bloodPressure,
    this.heartRate,
    this.temperature,
    this.oxygenSaturation,
    this.respiratoryRate,
  });

  factory _$VitalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VitalsImplFromJson(json);

  @override
  final String? bloodPressure;
  @override
  final int? heartRate;
  @override
  final double? temperature;
  @override
  final int? oxygenSaturation;
  @override
  final int? respiratoryRate;

  @override
  String toString() {
    return 'Vitals(bloodPressure: $bloodPressure, heartRate: $heartRate, temperature: $temperature, oxygenSaturation: $oxygenSaturation, respiratoryRate: $respiratoryRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VitalsImpl &&
            (identical(other.bloodPressure, bloodPressure) ||
                other.bloodPressure == bloodPressure) &&
            (identical(other.heartRate, heartRate) ||
                other.heartRate == heartRate) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.oxygenSaturation, oxygenSaturation) ||
                other.oxygenSaturation == oxygenSaturation) &&
            (identical(other.respiratoryRate, respiratoryRate) ||
                other.respiratoryRate == respiratoryRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bloodPressure,
    heartRate,
    temperature,
    oxygenSaturation,
    respiratoryRate,
  );

  /// Create a copy of Vitals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VitalsImplCopyWith<_$VitalsImpl> get copyWith =>
      __$$VitalsImplCopyWithImpl<_$VitalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VitalsImplToJson(this);
  }
}

abstract class _Vitals implements Vitals {
  const factory _Vitals({
    final String? bloodPressure,
    final int? heartRate,
    final double? temperature,
    final int? oxygenSaturation,
    final int? respiratoryRate,
  }) = _$VitalsImpl;

  factory _Vitals.fromJson(Map<String, dynamic> json) = _$VitalsImpl.fromJson;

  @override
  String? get bloodPressure;
  @override
  int? get heartRate;
  @override
  double? get temperature;
  @override
  int? get oxygenSaturation;
  @override
  int? get respiratoryRate;

  /// Create a copy of Vitals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VitalsImplCopyWith<_$VitalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Patient _$PatientFromJson(Map<String, dynamic> json) {
  return _Patient.fromJson(json);
}

/// @nodoc
mixin _$Patient {
  String get name => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get bloodType => throw _privateConstructorUsedError;
  String? get occupation => throw _privateConstructorUsedError;
  String? get photoPath => throw _privateConstructorUsedError;
  List<String> get chronicDiseases => throw _privateConstructorUsedError;
  List<String> get currentMedications => throw _privateConstructorUsedError;
  List<String> get allergies => throw _privateConstructorUsedError;
  String? get chiefComplaint => throw _privateConstructorUsedError;
  Vitals? get vitals => throw _privateConstructorUsedError;
  String? get biography => throw _privateConstructorUsedError;

  /// Serializes this Patient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientCopyWith<Patient> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientCopyWith<$Res> {
  factory $PatientCopyWith(Patient value, $Res Function(Patient) then) =
      _$PatientCopyWithImpl<$Res, Patient>;
  @useResult
  $Res call({
    String name,
    int? age,
    String? gender,
    String? bloodType,
    String? occupation,
    String? photoPath,
    List<String> chronicDiseases,
    List<String> currentMedications,
    List<String> allergies,
    String? chiefComplaint,
    Vitals? vitals,
    String? biography,
  });

  $VitalsCopyWith<$Res>? get vitals;
}

/// @nodoc
class _$PatientCopyWithImpl<$Res, $Val extends Patient>
    implements $PatientCopyWith<$Res> {
  _$PatientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? bloodType = freezed,
    Object? occupation = freezed,
    Object? photoPath = freezed,
    Object? chronicDiseases = null,
    Object? currentMedications = null,
    Object? allergies = null,
    Object? chiefComplaint = freezed,
    Object? vitals = freezed,
    Object? biography = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            bloodType: freezed == bloodType
                ? _value.bloodType
                : bloodType // ignore: cast_nullable_to_non_nullable
                      as String?,
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as String?,
            photoPath: freezed == photoPath
                ? _value.photoPath
                : photoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            chronicDiseases: null == chronicDiseases
                ? _value.chronicDiseases
                : chronicDiseases // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            currentMedications: null == currentMedications
                ? _value.currentMedications
                : currentMedications // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allergies: null == allergies
                ? _value.allergies
                : allergies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            chiefComplaint: freezed == chiefComplaint
                ? _value.chiefComplaint
                : chiefComplaint // ignore: cast_nullable_to_non_nullable
                      as String?,
            vitals: freezed == vitals
                ? _value.vitals
                : vitals // ignore: cast_nullable_to_non_nullable
                      as Vitals?,
            biography: freezed == biography
                ? _value.biography
                : biography // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VitalsCopyWith<$Res>? get vitals {
    if (_value.vitals == null) {
      return null;
    }

    return $VitalsCopyWith<$Res>(_value.vitals!, (value) {
      return _then(_value.copyWith(vitals: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatientImplCopyWith<$Res> implements $PatientCopyWith<$Res> {
  factory _$$PatientImplCopyWith(
    _$PatientImpl value,
    $Res Function(_$PatientImpl) then,
  ) = __$$PatientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int? age,
    String? gender,
    String? bloodType,
    String? occupation,
    String? photoPath,
    List<String> chronicDiseases,
    List<String> currentMedications,
    List<String> allergies,
    String? chiefComplaint,
    Vitals? vitals,
    String? biography,
  });

  @override
  $VitalsCopyWith<$Res>? get vitals;
}

/// @nodoc
class __$$PatientImplCopyWithImpl<$Res>
    extends _$PatientCopyWithImpl<$Res, _$PatientImpl>
    implements _$$PatientImplCopyWith<$Res> {
  __$$PatientImplCopyWithImpl(
    _$PatientImpl _value,
    $Res Function(_$PatientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? bloodType = freezed,
    Object? occupation = freezed,
    Object? photoPath = freezed,
    Object? chronicDiseases = null,
    Object? currentMedications = null,
    Object? allergies = null,
    Object? chiefComplaint = freezed,
    Object? vitals = freezed,
    Object? biography = freezed,
  }) {
    return _then(
      _$PatientImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: freezed == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        bloodType: freezed == bloodType
            ? _value.bloodType
            : bloodType // ignore: cast_nullable_to_non_nullable
                  as String?,
        occupation: freezed == occupation
            ? _value.occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as String?,
        photoPath: freezed == photoPath
            ? _value.photoPath
            : photoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        chronicDiseases: null == chronicDiseases
            ? _value._chronicDiseases
            : chronicDiseases // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        currentMedications: null == currentMedications
            ? _value._currentMedications
            : currentMedications // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allergies: null == allergies
            ? _value._allergies
            : allergies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        chiefComplaint: freezed == chiefComplaint
            ? _value.chiefComplaint
            : chiefComplaint // ignore: cast_nullable_to_non_nullable
                  as String?,
        vitals: freezed == vitals
            ? _value.vitals
            : vitals // ignore: cast_nullable_to_non_nullable
                  as Vitals?,
        biography: freezed == biography
            ? _value.biography
            : biography // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientImpl implements _Patient {
  const _$PatientImpl({
    this.name = '',
    this.age,
    this.gender,
    this.bloodType,
    this.occupation,
    this.photoPath,
    final List<String> chronicDiseases = const [],
    final List<String> currentMedications = const [],
    final List<String> allergies = const [],
    this.chiefComplaint,
    this.vitals,
    this.biography,
  }) : _chronicDiseases = chronicDiseases,
       _currentMedications = currentMedications,
       _allergies = allergies;

  factory _$PatientImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  final int? age;
  @override
  final String? gender;
  @override
  final String? bloodType;
  @override
  final String? occupation;
  @override
  final String? photoPath;
  final List<String> _chronicDiseases;
  @override
  @JsonKey()
  List<String> get chronicDiseases {
    if (_chronicDiseases is EqualUnmodifiableListView) return _chronicDiseases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chronicDiseases);
  }

  final List<String> _currentMedications;
  @override
  @JsonKey()
  List<String> get currentMedications {
    if (_currentMedications is EqualUnmodifiableListView)
      return _currentMedications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentMedications);
  }

  final List<String> _allergies;
  @override
  @JsonKey()
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  final String? chiefComplaint;
  @override
  final Vitals? vitals;
  @override
  final String? biography;

  @override
  String toString() {
    return 'Patient(name: $name, age: $age, gender: $gender, bloodType: $bloodType, occupation: $occupation, photoPath: $photoPath, chronicDiseases: $chronicDiseases, currentMedications: $currentMedications, allergies: $allergies, chiefComplaint: $chiefComplaint, vitals: $vitals, biography: $biography)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.bloodType, bloodType) ||
                other.bloodType == bloodType) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.photoPath, photoPath) ||
                other.photoPath == photoPath) &&
            const DeepCollectionEquality().equals(
              other._chronicDiseases,
              _chronicDiseases,
            ) &&
            const DeepCollectionEquality().equals(
              other._currentMedications,
              _currentMedications,
            ) &&
            const DeepCollectionEquality().equals(
              other._allergies,
              _allergies,
            ) &&
            (identical(other.chiefComplaint, chiefComplaint) ||
                other.chiefComplaint == chiefComplaint) &&
            (identical(other.vitals, vitals) || other.vitals == vitals) &&
            (identical(other.biography, biography) ||
                other.biography == biography));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    age,
    gender,
    bloodType,
    occupation,
    photoPath,
    const DeepCollectionEquality().hash(_chronicDiseases),
    const DeepCollectionEquality().hash(_currentMedications),
    const DeepCollectionEquality().hash(_allergies),
    chiefComplaint,
    vitals,
    biography,
  );

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientImplCopyWith<_$PatientImpl> get copyWith =>
      __$$PatientImplCopyWithImpl<_$PatientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientImplToJson(this);
  }
}

abstract class _Patient implements Patient {
  const factory _Patient({
    final String name,
    final int? age,
    final String? gender,
    final String? bloodType,
    final String? occupation,
    final String? photoPath,
    final List<String> chronicDiseases,
    final List<String> currentMedications,
    final List<String> allergies,
    final String? chiefComplaint,
    final Vitals? vitals,
    final String? biography,
  }) = _$PatientImpl;

  factory _Patient.fromJson(Map<String, dynamic> json) = _$PatientImpl.fromJson;

  @override
  String get name;
  @override
  int? get age;
  @override
  String? get gender;
  @override
  String? get bloodType;
  @override
  String? get occupation;
  @override
  String? get photoPath;
  @override
  List<String> get chronicDiseases;
  @override
  List<String> get currentMedications;
  @override
  List<String> get allergies;
  @override
  String? get chiefComplaint;
  @override
  Vitals? get vitals;
  @override
  String? get biography;

  /// Create a copy of Patient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientImplCopyWith<_$PatientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Case _$CaseFromJson(Map<String, dynamic> json) {
  return _Case.fromJson(json);
}

/// @nodoc
mixin _$Case {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String get fullDescription => throw _privateConstructorUsedError;
  String get coverImage => throw _privateConstructorUsedError;
  Difficulty get difficulty => throw _privateConstructorUsedError;
  CaseStatus get status => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int? get creditPrice => throw _privateConstructorUsedError;
  int? get estimatedDuration => throw _privateConstructorUsedError;

  /// Hasta bilgisi
  Patient get patient => throw _privateConstructorUsedError;

  /// Tıbbi veriler (tahlil, görüntüleme, muayene bulgusu vb.)
  List<MedicalData> get medicalData => throw _privateConstructorUsedError;

  /// Olası teşhisler
  List<Diagnosis> get diagnoses => throw _privateConstructorUsedError;

  /// Anamnez görüşmeleri (hasta, yakın, hemşire)
  List<Interview> get interviews => throw _privateConstructorUsedError;

  /// Teşhis & tedavi çözümü
  Solution get solution => throw _privateConstructorUsedError;

  /// Teşhis tahtası birleştirme kuralları
  List<Deduction> get deductions => throw _privateConstructorUsedError;

  /// Mini oyunlar (görüntüleme analizi, muayene)
  List<MiniGameDef> get miniGames => throw _privateConstructorUsedError;

  /// Vaka kategorisi (kardiyoloji, nöroloji vb.)
  List<String>? get tags => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get playerNotes => throw _privateConstructorUsedError;
  int get progressPercent =>
      throw _privateConstructorUsedError; // === BRIEFING (Hasta Gelişi) ===
  /// Hemşire notu / hasta şikayeti (daktilo efektiyle)
  String? get introText => throw _privateConstructorUsedError;

  /// Klinik / bölüm (Örn: "Acil Servis", "Kardiyoloji Polikliniği")
  String? get clinic => throw _privateConstructorUsedError;

  /// Triaj notu / hemşire raporu
  String? get nurseReport =>
      throw _privateConstructorUsedError; // === BULAŞ RİSKİ ===
  /// Vaka bulaş riski bilgisi (KKD gereksinimi)
  InfectionRisk? get infectionRisk =>
      throw _privateConstructorUsedError; // === ETİK İKİLEMLER ===
  /// Vaka içi etik karar noktaları
  List<EthicalDilemma> get ethicalDilemmas =>
      throw _privateConstructorUsedError; // === ENDING (Vaka Kapanış) ===
  EndingData? get endingData => throw _privateConstructorUsedError;

  /// Serializes this Case to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaseCopyWith<Case> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaseCopyWith<$Res> {
  factory $CaseCopyWith(Case value, $Res Function(Case) then) =
      _$CaseCopyWithImpl<$Res, Case>;
  @useResult
  $Res call({
    String id,
    String title,
    String shortDescription,
    String fullDescription,
    String coverImage,
    Difficulty difficulty,
    CaseStatus status,
    double price,
    int? creditPrice,
    int? estimatedDuration,
    Patient patient,
    List<MedicalData> medicalData,
    List<Diagnosis> diagnoses,
    List<Interview> interviews,
    Solution solution,
    List<Deduction> deductions,
    List<MiniGameDef> miniGames,
    List<String>? tags,
    String? createdAt,
    String? playerNotes,
    int progressPercent,
    String? introText,
    String? clinic,
    String? nurseReport,
    InfectionRisk? infectionRisk,
    List<EthicalDilemma> ethicalDilemmas,
    EndingData? endingData,
  });

  $PatientCopyWith<$Res> get patient;
  $SolutionCopyWith<$Res> get solution;
  $InfectionRiskCopyWith<$Res>? get infectionRisk;
  $EndingDataCopyWith<$Res>? get endingData;
}

/// @nodoc
class _$CaseCopyWithImpl<$Res, $Val extends Case>
    implements $CaseCopyWith<$Res> {
  _$CaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? fullDescription = null,
    Object? coverImage = null,
    Object? difficulty = null,
    Object? status = null,
    Object? price = null,
    Object? creditPrice = freezed,
    Object? estimatedDuration = freezed,
    Object? patient = null,
    Object? medicalData = null,
    Object? diagnoses = null,
    Object? interviews = null,
    Object? solution = null,
    Object? deductions = null,
    Object? miniGames = null,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? playerNotes = freezed,
    Object? progressPercent = null,
    Object? introText = freezed,
    Object? clinic = freezed,
    Object? nurseReport = freezed,
    Object? infectionRisk = freezed,
    Object? ethicalDilemmas = null,
    Object? endingData = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            shortDescription: null == shortDescription
                ? _value.shortDescription
                : shortDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            fullDescription: null == fullDescription
                ? _value.fullDescription
                : fullDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            coverImage: null == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as Difficulty,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CaseStatus,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            creditPrice: freezed == creditPrice
                ? _value.creditPrice
                : creditPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            estimatedDuration: freezed == estimatedDuration
                ? _value.estimatedDuration
                : estimatedDuration // ignore: cast_nullable_to_non_nullable
                      as int?,
            patient: null == patient
                ? _value.patient
                : patient // ignore: cast_nullable_to_non_nullable
                      as Patient,
            medicalData: null == medicalData
                ? _value.medicalData
                : medicalData // ignore: cast_nullable_to_non_nullable
                      as List<MedicalData>,
            diagnoses: null == diagnoses
                ? _value.diagnoses
                : diagnoses // ignore: cast_nullable_to_non_nullable
                      as List<Diagnosis>,
            interviews: null == interviews
                ? _value.interviews
                : interviews // ignore: cast_nullable_to_non_nullable
                      as List<Interview>,
            solution: null == solution
                ? _value.solution
                : solution // ignore: cast_nullable_to_non_nullable
                      as Solution,
            deductions: null == deductions
                ? _value.deductions
                : deductions // ignore: cast_nullable_to_non_nullable
                      as List<Deduction>,
            miniGames: null == miniGames
                ? _value.miniGames
                : miniGames // ignore: cast_nullable_to_non_nullable
                      as List<MiniGameDef>,
            tags: freezed == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            playerNotes: freezed == playerNotes
                ? _value.playerNotes
                : playerNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            progressPercent: null == progressPercent
                ? _value.progressPercent
                : progressPercent // ignore: cast_nullable_to_non_nullable
                      as int,
            introText: freezed == introText
                ? _value.introText
                : introText // ignore: cast_nullable_to_non_nullable
                      as String?,
            clinic: freezed == clinic
                ? _value.clinic
                : clinic // ignore: cast_nullable_to_non_nullable
                      as String?,
            nurseReport: freezed == nurseReport
                ? _value.nurseReport
                : nurseReport // ignore: cast_nullable_to_non_nullable
                      as String?,
            infectionRisk: freezed == infectionRisk
                ? _value.infectionRisk
                : infectionRisk // ignore: cast_nullable_to_non_nullable
                      as InfectionRisk?,
            ethicalDilemmas: null == ethicalDilemmas
                ? _value.ethicalDilemmas
                : ethicalDilemmas // ignore: cast_nullable_to_non_nullable
                      as List<EthicalDilemma>,
            endingData: freezed == endingData
                ? _value.endingData
                : endingData // ignore: cast_nullable_to_non_nullable
                      as EndingData?,
          )
          as $Val,
    );
  }

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PatientCopyWith<$Res> get patient {
    return $PatientCopyWith<$Res>(_value.patient, (value) {
      return _then(_value.copyWith(patient: value) as $Val);
    });
  }

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SolutionCopyWith<$Res> get solution {
    return $SolutionCopyWith<$Res>(_value.solution, (value) {
      return _then(_value.copyWith(solution: value) as $Val);
    });
  }

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InfectionRiskCopyWith<$Res>? get infectionRisk {
    if (_value.infectionRisk == null) {
      return null;
    }

    return $InfectionRiskCopyWith<$Res>(_value.infectionRisk!, (value) {
      return _then(_value.copyWith(infectionRisk: value) as $Val);
    });
  }

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EndingDataCopyWith<$Res>? get endingData {
    if (_value.endingData == null) {
      return null;
    }

    return $EndingDataCopyWith<$Res>(_value.endingData!, (value) {
      return _then(_value.copyWith(endingData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CaseImplCopyWith<$Res> implements $CaseCopyWith<$Res> {
  factory _$$CaseImplCopyWith(
    _$CaseImpl value,
    $Res Function(_$CaseImpl) then,
  ) = __$$CaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String shortDescription,
    String fullDescription,
    String coverImage,
    Difficulty difficulty,
    CaseStatus status,
    double price,
    int? creditPrice,
    int? estimatedDuration,
    Patient patient,
    List<MedicalData> medicalData,
    List<Diagnosis> diagnoses,
    List<Interview> interviews,
    Solution solution,
    List<Deduction> deductions,
    List<MiniGameDef> miniGames,
    List<String>? tags,
    String? createdAt,
    String? playerNotes,
    int progressPercent,
    String? introText,
    String? clinic,
    String? nurseReport,
    InfectionRisk? infectionRisk,
    List<EthicalDilemma> ethicalDilemmas,
    EndingData? endingData,
  });

  @override
  $PatientCopyWith<$Res> get patient;
  @override
  $SolutionCopyWith<$Res> get solution;
  @override
  $InfectionRiskCopyWith<$Res>? get infectionRisk;
  @override
  $EndingDataCopyWith<$Res>? get endingData;
}

/// @nodoc
class __$$CaseImplCopyWithImpl<$Res>
    extends _$CaseCopyWithImpl<$Res, _$CaseImpl>
    implements _$$CaseImplCopyWith<$Res> {
  __$$CaseImplCopyWithImpl(_$CaseImpl _value, $Res Function(_$CaseImpl) _then)
    : super(_value, _then);

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? fullDescription = null,
    Object? coverImage = null,
    Object? difficulty = null,
    Object? status = null,
    Object? price = null,
    Object? creditPrice = freezed,
    Object? estimatedDuration = freezed,
    Object? patient = null,
    Object? medicalData = null,
    Object? diagnoses = null,
    Object? interviews = null,
    Object? solution = null,
    Object? deductions = null,
    Object? miniGames = null,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? playerNotes = freezed,
    Object? progressPercent = null,
    Object? introText = freezed,
    Object? clinic = freezed,
    Object? nurseReport = freezed,
    Object? infectionRisk = freezed,
    Object? ethicalDilemmas = null,
    Object? endingData = freezed,
  }) {
    return _then(
      _$CaseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        shortDescription: null == shortDescription
            ? _value.shortDescription
            : shortDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        fullDescription: null == fullDescription
            ? _value.fullDescription
            : fullDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        coverImage: null == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as Difficulty,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CaseStatus,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        creditPrice: freezed == creditPrice
            ? _value.creditPrice
            : creditPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        estimatedDuration: freezed == estimatedDuration
            ? _value.estimatedDuration
            : estimatedDuration // ignore: cast_nullable_to_non_nullable
                  as int?,
        patient: null == patient
            ? _value.patient
            : patient // ignore: cast_nullable_to_non_nullable
                  as Patient,
        medicalData: null == medicalData
            ? _value._medicalData
            : medicalData // ignore: cast_nullable_to_non_nullable
                  as List<MedicalData>,
        diagnoses: null == diagnoses
            ? _value._diagnoses
            : diagnoses // ignore: cast_nullable_to_non_nullable
                  as List<Diagnosis>,
        interviews: null == interviews
            ? _value._interviews
            : interviews // ignore: cast_nullable_to_non_nullable
                  as List<Interview>,
        solution: null == solution
            ? _value.solution
            : solution // ignore: cast_nullable_to_non_nullable
                  as Solution,
        deductions: null == deductions
            ? _value._deductions
            : deductions // ignore: cast_nullable_to_non_nullable
                  as List<Deduction>,
        miniGames: null == miniGames
            ? _value._miniGames
            : miniGames // ignore: cast_nullable_to_non_nullable
                  as List<MiniGameDef>,
        tags: freezed == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        playerNotes: freezed == playerNotes
            ? _value.playerNotes
            : playerNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        progressPercent: null == progressPercent
            ? _value.progressPercent
            : progressPercent // ignore: cast_nullable_to_non_nullable
                  as int,
        introText: freezed == introText
            ? _value.introText
            : introText // ignore: cast_nullable_to_non_nullable
                  as String?,
        clinic: freezed == clinic
            ? _value.clinic
            : clinic // ignore: cast_nullable_to_non_nullable
                  as String?,
        nurseReport: freezed == nurseReport
            ? _value.nurseReport
            : nurseReport // ignore: cast_nullable_to_non_nullable
                  as String?,
        infectionRisk: freezed == infectionRisk
            ? _value.infectionRisk
            : infectionRisk // ignore: cast_nullable_to_non_nullable
                  as InfectionRisk?,
        ethicalDilemmas: null == ethicalDilemmas
            ? _value._ethicalDilemmas
            : ethicalDilemmas // ignore: cast_nullable_to_non_nullable
                  as List<EthicalDilemma>,
        endingData: freezed == endingData
            ? _value.endingData
            : endingData // ignore: cast_nullable_to_non_nullable
                  as EndingData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CaseImpl implements _Case {
  const _$CaseImpl({
    this.id = '',
    this.title = '',
    this.shortDescription = '',
    this.fullDescription = '',
    this.coverImage = '',
    this.difficulty = Difficulty.easy,
    this.status = CaseStatus.available,
    this.price = 0.0,
    this.creditPrice,
    this.estimatedDuration,
    this.patient = const Patient(),
    final List<MedicalData> medicalData = const [],
    final List<Diagnosis> diagnoses = const [],
    final List<Interview> interviews = const [],
    this.solution = const Solution(),
    final List<Deduction> deductions = const [],
    final List<MiniGameDef> miniGames = const [],
    final List<String>? tags,
    this.createdAt,
    this.playerNotes,
    this.progressPercent = 0,
    this.introText,
    this.clinic,
    this.nurseReport,
    this.infectionRisk,
    final List<EthicalDilemma> ethicalDilemmas = const [],
    this.endingData,
  }) : _medicalData = medicalData,
       _diagnoses = diagnoses,
       _interviews = interviews,
       _deductions = deductions,
       _miniGames = miniGames,
       _tags = tags,
       _ethicalDilemmas = ethicalDilemmas;

  factory _$CaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaseImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String shortDescription;
  @override
  @JsonKey()
  final String fullDescription;
  @override
  @JsonKey()
  final String coverImage;
  @override
  @JsonKey()
  final Difficulty difficulty;
  @override
  @JsonKey()
  final CaseStatus status;
  @override
  @JsonKey()
  final double price;
  @override
  final int? creditPrice;
  @override
  final int? estimatedDuration;

  /// Hasta bilgisi
  @override
  @JsonKey()
  final Patient patient;

  /// Tıbbi veriler (tahlil, görüntüleme, muayene bulgusu vb.)
  final List<MedicalData> _medicalData;

  /// Tıbbi veriler (tahlil, görüntüleme, muayene bulgusu vb.)
  @override
  @JsonKey()
  List<MedicalData> get medicalData {
    if (_medicalData is EqualUnmodifiableListView) return _medicalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_medicalData);
  }

  /// Olası teşhisler
  final List<Diagnosis> _diagnoses;

  /// Olası teşhisler
  @override
  @JsonKey()
  List<Diagnosis> get diagnoses {
    if (_diagnoses is EqualUnmodifiableListView) return _diagnoses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_diagnoses);
  }

  /// Anamnez görüşmeleri (hasta, yakın, hemşire)
  final List<Interview> _interviews;

  /// Anamnez görüşmeleri (hasta, yakın, hemşire)
  @override
  @JsonKey()
  List<Interview> get interviews {
    if (_interviews is EqualUnmodifiableListView) return _interviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interviews);
  }

  /// Teşhis & tedavi çözümü
  @override
  @JsonKey()
  final Solution solution;

  /// Teşhis tahtası birleştirme kuralları
  final List<Deduction> _deductions;

  /// Teşhis tahtası birleştirme kuralları
  @override
  @JsonKey()
  List<Deduction> get deductions {
    if (_deductions is EqualUnmodifiableListView) return _deductions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deductions);
  }

  /// Mini oyunlar (görüntüleme analizi, muayene)
  final List<MiniGameDef> _miniGames;

  /// Mini oyunlar (görüntüleme analizi, muayene)
  @override
  @JsonKey()
  List<MiniGameDef> get miniGames {
    if (_miniGames is EqualUnmodifiableListView) return _miniGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_miniGames);
  }

  /// Vaka kategorisi (kardiyoloji, nöroloji vb.)
  final List<String>? _tags;

  /// Vaka kategorisi (kardiyoloji, nöroloji vb.)
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? createdAt;
  @override
  final String? playerNotes;
  @override
  @JsonKey()
  final int progressPercent;
  // === BRIEFING (Hasta Gelişi) ===
  /// Hemşire notu / hasta şikayeti (daktilo efektiyle)
  @override
  final String? introText;

  /// Klinik / bölüm (Örn: "Acil Servis", "Kardiyoloji Polikliniği")
  @override
  final String? clinic;

  /// Triaj notu / hemşire raporu
  @override
  final String? nurseReport;
  // === BULAŞ RİSKİ ===
  /// Vaka bulaş riski bilgisi (KKD gereksinimi)
  @override
  final InfectionRisk? infectionRisk;
  // === ETİK İKİLEMLER ===
  /// Vaka içi etik karar noktaları
  final List<EthicalDilemma> _ethicalDilemmas;
  // === ETİK İKİLEMLER ===
  /// Vaka içi etik karar noktaları
  @override
  @JsonKey()
  List<EthicalDilemma> get ethicalDilemmas {
    if (_ethicalDilemmas is EqualUnmodifiableListView) return _ethicalDilemmas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ethicalDilemmas);
  }

  // === ENDING (Vaka Kapanış) ===
  @override
  final EndingData? endingData;

  @override
  String toString() {
    return 'Case(id: $id, title: $title, shortDescription: $shortDescription, fullDescription: $fullDescription, coverImage: $coverImage, difficulty: $difficulty, status: $status, price: $price, creditPrice: $creditPrice, estimatedDuration: $estimatedDuration, patient: $patient, medicalData: $medicalData, diagnoses: $diagnoses, interviews: $interviews, solution: $solution, deductions: $deductions, miniGames: $miniGames, tags: $tags, createdAt: $createdAt, playerNotes: $playerNotes, progressPercent: $progressPercent, introText: $introText, clinic: $clinic, nurseReport: $nurseReport, infectionRisk: $infectionRisk, ethicalDilemmas: $ethicalDilemmas, endingData: $endingData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.fullDescription, fullDescription) ||
                other.fullDescription == fullDescription) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.creditPrice, creditPrice) ||
                other.creditPrice == creditPrice) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.patient, patient) || other.patient == patient) &&
            const DeepCollectionEquality().equals(
              other._medicalData,
              _medicalData,
            ) &&
            const DeepCollectionEquality().equals(
              other._diagnoses,
              _diagnoses,
            ) &&
            const DeepCollectionEquality().equals(
              other._interviews,
              _interviews,
            ) &&
            (identical(other.solution, solution) ||
                other.solution == solution) &&
            const DeepCollectionEquality().equals(
              other._deductions,
              _deductions,
            ) &&
            const DeepCollectionEquality().equals(
              other._miniGames,
              _miniGames,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.playerNotes, playerNotes) ||
                other.playerNotes == playerNotes) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.introText, introText) ||
                other.introText == introText) &&
            (identical(other.clinic, clinic) || other.clinic == clinic) &&
            (identical(other.nurseReport, nurseReport) ||
                other.nurseReport == nurseReport) &&
            (identical(other.infectionRisk, infectionRisk) ||
                other.infectionRisk == infectionRisk) &&
            const DeepCollectionEquality().equals(
              other._ethicalDilemmas,
              _ethicalDilemmas,
            ) &&
            (identical(other.endingData, endingData) ||
                other.endingData == endingData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    shortDescription,
    fullDescription,
    coverImage,
    difficulty,
    status,
    price,
    creditPrice,
    estimatedDuration,
    patient,
    const DeepCollectionEquality().hash(_medicalData),
    const DeepCollectionEquality().hash(_diagnoses),
    const DeepCollectionEquality().hash(_interviews),
    solution,
    const DeepCollectionEquality().hash(_deductions),
    const DeepCollectionEquality().hash(_miniGames),
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    playerNotes,
    progressPercent,
    introText,
    clinic,
    nurseReport,
    infectionRisk,
    const DeepCollectionEquality().hash(_ethicalDilemmas),
    endingData,
  ]);

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaseImplCopyWith<_$CaseImpl> get copyWith =>
      __$$CaseImplCopyWithImpl<_$CaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaseImplToJson(this);
  }
}

abstract class _Case implements Case {
  const factory _Case({
    final String id,
    final String title,
    final String shortDescription,
    final String fullDescription,
    final String coverImage,
    final Difficulty difficulty,
    final CaseStatus status,
    final double price,
    final int? creditPrice,
    final int? estimatedDuration,
    final Patient patient,
    final List<MedicalData> medicalData,
    final List<Diagnosis> diagnoses,
    final List<Interview> interviews,
    final Solution solution,
    final List<Deduction> deductions,
    final List<MiniGameDef> miniGames,
    final List<String>? tags,
    final String? createdAt,
    final String? playerNotes,
    final int progressPercent,
    final String? introText,
    final String? clinic,
    final String? nurseReport,
    final InfectionRisk? infectionRisk,
    final List<EthicalDilemma> ethicalDilemmas,
    final EndingData? endingData,
  }) = _$CaseImpl;

  factory _Case.fromJson(Map<String, dynamic> json) = _$CaseImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get shortDescription;
  @override
  String get fullDescription;
  @override
  String get coverImage;
  @override
  Difficulty get difficulty;
  @override
  CaseStatus get status;
  @override
  double get price;
  @override
  int? get creditPrice;
  @override
  int? get estimatedDuration;

  /// Hasta bilgisi
  @override
  Patient get patient;

  /// Tıbbi veriler (tahlil, görüntüleme, muayene bulgusu vb.)
  @override
  List<MedicalData> get medicalData;

  /// Olası teşhisler
  @override
  List<Diagnosis> get diagnoses;

  /// Anamnez görüşmeleri (hasta, yakın, hemşire)
  @override
  List<Interview> get interviews;

  /// Teşhis & tedavi çözümü
  @override
  Solution get solution;

  /// Teşhis tahtası birleştirme kuralları
  @override
  List<Deduction> get deductions;

  /// Mini oyunlar (görüntüleme analizi, muayene)
  @override
  List<MiniGameDef> get miniGames;

  /// Vaka kategorisi (kardiyoloji, nöroloji vb.)
  @override
  List<String>? get tags;
  @override
  String? get createdAt;
  @override
  String? get playerNotes;
  @override
  int get progressPercent; // === BRIEFING (Hasta Gelişi) ===
  /// Hemşire notu / hasta şikayeti (daktilo efektiyle)
  @override
  String? get introText;

  /// Klinik / bölüm (Örn: "Acil Servis", "Kardiyoloji Polikliniği")
  @override
  String? get clinic;

  /// Triaj notu / hemşire raporu
  @override
  String? get nurseReport; // === BULAŞ RİSKİ ===
  /// Vaka bulaş riski bilgisi (KKD gereksinimi)
  @override
  InfectionRisk? get infectionRisk; // === ETİK İKİLEMLER ===
  /// Vaka içi etik karar noktaları
  @override
  List<EthicalDilemma> get ethicalDilemmas; // === ENDING (Vaka Kapanış) ===
  @override
  EndingData? get endingData;

  /// Create a copy of Case
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaseImplCopyWith<_$CaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CaseList _$CaseListFromJson(Map<String, dynamic> json) {
  return _CaseList.fromJson(json);
}

/// @nodoc
mixin _$CaseList {
  List<Case> get cases => throw _privateConstructorUsedError;

  /// Serializes this CaseList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CaseList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CaseListCopyWith<CaseList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CaseListCopyWith<$Res> {
  factory $CaseListCopyWith(CaseList value, $Res Function(CaseList) then) =
      _$CaseListCopyWithImpl<$Res, CaseList>;
  @useResult
  $Res call({List<Case> cases});
}

/// @nodoc
class _$CaseListCopyWithImpl<$Res, $Val extends CaseList>
    implements $CaseListCopyWith<$Res> {
  _$CaseListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CaseList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cases = null}) {
    return _then(
      _value.copyWith(
            cases: null == cases
                ? _value.cases
                : cases // ignore: cast_nullable_to_non_nullable
                      as List<Case>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CaseListImplCopyWith<$Res>
    implements $CaseListCopyWith<$Res> {
  factory _$$CaseListImplCopyWith(
    _$CaseListImpl value,
    $Res Function(_$CaseListImpl) then,
  ) = __$$CaseListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Case> cases});
}

/// @nodoc
class __$$CaseListImplCopyWithImpl<$Res>
    extends _$CaseListCopyWithImpl<$Res, _$CaseListImpl>
    implements _$$CaseListImplCopyWith<$Res> {
  __$$CaseListImplCopyWithImpl(
    _$CaseListImpl _value,
    $Res Function(_$CaseListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CaseList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? cases = null}) {
    return _then(
      _$CaseListImpl(
        cases: null == cases
            ? _value._cases
            : cases // ignore: cast_nullable_to_non_nullable
                  as List<Case>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CaseListImpl implements _CaseList {
  const _$CaseListImpl({final List<Case> cases = const []}) : _cases = cases;

  factory _$CaseListImpl.fromJson(Map<String, dynamic> json) =>
      _$$CaseListImplFromJson(json);

  final List<Case> _cases;
  @override
  @JsonKey()
  List<Case> get cases {
    if (_cases is EqualUnmodifiableListView) return _cases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cases);
  }

  @override
  String toString() {
    return 'CaseList(cases: $cases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CaseListImpl &&
            const DeepCollectionEquality().equals(other._cases, _cases));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cases));

  /// Create a copy of CaseList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CaseListImplCopyWith<_$CaseListImpl> get copyWith =>
      __$$CaseListImplCopyWithImpl<_$CaseListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CaseListImplToJson(this);
  }
}

abstract class _CaseList implements CaseList {
  const factory _CaseList({final List<Case> cases}) = _$CaseListImpl;

  factory _CaseList.fromJson(Map<String, dynamic> json) =
      _$CaseListImpl.fromJson;

  @override
  List<Case> get cases;

  /// Create a copy of CaseList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CaseListImplCopyWith<_$CaseListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
