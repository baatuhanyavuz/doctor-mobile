import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_providers.dart';
import '../../providers/credit_providers.dart';

/// İlk kez giriş yapan kullanıcılar için profil oluşturma ekranı
///
/// Ad soyad düzenleme + referans kodu girişi
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _bgColor = Color(0xFF0D0D0D);
  static const _surfaceColor = Color(0xFF1E1E1E);
  static const _gold = Color(0xFFD4A847);
  static const _teal = Color(0xFF03DAC6);
  static const _crimson = Color(0xFFCF6679);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _referralController = TextEditingController();

  bool _isSaving = false;
  bool _referralApplied = false;
  String? _referralMessage;
  bool _referralLoading = false;

  @override
  void initState() {
    super.initState();
    // Mevcut kullanıcı adını doldur
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = ref.read(authNotifierProvider);
      authState.maybeWhen(
        authenticated: (user) {
          _nameController.text = user.fullName;
        },
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _applyReferralCode() async {
    final code = _referralController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _referralLoading = true;
      _referralMessage = null;
    });

    final success =
        await ref.read(creditNotifierProvider.notifier).applyReferral(code);

    if (!mounted) return;

    setState(() {
      _referralLoading = false;
      if (success) {
        _referralApplied = true;
        _referralMessage = 'onboarding.referral_applied'.tr();
      } else {
        _referralMessage = 'onboarding.referral_invalid'.tr();
      }
    });
  }

  Future<void> _completeOnboarding() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final authNotifier = ref.read(authNotifierProvider.notifier);

    // Profil bilgilerini güncelle
    final authState = ref.read(authNotifierProvider);
    final currentEmail = authState.maybeWhen(
      authenticated: (user) => user.email,
      orElse: () => '',
    );

    final success = await authNotifier.updateProfile(
      fullName: _nameController.text.trim(),
      email: currentEmail,
    );

    if (!mounted) return;

    if (success) {
      // Onboarding tamamlandı flag'ini temizle
      await authNotifier.completeOnboarding();
      if (mounted) {
        context.go('/');
      }
    } else {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profil kaydedilemedi. Lütfen tekrar deneyin.',
            style: GoogleFonts.merriweather(color: Colors.white),
          ),
          backgroundColor: _crimson.withValues(alpha:0.9),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // ─── Logo / Icon ────────────────────────────────────
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _surfaceColor,
                    border: Border.all(
                      color: _gold.withValues(alpha:0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _gold.withValues(alpha:0.12),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 40,
                    color: _gold.withValues(alpha:0.8),
                  ),
                ),
                const SizedBox(height: 24),

                // ─── Başlık ──────────────────────────────────────────
                Text(
                  'onboarding.welcome'.tr(),
                  style: GoogleFonts.specialElite(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: _gold,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'onboarding.complete_profile'.tr(),
                  style: GoogleFonts.merriweather(
                    fontSize: 13,
                    color: Colors.white38,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // ─── Profil Bilgileri Kartı ─────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _gold.withValues(alpha:0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: _gold.withValues(alpha:0.7),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'onboarding.profile_info'.tr(),
                            style: GoogleFonts.specialElite(
                              fontSize: 14,
                              color: _gold.withValues(alpha:0.7),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(color: Colors.white.withValues(alpha:0.06)),
                      const SizedBox(height: 12),
                      Text(
                        'onboarding.name_label'.tr(),
                        style: GoogleFonts.robotoMono(
                          fontSize: 11,
                          color: Colors.white38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _nameController,
                        enabled: !_isSaving,
                        style: GoogleFonts.merriweather(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        decoration: _inputDecoration('onboarding.name_hint'.tr()),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'onboarding.name_required'.tr()
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ─── Referans Kodu Kartı ──────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _referralApplied
                          ? _teal.withValues(alpha:0.3)
                          : Colors.white.withValues(alpha:0.06),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _referralApplied
                                ? Icons.check_circle_outline
                                : Icons.card_giftcard_rounded,
                            color: _referralApplied ? _teal : _gold,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'onboarding.referral_title'.tr(),
                            style: GoogleFonts.specialElite(
                              fontSize: 14,
                              color: _referralApplied
                                  ? _teal.withValues(alpha:0.7)
                                  : _gold.withValues(alpha:0.7),
                              letterSpacing: 2,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha:0.05),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'onboarding.referral_optional'.tr(),
                              style: GoogleFonts.robotoMono(
                                fontSize: 9,
                                color: Colors.white24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(color: Colors.white.withValues(alpha:0.06)),
                      const SizedBox(height: 8),
                      if (_referralApplied)
                        Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: _teal, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _referralMessage ?? 'onboarding.referral_applied'.tr(),
                                style: GoogleFonts.merriweather(
                                  fontSize: 12,
                                  color: _teal,
                                ),
                              ),
                            ),
                          ],
                        )
                      else ...[
                        Text(
                          'onboarding.referral_description'.tr(),
                          style: GoogleFonts.merriweather(
                            fontSize: 11,
                            color: Colors.white38,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _referralController,
                                enabled: !_referralLoading && !_isSaving,
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  letterSpacing: 2,
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: _inputDecoration('onboarding.referral_hint'.tr()),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: (_referralLoading || _isSaving)
                                    ? null
                                    : _applyReferralCode,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _gold.withValues(alpha:0.15),
                                  foregroundColor: _gold,
                                  side: BorderSide(
                                    color: _gold.withValues(alpha:0.4),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(6),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                                child: _referralLoading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: _gold,
                                        ),
                                      )
                                    : Text(
                                        'common.apply'.tr(),
                                        style:
                                            GoogleFonts.specialElite(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        if (_referralMessage != null &&
                            !_referralApplied) ...[
                          const SizedBox(height: 8),
                          Text(
                            _referralMessage!,
                            style: GoogleFonts.merriweather(
                              fontSize: 11,
                              color: _crimson,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // ─── Tamamla Butonu ──────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _completeOnboarding,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _gold.withValues(alpha:0.15),
                      foregroundColor: _gold,
                      side: BorderSide(color: _gold.withValues(alpha:0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: _gold,
                            ),
                          )
                        : Text(
                            'onboarding.start_investigation'.tr(),
                            style: GoogleFonts.specialElite(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // ─── Atla Linki ──────────────────────────────────────
                TextButton(
                  onPressed: _isSaving
                      ? null
                      : () async {
                          final authNotifier =
                              ref.read(authNotifierProvider.notifier);
                          await authNotifier.completeOnboarding();
                          if (mounted) context.go('/');
                        },
                  child: Text(
                    'onboarding.skip_for_now'.tr(),
                    style: GoogleFonts.merriweather(
                      fontSize: 12,
                      color: Colors.white24,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white24,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.robotoMono(color: Colors.white24, fontSize: 12),
      filled: true,
      fillColor: _bgColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: _gold.withValues(alpha:0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: _gold.withValues(alpha:0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: _gold.withValues(alpha:0.6)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: _crimson),
      ),
      errorStyle: GoogleFonts.merriweather(color: _crimson, fontSize: 11),
      isDense: true,
    );
  }
}
