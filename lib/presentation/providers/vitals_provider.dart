import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/case.dart';

/// Hasta durumu enum
enum PatientCondition { stable, warning, critical, cardiacArrest, lost }

/// Vital bulguları durumu
class VitalsState {
  final int heartRate;           // Normal: 60-100
  final int systolicBP;          // Normal: 90-140
  final int diastolicBP;         // Normal: 60-90
  final double temperature;      // Normal: 36.1-37.2
  final int oxygenSaturation;    // Normal: 95-100
  final int respiratoryRate;     // Normal: 12-20

  /// Kalan süre (saniye) — 0 olursa hasta kaybedilir
  final int remainingSeconds;

  /// Kritik durumda kalma süresi (saniye) — çok uzun kalırsa arrest
  final int criticalDuration;

  /// Hasta durumu
  final PatientCondition condition;

  const VitalsState({
    this.heartRate = 75,
    this.systolicBP = 120,
    this.diastolicBP = 80,
    this.temperature = 36.6,
    this.oxygenSaturation = 98,
    this.respiratoryRate = 16,
    this.remainingSeconds = 600, // 10 dakika varsayılan
    this.criticalDuration = 0,
    this.condition = PatientCondition.stable,
  });

  String get bloodPressure => '$systolicBP/$diastolicBP';

  /// Kalp atim hizi durumu
  VitalStatus get heartRateStatus {
    if (heartRate < 50 || heartRate > 130) return VitalStatus.critical;
    if (heartRate < 60 || heartRate > 100) return VitalStatus.warning;
    return VitalStatus.normal;
  }

  /// Kan basinci durumu
  VitalStatus get bloodPressureStatus {
    if (systolicBP > 180 || systolicBP < 80 || diastolicBP > 120 || diastolicBP < 50) {
      return VitalStatus.critical;
    }
    if (systolicBP > 140 || systolicBP < 90 || diastolicBP > 90 || diastolicBP < 60) {
      return VitalStatus.warning;
    }
    return VitalStatus.normal;
  }

  /// Vucut isisi durumu
  VitalStatus get temperatureStatus {
    if (temperature > 39.5 || temperature < 35.0) return VitalStatus.critical;
    if (temperature > 37.5 || temperature < 36.0) return VitalStatus.warning;
    return VitalStatus.normal;
  }

  /// SpO2 durumu
  VitalStatus get oxygenStatus {
    if (oxygenSaturation < 90) return VitalStatus.critical;
    if (oxygenSaturation < 95) return VitalStatus.warning;
    return VitalStatus.normal;
  }

  /// Solunum hizi durumu
  VitalStatus get respiratoryRateStatus {
    if (respiratoryRate > 30 || respiratoryRate < 8) return VitalStatus.critical;
    if (respiratoryRate > 20 || respiratoryRate < 12) return VitalStatus.warning;
    return VitalStatus.normal;
  }

  /// Herhangi bir vital kritik mi?
  bool get isCritical =>
      heartRateStatus == VitalStatus.critical ||
      bloodPressureStatus == VitalStatus.critical ||
      temperatureStatus == VitalStatus.critical ||
      oxygenStatus == VitalStatus.critical ||
      respiratoryRateStatus == VitalStatus.critical;

  /// Herhangi bir vital uyari seviyesinde mi?
  bool get hasWarning =>
      heartRateStatus == VitalStatus.warning ||
      bloodPressureStatus == VitalStatus.warning ||
      temperatureStatus == VitalStatus.warning ||
      oxygenStatus == VitalStatus.warning ||
      respiratoryRateStatus == VitalStatus.warning;

  /// Kalan süre formatı (MM:SS)
  String get remainingTimeFormatted {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  /// Süre kritik mi? (son 2 dakika)
  bool get isTimeUrgent => remainingSeconds <= 120 && remainingSeconds > 0;

  VitalsState copyWith({
    int? heartRate,
    int? systolicBP,
    int? diastolicBP,
    double? temperature,
    int? oxygenSaturation,
    int? respiratoryRate,
    int? remainingSeconds,
    int? criticalDuration,
    PatientCondition? condition,
  }) {
    return VitalsState(
      heartRate: heartRate ?? this.heartRate,
      systolicBP: systolicBP ?? this.systolicBP,
      diastolicBP: diastolicBP ?? this.diastolicBP,
      temperature: temperature ?? this.temperature,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      criticalDuration: criticalDuration ?? this.criticalDuration,
      condition: condition ?? this.condition,
    );
  }
}

/// Vital durumu enum
enum VitalStatus { normal, warning, critical }

/// Vitals StateNotifier
class VitalsNotifier extends StateNotifier<VitalsState> {
  final Random _random = Random();
  Timer? _degradationTimer;
  Timer? _countdownTimer;
  bool _kodMaviShown = false;

  /// Kritik durumda arrest'e geçiş eşiği (saniye)
  static const int _arrestThreshold = 60;

  /// Kod Mavi gösterildi mi? (tekrar göstermeyi önle)
  bool get kodMaviShown => _kodMaviShown;
  void resetKodMavi() => _kodMaviShown = false;

  VitalsNotifier() : super(const VitalsState());

  /// Vakadaki hasta vital bilgilerinden baslatma
  void initFromCase(Vitals? vitals) {
    if (vitals == null) return;

    int systolic = 120;
    int diastolic = 80;
    if (vitals.bloodPressure != null) {
      final parts = vitals.bloodPressure!.split('/');
      if (parts.length == 2) {
        systolic = int.tryParse(parts[0].trim()) ?? 120;
        diastolic = int.tryParse(parts[1].trim()) ?? 80;
      }
    }

    state = VitalsState(
      heartRate: vitals.heartRate ?? 75,
      systolicBP: systolic,
      diastolicBP: diastolic,
      temperature: vitals.temperature ?? 36.6,
      oxygenSaturation: vitals.oxygenSaturation ?? 98,
      respiratoryRate: vitals.respiratoryRate ?? 16,
      remainingSeconds: 600, // 10 dakika
      criticalDuration: 0,
      condition: PatientCondition.stable,
    );
  }

  /// Zamanla kademeli kötüleşme timer'ını başlat
  void startDegradation({Duration interval = const Duration(seconds: 45)}) {
    _degradationTimer?.cancel();
    _degradationTimer = Timer.periodic(interval, (_) {
      mildDeteriorate();
    });
  }

  /// Countdown timer'ını başlat (her saniye)
  void startCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickCountdown();
    });
  }

  /// Tüm timer'ları durdur
  void stopAll() {
    _degradationTimer?.cancel();
    _degradationTimer = null;
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  /// Kademeli kötüleşmeyi durdur
  void stopDegradation() {
    _degradationTimer?.cancel();
    _degradationTimer = null;
  }

  void _tickCountdown() {
    if (state.condition == PatientCondition.lost) return;

    final newRemaining = (state.remainingSeconds - 1).clamp(0, 9999);

    // Kritik durumda kalma süresini takip et
    int newCriticalDuration = state.criticalDuration;
    PatientCondition newCondition = state.condition;

    if (state.condition == PatientCondition.cardiacArrest) {
      // Arrest durumunda — defibrilatör uygulanmazsa hasta kaybedilir
      newCriticalDuration += 1;
      if (newCriticalDuration >= 30) {
        // 30 saniye arrest → hasta kaybı
        newCondition = PatientCondition.lost;
        stopAll();
      }
    } else if (state.isCritical) {
      newCriticalDuration += 1;
      if (newCriticalDuration >= _arrestThreshold) {
        // 60 saniye kritik → kardiyak arrest
        newCondition = PatientCondition.cardiacArrest;
      } else {
        newCondition = PatientCondition.critical;
      }
    } else if (state.hasWarning) {
      newCriticalDuration = max(0, newCriticalDuration - 1);
      newCondition = PatientCondition.warning;
    } else {
      newCriticalDuration = 0;
      newCondition = PatientCondition.stable;
    }

    // Süre bitti → hasta kaybı
    if (newRemaining <= 0) {
      newCondition = PatientCondition.lost;
      stopAll();
    }

    state = state.copyWith(
      remainingSeconds: newRemaining,
      criticalDuration: newCriticalDuration,
      condition: newCondition,
    );
  }

  /// Sakinleştirici uygula (nabzı düşürür)
  void applySedative() {
    state = state.copyWith(
      heartRate: _moveToward(state.heartRate, 72, 12),
      respiratoryRate: _moveToward(state.respiratoryRate, 15, 3),
    );
  }

  /// Ağrı kesici uygula (genel iyileşme)
  void applyPainKiller() {
    state = state.copyWith(
      heartRate: _moveToward(state.heartRate, 75, 6),
      systolicBP: _moveToward(state.systolicBP, 120, 5),
    );
  }

  /// Sıcak çay uygula (tansiyon düşürür)
  void applyTea() {
    state = state.copyWith(
      systolicBP: _moveToward(state.systolicBP, 115, 8),
      diastolicBP: _moveToward(state.diastolicBP, 75, 4),
    );
  }

  /// Battaniye uygula (vücut ısısı normalize)
  void applyBlanket() {
    state = state.copyWith(
      temperature: double.parse(
        _moveTowardDouble(state.temperature, 36.6, 0.5).toStringAsFixed(1),
      ),
    );
  }

  /// Defibrilatör uygula (kardiyak arrest'ten çıkar)
  void applyDefibrillator() {
    if (state.condition != PatientCondition.cardiacArrest) return;
    state = state.copyWith(
      heartRate: 65 + _random.nextInt(15),
      oxygenSaturation: (85 + _random.nextInt(8)).clamp(70, 100),
      criticalDuration: 0,
      condition: PatientCondition.critical, // Arrest'ten çıktı ama hala kritik
    );
    _kodMaviShown = false;
  }

  /// Hafif kötüleşme (zaman geçişi — her 45 saniyede bir)
  void mildDeteriorate() {
    state = state.copyWith(
      heartRate: state.heartRate + _random.nextInt(3) + 1,
      systolicBP: state.systolicBP + _random.nextInt(3),
      oxygenSaturation: (state.oxygenSaturation - _random.nextInt(2)).clamp(70, 100),
      respiratoryRate: state.respiratoryRate + (_random.nextBool() ? 1 : 0),
    );
    _checkKodMavi();
  }

  /// Oksijen desteği uygula (SpO₂ iyileştirir)
  void applyOxygen() {
    state = state.copyWith(
      oxygenSaturation: (state.oxygenSaturation + 4 + _random.nextInt(3)).clamp(70, 100),
      respiratoryRate: _moveToward(state.respiratoryRate, 16, 3),
    );
    _kodMaviShown = false; // İyileştirme sonrası tekrar uyarı gösterilebilir
  }

  /// IV sıvı uygula (Tansiyon + kalp stabilize)
  void applyIV() {
    state = state.copyWith(
      heartRate: _moveToward(state.heartRate, 80, 8),
      systolicBP: _moveToward(state.systolicBP, 120, 10),
      diastolicBP: _moveToward(state.diastolicBP, 80, 5),
    );
    _kodMaviShown = false;
  }

  void _checkKodMavi() {
    if (state.isCritical && !_kodMaviShown) {
      _kodMaviShown = true;
    }
  }

  @override
  void dispose() {
    _degradationTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  /// Vitalleri kotulestirir (yanlis aksiyon sonrasi cagrilir)
  void deteriorate() {
    state = state.copyWith(
      heartRate: state.heartRate + _random.nextInt(8) + 2,
      systolicBP: state.systolicBP + _random.nextInt(6) + 2,
      diastolicBP: state.diastolicBP + _random.nextInt(4) + 1,
      temperature: double.parse(
        (state.temperature + (_random.nextDouble() * 0.3 + 0.1)).toStringAsFixed(1),
      ),
      oxygenSaturation: (state.oxygenSaturation - _random.nextInt(3) - 1).clamp(70, 100),
      respiratoryRate: state.respiratoryRate + _random.nextInt(3) + 1,
    );
  }

  /// Vitalleri stabilize eder (stabilizasyon uygulandiginda cagrilir)
  void stabilize() {
    state = state.copyWith(
      heartRate: _moveToward(state.heartRate, 75, 5),
      systolicBP: _moveToward(state.systolicBP, 120, 5),
      diastolicBP: _moveToward(state.diastolicBP, 80, 3),
      temperature: double.parse(
        _moveTowardDouble(state.temperature, 36.6, 0.3).toStringAsFixed(1),
      ),
      oxygenSaturation: (state.oxygenSaturation + _random.nextInt(3) + 1).clamp(70, 100),
      respiratoryRate: _moveToward(state.respiratoryRate, 16, 2),
    );
  }

  int _moveToward(int current, int target, int step) {
    if (current > target) return max(target, current - step);
    if (current < target) return min(target, current + step);
    return current;
  }

  double _moveTowardDouble(double current, double target, double step) {
    if (current > target) return max(target, current - step);
    if (current < target) return min(target, current + step);
    return current;
  }
}

/// Vitals provider (vaka bazli degil, oyun ekrani boyunca yasayan)
final vitalsProvider = StateNotifierProvider<VitalsNotifier, VitalsState>(
  (ref) => VitalsNotifier(),
);
