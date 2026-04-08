// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DangerousTreatment _$DangerousTreatmentFromJson(Map<String, dynamic> json) {
  return _DangerousTreatment.fromJson(json);
}

/// @nodoc
mixin _$DangerousTreatment {
  /// Tehlikeli tedavinin adı (treatmentOptions'daki ile eşleşmeli)
  String get treatmentName => throw _privateConstructorUsedError;

  /// Neden tehlikeli (ör: "Hastanın böbrek yetmezliği var")
  String get reason => throw _privateConstructorUsedError;

  /// Sonucu (ör: "Akut böbrek hasarı riski")
  String get consequence => throw _privateConstructorUsedError;

  /// Serializes this DangerousTreatment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DangerousTreatment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DangerousTreatmentCopyWith<DangerousTreatment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DangerousTreatmentCopyWith<$Res> {
  factory $DangerousTreatmentCopyWith(
    DangerousTreatment value,
    $Res Function(DangerousTreatment) then,
  ) = _$DangerousTreatmentCopyWithImpl<$Res, DangerousTreatment>;
  @useResult
  $Res call({String treatmentName, String reason, String consequence});
}

/// @nodoc
class _$DangerousTreatmentCopyWithImpl<$Res, $Val extends DangerousTreatment>
    implements $DangerousTreatmentCopyWith<$Res> {
  _$DangerousTreatmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DangerousTreatment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? treatmentName = null,
    Object? reason = null,
    Object? consequence = null,
  }) {
    return _then(
      _value.copyWith(
            treatmentName: null == treatmentName
                ? _value.treatmentName
                : treatmentName // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            consequence: null == consequence
                ? _value.consequence
                : consequence // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DangerousTreatmentImplCopyWith<$Res>
    implements $DangerousTreatmentCopyWith<$Res> {
  factory _$$DangerousTreatmentImplCopyWith(
    _$DangerousTreatmentImpl value,
    $Res Function(_$DangerousTreatmentImpl) then,
  ) = __$$DangerousTreatmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String treatmentName, String reason, String consequence});
}

/// @nodoc
class __$$DangerousTreatmentImplCopyWithImpl<$Res>
    extends _$DangerousTreatmentCopyWithImpl<$Res, _$DangerousTreatmentImpl>
    implements _$$DangerousTreatmentImplCopyWith<$Res> {
  __$$DangerousTreatmentImplCopyWithImpl(
    _$DangerousTreatmentImpl _value,
    $Res Function(_$DangerousTreatmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DangerousTreatment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? treatmentName = null,
    Object? reason = null,
    Object? consequence = null,
  }) {
    return _then(
      _$DangerousTreatmentImpl(
        treatmentName: null == treatmentName
            ? _value.treatmentName
            : treatmentName // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        consequence: null == consequence
            ? _value.consequence
            : consequence // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DangerousTreatmentImpl implements _DangerousTreatment {
  const _$DangerousTreatmentImpl({
    this.treatmentName = '',
    this.reason = '',
    this.consequence = '',
  });

  factory _$DangerousTreatmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DangerousTreatmentImplFromJson(json);

  /// Tehlikeli tedavinin adı (treatmentOptions'daki ile eşleşmeli)
  @override
  @JsonKey()
  final String treatmentName;

  /// Neden tehlikeli (ör: "Hastanın böbrek yetmezliği var")
  @override
  @JsonKey()
  final String reason;

  /// Sonucu (ör: "Akut böbrek hasarı riski")
  @override
  @JsonKey()
  final String consequence;

  @override
  String toString() {
    return 'DangerousTreatment(treatmentName: $treatmentName, reason: $reason, consequence: $consequence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DangerousTreatmentImpl &&
            (identical(other.treatmentName, treatmentName) ||
                other.treatmentName == treatmentName) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.consequence, consequence) ||
                other.consequence == consequence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, treatmentName, reason, consequence);

  /// Create a copy of DangerousTreatment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DangerousTreatmentImplCopyWith<_$DangerousTreatmentImpl> get copyWith =>
      __$$DangerousTreatmentImplCopyWithImpl<_$DangerousTreatmentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DangerousTreatmentImplToJson(this);
  }
}

abstract class _DangerousTreatment implements DangerousTreatment {
  const factory _DangerousTreatment({
    final String treatmentName,
    final String reason,
    final String consequence,
  }) = _$DangerousTreatmentImpl;

  factory _DangerousTreatment.fromJson(Map<String, dynamic> json) =
      _$DangerousTreatmentImpl.fromJson;

  /// Tehlikeli tedavinin adı (treatmentOptions'daki ile eşleşmeli)
  @override
  String get treatmentName;

  /// Neden tehlikeli (ör: "Hastanın böbrek yetmezliği var")
  @override
  String get reason;

  /// Sonucu (ör: "Akut böbrek hasarı riski")
  @override
  String get consequence;

  /// Create a copy of DangerousTreatment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DangerousTreatmentImplCopyWith<_$DangerousTreatmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Solution _$SolutionFromJson(Map<String, dynamic> json) {
  return _Solution.fromJson(json);
}

/// @nodoc
mixin _$Solution {
  /// Doğru teşhis ID'si
  String get correctDiagnosisId => throw _privateConstructorUsedError;

  /// Doğru tedavi planı
  String get correctTreatment => throw _privateConstructorUsedError;

  /// Çözüm açıklaması (doğru teşhis koyulduğunda gösterilir)
  String get explanation => throw _privateConstructorUsedError;

  /// Tedavi seçenekleri (oyuncuya sunulur)
  List<String> get treatmentOptions => throw _privateConstructorUsedError;

  /// Eğitici not (hastalık hakkında bilgi)
  String get educationalNote => throw _privateConstructorUsedError;

  /// XP ödülü
  int get scoreReward => throw _privateConstructorUsedError;

  /// Tehlikeli tedaviler (ilaç etkileşimi / yan etki uyarıları)
  List<DangerousTreatment> get dangerousTreatments =>
      throw _privateConstructorUsedError; // Geriye uyumluluk için eski alan adları (JSON parse)
  @JsonKey(name: 'guiltyId')
  String? get guiltyIdLegacy => throw _privateConstructorUsedError;
  @JsonKey(name: 'correctMotive')
  String? get correctMotiveLegacy => throw _privateConstructorUsedError;
  @JsonKey(name: 'motiveOptions')
  List<String>? get motiveOptionsLegacy => throw _privateConstructorUsedError;

  /// Serializes this Solution to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolutionCopyWith<Solution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolutionCopyWith<$Res> {
  factory $SolutionCopyWith(Solution value, $Res Function(Solution) then) =
      _$SolutionCopyWithImpl<$Res, Solution>;
  @useResult
  $Res call({
    String correctDiagnosisId,
    String correctTreatment,
    String explanation,
    List<String> treatmentOptions,
    String educationalNote,
    int scoreReward,
    List<DangerousTreatment> dangerousTreatments,
    @JsonKey(name: 'guiltyId') String? guiltyIdLegacy,
    @JsonKey(name: 'correctMotive') String? correctMotiveLegacy,
    @JsonKey(name: 'motiveOptions') List<String>? motiveOptionsLegacy,
  });
}

/// @nodoc
class _$SolutionCopyWithImpl<$Res, $Val extends Solution>
    implements $SolutionCopyWith<$Res> {
  _$SolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correctDiagnosisId = null,
    Object? correctTreatment = null,
    Object? explanation = null,
    Object? treatmentOptions = null,
    Object? educationalNote = null,
    Object? scoreReward = null,
    Object? dangerousTreatments = null,
    Object? guiltyIdLegacy = freezed,
    Object? correctMotiveLegacy = freezed,
    Object? motiveOptionsLegacy = freezed,
  }) {
    return _then(
      _value.copyWith(
            correctDiagnosisId: null == correctDiagnosisId
                ? _value.correctDiagnosisId
                : correctDiagnosisId // ignore: cast_nullable_to_non_nullable
                      as String,
            correctTreatment: null == correctTreatment
                ? _value.correctTreatment
                : correctTreatment // ignore: cast_nullable_to_non_nullable
                      as String,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            treatmentOptions: null == treatmentOptions
                ? _value.treatmentOptions
                : treatmentOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            educationalNote: null == educationalNote
                ? _value.educationalNote
                : educationalNote // ignore: cast_nullable_to_non_nullable
                      as String,
            scoreReward: null == scoreReward
                ? _value.scoreReward
                : scoreReward // ignore: cast_nullable_to_non_nullable
                      as int,
            dangerousTreatments: null == dangerousTreatments
                ? _value.dangerousTreatments
                : dangerousTreatments // ignore: cast_nullable_to_non_nullable
                      as List<DangerousTreatment>,
            guiltyIdLegacy: freezed == guiltyIdLegacy
                ? _value.guiltyIdLegacy
                : guiltyIdLegacy // ignore: cast_nullable_to_non_nullable
                      as String?,
            correctMotiveLegacy: freezed == correctMotiveLegacy
                ? _value.correctMotiveLegacy
                : correctMotiveLegacy // ignore: cast_nullable_to_non_nullable
                      as String?,
            motiveOptionsLegacy: freezed == motiveOptionsLegacy
                ? _value.motiveOptionsLegacy
                : motiveOptionsLegacy // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SolutionImplCopyWith<$Res>
    implements $SolutionCopyWith<$Res> {
  factory _$$SolutionImplCopyWith(
    _$SolutionImpl value,
    $Res Function(_$SolutionImpl) then,
  ) = __$$SolutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String correctDiagnosisId,
    String correctTreatment,
    String explanation,
    List<String> treatmentOptions,
    String educationalNote,
    int scoreReward,
    List<DangerousTreatment> dangerousTreatments,
    @JsonKey(name: 'guiltyId') String? guiltyIdLegacy,
    @JsonKey(name: 'correctMotive') String? correctMotiveLegacy,
    @JsonKey(name: 'motiveOptions') List<String>? motiveOptionsLegacy,
  });
}

/// @nodoc
class __$$SolutionImplCopyWithImpl<$Res>
    extends _$SolutionCopyWithImpl<$Res, _$SolutionImpl>
    implements _$$SolutionImplCopyWith<$Res> {
  __$$SolutionImplCopyWithImpl(
    _$SolutionImpl _value,
    $Res Function(_$SolutionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correctDiagnosisId = null,
    Object? correctTreatment = null,
    Object? explanation = null,
    Object? treatmentOptions = null,
    Object? educationalNote = null,
    Object? scoreReward = null,
    Object? dangerousTreatments = null,
    Object? guiltyIdLegacy = freezed,
    Object? correctMotiveLegacy = freezed,
    Object? motiveOptionsLegacy = freezed,
  }) {
    return _then(
      _$SolutionImpl(
        correctDiagnosisId: null == correctDiagnosisId
            ? _value.correctDiagnosisId
            : correctDiagnosisId // ignore: cast_nullable_to_non_nullable
                  as String,
        correctTreatment: null == correctTreatment
            ? _value.correctTreatment
            : correctTreatment // ignore: cast_nullable_to_non_nullable
                  as String,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        treatmentOptions: null == treatmentOptions
            ? _value._treatmentOptions
            : treatmentOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        educationalNote: null == educationalNote
            ? _value.educationalNote
            : educationalNote // ignore: cast_nullable_to_non_nullable
                  as String,
        scoreReward: null == scoreReward
            ? _value.scoreReward
            : scoreReward // ignore: cast_nullable_to_non_nullable
                  as int,
        dangerousTreatments: null == dangerousTreatments
            ? _value._dangerousTreatments
            : dangerousTreatments // ignore: cast_nullable_to_non_nullable
                  as List<DangerousTreatment>,
        guiltyIdLegacy: freezed == guiltyIdLegacy
            ? _value.guiltyIdLegacy
            : guiltyIdLegacy // ignore: cast_nullable_to_non_nullable
                  as String?,
        correctMotiveLegacy: freezed == correctMotiveLegacy
            ? _value.correctMotiveLegacy
            : correctMotiveLegacy // ignore: cast_nullable_to_non_nullable
                  as String?,
        motiveOptionsLegacy: freezed == motiveOptionsLegacy
            ? _value._motiveOptionsLegacy
            : motiveOptionsLegacy // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SolutionImpl implements _Solution {
  const _$SolutionImpl({
    this.correctDiagnosisId = '',
    this.correctTreatment = '',
    this.explanation = '',
    final List<String> treatmentOptions = const [],
    this.educationalNote = '',
    this.scoreReward = 100,
    final List<DangerousTreatment> dangerousTreatments = const [],
    @JsonKey(name: 'guiltyId') this.guiltyIdLegacy,
    @JsonKey(name: 'correctMotive') this.correctMotiveLegacy,
    @JsonKey(name: 'motiveOptions') final List<String>? motiveOptionsLegacy,
  }) : _treatmentOptions = treatmentOptions,
       _dangerousTreatments = dangerousTreatments,
       _motiveOptionsLegacy = motiveOptionsLegacy;

  factory _$SolutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolutionImplFromJson(json);

  /// Doğru teşhis ID'si
  @override
  @JsonKey()
  final String correctDiagnosisId;

  /// Doğru tedavi planı
  @override
  @JsonKey()
  final String correctTreatment;

  /// Çözüm açıklaması (doğru teşhis koyulduğunda gösterilir)
  @override
  @JsonKey()
  final String explanation;

  /// Tedavi seçenekleri (oyuncuya sunulur)
  final List<String> _treatmentOptions;

  /// Tedavi seçenekleri (oyuncuya sunulur)
  @override
  @JsonKey()
  List<String> get treatmentOptions {
    if (_treatmentOptions is EqualUnmodifiableListView)
      return _treatmentOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treatmentOptions);
  }

  /// Eğitici not (hastalık hakkında bilgi)
  @override
  @JsonKey()
  final String educationalNote;

  /// XP ödülü
  @override
  @JsonKey()
  final int scoreReward;

  /// Tehlikeli tedaviler (ilaç etkileşimi / yan etki uyarıları)
  final List<DangerousTreatment> _dangerousTreatments;

  /// Tehlikeli tedaviler (ilaç etkileşimi / yan etki uyarıları)
  @override
  @JsonKey()
  List<DangerousTreatment> get dangerousTreatments {
    if (_dangerousTreatments is EqualUnmodifiableListView)
      return _dangerousTreatments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dangerousTreatments);
  }

  // Geriye uyumluluk için eski alan adları (JSON parse)
  @override
  @JsonKey(name: 'guiltyId')
  final String? guiltyIdLegacy;
  @override
  @JsonKey(name: 'correctMotive')
  final String? correctMotiveLegacy;
  final List<String>? _motiveOptionsLegacy;
  @override
  @JsonKey(name: 'motiveOptions')
  List<String>? get motiveOptionsLegacy {
    final value = _motiveOptionsLegacy;
    if (value == null) return null;
    if (_motiveOptionsLegacy is EqualUnmodifiableListView)
      return _motiveOptionsLegacy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Solution(correctDiagnosisId: $correctDiagnosisId, correctTreatment: $correctTreatment, explanation: $explanation, treatmentOptions: $treatmentOptions, educationalNote: $educationalNote, scoreReward: $scoreReward, dangerousTreatments: $dangerousTreatments, guiltyIdLegacy: $guiltyIdLegacy, correctMotiveLegacy: $correctMotiveLegacy, motiveOptionsLegacy: $motiveOptionsLegacy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolutionImpl &&
            (identical(other.correctDiagnosisId, correctDiagnosisId) ||
                other.correctDiagnosisId == correctDiagnosisId) &&
            (identical(other.correctTreatment, correctTreatment) ||
                other.correctTreatment == correctTreatment) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality().equals(
              other._treatmentOptions,
              _treatmentOptions,
            ) &&
            (identical(other.educationalNote, educationalNote) ||
                other.educationalNote == educationalNote) &&
            (identical(other.scoreReward, scoreReward) ||
                other.scoreReward == scoreReward) &&
            const DeepCollectionEquality().equals(
              other._dangerousTreatments,
              _dangerousTreatments,
            ) &&
            (identical(other.guiltyIdLegacy, guiltyIdLegacy) ||
                other.guiltyIdLegacy == guiltyIdLegacy) &&
            (identical(other.correctMotiveLegacy, correctMotiveLegacy) ||
                other.correctMotiveLegacy == correctMotiveLegacy) &&
            const DeepCollectionEquality().equals(
              other._motiveOptionsLegacy,
              _motiveOptionsLegacy,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    correctDiagnosisId,
    correctTreatment,
    explanation,
    const DeepCollectionEquality().hash(_treatmentOptions),
    educationalNote,
    scoreReward,
    const DeepCollectionEquality().hash(_dangerousTreatments),
    guiltyIdLegacy,
    correctMotiveLegacy,
    const DeepCollectionEquality().hash(_motiveOptionsLegacy),
  );

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolutionImplCopyWith<_$SolutionImpl> get copyWith =>
      __$$SolutionImplCopyWithImpl<_$SolutionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolutionImplToJson(this);
  }
}

abstract class _Solution implements Solution {
  const factory _Solution({
    final String correctDiagnosisId,
    final String correctTreatment,
    final String explanation,
    final List<String> treatmentOptions,
    final String educationalNote,
    final int scoreReward,
    final List<DangerousTreatment> dangerousTreatments,
    @JsonKey(name: 'guiltyId') final String? guiltyIdLegacy,
    @JsonKey(name: 'correctMotive') final String? correctMotiveLegacy,
    @JsonKey(name: 'motiveOptions') final List<String>? motiveOptionsLegacy,
  }) = _$SolutionImpl;

  factory _Solution.fromJson(Map<String, dynamic> json) =
      _$SolutionImpl.fromJson;

  /// Doğru teşhis ID'si
  @override
  String get correctDiagnosisId;

  /// Doğru tedavi planı
  @override
  String get correctTreatment;

  /// Çözüm açıklaması (doğru teşhis koyulduğunda gösterilir)
  @override
  String get explanation;

  /// Tedavi seçenekleri (oyuncuya sunulur)
  @override
  List<String> get treatmentOptions;

  /// Eğitici not (hastalık hakkında bilgi)
  @override
  String get educationalNote;

  /// XP ödülü
  @override
  int get scoreReward;

  /// Tehlikeli tedaviler (ilaç etkileşimi / yan etki uyarıları)
  @override
  List<DangerousTreatment> get dangerousTreatments; // Geriye uyumluluk için eski alan adları (JSON parse)
  @override
  @JsonKey(name: 'guiltyId')
  String? get guiltyIdLegacy;
  @override
  @JsonKey(name: 'correctMotive')
  String? get correctMotiveLegacy;
  @override
  @JsonKey(name: 'motiveOptions')
  List<String>? get motiveOptionsLegacy;

  /// Create a copy of Solution
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolutionImplCopyWith<_$SolutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  /// Seçilen teşhis ID'si
  String get selectedDiagnosisId => throw _privateConstructorUsedError;

  /// Seçilen tedavi planı
  String get selectedTreatment => throw _privateConstructorUsedError;

  /// Cevap doğru mu
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Cevap zamanı
  DateTime? get submittedAt => throw _privateConstructorUsedError;

  /// Serializes this UserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
    UserAnswer value,
    $Res Function(UserAnswer) then,
  ) = _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call({
    String selectedDiagnosisId,
    String selectedTreatment,
    bool isCorrect,
    DateTime? submittedAt,
  });
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDiagnosisId = null,
    Object? selectedTreatment = null,
    Object? isCorrect = null,
    Object? submittedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedDiagnosisId: null == selectedDiagnosisId
                ? _value.selectedDiagnosisId
                : selectedDiagnosisId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedTreatment: null == selectedTreatment
                ? _value.selectedTreatment
                : selectedTreatment // ignore: cast_nullable_to_non_nullable
                      as String,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAnswerImplCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$UserAnswerImplCopyWith(
    _$UserAnswerImpl value,
    $Res Function(_$UserAnswerImpl) then,
  ) = __$$UserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String selectedDiagnosisId,
    String selectedTreatment,
    bool isCorrect,
    DateTime? submittedAt,
  });
}

/// @nodoc
class __$$UserAnswerImplCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$UserAnswerImpl>
    implements _$$UserAnswerImplCopyWith<$Res> {
  __$$UserAnswerImplCopyWithImpl(
    _$UserAnswerImpl _value,
    $Res Function(_$UserAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDiagnosisId = null,
    Object? selectedTreatment = null,
    Object? isCorrect = null,
    Object? submittedAt = freezed,
  }) {
    return _then(
      _$UserAnswerImpl(
        selectedDiagnosisId: null == selectedDiagnosisId
            ? _value.selectedDiagnosisId
            : selectedDiagnosisId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedTreatment: null == selectedTreatment
            ? _value.selectedTreatment
            : selectedTreatment // ignore: cast_nullable_to_non_nullable
                  as String,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAnswerImpl implements _UserAnswer {
  const _$UserAnswerImpl({
    this.selectedDiagnosisId = '',
    this.selectedTreatment = '',
    this.isCorrect = false,
    this.submittedAt,
  });

  factory _$UserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnswerImplFromJson(json);

  /// Seçilen teşhis ID'si
  @override
  @JsonKey()
  final String selectedDiagnosisId;

  /// Seçilen tedavi planı
  @override
  @JsonKey()
  final String selectedTreatment;

  /// Cevap doğru mu
  @override
  @JsonKey()
  final bool isCorrect;

  /// Cevap zamanı
  @override
  final DateTime? submittedAt;

  @override
  String toString() {
    return 'UserAnswer(selectedDiagnosisId: $selectedDiagnosisId, selectedTreatment: $selectedTreatment, isCorrect: $isCorrect, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnswerImpl &&
            (identical(other.selectedDiagnosisId, selectedDiagnosisId) ||
                other.selectedDiagnosisId == selectedDiagnosisId) &&
            (identical(other.selectedTreatment, selectedTreatment) ||
                other.selectedTreatment == selectedTreatment) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedDiagnosisId,
    selectedTreatment,
    isCorrect,
    submittedAt,
  );

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      __$$UserAnswerImplCopyWithImpl<_$UserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnswerImplToJson(this);
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer({
    final String selectedDiagnosisId,
    final String selectedTreatment,
    final bool isCorrect,
    final DateTime? submittedAt,
  }) = _$UserAnswerImpl;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$UserAnswerImpl.fromJson;

  /// Seçilen teşhis ID'si
  @override
  String get selectedDiagnosisId;

  /// Seçilen tedavi planı
  @override
  String get selectedTreatment;

  /// Cevap doğru mu
  @override
  bool get isCorrect;

  /// Cevap zamanı
  @override
  DateTime? get submittedAt;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
