import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/upgrade.dart';

/// Kullanıcı yükseltme durumu
class UpgradesState {
  final Map<UpgradeType, int> levels; // type → seviye (0 = yok)

  const UpgradesState({this.levels = const {}});

  int getLevel(UpgradeType type) => levels[type] ?? 0;
  bool hasUpgrade(UpgradeType type) => getLevel(type) > 0;
  bool isMaxLevel(UpgradeType type) => getLevel(type) >= 3;

  /// Hızlı Cihaz bonus süresi (saniye)
  int get bonusTimeSeconds {
    final level = getLevel(UpgradeType.fastDevice);
    return level * 120; // Seviye başına +2dk
  }

  /// AI MR tolerans çarpanı
  double get toleranceMultiplier {
    final level = getLevel(UpgradeType.aiMRI);
    return 1.0 + (level * 0.10); // Seviye başına +%10
  }

  /// Konfor kit çarpanı
  double get comfortMultiplier {
    final level = getLevel(UpgradeType.comfortKit);
    return 1.0 + (level * 0.25); // Seviye başına +%25
  }

  /// İpucu kalite seviyesi (0-3)
  int get hintQuality => getLevel(UpgradeType.goldenStethoscope);

  /// Lab detay seviyesi (0-3)
  int get labDetailLevel => getLevel(UpgradeType.advancedLab);

  UpgradesState copyWith({Map<UpgradeType, int>? levels}) {
    return UpgradesState(levels: levels ?? this.levels);
  }
}

class UpgradesNotifier extends StateNotifier<UpgradesState> {
  static const _storageKey = 'user_upgrades';

  UpgradesNotifier() : super(const UpgradesState()) {
    _loadFromStorage();
  }

  /// Yükseltme satın al
  bool purchase(UpgradeType type) {
    final currentLevel = state.getLevel(type);
    if (currentLevel >= 3) return false; // Max seviye

    final newLevels = {...state.levels};
    newLevels[type] = currentLevel + 1;
    state = state.copyWith(levels: newLevels);
    _saveToStorage();
    return true;
  }

  /// Kalıcı storage'dan yükle
  Future<void> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_storageKey);
      if (json == null) return;

      final data = jsonDecode(json) as Map<String, dynamic>;
      final levels = <UpgradeType, int>{};
      for (final entry in data.entries) {
        final type = UpgradeType.values.firstWhere(
          (t) => t.name == entry.key,
          orElse: () => UpgradeType.goldenStethoscope,
        );
        levels[type] = entry.value as int;
      }
      state = state.copyWith(levels: levels);
    } catch (e) {
      debugPrint('[Upgrades] Storage yükleme hatası: $e');
    }
  }

  /// Kalıcı storage'a kaydet
  Future<void> _saveToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = <String, int>{};
      for (final entry in state.levels.entries) {
        data[entry.key.name] = entry.value;
      }
      await prefs.setString(_storageKey, jsonEncode(data));
    } catch (e) {
      debugPrint('[Upgrades] Storage kaydetme hatası: $e');
    }
  }
}

final upgradesProvider = StateNotifierProvider<UpgradesNotifier, UpgradesState>(
  (ref) => UpgradesNotifier(),
);
