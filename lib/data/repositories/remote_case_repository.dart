import 'package:dio/dio.dart';
import '../../core/utils/lab_randomizer.dart';
import '../../domain/repositories/case_repository.dart';
import '../models/case.dart';
import '../models/medical_data.dart';

/// Remote API'den vakaları çeken repository implementasyonu
class RemoteCaseRepository implements ICaseRepository {
  final Dio _dio;

  RemoteCaseRepository(this._dio);

  @override
  Future<List<Case>> getAllCases() async {
    try {
      final response = await _dio.get('/api/cases');
      
      // Defensive check: Ensure response data is a list
      if (response.data is! List) {
        throw Exception('API vaka listesi beklenmedik bir formatta döndürdü.');
      }

      final List<dynamic> data = response.data;
      
      return data.map((json) {
        if (json is! Map<String, dynamic>) {
          return null;
        }
        try {
          return Case.fromJson(json);
        } catch (e) {
          return null;
        }
      })
      .whereType<Case>() // Skip nulls from failed parsing
      .toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Case?> getCaseById(String id) async {
    try {
      final response = await _dio.get('/api/cases/$id');
      
      if (response.data is! Map<String, dynamic>) {
        throw Exception('API geçersiz vaka detayı döndürdü.');
      }

      final parsedCase = Case.fromJson(response.data as Map<String, dynamic>);
      return _randomizeLabValues(parsedCase);
    } catch (e) {
      // 404 durumunda null dön
      if (e is DioException && e.response?.statusCode == 404) {
        return null;
      }
      throw _handleError(e);
    }
  }

  /// Laboratuvar sonuc degerlerini hafifce rastgelelestir (tekrar oynama icin)
  Case _randomizeLabValues(Case c) {
    final randomized = c.medicalData.map((md) {
      if (md.resultValue != null && md.resultValue!.isNotEmpty) {
        return md.copyWith(
          resultValue: LabRandomizer.randomizeValue(md.resultValue!, variance: 0.08),
        );
      }
      return md;
    }).toList();

    return c.copyWith(medicalData: randomized);
  }

  Exception _handleError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Bağlantı zaman aşımına uğradı. Lütfen tekrar deneyin.');
        case DioExceptionType.connectionError:
          return Exception('İnternet bağlantısı kurulamadı. Bağlantınızı kontrol edin.');
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final message = e.response?.data is Map
              ? (e.response?.data['message'] ?? e.response?.data['title'])
              : null;
          if (statusCode == 404) return Exception('İstenen vaka bulunamadı.');
          if (statusCode == 500) return Exception('Sunucu hatası. Lütfen daha sonra tekrar deneyin.');
          return Exception(message ?? 'Sunucu hatası ($statusCode)');
        case DioExceptionType.cancel:
          return Exception('İstek iptal edildi.');
        default:
          return Exception(e.message ?? 'Beklenmeyen ağ hatası.');
      }
    }
    return Exception('Beklenmeyen hata: $e');
  }

}
