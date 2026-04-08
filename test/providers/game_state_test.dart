import 'package:flutter_test/flutter_test.dart';
import 'package:dedektif/presentation/providers/game_state_provider.dart';

void main() {
  group('GameState Model', () {
    test('varsayılan boş state', () {
      const state = GameState();

      expect(state.unlockedEvidenceIds, isEmpty);
      expect(state.viewedInterrogationIds, isEmpty);
      expect(state.unlockedDeductionIds, isEmpty);
      expect(state.progress, 0);
    });

    test('toJson → fromJson round-trip', () {
      final original = GameState(
        unlockedEvidenceIds: {'ev_001', 'ev_003'},
        viewedInterrogationIds: {'int_001'},
        unlockedDeductionIds: {'ded_001', 'ded_002'},
        progress: 45,
      );

      final json = original.toJson();
      final restored = GameState.fromJson(json);

      expect(restored.unlockedEvidenceIds, original.unlockedEvidenceIds);
      expect(restored.viewedInterrogationIds, original.viewedInterrogationIds);
      expect(restored.unlockedDeductionIds, original.unlockedDeductionIds);
    });

    test('copyWith', () {
      const state = GameState();
      final updated = state.copyWith(
        unlockedEvidenceIds: {'ev_001'},
        progress: 25,
      );

      expect(updated.unlockedEvidenceIds, {'ev_001'});
      expect(updated.progress, 25);
      expect(updated.viewedInterrogationIds, isEmpty); // değişmedi
    });

    test('copyWith — mevcut değerleri korur', () {
      final state = GameState(
        unlockedEvidenceIds: {'ev_001'},
        viewedInterrogationIds: {'int_001'},
      );

      final updated = state.copyWith(progress: 50);

      expect(updated.unlockedEvidenceIds, {'ev_001'}); // korundu
      expect(updated.viewedInterrogationIds, {'int_001'}); // korundu
      expect(updated.progress, 50);
    });
  });

  group('GameState toJson', () {
    test('doğru JSON çıktısı', () {
      final state = GameState(
        unlockedEvidenceIds: {'ev_001'},
        viewedInterrogationIds: {'int_001'},
        unlockedDeductionIds: {'ded_001'},
      );

      final json = state.toJson();

      expect(json['unlockedEvidenceIds'], isA<List>());
      expect(json['unlockedEvidenceIds'], contains('ev_001'));
      expect(json['viewedInterrogationIds'], contains('int_001'));
      expect(json['unlockedDeductionIds'], contains('ded_001'));
    });
  });
}
