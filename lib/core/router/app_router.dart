import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/game_screen.dart';
import '../../presentation/screens/briefing_screen.dart';
import '../../presentation/screens/conclusion_screen.dart';
import '../../presentation/screens/login/login_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/mini_games/ballistic_screen.dart';
import '../../presentation/screens/mini_games/interrogation_game_screen.dart';
import '../../presentation/screens/mini_games/toxicology_screen.dart';
import '../../presentation/screens/mini_games/blood_type_screen.dart';
import '../../presentation/screens/mini_games/ekg_reading_screen.dart';
import '../../presentation/screens/mini_games/drug_dose_screen.dart';
import '../../presentation/screens/mini_games/microscope_screen.dart';
import '../../presentation/screens/mini_games/auscultation_screen.dart';
import '../../presentation/screens/mini_games/cpr_rhythm_screen.dart';
import '../../presentation/screens/store/credit_store_screen.dart';
import '../../presentation/screens/case_preview_screen.dart';
import '../../presentation/screens/locker_room_screen.dart';
import '../../presentation/screens/shift/shift_lobby_screen.dart';
import '../../presentation/screens/shift/shift_case_screen.dart';
import '../../presentation/screens/shift/shift_report_screen.dart';
import '../../data/models/shift.dart';
import '../../presentation/providers/case_providers.dart';
import '../../presentation/providers/auth_providers.dart';
import '../../presentation/providers/auth_state.dart';
import '../../data/models/mini_game.dart';

/// Auth durumunu GoRouter'a köprüleyen ChangeNotifier
///
/// GoRouter'ın refreshListenable'ı bir ChangeNotifier bekler.
/// Bu sınıf Riverpod AuthState değişikliklerini ChangeNotifier'a çevirir.
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(Ref ref) {
    ref.listen<AuthState>(authNotifierProvider, (_, __) {
      notifyListeners();
    });
    // isNewUser değiştiğinde de router'ı yeniden değerlendir
    ref.listen<bool>(isNewUserProvider, (_, __) {
      notifyListeners();
    });
  }
}

/// AuthChangeNotifier provider — router tarafından kullanılır
final authChangeNotifierProvider = Provider<AuthChangeNotifier>((ref) {
  return AuthChangeNotifier(ref);
});

final routerProvider = Provider<GoRouter>((ref) {
  // ChangeNotifier ile GoRouter'a "yeniden değerlendir" sinyali gönder
  // ÖNEMLİ: ref.watch DEĞİL — router yeniden oluşturulmasın
  final authNotifier = ref.read(authChangeNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      // Redirect her tetiklendiğinde GÜNCEL auth durumunu oku
      final authState = ref.read(authNotifierProvider);
      final isLoginRoute = state.matchedLocation == '/login';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';

      return authState.when(
        initial: () => null, // Henüz kontrol edilmedi, bekle
        loading: () => null, // Yükleniyor, bekle (burada yönlendirme yapma!)
        authenticated: (user) {
          final isNewUser = ref.read(isNewUserProvider);

          // Yeni kullanıcı → onboarding'e yönlendir
          if (isNewUser && !isOnboardingRoute) return '/onboarding';

          // Onboarding tamamlanmış ama hala onboarding'deyse → ana sayfa
          if (!isNewUser && isOnboardingRoute) return '/';

          // Giriş yapılmış ama login ekranındaysa ana sayfaya yönlendir
          if (isLoginRoute) return '/';
          return null;
        },
        unauthenticated: () {
          // Giriş yapılmamış ve login ekranında değilse login'e yönlendir
          if (!isLoginRoute) return '/login';
          return null;
        },
        error: (message) {
          // Hata durumunda login'e yönlendir
          if (!isLoginRoute) return '/login';
          return null;
        },
      );
    },
    routes: [
      // ─── Login ──────────────────────────────────────────────
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ─── Onboarding (İlk Giriş Profil Oluşturma) ──────────
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ─── Dashboard (Ana Giriş Ekranı) ──────────────────────
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          // ─── Vaka Listesi ────────────────────────────────────
          GoRoute(
            path: 'cases',
            builder: (context, state) => const HomeScreen(),
          ),

          // ─── Profil ───────────────────────────────────────────
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),

          // ─── Kredi Mağazası ────────────────────────────────
          GoRoute(
            path: 'store',
            builder: (context, state) => const CreditStoreScreen(),
          ),

          // ─── Vaka Önizleme ──────────────────────────────────────
          GoRoute(
            path: 'preview/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              return CasePreviewScreen(caseId: caseId);
            },
          ),

          // ─── Brifing ────────────────────────────────────────────
          GoRoute(
            path: 'briefing/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId'];
              if (caseId == null || caseId.isEmpty) {
                return const Scaffold(
                  body: Center(child: Text('Geçersiz vaka ID')),
                );
              }
              return Consumer(
                builder: (context, ref, _) {
                  final caseAsync = ref.watch(caseByIdProvider(caseId));
                  return caseAsync.when(
                    data: (gameCase) {
                      if (gameCase == null) {
                        return const Scaffold(
                          body: Center(child: Text('Vaka bulunamadı')),
                        );
                      }
                      return BriefingScreen(
                        gameCase: gameCase,
                        onAccept: () => context.pushReplacement('/locker/$caseId'),
                      );
                    },
                    loading: () => const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, __) => Scaffold(
                      body: Center(child: Text('Vaka yüklenirken hata oluştu: $err')),
                    ),
                  );
                },
              );
            },
          ),

          // ─── Hazırlık Odası (KKD Seçimi) ────────────────────────
          GoRoute(
            path: 'locker/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              return Consumer(
                builder: (context, ref, _) {
                  final caseAsync = ref.watch(caseByIdProvider(caseId));
                  return caseAsync.when(
                    data: (gameCase) {
                      if (gameCase == null) {
                        return const Scaffold(
                          body: Center(child: Text('Vaka bulunamadı')),
                        );
                      }
                      return LockerRoomScreen(gameCase: gameCase);
                    },
                    loading: () => const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, __) => Scaffold(
                      body: Center(child: Text('Hata: $err')),
                    ),
                  );
                },
              );
            },
          ),

          // ─── Oyun ───────────────────────────────────────────────
          GoRoute(
            path: 'game/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId'];
              if (caseId == null || caseId.isEmpty) {
                return const Scaffold(
                  body: Center(child: Text('Geçersiz vaka ID')),
                );
              }
              return GameScreen(caseId: caseId);
            },
          ),

          // ─── Balistik Analiz Mini Oyunu ─────────────────────────
          GoRoute(
            path: 'minigame/ballistic/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return BallisticScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Sorgulama Mini Oyunu ─────────────────────────────────
          GoRoute(
            path: 'minigame/interrogation/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return InterrogationGameScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Toksikoloji Lab Mini Oyunu ───────────────────────────
          GoRoute(
            path: 'minigame/toxicology/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return ToxicologyScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Kan Grubu Tespiti Mini Oyunu ──────────────────────
          GoRoute(
            path: 'minigame/blood_type/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return BloodTypeScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── EKG Okuma Mini Oyunu ─────────────────────────────
          GoRoute(
            path: 'minigame/ekg_reading/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return EkgReadingScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── İlaç Dozu Hesaplama Mini Oyunu ───────────────────
          GoRoute(
            path: 'minigame/drug_dose/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return DrugDoseScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Mikroskop Analizi Mini Oyunu ─────────────────────
          GoRoute(
            path: 'minigame/microscope/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return MicroscopeScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Oskültasyon Mini Oyunu ───────────────────────────
          GoRoute(
            path: 'minigame/auscultation/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return AuscultationScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── CPR Ritim Mini Oyunu ─────────────────────────────
          GoRoute(
            path: 'minigame/cpr_rhythm/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId']!;
              final miniGame = state.extra as MiniGameDef;
              return CprRhythmScreen(caseId: caseId, miniGame: miniGame);
            },
          ),

          // ─── Nöbet Modu ───────────────────────────────────────────
          GoRoute(
            path: 'shift',
            builder: (context, state) => const ShiftLobbyScreen(),
          ),
          GoRoute(
            path: 'shift-case',
            builder: (context, state) => const ShiftCaseScreen(),
          ),
          GoRoute(
            path: 'shift-report',
            builder: (context, state) {
              final report = state.extra as ShiftStatus;
              return ShiftReportScreen(report: report);
            },
          ),

          // ─── Sonuç ──────────────────────────────────────────────
          GoRoute(
            path: 'conclusion/:caseId',
            builder: (context, state) {
              final caseId = state.pathParameters['caseId'];
              if (caseId == null || caseId.isEmpty) {
                return const Scaffold(
                  body: Center(child: Text('Geçersiz vaka ID')),
                );
              }
              // Failure parametreleri (opsiyonel)
              final failureType = state.uri.queryParameters['failure'];
              final failureData = state.extra as Map<String, String>?;

              return Consumer(
                builder: (context, ref, _) {
                  final caseAsync = ref.watch(caseByIdProvider(caseId));
                  return caseAsync.when(
                    data: (gameCase) {
                      if (gameCase == null) {
                        return const Scaffold(
                          body: Center(child: Text('Vaka bulunamadı')),
                        );
                      }
                      return ConclusionScreen(
                        gameCase: gameCase,
                        failureType: failureType,
                        failureData: failureData,
                      );
                    },
                    loading: () => const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, __) => Scaffold(
                      body: Center(child: Text('Vaka yüklenirken hata oluştu: $err')),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
});
