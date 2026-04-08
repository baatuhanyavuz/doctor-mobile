import 'dart:math';

/// Laboratuvar degerlerini hafifce rastgelelestiren yardimci sinif.
///
/// Tekrar oynamalarda degerlerin ezberlenememesi icin
/// numerik lab sonuclarina +-variance oraninda rastgele
/// sapma uygular. Birimler korunur.
class LabRandomizer {
  static final Random _random = Random();

  /// Bir lab deger metnindeki numerik kismi +-variance oraniyla degistirir.
  ///
  /// Ornek girdiler:
  /// - "2.8 mg/L" -> "2.6 mg/L" (variance=0.1 ile)
  /// - "Troponin: 0.02 ng/mL" -> "Troponin: 0.019 ng/mL"
  /// - "Pozitif" -> "Pozitif" (numerik olmayan, degistirilmez)
  /// - "HGB: 14.2 g/dL" -> "HGB: 14.8 g/dL"
  ///
  /// [variance] varsayilan %10 (0.1). 0.05 = %5, 0.2 = %20.
  static String randomizeValue(String originalValue, {double variance = 0.1}) {
    if (originalValue.isEmpty) return originalValue;

    // Numerik parca bul (tam sayi veya ondalikli)
    final numericPattern = RegExp(r'(\d+\.?\d*)');
    final match = numericPattern.firstMatch(originalValue);

    if (match == null) {
      // Numerik deger bulunamadi, aynen dondur
      return originalValue;
    }

    final numericStr = match.group(1)!;
    final numericVal = double.tryParse(numericStr);

    if (numericVal == null || numericVal == 0) {
      return originalValue;
    }

    // Ondalik basamak sayisini tespit et
    final decimalPlaces = numericStr.contains('.')
        ? numericStr.split('.').last.length
        : 0;

    // +-variance oraninda rastgele sapma uygula
    final factor = 1.0 + ((_random.nextDouble() * 2 - 1) * variance);
    final newVal = numericVal * factor;

    // Orijinal formatla ayni basamak sayisina yuvarla
    final newStr = decimalPlaces > 0
        ? newVal.toStringAsFixed(decimalPlaces)
        : newVal.round().toString();

    // Orijinal metin icerisinde degistir
    return originalValue.replaceFirst(numericStr, newStr);
  }
}
