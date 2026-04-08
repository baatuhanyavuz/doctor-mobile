import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/failure.dart';
import '../../domain/repositories/credit_repository.dart';
import '../models/credit_balance.dart';
import '../models/credit_package.dart';
import '../models/subscription_plan.dart';
import '../models/credit_transaction.dart';
import '../models/purchase_result.dart';
import '../models/subscribe_result.dart';
import '../models/spend_result.dart';
import '../models/daily_reward_result.dart';
import '../models/mystery_box_result.dart';
import '../models/ad_watch_result.dart';
import '../models/validate_promo_result.dart';
import '../models/active_subscription.dart';

/// Kredi sistemi repository implementasyonu
///
/// Backend API ile Dio uzerinden iletisim kurar.
/// Tum hatalar Either<Failure, T> ile sarmalanir.
class CreditRepositoryImpl implements ICreditRepository {
  final Dio _dio;

  CreditRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, CreditBalance>> getBalance() async {
    try {
      final response = await _dio.get(AppConstants.creditsBalanceEndpoint);
      return Right(CreditBalance.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<CreditPackage>>> getPackages() async {
    try {
      final response = await _dio.get(AppConstants.creditsPackagesEndpoint);
      final List<dynamic> data = response.data;
      return Right(data.map((j) => CreditPackage.fromJson(j)).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionPlan>>> getPlans() async {
    try {
      final response =
          await _dio.get(AppConstants.creditsSubscriptionPlansEndpoint);
      final List<dynamic> data = response.data;
      return Right(data.map((j) => SubscriptionPlan.fromJson(j)).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<CreditTransaction>>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        AppConstants.creditsTransactionsEndpoint,
        queryParameters: {'page': page, 'pageSize': pageSize},
      );
      final List<dynamic> data = response.data;
      return Right(data.map((j) => CreditTransaction.fromJson(j)).toList());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, ActiveSubscription?>> getActiveSubscription() async {
    try {
      final response =
          await _dio.get(AppConstants.creditsSubscriptionEndpoint);
      if (response.data == null || response.statusCode == 204) {
        return const Right(null);
      }
      return Right(ActiveSubscription.fromJson(response.data));
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return const Right(null);
      }
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, PurchaseResult>> purchasePackage({
    required int packageId,
    String? promoCode,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsPurchasePackageEndpoint,
        data: {
          'packageId': packageId,
          if (promoCode != null) 'promoCode': promoCode,
        },
      );
      return Right(PurchaseResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, SubscribeResult>> subscribe({
    required int planId,
    String? promoCode,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsSubscribeEndpoint,
        data: {
          'planId': planId,
          if (promoCode != null) 'promoCode': promoCode,
        },
      );
      return Right(SubscribeResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, SpendResult>> purchaseCase({
    required String caseId,
    String? promoCode,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsPurchaseCaseEndpoint,
        data: {
          'caseId': caseId,
          if (promoCode != null) 'promoCode': promoCode,
        },
      );
      return Right(SpendResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, SpendResult>> purchaseHint({
    required String caseId,
    required String hintType,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsPurchaseHintEndpoint,
        data: {
          'caseId': caseId,
          'hintType': hintType,
        },
      );
      return Right(SpendResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, AdWatchResult>> watchAd() async {
    try {
      final response =
          await _dio.post(AppConstants.creditsAdWatchEndpoint);
      return Right(AdWatchResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, DailyRewardResult>> claimDailyReward() async {
    try {
      final response =
          await _dio.post(AppConstants.creditsDailyLoginEndpoint);
      return Right(DailyRewardResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, MysteryBoxResult>> openMysteryBox() async {
    try {
      final response =
          await _dio.post(AppConstants.creditsMysteryBoxEndpoint);
      return Right(MysteryBoxResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, CreditBalance>> claimStoreReview() async {
    try {
      final response =
          await _dio.post(AppConstants.creditsStoreReviewEndpoint);
      return Right(CreditBalance.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, CreditBalance>> claimSocialShare({String? caseId}) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsSocialShareEndpoint,
        queryParameters: caseId != null ? {'caseId': caseId} : null,
      );
      return Right(CreditBalance.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, ValidatePromoResult>> validatePromo({
    required String code,
    required int packageId,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsValidatePromoEndpoint,
        data: {'code': code, 'packageId': packageId},
      );
      return Right(ValidatePromoResult.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, CreditBalance>> applyReferral({
    required String referralCode,
  }) async {
    try {
      final response = await _dio.post(
        AppConstants.creditsApplyReferralEndpoint,
        data: {'referralCode': referralCode},
      );
      return Right(CreditBalance.fromJson(response.data));
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, Set<String>>> getPurchasedCaseIds() async {
    try {
      final response =
          await _dio.get(AppConstants.creditsPurchasedCasesEndpoint);
      final List<dynamic> data = response.data;
      return Right(data.map((e) => e.toString()).toSet());
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  /// Dio hatalarini Failure tipine donusturur
  Failure _handleError(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return NetworkFailure(
              'Baglanti zaman asimina ugradi. Lutfen tekrar deneyin.');
        case DioExceptionType.connectionError:
          return NetworkFailure();
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          final message = e.response?.data is Map
              ? (e.response?.data['message'] ?? e.response?.data['title'])
              : null;
          if (statusCode == 401) return AuthFailure();
          if (statusCode == 400) {
            return ServerFailure(
              message?.toString() ?? 'Gecersiz istek.',
              statusCode: 400,
            );
          }
          if (statusCode == 409) {
            return ServerFailure(
              message?.toString() ?? 'Bu islem zaten yapilmis.',
              statusCode: 409,
            );
          }
          return ServerFailure(
            message?.toString() ?? 'Sunucu hatasi ($statusCode)',
            statusCode: statusCode,
          );
        case DioExceptionType.cancel:
          return const ServerFailure('Istek iptal edildi.');
        default:
          return ServerFailure(e.message ?? 'Beklenmeyen ag hatasi.');
      }
    }
    return UnknownFailure();
  }
}
