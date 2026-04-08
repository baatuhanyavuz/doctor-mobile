import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumable.freezed.dart';
part 'consumable.g.dart';

/// Sarf malzeme türleri
enum ConsumableType {
  @JsonValue('disposableGloves')
  disposableGloves,     // Tek kullanımlık eldiven
  @JsonValue('surgicalMask')
  surgicalMask,         // Cerrahi maske
  @JsonValue('n95Mask')
  n95Mask,              // N95 maske
  @JsonValue('painKiller')
  painKiller,           // Ağrı kesici (hasta konforu)
  @JsonValue('sedative')
  sedative,             // Sakinleştirici (hasta konforu)
  @JsonValue('tea')
  tea,                  // Sıcak içecek (hasta konforu)
  @JsonValue('blanket')
  blanket,              // Battaniye (hasta konforu)
}

/// Sarf malzeme kategorisi
enum ConsumableCategory {
  protection,   // KKD sarf malzemeleri
  comfort,      // Hasta konfor malzemeleri
}

/// Sarf malzeme tanımı
@freezed
class Consumable with _$Consumable {
  const factory Consumable({
    required ConsumableType type,
    @Default('') String name,
    @Default('') String description,
    @Default(ConsumableCategory.protection) ConsumableCategory category,
    @Default(0) int creditCost,
    @Default('') String iconName,
  }) = _Consumable;

  factory Consumable.fromJson(Map<String, dynamic> json) =>
      _$ConsumableFromJson(json);
}
