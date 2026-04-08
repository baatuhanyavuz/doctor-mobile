import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/services/notification_service.dart';

/// Bildirim izin durumu provider'ı
/// Cihazın mevcut bildirim izin durumunu kontrol eder.
final notificationPermissionProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  if (kIsWeb) return false;

  final settings = await FirebaseMessaging.instance.getNotificationSettings();
  return settings.authorizationStatus == AuthorizationStatus.authorized ||
      settings.authorizationStatus == AuthorizationStatus.provisional;
});

/// Bildirim izni iste ve sonucu döndür
final requestNotificationPermissionProvider =
    FutureProvider.family.autoDispose<bool, void>((ref, _) async {
  final service = ref.read(notificationServiceProvider);
  final granted = await service.requestPermission();
  ref.invalidate(notificationPermissionProvider);
  return granted;
});
