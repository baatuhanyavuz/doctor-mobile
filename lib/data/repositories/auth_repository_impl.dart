import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failure.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/utils/app_logger.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

/// Auth repository implementasyonu
///
/// Handles authentication for both Mobile (Android/iOS) and Web platforms.
/// 
/// Mobile: Google Sign-In plugin → idToken → Backend
/// Web: Google Identity Services SDK → idToken → Backend (via signInWithGoogleIdToken)
class AuthRepositoryImpl implements IAuthRepository {
  final GoogleSignIn _googleSignIn;
  final Dio _dio;
  final SecureStorageService _storageService;

  AuthRepositoryImpl({
    required GoogleSignIn googleSignIn,
    required Dio dio,
    required SecureStorageService storageService,
  })  : _googleSignIn = googleSignIn,
        _dio = dio,
        _storageService = storageService;

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      // For web: just trigger the sign-in flow
      // For mobile: shows system dialog
      AppLogger.debug('Auth', 'Google Sign-In başlatılıyor...');
      AppLogger.debug('Auth', 'serverClientId: ${AppConstants.googleServerClientId}');
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Left(GoogleSignInFailure('Google girişi iptal edildi.'));
      }

      // Get authentication details
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        return Left(GoogleSignInFailure('Google token alınamadı.'));
      }

      // Send idToken to backend
      return _authenticateWithBackend(idToken);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e, stack) {
      AppLogger.error('Auth', 'Beklenmeyen hata: $e', e, stack);
      return Left(UnknownFailure('Giriş sırasında hata oluştu: $e'));
    }
  }

  /// Web-only method: Called when GIS SDK provides idToken
  ///
  @override
  Future<Either<Failure, User>> signInWithApple() async {
    try {
      // Apple Sign-In sadece iOS'ta desteklenir
      if (kIsWeb || !Platform.isIOS) {
        return Left(UnknownFailure('Apple ile giriş sadece iOS\'ta desteklenir.'));
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final email = credential.email;
      final fullName = [credential.givenName, credential.familyName]
          .where((n) => n != null && n.isNotEmpty)
          .join(' ');

      if (email == null || email.isEmpty) {
        return Left(UnknownFailure('Apple hesabından e-posta alınamadı.'));
      }

      // Backend'e gönder
      final response = await _dio.post(
        AppConstants.authAppleEndpoint,
        data: {
          'identityToken': credential.identityToken,
          'authorizationCode': credential.authorizationCode,
          'email': email,
          'fullName': fullName.isEmpty ? 'Apple User' : fullName,
        },
      );

      return _parseAuthResponse(response.data);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return Left(GoogleSignInFailure('Apple ile giriş iptal edildi.'));
      }
      return Left(UnknownFailure('Apple giriş hatası: ${e.message}'));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Apple Sign-In error', e);
      return Left(UnknownFailure('Apple ile giriş başarısız: $e'));
    }
  }

  /// Called from the web login button after user authenticates
  /// with Google Identity Services JavaScript SDK.
  @override
  Future<Either<Failure, User>> signInWithGoogleIdToken(String idToken) async {
    try {
      AppLogger.debug('Auth', 'Web: Received idToken from GIS SDK');

      if (idToken.isEmpty) {
        return Left(GoogleSignInFailure('Google token alınamadı.'));
      }

      // Send idToken to backend
      return _authenticateWithBackend(idToken);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Web authentication error', e);
      return Left(UnknownFailure('Web giriş sırasında hata oluştu: $e'));
    }
  }

  /// Common backend authentication logic
  ///
  /// Shared by both mobile (signInWithGoogle) and web (signInWithGoogleIdToken)
  /// Sends idToken to backend, receives JWT and user data
  Future<Either<Failure, User>> _authenticateWithBackend(String idToken) async {
    try {
      AppLogger.debug('Auth', 'Sending idToken to backend...');

      // Send idToken to .NET backend
      final response = await _dio.post(
        AppConstants.authGoogleEndpoint,
        data: {'idToken': idToken},
      );

      return _parseAuthResponse(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Backend auth error', e);
      return Left(UnknownFailure('Backend authentication failed: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.authRegisterEndpoint,
        data: {
          'email': email,
          'password': password,
          'fullName': fullName,
        },
      );

      return _parseAuthResponse(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message = _extractErrorMessage(e.response?.data) ??
            'Bu e-posta adresi zaten kullanımda.';
        return Left(EmailAuthFailure(message));
      }
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Email kayıt hatası', e);
      return Left(UnknownFailure('Kayıt sırasında hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.authLoginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
      );

      return _parseAuthResponse(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final message = _extractErrorMessage(e.response?.data) ??
            'E-posta veya şifre hatalı.';
        return Left(EmailAuthFailure(message));
      }
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Email giriş hatası', e);
      return Left(UnknownFailure('Giriş sırasında hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> authenticateWithGoogleAccount(GoogleSignInAccount googleUser) async {
    try {
      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        return Left(GoogleSignInFailure('Google token alınamadı.'));
      }

      AppLogger.debug('Auth', "Google idToken alındı (stream), backend'e gönderiliyor...");

      final response = await _dio.post(
        AppConstants.authGoogleEndpoint,
        data: {'idToken': idToken},
      );

      return _parseAuthResponse(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Beklenmeyen hata (stream)', e);
      return Left(UnknownFailure('Giriş sırasında hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Google oturumunu kapat
      await _googleSignIn.signOut();

      // JWT token'ı sil
      await _storageService.clearAll();

      AppLogger.info('Auth', 'Çıkış yapıldı.');
      return const Right(null);
    } catch (e) {
      AppLogger.error('Auth', 'Çıkış hatası', e);
      return Left(UnknownFailure('Çıkış sırasında hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> checkAuthStatus() async {
    try {
      // Kayıtlı token var mı?
      final hasToken = await _storageService.hasToken();
      if (!hasToken) {
        return Left(AuthFailure('Oturum bulunamadı.'));
      }

      // Token ile backend'den kullanıcı bilgisi al
      final response = await _dio.get(AppConstants.authMeEndpoint);

      final userData = response.data as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userData);

      AppLogger.info('Auth', 'Oturum doğrulandı: ${userModel.fullName}');
      return Right(userModel.toDomain());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token geçersiz → temizle
        await _storageService.deleteToken();
        return Left(AuthFailure('Oturum süresi doldu.'));
      }
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Auth kontrol hatası', e);
      return Left(UnknownFailure('Oturum kontrolünde hata: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required String fullName,
    required String email,
  }) async {
    try {
      final response = await _dio.put(
        AppConstants.authProfileEndpoint,
        data: {
          'fullName': fullName,
          'email': email,
        },
      );

      final userData = response.data as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userData);
      AppLogger.info('Auth', 'Profil güncellendi: ${userModel.fullName}');
      return Right(userModel.toDomain());
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        final message = _extractErrorMessage(e.response?.data) ??
            'Bu e-posta adresi zaten kullanımda.';
        return Left(EmailAuthFailure(message));
      }
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Profil güncelleme hatası', e);
      return Left(UnknownFailure('Profil güncellenirken hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dio.put(
        AppConstants.authChangePasswordEndpoint,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
      AppLogger.info('Auth', 'Şifre değiştirildi.');
      return const Right(null);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final message = _extractErrorMessage(e.response?.data) ??
            'Mevcut şifre hatalı.';
        return Left(EmailAuthFailure(message));
      }
      if (e.response?.statusCode == 400) {
        final message = _extractErrorMessage(e.response?.data) ??
            'Şifre değiştirilemedi.';
        return Left(EmailAuthFailure(message));
      }
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Şifre değiştirme hatası', e);
      return Left(UnknownFailure('Şifre değiştirilirken hata oluştu: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _dio.delete(AppConstants.authDeleteAccountEndpoint);
      AppLogger.info('Auth', 'Hesap silindi.');

      // Tüm lokal verileri temizle
      await _googleSignIn.signOut();
      await _storageService.clearAll();

      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      AppLogger.error('Auth', 'Hesap silme hatası', e);
      return Left(UnknownFailure('Hesap silinirken hata oluştu: $e'));
    }
  }

  /// Backend auth response'unu parse et ve doğrula
  ///
  /// Beklenen format: { "token": "...", "refreshToken": "...", "user": { ... } }
  Future<Either<Failure, User>> _parseAuthResponse(dynamic data) async {
    if (data is! Map<String, dynamic>) {
      return const Left(ServerFailure('Sunucudan beklenmeyen yanıt formatı.'));
    }

    final jwt = data['token'];
    final refreshToken = data['refreshToken'];
    final userData = data['user'];

    if (jwt is! String || refreshToken is! String) {
      return const Left(ServerFailure('Sunucu yanıtında token bilgisi eksik.'));
    }

    if (userData is! Map<String, dynamic>) {
      return const Left(ServerFailure('Sunucu yanıtında kullanıcı bilgisi eksik.'));
    }

    await _storageService.saveTokens(
      accessToken: jwt,
      refreshToken: refreshToken,
    );

    // isNewUser flag'ini kaydet (backend bunu döner)
    final isNewUser = data['isNewUser'] == true;
    await _storageService.saveNewUserFlag(isNewUser);

    final userModel = UserModel.fromJson(userData);
    AppLogger.info('Auth', 'Authentication successful: ${userModel.fullName} (isNewUser: $isNewUser)');
    return Right(userModel.toDomain());
  }

  /// DioException'ları Failure'a dönüştür
  Failure _handleDioError(DioException e) {
    AppLogger.error('Auth', 'DioException: ${e.type} - ${e.message}');

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Bağlantı zaman aşımına uğradı.');

      case DioExceptionType.connectionError:
        return NetworkFailure('Sunucuya bağlanılamadı. İnternet bağlantınızı kontrol edin.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _extractErrorMessage(e.response?.data);

        if (statusCode == 401) {
          return AuthFailure();
        }
        return ServerFailure(
          message ?? 'Sunucu hatası (${statusCode ?? 'bilinmiyor'})',
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return UnknownFailure('İstek iptal edildi.');

      default:
        return UnknownFailure(e.message ?? 'Bilinmeyen bir ağ hatası oluştu.');
    }
  }

  /// API hata mesajını çıkart
  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['title'] as String?;
    }
    if (data is String) return data;
    return null;
  }
}
