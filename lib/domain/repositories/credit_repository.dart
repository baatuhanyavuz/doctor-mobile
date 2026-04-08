import 'package:fpdart/fpdart.dart';
import '../../core/errors/failure.dart';
import '../../data/models/credit_balance.dart';
import '../../data/models/credit_package.dart';
import '../../data/models/subscription_plan.dart';
import '../../data/models/credit_transaction.dart';
import '../../data/models/purchase_result.dart';
import '../../data/models/subscribe_result.dart';
import '../../data/models/spend_result.dart';
import '../../data/models/daily_reward_result.dart';
import '../../data/models/mystery_box_result.dart';
import '../../data/models/ad_watch_result.dart';
import '../../data/models/validate_promo_result.dart';
import '../../data/models/active_subscription.dart';

/// Kredi sistemi repository arayuzu
///
/// Domain katmani sadece bu arayuzu bilir.
/// Tum kredi islemleri bu interface uzerinden yapilir.
abstract class ICreditRepository {
  /// Kullanicinin kredi bakiyesini getir
  Future<Either<Failure, CreditBalance>> getBalance();

  /// Satin alinabilir kredi paketlerini listele
  Future<Either<Failure, List<CreditPackage>>> getPackages();

  /// Abonelik planlarini listele
  Future<Either<Failure, List<SubscriptionPlan>>> getPlans();

  /// Kredi islem gecmisini getir
  Future<Either<Failure, List<CreditTransaction>>> getTransactions({
    int page,
    int pageSize,
  });

  /// Aktif aboneligi getir
  Future<Either<Failure, ActiveSubscription?>> getActiveSubscription();

  /// Kredi paketi satin al (mock)
  Future<Either<Failure, PurchaseResult>> purchasePackage({
    required int packageId,
    String? promoCode,
  });

  /// Abonelik baslat (mock)
  Future<Either<Failure, SubscribeResult>> subscribe({
    required int planId,
    String? promoCode,
  });

  /// Vaka satin al (kredi harca)
  Future<Either<Failure, SpendResult>> purchaseCase({
    required String caseId,
    String? promoCode,
  });

  /// Ipucu satin al (kredi harca)
  Future<Either<Failure, SpendResult>> purchaseHint({
    required String caseId,
    required String hintType,
  });

  /// Reklam izle - kredi kazan
  Future<Either<Failure, AdWatchResult>> watchAd();

  /// Gunluk giris odulu al
  Future<Either<Failure, DailyRewardResult>> claimDailyReward();

  /// Gizemli kutu ac
  Future<Either<Failure, MysteryBoxResult>> openMysteryBox();

  /// Magaza degerlendirme odulu
  Future<Either<Failure, CreditBalance>> claimStoreReview();

  /// Sosyal paylasim odulu
  Future<Either<Failure, CreditBalance>> claimSocialShare({String? caseId});

  /// Promo kodu dogrula
  Future<Either<Failure, ValidatePromoResult>> validatePromo({
    required String code,
    required int packageId,
  });

  /// Referans kodu uygula
  Future<Either<Failure, CreditBalance>> applyReferral({
    required String referralCode,
  });

  /// Kullanicinin satin aldigi vaka ID'lerini getir
  Future<Either<Failure, Set<String>>> getPurchasedCaseIds();
}
