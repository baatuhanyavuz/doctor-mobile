import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/auth_providers.dart';
import '../../providers/auth_state.dart';
import '../../providers/credit_providers.dart';
import '../../providers/notification_providers.dart';
import '../../providers/achievement_provider.dart';
import '../../../core/services/notification_service.dart';
import '../../../domain/entities/user.dart';

/// Doktor temali Profil Ekrani
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);
  static const _crimson = Color(0xFF00BFA5);
  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: Text(
          'profile.title'.tr(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white54, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: authState.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(color: _crimson),
        ),
        authenticated: (user) => _ProfileBody(user: user),
        unauthenticated: () => const SizedBox.shrink(),
        error: (msg) => Center(
          child: Text(msg, style: const TextStyle(color: _crimson)),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// PROFİL BODY
// ═══════════════════════════════════════════════════════════════════

class _ProfileBody extends ConsumerWidget {
  final User user;
  const _ProfileBody({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: ProfileScreen._crimson,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          _AvatarSection(user: user),
          const SizedBox(height: 32),
          _StatsRow(user: user),
          const SizedBox(height: 24),

          // ─── Başarım Rozetleri ───────────────────────────
          const _AchievementShowcase(),
          const SizedBox(height: 24),

          _InfoCard(user: user),
          const SizedBox(height: 24),

          // ─── Referans Kodu ─────────────────────────────────
          const _ReferralCodeCard(),
          const SizedBox(height: 24),

          // ─── Hesap Yönetimi ───────────────────────────────
          _AccountActionsCard(user: user, isLoading: isLoading),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// AVATAR SECTION
// ═══════════════════════════════════════════════════════════════════

class _AvatarSection extends StatelessWidget {
  final User user;
  const _AvatarSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                ProfileScreen._surfaceColor,
                ProfileScreen._bgColor,
              ],
            ),
            border: Border.all(
              color: ProfileScreen._gold.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: ProfileScreen._gold.withValues(alpha: 0.12),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.local_hospital,
                size: 52,
                color: ProfileScreen._crimson.withValues(alpha: 0.15),
              ),
              Icon(
                Icons.medical_services_outlined,
                size: 44,
                color: ProfileScreen._gold.withValues(alpha: 0.8),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.fullName.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.9),
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: ProfileScreen._gold.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(4),
            color: ProfileScreen._gold.withValues(alpha: 0.06),
          ),
          child: Text(
            _getRankTitle(user.level),
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              color: ProfileScreen._gold,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }

  String _getRankTitle(int level) {
    if (level >= 10) return 'profile.ranks.professor'.tr();
    if (level >= 7) return 'profile.ranks.docent'.tr();
    if (level >= 4) return 'profile.ranks.specialist'.tr();
    if (level >= 2) return 'profile.ranks.assistant'.tr();
    return 'profile.ranks.intern'.tr();
  }
}

// ═══════════════════════════════════════════════════════════════════
// STATS ROW
// ═══════════════════════════════════════════════════════════════════

class _StatsRow extends StatelessWidget {
  final User user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.military_tech_outlined,
            iconColor: ProfileScreen._gold,
            label: 'profile.level'.tr(),
            value: '${user.level}',
            borderColor: ProfileScreen._gold,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            icon: Icons.auto_awesome_outlined,
            iconColor: ProfileScreen._teal,
            label: 'profile.total_xp'.tr(),
            value: '${user.totalXp}',
            borderColor: ProfileScreen._teal,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color borderColor;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: ProfileScreen._surfaceColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.robotoMono(
              fontSize: 10,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// INFO CARD
// ═══════════════════════════════════════════════════════════════════

class _InfoCard extends StatelessWidget {
  final User user;
  const _InfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ProfileScreen._surfaceColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.badge_outlined,
                color: ProfileScreen._crimson.withValues(alpha: 0.7),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'profile.personnel_file'.tr(),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: ProfileScreen._crimson.withValues(alpha: 0.7),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 8),
          _InfoRow(label: 'profile.name'.tr(), value: user.fullName),
          const SizedBox(height: 12),
          _InfoRow(label: 'profile.email'.tr(), value: user.email),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'profile.badge_no'.tr(),
            value: user.id.substring(0, 8).toUpperCase(),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              color: Colors.white30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text('  :  ', style: TextStyle(color: Colors.white24, fontSize: 11)),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// REFERANS KODU KARTI
// ═══════════════════════════════════════════════════════════════════

class _ReferralCodeCard extends ConsumerStatefulWidget {
  const _ReferralCodeCard();

  @override
  ConsumerState<_ReferralCodeCard> createState() => _ReferralCodeCardState();
}

class _ReferralCodeCardState extends ConsumerState<_ReferralCodeCard> {
  final _controller = TextEditingController();
  bool _isLoading = false;
  bool _applied = false;
  String? _message;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _applyCode() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _message = null;
    });

    final success = await ref.read(creditNotifierProvider.notifier).applyReferral(code);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (success) {
        _applied = true;
        _message = 'Referans kodu başarıyla uygulandı! Kredi kazandınız.';
      } else {
        _message = 'Geçersiz veya daha önce kullanılmış referans kodu.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ProfileScreen._surfaceColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _applied
              ? ProfileScreen._teal.withValues(alpha: 0.3)
              : ProfileScreen._gold.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _applied ? Icons.check_circle_outline : Icons.card_giftcard_rounded,
                color: _applied ? ProfileScreen._teal : ProfileScreen._gold,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'profile.referral_title'.tr(),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: _applied
                      ? ProfileScreen._teal.withValues(alpha: 0.7)
                      : ProfileScreen._gold.withValues(alpha: 0.7),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Colors.white.withValues(alpha: 0.06)),
          const SizedBox(height: 8),

          if (_applied)
            Row(
              children: [
                Icon(Icons.check_circle, color: ProfileScreen._teal, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _message ?? 'profile.referral_applied'.tr(),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ProfileScreen._teal,
                    ),
                  ),
                ),
              ],
            )
          else ...[
            Text(
              'profile.referral_description'.tr(),
              style: GoogleFonts.inter(
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
                    controller: _controller,
                    enabled: !_isLoading,
                    style: GoogleFonts.robotoMono(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'profile.referral_hint'.tr(),
                      hintStyle: GoogleFonts.robotoMono(
                        color: Colors.white24,
                        fontSize: 12,
                      ),
                      filled: true,
                      fillColor: ProfileScreen._bgColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: ProfileScreen._gold.withValues(alpha: 0.2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: ProfileScreen._gold.withValues(alpha: 0.2),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: ProfileScreen._gold.withValues(alpha: 0.6),
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _applyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ProfileScreen._gold.withValues(alpha: 0.15),
                      foregroundColor: ProfileScreen._gold,
                      side: BorderSide(
                        color: ProfileScreen._gold.withValues(alpha: 0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ProfileScreen._gold,
                            ),
                          )
                        : Text(
                            'common.apply'.tr(),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            if (_message != null && !_applied) ...[
              const SizedBox(height: 8),
              Text(
                _message!,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: ProfileScreen._crimson,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// HESAP YÖNETİMİ KARTI
// ═══════════════════════════════════════════════════════════════════

class _AccountActionsCard extends ConsumerWidget {
  final User user;
  final bool isLoading;

  const _AccountActionsCard({required this.user, required this.isLoading});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ProfileScreen._surfaceColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.white38,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'profile.account_management'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white38,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white.withValues(alpha: 0.06)),

          // Profili Düzenle
          _ActionTile(
            icon: Icons.edit_outlined,
            iconColor: ProfileScreen._teal,
            label: 'profile.edit_profile'.tr(),
            onTap: isLoading ? null : () => _showEditProfileDialog(context, ref, user),
          ),

          // Şifre Değiştir
          _ActionTile(
            icon: Icons.lock_outline,
            iconColor: ProfileScreen._gold,
            label: 'profile.change_password'.tr(),
            onTap: isLoading ? null : () => _showChangePasswordDialog(context, ref),
          ),

          // Bildirim Ayarları
          if (!kIsWeb) const _NotificationToggleTile(),

          // Gizlilik Politikası
          _ActionTile(
            icon: Icons.privacy_tip_outlined,
            iconColor: Colors.white54,
            label: 'profile.privacy_policy'.tr(),
            onTap: () async {
              try {
                await launchUrl(Uri.parse(AppConstants.privacyPolicyUrl),
                    mode: LaunchMode.externalApplication);
              } catch (_) {}
            },
          ),

          // Kullanım Koşulları
          _ActionTile(
            icon: Icons.description_outlined,
            iconColor: Colors.white54,
            label: 'profile.terms_of_service'.tr(),
            onTap: () async {
              try {
                await launchUrl(Uri.parse(AppConstants.termsOfServiceUrl),
                    mode: LaunchMode.externalApplication);
              } catch (_) {}
            },
          ),

          // Dil Değiştir
          _ActionTile(
            icon: Icons.language_rounded,
            iconColor: ProfileScreen._teal,
            label: 'profile.language'.tr(),
            trailing: Text(
              context.locale.languageCode == 'tr'
                  ? '🇹🇷 Türkçe'
                  : '🇬🇧 English',
              style: GoogleFonts.robotoMono(
                fontSize: 12,
                color: Colors.white38,
              ),
            ),
            onTap: () => _showLanguageDialog(context),
          ),

          Divider(color: Colors.white.withValues(alpha: 0.06), indent: 20, endIndent: 20),

          // Çıkış Yap
          _ActionTile(
            icon: Icons.logout_rounded,
            iconColor: ProfileScreen._crimson,
            label: 'profile.logout'.tr(),
            onTap: isLoading ? null : () => ref.read(authNotifierProvider.notifier).logout(),
          ),

          // Hesabı Sil
          _ActionTile(
            icon: Icons.delete_forever_outlined,
            iconColor: Colors.red.shade400,
            label: 'profile.delete_account'.tr(),
            isDestructive: true,
            onTap: isLoading ? null : () => _showDeleteAccountDialog(context, ref),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// BİLDİRİM TOGGLE
// ═══════════════════════════════════════════════════════════════════

class _NotificationToggleTile extends ConsumerWidget {
  const _NotificationToggleTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionAsync = ref.watch(notificationPermissionProvider);

    return permissionAsync.when(
      data: (isEnabled) => InkWell(
        onTap: () async {
          if (!isEnabled) {
            // İzin yoksa — izin iste
            final granted = await ref
                .read(notificationServiceProvider)
                .requestPermission();
            ref.invalidate(notificationPermissionProvider);

            if (!granted && context.mounted) {
              // Sistem izni reddedildiyse ayarlara yönlendir
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: const Color(0xFF132038),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: ProfileScreen._gold.withValues(alpha: 0.2),
                    ),
                  ),
                  title: Text(
                    'profile.notifications_disabled_title'.tr(),
                    style: GoogleFonts.poppins(
                      color: ProfileScreen._gold,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),
                  content: Text(
                    'profile.notifications_disabled_body'.tr(),
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                        'common.cancel'.tr(),
                        style: const TextStyle(color: Colors.white38),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        _openNotificationSettings();
                      },
                      child: Text(
                        'profile.open_settings'.tr(),
                        style: TextStyle(color: ProfileScreen._gold),
                      ),
                    ),
                  ],
                ),
              );
            }
          } else {
            // İzin varsa — ayarlara yönlendir (kapatmak için)
            _openNotificationSettings();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Icon(
                isEnabled
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_off_outlined,
                color: isEnabled ? ProfileScreen._teal : Colors.white38,
                size: 20,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'profile.notifications'.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isEnabled
                      ? ProfileScreen._teal.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isEnabled
                        ? ProfileScreen._teal.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  isEnabled
                      ? 'profile.notifications_on'.tr()
                      : 'profile.notifications_off'.tr(),
                  style: GoogleFonts.robotoMono(
                    fontSize: 11,
                    color: isEnabled ? ProfileScreen._teal : Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
            ],
          ),
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _openNotificationSettings() async {
    try {
      if (Platform.isAndroid) {
        // Android: uygulama bildirim ayarları
        final launched = await launchUrl(
          Uri.parse('package:com.doktor.doktor'),
          mode: LaunchMode.externalApplication,
        );
        if (!launched) {
          await launchUrl(Uri.parse('app-settings:'));
        }
      } else {
        // iOS: uygulama ayarları
        await launchUrl(Uri.parse('app-settings:'));
      }
    } catch (_) {
      // Fallback — hiçbir şey yapma
    }
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;
  final Widget? trailing;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
    this.isDestructive = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDestructive
                      ? Colors.red.shade400
                      : Colors.white70,
                ),
              ),
            ),
            if (trailing != null) ...[
              trailing!,
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.chevron_right,
              color: Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// DIALOGLAR
// ═══════════════════════════════════════════════════════════════════

void _showLanguageDialog(BuildContext context) {
  final currentLocale = context.locale;

  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: const Color(0xFF132038),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: const Color(0xFFFFD54F).withValues(alpha: 0.2)),
      ),
      title: Text(
        'profile.language_title'.tr(),
        style: GoogleFonts.poppins(
          color: const Color(0xFFFFD54F),
          fontSize: 18,
          letterSpacing: 2,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOption(
            flag: '🇹🇷',
            label: 'profile.language_tr'.tr(),
            isSelected: currentLocale.languageCode == 'tr',
            onTap: () {
              context.setLocale(const Locale('tr'));
              Navigator.of(dialogContext).pop();
            },
          ),
          const SizedBox(height: 8),
          _LanguageOption(
            flag: '🇬🇧',
            label: 'profile.language_en'.tr(),
            isSelected: currentLocale.languageCode == 'en',
            onTap: () {
              context.setLocale(const Locale('en'));
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    ),
  );
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF42A5F5).withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF42A5F5).withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: isSelected ? const Color(0xFF42A5F5) : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF42A5F5),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

void _showEditProfileDialog(BuildContext context, WidgetRef ref, User user) {
  final nameController = TextEditingController(text: user.fullName);
  final emailController = TextEditingController(text: user.email);
  final formKey = GlobalKey<FormState>();
  var isSaving = false;

  showDialog(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          'profile.edit_profile_title'.tr(),
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.9),
            letterSpacing: 2,
            fontSize: 18,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogTextField(
                controller: nameController,
                label: 'profile.name'.tr(),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'profile.name_required'.tr() : null,
              ),
              const SizedBox(height: 16),
              _dialogTextField(
                controller: emailController,
                label: 'profile.email'.tr(),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'profile.email_required'.tr();
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim())) {
                    return 'profile.email_invalid'.tr();
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: isSaving ? null : () => Navigator.of(dialogContext).pop(),
            child: Text('common.cancel'.tr(), style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: isSaving
                ? null
                : () async {
                    if (!formKey.currentState!.validate()) return;
                    setState(() => isSaving = true);
                    final success =
                        await ref.read(authNotifierProvider.notifier).updateProfile(
                              fullName: nameController.text.trim(),
                              email: emailController.text.trim(),
                            );
                    if (!dialogContext.mounted) return;
                    if (success) {
                      // Messenger ref'i pop ÖNCESINDE al — pop sonrası context geçersiz olabilir
                      final messenger = ScaffoldMessenger.of(context);
                      Navigator.of(dialogContext).pop();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('profile.profile_updated'.tr()),
                          backgroundColor: Color(0xFF42A5F5),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      setState(() => isSaving = false);
                    }
                  },
            child: isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF42A5F5),
                    ),
                  )
                : Text(
                    'common.save'.tr(),
                    style: TextStyle(color: const Color(0xFF42A5F5)),
                  ),
          ),
        ],
      ),
    ),
  );
}

void _showChangePasswordDialog(BuildContext context, WidgetRef ref) {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isSaving = false;
  var obscureCurrent = true;
  var obscureNew = true;

  showDialog(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          'profile.change_password_title'.tr(),
          style: GoogleFonts.poppins(
            color: Colors.white.withValues(alpha: 0.9),
            letterSpacing: 2,
            fontSize: 18,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogTextField(
                controller: currentPasswordController,
                label: 'profile.current_password'.tr(),
                obscureText: obscureCurrent,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureCurrent ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white38,
                    size: 18,
                  ),
                  onPressed: () => setState(() => obscureCurrent = !obscureCurrent),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'profile.current_password_required'.tr() : null,
              ),
              const SizedBox(height: 16),
              _dialogTextField(
                controller: newPasswordController,
                label: 'profile.new_password'.tr(),
                obscureText: obscureNew,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureNew ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white38,
                    size: 18,
                  ),
                  onPressed: () => setState(() => obscureNew = !obscureNew),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'profile.new_password_required'.tr();
                  if (v.length < 8) return 'profile.new_password_min'.tr();
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _dialogTextField(
                controller: confirmPasswordController,
                label: 'profile.new_password_confirm'.tr(),
                obscureText: true,
                validator: (v) {
                  if (v != newPasswordController.text) {
                    return 'profile.password_mismatch'.tr();
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: isSaving ? null : () => Navigator.of(dialogContext).pop(),
            child: Text('common.cancel'.tr(), style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: isSaving
                ? null
                : () async {
                    if (!formKey.currentState!.validate()) return;
                    setState(() => isSaving = true);
                    final success =
                        await ref.read(authNotifierProvider.notifier).changePassword(
                              currentPassword: currentPasswordController.text,
                              newPassword: newPasswordController.text,
                            );
                    if (!dialogContext.mounted) return;
                    if (success) {
                      final messenger = ScaffoldMessenger.of(context);
                      Navigator.of(dialogContext).pop();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('profile.password_changed'.tr()),
                          backgroundColor: Color(0xFF42A5F5),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      setState(() => isSaving = false);
                    }
                  },
            child: isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFFFFD54F),
                    ),
                  )
                : Text(
                    'profile.change_btn'.tr(),
                    style: TextStyle(color: const Color(0xFFFFD54F)),
                  ),
          ),
        ],
      ),
    ),
  );
}

void _showDeleteAccountDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      var isDeleting = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF132038),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                'profile.delete_account_title'.tr(),
                style: GoogleFonts.poppins(
                  color: Colors.red.shade400,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            'profile.delete_account_warning'.tr(),
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          actions: [
            TextButton(
              onPressed: isDeleting ? null : () => Navigator.of(dialogContext).pop(),
              child: Text(
                'profile.give_up'.tr(),
                style: TextStyle(color: Colors.white38),
              ),
            ),
            TextButton(
              onPressed: isDeleting
                  ? null
                  : () async {
                      setState(() => isDeleting = true);
                      // Önce notifier referansını al — dialog kapandıktan sonra ref geçersiz olabilir
                      final notifier = ref.read(authNotifierProvider.notifier);
                      // Önce dialog kapat
                      if (dialogContext.mounted) {
                        Navigator.of(dialogContext).pop();
                      }
                      // Sonra sil — notifier referansı hâlâ geçerli (Notifier widget'a bağlı değil)
                      try {
                        await notifier.deleteAccount();
                      } catch (_) {
                        // Widget dispose olmuşsa hata yutulur — auth state zaten değişecek
                      }
                    },
              child: isDeleting
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.red.shade400,
                      ),
                    )
                  : Text(
                      'profile.delete_account'.tr(),
                      style: TextStyle(color: Colors.red.shade400),
                    ),
            ),
          ],
        ),
      );
    },
  );
}

// ═══════════════════════════════════════════════════════════════════
// YARDIMCI: Dialog TextField
// ═══════════════════════════════════════════════════════════════════

Widget _dialogTextField({
  required TextEditingController controller,
  required String label,
  TextInputType? keyboardType,
  bool obscureText = false,
  Widget? suffixIcon,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
    cursorColor: const Color(0xFF00BFA5),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.robotoMono(
        color: Colors.white38,
        fontSize: 12,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF0A1628),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF1A2D4D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF1A2D4D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF00BFA5), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF00BFA5)),
      ),
      errorStyle: GoogleFonts.inter(
        color: const Color(0xFF00BFA5),
        fontSize: 11,
      ),
    ),
    validator: validator,
  );
}

// ═══════════════════════════════════════════════════════════════════
// BAŞARIM VİTRİNİ
// ═══════════════════════════════════════════════════════════════════

class _AchievementShowcase extends ConsumerWidget {
  const _AchievementShowcase();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementsAsync = ref.watch(achievementsProvider);

    return achievementsAsync.when(
      data: (achievements) {
        if (achievements.isEmpty) return const SizedBox.shrink();

        final unlocked = achievements.where((a) => a.unlocked).toList();
        final locked = achievements.where((a) => !a.unlocked).toList();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ProfileScreen._surfaceColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: ProfileScreen._gold.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.emoji_events_outlined, color: ProfileScreen._gold.withValues(alpha: 0.7), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'BAŞARIMLAR',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ProfileScreen._gold.withValues(alpha: 0.7),
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${unlocked.length}/${achievements.length}',
                    style: GoogleFonts.robotoMono(
                      fontSize: 12,
                      color: ProfileScreen._gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Divider(color: Colors.white.withValues(alpha: 0.06)),
              const SizedBox(height: 12),

              // Açılmış rozetler
              if (unlocked.isNotEmpty) ...[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: unlocked.map((a) => _AchievementBadge(
                    achievement: a,
                    isUnlocked: true,
                  )).toList(),
                ),
                if (locked.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withValues(alpha: 0.04)),
                  const SizedBox(height: 12),
                ],
              ],

              // Kilitli rozetler
              if (locked.isNotEmpty)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: locked.map((a) => _AchievementBadge(
                    achievement: a,
                    isUnlocked: false,
                  )).toList(),
                ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool isUnlocked;

  const _AchievementBadge({required this.achievement, required this.isUnlocked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetail(context),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? ProfileScreen._gold.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.03),
              border: Border.all(
                color: isUnlocked
                    ? ProfileScreen._gold.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: isUnlocked ? 2 : 1,
              ),
              boxShadow: isUnlocked
                  ? [BoxShadow(color: ProfileScreen._gold.withValues(alpha: 0.15), blurRadius: 12)]
                  : null,
            ),
            child: Center(
              child: Text(
                isUnlocked ? achievement.icon : '🔒',
                style: TextStyle(fontSize: isUnlocked ? 24 : 18),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 64,
            child: Text(
              achievement.name,
              style: GoogleFonts.robotoMono(
                fontSize: 8,
                color: isUnlocked ? Colors.white60 : Colors.white24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isUnlocked
                ? ProfileScreen._gold.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(achievement.icon, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            Text(
              achievement.name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: isUnlocked ? ProfileScreen._gold : Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              achievement.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            if (isUnlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: ProfileScreen._teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: ProfileScreen._teal.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '+${achievement.creditReward} Kredi Kazandın!',
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    color: ProfileScreen._teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Text(
                  'Ödül: ${achievement.creditReward} Kredi',
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    color: Colors.white30,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
