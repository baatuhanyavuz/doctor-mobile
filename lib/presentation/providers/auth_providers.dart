import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/secure_storage_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';
import 'case_providers.dart';
import 'credit_providers.dart';
import 'config_provider.dart';

// ─── New User Flag Provider ────────────────────────────────────
/// İlk kez giriş yapan kullanıcıyı takip eder.
/// true ise kullanıcı onboarding ekranına yönlendirilir.
final isNewUserProvider = StateProvider<bool>((ref) => false);

// ─── Google Sign-In Provider ────────────────────────────────────
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  if (kIsWeb) {
    // Web: Don't pass serverClientId for web platform
    return GoogleSignIn(
      scopes: ['email', 'profile'],
    );
  }
  // Mobile: Include serverClientId
  return GoogleSignIn(
    serverClientId: AppConstants.googleServerClientId,
    scopes: ['email', 'profile'],
  );
});

// ─── Auth Repository Provider ───────────────────────────────────
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryImpl(
    googleSignIn: ref.watch(googleSignInProvider),
    dio: ref.watch(dioProvider),
    storageService: ref.watch(secureStorageServiceProvider),
  );
});

// ─── Auth Notifier ──────────────────────────────────────────────

/// Auth durumunu yöneten Notifier
///
/// Uygulama başladığında checkAuthStatus çağrılır.
/// Login ekranından signInWithGoogle çağrılır.
/// AuthState değiştiğinde go_router redirect tetiklenir.
class AuthNotifier extends Notifier<AuthState> {
  StreamSubscription<GoogleSignInAccount?>? _googleAuthSubscription;

  @override
  AuthState build() {
    // Başlangıçta auth durumunu kontrol et
    _checkAuthOnInit();

    // Dinle: Web GIS SDK veya signIn tetiklemesinden gelen kullanıcı kimliği stream'i
    _googleAuthSubscription = ref.read(googleSignInProvider).onCurrentUserChanged.listen((account) {
      if (account != null) {
        final isAuth = state.maybeWhen(
          authenticated: (_) => true,
          loading: () => true, // Eğer kendi başlattığımız sürece denk gelirse tekrar beklemesin
          orElse: () => false,
        );
        if (!isAuth) {
          _handleGoogleAccount(account);
        }
      }
    });

    ref.onDispose(() {
      _googleAuthSubscription?.cancel();
    });

    return const AuthState.initial();
  }

  /// Uygulama başlatıldığında oturum kontrolü
  Future<void> _checkAuthOnInit() async {
    state = const AuthState.loading();

    // Web: Initialize GoogleSignIn so renderButton works
    if (kIsWeb) {
      try {
        await ref.read(googleSignInProvider).isSignedIn();
      } catch (_) {}
    }

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.checkAuthStatus();

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Oturum bulunamadı: ${failure.message}');
        state = const AuthState.unauthenticated();
      },
      (user) async {
        debugPrint('[AuthNotifier] Oturum mevcut: ${user.fullName}');
        // Secure storage'dan isNewUser flag'ini oku
        final storage = ref.read(secureStorageServiceProvider);
        final isNew = await storage.isNewUser();
        ref.read(isNewUserProvider.notifier).state = isNew;
        state = AuthState.authenticated(user);
      },
    );
  }

  /// Google ile giriş yap
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithGoogle();

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Giriş hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Giriş başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// Apple ile giriş yap (iOS only)
  Future<void> signInWithApple() async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithApple();

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Apple giriş hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Apple giriş başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// Web-only: Sign in with idToken from Google Identity Services
  ///
  /// Called when GIS SDK provides idToken from authentication event
  Future<void> signInWithGoogleIdToken(String idToken) async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithGoogleIdToken(idToken);

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Web giriş hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Web giriş başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// GoogleSignInAccount geldiğinde backend login işlemini yönetir
  Future<void> _handleGoogleAccount(GoogleSignInAccount account) async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.authenticateWithGoogleAccount(account);

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Stream giriş hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Stream giriş başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// E-posta ve şifre ile kayıt ol
  Future<void> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.registerWithEmail(
      email: email,
      password: password,
      fullName: fullName,
    );

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Kayıt hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Kayıt başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// E-posta ve şifre ile giriş yap
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.signInWithEmail(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Email giriş hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (user) async {
        debugPrint('[AuthNotifier] Email giriş başarılı: ${user.fullName}');
        await _syncNewUserFlag();
        state = AuthState.authenticated(user);
      },
    );
  }

  /// Secure storage'dan isNewUser flag'ini oku ve provider'a yansıt
  Future<void> _syncNewUserFlag() async {
    final storage = ref.read(secureStorageServiceProvider);
    final isNew = await storage.isNewUser();
    ref.read(isNewUserProvider.notifier).state = isNew;
  }

  /// Tüm kullanıcıya ait provider cache'lerini temizle.
  /// try-catch ile CircularDependencyError'u yakalar (Crashlytics: 6 crash).
  void _invalidateAllUserProviders() {
    try {
      ref.invalidate(appConfigProvider);
      ref.invalidate(creditPackagesProvider);
      ref.invalidate(subscriptionPlansProvider);
      ref.invalidate(creditTransactionsProvider);
      ref.invalidate(activeSubscriptionProvider);
      ref.invalidate(creditNotifierProvider);
      ref.invalidate(allCasesProvider);
      ref.invalidate(completedCaseIdsProvider);
      ref.invalidate(purchasedCaseIdsProvider);
    } catch (e) {
      debugPrint('[AuthNotifier] Provider invalidate hatası: $e');
    }
  }

  /// Onboarding tamamlandığında çağrılır
  Future<void> completeOnboarding() async {
    final storage = ref.read(secureStorageServiceProvider);
    await storage.clearNewUserFlag();
    ref.read(isNewUserProvider.notifier).state = false;
  }

  /// Çıkış yap
  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();

    debugPrint('[AuthNotifier] Çıkış başarılı');
    // Önce state'i değiştir, sonra cache'leri temizle
    // Böylece invalidate edilen provider'lar unauthenticated state'i görüp fetch etmez
    state = const AuthState.unauthenticated();
    _invalidateAllUserProviders();
  }

  /// Kullanıcının XP ve Seviye bilgisini lokal olarak güncelle (örneğin vaka çözdükten sonra)
  void updateUserProgress({required int newLevel, required int newTotalXp}) {
    state.maybeWhen(
      authenticated: (user) {
        final updatedUser = user.copyWith(
          level: newLevel,
          totalXp: newTotalXp,
        );
        state = AuthState.authenticated(updatedUser);
      },
      orElse: () {},
    );
  }

  /// Profili güncelle (ad soyad, e-posta)
  Future<bool> updateProfile({
    required String fullName,
    required String email,
  }) async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.updateProfile(
      fullName: fullName,
      email: email,
    );

    return result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Profil güncelleme hatası: ${failure.message}');
        state = AuthState.error(failure.message);
        return false;
      },
      (user) {
        debugPrint('[AuthNotifier] Profil güncellendi: ${user.fullName}');
        state = AuthState.authenticated(user);
        return true;
      },
    );
  }

  /// Şifre değiştir
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    return result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Şifre değiştirme hatası: ${failure.message}');
        state = AuthState.error(failure.message);
        return false;
      },
      (_) {
        debugPrint('[AuthNotifier] Şifre değiştirildi');
        // State'i tekrar authenticated olarak ayarla (error state'inden çıkmak için)
        state.maybeWhen(
          authenticated: (user) => state = AuthState.authenticated(user),
          orElse: () {},
        );
        return true;
      },
    );
  }

  /// Hesabı kalıcı olarak sil
  Future<void> deleteAccount() async {
    state = const AuthState.loading();

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.deleteAccount();

    result.fold(
      (failure) {
        debugPrint('[AuthNotifier] Hesap silme hatası: ${failure.message}');
        state = AuthState.error(failure.message);
      },
      (_) {
        debugPrint('[AuthNotifier] Hesap silindi');
        _invalidateAllUserProviders();
        state = const AuthState.unauthenticated();
      },
    );
  }
}

/// AuthNotifier provider
final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
