import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'auth_state.freezed.dart';

/// Kimlik doğrulama durumu
///
/// UI bu duruma göre hangi ekranı göstereceğine karar verir.
@freezed
sealed class AuthState with _$AuthState {
  /// Başlangıç durumu — henüz kontrol edilmedi
  const factory AuthState.initial() = AuthInitial;

  /// Yükleniyor (giriş yapılıyor veya kontrol ediliyor)
  const factory AuthState.loading() = AuthLoading;

  /// Giriş yapılmış
  const factory AuthState.authenticated(User user) = AuthAuthenticated;

  /// Giriş yapılmamış
  const factory AuthState.unauthenticated() = AuthUnauthenticated;

  /// Hata oluştu
  const factory AuthState.error(String message) = AuthError;
}
