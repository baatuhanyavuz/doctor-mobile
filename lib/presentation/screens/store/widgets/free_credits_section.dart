import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/credit_providers.dart';
import 'package:easy_localization/easy_localization.dart';

/// Ucretsiz kredi kazanma yollarini gosteren section
class FreeCreditsSection extends ConsumerStatefulWidget {
  const FreeCreditsSection({super.key});

  @override
  ConsumerState<FreeCreditsSection> createState() => _FreeCreditsSectionState();
}

class _FreeCreditsSectionState extends ConsumerState<FreeCreditsSection> {
  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _cardColor = Color(0xFF132038);

  String? _loadingAction;

  Future<void> _doAction(String actionKey, Future<bool> Function() action) async {
    setState(() => _loadingAction = actionKey);
    try {
      final notifier = ref.read(creditNotifierProvider.notifier);
      final success = await action();
      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('store.credit_earned'.tr(),
                style: GoogleFonts.inter(color: Colors.white)),
            backgroundColor: _teal.withOpacity(0.9),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (mounted && !success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('store.reward_unavailable'.tr(),
                style: GoogleFonts.inter(color: Colors.white)),
            backgroundColor: Colors.red.withOpacity(0.7),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingAction = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(creditNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ÜCRETSİZ KREDİ',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _teal,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Her gün kredi kazanmanın yollarını keşfet!',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.white38,
          ),
        ),
        const SizedBox(height: 16),

        _FreeCreditTile(
          icon: Icons.calendar_today_rounded,
          title: 'store.daily_login_title'.tr(),
          subtitle: 'store.daily_login_desc'.tr(),
          reward: '10-100 Kredi',
          color: _gold,
          isLoading: _loadingAction == 'daily',
          onTap: () => _doAction('daily', () => notifier.claimDailyReward()),
        ),

        _FreeCreditTile(
          icon: Icons.play_circle_outline_rounded,
          title: 'store.ad_watch_title'.tr(),
          subtitle: 'store.ad_watch_desc'.tr(),
          reward: '3 Kredi',
          color: Colors.orangeAccent,
          isLoading: _loadingAction == 'ad',
          onTap: () => _doAction('ad', () => notifier.watchAd()),
        ),

        _FreeCreditTile(
          icon: Icons.card_giftcard_rounded,
          title: 'store.mystery_box_title'.tr(),
          subtitle: 'store.mystery_box_desc'.tr(),
          reward: '5-200 Kredi',
          color: Colors.purpleAccent,
          isLoading: _loadingAction == 'mystery',
          onTap: () => _doAction('mystery', () => notifier.openMysteryBox()),
        ),

        _FreeCreditTile(
          icon: Icons.star_border_rounded,
          title: 'store.store_review_title'.tr(),
          subtitle: 'store.store_review_desc'.tr(),
          reward: '100 Kredi',
          color: Colors.amberAccent,
          isLoading: _loadingAction == 'review',
          onTap: () => _doAction('review', () => notifier.claimStoreReview()),
        ),

        _FreeCreditTile(
          icon: Icons.share_rounded,
          title: 'store.social_share_title'.tr(),
          subtitle: 'store.social_share_desc'.tr(),
          reward: '20 Kredi',
          color: Colors.lightBlueAccent,
          isLoading: _loadingAction == 'share',
          onTap: () => _doAction('share', () => notifier.claimSocialShare()),
        ),
      ],
    );
  }
}

class _FreeCreditTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String reward;
  final Color color;
  final bool isLoading;
  final VoidCallback onTap;

  static const _cardColor = Color(0xFF132038);

  const _FreeCreditTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.reward,
    required this.color,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(8),
          splashColor: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: color,
                          ),
                        )
                      : Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white30,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Text(
                    reward,
                    style: GoogleFonts.robotoMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
