import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import '../../data/models/mini_game.dart';
import '../../data/repositories/mini_game_repository.dart';

/// MiniGame repository provider
final miniGameRepositoryProvider = Provider<MiniGameRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MiniGameRepository(dio);
});

/// Bir davadaki tamamlanmış mini oyun sonuçları
final miniGameResultsProvider =
    FutureProvider.autoDispose.family<List<MiniGameResult>, String>((ref, caseId) async {
  final repo = ref.watch(miniGameRepositoryProvider);
  return repo.getResults(caseId);
});

/// Mini oyun sonucu gönder (tüm tipler için ortak)
final submitMiniGameProvider =
    FutureProvider.autoDispose.family<MiniGameResult?, Map<String, dynamic>>((ref, params) async {
  final repo = ref.watch(miniGameRepositoryProvider);
  final caseId = params['caseId'] as String;
  final miniGameId = params['miniGameId'] as String;
  final miniGameType = params['miniGameType'] as String;
  final score = params['score'] as int;

  return repo.submitResult(
    caseId: caseId,
    miniGameId: miniGameId,
    miniGameType: miniGameType,
    score: score,
  );
});
