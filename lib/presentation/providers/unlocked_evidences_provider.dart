import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Kullanıcının kilidi açtığı tıbbi verilerin ID'lerini tutan provider
/// 
/// Memory'de tutuluyor (uygulama kapatılınca sıfırlanır)
/// İleride SharedPreferences ile kalıcı hale getirilebilir
class UnlockedEvidencesNotifier extends StateNotifier<Set<String>> {
  UnlockedEvidencesNotifier() : super({});

  /// Bir tıbbi veriyin kilidini açmayı dene
  /// Girilen kod doğruysa true döner ve tıbbi veriyi açar
  /// Yanlışsa false döner
  bool tryUnlockEvidence(String evidenceId, String inputCode, String correctCode) {
    if (inputCode == correctCode) {
      state = {...state, evidenceId};
      return true;
    }
    return false;
  }

  /// Bir tıbbi veriyin kilidini direkt aç (kod kontrolü olmadan)
  void unlockEvidence(String evidenceId) {
    state = {...state, evidenceId};
  }

  /// Bir tıbbi veri kilitli mi kontrol et
  bool isUnlocked(String evidenceId) {
    return state.contains(evidenceId);
  }

  /// Tüm kilitleri temizle (test/debug için)
  void clearAll() {
    state = {};
  }
}

/// Unlocked evidences provider
final unlockedEvidencesProvider = 
    StateNotifierProvider<UnlockedEvidencesNotifier, Set<String>>((ref) {
  return UnlockedEvidencesNotifier();
});
