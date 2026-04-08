import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/notification_service.dart';
import '../../core/utils/app_logger.dart';

/// Push notification API iletişimi
class NotificationRepository {
  static const String _tag = 'NotificationRepo';

  final Dio _dio;
  final NotificationService _notificationService;

  NotificationRepository({
    required Dio dio,
    required NotificationService notificationService,
  })  : _dio = dio,
        _notificationService = notificationService;

  /// FCM token'ı backend'e kaydet
  Future<void> registerDevice() async {
    if (kIsWeb) return;

    try {
      final token = await _notificationService.getToken();
      if (token == null) {
        AppLogger.warning(_tag, 'FCM token alınamadı, kayıt atlanıyor.');
        return;
      }

      final platform = _notificationService.getPlatform();

      await _dio.post(
        AppConstants.notificationsRegisterDeviceEndpoint,
        data: {
          'fcmToken': token,
          'platform': platform,
        },
      );

      AppLogger.info(_tag, 'Device token backend\'e kaydedildi.');
    } on DioException catch (e) {
      AppLogger.error(_tag, 'Device token kayıt hatası: ${e.message}', e);
    } catch (e) {
      AppLogger.error(_tag, 'Device token kayıt hatası', e);
    }
  }

  /// FCM token'ı backend'den kaldır (logout)
  Future<void> unregisterDevice() async {
    if (kIsWeb) return;

    try {
      final token = await _notificationService.getToken();
      if (token == null) return;

      final platform = _notificationService.getPlatform();

      await _dio.post(
        AppConstants.notificationsUnregisterDeviceEndpoint,
        data: {
          'fcmToken': token,
          'platform': platform,
        },
      );

      AppLogger.info(_tag, 'Device token backend\'den kaldırıldı.');
    } on DioException catch (e) {
      AppLogger.error(_tag, 'Device token kaldırma hatası: ${e.message}', e);
    } catch (e) {
      AppLogger.error(_tag, 'Device token kaldırma hatası', e);
    }
  }

  /// Token yenilendiğinde otomatik güncelle
  void listenTokenRefresh() {
    _notificationService.onTokenRefresh.listen((newToken) async {
      AppLogger.info(_tag, 'FCM token yenilendi, backend güncelleniyor...');
      await registerDevice();
    });
  }
}

/// NotificationRepository provider
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(
    dio: ref.watch(dioProvider),
    notificationService: ref.watch(notificationServiceProvider),
  );
});
