import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dedektif/core/services/secure_storage_service.dart';
import 'package:dedektif/core/constants/app_constants.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageService service;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureStorageService(storage: mockStorage);
  });

  group('SecureStorageService — JWT Token', () {
    test('saveToken çağrılır', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await service.saveToken('test_token');

      verify(() => mockStorage.write(key: AppConstants.jwtTokenKey, value: 'test_token')).called(1);
    });

    test('getToken token döndürür', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'my_jwt_token');

      final token = await service.getToken();

      expect(token, 'my_jwt_token');
    });

    test('getToken — token yoksa null döner', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      final token = await service.getToken();

      expect(token, isNull);
    });

    test('hasToken — token varsa true', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'some_token');

      expect(await service.hasToken(), true);
    });

    test('hasToken — token yoksa false', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      expect(await service.hasToken(), false);
    });
  });

  group('SecureStorageService — Refresh Token', () {
    test('saveRefreshToken çağrılır', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await service.saveRefreshToken('refresh_abc');

      verify(() => mockStorage.write(key: AppConstants.refreshTokenKey, value: 'refresh_abc')).called(1);
    });
  });

  group('SecureStorageService — Token Pair', () {
    test('saveTokens iki token birlikte kaydeder', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await service.saveTokens(accessToken: 'jwt', refreshToken: 'ref');

      verify(() => mockStorage.write(key: AppConstants.jwtTokenKey, value: 'jwt')).called(1);
      verify(() => mockStorage.write(key: AppConstants.refreshTokenKey, value: 'ref')).called(1);
    });
  });

  group('SecureStorageService — Clear', () {
    test('clearAll tüm verileri siler', () async {
      when(() => mockStorage.deleteAll()).thenAnswer((_) async {});

      await service.clearAll();

      verify(() => mockStorage.deleteAll()).called(1);
    });
  });

  group('SecureStorageService — New User Flag', () {
    test('saveNewUserFlag true kaydeder', () async {
      when(() => mockStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async {});

      await service.saveNewUserFlag(true);

      verify(() => mockStorage.write(key: AppConstants.isNewUserKey, value: 'true')).called(1);
    });

    test('isNewUser true döner', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => 'true');

      expect(await service.isNewUser(), true);
    });

    test('isNewUser — değer yoksa false', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      expect(await service.isNewUser(), false);
    });
  });
}
