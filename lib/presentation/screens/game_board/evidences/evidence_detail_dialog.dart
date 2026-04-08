import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:doctor/data/models/medical_data.dart';
import '../../../providers/config_provider.dart';
import '../../../providers/game_state_provider.dart';
import '../../../providers/retested_evidences_provider.dart';
import '../../../widgets/retest_button.dart';
import '../../../widgets/uv_light_reveal.dart';

class EvidenceDetailDialog extends ConsumerWidget {
  final MedicalData evidence;

  final String cdnBaseUrl;

  /// Deduction'larin kontrol edilmesi icin caseId gerekli
  final String? caseId;

  const EvidenceDetailDialog({
    super.key,
    required this.evidence,
    required this.cdnBaseUrl,
    this.caseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);

    // Retest durumunu izle
    final retestedMap = ref.watch(retestedEvidencesProvider);
    final isRetested = evidence.isRetested || retestedMap.containsKey(evidence.id);
    final correctValue = retestedMap[evidence.id] ?? evidence.correctValue;

    // Deduction durumunu izle (nurseNoteInconsistency icin)
    final gameState = caseId != null
        ? ref.watch(gameStateProvider(caseId!))
        : null;
    final unlockedDeductionIds = gameState?.unlockedDeductionIds ?? {};

    // nurseNoteInconsistency sadece ilgili deduction bulunmussa gosterilir
    // Basit yaklasim: herhangi bir deduction acildiysa goster
    // (Gercek implementasyonda evidence ID'sini iceren deduction kontrol edilir)
    final hasRelevantDeduction = unlockedDeductionIds.isNotEmpty;

    return Dialog(
      backgroundColor: const Color(0xFF132038),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header / Gorsel
            if (evidence.type == MedicalDataType.photo ||
                evidence.type == MedicalDataType.imaging ||
                evidence.type == MedicalDataType.anatomicalImaging)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: SizedBox(
                  height: 300,
                  child: evidence.hasHiddenLayer && evidence.hiddenLayerUrl != null
                      ? UVLightReveal(
                          baseImagePath: evidence.filePath,
                          hiddenImagePath: evidence.hiddenLayerUrl!,
                          revealRadius: 70,
                          cdnBaseUrl: cdnBaseUrl,
                        )
                      : AppImage(
                          path: evidence.filePath,
                          cdnBaseUrl: cdnBaseUrl,
                          fit: BoxFit.cover,
                          errorWidget: Container(
                            height: 200,
                            color: Colors.grey[800],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                ),
              )
            else
              Container(
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF0A1628),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Icon(
                  _getTypeIcon(evidence.type),
                  size: 50,
                  color: Colors.white54,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baslik + Dogrulanmamis Badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          evidence.title,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Dogrulanmamis sonuc uyarisi
                      if (evidence.isPotentiallySwapped && !isRetested)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9800).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFFFF9800).withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                size: 14,
                                color: Color(0xFFFF9800),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Dogrulanmamis',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFF9800),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Dogrulanmis sonuc badge
                      if (evidence.isPotentiallySwapped && isRetested)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFF4CAF50).withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 14,
                                color: Color(0xFF4CAF50),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Dogrulanmis',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(
                        evidence.location ?? 'common.unknown_location'.tr(),
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                      const Spacer(),
                      Text(
                        evidence.discoveredAt ?? '',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),

                  // Sonuc Degeri Gosterimi (isPotentiallySwapped durumunda)
                  if (evidence.isPotentiallySwapped && evidence.resultValue != null) ...[
                    _buildResultValueSection(isRetested, correctValue),
                    const SizedBox(height: 12),
                  ],

                  // Tibbi veri icerigi / Aciklama
                  if (evidence.type == MedicalDataType.document) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        evidence.description,
                        style: GoogleFonts.courierPrime(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      evidence.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],

                  // Hemsire Notu bolumu
                  if (evidence.nurseNote != null) ...[
                    const SizedBox(height: 16),
                    _buildNurseNoteSection(
                      evidence.nurseNote!,
                      evidence.nurseNoteInconsistency,
                      hasRelevantDeduction,
                    ),
                  ],

                  if (evidence.notes != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF5350).withOpacity(0.1),
                        border: Border.all(color: const Color(0xFFEF5350).withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF5350), size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              evidence.notes!,
                              style: const TextStyle(
                                color: Color(0xFFEF5350),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Dogrulanmamis sonuc uyarisi (tam genislikte)
                  if (evidence.isPotentiallySwapped && !isRetested) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFFF9800).withOpacity(0.25),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFFF9800),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Sonuc dogrulanmamis',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: const Color(0xFFFFB74D),
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Testi Tekrarla butonu
                  if (evidence.isPotentiallySwapped && !isRetested)
                    RetestButton(
                      evidence: evidence,
                      caseId: caseId,
                      onRetestSuccess: () {
                        // Dialog'u kapat ve yeniden ac (state guncellenmesi icin)
                        Navigator.of(context).pop();
                      },
                    ),

                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('common.close'.tr()),
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

  /// Sonuc degeri bolumu — retest durumuna gore orijinal veya dogru degeri gosterir
  Widget _buildResultValueSection(bool isRetested, String? correctValue) {
    if (isRetested && correctValue != null) {
      // Dogrulanmis sonuc
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle,
                    size: 16, color: Color(0xFF4CAF50)),
                const SizedBox(width: 6),
                Text(
                  'Dogrulanmis sonuc',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              correctValue,
              style: GoogleFonts.robotoMono(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF81C784),
              ),
            ),
            if (evidence.resultValue != null &&
                evidence.resultValue != correctValue) ...[
              const SizedBox(height: 6),
              Text(
                'Onceki sonuc: ${evidence.resultValue}',
                style: GoogleFonts.robotoMono(
                  fontSize: 11,
                  color: Colors.white30,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.white30,
                ),
              ),
            ],
          ],
        ),
      );
    } else {
      // Dogrulanmamis orijinal sonuc
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9800).withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFFF9800).withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.science, size: 14, color: Colors.white38),
                const SizedBox(width: 6),
                Text(
                  'Sonuc Degeri',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              evidence.resultValue!,
              style: GoogleFonts.robotoMono(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFFCC80),
              ),
            ),
            if (evidence.referenceRange != null) ...[
              const SizedBox(height: 4),
              Text(
                evidence.referenceRange!,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.white30,
                ),
              ),
            ],
          ],
        ),
      );
    }
  }

  /// Hemsire notu bolumu
  Widget _buildNurseNoteSection(
    String nurseNote,
    String? inconsistency,
    bool hasRelevantDeduction,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF42A5F5).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF42A5F5).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.assignment_ind,
                size: 16,
                color: Color(0xFF42A5F5),
              ),
              const SizedBox(width: 6),
              Text(
                'Hemsire Notu',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF42A5F5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            nurseNote,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white60,
              height: 1.5,
            ),
          ),
          // Tutarsizlik bilgisi — sadece ilgili deduction bulunduysa gosterilir
          if (inconsistency != null && hasRelevantDeduction) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFB300).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFFFB300).withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb,
                    size: 14,
                    color: Color(0xFFFFB300),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      inconsistency,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFFFFD54F),
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Tibbi veri turune gore ikon secimi
  IconData _getTypeIcon(MedicalDataType type) {
    switch (type) {
      case MedicalDataType.document:
        return Icons.description;
      case MedicalDataType.toxicology:
        return Icons.science;
      case MedicalDataType.policeReport:
        return Icons.local_police;
      case MedicalDataType.trainingLog:
        return Icons.fitness_center;
      case MedicalDataType.lifestyleData:
        return Icons.self_improvement;
      case MedicalDataType.anatomicalImaging:
        return Icons.accessibility_new;
      case MedicalDataType.labResult:
        return Icons.biotech;
      case MedicalDataType.physicalExam:
        return Icons.medical_services;
      case MedicalDataType.audio:
        return Icons.audiotrack;
      case MedicalDataType.labSample:
        return Icons.science;
      default:
        return Icons.extension;
    }
  }
}
