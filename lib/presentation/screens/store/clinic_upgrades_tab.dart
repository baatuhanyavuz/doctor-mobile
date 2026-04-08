import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/upgrade.dart';
import '../../providers/upgrades_provider.dart';

/// Mağaza — Klinik Yükseltmeleri sekmesi
class ClinicUpgradesTab extends ConsumerWidget {
  const ClinicUpgradesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upgrades = ref.watch(upgradesProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Başlık
        Text(
          'KLİNİK GELİŞTİRME',
          style: GoogleFonts.poppins(
            color: const Color(0xFF00BFA5),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Kalıcı yükseltmeler — tüm vakalarda geçerli',
          style: TextStyle(color: Colors.white38, fontSize: 12),
        ),
        const SizedBox(height: 20),

        // Yükseltme kartları
        ...UpgradeType.values.map((type) {
          final catalog = upgradeCatalog[type]!;
          final currentLevel = upgrades.getLevel(type);
          return _UpgradeCard(
            catalog: catalog,
            currentLevel: currentLevel,
            onPurchase: () {
              HapticFeedback.mediumImpact();
              final ok = ref.read(upgradesProvider.notifier).purchase(type);
              if (ok) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${catalog.name} Seviye ${currentLevel + 1} açıldı!'),
                    backgroundColor: const Color(0xFF00BFA5),
                  ),
                );
              }
            },
          );
        }),
      ],
    );
  }
}

class _UpgradeCard extends StatelessWidget {
  final UpgradeCatalogItem catalog;
  final int currentLevel;
  final VoidCallback onPurchase;

  const _UpgradeCard({
    required this.catalog,
    required this.currentLevel,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    final isMaxed = currentLevel >= catalog.levelCosts.length;
    final nextCost = isMaxed ? 0 : catalog.levelCosts[currentLevel];
    final nextEffect = isMaxed ? 'Maksimum seviye' : catalog.levelEffects[currentLevel];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMaxed
              ? const Color(0xFFFFD54F).withOpacity(0.3)
              : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Üst satır — ikon + isim + seviye
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF00BFA5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getIcon(catalog.type),
                  color: isMaxed ? const Color(0xFFFFD54F) : const Color(0xFF00BFA5),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      catalog.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      catalog.description,
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              // Seviye göstergesi
              _LevelIndicator(currentLevel: currentLevel, maxLevel: 3),
            ],
          ),
          const SizedBox(height: 12),

          // Sonraki seviye efekti
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isMaxed ? Icons.check_circle : Icons.arrow_upward,
                  color: isMaxed ? const Color(0xFFFFD54F) : const Color(0xFF00BFA5),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isMaxed ? 'Maksimum seviye — tüm bonuslar aktif' : nextEffect,
                    style: TextStyle(
                      color: isMaxed ? const Color(0xFFFFD54F) : Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Satın al butonu
          if (!isMaxed)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPurchase,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5).withOpacity(0.15),
                  foregroundColor: const Color(0xFF00BFA5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: const Color(0xFF00BFA5).withOpacity(0.3)),
                  ),
                ),
                child: Text(
                  'SEVİYE ${currentLevel + 1} AÇ — $nextCost Kredi',
                  style: GoogleFonts.robotoMono(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon(UpgradeType type) {
    switch (type) {
      case UpgradeType.goldenStethoscope: return Icons.hearing;
      case UpgradeType.fastDevice: return Icons.speed;
      case UpgradeType.aiMRI: return Icons.psychology;
      case UpgradeType.advancedLab: return Icons.biotech;
      case UpgradeType.comfortKit: return Icons.volunteer_activism;
    }
  }
}

/// Seviye göstergesi (3 nokta)
class _LevelIndicator extends StatelessWidget {
  final int currentLevel;
  final int maxLevel;

  const _LevelIndicator({required this.currentLevel, required this.maxLevel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxLevel, (i) {
        final isFilled = i < currentLevel;
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? const Color(0xFFFFD54F) : Colors.white10,
            border: Border.all(
              color: isFilled ? const Color(0xFFFFD54F) : Colors.white24,
              width: 1,
            ),
          ),
        );
      }),
    );
  }
}
