import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Retest yapilmis tibbi verilerin ID ve dogru degerlerini tutan provider
///
/// Bellekte tutuluyor. Retest basarili olursa evidence ID -> correctValue eslestirmesi saklanir.
class RetestedEvidencesNotifier extends StateNotifier<Map<String, String>> {
  RetestedEvidencesNotifier() : super({});

  /// Retest sonucunu kaydet
  void markRetested(String evidenceId, String correctValue) {
    state = {...state, evidenceId: correctValue};
  }

  /// Bir tibbi veri retest edilmis mi
  bool isRetested(String evidenceId) {
    return state.containsKey(evidenceId);
  }

  /// Retest edilmis dogru degeri getir
  String? getCorrectValue(String evidenceId) {
    return state[evidenceId];
  }

  /// Tum retest durumunu temizle
  void clearAll() {
    state = {};
  }
}

/// Retested evidences provider
final retestedEvidencesProvider =
    StateNotifierProvider<RetestedEvidencesNotifier, Map<String, String>>((ref) {
  return RetestedEvidencesNotifier();
});
