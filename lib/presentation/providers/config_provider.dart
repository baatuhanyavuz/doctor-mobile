import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';

/// Uygulama konfigürasyonunu API'den çeken provider.
/// Uygulama açılışında bir kez çağrılır ve cache'lenir.
final appConfigProvider = FutureProvider.autoDispose<Map<String, String>>((ref) async {
  final dio = ref.watch(dioProvider);
  try {
    debugPrint('[AppConfig] Fetching config...');
    final response = await dio.get('/api/config');
    final Map<String, dynamic> data = response.data;
    final config = data.map((key, value) => MapEntry(key, value.toString()));
    debugPrint('[AppConfig] Config loaded: $config');
    return config;
  } catch (e) {
    debugPrint('[AppConfig] ERROR: $e');
    return {};
  }
});

/// CDN base URL'ine kolay erişim sağlayan provider.
final cdnBaseUrlProvider = Provider<String>((ref) {
  final configAsync = ref.watch(appConfigProvider);
  return configAsync.when(
    data: (config) => config['cdn_base_url'] ?? 'https://cdn.gloombit.com/detective/',
    loading: () => 'https://cdn.gloombit.com/detective/',
    error: (_, __) => 'https://cdn.gloombit.com/detective/',
  );
});
