import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/energy_provider.dart';
import 'mock_ad_dialog.dart';

/// Enerjisi biten kullanıcıya reklam izleme veya bekleme seçenekleri sunan dialog.
/// Geri dönüş: true = enerji yenilendi (reklam izlendi), false = vazgeçti
class NoEnergyDialog extends ConsumerWidget {
  const NoEnergyDialog({super.key});

  static const _red = Color(0xFFEF5350);

  /// Helper: dialog göster, reklam izlenirse true döner
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const NoEnergyDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energy = ref.watch(energyProvider);

    return Dialog(
      backgroundColor: const Color(0xFF0F1B2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _red.withOpacity(0.4), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kırık kalp animasyonu
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _red.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: _red.withOpacity(0.3), width: 2),
              ),
              child: const Icon(
                Icons.heart_broken_rounded,
                color: _red,
                size: 56,
              ),
            ),
            const SizedBox(height: 20),

            // Başlık
            Text(
              'ENERJİN BİTTİ',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _red,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vakaya başlamak için enerjiye ihtiyacın var.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Bilgi kutusu
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite, color: _red, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '${energy.energy}/${energy.maxEnergy} Enerji',
                        style: GoogleFonts.robotoMono(
                          color: _red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (!energy.isFull) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.white54, size: 14),
                        const SizedBox(width: 8),
                        Text(
                          'Sonraki enerji: ${energy.nextRefillFormatted}',
                          style: GoogleFonts.robotoMono(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Reklam izle
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_circle_fill),
                label: Text(
                  'REKLAM İZLE (+1 ENERJİ)',
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                onPressed: () async {
                  final completed = await MockAdDialog.show(
                    context,
                    reward: '+1 Enerji',
                    rewardIcon: Icons.favorite,
                    rewardColor: _red,
                  );
                  if (completed) {
                    await ref.read(energyProvider.notifier).refillWithAd();
                    if (context.mounted) Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _red.withOpacity(0.2),
                  foregroundColor: _red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Bekle
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'BEKLEMEYE DEVAM ET',
                style: GoogleFonts.robotoMono(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
