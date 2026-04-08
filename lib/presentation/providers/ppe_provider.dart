import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/protective_gear.dart';

/// Enfeksiyon şiddeti
enum InfectionSeverity { none, mild, moderate, severe }

/// Kullanıcının kuşandığı KKD (Kişisel Koruyucu Donanım) durumu
class PPEState {
  final Set<GearType> equippedGear;
  final bool infectionPenaltyApplied;

  /// Doktor enfekte mi?
  final bool isInfected;

  /// Enfeksiyon şiddeti (eksik KKD sayısına göre)
  final InfectionSeverity severity;

  /// Eksik KKD açıklaması
  final String infectionDescription;

  /// İyileşmeye kalan saniye
  final int healingRemainingSeconds;

  /// Aktif hızlandırma çarpanı (1.0 = normal)
  final double healingSpeedMultiplier;

  /// Aktif tedavi adı
  final String activeTreatmentName;

  /// Bugün vitamin kullanıldı mı
  final bool vitaminUsedToday;

  const PPEState({
    this.equippedGear = const {},
    this.infectionPenaltyApplied = false,
    this.isInfected = false,
    this.severity = InfectionSeverity.none,
    this.infectionDescription = '',
    this.healingRemainingSeconds = 0,
    this.healingSpeedMultiplier = 1.0,
    this.activeTreatmentName = 'İstirahat',
    this.vitaminUsedToday = false,
  });

  bool hasGear(GearType type) => equippedGear.contains(type);

  /// Gereken tüm KKD giyilmiş mi?
  bool meetsRequirements(List<GearType> required) {
    return required.every((g) => equippedGear.contains(g));
  }

  /// Eksik KKD listesi
  List<GearType> missingGear(List<GearType> required) {
    return required.where((g) => !equippedGear.contains(g)).toList();
  }

  /// Enfeksiyon skor ceza çarpanı (1.0 = ceza yok, 0.5 = yarı XP)
  double get scorePenaltyMultiplier {
    switch (severity) {
      case InfectionSeverity.none:
        return 1.0;
      case InfectionSeverity.mild:
        return 0.8; // %20 XP kaybı
      case InfectionSeverity.moderate:
        return 0.5; // %50 XP kaybı
      case InfectionSeverity.severe:
        return 0.2; // %80 XP kaybı
    }
  }

  /// İyileşme süresi formatı (MM:SS)
  String get healingTimeFormatted {
    final m = healingRemainingSeconds ~/ 60;
    final s = healingRemainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  PPEState copyWith({
    Set<GearType>? equippedGear,
    bool? infectionPenaltyApplied,
    bool? isInfected,
    InfectionSeverity? severity,
    String? infectionDescription,
    int? healingRemainingSeconds,
    double? healingSpeedMultiplier,
    String? activeTreatmentName,
    bool? vitaminUsedToday,
  }) {
    return PPEState(
      equippedGear: equippedGear ?? this.equippedGear,
      infectionPenaltyApplied: infectionPenaltyApplied ?? this.infectionPenaltyApplied,
      isInfected: isInfected ?? this.isInfected,
      severity: severity ?? this.severity,
      infectionDescription: infectionDescription ?? this.infectionDescription,
      healingRemainingSeconds: healingRemainingSeconds ?? this.healingRemainingSeconds,
      healingSpeedMultiplier: healingSpeedMultiplier ?? this.healingSpeedMultiplier,
      activeTreatmentName: activeTreatmentName ?? this.activeTreatmentName,
      vitaminUsedToday: vitaminUsedToday ?? this.vitaminUsedToday,
    );
  }
}

class PPENotifier extends StateNotifier<PPEState> {
  Timer? _healingTimer;
  static const _storageKey = 'infection_state';

  PPENotifier() : super(const PPEState()) {
    _loadFromStorage();
  }

  /// Kalıcı storage'dan enfeksiyon durumunu yükle
  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_storageKey);
      if (json == null) return;

      final data = jsonDecode(json) as Map<String, dynamic>;
      final savedAt = DateTime.tryParse(data['savedAt'] ?? '');
      if (savedAt == null) return;

      // Geçen süreyi hesapla ve kalan süreden düş
      final elapsed = DateTime.now().difference(savedAt).inSeconds;
      final remaining = (data['healingRemainingSeconds'] as int) - elapsed;

      if (remaining <= 0) {
        // Uygulama kapalıyken iyileşmiş
        await prefs.remove(_storageKey);
        return;
      }

      state = state.copyWith(
        isInfected: true,
        severity: InfectionSeverity.values[data['severity'] as int],
        infectionDescription: data['infectionDescription'] ?? '',
        healingRemainingSeconds: remaining,
        healingSpeedMultiplier: (data['healingSpeedMultiplier'] as num).toDouble(),
        activeTreatmentName: data['activeTreatmentName'] ?? 'İstirahat',
        vitaminUsedToday: data['vitaminUsedToday'] ?? false,
        infectionPenaltyApplied: true,
      );
      _startHealingTimer();
    } catch (e) {
      debugPrint('[PPE] Storage yükleme hatası: $e');
    }
  }

  /// Enfeksiyon durumunu kalıcı storage'a kaydet
  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!state.isInfected) {
        await prefs.remove(_storageKey);
        return;
      }
      await prefs.setString(_storageKey, jsonEncode({
        'severity': state.severity.index,
        'infectionDescription': state.infectionDescription,
        'healingRemainingSeconds': state.healingRemainingSeconds,
        'healingSpeedMultiplier': state.healingSpeedMultiplier,
        'activeTreatmentName': state.activeTreatmentName,
        'vitaminUsedToday': state.vitaminUsedToday,
        'savedAt': DateTime.now().toIso8601String(),
      }));
    } catch (e) {
      debugPrint('[PPE] Storage kaydetme hatası: $e');
    }
  }

  /// KKD kuşan
  void equip(GearType type) {
    state = state.copyWith(
      equippedGear: {...state.equippedGear, type},
    );
  }

  /// KKD çıkar
  void unequip(GearType type) {
    final newGear = {...state.equippedGear};
    newGear.remove(type);
    state = state.copyWith(equippedGear: newGear);
  }

  /// KKD toggle
  void toggle(GearType type) {
    if (state.hasGear(type)) {
      unequip(type);
    } else {
      equip(type);
    }
  }

  /// Enfeksiyon cezası uygula — eksik KKD sayısına göre şiddet belirle
  void applyInfection(List<GearType> requiredGear, String penaltyDescription) {
    final missing = state.missingGear(requiredGear);
    if (missing.isEmpty) return;

    InfectionSeverity severity;
    int healingSeconds;
    if (missing.length >= 3) {
      severity = InfectionSeverity.severe;
      healingSeconds = 30 * 60; // 30 dakika
    } else if (missing.length == 2) {
      severity = InfectionSeverity.moderate;
      healingSeconds = 15 * 60; // 15 dakika
    } else {
      severity = InfectionSeverity.mild;
      healingSeconds = 5 * 60; // 5 dakika
    }

    state = state.copyWith(
      infectionPenaltyApplied: true,
      isInfected: true,
      severity: severity,
      infectionDescription: penaltyDescription,
      healingRemainingSeconds: healingSeconds,
    );

    _startHealingTimer();
    _saveToStorage();
  }

  void _startHealingTimer() {
    _healingTimer?.cancel();
    _healingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!state.isInfected) return;
      final remaining = (state.healingRemainingSeconds - 1).clamp(0, 99999);
      if (remaining <= 0) {
        _completeHealing();
      } else {
        state = state.copyWith(healingRemainingSeconds: remaining);
      }
    });
  }

  void _completeHealing() {
    _healingTimer?.cancel();
    _healingTimer = null;
    state = state.copyWith(
      isInfected: false,
      severity: InfectionSeverity.none,
      healingRemainingSeconds: 0,
      infectionDescription: '',
      infectionPenaltyApplied: false,
      healingSpeedMultiplier: 1.0,
      activeTreatmentName: 'İstirahat',
    );
    _saveToStorage();
  }

  /// Vitamin takviyesi — süreyi %20 azalt (günde 1 kez ücretsiz)
  bool applyVitamin() {
    if (!state.isInfected || state.vitaminUsedToday) return false;
    final newRemaining = (state.healingRemainingSeconds * 0.80).round();
    state = state.copyWith(
      healingRemainingSeconds: newRemaining,
      healingSpeedMultiplier: 1.25,
      activeTreatmentName: 'Vitamin Takviyesi',
      vitaminUsedToday: true,
    );
    _saveToStorage();
    return true;
  }

  /// Antibiyotik kürü — süreyi %33 azalt (1.5x)
  void applyAntibiotic() {
    if (!state.isInfected) return;
    final newRemaining = (state.healingRemainingSeconds * 0.67).round();
    state = state.copyWith(
      healingRemainingSeconds: newRemaining,
      healingSpeedMultiplier: 1.5,
      activeTreatmentName: 'Antibiyotik Kürü',
    );
    _saveToStorage();
  }

  /// Yoğun tedavi — süreyi yarıya indir (2x)
  void applyIntensiveTreatment() {
    if (!state.isInfected) return;
    final newRemaining = (state.healingRemainingSeconds * 0.50).round();
    state = state.copyWith(
      healingRemainingSeconds: newRemaining,
      healingSpeedMultiplier: 2.0,
      activeTreatmentName: 'Yoğun Tedavi',
    );
    _saveToStorage();
  }

  /// Acil müdahale — anında iyileş
  void applyEmergencyCure() {
    if (!state.isInfected) return;
    _completeHealing();
  }

  /// KKD'yi sıfırla (yeni vaka için) — enfeksiyon durumu korunur
  void resetGear() {
    state = state.copyWith(
      equippedGear: {},
      infectionPenaltyApplied: false,
    );
  }

  @override
  void dispose() {
    _healingTimer?.cancel();
    super.dispose();
  }
}

final ppeProvider = StateNotifierProvider<PPENotifier, PPEState>(
  (ref) => PPENotifier(),
);
