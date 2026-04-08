import 'package:freezed_annotation/freezed_annotation.dart';

part 'ending_data.freezed.dart';
part 'ending_data.g.dart';

@freezed
class EndingData with _$EndingData {
  const factory EndingData({
    @Default('') String title,
    @Default('') String narrative,

    /// Hasta geri bildirimi ("Teşekkürler doktor...")
    @Default('') String patientFeedback,

    /// Hasta iyileşme görseli
    String? patientImage,

    /// Eğitici not (hastalık hakkında bilgi)
    String? educationalNote,

    /// Etik seçime bağlı alternatif bitiş anlatıları
    /// Key: dilemmaId, Value: alternateEndingNarrative
    @Default({}) Map<String, String> alternateNarratives,

    /// İtibar puanı eşik değeri — bu eşiğin altında farklı ending
    int? reputationThreshold,

    /// Düşük itibar ending anlatısı
    String? lowReputationNarrative,

    /// Düşük itibar hasta geri bildirimi
    String? lowReputationFeedback,

    // Geriye uyumluluk
    @JsonKey(name: 'killerConfession') String? killerConfessionLegacy,
    @JsonKey(name: 'killerImage') String? killerImageLegacy,
  }) = _EndingData;

  factory EndingData.fromJson(Map<String, dynamic> json) =>
      _$EndingDataFromJson(json);
}
