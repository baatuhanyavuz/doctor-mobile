import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/ppe_provider.dart';

/// Enfeksiyon Detay Ekranı — iyileşme seçenekleri
class InfectionDetailScreen extends ConsumerWidget {
  const InfectionDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ppe = ref.watch(ppeProvider);

    // Enfeksiyon yoksa geri dön
    if (!ppe.isInfected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).pop();
      });
      return const SizedBox.shrink();
    }

    final color = _severityColor(ppe.severity);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          'ENFEKSİYON TEDAVİSİ',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ─── Durum Kartı ────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.coronavirus, color: color, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      _severityLabel(ppe.severity),
                      style: GoogleFonts.poppins(
                        color: color,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (ppe.infectionDescription.isNotEmpty)
                      Text(
                        ppe.infectionDescription,
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 20),
                    // Sayaç
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'İyileşmeye Kalan',
                            style: TextStyle(color: Colors.white38, fontSize: 11),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ppe.healingTimeFormatted,
                            style: GoogleFonts.robotoMono(
                              color: color,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.speed, color: Colors.white38, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                '${ppe.healingSpeedMultiplier}x — ${ppe.activeTreatmentName}',
                                style: GoogleFonts.robotoMono(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // XP ceza bilgisi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Enfekte iken vaka XP\'si -%${((1 - ppe.scorePenaltyMultiplier) * 100).round()} cezalı',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFFEF5350),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ─── Tedavi Seçenekleri ──────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'TEDAVİ SEÇENEKLERİ',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Vitamin Takviyesi — ücretsiz günde 1
              _TreatmentCard(
                icon: Icons.local_pharmacy,
                title: 'Vitamin Takviyesi',
                subtitle: 'Süreyi %20 azaltır',
                speedLabel: '-%20',
                color: const Color(0xFF66BB6A),
                cost: 'Günde 1 ücretsiz',
                isActive: ppe.activeTreatmentName == 'Vitamin Takviyesi',
                isDisabled: ppe.vitaminUsedToday && ppe.activeTreatmentName != 'Vitamin Takviyesi',
                onTap: () {
                  final ok = ref.read(ppeProvider.notifier).applyVitamin();
                  if (!ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bugün zaten vitamin aldınız'),
                        backgroundColor: Colors.orangeAccent,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),

              // Antibiyotik Kürü
              _TreatmentCard(
                icon: Icons.medication,
                title: 'Antibiyotik Kürü',
                subtitle: 'Süreyi %33 azaltır',
                speedLabel: '-%33',
                color: const Color(0xFF42A5F5),
                cost: '10 Kredi',
                isActive: ppe.activeTreatmentName == 'Antibiyotik Kürü',
                onTap: () {
                  ref.read(ppeProvider.notifier).applyAntibiotic();
                },
              ),
              const SizedBox(height: 12),

              // Yoğun Tedavi
              _TreatmentCard(
                icon: Icons.local_hospital,
                title: 'Yoğun Tedavi',
                subtitle: 'Süreyi yarıya indirir',
                speedLabel: '-%50',
                color: const Color(0xFFFF9800),
                cost: '25 Kredi',
                isActive: ppe.activeTreatmentName == 'Yoğun Tedavi',
                onTap: () {
                  ref.read(ppeProvider.notifier).applyIntensiveTreatment();
                },
              ),
              const SizedBox(height: 12),

              // Acil Müdahale — anında iyileş
              _TreatmentCard(
                icon: Icons.emergency,
                title: 'Acil Müdahale',
                subtitle: 'Anında tamamen iyileş',
                speedLabel: 'ANINDA',
                color: const Color(0xFFEF5350),
                cost: '50 Kredi',
                isActive: false,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: const Color(0xFF132038),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFEF5350)),
                      ),
                      title: Text(
                        'Acil Müdahale',
                        style: GoogleFonts.poppins(color: const Color(0xFFEF5350)),
                      ),
                      content: const Text(
                        'Enfeksiyonu anında iyileştirmek istediğinize emin misiniz?\n\nBu işlem 50 kredi harcar.',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('İptal', style: TextStyle(color: Colors.white54)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(ppeProvider.notifier).applyEmergencyCure();
                            Navigator.pop(ctx);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF5350),
                          ),
                          child: const Text('İYİLEŞTİR', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // İleride: Reklam izle butonu placeholder
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.play_circle_outline, color: Colors.white24, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reklam İzle',
                            style: GoogleFonts.poppins(
                              color: Colors.white38,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Yakında — reklam izleyerek ücretsiz hızlandırma',
                            style: TextStyle(color: Colors.white24, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'YAKINDA',
                        style: GoogleFonts.robotoMono(
                          color: Colors.white30,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _severityColor(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none: return const Color(0xFF66BB6A);
      case InfectionSeverity.mild: return const Color(0xFFFFB74D);
      case InfectionSeverity.moderate: return const Color(0xFFFF9800);
      case InfectionSeverity.severe: return const Color(0xFFEF5350);
    }
  }

  String _severityLabel(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none: return 'Sağlıklı';
      case InfectionSeverity.mild: return 'Hafif Enfeksiyon';
      case InfectionSeverity.moderate: return 'Orta Enfeksiyon';
      case InfectionSeverity.severe: return 'Ağır Enfeksiyon';
    }
  }
}

/// Tedavi seçenek kartı
class _TreatmentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String speedLabel;
  final Color color;
  final String cost;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback onTap;

  const _TreatmentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.speedLabel,
    required this.color,
    required this.cost,
    required this.isActive,
    this.isDisabled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.4 : 1.0,
      child: GestureDetector(
        onTap: isDisabled || isActive ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive
                ? color.withOpacity(0.12)
                : const Color(0xFF132038),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? color : Colors.white10,
              width: isActive ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: isActive ? color : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isActive) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'AKTİF',
                              style: GoogleFonts.robotoMono(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      speedLabel,
                      style: GoogleFonts.robotoMono(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cost,
                    style: TextStyle(color: Colors.white30, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
