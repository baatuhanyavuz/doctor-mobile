import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/shift.dart';

class ShiftReportScreen extends StatelessWidget {
  final ShiftStatus report;

  const ShiftReportScreen({super.key, required this.report});

  static const _bg = Color(0xFF0A1628);
  static const _surface = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _gold = Color(0xFFFFD54F);

  @override
  Widget build(BuildContext context) {
    final gradeColor = _gradeColor(report.grade ?? 'F');
    final total = report.totalCases + report.missedCases;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Grade badge
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [gradeColor.withOpacity(0.3), gradeColor.withOpacity(0.05)],
                  ),
                  border: Border.all(color: gradeColor, width: 3),
                ),
                child: Center(
                  child: Text(
                    report.grade ?? 'F',
                    style: GoogleFonts.poppins(
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      color: gradeColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'NÖBET RAPORU',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _gradeMessage(report.grade ?? 'F'),
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white54),
              ),
              const SizedBox(height: 32),

              // Stats grid
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    _buildStatRow('Toplam Vaka', '$total', Icons.local_hospital, Colors.white70),
                    const Divider(color: Colors.white12, height: 24),
                    _buildStatRow('Doğru Cevap', '${report.correctCases}', Icons.check_circle, Colors.greenAccent),
                    const Divider(color: Colors.white12, height: 24),
                    _buildStatRow('Yanlış Cevap', '${report.wrongCases}', Icons.cancel, Colors.redAccent),
                    const Divider(color: Colors.white12, height: 24),
                    _buildStatRow('Kaçırılan', '${report.missedCases}', Icons.timer_off, Colors.orange),
                    const Divider(color: Colors.white12, height: 24),
                    _buildStatRow('Başarı Oranı', total > 0
                        ? '%${((report.correctCases / total) * 100).round()}'
                        : '%0',
                      Icons.analytics, _teal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // XP + Credit rewards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _teal.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.star, color: _teal, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            '+${report.totalXp}',
                            style: GoogleFonts.robotoMono(fontSize: 24, fontWeight: FontWeight.bold, color: _teal),
                          ),
                          Text('XP', style: GoogleFonts.inter(fontSize: 12, color: Colors.white38)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _gold.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.monetization_on, color: _gold, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            '+${report.totalCredits}',
                            style: GoogleFonts.robotoMono(fontSize: 24, fontWeight: FontWeight.bold, color: _gold),
                          ),
                          Text('Kredi', style: GoogleFonts.inter(fontSize: 12, color: Colors.white38)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Shift info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip('Tür', _typeLabel(report.shiftType)),
                    _buildInfoChip('Yoğunluk', _intensityLabel(report.intensity)),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => context.go('/shift'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('YENİ NÖBET BAŞLAT', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/'),
                child: Text('Ana Ekrana Dön', style: GoogleFonts.inter(color: Colors.white38)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.white70))),
        Text(value, style: GoogleFonts.robotoMono(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white30)),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70)),
      ],
    );
  }

  Color _gradeColor(String grade) => switch (grade) {
    'S' => _gold,
    'A' => Colors.greenAccent,
    'B' => _teal,
    'C' => Colors.orange,
    'D' => Colors.deepOrange,
    _ => Colors.red,
  };

  String _gradeMessage(String grade) => switch (grade) {
    'S' => 'Mükemmel performans! Örnek doktor!',
    'A' => 'Harika iş! Çok iyi bir nöbet.',
    'B' => 'İyi performans, gelişime devam!',
    'C' => 'Ortalama performans. Daha dikkatli olun.',
    'D' => 'Zayıf performans. Pratik yapmalısınız.',
    _ => 'Başarısız. Tekrar deneyin.',
  };

  String _typeLabel(String type) => {'day': 'Gündüz', 'night': 'Gece', 'weekend': 'Hafta Sonu'}[type] ?? type;
  String _intensityLabel(String i) => {'calm': 'Sakin', 'normal': 'Normal', 'intense': 'Yoğun', 'chaotic': 'Kaotik'}[i] ?? i;
}
