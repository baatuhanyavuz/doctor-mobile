import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';

/// Mini oyun sonuç diyalogu
///
/// Skor, XP, seviye atlama ve değerlendirme gösterir.
class MiniGameResultDialog extends StatelessWidget {
  final MiniGameResult result;
  final VoidCallback onClose;

  const MiniGameResultDialog({
    super.key,
    required this.result,
    required this.onClose,
  });

  Color _scoreColor() {
    if (result.score >= 900) return const Color(0xFFD4A847);
    if (result.score >= 700) return const Color(0xFF03DAC6);
    if (result.score >= 400) return Colors.white;
    return const Color(0xFFCF6679);
  }

  String _scoreLabel() {
    if (result.score >= 900) return 'mini_games.result.perfect'.tr();
    if (result.score >= 700) return 'mini_games.result.very_good'.tr();
    if (result.score >= 400) return 'mini_games.result.good'.tr();
    if (result.score >= 200) return 'mini_games.result.average'.tr();
    return 'mini_games.result.failed'.tr();
  }

  String _verdict() {
    final s = result.score;
    if (s >= 900) return 'mini_games.result.perfect_msg'.tr();
    if (s >= 700) return 'mini_games.result.very_good_msg'.tr();
    if (s >= 400) return 'mini_games.result.good_msg'.tr();
    if (s >= 200) return 'mini_games.result.average_msg'.tr();
    return 'mini_games.result.failed_msg'.tr();
  }

  IconData _scoreIcon() {
    if (result.score >= 900) return Icons.military_tech;
    if (result.score >= 700) return Icons.thumb_up;
    if (result.score >= 400) return Icons.check_circle;
    return Icons.warning;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _scoreColor().withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Başlık ikonu
            Icon(_scoreIcon(), size: 48, color: _scoreColor()),
            const SizedBox(height: 12),

            // Değerlendirme
            Text(
              _scoreLabel(),
              style: GoogleFonts.specialElite(
                color: _scoreColor(),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 16),

            // Skor
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${result.score} / 1000',
                style: GoogleFonts.robotoMono(
                  color: _scoreColor(),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Verdict
            Text(
              _verdict(),
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // XP ve Seviye bilgisi
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    icon: Icons.star,
                    label: 'common.xp'.tr(),
                    value: '+${result.xpEarned}',
                    color: const Color(0xFFD4A847),
                  ),
                  Container(width: 1, height: 30, color: Colors.white12),
                  _StatItem(
                    icon: Icons.trending_up,
                    label: 'mini_games.result.total_xp'.tr(),
                    value: '${result.totalXp}',
                    color: const Color(0xFF03DAC6),
                  ),
                  Container(width: 1, height: 30, color: Colors.white12),
                  _StatItem(
                    icon: Icons.shield,
                    label: 'mini_games.result.level'.tr(),
                    value: '${result.newLevel}',
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Seviye atladıysa
            if (result.leveledUp) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A847).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFD4A847).withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.celebration, color: Color(0xFFD4A847), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'SEVİYE ATLADIN! → Lv.${result.newLevel}',
                      style: GoogleFonts.specialElite(
                        color: const Color(0xFFD4A847),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Kapat butonu
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _scoreColor().withOpacity(0.2),
                  foregroundColor: _scoreColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: _scoreColor()),
                  ),
                ),
                child: Text(
                  'common.continue_btn'.tr(),
                  style: GoogleFonts.specialElite(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: Colors.white38,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
