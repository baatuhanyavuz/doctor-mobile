import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Uygulama genelinde kullanılan loglama servisi
///
/// Debug modda: console'a yazar (debugPrint)
/// Release modda: dart:developer log ile yazar (cihaz loglarında görünür)
class AppLogger {
  AppLogger._();

  static void debug(String tag, String message) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
    }
  }

  static void info(String tag, String message) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
    } else {
      developer.log(message, name: tag, level: 800);
    }
  }

  static void warning(String tag, String message) {
    if (kDebugMode) {
      debugPrint('⚠️ [$tag] $message');
    } else {
      developer.log(message, name: tag, level: 900);
    }
  }

  static void error(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[$tag] $message');
      if (error != null) debugPrint('[$tag] Error: $error');
      if (stackTrace != null) debugPrint('[$tag] Stack: $stackTrace');
    } else {
      developer.log(
        message,
        name: tag,
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
