import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../models/mini_game.dart';

class MiniGameRepository {
  final Dio _dio;

  MiniGameRepository(this._dio);

  /// Balistik analiz sonucunu gönder (skor Flutter'da hesaplanır)
  Future<MiniGameResult> submitBallistic({
    required String caseId,
    required String miniGameId,
    required int score,
  }) async {
    final response = await _dio.post(
      AppConstants.miniGameBallisticEndpoint,
      data: {
        'caseId': caseId,
        'miniGameId': miniGameId,
        'miniGameType': 'ballistic',
        'score': score,
      },
    );
    return MiniGameResult.fromJson(response.data);
  }

  /// Sorgulama sonucunu gönder (skor Flutter'da hesaplanır)
  Future<MiniGameResult> submitInterrogation({
    required String caseId,
    required String miniGameId,
    required int score,
  }) async {
    final response = await _dio.post(
      AppConstants.miniGameInterrogationEndpoint,
      data: {
        'caseId': caseId,
        'miniGameId': miniGameId,
        'miniGameType': 'interrogation',
        'score': score,
      },
    );
    return MiniGameResult.fromJson(response.data);
  }

  /// Toksikoloji analiz sonucunu gönder
  Future<MiniGameResult> submitToxicology({
    required String caseId,
    required String miniGameId,
    required int score,
  }) async {
    final response = await _dio.post(
      '${AppConstants.miniGamesBaseEndpoint}/toxicology',
      data: {
        'caseId': caseId,
        'miniGameId': miniGameId,
        'miniGameType': 'toxicology',
        'score': score,
      },
    );
    return MiniGameResult.fromJson(response.data);
  }

  /// Genel mini oyun sonucu gönder (tüm tipler)
  Future<MiniGameResult> submitResult({
    required String caseId,
    required String miniGameId,
    required String miniGameType,
    required int score,
  }) async {
    final endpoint = switch (miniGameType) {
      'ballistic' => AppConstants.miniGameBallisticEndpoint,
      'interrogation' => AppConstants.miniGameInterrogationEndpoint,
      'toxicology' => '${AppConstants.miniGamesBaseEndpoint}/toxicology',
      _ => '${AppConstants.miniGamesBaseEndpoint}/$miniGameType',
    };
    final response = await _dio.post(
      endpoint,
      data: {
        'caseId': caseId,
        'miniGameId': miniGameId,
        'miniGameType': miniGameType,
        'score': score,
      },
    );
    return MiniGameResult.fromJson(response.data);
  }

  /// Bir davadaki tüm mini oyun sonuçlarını getir
  Future<List<MiniGameResult>> getResults(String caseId) async {
    final response = await _dio.get('${AppConstants.miniGameResultsEndpoint}/$caseId');
    final List<dynamic> data = response.data;
    return data.map((json) => MiniGameResult.fromJson(json)).toList();
  }
}
