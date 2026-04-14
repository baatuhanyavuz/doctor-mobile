import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/energy_provider.dart';
import 'mock_ad_dialog.dart';

/// Üst barda gösterilen enerji widget'ı — kalp ikonları + sayaç
class EnergyIndicator extends ConsumerWidget {
  const EnergyIndicator({super.key});

  static const _heartColor = Color(0xFFEF5350);
  static const _emptyColor = Color(0xFF3A4458);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final energy = ref.watch(energyProvider);

    return GestureDetector(
      onTap: () => _showEnergyDialog(context, ref),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _heartColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _heartColor.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: _heartColor, size: 16),
            const SizedBox(width: 4),
            Text(
              '${energy.energy}/${energy.maxEnergy}',
              style: GoogleFonts.robotoMono(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _heartColor,
              ),
            ),
            if (!energy.isFull) ...[
              const SizedBox(width: 6),
              Container(width: 1, height: 14, color: Colors.white12),
              const SizedBox(width: 6),
              Icon(Icons.timer, color: Colors.white54, size: 12),
              const SizedBox(width: 2),
              Text(
                energy.nextRefillFormatted,
                style: GoogleFonts.robotoMono(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showEnergyDialog(BuildContext context, WidgetRef ref) {
    final energy = ref.read(energyProvider);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _heartColor.withOpacity(0.4), width: 2),
        ),
        title: Row(
          children: [
            Icon(Icons.favorite, color: _heartColor, size: 24),
            const SizedBox(width: 10),
            Text('ENERJİ',
                style: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kalp göstergesi
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(energy.maxEnergy, (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.favorite,
                    color: i < energy.energy ? _heartColor : _emptyColor,
                    size: 32,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              '${energy.energy} / ${energy.maxEnergy}',
              style: GoogleFonts.robotoMono(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: _heartColor,
              ),
            ),
            const SizedBox(height: 8),
            if (energy.isFull)
              Text(
                'Enerjin tam dolu!',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
              )
            else
              Column(
                children: [
                  Text(
                    'Sonraki dolum: ${energy.nextRefillFormatted}',
                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Her 15 dakikada 1 enerji dolar',
                    style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // Reklam izleyerek doldur
            if (!energy.isFull)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_circle_fill),
                  label: Text(
                    'REKLAM İZLE +1 ENERJİ',
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  onPressed: () async {
                    Navigator.pop(ctx);
                    final completed = await MockAdDialog.show(
                      context,
                      reward: '+1 Enerji',
                      rewardIcon: Icons.favorite,
                      rewardColor: _heartColor,
                    );
                    if (completed) {
                      await ref.read(energyProvider.notifier).refillWithAd();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _heartColor.withOpacity(0.2),
                    foregroundColor: _heartColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('KAPAT', style: GoogleFonts.robotoMono(color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}
