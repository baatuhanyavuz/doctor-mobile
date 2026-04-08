import 'package:freezed_annotation/freezed_annotation.dart';

part 'mini_game.freezed.dart';
part 'mini_game.g.dart';

/// Mini oyun tanımı
@freezed
class MiniGameDef with _$MiniGameDef {
  const factory MiniGameDef({
    @Default('') String id,
    /// Tip: "imaging_analysis" veya "examination"
    @Default('') String type,
    @Default('') String title,
    @Default('') String description,
    String? trigger,
    String? sceneImage,
    int? timeLimitSeconds,

    // Görüntüleme analizi alanları (röntgen/MR'da anomali bul)
    double? correctX,
    double? correctY,
    double? correctAngle,
    double? tolerance,
    Map<String, dynamic>? targetArea,
    @Default([]) List<String> hints,

    // Muayene mini oyun alanları (doğru soruları sor)
    String? patientName,
    String? patientImage,
    int? initialComfort,
    int? comfortThreshold,
    @Default([]) List<ExaminationQuestion> questions,
    @Default([]) List<String> criticalQuestions,
    @Default([]) List<String> optimalOrder,

    // Toksikoloji lab mini oyun alanları (doğru antidotu/tedaviyi seç)
    /// Toksik madde adı
    String? toxinName,
    /// Toksin açıklaması
    String? toxinDescription,
    /// Semptom listesi
    @Default([]) List<String> toxinSymptoms,
    /// Antidot/tedavi seçenekleri
    @Default([]) List<ToxicologyOption> toxicologyOptions,
    /// Toksin yoğunluk seviyesi (1-10) — süre baskısı
    @Default(5) int toxinSeverity,

    // EKG okuma mini oyun alanları
    /// Anomali tipi: "st_elevation", "atrial_fibrillation", "prolonged_qt", "ventricular_tachycardia"
    String? ekgAnomalyType,
    /// Anomali başlangıç pozisyonu (0-1 normalize)
    double? ekgAnomalyStartX,
    /// Anomali bitiş pozisyonu (0-1 normalize)
    double? ekgAnomalyEndX,
    /// Teşhis seçenekleri
    @Default([]) List<String> ekgDiagnosisOptions,
    /// Doğru teşhis
    String? ekgCorrectDiagnosis,

    // Oskültasyon (stetoskop) mini oyun alanları
    /// Oskültasyon noktaları ve bulguları
    @Default([]) List<AuscultationFinding> auscultationFindings,
    /// Tanı seçenekleri
    @Default([]) List<String> auscultationDiagnosisOptions,
    /// Doğru tanı
    String? auscultationCorrectDiagnosis,

    // CPR Ritim mini oyun alanları
    /// Hedef BPM (varsayılan 110)
    @Default(110) int targetBPM,
    /// Kompresyon sayısı (varsayılan 30)
    @Default(30) int compressionCount,
    /// BPM toleransı (varsayılan 10)
    @Default(10) int bpmTolerance,

    // İlaç doz hesaplama mini oyun alanları
    /// İlaç adı
    String? drugName,
    /// Doz aralığı (ör. "2-4 mg/kg")
    String? drugDoseRange,
    /// Hasta kilosu (kg)
    double? patientWeight,
    /// Hasta yaşı
    int? patientAge,
    /// Hasta GFR (böbrek fonksiyonu)
    double? patientGFR,
    /// Doğru toplam doz (mg)
    double? correctDoseMg,
    /// Doğru IV damla hızı (ör. "100 mL/saat")
    String? correctIVRate,
    /// Doz tolerans yüzdesi (varsayılan %10)
    @Default(10) double doseTolerancePercent,
    /// Maksimum günlük doz (mg)
    double? maxDailyDoseMg,
    /// Böbrek yetmezliğinde doz ayarı gerekli mi
    @Default(false) bool kidneyAdjustmentNeeded,

    // Mikroskop analizi mini oyun alanları
    /// Mikroskop tipi: "blood_smear" veya "urine_sediment"
    String? microscopeType,
    /// Anormal hücre sayısı
    int? abnormalCellCount,
    /// Anormal hücre tipi (ör. "Orak Hücre", "Blast Hücre", "Bakteri", "Kristal")
    String? abnormalCellType,
    /// Tanı seçenekleri
    @Default([]) List<String> microscopeDiagnosisOptions,
    /// Doğru tanı
    String? microscopeCorrectDiagnosis,

    // Geriye uyumluluk (ballistic/interrogation) — eski alan adları
    Map<String, dynamic>? impactPoint,
    double? bulletTrajectoryAngle,
    String? suspectName,
    String? suspectImage,
    int? initialStress,
    int? stressThreshold,
  }) = _MiniGameDef;

  factory MiniGameDef.fromJson(Map<String, dynamic> json) =>
      _$MiniGameDefFromJson(json);
}

/// Muayene sorusu
@freezed
class ExaminationQuestion with _$ExaminationQuestion {
  const factory ExaminationQuestion({
    @Default('') String id,
    @Default('') String text,
    /// Stres etkisi (negatif = rahatsızlık verir)
    @Default(0) int stressImpact,
    @Default('') String response,
    /// Açığa çıkan bilgi
    String? revealsInfo,
    @Default(false) bool isCritical,
  }) = _ExaminationQuestion;

  factory ExaminationQuestion.fromJson(Map<String, dynamic> json) =>
      _$ExaminationQuestionFromJson(json);
}

/// Toksikoloji tedavi seçeneği
@freezed
class ToxicologyOption with _$ToxicologyOption {
  const factory ToxicologyOption({
    @Default('') String id,
    /// Antidot/tedavi adı
    @Default('') String name,
    /// Açıklama
    @Default('') String description,
    /// Doğru seçenek mi
    @Default(false) bool isCorrect,
    /// Yanlış seçilirse sonuç
    String? wrongConsequence,
    /// Uygulama dozu/yöntemi
    String? dosage,
  }) = _ToxicologyOption;

  factory ToxicologyOption.fromJson(Map<String, dynamic> json) =>
      _$ToxicologyOptionFromJson(json);
}

/// Oskültasyon bulgusu
@freezed
class AuscultationFinding with _$AuscultationFinding {
  const factory AuscultationFinding({
    /// Nokta kimliği: "aortic", "pulmonic", "tricuspid", "mitral",
    /// "right_upper_lung", "right_lower_lung", "left_upper_lung", "left_lower_lung"
    @Default('') String pointId,
    /// Anormal mi?
    @Default(false) bool isAbnormal,
    /// Ses tipi: "normal", "ral", "ronkus", "üfürüm", "wheezing", "stridor"
    @Default('normal') String soundType,
  }) = _AuscultationFinding;

  factory AuscultationFinding.fromJson(Map<String, dynamic> json) =>
      _$AuscultationFindingFromJson(json);
}

/// Mini oyun sonuç yanıtı (API'den döner)
@freezed
class MiniGameResult with _$MiniGameResult {
  const factory MiniGameResult({
    @Default(0) int id,
    @Default('') String caseId,
    @Default('') String miniGameId,
    @Default('') String miniGameType,
    @Default(0) int score,
    @Default(0) int xpEarned,
    @Default(0) int totalXp,
    @Default(0) int newLevel,
    @Default(false) bool leveledUp,
    @Default('') String verdict,
    Map<String, dynamic>? details,
  }) = _MiniGameResult;

  factory MiniGameResult.fromJson(Map<String, dynamic> json) =>
      _$MiniGameResultFromJson(json);
}
