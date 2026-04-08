import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// Güvenli depolama servisi
///
/// JWT token ve refresh token'ları şifreli olarak cihazda saklar.
/// Android: EncryptedSharedPreferences
/// iOS: Keychain
/// Web: Encrypted localStorage (sessionStorage değil)
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        );

  // ─── JWT Access Token ──────────────────────────────────────────

  /// JWT token'ı kaydet
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: AppConstants.jwtTokenKey, value: token);
    } catch (e) {
      debugPrint('[SecureStorage] Token kaydetme hatası: $e');
    }
  }

  /// JWT token'ı oku
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: AppConstants.jwtTokenKey);
    } catch (e) {
      debugPrint('[SecureStorage] Token okuma hatası: $e');
      return null;
    }
  }

  /// JWT token'ı sil
  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: AppConstants.jwtTokenKey);
    } catch (e) {
      debugPrint('[SecureStorage] Token silme hatası: $e');
    }
  }

  /// Token var mı?
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ─── Refresh Token ────────────────────────────────────────────

  /// Refresh token'ı kaydet
  Future<void> saveRefreshToken(String token) async {
    try {
      await _storage.write(key: AppConstants.refreshTokenKey, value: token);
    } catch (e) {
      debugPrint('[SecureStorage] Refresh token kaydetme hatası: $e');
    }
  }

  /// Refresh token'ı oku
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: AppConstants.refreshTokenKey);
    } catch (e) {
      debugPrint('[SecureStorage] Refresh token okuma hatası: $e');
      return null;
    }
  }

  /// Refresh token'ı sil
  Future<void> deleteRefreshToken() async {
    try {
      await _storage.delete(key: AppConstants.refreshTokenKey);
    } catch (e) {
      debugPrint('[SecureStorage] Refresh token silme hatası: $e');
    }
  }

  // ─── Her İki Token'ı Birlikte Kaydet ──────────────────────────

  /// Access + refresh token çiftini birlikte kaydet
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await saveToken(accessToken);
    await saveRefreshToken(refreshToken);
  }

  // ─── New User Flag ──────────────────────────────────────────

  /// Yeni kullanıcı flag'ini kaydet
  Future<void> saveNewUserFlag(bool isNew) async {
    try {
      await _storage.write(
        key: AppConstants.isNewUserKey,
        value: isNew ? 'true' : 'false',
      );
    } catch (e) {
      debugPrint('[SecureStorage] New user flag kaydetme hatası: $e');
    }
  }

  /// Yeni kullanıcı flag'ini oku
  Future<bool> isNewUser() async {
    try {
      final value = await _storage.read(key: AppConstants.isNewUserKey);
      return value == 'true';
    } catch (e) {
      debugPrint('[SecureStorage] New user flag okuma hatası: $e');
      return false;
    }
  }

  /// Yeni kullanıcı flag'ini temizle
  Future<void> clearNewUserFlag() async {
    try {
      await _storage.delete(key: AppConstants.isNewUserKey);
    } catch (e) {
      debugPrint('[SecureStorage] New user flag silme hatası: $e');
    }
  }

  // ─── Tümünü Temizle ──────────────────────────────────────────

  /// Tüm kayıtlı verileri sil (logout)
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      debugPrint('[SecureStorage] Tümünü silme hatası: $e');
    }
  }
}

/// SecureStorageService provider
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});
