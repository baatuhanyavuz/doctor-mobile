import 'package:freezed_annotation/freezed_annotation.dart';

part 'protective_gear.freezed.dart';
part 'protective_gear.g.dart';

/// KKD (Kişisel Koruyucu Donanım) türleri
enum GearType {
  @JsonValue('mask')
  mask,           // Cerrahi maske / N95
  @JsonValue('gloves')
  gloves,         // Eldiven
  @JsonValue('gown')
  gown,           // Önlük / Tulum
  @JsonValue('goggles')
  goggles,        // Koruyucu gözlük / Yüz siperliği
  @JsonValue('faceShield')
  faceShield,     // Yüz siperliği
}

/// Bulaş riski seviyesi
enum InfectionRiskLevel {
  @JsonValue('none')
  none,           // Risk yok — KKD isteğe bağlı
  @JsonValue('low')
  low,            // Düşük — eldiven yeterli
  @JsonValue('medium')
  medium,         // Orta — eldiven + maske gerekli
  @JsonValue('high')
  high,           // Yüksek — tam KKD gerekli (eldiven + maske + önlük + gözlük)
}

/// Vaka için gereken KKD tanımı
@freezed
class InfectionRisk with _$InfectionRisk {
  const factory InfectionRisk({
    /// Bulaş riski seviyesi
    @Default(InfectionRiskLevel.none) InfectionRiskLevel level,

    /// Bulaş tipi açıklaması (ör: "Damlacık yoluyla bulaşır")
    @Default('') String description,

    /// Bu vaka için zorunlu KKD listesi
    @Default([]) List<GearType> requiredGear,

    /// KKD giyilmezse uygulanacak ceza açıklaması
    @Default('') String penaltyDescription,
  }) = _InfectionRisk;

  factory InfectionRisk.fromJson(Map<String, dynamic> json) =>
      _$InfectionRiskFromJson(json);
}
