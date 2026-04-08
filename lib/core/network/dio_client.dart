import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../services/secure_storage_service.dart';
import '../utils/app_logger.dart';

/// Auth Interceptor — Otomatik Token Yenileme
///
/// Her giden HTTP isteğine SecureStorage'dan okunan JWT token'ı
/// `Authorization: Bearer <token>` header'ı olarak ekler.
/// 401 hatası alındığında refresh token ile otomatik yenileme dener.
/// Refresh da başarısız olursa token'ları temizler.
class AuthInterceptor extends QueuedInterceptor {
  final SecureStorageService _storageService;
  final Dio _dio;

  /// Refresh işlemi sırasında çoklu istek çakışmasını önlemek için kilit
  bool _isRefreshing = false;

  AuthInterceptor(this._storageService, this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Auth gerektirmeyen endpoint'leri atla
    final noAuthPaths = [
      AppConstants.authGoogleEndpoint,
      AppConstants.authRefreshEndpoint,
    ];

    final requiresAuth = !noAuthPaths.any(
      (path) => options.path.contains(path),
    );

    if (requiresAuth) {
      final token = await _storageService.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 Unauthorized → Token expired, try refresh
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      // Refresh endpoint kendisi 401 dönerse sonsuz döngü olmasın
      if (err.requestOptions.path.contains(AppConstants.authRefreshEndpoint)) {
        await _storageService.clearAll();
        handler.next(err);
        return;
      }

      _isRefreshing = true;

      try {
        final accessToken = await _storageService.getToken();
        final refreshToken = await _storageService.getRefreshToken();

        if (accessToken == null || refreshToken == null) {
          await _storageService.clearAll();
          AppLogger.warning('AuthInterceptor', 'Token yok, temizlendi.');
          handler.next(err);
          return;
        }

        AppLogger.info('AuthInterceptor', '401 alındı, token yenileniyor...');

        // Refresh endpoint'ine istek at (interceptor'ı bypass etmek için yeni Dio)
        final refreshDio = Dio(BaseOptions(
          baseUrl: AppConstants.apiBaseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

        // Retry: geçici ağ hatalarında 1 kez daha dene
        Response? response;
        for (var attempt = 0; attempt < 2; attempt++) {
          try {
            response = await refreshDio.post(
              AppConstants.authRefreshEndpoint,
              data: {
                'accessToken': accessToken,
                'refreshToken': refreshToken,
              },
            );
            break; // Başarılı, döngüden çık
          } on DioException catch (e) {
            if (attempt == 1 || e.response?.statusCode != null) rethrow;
            AppLogger.warning('AuthInterceptor', 'Refresh retry ($attempt)...');
            await Future.delayed(const Duration(seconds: 1));
          }
        }

        if (response == null) {
          throw DioException(requestOptions: err.requestOptions, message: 'Refresh failed after retries');
        }

        final responseData = response.data;
        if (responseData is! Map<String, dynamic>) {
          throw FormatException('Refresh response beklenmeyen formatta: ${responseData.runtimeType}');
        }

        final newAccessToken = responseData['token'];
        final newRefreshToken = responseData['refreshToken'];

        if (newAccessToken is! String || newRefreshToken is! String) {
          throw const FormatException('Refresh response token alanları eksik veya hatalı.');
        }

        // Yeni token'ları kaydet
        await _storageService.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );

        AppLogger.info('AuthInterceptor', 'Token yenilendi, istek tekrarlanıyor.');

        // Orijinal isteği yeni token ile tekrarla
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        final retryResponse = await _dio.fetch(err.requestOptions);
        handler.resolve(retryResponse);
        return;
      } on DioException catch (refreshError) {
        AppLogger.error('AuthInterceptor', 'Refresh başarısız: ${refreshError.message}');
        await _storageService.clearAll();
        handler.next(err);
        return;
      } catch (e) {
        AppLogger.error('AuthInterceptor', 'Refresh hatası', e);
        await _storageService.clearAll();
        handler.next(err);
        return;
      } finally {
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }
}

/// Dio instance'ını yapılandıran ve sağlayan sınıf
class DioClient {
  final Dio dio;

  DioClient._({required this.dio});

  factory DioClient({required SecureStorageService storageService}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptors
    dio.interceptors.addAll([
      AuthInterceptor(storageService, dio),
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint('[Dio] $obj'),
        ),
    ]);

    return DioClient._(dio: dio);
  }
}

/// DioClient provider
/// SecureStorageService'e bağımlı — token interceptor için
final dioClientProvider = Provider<DioClient>((ref) {
  final storageService = ref.watch(secureStorageServiceProvider);
  return DioClient(storageService: storageService);
});

/// Dio instance'ına direkt erişim (kısa yol)
final dioProvider = Provider<Dio>((ref) {
  return ref.watch(dioClientProvider).dio;
});
