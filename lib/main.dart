import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.dart';
import 'core/services/notification_service.dart';
import 'core/utils/sound_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Google Fonts — fontlar bundled değil, runtime fetch gerekli.
  // false + bundled olmayan font = exception fırlatır (Crashlytics: 41 crash).
  // true bırakıyoruz — indirme başarısızsa google_fonts sistem fontuna fallback yapar.
  GoogleFonts.config.allowRuntimeFetching = true;

  // Localization başlat
  await EasyLocalization.ensureInitialized();

  // Firebase başlat
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDbeajmoH2ACv5A6gkoirtMAAzqInKUMuk',
        authDomain: 'detective-487310.firebaseapp.com',
        projectId: 'detective-487310',
        storageBucket: 'detective-487310.firebasestorage.app',
        messagingSenderId: '449009688447',
        appId: '1:449009688447:web:c3849002cbe9b58086844a',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Crashlytics (web hariç)
  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // FCM background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // Web için temiz URL'ler (hash olmadan)
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  // Ses motorunu başlat
  await SoundManager.instance.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('tr'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      child: const ProviderScope(
        child: DoctorApp(),
      ),
    ),
  );
}
