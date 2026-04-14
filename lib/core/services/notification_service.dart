import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/app_logger.dart';

/// Background message handler — top-level function olmalı
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AppLogger.info('FCM', 'Background mesaj alındı: ${message.messageId}');
}

/// Push notification servisi
///
/// Firebase Cloud Messaging (FCM) entegrasyonu ve
/// local notification gösterimini yönetir.
class NotificationService {
  static const String _tag = 'NotificationService';

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  /// Bildirime tıklanınca çağrılacak callback
  void Function(String? route, Map<String, dynamic>? payload)? onNotificationTap;

  NotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotifications =
            localNotifications ?? FlutterLocalNotificationsPlugin();

  // ─── Android Notification Channel ────────────────────────────────

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'doctor_notifications',
    'Doktor Bildirimler',
    description: 'Doktor: Tanı Dosyaları uygulama bildirimleri',
    importance: Importance.high,
  );

  // ─── Initialization ──────────────────────────────────────────────

  /// Servisi başlat: izin iste, token al, listener'ları kur
  Future<void> init() async {
    if (kIsWeb) return; // Web'de push notification desteklenmeyecek

    // 1. Android notification channel oluştur
    await _createNotificationChannel();

    // 2. Local notifications'ı başlat
    await _initLocalNotifications();

    // 3. FCM izin iste
    await requestPermission();

    // 4. Foreground mesaj dinleyicisi
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 5. Bildirime tıklama (app background'dayken)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 6. App terminated iken bildirime tıklama
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    AppLogger.info(_tag, 'Notification servisi başlatıldı.');
  }

  // ─── Permission ──────────────────────────────────────────────────

  /// Bildirim izni iste
  Future<bool> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    final granted = settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;

    AppLogger.info(_tag, 'Bildirim izni: ${settings.authorizationStatus}');
    return granted;
  }

  // ─── FCM Token ───────────────────────────────────────────────────

  /// FCM device token'ını al
  Future<String?> getToken() async {
    try {
      final token = await _messaging.getToken();
      AppLogger.info(_tag, 'FCM Token alındı: ${token?.substring(0, 20)}...');
      return token;
    } catch (e) {
      AppLogger.error(_tag, 'FCM Token alınamadı', e);
      return null;
    }
  }

  /// Token yenilendiğinde dinle
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  // ─── Platform Bilgisi ────────────────────────────────────────────

  /// Cihaz platformunu döndür
  String getPlatform() {
    if (kIsWeb) return 'web';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    return 'unknown';
  }

  // ─── Local Notification Setup ────────────────────────────────────

  Future<void> _createNotificationChannel() async {
    if (!Platform.isAndroid) return;

    final androidPlugin =
        _localNotifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(_channel);
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );
  }

  // ─── Message Handlers ────────────────────────────────────────────

  /// Verilen saniye sonra local notification göster (in-app tek sefer)
  Future<void> scheduleLocalNotification({
    required int id,
    required String title,
    required String body,
    required int delaySeconds,
    String? route,
  }) async {
    if (kIsWeb) return;

    // Future.delayed ile basit schedule (uygulama açık olmalı)
    // Tam gerçekçi schedule için zonedSchedule + timezone kullanılabilir
    Future.delayed(Duration(seconds: delaySeconds), () async {
      try {
        await _localNotifications.show(
          id,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: route != null ? jsonEncode({'route': route}) : null,
        );
      } catch (e) {
        AppLogger.error(_tag, 'Local notification hatası', e);
      }
    });
  }

  /// Foreground'da mesaj geldiğinde local notification göster
  void _handleForegroundMessage(RemoteMessage message) {
    AppLogger.info(_tag, 'Foreground mesaj: ${message.notification?.title}');

    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  /// Bildirime tıklandığında (background → app açılınca)
  void _handleNotificationTap(RemoteMessage message) {
    AppLogger.info(_tag, 'Bildirime tıklandı: ${message.data}');

    final route = message.data['route'] as String?;
    onNotificationTap?.call(route, message.data);
  }

  /// Local notification'a tıklandığında
  void _onLocalNotificationTap(NotificationResponse response) {
    AppLogger.info(_tag, 'Local bildirime tıklandı: ${response.payload}');

    if (response.payload == null) return;

    try {
      final data = jsonDecode(response.payload!) as Map<String, dynamic>;
      final route = data['route'] as String?;
      onNotificationTap?.call(route, data);
    } catch (e) {
      AppLogger.error(_tag, 'Payload parse hatası', e);
    }
  }
}

/// NotificationService provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
