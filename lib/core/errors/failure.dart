import 'package:easy_localization/easy_localization.dart';

/// Uygulama genelinde kullanılan hata tipleri
///
/// fpdart `Either<Failure, T>` ile kullanılır.
/// Her katmanda oluşacak hatalar bu tiplere dönüştürülür.
sealed class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  String toString() => 'Failure($message, statusCode: $statusCode)';
}

/// Sunucu tarafından dönen hata (4xx, 5xx)
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

/// Ağ bağlantısı hatası (timeout, no internet)
class NetworkFailure extends Failure {
  NetworkFailure([String? message]) : super(message ?? 'errors.network'.tr());
}

/// Kimlik doğrulama hatası (401, token geçersiz)
class AuthFailure extends Failure {
  AuthFailure([String? message]) : super(message ?? 'errors.session_expired'.tr());
}

/// Google Sign-In hatası (iptal, hata)
class GoogleSignInFailure extends Failure {
  GoogleSignInFailure([String? message]) : super(message ?? 'errors.google_sign_in_failed'.tr());
}

/// E-posta/şifre giriş veya kayıt hatası
class EmailAuthFailure extends Failure {
  EmailAuthFailure([String? message]) : super(message ?? 'errors.invalid_credentials'.tr());
}

/// Bilinmeyen hata
class UnknownFailure extends Failure {
  UnknownFailure([String? message]) : super(message ?? 'errors.unexpected'.tr());
}
