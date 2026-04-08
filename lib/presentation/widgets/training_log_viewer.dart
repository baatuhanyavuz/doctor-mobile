import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/medical_data.dart';

/// Antrenman günlüğü görüntüleyici widget.
///
/// Spor hekimliği vakalarında hasta antrenman günlüğü verisini
/// kronolojik sırayla gösterir.
class TrainingLogViewer extends StatelessWidget {
  final MedicalData evidence;

  const TrainingLogViewer({super.key, required this.evidence});

  static const _green = Color(0xFF66BB6A);
  static const _orange = Color(0xFFFF9800);
  static const _teal = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _green.withOpacity(0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: _green.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.fitness_center,
                      color: _green, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ANTRENMAN GÜNLÜĞÜ',
                        style: GoogleFonts.robotoMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _green,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        evidence.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (evidence.dateTime != null)
                  Text(
                    evidence.dateTime!,
                    style: GoogleFonts.robotoMono(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  ),
              ],
            ),
          ),

          // İçerik
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Açıklama
                if (evidence.description.isNotEmpty) ...[
                  Text(
                    evidence.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Notlar (detaylı antrenman bilgisi)
                if (evidence.notes != null && evidence.notes!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132038),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      evidence.notes!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 11,
                        color: Colors.white60,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Anormal değer gösterimi
                if (evidence.isAbnormal &&
                    evidence.resultValue != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _orange.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: _orange, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                evidence.resultValue!,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: _orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (evidence.referenceRange != null)
                                Text(
                                  evidence.referenceRange!,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: Colors.white38,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Kaynak
                if (evidence.source != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.source, size: 14, color: _teal.withOpacity(0.5)),
                      const SizedBox(width: 6),
                      Text(
                        'Kaynak: ${evidence.source}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: _teal.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Yaşam tarzı analizi görüntüleyici widget.
///
/// Spor hekimliği vakalarında hasta yaşam tarzı verilerini
/// görsel kartlar halinde gösterir.
class LifestyleDataViewer extends StatelessWidget {
  final MedicalData evidence;

  const LifestyleDataViewer({super.key, required this.evidence});

  static const _orange = Color(0xFFFF9800);
  static const _teal = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _orange.withOpacity(0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: _orange.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _orange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.self_improvement,
                      color: _orange, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YAŞAM TARZI ANALİZİ',
                        style: GoogleFonts.robotoMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _orange,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        evidence.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // İçerik
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (evidence.description.isNotEmpty)
                  Text(
                    evidence.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                if (evidence.notes != null && evidence.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132038),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Text(
                      evidence.notes!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white60,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Polis raporu görüntüleyici widget.
///
/// Adli tıp vakalarında polis raporu entegrasyonunu gösterir.
class PoliceReportViewer extends StatelessWidget {
  final MedicalData evidence;

  const PoliceReportViewer({super.key, required this.evidence});

  static const _blue = Color(0xFF42A5F5);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _blue.withOpacity(0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(color: _blue.withOpacity(0.2)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _blue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.local_police,
                      color: _blue, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'POLİS RAPORU',
                        style: GoogleFonts.robotoMono(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _blue,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        evidence.title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (evidence.dateTime != null)
                  Text(
                    evidence.dateTime!,
                    style: GoogleFonts.robotoMono(
                      fontSize: 10,
                      color: Colors.white38,
                    ),
                  ),
              ],
            ),
          ),

          // İçerik
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (evidence.description.isNotEmpty)
                  Text(
                    evidence.description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                if (evidence.notes != null && evidence.notes!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132038),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _blue.withOpacity(0.15)),
                    ),
                    child: Text(
                      evidence.notes!,
                      style: GoogleFonts.robotoMono(
                        fontSize: 11,
                        color: Colors.white60,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
