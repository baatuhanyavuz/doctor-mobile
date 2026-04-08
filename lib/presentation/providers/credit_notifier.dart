import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/credit_repository.dart';
import 'credit_state.dart';
import 'credit_providers.dart';

/// Kredi durumunu yoneten Notifier
///
/// Bakiye yukleme, satin alma, odul toplama islemlerini yonetir.
/// Her basarili islemden sonra bakiyeyi otomatik gunceller.
class CreditNotifier extends AutoDisposeNotifier<CreditState> {
  @override
  CreditState build() {
    _loadBalance();
    return const CreditState.loading();
  }

  ICreditRepository get _repo => ref.read(creditRepositoryProvider);

  /// Bakiyeyi yukle
  Future<void> _loadBalance() async {
    final result = await _repo.getBalance();
    result.fold(
      (failure) {
        debugPrint('[CreditNotifier] Bakiye hatasi: ${failure.message}');
        state = CreditState.error(failure.message);
      },
      (balance) {
        state = CreditState.loaded(balance);
      },
    );
  }

  /// Bakiyeyi yenile (pull-to-refresh, islem sonrasi vb.)
  Future<void> refresh() async {
    await _loadBalance();
  }

  /// Kredi paketi satin al
  Future<bool> purchasePackage({
    required int packageId,
    String? promoCode,
  }) async {
    final result = await _repo.purchasePackage(
      packageId: packageId,
      promoCode: promoCode,
    );
    return result.fold(
      (failure) {
        debugPrint('[CreditNotifier] Paket satin alma hatasi: ${failure.message}');
        return false;
      },
      (purchaseResult) {
        // Bakiyeyi guncelle
        state.maybeWhen(
          loaded: (balance) {
            state = CreditState.loaded(
              balance.copyWith(balance: purchaseResult.newBalance),
            );
          },
          orElse: () => _loadBalance(),
        );
        return true;
      },
    );
  }

  /// Abonelik baslat
  Future<bool> subscribe({
    required int planId,
    String? promoCode,
  }) async {
    final result = await _repo.subscribe(
      planId: planId,
      promoCode: promoCode,
    );
    return result.fold(
      (failure) {
        debugPrint('[CreditNotifier] Abonelik hatasi: ${failure.message}');
        return false;
      },
      (subscribeResult) {
        state.maybeWhen(
          loaded: (balance) {
            state = CreditState.loaded(
              balance.copyWith(
                balance: subscribeResult.newBalance,
                hasActiveSubscription: true,
                subscriptionPlanName: subscribeResult.planName,
              ),
            );
          },
          orElse: () => _loadBalance(),
        );
        return true;
      },
    );
  }

  /// Vaka satin al - basarili ise null, hata varsa hata mesaji doner
  Future<String?> purchaseCase({
    required String caseId,
    String? promoCode,
  }) async {
    final result = await _repo.purchaseCase(
      caseId: caseId,
      promoCode: promoCode,
    );
    return result.fold(
      (failure) {
        debugPrint('[CreditNotifier] Vaka satin alma hatasi: ${failure.message}');
        return failure.message;
      },
      (spendResult) {
        _updateBalance(spendResult.newBalance);
        return null;
      },
    );
  }

  /// Ipucu satin al
  Future<bool> purchaseHint({
    required String caseId,
    required String hintType,
  }) async {
    final result = await _repo.purchaseHint(
      caseId: caseId,
      hintType: hintType,
    );
    return result.fold(
      (failure) {
        debugPrint('[CreditNotifier] Ipucu satin alma hatasi: ${failure.message}');
        return false;
      },
      (spendResult) {
        _updateBalance(spendResult.newBalance);
        return true;
      },
    );
  }

  /// Reklam izle
  Future<bool> watchAd() async {
    final result = await _repo.watchAd();
    return result.fold(
      (failure) => false,
      (adResult) {
        _updateBalance(adResult.newBalance);
        return true;
      },
    );
  }

  /// Gunluk odul al
  Future<bool> claimDailyReward() async {
    final result = await _repo.claimDailyReward();
    return result.fold(
      (failure) => false,
      (reward) {
        _updateBalance(reward.newBalance);
        return true;
      },
    );
  }

  /// Gizemli kutu ac
  Future<bool> openMysteryBox() async {
    final result = await _repo.openMysteryBox();
    return result.fold(
      (failure) => false,
      (box) {
        _updateBalance(box.newBalance);
        return true;
      },
    );
  }

  /// Magaza degerlendirme
  Future<bool> claimStoreReview() async {
    final result = await _repo.claimStoreReview();
    return result.fold(
      (failure) => false,
      (balance) {
        state = CreditState.loaded(balance);
        return true;
      },
    );
  }

  /// Sosyal paylasim
  Future<bool> claimSocialShare([String? caseId]) async {
    final result = await _repo.claimSocialShare(caseId: caseId);
    return result.fold(
      (failure) => false,
      (balance) {
        state = CreditState.loaded(balance);
        return true;
      },
    );
  }

  /// Referans kodu uygula
  Future<bool> applyReferral(String referralCode) async {
    final result = await _repo.applyReferral(referralCode: referralCode);
    return result.fold(
      (failure) => false,
      (balance) {
        state = CreditState.loaded(balance);
        return true;
      },
    );
  }

  void _updateBalance(int newBalance) {
    state.maybeWhen(
      loaded: (balance) {
        state = CreditState.loaded(
          balance.copyWith(balance: newBalance),
        );
      },
      orElse: () => _loadBalance(),
    );
  }
}
