import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/case_randomizer.dart';
import '../../data/models/case.dart';
import '../../data/repositories/remote_case_repository.dart';
import '../../domain/repositories/case_repository.dart';
import '../../core/network/dio_client.dart';
import 'auth_providers.dart';

/// Repository provider
/// API'den veri çeken RemoteCaseRepository kullanılır
final caseRepositoryProvider = Provider<ICaseRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return RemoteCaseRepository(dio);
});

/// Tüm vakaları getiren provider
final allCasesProvider = FutureProvider.autoDispose<List<Case>>((ref) async {
  final repository = ref.watch(caseRepositoryProvider);
  return repository.getAllCases();
});

/// Tek bir vakayı getiren provider (family)
/// autoDispose ile kullanıcı vakadan çıktığında RAM'den silinir
final caseByIdProvider = FutureProvider.autoDispose.family<Case?, String>((ref, id) async {
  final repository = ref.watch(caseRepositoryProvider);
  return repository.getCaseById(id);
});

/// Oyun ekranı için randomize edilmiş vaka provider'ı.
/// Tahlil değerlerinde ±%10 sapma, vital varyasyonları uygular.
/// Seed kullanıcı+vaka+gün bazlı → aynı gün içinde tutarlı sonuçlar.
final randomizedCaseProvider = FutureProvider.autoDispose.family<Case?, String>((ref, id) async {
  final baseCase = await ref.watch(caseByIdProvider(id).future);
  if (baseCase == null) return null;

  // Kullanıcı ID'sini seed için al
  final authState = ref.read(authNotifierProvider);
  final userId = authState.maybeWhen(
    authenticated: (user) => user.id,
    orElse: () => 'anonymous',
  );

  final seed = generateCaseSeed(userId, id);
  final randomizer = CaseRandomizer(seed: seed);
  return randomizer.randomize(baseCase);
});

/// Kullanıcının tamamladığı vaka ID'lerini getiren provider
/// GET /api/usercases → status == "Completed" olanların caseId'lerini döndürür
final completedCaseIdsProvider = FutureProvider.autoDispose<Set<String>>((ref) async {
  // Auth state değiştiğinde (login/logout) otomatik yeniden fetch et
  final authState = ref.watch(authNotifierProvider);
  final dio = ref.watch(dioProvider);

  // Sadece authenticated iken fetch et
  final isAuthenticated = authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );

  if (!isAuthenticated) {
    debugPrint('[CompletedCases] Not authenticated, returning empty set');
    return <String>{};
  }

  try {
    debugPrint('[CompletedCases] Fetching user cases...');
    final response = await dio.get('/api/usercases');
    debugPrint('[CompletedCases] Response: ${response.data}');
    final List<dynamic> data = response.data;
    final completed = data
        .where((uc) => uc['status'] == 'Completed')
        .map<String>((uc) => uc['caseId'] as String)
        .toSet();
    debugPrint('[CompletedCases] Completed IDs: $completed');
    return completed;
  } catch (e) {
    debugPrint('[CompletedCases] ERROR: $e');
    return <String>{};
  }
});

/// Kullanıcının başladığı ama tamamlamadığı vaka ID'leri
final startedCaseIdsProvider = FutureProvider.autoDispose<Set<String>>((ref) async {
  final authState = ref.watch(authNotifierProvider);
  final dio = ref.watch(dioProvider);

  final isAuthenticated = authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );

  if (!isAuthenticated) return <String>{};

  try {
    final response = await dio.get('/api/usercases');
    final List<dynamic> data = response.data;
    return data
        .where((uc) => uc['status'] == 'Started')
        .map<String>((uc) => uc['caseId'] as String)
        .toSet();
  } catch (e) {
    return <String>{};
  }
});
