import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import '../../data/models/credit_package.dart';
import '../../data/models/subscription_plan.dart';
import '../../data/models/credit_transaction.dart';
import '../../data/models/active_subscription.dart';
import '../../data/models/validate_promo_result.dart';
import '../../data/repositories/credit_repository_impl.dart';
import '../../domain/repositories/credit_repository.dart';
import 'credit_notifier.dart';
import 'credit_state.dart';

// ─── Repository Provider ────────────────────────────────────────
final creditRepositoryProvider = Provider<ICreditRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CreditRepositoryImpl(dio);
});

// ─── Credit Notifier (bakiye + islemler) ────────────────────────
final creditNotifierProvider =
    AutoDisposeNotifierProvider<CreditNotifier, CreditState>(CreditNotifier.new);

// ─── Kredi Paketleri ────────────────────────────────────────────
final creditPackagesProvider =
    FutureProvider.autoDispose<List<CreditPackage>>((ref) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.getPackages();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (packages) => packages,
  );
});

// ─── Abonelik Planlari ──────────────────────────────────────────
final subscriptionPlansProvider =
    FutureProvider.autoDispose<List<SubscriptionPlan>>((ref) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.getPlans();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (plans) => plans,
  );
});

// ─── Islem Gecmisi ──────────────────────────────────────────────
final creditTransactionsProvider =
    FutureProvider.autoDispose<List<CreditTransaction>>((ref) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.getTransactions();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (transactions) => transactions,
  );
});

// ─── Aktif Abonelik ─────────────────────────────────────────────
final activeSubscriptionProvider =
    FutureProvider.autoDispose<ActiveSubscription?>((ref) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.getActiveSubscription();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (sub) => sub,
  );
});

// ─── Satin Alinan Vaka ID'leri ──────────────────────────────────
final purchasedCaseIdsProvider =
    FutureProvider.autoDispose<Set<String>>((ref) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.getPurchasedCaseIds();
  return result.fold(
    (failure) => <String>{},
    (ids) => ids,
  );
});

// ─── Promo Kod Dogrulama (family - packageId parametreli) ───────
final validatePromoProvider = FutureProvider.autoDispose
    .family<ValidatePromoResult, ({String code, int packageId})>(
        (ref, params) async {
  final repo = ref.watch(creditRepositoryProvider);
  final result = await repo.validatePromo(
    code: params.code,
    packageId: params.packageId,
  );
  return result.fold(
    (failure) => throw Exception(failure.message),
    (result) => result,
  );
});
