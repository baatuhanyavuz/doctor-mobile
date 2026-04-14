/// API ve ortam sabitleri
///
/// Canlı sunucuya geçildiğinde sadece bu dosyadaki URL'leri
/// güncellemek yeterli olacaktır.
class AppConstants {
  AppConstants._();

  // ─── API Base URL ─────────────────────────────────────────────
  static const String apiBaseUrl = 'https://api-doctor.gloombit.com';

  // ─── API Endpoints ────────────────────────────────────────────
  static const String authGoogleEndpoint = '/api/auth/google';
  static const String authAppleEndpoint = '/api/auth/apple';
  static const String authRegisterEndpoint = '/api/auth/register';
  static const String authLoginEndpoint = '/api/auth/login';
  static const String authRefreshEndpoint = '/api/auth/refresh';
  static const String authMeEndpoint = '/api/auth/me';
  static const String authProfileEndpoint = '/api/auth/profile';
  static const String authChangePasswordEndpoint = '/api/auth/change-password';
  static const String authDeleteAccountEndpoint = '/api/auth/account';

  // ─── User Cases Endpoints ─────────────────────────────────────
  static const String userCasesStartEndpoint = '/api/usercases/start';
  static const String userCasesCompleteEndpoint = '/api/usercases/complete';

  // ─── Mini Games Endpoints ───────────────────────────────────
  static const String miniGamesBaseEndpoint = '/api/minigames';
  static const String miniGameBallisticEndpoint = '/api/minigames/ballistic';
  static const String miniGameInterrogationEndpoint = '/api/minigames/interrogation';
  static const String miniGameToxicologyEndpoint = '/api/minigames/toxicology';
  static const String miniGameResultsEndpoint = '/api/minigames'; // + /{caseId}

  // ─── Dilemma & Retest Endpoints ────────────────────────────────
  static const String dilemmaChoiceEndpoint = '/api/dilemma/choice';
  static const String dilemmaChoicesEndpoint = '/api/dilemma/choices'; // + /{caseId}
  static const String dilemmaReputationEndpoint = '/api/dilemma/reputation';
  static const String retestEndpoint = '/api/dilemma/retest';

  // ─── Energy & Unlock Endpoints ─────────────────────────────────
  static const String energyEndpoint = '/api/energy';
  static const String energyConsumeEndpoint = '/api/energy/consume';
  static const String energyRefillAdEndpoint = '/api/energy/refill-with-ad';
  static const String unlockedCasesEndpoint = '/api/energy/unlocked-cases';
  static const String initializeUnlocksEndpoint = '/api/energy/initialize-unlocks';
  static const String unlockWithAdEndpoint = '/api/energy/unlock-with-ad';
  static const String unlockNextEndpoint = '/api/energy/unlock-next';

  // ─── Credits Endpoints ─────────────────────────────────────────
  static const String creditsBalanceEndpoint = '/api/credits/balance';
  static const String creditsPackagesEndpoint = '/api/credits/packages';
  static const String creditsSubscriptionPlansEndpoint = '/api/credits/subscriptions/plans';
  static const String creditsTransactionsEndpoint = '/api/credits/transactions';
  static const String creditsSubscriptionEndpoint = '/api/credits/subscription';
  static const String creditsPurchasePackageEndpoint = '/api/credits/purchase-package';
  static const String creditsSubscribeEndpoint = '/api/credits/subscribe';
  static const String creditsPurchaseCaseEndpoint = '/api/credits/purchase-case';
  static const String creditsPurchaseHintEndpoint = '/api/credits/purchase-hint';
  static const String creditsAdWatchEndpoint = '/api/credits/ad-watch';
  static const String creditsDailyLoginEndpoint = '/api/credits/daily-login';
  static const String creditsMysteryBoxEndpoint = '/api/credits/mystery-box';
  static const String creditsStoreReviewEndpoint = '/api/credits/store-review';
  static const String creditsSocialShareEndpoint = '/api/credits/social-share';
  static const String creditsValidatePromoEndpoint = '/api/credits/validate-promo';
  static const String creditsApplyReferralEndpoint = '/api/credits/apply-referral';
  static const String creditsPurchasedCasesEndpoint = '/api/credits/purchased-cases';

  // ─── Achievements Endpoints ────────────────────────────────────
  static const String achievementsEndpoint = '/api/achievements';

  // ─── Game State Endpoints ──────────────────────────────────────
  static const String gameStateSaveEndpoint = '/api/usercases/game-state';
  static const String gameStateLoadEndpoint = '/api/usercases/game-state'; // + /{caseId}

  // ─── Bundles/Campaigns Endpoints ───────────────────────────────
  static const String caseBundlesEndpoint = '/api/cases/bundles';
  static const String creditsPurchaseBundleEndpoint = '/api/credits/purchase-bundle';

  // ─── Shift (Nöbet) Endpoints ───────────────────────────────────
  static const String shiftStartEndpoint = '/api/shifts/start';
  static const String shiftStatusEndpoint = '/api/shifts/status';
  static const String shiftRespondEndpoint = '/api/shifts/respond';
  static const String shiftCompleteEndpoint = '/api/shifts/complete';
  static const String shiftCancelEndpoint = '/api/shifts/cancel';
  static const String shiftHistoryEndpoint = '/api/shifts/history';

  // ─── Notifications Endpoints ──────────────────────────────────
  static const String notificationsRegisterDeviceEndpoint = '/api/notifications/register-device';
  static const String notificationsUnregisterDeviceEndpoint = '/api/notifications/unregister-device';

  // ─── Google Sign-In ───────────────────────────────────────────
  // Android/Installed Client ID (from Google Cloud Console)
  static const String googleServerClientId = '449009688447-16mfge7mn89tibids6vmhqpi93jl9bi4.apps.googleusercontent.com';

  // ─── Secure Storage Keys ──────────────────────────────────────
  static const String jwtTokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String isNewUserKey = 'is_new_user';

  // ─── Timeouts ─────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // ─── Website Base URL ─────────────────────────────────────────
  static const String websiteBaseUrl = 'https://doctor.gloombit.com';

  // ─── Legal URLs ──────────────────────────────────────────────
  static const String privacyPolicyUrl = '$websiteBaseUrl/privacy.html';
  static const String termsOfServiceUrl = '$websiteBaseUrl/terms.html';
}
