import 'dart:math';
import '../../data/models/case.dart';
import '../../data/models/medical_data.dart';
import '../../data/models/interview.dart';

/// Vaka verilerini tekrar oynanabilirlik için randomize eder.
///
/// - Tahlil sonuçlarında ±%10 sapma
/// - Vital bulgularda küçük varyasyonlar
/// - Hasta cevaplarında alternatif varyasyonlar (varsa)
///
/// Seed bazlı — aynı kullanıcı+vaka için tutarlı sonuçlar üretir.
class CaseRandomizer {
  final Random _random;

  CaseRandomizer({required String seed})
      : _random = Random(seed.hashCode);

  /// Tüm vakayı randomize et
  Case randomize(Case gameCase) {
    return gameCase.copyWith(
      patient: _randomizePatientVitals(gameCase.patient),
      medicalData: gameCase.medicalData
          .map((md) => _randomizeMedicalData(md))
          .toList(),
      interviews: gameCase.interviews
          .map((iv) => _randomizeInterview(iv))
          .toList(),
    );
  }

  /// Hasta vital bulgularını ±%10 sapma ile randomize et
  Patient _randomizePatientVitals(Patient patient) {
    final vitals = patient.vitals;
    if (vitals == null) return patient;

    return patient.copyWith(
      vitals: Vitals(
        heartRate: vitals.heartRate != null
            ? _varyInt(vitals.heartRate!, 0.08)
            : null,
        bloodPressure: vitals.bloodPressure != null
            ? _varyBloodPressure(vitals.bloodPressure!)
            : null,
        temperature: vitals.temperature != null
            ? _varyDouble(vitals.temperature!, 0.005)
            : null,
        oxygenSaturation: vitals.oxygenSaturation != null
            ? _varyInt(vitals.oxygenSaturation!, 0.03).clamp(70, 100)
            : null,
        respiratoryRate: vitals.respiratoryRate != null
            ? _varyInt(vitals.respiratoryRate!, 0.1)
            : null,
      ),
    );
  }

  /// Tahlil sonuçlarını ±%10 sapma ile randomize et
  MedicalData _randomizeMedicalData(MedicalData md) {
    if (md.resultValue == null || md.resultValue!.isEmpty) return md;

    // Sayısal değer varsa sapma uygula
    final numericValue = _extractNumericValue(md.resultValue!);
    if (numericValue == null) return md;

    final varied = _varyDouble(numericValue, 0.10);
    final newValue = md.resultValue!.replaceFirst(
      numericValue.toString(),
      varied.toStringAsFixed(1),
    );

    return md.copyWith(resultValue: newValue);
  }

  /// Hasta cevaplarında alternatif varyasyonlar
  Interview _randomizeInterview(Interview interview) {
    // Transcript'teki normal (çelişkisiz) cevaplarda küçük varyasyonlar
    final newTranscript = interview.transcript.map((qa) {
      // Çelişkili veya clue cevapları değiştirme
      if (qa.isContradiction || qa.isClue) return qa;

      // Rastgele kelime ekleme/çıkarma şimdilik devre dışı
      // İleride: qa.answerVariants listesi eklenebilir
      return qa;
    }).toList();

    return interview.copyWith(transcript: newTranscript);
  }

  // ─── Yardımcı metodlar ────────────────────────────────────

  /// Tam sayıyı ±yüzde sapma ile değiştir
  int _varyInt(int value, double pct) {
    final delta = (value * pct * (_random.nextDouble() * 2 - 1)).round();
    return value + delta;
  }

  /// Ondalık sayıyı ±yüzde sapma ile değiştir
  double _varyDouble(double value, double pct) {
    final delta = value * pct * (_random.nextDouble() * 2 - 1);
    return double.parse((value + delta).toStringAsFixed(1));
  }

  /// Kan basıncı string'ini (120/80) randomize et
  String _varyBloodPressure(String bp) {
    final parts = bp.split('/');
    if (parts.length != 2) return bp;
    final sys = int.tryParse(parts[0].trim());
    final dia = int.tryParse(parts[1].trim());
    if (sys == null || dia == null) return bp;
    return '${_varyInt(sys, 0.06)}/${_varyInt(dia, 0.06)}';
  }

  /// String'den ilk sayısal değeri çıkar (ör: "D-Dimer: 2.8 mg/L" → 2.8)
  double? _extractNumericValue(String text) {
    final match = RegExp(r'(\d+\.?\d*)').firstMatch(text);
    if (match == null) return null;
    return double.tryParse(match.group(1)!);
  }
}

/// Kullanıcı + vaka bazlı seed üret
String generateCaseSeed(String userId, String caseId) {
  return '${userId}_${caseId}_${DateTime.now().millisecondsSinceEpoch ~/ 86400000}';
}
