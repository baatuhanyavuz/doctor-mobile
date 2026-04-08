import 'package:freezed_annotation/freezed_annotation.dart';
import 'deduction.dart';
import 'medical_data.dart';
import 'diagnosis.dart';
import 'interview.dart';
import 'solution.dart';
import 'ending_data.dart';
import 'mini_game.dart';
import 'protective_gear.dart';
import 'ethical_dilemma.dart';

part 'case.freezed.dart';
part 'case.g.dart';

/// Zorluk seviyesi
enum Difficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
  @JsonValue('expert')
  expert,
  @JsonValue('tutorial')
  tutorial,
}

/// Vaka durumu
enum CaseStatus {
  @JsonValue('locked')
  locked,
  @JsonValue('available')
  available,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('solved')
  solved,
  @JsonValue('failed')
  failed,
}

/// Hasta vital bulguları
@freezed
class Vitals with _$Vitals {
  const factory Vitals({
    String? bloodPressure,
    int? heartRate,
    double? temperature,
    int? oxygenSaturation,
    int? respiratoryRate,
  }) = _Vitals;

  factory Vitals.fromJson(Map<String, dynamic> json) =>
      _$VitalsFromJson(json);
}

/// Hasta modeli
@freezed
class Patient with _$Patient {
  const factory Patient({
    @Default('') String name,
    int? age,
    String? gender,
    String? bloodType,
    String? occupation,
    String? photoPath,
    @Default([]) List<String> chronicDiseases,
    @Default([]) List<String> currentMedications,
    @Default([]) List<String> allergies,
    String? chiefComplaint,
    Vitals? vitals,
    String? biography,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
}

/// Hasta vakası modeli
@freezed
class Case with _$Case {
  const factory Case({
    @Default('') String id,
    @Default('') String title,
    @Default('') String shortDescription,
    @Default('') String fullDescription,
    @Default('') String coverImage,
    @Default(Difficulty.easy) Difficulty difficulty,
    @Default(CaseStatus.available) CaseStatus status,
    @Default(0.0) double price,
    int? creditPrice,
    int? estimatedDuration,

    /// Hasta bilgisi
    @Default(Patient()) Patient patient,

    /// Tıbbi veriler (tahlil, görüntüleme, muayene bulgusu vb.)
    @Default([]) List<MedicalData> medicalData,

    /// Olası teşhisler
    @Default([]) List<Diagnosis> diagnoses,

    /// Anamnez görüşmeleri (hasta, yakın, hemşire)
    @Default([]) List<Interview> interviews,

    /// Teşhis & tedavi çözümü
    @Default(Solution()) Solution solution,

    /// Teşhis tahtası birleştirme kuralları
    @Default([]) List<Deduction> deductions,

    /// Mini oyunlar (görüntüleme analizi, muayene)
    @Default([]) List<MiniGameDef> miniGames,

    /// Vaka kategorisi (kardiyoloji, nöroloji vb.)
    List<String>? tags,
    String? createdAt,
    String? playerNotes,
    @Default(0) int progressPercent,

    // === BRIEFING (Hasta Gelişi) ===
    /// Hemşire notu / hasta şikayeti (daktilo efektiyle)
    String? introText,
    /// Klinik / bölüm (Örn: "Acil Servis", "Kardiyoloji Polikliniği")
    String? clinic,
    /// Triaj notu / hemşire raporu
    String? nurseReport,

    // === BULAŞ RİSKİ ===
    /// Vaka bulaş riski bilgisi (KKD gereksinimi)
    InfectionRisk? infectionRisk,

    // === ETİK İKİLEMLER ===
    /// Vaka içi etik karar noktaları
    @Default([]) List<EthicalDilemma> ethicalDilemmas,

    // === ENDING (Vaka Kapanış) ===
    EndingData? endingData,
  }) = _Case;

  factory Case.fromJson(Map<String, dynamic> json) =>
      _$CaseFromJson(json);
}

/// Vaka listesi wrapper (JSON root)
@freezed
class CaseList with _$CaseList {
  const factory CaseList({
    @Default([]) List<Case> cases,
  }) = _CaseList;

  factory CaseList.fromJson(Map<String, dynamic> json) =>
      _$CaseListFromJson(json);
}
