import 'package:freezed_annotation/freezed_annotation.dart';

part 'solution.freezed.dart';
part 'solution.g.dart';

/// Tehlikeli tedavi tanımı (ilaç etkileşimi / yan etki uyarısı)
@freezed
class DangerousTreatment with _$DangerousTreatment {
  const factory DangerousTreatment({
    /// Tehlikeli tedavinin adı (treatmentOptions'daki ile eşleşmeli)
    @Default('') String treatmentName,

    /// Neden tehlikeli (ör: "Hastanın böbrek yetmezliği var")
    @Default('') String reason,

    /// Sonucu (ör: "Akut böbrek hasarı riski")
    @Default('') String consequence,
  }) = _DangerousTreatment;

  factory DangerousTreatment.fromJson(Map<String, dynamic> json) =>
      _$DangerousTreatmentFromJson(json);
}

/// Teşhis & tedavi çözümü
@freezed
class Solution with _$Solution {
  const factory Solution({
    /// Doğru teşhis ID'si
    @Default('') String correctDiagnosisId,

    /// Doğru tedavi planı
    @Default('') String correctTreatment,

    /// Çözüm açıklaması (doğru teşhis koyulduğunda gösterilir)
    @Default('') String explanation,

    /// Tedavi seçenekleri (oyuncuya sunulur)
    @Default([]) List<String> treatmentOptions,

    /// Eğitici not (hastalık hakkında bilgi)
    @Default('') String educationalNote,

    /// XP ödülü
    @Default(100) int scoreReward,

    /// Tehlikeli tedaviler (ilaç etkileşimi / yan etki uyarıları)
    @Default([]) List<DangerousTreatment> dangerousTreatments,

    // Geriye uyumluluk için eski alan adları (JSON parse)
    @JsonKey(name: 'guiltyId') String? guiltyIdLegacy,
    @JsonKey(name: 'correctMotive') String? correctMotiveLegacy,
    @JsonKey(name: 'motiveOptions') List<String>? motiveOptionsLegacy,
  }) = _Solution;

  factory Solution.fromJson(Map<String, dynamic> json) =>
      _$SolutionFromJson(json);
}

/// Kullanıcının verdiği cevap
@freezed
class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    /// Seçilen teşhis ID'si
    @Default('') String selectedDiagnosisId,

    /// Seçilen tedavi planı
    @Default('') String selectedTreatment,

    /// Cevap doğru mu
    @Default(false) bool isCorrect,

    /// Cevap zamanı
    DateTime? submittedAt,
  }) = _UserAnswer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);
}
