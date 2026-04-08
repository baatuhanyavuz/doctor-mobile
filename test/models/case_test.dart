import 'package:flutter_test/flutter_test.dart';
import 'package:dedektif/data/models/case.dart';

void main() {
  group('Case Model', () {
    test('fromJson — minimal vaka', () {
      final json = {
        'id': 'case_001',
        'title': 'Test Vakası',
        'difficulty': 'medium',
        'status': 'available',
        'price': 0.0,
        'creditPrice': 40,
      };

      final c = Case.fromJson(json);

      expect(c.id, 'case_001');
      expect(c.title, 'Test Vakası');
      expect(c.difficulty, Difficulty.medium);
      expect(c.status, CaseStatus.available);
      expect(c.creditPrice, 40);
      expect(c.price, 0.0);
    });

    test('fromJson — varsayılan değerler', () {
      final c = Case.fromJson({});

      expect(c.id, '');
      expect(c.title, '');
      expect(c.difficulty, Difficulty.easy);
      expect(c.status, CaseStatus.available);
      expect(c.price, 0.0);
      expect(c.creditPrice, isNull);
      expect(c.evidences, isEmpty);
      expect(c.suspects, isEmpty);
    });

    test('fromJson — tam veri ile', () {
      final json = {
        'id': 'case_007',
        'title': 'Son Perde',
        'difficulty': 'hard',
        'status': 'available',
        'creditPrice': 550,
        'victim': {'name': 'Ahmet', 'age': 45, 'occupation': 'Yönetmen'},
        'suspects': [
          {'id': 's1', 'name': 'Ali'},
          {'id': 's2', 'name': 'Veli'},
        ],
        'evidences': [
          {'id': 'ev1', 'title': 'Bıçak', 'type': 'object'},
        ],
      };

      final c = Case.fromJson(json);

      expect(c.victim.name, 'Ahmet');
      expect(c.victim.age, 45);
      expect(c.suspects.length, 2);
      expect(c.evidences.length, 1);
      expect(c.creditPrice, 550);
    });

    test('temel alanlar doğru serialize edilir', () {
      final original = Case(
        id: 'case_test',
        title: 'Serialize Test',
        difficulty: Difficulty.hard,
        creditPrice: 50,
      );

      final json = original.toJson();

      expect(json['id'], 'case_test');
      expect(json['title'], 'Serialize Test');
      expect(json['difficulty'], 'hard');
      expect(json['creditPrice'], 50);
    });
  });

  group('Victim Model', () {
    test('fromJson', () {
      final v = Victim.fromJson({
        'name': 'Mehmet',
        'age': 35,
        'occupation': 'Doktor',
        'causeOfDeath': 'Zehirlenme',
      });

      expect(v.name, 'Mehmet');
      expect(v.age, 35);
      expect(v.occupation, 'Doktor');
      expect(v.causeOfDeath, 'Zehirlenme');
    });

    test('varsayılan değerler', () {
      final v = Victim.fromJson({});
      expect(v.name, '');
      expect(v.age, isNull);
    });
  });

  group('Difficulty Enum', () {
    test('tüm zorluk seviyeleri parse edilir', () {
      expect(Case.fromJson({'difficulty': 'tutorial'}).difficulty, Difficulty.tutorial);
      expect(Case.fromJson({'difficulty': 'easy'}).difficulty, Difficulty.easy);
      expect(Case.fromJson({'difficulty': 'medium'}).difficulty, Difficulty.medium);
      expect(Case.fromJson({'difficulty': 'hard'}).difficulty, Difficulty.hard);
      expect(Case.fromJson({'difficulty': 'expert'}).difficulty, Difficulty.expert);
    });
  });
}
