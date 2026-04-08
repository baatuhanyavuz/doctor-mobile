import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/notification_service.dart';
import '../../core/utils/app_logger.dart';
import '../../data/repositories/notification_repository.dart';
import '../providers/auth_providers.dart';
import '../providers/auth_state.dart';
import '../providers/shift_provider.dart';

/// Notification servisini başlatan ve auth state'e göre
/// device token'ı register/unregister eden widget.
///
/// DoctorApp'in içinde, router'ın üzerinde kullanılır.
class NotificationInitializer extends ConsumerStatefulWidget {
  final Widget child;

  const NotificationInitializer({super.key, required this.child});

  @override
  ConsumerState<NotificationInitializer> createState() =>
      _NotificationInitializerState();
}

class _NotificationInitializerState
    extends ConsumerState<NotificationInitializer> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initNotifications();
    }
  }

  Future<void> _initNotifications() async {
    final notificationService = ref.read(notificationServiceProvider);

    // Notification servisini başlat
    await notificationService.init();

    // Bildirime tıklanınca route'a yönlendir
    notificationService.onNotificationTap = (route, payload) {
      if (route != null && mounted) {
        AppLogger.info('NotificationInit', 'Navigating to: $route');
        // Nöbet bildirimi ise shift provider'ı yenile
        if (payload?['type'] == 'shift_case' || payload?['type'] == 'shift_case_full') {
          ref.read(activeShiftProvider.notifier).refresh();
        }
        context.go(route);
      }
    };

    _initialized = true;

    // Auth state'i dinle — giriş yapıldığında register, çıkışta unregister
    ref.listenManual<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (_) => _registerDevice(),
        unauthenticated: () => _unregisterDevice(),
        orElse: () {},
      );
    });

    // Eğer zaten authenticated ise hemen register et
    final currentAuth = ref.read(authNotifierProvider);
    currentAuth.maybeWhen(
      authenticated: (_) => _registerDevice(),
      orElse: () {},
    );
  }

  Future<void> _registerDevice() async {
    if (!_initialized) return;

    final notificationRepo = ref.read(notificationRepositoryProvider);
    await notificationRepo.registerDevice();
    notificationRepo.listenTokenRefresh();
  }

  Future<void> _unregisterDevice() async {
    if (!_initialized) return;

    final notificationRepo = ref.read(notificationRepositoryProvider);
    await notificationRepo.unregisterDevice();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
