import 'package:freezed_annotation/freezed_annotation.dart';

part 'upgrade.freezed.dart';
part 'upgrade.g.dart';

/// Yükseltme türleri
enum UpgradeType {
  @JsonValue('goldenStethoscope')
  goldenStethoscope,    // İpucu kalitesi artırır
  @JsonValue('fastDevice')
  fastDevice,           // Countdown süresini uzatır
  @JsonValue('aiMRI')
  aiMRI,                // Mini oyun tolerans genişletme
  @JsonValue('advancedLab')
  advancedLab,          // Tahlil sonuçları daha detaylı
  @JsonValue('comfortKit')
  comfortKit,           // Hasta konfor eşyaları +%50 etkili
}

/// Yükseltme seviyesi (her upgrade max 3 seviye)
@freezed
class Upgrade with _$Upgrade {
  const factory Upgrade({
    required UpgradeType type,
    @Default(0) int level,          // 0 = satın alınmamış, 1-3 = seviye
    @Default(3) int maxLevel,
  }) = _Upgrade;

  factory Upgrade.fromJson(Map<String, dynamic> json) =>
      _$UpgradeFromJson(json);
}

/// Yükseltme katalog bilgisi (UI gösterimi için)
class UpgradeCatalogItem {
  final UpgradeType type;
  final String name;
  final String description;
  final String iconName;
  final List<int> levelCosts;       // Her seviye için kredi maliyeti
  final List<String> levelEffects;  // Her seviye için etki açıklaması

  const UpgradeCatalogItem({
    required this.type,
    required this.name,
    required this.description,
    required this.iconName,
    required this.levelCosts,
    required this.levelEffects,
  });
}

/// Yükseltme katalogu
const upgradeCatalog = <UpgradeType, UpgradeCatalogItem>{
  UpgradeType.goldenStethoscope: UpgradeCatalogItem(
    type: UpgradeType.goldenStethoscope,
    name: 'Altın Stetoskop',
    description: 'İpuçları daha detaylı ve yönlendirici olur',
    iconName: 'stethoscope',
    levelCosts: [50, 100, 200],
    levelEffects: [
      'İpuçları biraz daha detaylı',
      'İpuçları ilgili tıbbi veriyi işaret eder',
      'İpuçları doğrudan teşhise yönlendirir',
    ],
  ),
  UpgradeType.fastDevice: UpgradeCatalogItem(
    type: UpgradeType.fastDevice,
    name: 'Hızlı Cihaz',
    description: 'Vaka çözme süresini uzatır',
    iconName: 'speed',
    levelCosts: [40, 80, 160],
    levelEffects: [
      '+2 dakika ek süre',
      '+4 dakika ek süre',
      '+6 dakika ek süre',
    ],
  ),
  UpgradeType.aiMRI: UpgradeCatalogItem(
    type: UpgradeType.aiMRI,
    name: 'AI Destekli MR',
    description: 'Görüntüleme analizinde tolerans genişler',
    iconName: 'psychology',
    levelCosts: [60, 120, 240],
    levelEffects: [
      'Tolerans +%10 genişler',
      'Tolerans +%20 genişler',
      'Tolerans +%30 genişler',
    ],
  ),
  UpgradeType.advancedLab: UpgradeCatalogItem(
    type: UpgradeType.advancedLab,
    name: 'Gelişmiş Laboratuvar',
    description: 'Tahlil sonuçları daha detaylı açıklamalar içerir',
    iconName: 'biotech',
    levelCosts: [45, 90, 180],
    levelEffects: [
      'Referans aralıkları gösterilir',
      'Anormallik vurgulanır',
      'Olası teşhis bağlantısı gösterilir',
    ],
  ),
  UpgradeType.comfortKit: UpgradeCatalogItem(
    type: UpgradeType.comfortKit,
    name: 'Konfor Kiti',
    description: 'Hasta konfor eşyaları daha etkili olur',
    iconName: 'volunteer_activism',
    levelCosts: [30, 60, 120],
    levelEffects: [
      'Konfor eşyaları +%25 etkili',
      'Konfor eşyaları +%50 etkili',
      'Konfor eşyaları +%75 etkili',
    ],
  ),
};
