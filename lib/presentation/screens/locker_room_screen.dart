import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/case.dart';
import '../../data/models/protective_gear.dart';
import '../providers/ppe_provider.dart';

/// Hazırlık Odası — Hastaya girmeden önce KKD seçim ekranı
class LockerRoomScreen extends ConsumerWidget {
  final Case gameCase;

  const LockerRoomScreen({super.key, required this.gameCase});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ppe = ref.watch(ppeProvider);
    final risk = gameCase.infectionRisk;
    final hasRisk = risk != null && risk.level != InfectionRiskLevel.none;
    final requiredGear = risk?.requiredGear ?? [];
    final allMet = ppe.meetsRequirements(requiredGear);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          'HAZIRLIK ODASI',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Bulaş riski uyarısı
            if (hasRisk)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: _riskColor(risk.level).withOpacity(0.15),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: _riskColor(risk.level), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BULAŞ RİSKİ: ${_riskLabel(risk.level)}',
                            style: GoogleFonts.robotoMono(
                              color: _riskColor(risk.level),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (risk.description.isNotEmpty)
                            Text(
                              risk.description,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // Başlık
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Koruyucu Ekipman Seçin',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                hasRisk
                    ? 'Bu hasta için uygun KKD giymelisiniz.'
                    : 'Bu hasta için KKD isteğe bağlıdır.',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
            ),

            const SizedBox(height: 24),

            // KKD Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                  children: GearType.values.map((gear) {
                    final isEquipped = ppe.hasGear(gear);
                    final isRequired = requiredGear.contains(gear);
                    return _GearCard(
                      gear: gear,
                      isEquipped: isEquipped,
                      isRequired: isRequired,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        ref.read(ppeProvider.notifier).toggle(gear);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            // Alt buton
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (hasRisk && !allMet)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.info_outline,
                              color: Color(0xFFFFB74D), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Eksik ekipman var — enfeksiyon riski!',
                            style: TextStyle(
                              color: const Color(0xFFFFB74D),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/game/${gameCase.id}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allMet || !hasRisk
                            ? const Color(0xFF00BFA5)
                            : const Color(0xFFFFB74D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        allMet || !hasRisk
                            ? 'HASTAYA GİR'
                            : 'EKSİK KKD İLE GİR',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _riskColor(InfectionRiskLevel level) {
    switch (level) {
      case InfectionRiskLevel.none:
        return const Color(0xFF66BB6A);
      case InfectionRiskLevel.low:
        return const Color(0xFFFFB74D);
      case InfectionRiskLevel.medium:
        return const Color(0xFFFF9800);
      case InfectionRiskLevel.high:
        return const Color(0xFFEF5350);
    }
  }

  String _riskLabel(InfectionRiskLevel level) {
    switch (level) {
      case InfectionRiskLevel.none:
        return 'YOK';
      case InfectionRiskLevel.low:
        return 'DÜŞÜK';
      case InfectionRiskLevel.medium:
        return 'ORTA';
      case InfectionRiskLevel.high:
        return 'YÜKSEK';
    }
  }
}

/// Tek bir KKD kartı
class _GearCard extends StatelessWidget {
  final GearType gear;
  final bool isEquipped;
  final bool isRequired;
  final VoidCallback onTap;

  const _GearCard({
    required this.gear,
    required this.isEquipped,
    required this.isRequired,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isEquipped
        ? const Color(0xFF00BFA5)
        : isRequired
            ? const Color(0xFFEF5350)
            : Colors.white24;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isEquipped
              ? const Color(0xFF00BFA5).withOpacity(0.12)
              : const Color(0xFF132038),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: isEquipped ? 2 : 1),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_gearIcon(gear), color: color, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    _gearLabel(gear),
                    style: GoogleFonts.poppins(
                      color: isEquipped ? const Color(0xFF00BFA5) : Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Zorunlu badge
            if (isRequired && !isEquipped)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF5350),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'GEREKLİ',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Equipped checkmark
            if (isEquipped)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00BFA5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _gearIcon(GearType type) {
    switch (type) {
      case GearType.mask:
        return Icons.masks;
      case GearType.gloves:
        return Icons.back_hand;
      case GearType.gown:
        return Icons.checkroom;
      case GearType.goggles:
        return Icons.visibility;
      case GearType.faceShield:
        return Icons.face_retouching_natural;
    }
  }

  String _gearLabel(GearType type) {
    switch (type) {
      case GearType.mask:
        return 'Maske';
      case GearType.gloves:
        return 'Eldiven';
      case GearType.gown:
        return 'Önlük';
      case GearType.goggles:
        return 'Gözlük';
      case GearType.faceShield:
        return 'Yüz Siperliği';
    }
  }
}
