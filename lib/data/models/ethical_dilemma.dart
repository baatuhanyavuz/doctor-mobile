import 'package:freezed_annotation/freezed_annotation.dart';

part 'ethical_dilemma.freezed.dart';
part 'ethical_dilemma.g.dart';

/// Etik ikilem seçeneği
@freezed
class DilemmaChoice with _$DilemmaChoice {
  const factory DilemmaChoice({
    @Default('') String id,

    /// Seçenek metni (ör: "Tedaviyi uygula")
    @Default('') String text,

    /// Seçim sonrası gösterilen sonuç anlatısı
    @Default('') String consequence,

    /// İtibar puanı etkisi (+/-)
    @Default(0) int reputationImpact,

    /// Bu seçim yeni tıbbi veri açar mı
    String? unlocksEvidenceId,

    /// Bu seçim bir tıbbi veriyi kaldırır/gizler mi
    String? removesEvidenceId,

    /// Farklı bitiş anlatısı (seçime bağlı ending)
    String? alternateEndingNarrative,

    /// Farklı bitiş başlığı
    String? alternateEndingTitle,

    /// Farklı hasta geri bildirimi
    String? alternatePatientFeedback,

    /// Etik olarak "doğru" kabul edilen seçim mi
    @Default(false) bool isEthical,
  }) = _DilemmaChoice;

  factory DilemmaChoice.fromJson(Map<String, dynamic> json) =>
      _$DilemmaChoiceFromJson(json);
}

/// Etik ikilem — oyun sırasında oyuncuya sunulan moral karar noktası
@freezed
class EthicalDilemma with _$EthicalDilemma {
  const factory EthicalDilemma({
    @Default('') String id,

    /// İkilem başlığı (ör: "Hasta Mahremiyeti")
    @Default('') String title,

    /// Durum açıklaması — oyuncuya gösterilir
    @Default('') String description,

    /// Ne zaman tetiklenir:
    /// - "before_solution" → Teşhis & Tedavi tabına geçerken
    /// - "after_evidence_ev_001" → Belirli kanıt açıldığında
    /// - "after_deduction_ded_001" → Belirli çıkarım bulunduğunda
    /// - "on_game_start" → Oyun başladığında
    @Default('before_solution') String triggerPoint,

    /// Seçenekler (tam olarak 2 adet)
    @Default([]) List<DilemmaChoice> choices,

    /// Ek bağlam bilgisi (ör: tıbbi etik kuralı referansı)
    String? contextInfo,

    /// İkilem kategorisi (ör: "mahremiyet", "kaynak_dagitimi", "bilgilendirme")
    String? category,
  }) = _EthicalDilemma;

  factory EthicalDilemma.fromJson(Map<String, dynamic> json) =>
      _$EthicalDilemmaFromJson(json);
}
