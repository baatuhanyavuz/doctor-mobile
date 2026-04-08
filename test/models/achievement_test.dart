import 'package:flutter_test/flutter_test.dart';
import 'package:dedektif/presentation/providers/achievement_provider.dart';

void main() {
  group('Achievement Model', () {
    test('fromJson — açılmış başarım', () {
      final json = {
        'id': 'first_case',
        'name': 'İlk Dosya',
        'description': 'İlk vakayı çöz',
        'icon': '📁',
        'category': 'cases',
        'creditReward': 10,
        'unlocked': true,
        'unlockedAt': '2026-03-30T12:00:00Z',
      };

      final a = Achievement.fromJson(json);

      expect(a.id, 'first_case');
      expect(a.name, 'İlk Dosya');
      expect(a.icon, '📁');
      expect(a.creditReward, 10);
      expect(a.unlocked, true);
      expect(a.unlockedAt, isNotNull);
    });

    test('fromJson — kilitli başarım', () {
      final json = {
        'id': 'cases_10',
        'name': 'Kıdemli Dedektif',
        'description': '10 vaka çöz',
        'icon': '⭐',
        'category': 'cases',
        'credit_reward': 50,
        'unlocked': false,
      };

      final a = Achievement.fromJson(json);

      expect(a.unlocked, false);
      expect(a.unlockedAt, isNull);
      expect(a.creditReward, 50); // snake_case desteği
    });

    test('fromJson — varsayılan değerler', () {
      final a = Achievement.fromJson({});

      expect(a.id, '');
      expect(a.icon, '🏆');
      expect(a.category, 'general');
      expect(a.creditReward, 0);
      expect(a.unlocked, false);
    });
  });
}
