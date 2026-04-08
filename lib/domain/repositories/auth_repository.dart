import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../entities/user.dart';

/// Auth repository arayüzü
///
/// Domain katmanı sadece bu arayüzü bilir.
/// Implementasyon detayları (Google, Apple, email vs.) data katmanında.
abstract class IAuthRepository {
  /// Google ile giriş yap (Mobile platforms)
  ///
  /// Android/iOS: Google Sign-In plugin → idToken → Backend API → JWT → User
  Future<Either<Failure, User>> signInWithGoogle();

  /// Web-specific authentication with Google Identity Services
  ///
  /// Web: GIS SDK → idToken → Backend API → JWT → User
  Future<Either<Failure, User>> signInWithGoogleIdToken(String idToken);

  /// Google'dan dönen hesap bilgisi ile backend doğrulaması yap
  Future<Either<Failure, User>> authenticateWithGoogleAccount(GoogleSignInAccount googleUser);

  /// Sign in with Apple
  Future<Either<Failure, User>> signInWithApple();

  /// E-posta ve şifre ile kayıt ol
  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
  });

  /// E-posta ve şifre ile giriş yap
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Oturumu kapat
  /// 
  /// Token'ı siler, Google oturumunu kapatır
  Future<Either<Failure, void>> logout();

  /// Mevcut auth durumunu kontrol et
  ///
  /// Kayıtlı JWT ile backend'den kullanıcı bilgisini çeker
  Future<Either<Failure, User>> checkAuthStatus();

  /// Profili güncelle (ad soyad, e-posta)
  Future<Either<Failure, User>> updateProfile({
    required String fullName,
    required String email,
  });

  /// Şifre değiştir
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Hesabı kalıcı olarak sil
  Future<Either<Failure, void>> deleteAccount();
}
