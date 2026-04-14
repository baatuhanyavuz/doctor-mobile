import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';

/// Kullanıcının açtığı vakaların ID set'i
class UnlockedCasesNotifier extends StateNotifier<Set<String>> {
  final Ref _ref;

  UnlockedCasesNotifier(this._ref) : super(<String>{}) {
    fetchFromServer();
  }

  /// Sunucudan açık vakaları getir + ilk girişte initialize et
  Future<void> fetchFromServer() async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.get(AppConstants.unlockedCasesEndpoint);
      final ids = (response.data['unlockedCaseIds'] as List?)?.cast<String>() ?? [];

      // Hiç açık vaka yoksa, ilk girişte initialize çağır
      if (ids.isEmpty) {
        await initializeUnlocks();
      } else {
        state = ids.toSet();
      }
    } catch (e) {
      debugPrint('[UnlockedCases] Fetch error: $e');
    }
  }

  /// İlk girişte her zorluktan random 1 vaka aç
  Future<void> initializeUnlocks() async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.post(AppConstants.initializeUnlocksEndpoint);
      final ids = (response.data['unlockedCaseIds'] as List?)?.cast<String>() ?? [];
      state = ids.toSet();
    } catch (e) {
      debugPrint('[UnlockedCases] Initialize error: $e');
    }
  }

  /// Reklam izleyerek belirli zorluktan random vaka aç
  Future<String?> unlockWithAd(String difficulty) async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.post(
        AppConstants.unlockWithAdEndpoint,
        data: {'difficulty': difficulty},
      );
      final caseId = response.data['caseId'] as String?;
      if (caseId != null) {
        state = {...state, caseId};
      }
      return caseId;
    } catch (e) {
      debugPrint('[UnlockedCases] Unlock with ad error: $e');
      return null;
    }
  }

  /// Vaka tamamlandığında çağrılır — aynı zorluktan yeni vaka açar
  Future<String?> unlockNext(String difficulty) async {
    try {
      final dio = _ref.read(dioProvider);
      final response = await dio.post(
        AppConstants.unlockNextEndpoint,
        data: {'difficulty': difficulty},
      );
      final caseId = response.data['caseId'] as String?;
      if (caseId != null) {
        state = {...state, caseId};
      }
      return caseId;
    } catch (e) {
      debugPrint('[UnlockedCases] Unlock next error: $e');
      return null;
    }
  }

  bool isUnlocked(String caseId) => state.contains(caseId);
}

final unlockedCasesProvider =
    StateNotifierProvider<UnlockedCasesNotifier, Set<String>>((ref) {
  return UnlockedCasesNotifier(ref);
});
