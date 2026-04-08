import 'package:flutter_test/flutter_test.dart';
import 'package:dedektif/data/models/case_bundle.dart';

void main() {
  group('CaseBundle Model', () {
    test('fromJson — tam veri', () {
      final json = {
        'id': 1,
        'name': 'Başlangıç Paketi',
        'description': '3 vaka bir arada',
        'caseIds': ['case_001', 'case_002', 'case_003'],
        'originalPrice': 120,
        'bundlePrice': 90,
        'discountPercent': 25,
        'isActive': true,
      };

      final bundle = CaseBundle.fromJson(json);

      expect(bundle.id, 1);
      expect(bundle.name, 'Başlangıç Paketi');
      expect(bundle.caseIds.length, 3);
      expect(bundle.caseIds, contains('case_002'));
      expect(bundle.originalPrice, 120);
      expect(bundle.bundlePrice, 90);
      expect(bundle.discountPercent, 25);
      expect(bundle.isActive, true);
    });

    test('fromJson — snake_case alanlar', () {
      final json = {
        'id': 2,
        'name': 'Test',
        'case_ids': ['case_001'],
        'original_price': 50,
        'bundle_price': 40,
        'discount_percent': 20,
        'is_active': false,
      };

      final bundle = CaseBundle.fromJson(json);

      expect(bundle.caseIds, ['case_001']);
      expect(bundle.originalPrice, 50);
      expect(bundle.bundlePrice, 40);
      expect(bundle.isActive, false);
    });

    test('fromJson — caseIds string olarak gelirse parse eder', () {
      final json = {
        'id': 3,
        'name': 'String Test',
        'case_ids': '["case_001","case_002"]',
        'original_price': 0,
        'bundle_price': 0,
        'discount_percent': 0,
      };

      final bundle = CaseBundle.fromJson(json);
      expect(bundle.caseIds.length, 2);
    });

    test('fromJson — boş/null alanlar', () {
      final bundle = CaseBundle.fromJson({'id': 0, 'name': ''});

      expect(bundle.caseIds, isEmpty);
      expect(bundle.originalPrice, 0);
      expect(bundle.isActive, true); // varsayılan
    });
  });
}
