// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mini_game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MiniGameDef _$MiniGameDefFromJson(Map<String, dynamic> json) {
  return _MiniGameDef.fromJson(json);
}

/// @nodoc
mixin _$MiniGameDef {
  String get id => throw _privateConstructorUsedError;

  /// Tip: "imaging_analysis" veya "examination"
  String get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get trigger => throw _privateConstructorUsedError;
  String? get sceneImage => throw _privateConstructorUsedError;
  int? get timeLimitSeconds =>
      throw _privateConstructorUsedError; // Görüntüleme analizi alanları (röntgen/MR'da anomali bul)
  double? get correctX => throw _privateConstructorUsedError;
  double? get correctY => throw _privateConstructorUsedError;
  double? get correctAngle => throw _privateConstructorUsedError;
  double? get tolerance => throw _privateConstructorUsedError;
  Map<String, dynamic>? get targetArea => throw _privateConstructorUsedError;
  List<String> get hints =>
      throw _privateConstructorUsedError; // Muayene mini oyun alanları (doğru soruları sor)
  String? get patientName => throw _privateConstructorUsedError;
  String? get patientImage => throw _privateConstructorUsedError;
  int? get initialComfort => throw _privateConstructorUsedError;
  int? get comfortThreshold => throw _privateConstructorUsedError;
  List<ExaminationQuestion> get questions => throw _privateConstructorUsedError;
  List<String> get criticalQuestions => throw _privateConstructorUsedError;
  List<String> get optimalOrder =>
      throw _privateConstructorUsedError; // Toksikoloji lab mini oyun alanları (doğru antidotu/tedaviyi seç)
  /// Toksik madde adı
  String? get toxinName => throw _privateConstructorUsedError;

  /// Toksin açıklaması
  String? get toxinDescription => throw _privateConstructorUsedError;

  /// Semptom listesi
  List<String> get toxinSymptoms => throw _privateConstructorUsedError;

  /// Antidot/tedavi seçenekleri
  List<ToxicologyOption> get toxicologyOptions =>
      throw _privateConstructorUsedError;

  /// Toksin yoğunluk seviyesi (1-10) — süre baskısı
  int get toxinSeverity =>
      throw _privateConstructorUsedError; // EKG okuma mini oyun alanları
  /// Anomali tipi: "st_elevation", "atrial_fibrillation", "prolonged_qt", "ventricular_tachycardia"
  String? get ekgAnomalyType => throw _privateConstructorUsedError;

  /// Anomali başlangıç pozisyonu (0-1 normalize)
  double? get ekgAnomalyStartX => throw _privateConstructorUsedError;

  /// Anomali bitiş pozisyonu (0-1 normalize)
  double? get ekgAnomalyEndX => throw _privateConstructorUsedError;

  /// Teşhis seçenekleri
  List<String> get ekgDiagnosisOptions => throw _privateConstructorUsedError;

  /// Doğru teşhis
  String? get ekgCorrectDiagnosis =>
      throw _privateConstructorUsedError; // Oskültasyon (stetoskop) mini oyun alanları
  /// Oskültasyon noktaları ve bulguları
  List<AuscultationFinding> get auscultationFindings =>
      throw _privateConstructorUsedError;

  /// Tanı seçenekleri
  List<String> get auscultationDiagnosisOptions =>
      throw _privateConstructorUsedError;

  /// Doğru tanı
  String? get auscultationCorrectDiagnosis =>
      throw _privateConstructorUsedError; // CPR Ritim mini oyun alanları
  /// Hedef BPM (varsayılan 110)
  int get targetBPM => throw _privateConstructorUsedError;

  /// Kompresyon sayısı (varsayılan 30)
  int get compressionCount => throw _privateConstructorUsedError;

  /// BPM toleransı (varsayılan 10)
  int get bpmTolerance =>
      throw _privateConstructorUsedError; // İlaç doz hesaplama mini oyun alanları
  /// İlaç adı
  String? get drugName => throw _privateConstructorUsedError;

  /// Doz aralığı (ör. "2-4 mg/kg")
  String? get drugDoseRange => throw _privateConstructorUsedError;

  /// Hasta kilosu (kg)
  double? get patientWeight => throw _privateConstructorUsedError;

  /// Hasta yaşı
  int? get patientAge => throw _privateConstructorUsedError;

  /// Hasta GFR (böbrek fonksiyonu)
  double? get patientGFR => throw _privateConstructorUsedError;

  /// Doğru toplam doz (mg)
  double? get correctDoseMg => throw _privateConstructorUsedError;

  /// Doğru IV damla hızı (ör. "100 mL/saat")
  String? get correctIVRate => throw _privateConstructorUsedError;

  /// Doz tolerans yüzdesi (varsayılan %10)
  double get doseTolerancePercent => throw _privateConstructorUsedError;

  /// Maksimum günlük doz (mg)
  double? get maxDailyDoseMg => throw _privateConstructorUsedError;

  /// Böbrek yetmezliğinde doz ayarı gerekli mi
  bool get kidneyAdjustmentNeeded =>
      throw _privateConstructorUsedError; // Mikroskop analizi mini oyun alanları
  /// Mikroskop tipi: "blood_smear" veya "urine_sediment"
  String? get microscopeType => throw _privateConstructorUsedError;

  /// Anormal hücre sayısı
  int? get abnormalCellCount => throw _privateConstructorUsedError;

  /// Anormal hücre tipi (ör. "Orak Hücre", "Blast Hücre", "Bakteri", "Kristal")
  String? get abnormalCellType => throw _privateConstructorUsedError;

  /// Tanı seçenekleri
  List<String> get microscopeDiagnosisOptions =>
      throw _privateConstructorUsedError;

  /// Doğru tanı
  String? get microscopeCorrectDiagnosis =>
      throw _privateConstructorUsedError; // Geriye uyumluluk (ballistic/interrogation) — eski alan adları
  Map<String, dynamic>? get impactPoint => throw _privateConstructorUsedError;
  double? get bulletTrajectoryAngle => throw _privateConstructorUsedError;
  String? get suspectName => throw _privateConstructorUsedError;
  String? get suspectImage => throw _privateConstructorUsedError;
  int? get initialStress => throw _privateConstructorUsedError;
  int? get stressThreshold => throw _privateConstructorUsedError;

  /// Serializes this MiniGameDef to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MiniGameDef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MiniGameDefCopyWith<MiniGameDef> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiniGameDefCopyWith<$Res> {
  factory $MiniGameDefCopyWith(
    MiniGameDef value,
    $Res Function(MiniGameDef) then,
  ) = _$MiniGameDefCopyWithImpl<$Res, MiniGameDef>;
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String description,
    String? trigger,
    String? sceneImage,
    int? timeLimitSeconds,
    double? correctX,
    double? correctY,
    double? correctAngle,
    double? tolerance,
    Map<String, dynamic>? targetArea,
    List<String> hints,
    String? patientName,
    String? patientImage,
    int? initialComfort,
    int? comfortThreshold,
    List<ExaminationQuestion> questions,
    List<String> criticalQuestions,
    List<String> optimalOrder,
    String? toxinName,
    String? toxinDescription,
    List<String> toxinSymptoms,
    List<ToxicologyOption> toxicologyOptions,
    int toxinSeverity,
    String? ekgAnomalyType,
    double? ekgAnomalyStartX,
    double? ekgAnomalyEndX,
    List<String> ekgDiagnosisOptions,
    String? ekgCorrectDiagnosis,
    List<AuscultationFinding> auscultationFindings,
    List<String> auscultationDiagnosisOptions,
    String? auscultationCorrectDiagnosis,
    int targetBPM,
    int compressionCount,
    int bpmTolerance,
    String? drugName,
    String? drugDoseRange,
    double? patientWeight,
    int? patientAge,
    double? patientGFR,
    double? correctDoseMg,
    String? correctIVRate,
    double doseTolerancePercent,
    double? maxDailyDoseMg,
    bool kidneyAdjustmentNeeded,
    String? microscopeType,
    int? abnormalCellCount,
    String? abnormalCellType,
    List<String> microscopeDiagnosisOptions,
    String? microscopeCorrectDiagnosis,
    Map<String, dynamic>? impactPoint,
    double? bulletTrajectoryAngle,
    String? suspectName,
    String? suspectImage,
    int? initialStress,
    int? stressThreshold,
  });
}

/// @nodoc
class _$MiniGameDefCopyWithImpl<$Res, $Val extends MiniGameDef>
    implements $MiniGameDefCopyWith<$Res> {
  _$MiniGameDefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MiniGameDef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? trigger = freezed,
    Object? sceneImage = freezed,
    Object? timeLimitSeconds = freezed,
    Object? correctX = freezed,
    Object? correctY = freezed,
    Object? correctAngle = freezed,
    Object? tolerance = freezed,
    Object? targetArea = freezed,
    Object? hints = null,
    Object? patientName = freezed,
    Object? patientImage = freezed,
    Object? initialComfort = freezed,
    Object? comfortThreshold = freezed,
    Object? questions = null,
    Object? criticalQuestions = null,
    Object? optimalOrder = null,
    Object? toxinName = freezed,
    Object? toxinDescription = freezed,
    Object? toxinSymptoms = null,
    Object? toxicologyOptions = null,
    Object? toxinSeverity = null,
    Object? ekgAnomalyType = freezed,
    Object? ekgAnomalyStartX = freezed,
    Object? ekgAnomalyEndX = freezed,
    Object? ekgDiagnosisOptions = null,
    Object? ekgCorrectDiagnosis = freezed,
    Object? auscultationFindings = null,
    Object? auscultationDiagnosisOptions = null,
    Object? auscultationCorrectDiagnosis = freezed,
    Object? targetBPM = null,
    Object? compressionCount = null,
    Object? bpmTolerance = null,
    Object? drugName = freezed,
    Object? drugDoseRange = freezed,
    Object? patientWeight = freezed,
    Object? patientAge = freezed,
    Object? patientGFR = freezed,
    Object? correctDoseMg = freezed,
    Object? correctIVRate = freezed,
    Object? doseTolerancePercent = null,
    Object? maxDailyDoseMg = freezed,
    Object? kidneyAdjustmentNeeded = null,
    Object? microscopeType = freezed,
    Object? abnormalCellCount = freezed,
    Object? abnormalCellType = freezed,
    Object? microscopeDiagnosisOptions = null,
    Object? microscopeCorrectDiagnosis = freezed,
    Object? impactPoint = freezed,
    Object? bulletTrajectoryAngle = freezed,
    Object? suspectName = freezed,
    Object? suspectImage = freezed,
    Object? initialStress = freezed,
    Object? stressThreshold = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            trigger: freezed == trigger
                ? _value.trigger
                : trigger // ignore: cast_nullable_to_non_nullable
                      as String?,
            sceneImage: freezed == sceneImage
                ? _value.sceneImage
                : sceneImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            timeLimitSeconds: freezed == timeLimitSeconds
                ? _value.timeLimitSeconds
                : timeLimitSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            correctX: freezed == correctX
                ? _value.correctX
                : correctX // ignore: cast_nullable_to_non_nullable
                      as double?,
            correctY: freezed == correctY
                ? _value.correctY
                : correctY // ignore: cast_nullable_to_non_nullable
                      as double?,
            correctAngle: freezed == correctAngle
                ? _value.correctAngle
                : correctAngle // ignore: cast_nullable_to_non_nullable
                      as double?,
            tolerance: freezed == tolerance
                ? _value.tolerance
                : tolerance // ignore: cast_nullable_to_non_nullable
                      as double?,
            targetArea: freezed == targetArea
                ? _value.targetArea
                : targetArea // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            hints: null == hints
                ? _value.hints
                : hints // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            patientName: freezed == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                      as String?,
            patientImage: freezed == patientImage
                ? _value.patientImage
                : patientImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            initialComfort: freezed == initialComfort
                ? _value.initialComfort
                : initialComfort // ignore: cast_nullable_to_non_nullable
                      as int?,
            comfortThreshold: freezed == comfortThreshold
                ? _value.comfortThreshold
                : comfortThreshold // ignore: cast_nullable_to_non_nullable
                      as int?,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<ExaminationQuestion>,
            criticalQuestions: null == criticalQuestions
                ? _value.criticalQuestions
                : criticalQuestions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            optimalOrder: null == optimalOrder
                ? _value.optimalOrder
                : optimalOrder // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            toxinName: freezed == toxinName
                ? _value.toxinName
                : toxinName // ignore: cast_nullable_to_non_nullable
                      as String?,
            toxinDescription: freezed == toxinDescription
                ? _value.toxinDescription
                : toxinDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            toxinSymptoms: null == toxinSymptoms
                ? _value.toxinSymptoms
                : toxinSymptoms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            toxicologyOptions: null == toxicologyOptions
                ? _value.toxicologyOptions
                : toxicologyOptions // ignore: cast_nullable_to_non_nullable
                      as List<ToxicologyOption>,
            toxinSeverity: null == toxinSeverity
                ? _value.toxinSeverity
                : toxinSeverity // ignore: cast_nullable_to_non_nullable
                      as int,
            ekgAnomalyType: freezed == ekgAnomalyType
                ? _value.ekgAnomalyType
                : ekgAnomalyType // ignore: cast_nullable_to_non_nullable
                      as String?,
            ekgAnomalyStartX: freezed == ekgAnomalyStartX
                ? _value.ekgAnomalyStartX
                : ekgAnomalyStartX // ignore: cast_nullable_to_non_nullable
                      as double?,
            ekgAnomalyEndX: freezed == ekgAnomalyEndX
                ? _value.ekgAnomalyEndX
                : ekgAnomalyEndX // ignore: cast_nullable_to_non_nullable
                      as double?,
            ekgDiagnosisOptions: null == ekgDiagnosisOptions
                ? _value.ekgDiagnosisOptions
                : ekgDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            ekgCorrectDiagnosis: freezed == ekgCorrectDiagnosis
                ? _value.ekgCorrectDiagnosis
                : ekgCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                      as String?,
            auscultationFindings: null == auscultationFindings
                ? _value.auscultationFindings
                : auscultationFindings // ignore: cast_nullable_to_non_nullable
                      as List<AuscultationFinding>,
            auscultationDiagnosisOptions: null == auscultationDiagnosisOptions
                ? _value.auscultationDiagnosisOptions
                : auscultationDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            auscultationCorrectDiagnosis:
                freezed == auscultationCorrectDiagnosis
                ? _value.auscultationCorrectDiagnosis
                : auscultationCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetBPM: null == targetBPM
                ? _value.targetBPM
                : targetBPM // ignore: cast_nullable_to_non_nullable
                      as int,
            compressionCount: null == compressionCount
                ? _value.compressionCount
                : compressionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            bpmTolerance: null == bpmTolerance
                ? _value.bpmTolerance
                : bpmTolerance // ignore: cast_nullable_to_non_nullable
                      as int,
            drugName: freezed == drugName
                ? _value.drugName
                : drugName // ignore: cast_nullable_to_non_nullable
                      as String?,
            drugDoseRange: freezed == drugDoseRange
                ? _value.drugDoseRange
                : drugDoseRange // ignore: cast_nullable_to_non_nullable
                      as String?,
            patientWeight: freezed == patientWeight
                ? _value.patientWeight
                : patientWeight // ignore: cast_nullable_to_non_nullable
                      as double?,
            patientAge: freezed == patientAge
                ? _value.patientAge
                : patientAge // ignore: cast_nullable_to_non_nullable
                      as int?,
            patientGFR: freezed == patientGFR
                ? _value.patientGFR
                : patientGFR // ignore: cast_nullable_to_non_nullable
                      as double?,
            correctDoseMg: freezed == correctDoseMg
                ? _value.correctDoseMg
                : correctDoseMg // ignore: cast_nullable_to_non_nullable
                      as double?,
            correctIVRate: freezed == correctIVRate
                ? _value.correctIVRate
                : correctIVRate // ignore: cast_nullable_to_non_nullable
                      as String?,
            doseTolerancePercent: null == doseTolerancePercent
                ? _value.doseTolerancePercent
                : doseTolerancePercent // ignore: cast_nullable_to_non_nullable
                      as double,
            maxDailyDoseMg: freezed == maxDailyDoseMg
                ? _value.maxDailyDoseMg
                : maxDailyDoseMg // ignore: cast_nullable_to_non_nullable
                      as double?,
            kidneyAdjustmentNeeded: null == kidneyAdjustmentNeeded
                ? _value.kidneyAdjustmentNeeded
                : kidneyAdjustmentNeeded // ignore: cast_nullable_to_non_nullable
                      as bool,
            microscopeType: freezed == microscopeType
                ? _value.microscopeType
                : microscopeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            abnormalCellCount: freezed == abnormalCellCount
                ? _value.abnormalCellCount
                : abnormalCellCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            abnormalCellType: freezed == abnormalCellType
                ? _value.abnormalCellType
                : abnormalCellType // ignore: cast_nullable_to_non_nullable
                      as String?,
            microscopeDiagnosisOptions: null == microscopeDiagnosisOptions
                ? _value.microscopeDiagnosisOptions
                : microscopeDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            microscopeCorrectDiagnosis: freezed == microscopeCorrectDiagnosis
                ? _value.microscopeCorrectDiagnosis
                : microscopeCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                      as String?,
            impactPoint: freezed == impactPoint
                ? _value.impactPoint
                : impactPoint // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            bulletTrajectoryAngle: freezed == bulletTrajectoryAngle
                ? _value.bulletTrajectoryAngle
                : bulletTrajectoryAngle // ignore: cast_nullable_to_non_nullable
                      as double?,
            suspectName: freezed == suspectName
                ? _value.suspectName
                : suspectName // ignore: cast_nullable_to_non_nullable
                      as String?,
            suspectImage: freezed == suspectImage
                ? _value.suspectImage
                : suspectImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            initialStress: freezed == initialStress
                ? _value.initialStress
                : initialStress // ignore: cast_nullable_to_non_nullable
                      as int?,
            stressThreshold: freezed == stressThreshold
                ? _value.stressThreshold
                : stressThreshold // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MiniGameDefImplCopyWith<$Res>
    implements $MiniGameDefCopyWith<$Res> {
  factory _$$MiniGameDefImplCopyWith(
    _$MiniGameDefImpl value,
    $Res Function(_$MiniGameDefImpl) then,
  ) = __$$MiniGameDefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String title,
    String description,
    String? trigger,
    String? sceneImage,
    int? timeLimitSeconds,
    double? correctX,
    double? correctY,
    double? correctAngle,
    double? tolerance,
    Map<String, dynamic>? targetArea,
    List<String> hints,
    String? patientName,
    String? patientImage,
    int? initialComfort,
    int? comfortThreshold,
    List<ExaminationQuestion> questions,
    List<String> criticalQuestions,
    List<String> optimalOrder,
    String? toxinName,
    String? toxinDescription,
    List<String> toxinSymptoms,
    List<ToxicologyOption> toxicologyOptions,
    int toxinSeverity,
    String? ekgAnomalyType,
    double? ekgAnomalyStartX,
    double? ekgAnomalyEndX,
    List<String> ekgDiagnosisOptions,
    String? ekgCorrectDiagnosis,
    List<AuscultationFinding> auscultationFindings,
    List<String> auscultationDiagnosisOptions,
    String? auscultationCorrectDiagnosis,
    int targetBPM,
    int compressionCount,
    int bpmTolerance,
    String? drugName,
    String? drugDoseRange,
    double? patientWeight,
    int? patientAge,
    double? patientGFR,
    double? correctDoseMg,
    String? correctIVRate,
    double doseTolerancePercent,
    double? maxDailyDoseMg,
    bool kidneyAdjustmentNeeded,
    String? microscopeType,
    int? abnormalCellCount,
    String? abnormalCellType,
    List<String> microscopeDiagnosisOptions,
    String? microscopeCorrectDiagnosis,
    Map<String, dynamic>? impactPoint,
    double? bulletTrajectoryAngle,
    String? suspectName,
    String? suspectImage,
    int? initialStress,
    int? stressThreshold,
  });
}

/// @nodoc
class __$$MiniGameDefImplCopyWithImpl<$Res>
    extends _$MiniGameDefCopyWithImpl<$Res, _$MiniGameDefImpl>
    implements _$$MiniGameDefImplCopyWith<$Res> {
  __$$MiniGameDefImplCopyWithImpl(
    _$MiniGameDefImpl _value,
    $Res Function(_$MiniGameDefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MiniGameDef
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? description = null,
    Object? trigger = freezed,
    Object? sceneImage = freezed,
    Object? timeLimitSeconds = freezed,
    Object? correctX = freezed,
    Object? correctY = freezed,
    Object? correctAngle = freezed,
    Object? tolerance = freezed,
    Object? targetArea = freezed,
    Object? hints = null,
    Object? patientName = freezed,
    Object? patientImage = freezed,
    Object? initialComfort = freezed,
    Object? comfortThreshold = freezed,
    Object? questions = null,
    Object? criticalQuestions = null,
    Object? optimalOrder = null,
    Object? toxinName = freezed,
    Object? toxinDescription = freezed,
    Object? toxinSymptoms = null,
    Object? toxicologyOptions = null,
    Object? toxinSeverity = null,
    Object? ekgAnomalyType = freezed,
    Object? ekgAnomalyStartX = freezed,
    Object? ekgAnomalyEndX = freezed,
    Object? ekgDiagnosisOptions = null,
    Object? ekgCorrectDiagnosis = freezed,
    Object? auscultationFindings = null,
    Object? auscultationDiagnosisOptions = null,
    Object? auscultationCorrectDiagnosis = freezed,
    Object? targetBPM = null,
    Object? compressionCount = null,
    Object? bpmTolerance = null,
    Object? drugName = freezed,
    Object? drugDoseRange = freezed,
    Object? patientWeight = freezed,
    Object? patientAge = freezed,
    Object? patientGFR = freezed,
    Object? correctDoseMg = freezed,
    Object? correctIVRate = freezed,
    Object? doseTolerancePercent = null,
    Object? maxDailyDoseMg = freezed,
    Object? kidneyAdjustmentNeeded = null,
    Object? microscopeType = freezed,
    Object? abnormalCellCount = freezed,
    Object? abnormalCellType = freezed,
    Object? microscopeDiagnosisOptions = null,
    Object? microscopeCorrectDiagnosis = freezed,
    Object? impactPoint = freezed,
    Object? bulletTrajectoryAngle = freezed,
    Object? suspectName = freezed,
    Object? suspectImage = freezed,
    Object? initialStress = freezed,
    Object? stressThreshold = freezed,
  }) {
    return _then(
      _$MiniGameDefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        trigger: freezed == trigger
            ? _value.trigger
            : trigger // ignore: cast_nullable_to_non_nullable
                  as String?,
        sceneImage: freezed == sceneImage
            ? _value.sceneImage
            : sceneImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        timeLimitSeconds: freezed == timeLimitSeconds
            ? _value.timeLimitSeconds
            : timeLimitSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        correctX: freezed == correctX
            ? _value.correctX
            : correctX // ignore: cast_nullable_to_non_nullable
                  as double?,
        correctY: freezed == correctY
            ? _value.correctY
            : correctY // ignore: cast_nullable_to_non_nullable
                  as double?,
        correctAngle: freezed == correctAngle
            ? _value.correctAngle
            : correctAngle // ignore: cast_nullable_to_non_nullable
                  as double?,
        tolerance: freezed == tolerance
            ? _value.tolerance
            : tolerance // ignore: cast_nullable_to_non_nullable
                  as double?,
        targetArea: freezed == targetArea
            ? _value._targetArea
            : targetArea // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        hints: null == hints
            ? _value._hints
            : hints // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        patientName: freezed == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String?,
        patientImage: freezed == patientImage
            ? _value.patientImage
            : patientImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        initialComfort: freezed == initialComfort
            ? _value.initialComfort
            : initialComfort // ignore: cast_nullable_to_non_nullable
                  as int?,
        comfortThreshold: freezed == comfortThreshold
            ? _value.comfortThreshold
            : comfortThreshold // ignore: cast_nullable_to_non_nullable
                  as int?,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<ExaminationQuestion>,
        criticalQuestions: null == criticalQuestions
            ? _value._criticalQuestions
            : criticalQuestions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        optimalOrder: null == optimalOrder
            ? _value._optimalOrder
            : optimalOrder // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        toxinName: freezed == toxinName
            ? _value.toxinName
            : toxinName // ignore: cast_nullable_to_non_nullable
                  as String?,
        toxinDescription: freezed == toxinDescription
            ? _value.toxinDescription
            : toxinDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        toxinSymptoms: null == toxinSymptoms
            ? _value._toxinSymptoms
            : toxinSymptoms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        toxicologyOptions: null == toxicologyOptions
            ? _value._toxicologyOptions
            : toxicologyOptions // ignore: cast_nullable_to_non_nullable
                  as List<ToxicologyOption>,
        toxinSeverity: null == toxinSeverity
            ? _value.toxinSeverity
            : toxinSeverity // ignore: cast_nullable_to_non_nullable
                  as int,
        ekgAnomalyType: freezed == ekgAnomalyType
            ? _value.ekgAnomalyType
            : ekgAnomalyType // ignore: cast_nullable_to_non_nullable
                  as String?,
        ekgAnomalyStartX: freezed == ekgAnomalyStartX
            ? _value.ekgAnomalyStartX
            : ekgAnomalyStartX // ignore: cast_nullable_to_non_nullable
                  as double?,
        ekgAnomalyEndX: freezed == ekgAnomalyEndX
            ? _value.ekgAnomalyEndX
            : ekgAnomalyEndX // ignore: cast_nullable_to_non_nullable
                  as double?,
        ekgDiagnosisOptions: null == ekgDiagnosisOptions
            ? _value._ekgDiagnosisOptions
            : ekgDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        ekgCorrectDiagnosis: freezed == ekgCorrectDiagnosis
            ? _value.ekgCorrectDiagnosis
            : ekgCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                  as String?,
        auscultationFindings: null == auscultationFindings
            ? _value._auscultationFindings
            : auscultationFindings // ignore: cast_nullable_to_non_nullable
                  as List<AuscultationFinding>,
        auscultationDiagnosisOptions: null == auscultationDiagnosisOptions
            ? _value._auscultationDiagnosisOptions
            : auscultationDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        auscultationCorrectDiagnosis: freezed == auscultationCorrectDiagnosis
            ? _value.auscultationCorrectDiagnosis
            : auscultationCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetBPM: null == targetBPM
            ? _value.targetBPM
            : targetBPM // ignore: cast_nullable_to_non_nullable
                  as int,
        compressionCount: null == compressionCount
            ? _value.compressionCount
            : compressionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        bpmTolerance: null == bpmTolerance
            ? _value.bpmTolerance
            : bpmTolerance // ignore: cast_nullable_to_non_nullable
                  as int,
        drugName: freezed == drugName
            ? _value.drugName
            : drugName // ignore: cast_nullable_to_non_nullable
                  as String?,
        drugDoseRange: freezed == drugDoseRange
            ? _value.drugDoseRange
            : drugDoseRange // ignore: cast_nullable_to_non_nullable
                  as String?,
        patientWeight: freezed == patientWeight
            ? _value.patientWeight
            : patientWeight // ignore: cast_nullable_to_non_nullable
                  as double?,
        patientAge: freezed == patientAge
            ? _value.patientAge
            : patientAge // ignore: cast_nullable_to_non_nullable
                  as int?,
        patientGFR: freezed == patientGFR
            ? _value.patientGFR
            : patientGFR // ignore: cast_nullable_to_non_nullable
                  as double?,
        correctDoseMg: freezed == correctDoseMg
            ? _value.correctDoseMg
            : correctDoseMg // ignore: cast_nullable_to_non_nullable
                  as double?,
        correctIVRate: freezed == correctIVRate
            ? _value.correctIVRate
            : correctIVRate // ignore: cast_nullable_to_non_nullable
                  as String?,
        doseTolerancePercent: null == doseTolerancePercent
            ? _value.doseTolerancePercent
            : doseTolerancePercent // ignore: cast_nullable_to_non_nullable
                  as double,
        maxDailyDoseMg: freezed == maxDailyDoseMg
            ? _value.maxDailyDoseMg
            : maxDailyDoseMg // ignore: cast_nullable_to_non_nullable
                  as double?,
        kidneyAdjustmentNeeded: null == kidneyAdjustmentNeeded
            ? _value.kidneyAdjustmentNeeded
            : kidneyAdjustmentNeeded // ignore: cast_nullable_to_non_nullable
                  as bool,
        microscopeType: freezed == microscopeType
            ? _value.microscopeType
            : microscopeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        abnormalCellCount: freezed == abnormalCellCount
            ? _value.abnormalCellCount
            : abnormalCellCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        abnormalCellType: freezed == abnormalCellType
            ? _value.abnormalCellType
            : abnormalCellType // ignore: cast_nullable_to_non_nullable
                  as String?,
        microscopeDiagnosisOptions: null == microscopeDiagnosisOptions
            ? _value._microscopeDiagnosisOptions
            : microscopeDiagnosisOptions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        microscopeCorrectDiagnosis: freezed == microscopeCorrectDiagnosis
            ? _value.microscopeCorrectDiagnosis
            : microscopeCorrectDiagnosis // ignore: cast_nullable_to_non_nullable
                  as String?,
        impactPoint: freezed == impactPoint
            ? _value._impactPoint
            : impactPoint // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        bulletTrajectoryAngle: freezed == bulletTrajectoryAngle
            ? _value.bulletTrajectoryAngle
            : bulletTrajectoryAngle // ignore: cast_nullable_to_non_nullable
                  as double?,
        suspectName: freezed == suspectName
            ? _value.suspectName
            : suspectName // ignore: cast_nullable_to_non_nullable
                  as String?,
        suspectImage: freezed == suspectImage
            ? _value.suspectImage
            : suspectImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        initialStress: freezed == initialStress
            ? _value.initialStress
            : initialStress // ignore: cast_nullable_to_non_nullable
                  as int?,
        stressThreshold: freezed == stressThreshold
            ? _value.stressThreshold
            : stressThreshold // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MiniGameDefImpl implements _MiniGameDef {
  const _$MiniGameDefImpl({
    this.id = '',
    this.type = '',
    this.title = '',
    this.description = '',
    this.trigger,
    this.sceneImage,
    this.timeLimitSeconds,
    this.correctX,
    this.correctY,
    this.correctAngle,
    this.tolerance,
    final Map<String, dynamic>? targetArea,
    final List<String> hints = const [],
    this.patientName,
    this.patientImage,
    this.initialComfort,
    this.comfortThreshold,
    final List<ExaminationQuestion> questions = const [],
    final List<String> criticalQuestions = const [],
    final List<String> optimalOrder = const [],
    this.toxinName,
    this.toxinDescription,
    final List<String> toxinSymptoms = const [],
    final List<ToxicologyOption> toxicologyOptions = const [],
    this.toxinSeverity = 5,
    this.ekgAnomalyType,
    this.ekgAnomalyStartX,
    this.ekgAnomalyEndX,
    final List<String> ekgDiagnosisOptions = const [],
    this.ekgCorrectDiagnosis,
    final List<AuscultationFinding> auscultationFindings = const [],
    final List<String> auscultationDiagnosisOptions = const [],
    this.auscultationCorrectDiagnosis,
    this.targetBPM = 110,
    this.compressionCount = 30,
    this.bpmTolerance = 10,
    this.drugName,
    this.drugDoseRange,
    this.patientWeight,
    this.patientAge,
    this.patientGFR,
    this.correctDoseMg,
    this.correctIVRate,
    this.doseTolerancePercent = 10,
    this.maxDailyDoseMg,
    this.kidneyAdjustmentNeeded = false,
    this.microscopeType,
    this.abnormalCellCount,
    this.abnormalCellType,
    final List<String> microscopeDiagnosisOptions = const [],
    this.microscopeCorrectDiagnosis,
    final Map<String, dynamic>? impactPoint,
    this.bulletTrajectoryAngle,
    this.suspectName,
    this.suspectImage,
    this.initialStress,
    this.stressThreshold,
  }) : _targetArea = targetArea,
       _hints = hints,
       _questions = questions,
       _criticalQuestions = criticalQuestions,
       _optimalOrder = optimalOrder,
       _toxinSymptoms = toxinSymptoms,
       _toxicologyOptions = toxicologyOptions,
       _ekgDiagnosisOptions = ekgDiagnosisOptions,
       _auscultationFindings = auscultationFindings,
       _auscultationDiagnosisOptions = auscultationDiagnosisOptions,
       _microscopeDiagnosisOptions = microscopeDiagnosisOptions,
       _impactPoint = impactPoint;

  factory _$MiniGameDefImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiniGameDefImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  /// Tip: "imaging_analysis" veya "examination"
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  final String? trigger;
  @override
  final String? sceneImage;
  @override
  final int? timeLimitSeconds;
  // Görüntüleme analizi alanları (röntgen/MR'da anomali bul)
  @override
  final double? correctX;
  @override
  final double? correctY;
  @override
  final double? correctAngle;
  @override
  final double? tolerance;
  final Map<String, dynamic>? _targetArea;
  @override
  Map<String, dynamic>? get targetArea {
    final value = _targetArea;
    if (value == null) return null;
    if (_targetArea is EqualUnmodifiableMapView) return _targetArea;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String> _hints;
  @override
  @JsonKey()
  List<String> get hints {
    if (_hints is EqualUnmodifiableListView) return _hints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hints);
  }

  // Muayene mini oyun alanları (doğru soruları sor)
  @override
  final String? patientName;
  @override
  final String? patientImage;
  @override
  final int? initialComfort;
  @override
  final int? comfortThreshold;
  final List<ExaminationQuestion> _questions;
  @override
  @JsonKey()
  List<ExaminationQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  final List<String> _criticalQuestions;
  @override
  @JsonKey()
  List<String> get criticalQuestions {
    if (_criticalQuestions is EqualUnmodifiableListView)
      return _criticalQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_criticalQuestions);
  }

  final List<String> _optimalOrder;
  @override
  @JsonKey()
  List<String> get optimalOrder {
    if (_optimalOrder is EqualUnmodifiableListView) return _optimalOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optimalOrder);
  }

  // Toksikoloji lab mini oyun alanları (doğru antidotu/tedaviyi seç)
  /// Toksik madde adı
  @override
  final String? toxinName;

  /// Toksin açıklaması
  @override
  final String? toxinDescription;

  /// Semptom listesi
  final List<String> _toxinSymptoms;

  /// Semptom listesi
  @override
  @JsonKey()
  List<String> get toxinSymptoms {
    if (_toxinSymptoms is EqualUnmodifiableListView) return _toxinSymptoms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toxinSymptoms);
  }

  /// Antidot/tedavi seçenekleri
  final List<ToxicologyOption> _toxicologyOptions;

  /// Antidot/tedavi seçenekleri
  @override
  @JsonKey()
  List<ToxicologyOption> get toxicologyOptions {
    if (_toxicologyOptions is EqualUnmodifiableListView)
      return _toxicologyOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toxicologyOptions);
  }

  /// Toksin yoğunluk seviyesi (1-10) — süre baskısı
  @override
  @JsonKey()
  final int toxinSeverity;
  // EKG okuma mini oyun alanları
  /// Anomali tipi: "st_elevation", "atrial_fibrillation", "prolonged_qt", "ventricular_tachycardia"
  @override
  final String? ekgAnomalyType;

  /// Anomali başlangıç pozisyonu (0-1 normalize)
  @override
  final double? ekgAnomalyStartX;

  /// Anomali bitiş pozisyonu (0-1 normalize)
  @override
  final double? ekgAnomalyEndX;

  /// Teşhis seçenekleri
  final List<String> _ekgDiagnosisOptions;

  /// Teşhis seçenekleri
  @override
  @JsonKey()
  List<String> get ekgDiagnosisOptions {
    if (_ekgDiagnosisOptions is EqualUnmodifiableListView)
      return _ekgDiagnosisOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ekgDiagnosisOptions);
  }

  /// Doğru teşhis
  @override
  final String? ekgCorrectDiagnosis;
  // Oskültasyon (stetoskop) mini oyun alanları
  /// Oskültasyon noktaları ve bulguları
  final List<AuscultationFinding> _auscultationFindings;
  // Oskültasyon (stetoskop) mini oyun alanları
  /// Oskültasyon noktaları ve bulguları
  @override
  @JsonKey()
  List<AuscultationFinding> get auscultationFindings {
    if (_auscultationFindings is EqualUnmodifiableListView)
      return _auscultationFindings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auscultationFindings);
  }

  /// Tanı seçenekleri
  final List<String> _auscultationDiagnosisOptions;

  /// Tanı seçenekleri
  @override
  @JsonKey()
  List<String> get auscultationDiagnosisOptions {
    if (_auscultationDiagnosisOptions is EqualUnmodifiableListView)
      return _auscultationDiagnosisOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_auscultationDiagnosisOptions);
  }

  /// Doğru tanı
  @override
  final String? auscultationCorrectDiagnosis;
  // CPR Ritim mini oyun alanları
  /// Hedef BPM (varsayılan 110)
  @override
  @JsonKey()
  final int targetBPM;

  /// Kompresyon sayısı (varsayılan 30)
  @override
  @JsonKey()
  final int compressionCount;

  /// BPM toleransı (varsayılan 10)
  @override
  @JsonKey()
  final int bpmTolerance;
  // İlaç doz hesaplama mini oyun alanları
  /// İlaç adı
  @override
  final String? drugName;

  /// Doz aralığı (ör. "2-4 mg/kg")
  @override
  final String? drugDoseRange;

  /// Hasta kilosu (kg)
  @override
  final double? patientWeight;

  /// Hasta yaşı
  @override
  final int? patientAge;

  /// Hasta GFR (böbrek fonksiyonu)
  @override
  final double? patientGFR;

  /// Doğru toplam doz (mg)
  @override
  final double? correctDoseMg;

  /// Doğru IV damla hızı (ör. "100 mL/saat")
  @override
  final String? correctIVRate;

  /// Doz tolerans yüzdesi (varsayılan %10)
  @override
  @JsonKey()
  final double doseTolerancePercent;

  /// Maksimum günlük doz (mg)
  @override
  final double? maxDailyDoseMg;

  /// Böbrek yetmezliğinde doz ayarı gerekli mi
  @override
  @JsonKey()
  final bool kidneyAdjustmentNeeded;
  // Mikroskop analizi mini oyun alanları
  /// Mikroskop tipi: "blood_smear" veya "urine_sediment"
  @override
  final String? microscopeType;

  /// Anormal hücre sayısı
  @override
  final int? abnormalCellCount;

  /// Anormal hücre tipi (ör. "Orak Hücre", "Blast Hücre", "Bakteri", "Kristal")
  @override
  final String? abnormalCellType;

  /// Tanı seçenekleri
  final List<String> _microscopeDiagnosisOptions;

  /// Tanı seçenekleri
  @override
  @JsonKey()
  List<String> get microscopeDiagnosisOptions {
    if (_microscopeDiagnosisOptions is EqualUnmodifiableListView)
      return _microscopeDiagnosisOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_microscopeDiagnosisOptions);
  }

  /// Doğru tanı
  @override
  final String? microscopeCorrectDiagnosis;
  // Geriye uyumluluk (ballistic/interrogation) — eski alan adları
  final Map<String, dynamic>? _impactPoint;
  // Geriye uyumluluk (ballistic/interrogation) — eski alan adları
  @override
  Map<String, dynamic>? get impactPoint {
    final value = _impactPoint;
    if (value == null) return null;
    if (_impactPoint is EqualUnmodifiableMapView) return _impactPoint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double? bulletTrajectoryAngle;
  @override
  final String? suspectName;
  @override
  final String? suspectImage;
  @override
  final int? initialStress;
  @override
  final int? stressThreshold;

  @override
  String toString() {
    return 'MiniGameDef(id: $id, type: $type, title: $title, description: $description, trigger: $trigger, sceneImage: $sceneImage, timeLimitSeconds: $timeLimitSeconds, correctX: $correctX, correctY: $correctY, correctAngle: $correctAngle, tolerance: $tolerance, targetArea: $targetArea, hints: $hints, patientName: $patientName, patientImage: $patientImage, initialComfort: $initialComfort, comfortThreshold: $comfortThreshold, questions: $questions, criticalQuestions: $criticalQuestions, optimalOrder: $optimalOrder, toxinName: $toxinName, toxinDescription: $toxinDescription, toxinSymptoms: $toxinSymptoms, toxicologyOptions: $toxicologyOptions, toxinSeverity: $toxinSeverity, ekgAnomalyType: $ekgAnomalyType, ekgAnomalyStartX: $ekgAnomalyStartX, ekgAnomalyEndX: $ekgAnomalyEndX, ekgDiagnosisOptions: $ekgDiagnosisOptions, ekgCorrectDiagnosis: $ekgCorrectDiagnosis, auscultationFindings: $auscultationFindings, auscultationDiagnosisOptions: $auscultationDiagnosisOptions, auscultationCorrectDiagnosis: $auscultationCorrectDiagnosis, targetBPM: $targetBPM, compressionCount: $compressionCount, bpmTolerance: $bpmTolerance, drugName: $drugName, drugDoseRange: $drugDoseRange, patientWeight: $patientWeight, patientAge: $patientAge, patientGFR: $patientGFR, correctDoseMg: $correctDoseMg, correctIVRate: $correctIVRate, doseTolerancePercent: $doseTolerancePercent, maxDailyDoseMg: $maxDailyDoseMg, kidneyAdjustmentNeeded: $kidneyAdjustmentNeeded, microscopeType: $microscopeType, abnormalCellCount: $abnormalCellCount, abnormalCellType: $abnormalCellType, microscopeDiagnosisOptions: $microscopeDiagnosisOptions, microscopeCorrectDiagnosis: $microscopeCorrectDiagnosis, impactPoint: $impactPoint, bulletTrajectoryAngle: $bulletTrajectoryAngle, suspectName: $suspectName, suspectImage: $suspectImage, initialStress: $initialStress, stressThreshold: $stressThreshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiniGameDefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.sceneImage, sceneImage) ||
                other.sceneImage == sceneImage) &&
            (identical(other.timeLimitSeconds, timeLimitSeconds) ||
                other.timeLimitSeconds == timeLimitSeconds) &&
            (identical(other.correctX, correctX) ||
                other.correctX == correctX) &&
            (identical(other.correctY, correctY) ||
                other.correctY == correctY) &&
            (identical(other.correctAngle, correctAngle) ||
                other.correctAngle == correctAngle) &&
            (identical(other.tolerance, tolerance) ||
                other.tolerance == tolerance) &&
            const DeepCollectionEquality().equals(
              other._targetArea,
              _targetArea,
            ) &&
            const DeepCollectionEquality().equals(other._hints, _hints) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.patientImage, patientImage) ||
                other.patientImage == patientImage) &&
            (identical(other.initialComfort, initialComfort) ||
                other.initialComfort == initialComfort) &&
            (identical(other.comfortThreshold, comfortThreshold) ||
                other.comfortThreshold == comfortThreshold) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            const DeepCollectionEquality().equals(
              other._criticalQuestions,
              _criticalQuestions,
            ) &&
            const DeepCollectionEquality().equals(
              other._optimalOrder,
              _optimalOrder,
            ) &&
            (identical(other.toxinName, toxinName) ||
                other.toxinName == toxinName) &&
            (identical(other.toxinDescription, toxinDescription) ||
                other.toxinDescription == toxinDescription) &&
            const DeepCollectionEquality().equals(
              other._toxinSymptoms,
              _toxinSymptoms,
            ) &&
            const DeepCollectionEquality().equals(
              other._toxicologyOptions,
              _toxicologyOptions,
            ) &&
            (identical(other.toxinSeverity, toxinSeverity) ||
                other.toxinSeverity == toxinSeverity) &&
            (identical(other.ekgAnomalyType, ekgAnomalyType) ||
                other.ekgAnomalyType == ekgAnomalyType) &&
            (identical(other.ekgAnomalyStartX, ekgAnomalyStartX) ||
                other.ekgAnomalyStartX == ekgAnomalyStartX) &&
            (identical(other.ekgAnomalyEndX, ekgAnomalyEndX) ||
                other.ekgAnomalyEndX == ekgAnomalyEndX) &&
            const DeepCollectionEquality().equals(
              other._ekgDiagnosisOptions,
              _ekgDiagnosisOptions,
            ) &&
            (identical(other.ekgCorrectDiagnosis, ekgCorrectDiagnosis) ||
                other.ekgCorrectDiagnosis == ekgCorrectDiagnosis) &&
            const DeepCollectionEquality().equals(
              other._auscultationFindings,
              _auscultationFindings,
            ) &&
            const DeepCollectionEquality().equals(
              other._auscultationDiagnosisOptions,
              _auscultationDiagnosisOptions,
            ) &&
            (identical(
                  other.auscultationCorrectDiagnosis,
                  auscultationCorrectDiagnosis,
                ) ||
                other.auscultationCorrectDiagnosis ==
                    auscultationCorrectDiagnosis) &&
            (identical(other.targetBPM, targetBPM) ||
                other.targetBPM == targetBPM) &&
            (identical(other.compressionCount, compressionCount) ||
                other.compressionCount == compressionCount) &&
            (identical(other.bpmTolerance, bpmTolerance) ||
                other.bpmTolerance == bpmTolerance) &&
            (identical(other.drugName, drugName) ||
                other.drugName == drugName) &&
            (identical(other.drugDoseRange, drugDoseRange) ||
                other.drugDoseRange == drugDoseRange) &&
            (identical(other.patientWeight, patientWeight) ||
                other.patientWeight == patientWeight) &&
            (identical(other.patientAge, patientAge) ||
                other.patientAge == patientAge) &&
            (identical(other.patientGFR, patientGFR) ||
                other.patientGFR == patientGFR) &&
            (identical(other.correctDoseMg, correctDoseMg) ||
                other.correctDoseMg == correctDoseMg) &&
            (identical(other.correctIVRate, correctIVRate) ||
                other.correctIVRate == correctIVRate) &&
            (identical(other.doseTolerancePercent, doseTolerancePercent) ||
                other.doseTolerancePercent == doseTolerancePercent) &&
            (identical(other.maxDailyDoseMg, maxDailyDoseMg) ||
                other.maxDailyDoseMg == maxDailyDoseMg) &&
            (identical(other.kidneyAdjustmentNeeded, kidneyAdjustmentNeeded) ||
                other.kidneyAdjustmentNeeded == kidneyAdjustmentNeeded) &&
            (identical(other.microscopeType, microscopeType) ||
                other.microscopeType == microscopeType) &&
            (identical(other.abnormalCellCount, abnormalCellCount) ||
                other.abnormalCellCount == abnormalCellCount) &&
            (identical(other.abnormalCellType, abnormalCellType) ||
                other.abnormalCellType == abnormalCellType) &&
            const DeepCollectionEquality().equals(
              other._microscopeDiagnosisOptions,
              _microscopeDiagnosisOptions,
            ) &&
            (identical(
                  other.microscopeCorrectDiagnosis,
                  microscopeCorrectDiagnosis,
                ) ||
                other.microscopeCorrectDiagnosis ==
                    microscopeCorrectDiagnosis) &&
            const DeepCollectionEquality().equals(
              other._impactPoint,
              _impactPoint,
            ) &&
            (identical(other.bulletTrajectoryAngle, bulletTrajectoryAngle) ||
                other.bulletTrajectoryAngle == bulletTrajectoryAngle) &&
            (identical(other.suspectName, suspectName) ||
                other.suspectName == suspectName) &&
            (identical(other.suspectImage, suspectImage) ||
                other.suspectImage == suspectImage) &&
            (identical(other.initialStress, initialStress) ||
                other.initialStress == initialStress) &&
            (identical(other.stressThreshold, stressThreshold) ||
                other.stressThreshold == stressThreshold));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    type,
    title,
    description,
    trigger,
    sceneImage,
    timeLimitSeconds,
    correctX,
    correctY,
    correctAngle,
    tolerance,
    const DeepCollectionEquality().hash(_targetArea),
    const DeepCollectionEquality().hash(_hints),
    patientName,
    patientImage,
    initialComfort,
    comfortThreshold,
    const DeepCollectionEquality().hash(_questions),
    const DeepCollectionEquality().hash(_criticalQuestions),
    const DeepCollectionEquality().hash(_optimalOrder),
    toxinName,
    toxinDescription,
    const DeepCollectionEquality().hash(_toxinSymptoms),
    const DeepCollectionEquality().hash(_toxicologyOptions),
    toxinSeverity,
    ekgAnomalyType,
    ekgAnomalyStartX,
    ekgAnomalyEndX,
    const DeepCollectionEquality().hash(_ekgDiagnosisOptions),
    ekgCorrectDiagnosis,
    const DeepCollectionEquality().hash(_auscultationFindings),
    const DeepCollectionEquality().hash(_auscultationDiagnosisOptions),
    auscultationCorrectDiagnosis,
    targetBPM,
    compressionCount,
    bpmTolerance,
    drugName,
    drugDoseRange,
    patientWeight,
    patientAge,
    patientGFR,
    correctDoseMg,
    correctIVRate,
    doseTolerancePercent,
    maxDailyDoseMg,
    kidneyAdjustmentNeeded,
    microscopeType,
    abnormalCellCount,
    abnormalCellType,
    const DeepCollectionEquality().hash(_microscopeDiagnosisOptions),
    microscopeCorrectDiagnosis,
    const DeepCollectionEquality().hash(_impactPoint),
    bulletTrajectoryAngle,
    suspectName,
    suspectImage,
    initialStress,
    stressThreshold,
  ]);

  /// Create a copy of MiniGameDef
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MiniGameDefImplCopyWith<_$MiniGameDefImpl> get copyWith =>
      __$$MiniGameDefImplCopyWithImpl<_$MiniGameDefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MiniGameDefImplToJson(this);
  }
}

abstract class _MiniGameDef implements MiniGameDef {
  const factory _MiniGameDef({
    final String id,
    final String type,
    final String title,
    final String description,
    final String? trigger,
    final String? sceneImage,
    final int? timeLimitSeconds,
    final double? correctX,
    final double? correctY,
    final double? correctAngle,
    final double? tolerance,
    final Map<String, dynamic>? targetArea,
    final List<String> hints,
    final String? patientName,
    final String? patientImage,
    final int? initialComfort,
    final int? comfortThreshold,
    final List<ExaminationQuestion> questions,
    final List<String> criticalQuestions,
    final List<String> optimalOrder,
    final String? toxinName,
    final String? toxinDescription,
    final List<String> toxinSymptoms,
    final List<ToxicologyOption> toxicologyOptions,
    final int toxinSeverity,
    final String? ekgAnomalyType,
    final double? ekgAnomalyStartX,
    final double? ekgAnomalyEndX,
    final List<String> ekgDiagnosisOptions,
    final String? ekgCorrectDiagnosis,
    final List<AuscultationFinding> auscultationFindings,
    final List<String> auscultationDiagnosisOptions,
    final String? auscultationCorrectDiagnosis,
    final int targetBPM,
    final int compressionCount,
    final int bpmTolerance,
    final String? drugName,
    final String? drugDoseRange,
    final double? patientWeight,
    final int? patientAge,
    final double? patientGFR,
    final double? correctDoseMg,
    final String? correctIVRate,
    final double doseTolerancePercent,
    final double? maxDailyDoseMg,
    final bool kidneyAdjustmentNeeded,
    final String? microscopeType,
    final int? abnormalCellCount,
    final String? abnormalCellType,
    final List<String> microscopeDiagnosisOptions,
    final String? microscopeCorrectDiagnosis,
    final Map<String, dynamic>? impactPoint,
    final double? bulletTrajectoryAngle,
    final String? suspectName,
    final String? suspectImage,
    final int? initialStress,
    final int? stressThreshold,
  }) = _$MiniGameDefImpl;

  factory _MiniGameDef.fromJson(Map<String, dynamic> json) =
      _$MiniGameDefImpl.fromJson;

  @override
  String get id;

  /// Tip: "imaging_analysis" veya "examination"
  @override
  String get type;
  @override
  String get title;
  @override
  String get description;
  @override
  String? get trigger;
  @override
  String? get sceneImage;
  @override
  int? get timeLimitSeconds; // Görüntüleme analizi alanları (röntgen/MR'da anomali bul)
  @override
  double? get correctX;
  @override
  double? get correctY;
  @override
  double? get correctAngle;
  @override
  double? get tolerance;
  @override
  Map<String, dynamic>? get targetArea;
  @override
  List<String> get hints; // Muayene mini oyun alanları (doğru soruları sor)
  @override
  String? get patientName;
  @override
  String? get patientImage;
  @override
  int? get initialComfort;
  @override
  int? get comfortThreshold;
  @override
  List<ExaminationQuestion> get questions;
  @override
  List<String> get criticalQuestions;
  @override
  List<String> get optimalOrder; // Toksikoloji lab mini oyun alanları (doğru antidotu/tedaviyi seç)
  /// Toksik madde adı
  @override
  String? get toxinName;

  /// Toksin açıklaması
  @override
  String? get toxinDescription;

  /// Semptom listesi
  @override
  List<String> get toxinSymptoms;

  /// Antidot/tedavi seçenekleri
  @override
  List<ToxicologyOption> get toxicologyOptions;

  /// Toksin yoğunluk seviyesi (1-10) — süre baskısı
  @override
  int get toxinSeverity; // EKG okuma mini oyun alanları
  /// Anomali tipi: "st_elevation", "atrial_fibrillation", "prolonged_qt", "ventricular_tachycardia"
  @override
  String? get ekgAnomalyType;

  /// Anomali başlangıç pozisyonu (0-1 normalize)
  @override
  double? get ekgAnomalyStartX;

  /// Anomali bitiş pozisyonu (0-1 normalize)
  @override
  double? get ekgAnomalyEndX;

  /// Teşhis seçenekleri
  @override
  List<String> get ekgDiagnosisOptions;

  /// Doğru teşhis
  @override
  String? get ekgCorrectDiagnosis; // Oskültasyon (stetoskop) mini oyun alanları
  /// Oskültasyon noktaları ve bulguları
  @override
  List<AuscultationFinding> get auscultationFindings;

  /// Tanı seçenekleri
  @override
  List<String> get auscultationDiagnosisOptions;

  /// Doğru tanı
  @override
  String? get auscultationCorrectDiagnosis; // CPR Ritim mini oyun alanları
  /// Hedef BPM (varsayılan 110)
  @override
  int get targetBPM;

  /// Kompresyon sayısı (varsayılan 30)
  @override
  int get compressionCount;

  /// BPM toleransı (varsayılan 10)
  @override
  int get bpmTolerance; // İlaç doz hesaplama mini oyun alanları
  /// İlaç adı
  @override
  String? get drugName;

  /// Doz aralığı (ör. "2-4 mg/kg")
  @override
  String? get drugDoseRange;

  /// Hasta kilosu (kg)
  @override
  double? get patientWeight;

  /// Hasta yaşı
  @override
  int? get patientAge;

  /// Hasta GFR (böbrek fonksiyonu)
  @override
  double? get patientGFR;

  /// Doğru toplam doz (mg)
  @override
  double? get correctDoseMg;

  /// Doğru IV damla hızı (ör. "100 mL/saat")
  @override
  String? get correctIVRate;

  /// Doz tolerans yüzdesi (varsayılan %10)
  @override
  double get doseTolerancePercent;

  /// Maksimum günlük doz (mg)
  @override
  double? get maxDailyDoseMg;

  /// Böbrek yetmezliğinde doz ayarı gerekli mi
  @override
  bool get kidneyAdjustmentNeeded; // Mikroskop analizi mini oyun alanları
  /// Mikroskop tipi: "blood_smear" veya "urine_sediment"
  @override
  String? get microscopeType;

  /// Anormal hücre sayısı
  @override
  int? get abnormalCellCount;

  /// Anormal hücre tipi (ör. "Orak Hücre", "Blast Hücre", "Bakteri", "Kristal")
  @override
  String? get abnormalCellType;

  /// Tanı seçenekleri
  @override
  List<String> get microscopeDiagnosisOptions;

  /// Doğru tanı
  @override
  String? get microscopeCorrectDiagnosis; // Geriye uyumluluk (ballistic/interrogation) — eski alan adları
  @override
  Map<String, dynamic>? get impactPoint;
  @override
  double? get bulletTrajectoryAngle;
  @override
  String? get suspectName;
  @override
  String? get suspectImage;
  @override
  int? get initialStress;
  @override
  int? get stressThreshold;

  /// Create a copy of MiniGameDef
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MiniGameDefImplCopyWith<_$MiniGameDefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExaminationQuestion _$ExaminationQuestionFromJson(Map<String, dynamic> json) {
  return _ExaminationQuestion.fromJson(json);
}

/// @nodoc
mixin _$ExaminationQuestion {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Stres etkisi (negatif = rahatsızlık verir)
  int get stressImpact => throw _privateConstructorUsedError;
  String get response => throw _privateConstructorUsedError;

  /// Açığa çıkan bilgi
  String? get revealsInfo => throw _privateConstructorUsedError;
  bool get isCritical => throw _privateConstructorUsedError;

  /// Serializes this ExaminationQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExaminationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExaminationQuestionCopyWith<ExaminationQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExaminationQuestionCopyWith<$Res> {
  factory $ExaminationQuestionCopyWith(
    ExaminationQuestion value,
    $Res Function(ExaminationQuestion) then,
  ) = _$ExaminationQuestionCopyWithImpl<$Res, ExaminationQuestion>;
  @useResult
  $Res call({
    String id,
    String text,
    int stressImpact,
    String response,
    String? revealsInfo,
    bool isCritical,
  });
}

/// @nodoc
class _$ExaminationQuestionCopyWithImpl<$Res, $Val extends ExaminationQuestion>
    implements $ExaminationQuestionCopyWith<$Res> {
  _$ExaminationQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExaminationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? stressImpact = null,
    Object? response = null,
    Object? revealsInfo = freezed,
    Object? isCritical = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            stressImpact: null == stressImpact
                ? _value.stressImpact
                : stressImpact // ignore: cast_nullable_to_non_nullable
                      as int,
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as String,
            revealsInfo: freezed == revealsInfo
                ? _value.revealsInfo
                : revealsInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCritical: null == isCritical
                ? _value.isCritical
                : isCritical // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExaminationQuestionImplCopyWith<$Res>
    implements $ExaminationQuestionCopyWith<$Res> {
  factory _$$ExaminationQuestionImplCopyWith(
    _$ExaminationQuestionImpl value,
    $Res Function(_$ExaminationQuestionImpl) then,
  ) = __$$ExaminationQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String text,
    int stressImpact,
    String response,
    String? revealsInfo,
    bool isCritical,
  });
}

/// @nodoc
class __$$ExaminationQuestionImplCopyWithImpl<$Res>
    extends _$ExaminationQuestionCopyWithImpl<$Res, _$ExaminationQuestionImpl>
    implements _$$ExaminationQuestionImplCopyWith<$Res> {
  __$$ExaminationQuestionImplCopyWithImpl(
    _$ExaminationQuestionImpl _value,
    $Res Function(_$ExaminationQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExaminationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? stressImpact = null,
    Object? response = null,
    Object? revealsInfo = freezed,
    Object? isCritical = null,
  }) {
    return _then(
      _$ExaminationQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        stressImpact: null == stressImpact
            ? _value.stressImpact
            : stressImpact // ignore: cast_nullable_to_non_nullable
                  as int,
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as String,
        revealsInfo: freezed == revealsInfo
            ? _value.revealsInfo
            : revealsInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCritical: null == isCritical
            ? _value.isCritical
            : isCritical // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExaminationQuestionImpl implements _ExaminationQuestion {
  const _$ExaminationQuestionImpl({
    this.id = '',
    this.text = '',
    this.stressImpact = 0,
    this.response = '',
    this.revealsInfo,
    this.isCritical = false,
  });

  factory _$ExaminationQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExaminationQuestionImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String text;

  /// Stres etkisi (negatif = rahatsızlık verir)
  @override
  @JsonKey()
  final int stressImpact;
  @override
  @JsonKey()
  final String response;

  /// Açığa çıkan bilgi
  @override
  final String? revealsInfo;
  @override
  @JsonKey()
  final bool isCritical;

  @override
  String toString() {
    return 'ExaminationQuestion(id: $id, text: $text, stressImpact: $stressImpact, response: $response, revealsInfo: $revealsInfo, isCritical: $isCritical)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExaminationQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.stressImpact, stressImpact) ||
                other.stressImpact == stressImpact) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.revealsInfo, revealsInfo) ||
                other.revealsInfo == revealsInfo) &&
            (identical(other.isCritical, isCritical) ||
                other.isCritical == isCritical));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    stressImpact,
    response,
    revealsInfo,
    isCritical,
  );

  /// Create a copy of ExaminationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExaminationQuestionImplCopyWith<_$ExaminationQuestionImpl> get copyWith =>
      __$$ExaminationQuestionImplCopyWithImpl<_$ExaminationQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExaminationQuestionImplToJson(this);
  }
}

abstract class _ExaminationQuestion implements ExaminationQuestion {
  const factory _ExaminationQuestion({
    final String id,
    final String text,
    final int stressImpact,
    final String response,
    final String? revealsInfo,
    final bool isCritical,
  }) = _$ExaminationQuestionImpl;

  factory _ExaminationQuestion.fromJson(Map<String, dynamic> json) =
      _$ExaminationQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get text;

  /// Stres etkisi (negatif = rahatsızlık verir)
  @override
  int get stressImpact;
  @override
  String get response;

  /// Açığa çıkan bilgi
  @override
  String? get revealsInfo;
  @override
  bool get isCritical;

  /// Create a copy of ExaminationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExaminationQuestionImplCopyWith<_$ExaminationQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ToxicologyOption _$ToxicologyOptionFromJson(Map<String, dynamic> json) {
  return _ToxicologyOption.fromJson(json);
}

/// @nodoc
mixin _$ToxicologyOption {
  String get id => throw _privateConstructorUsedError;

  /// Antidot/tedavi adı
  String get name => throw _privateConstructorUsedError;

  /// Açıklama
  String get description => throw _privateConstructorUsedError;

  /// Doğru seçenek mi
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Yanlış seçilirse sonuç
  String? get wrongConsequence => throw _privateConstructorUsedError;

  /// Uygulama dozu/yöntemi
  String? get dosage => throw _privateConstructorUsedError;

  /// Serializes this ToxicologyOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ToxicologyOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ToxicologyOptionCopyWith<ToxicologyOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToxicologyOptionCopyWith<$Res> {
  factory $ToxicologyOptionCopyWith(
    ToxicologyOption value,
    $Res Function(ToxicologyOption) then,
  ) = _$ToxicologyOptionCopyWithImpl<$Res, ToxicologyOption>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    bool isCorrect,
    String? wrongConsequence,
    String? dosage,
  });
}

/// @nodoc
class _$ToxicologyOptionCopyWithImpl<$Res, $Val extends ToxicologyOption>
    implements $ToxicologyOptionCopyWith<$Res> {
  _$ToxicologyOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ToxicologyOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isCorrect = null,
    Object? wrongConsequence = freezed,
    Object? dosage = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            wrongConsequence: freezed == wrongConsequence
                ? _value.wrongConsequence
                : wrongConsequence // ignore: cast_nullable_to_non_nullable
                      as String?,
            dosage: freezed == dosage
                ? _value.dosage
                : dosage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ToxicologyOptionImplCopyWith<$Res>
    implements $ToxicologyOptionCopyWith<$Res> {
  factory _$$ToxicologyOptionImplCopyWith(
    _$ToxicologyOptionImpl value,
    $Res Function(_$ToxicologyOptionImpl) then,
  ) = __$$ToxicologyOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    bool isCorrect,
    String? wrongConsequence,
    String? dosage,
  });
}

/// @nodoc
class __$$ToxicologyOptionImplCopyWithImpl<$Res>
    extends _$ToxicologyOptionCopyWithImpl<$Res, _$ToxicologyOptionImpl>
    implements _$$ToxicologyOptionImplCopyWith<$Res> {
  __$$ToxicologyOptionImplCopyWithImpl(
    _$ToxicologyOptionImpl _value,
    $Res Function(_$ToxicologyOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ToxicologyOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? isCorrect = null,
    Object? wrongConsequence = freezed,
    Object? dosage = freezed,
  }) {
    return _then(
      _$ToxicologyOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        wrongConsequence: freezed == wrongConsequence
            ? _value.wrongConsequence
            : wrongConsequence // ignore: cast_nullable_to_non_nullable
                  as String?,
        dosage: freezed == dosage
            ? _value.dosage
            : dosage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ToxicologyOptionImpl implements _ToxicologyOption {
  const _$ToxicologyOptionImpl({
    this.id = '',
    this.name = '',
    this.description = '',
    this.isCorrect = false,
    this.wrongConsequence,
    this.dosage,
  });

  factory _$ToxicologyOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ToxicologyOptionImplFromJson(json);

  @override
  @JsonKey()
  final String id;

  /// Antidot/tedavi adı
  @override
  @JsonKey()
  final String name;

  /// Açıklama
  @override
  @JsonKey()
  final String description;

  /// Doğru seçenek mi
  @override
  @JsonKey()
  final bool isCorrect;

  /// Yanlış seçilirse sonuç
  @override
  final String? wrongConsequence;

  /// Uygulama dozu/yöntemi
  @override
  final String? dosage;

  @override
  String toString() {
    return 'ToxicologyOption(id: $id, name: $name, description: $description, isCorrect: $isCorrect, wrongConsequence: $wrongConsequence, dosage: $dosage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToxicologyOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.wrongConsequence, wrongConsequence) ||
                other.wrongConsequence == wrongConsequence) &&
            (identical(other.dosage, dosage) || other.dosage == dosage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    isCorrect,
    wrongConsequence,
    dosage,
  );

  /// Create a copy of ToxicologyOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToxicologyOptionImplCopyWith<_$ToxicologyOptionImpl> get copyWith =>
      __$$ToxicologyOptionImplCopyWithImpl<_$ToxicologyOptionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ToxicologyOptionImplToJson(this);
  }
}

abstract class _ToxicologyOption implements ToxicologyOption {
  const factory _ToxicologyOption({
    final String id,
    final String name,
    final String description,
    final bool isCorrect,
    final String? wrongConsequence,
    final String? dosage,
  }) = _$ToxicologyOptionImpl;

  factory _ToxicologyOption.fromJson(Map<String, dynamic> json) =
      _$ToxicologyOptionImpl.fromJson;

  @override
  String get id;

  /// Antidot/tedavi adı
  @override
  String get name;

  /// Açıklama
  @override
  String get description;

  /// Doğru seçenek mi
  @override
  bool get isCorrect;

  /// Yanlış seçilirse sonuç
  @override
  String? get wrongConsequence;

  /// Uygulama dozu/yöntemi
  @override
  String? get dosage;

  /// Create a copy of ToxicologyOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToxicologyOptionImplCopyWith<_$ToxicologyOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuscultationFinding _$AuscultationFindingFromJson(Map<String, dynamic> json) {
  return _AuscultationFinding.fromJson(json);
}

/// @nodoc
mixin _$AuscultationFinding {
  /// Nokta kimliği: "aortic", "pulmonic", "tricuspid", "mitral",
  /// "right_upper_lung", "right_lower_lung", "left_upper_lung", "left_lower_lung"
  String get pointId => throw _privateConstructorUsedError;

  /// Anormal mi?
  bool get isAbnormal => throw _privateConstructorUsedError;

  /// Ses tipi: "normal", "ral", "ronkus", "üfürüm", "wheezing", "stridor"
  String get soundType => throw _privateConstructorUsedError;

  /// Serializes this AuscultationFinding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuscultationFinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuscultationFindingCopyWith<AuscultationFinding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuscultationFindingCopyWith<$Res> {
  factory $AuscultationFindingCopyWith(
    AuscultationFinding value,
    $Res Function(AuscultationFinding) then,
  ) = _$AuscultationFindingCopyWithImpl<$Res, AuscultationFinding>;
  @useResult
  $Res call({String pointId, bool isAbnormal, String soundType});
}

/// @nodoc
class _$AuscultationFindingCopyWithImpl<$Res, $Val extends AuscultationFinding>
    implements $AuscultationFindingCopyWith<$Res> {
  _$AuscultationFindingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuscultationFinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointId = null,
    Object? isAbnormal = null,
    Object? soundType = null,
  }) {
    return _then(
      _value.copyWith(
            pointId: null == pointId
                ? _value.pointId
                : pointId // ignore: cast_nullable_to_non_nullable
                      as String,
            isAbnormal: null == isAbnormal
                ? _value.isAbnormal
                : isAbnormal // ignore: cast_nullable_to_non_nullable
                      as bool,
            soundType: null == soundType
                ? _value.soundType
                : soundType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuscultationFindingImplCopyWith<$Res>
    implements $AuscultationFindingCopyWith<$Res> {
  factory _$$AuscultationFindingImplCopyWith(
    _$AuscultationFindingImpl value,
    $Res Function(_$AuscultationFindingImpl) then,
  ) = __$$AuscultationFindingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pointId, bool isAbnormal, String soundType});
}

/// @nodoc
class __$$AuscultationFindingImplCopyWithImpl<$Res>
    extends _$AuscultationFindingCopyWithImpl<$Res, _$AuscultationFindingImpl>
    implements _$$AuscultationFindingImplCopyWith<$Res> {
  __$$AuscultationFindingImplCopyWithImpl(
    _$AuscultationFindingImpl _value,
    $Res Function(_$AuscultationFindingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuscultationFinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointId = null,
    Object? isAbnormal = null,
    Object? soundType = null,
  }) {
    return _then(
      _$AuscultationFindingImpl(
        pointId: null == pointId
            ? _value.pointId
            : pointId // ignore: cast_nullable_to_non_nullable
                  as String,
        isAbnormal: null == isAbnormal
            ? _value.isAbnormal
            : isAbnormal // ignore: cast_nullable_to_non_nullable
                  as bool,
        soundType: null == soundType
            ? _value.soundType
            : soundType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuscultationFindingImpl implements _AuscultationFinding {
  const _$AuscultationFindingImpl({
    this.pointId = '',
    this.isAbnormal = false,
    this.soundType = 'normal',
  });

  factory _$AuscultationFindingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuscultationFindingImplFromJson(json);

  /// Nokta kimliği: "aortic", "pulmonic", "tricuspid", "mitral",
  /// "right_upper_lung", "right_lower_lung", "left_upper_lung", "left_lower_lung"
  @override
  @JsonKey()
  final String pointId;

  /// Anormal mi?
  @override
  @JsonKey()
  final bool isAbnormal;

  /// Ses tipi: "normal", "ral", "ronkus", "üfürüm", "wheezing", "stridor"
  @override
  @JsonKey()
  final String soundType;

  @override
  String toString() {
    return 'AuscultationFinding(pointId: $pointId, isAbnormal: $isAbnormal, soundType: $soundType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuscultationFindingImpl &&
            (identical(other.pointId, pointId) || other.pointId == pointId) &&
            (identical(other.isAbnormal, isAbnormal) ||
                other.isAbnormal == isAbnormal) &&
            (identical(other.soundType, soundType) ||
                other.soundType == soundType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pointId, isAbnormal, soundType);

  /// Create a copy of AuscultationFinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuscultationFindingImplCopyWith<_$AuscultationFindingImpl> get copyWith =>
      __$$AuscultationFindingImplCopyWithImpl<_$AuscultationFindingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AuscultationFindingImplToJson(this);
  }
}

abstract class _AuscultationFinding implements AuscultationFinding {
  const factory _AuscultationFinding({
    final String pointId,
    final bool isAbnormal,
    final String soundType,
  }) = _$AuscultationFindingImpl;

  factory _AuscultationFinding.fromJson(Map<String, dynamic> json) =
      _$AuscultationFindingImpl.fromJson;

  /// Nokta kimliği: "aortic", "pulmonic", "tricuspid", "mitral",
  /// "right_upper_lung", "right_lower_lung", "left_upper_lung", "left_lower_lung"
  @override
  String get pointId;

  /// Anormal mi?
  @override
  bool get isAbnormal;

  /// Ses tipi: "normal", "ral", "ronkus", "üfürüm", "wheezing", "stridor"
  @override
  String get soundType;

  /// Create a copy of AuscultationFinding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuscultationFindingImplCopyWith<_$AuscultationFindingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MiniGameResult _$MiniGameResultFromJson(Map<String, dynamic> json) {
  return _MiniGameResult.fromJson(json);
}

/// @nodoc
mixin _$MiniGameResult {
  int get id => throw _privateConstructorUsedError;
  String get caseId => throw _privateConstructorUsedError;
  String get miniGameId => throw _privateConstructorUsedError;
  String get miniGameType => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get xpEarned => throw _privateConstructorUsedError;
  int get totalXp => throw _privateConstructorUsedError;
  int get newLevel => throw _privateConstructorUsedError;
  bool get leveledUp => throw _privateConstructorUsedError;
  String get verdict => throw _privateConstructorUsedError;
  Map<String, dynamic>? get details => throw _privateConstructorUsedError;

  /// Serializes this MiniGameResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MiniGameResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MiniGameResultCopyWith<MiniGameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiniGameResultCopyWith<$Res> {
  factory $MiniGameResultCopyWith(
    MiniGameResult value,
    $Res Function(MiniGameResult) then,
  ) = _$MiniGameResultCopyWithImpl<$Res, MiniGameResult>;
  @useResult
  $Res call({
    int id,
    String caseId,
    String miniGameId,
    String miniGameType,
    int score,
    int xpEarned,
    int totalXp,
    int newLevel,
    bool leveledUp,
    String verdict,
    Map<String, dynamic>? details,
  });
}

/// @nodoc
class _$MiniGameResultCopyWithImpl<$Res, $Val extends MiniGameResult>
    implements $MiniGameResultCopyWith<$Res> {
  _$MiniGameResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MiniGameResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? caseId = null,
    Object? miniGameId = null,
    Object? miniGameType = null,
    Object? score = null,
    Object? xpEarned = null,
    Object? totalXp = null,
    Object? newLevel = null,
    Object? leveledUp = null,
    Object? verdict = null,
    Object? details = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            caseId: null == caseId
                ? _value.caseId
                : caseId // ignore: cast_nullable_to_non_nullable
                      as String,
            miniGameId: null == miniGameId
                ? _value.miniGameId
                : miniGameId // ignore: cast_nullable_to_non_nullable
                      as String,
            miniGameType: null == miniGameType
                ? _value.miniGameType
                : miniGameType // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            xpEarned: null == xpEarned
                ? _value.xpEarned
                : xpEarned // ignore: cast_nullable_to_non_nullable
                      as int,
            totalXp: null == totalXp
                ? _value.totalXp
                : totalXp // ignore: cast_nullable_to_non_nullable
                      as int,
            newLevel: null == newLevel
                ? _value.newLevel
                : newLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            leveledUp: null == leveledUp
                ? _value.leveledUp
                : leveledUp // ignore: cast_nullable_to_non_nullable
                      as bool,
            verdict: null == verdict
                ? _value.verdict
                : verdict // ignore: cast_nullable_to_non_nullable
                      as String,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MiniGameResultImplCopyWith<$Res>
    implements $MiniGameResultCopyWith<$Res> {
  factory _$$MiniGameResultImplCopyWith(
    _$MiniGameResultImpl value,
    $Res Function(_$MiniGameResultImpl) then,
  ) = __$$MiniGameResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String caseId,
    String miniGameId,
    String miniGameType,
    int score,
    int xpEarned,
    int totalXp,
    int newLevel,
    bool leveledUp,
    String verdict,
    Map<String, dynamic>? details,
  });
}

/// @nodoc
class __$$MiniGameResultImplCopyWithImpl<$Res>
    extends _$MiniGameResultCopyWithImpl<$Res, _$MiniGameResultImpl>
    implements _$$MiniGameResultImplCopyWith<$Res> {
  __$$MiniGameResultImplCopyWithImpl(
    _$MiniGameResultImpl _value,
    $Res Function(_$MiniGameResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MiniGameResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? caseId = null,
    Object? miniGameId = null,
    Object? miniGameType = null,
    Object? score = null,
    Object? xpEarned = null,
    Object? totalXp = null,
    Object? newLevel = null,
    Object? leveledUp = null,
    Object? verdict = null,
    Object? details = freezed,
  }) {
    return _then(
      _$MiniGameResultImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        caseId: null == caseId
            ? _value.caseId
            : caseId // ignore: cast_nullable_to_non_nullable
                  as String,
        miniGameId: null == miniGameId
            ? _value.miniGameId
            : miniGameId // ignore: cast_nullable_to_non_nullable
                  as String,
        miniGameType: null == miniGameType
            ? _value.miniGameType
            : miniGameType // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        xpEarned: null == xpEarned
            ? _value.xpEarned
            : xpEarned // ignore: cast_nullable_to_non_nullable
                  as int,
        totalXp: null == totalXp
            ? _value.totalXp
            : totalXp // ignore: cast_nullable_to_non_nullable
                  as int,
        newLevel: null == newLevel
            ? _value.newLevel
            : newLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        leveledUp: null == leveledUp
            ? _value.leveledUp
            : leveledUp // ignore: cast_nullable_to_non_nullable
                  as bool,
        verdict: null == verdict
            ? _value.verdict
            : verdict // ignore: cast_nullable_to_non_nullable
                  as String,
        details: freezed == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MiniGameResultImpl implements _MiniGameResult {
  const _$MiniGameResultImpl({
    this.id = 0,
    this.caseId = '',
    this.miniGameId = '',
    this.miniGameType = '',
    this.score = 0,
    this.xpEarned = 0,
    this.totalXp = 0,
    this.newLevel = 0,
    this.leveledUp = false,
    this.verdict = '',
    final Map<String, dynamic>? details,
  }) : _details = details;

  factory _$MiniGameResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiniGameResultImplFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String caseId;
  @override
  @JsonKey()
  final String miniGameId;
  @override
  @JsonKey()
  final String miniGameType;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int xpEarned;
  @override
  @JsonKey()
  final int totalXp;
  @override
  @JsonKey()
  final int newLevel;
  @override
  @JsonKey()
  final bool leveledUp;
  @override
  @JsonKey()
  final String verdict;
  final Map<String, dynamic>? _details;
  @override
  Map<String, dynamic>? get details {
    final value = _details;
    if (value == null) return null;
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'MiniGameResult(id: $id, caseId: $caseId, miniGameId: $miniGameId, miniGameType: $miniGameType, score: $score, xpEarned: $xpEarned, totalXp: $totalXp, newLevel: $newLevel, leveledUp: $leveledUp, verdict: $verdict, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiniGameResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.caseId, caseId) || other.caseId == caseId) &&
            (identical(other.miniGameId, miniGameId) ||
                other.miniGameId == miniGameId) &&
            (identical(other.miniGameType, miniGameType) ||
                other.miniGameType == miniGameType) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.totalXp, totalXp) || other.totalXp == totalXp) &&
            (identical(other.newLevel, newLevel) ||
                other.newLevel == newLevel) &&
            (identical(other.leveledUp, leveledUp) ||
                other.leveledUp == leveledUp) &&
            (identical(other.verdict, verdict) || other.verdict == verdict) &&
            const DeepCollectionEquality().equals(other._details, _details));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    caseId,
    miniGameId,
    miniGameType,
    score,
    xpEarned,
    totalXp,
    newLevel,
    leveledUp,
    verdict,
    const DeepCollectionEquality().hash(_details),
  );

  /// Create a copy of MiniGameResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MiniGameResultImplCopyWith<_$MiniGameResultImpl> get copyWith =>
      __$$MiniGameResultImplCopyWithImpl<_$MiniGameResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MiniGameResultImplToJson(this);
  }
}

abstract class _MiniGameResult implements MiniGameResult {
  const factory _MiniGameResult({
    final int id,
    final String caseId,
    final String miniGameId,
    final String miniGameType,
    final int score,
    final int xpEarned,
    final int totalXp,
    final int newLevel,
    final bool leveledUp,
    final String verdict,
    final Map<String, dynamic>? details,
  }) = _$MiniGameResultImpl;

  factory _MiniGameResult.fromJson(Map<String, dynamic> json) =
      _$MiniGameResultImpl.fromJson;

  @override
  int get id;
  @override
  String get caseId;
  @override
  String get miniGameId;
  @override
  String get miniGameType;
  @override
  int get score;
  @override
  int get xpEarned;
  @override
  int get totalXp;
  @override
  int get newLevel;
  @override
  bool get leveledUp;
  @override
  String get verdict;
  @override
  Map<String, dynamic>? get details;

  /// Create a copy of MiniGameResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MiniGameResultImplCopyWith<_$MiniGameResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
