import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:doctor/data/models/medical_data.dart';
import '../../../providers/config_provider.dart';
import '../../../providers/unlocked_evidences_provider.dart';
import '../../../providers/game_state_provider.dart';
import '../../../providers/retested_evidences_provider.dart';
import '../../../providers/evidence_request_provider.dart';
import '../../phone/fake_phone_screen.dart';
import '../../lab/forensic_lab_screen.dart';
import 'evidence_detail_dialog.dart';
import 'unlock_evidence_dialog.dart';

class EvidencesTab extends ConsumerWidget {
  final List<MedicalData> evidences;
  final String? caseId;

  const EvidencesTab({super.key, required this.evidences, this.caseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (evidences.isEmpty) {
      return Center(child: Text('evidences.no_evidence'.tr()));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: evidences.length,
      itemBuilder: (context, index) {
        final evidence = evidences[index];
        return _EvidenceCard(evidence: evidence, caseId: caseId);
      },
    );
  }
}

class _EvidenceCard extends ConsumerWidget {
  final MedicalData evidence;
  final String? caseId;

  const _EvidenceCard({required this.evidence, this.caseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedEvidences = ref.watch(unlockedEvidencesProvider);
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);
    final retestedMap = ref.watch(retestedEvidencesProvider);
    final isLocked = evidence.isLocked && !unlockedEvidences.contains(evidence.id);
    final isRetested = evidence.isRetested || retestedMap.containsKey(evidence.id);

    // Tahlil istek durumu
    final requestStatus = ref.watch(evidenceRequestStatusProvider(evidence.id));
    final requestDetail = ref.watch(evidenceRequestDetailProvider(evidence.id));
    final isRequestable = evidence.isRequestable && evidence.requestDurationSeconds > 0;
    final needsRequest = isRequestable && requestStatus == RequestStatus.notRequested;
    final isWaiting = requestStatus == RequestStatus.inProgress;

    return GestureDetector(
      onTap: () {
        if (isLocked) {
          // Kilitli - sifre diyalogunu goster
          showDialog(
            context: context,
            builder: (context) => UnlockEvidenceDialog(
              evidenceId: evidence.id,
              evidenceTitle: evidence.title,
              correctCode: evidence.unlockCode ?? '',
              lockedMessage: evidence.lockedHint ?? 'evidences.locked_evidence'.tr(),
              onUnlocked: () {
                ref.read(unlockedEvidencesProvider.notifier).unlockEvidence(evidence.id);
                if (caseId != null) {
                  ref.read(gameStateProvider(caseId!).notifier).unlockEvidence(evidence.id);
                }
              },
            ),
          );
        } else if (needsRequest) {
          // İstek gerekli — onay dialogu göster
          _showRequestDialog(context, ref);
        } else if (isWaiting) {
          // Bekleniyor — bilgi göster
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${evidence.title} sonuçları bekleniyor... ${requestDetail?.remainingFormatted ?? ""}',
                style: GoogleFonts.inter(fontSize: 12),
              ),
              backgroundColor: const Color(0xFFFFB74D).withOpacity(0.9),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (evidence.type == MedicalDataType.phone && evidence.phoneData != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FakePhoneScreen(
                phoneData: evidence.phoneData!,
                ownerName: evidence.title,
                cdnBaseUrl: cdnBaseUrl,
              ),
            ),
          );
        } else if (evidence.labAnalysisData != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ForensicLabScreen(
                evidence: evidence,
                cdnBaseUrl: cdnBaseUrl,
              ),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => EvidenceDetailDialog(
              evidence: evidence,
              cdnBaseUrl: cdnBaseUrl,
              caseId: caseId,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF132038),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isLocked
                    ? Colors.amber.shade700
                    : (evidence.isPotentiallySwapped && !isRetested)
                        ? const Color(0xFFFF9800).withOpacity(0.5)
                        : Colors.white10,
                width: isLocked ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildThumbnail(evidence, cdnBaseUrl),
                        if (isLocked)
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evidence.title,
                          style: GoogleFonts.poppins(
                            color: isLocked ? Colors.amber.shade700 : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          evidence.type.name.toUpperCase(),
                          style: GoogleFonts.robotoMono(
                            color: isLocked ? Colors.amber.shade600 : const Color(0xFF00BFA5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Kilit ikonu (kilitli ise)
          if (isLocked)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade700,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.shade900.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.black87,
                  size: 24,
                ),
              ),
            ),

          // Dogrulanmamis sonuc uyari badge (turuncu)
          if (!isLocked && evidence.isPotentiallySwapped && !isRetested)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9800),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9800).withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.black87,
                  size: 16,
                ),
              ),
            ),

          // Dogrulanmis sonuc badge (yesil tik)
          if (!isLocked && evidence.isPotentiallySwapped && isRetested)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),

          // Hemsire notu indikatoru (mavi)
          if (!isLocked && evidence.nurseNote != null)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFF42A5F5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF42A5F5).withOpacity(0.4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.assignment_ind,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),

          // Tahlil istek gerekli — "İSTE" overlay
          if (!isLocked && needsRequest)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.science, color: Color(0xFF00BFA5), size: 32),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BFA5).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.5)),
                      ),
                      child: Text(
                        'İSTE',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF00BFA5),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '~${_formatDuration(evidence.requestDurationSeconds)}',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Tahlil bekleniyor — geri sayım overlay
          if (!isLocked && isWaiting && requestDetail != null)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(
                        value: requestDetail.progress,
                        strokeWidth: 3,
                        color: const Color(0xFFFFB74D),
                        backgroundColor: Colors.white10,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      requestDetail.remainingFormatted,
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFFFB74D),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Sonuç bekleniyor...',
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showRequestDialog(BuildContext context, WidgetRef ref) {
    final duration = evidence.requestDurationSeconds;
    final cost = evidence.requestCreditCost;
    final durationStr = _formatDuration(duration);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: const Color(0xFF00BFA5).withOpacity(0.3)),
        ),
        title: Row(
          children: [
            const Icon(Icons.science, color: Color(0xFF00BFA5), size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                evidence.title,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bu tetkiki istemek istiyor musunuz?',
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.timer, color: Color(0xFFFFB74D), size: 20),
                      const SizedBox(height: 4),
                      Text(durationStr, style: GoogleFonts.robotoMono(color: const Color(0xFFFFB74D), fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Süre', style: GoogleFonts.inter(color: Colors.white38, fontSize: 10)),
                    ],
                  ),
                  if (cost > 0)
                    Column(
                      children: [
                        const Icon(Icons.monetization_on, color: Color(0xFFFFD54F), size: 20),
                        const SizedBox(height: 4),
                        Text('$cost Kr', style: GoogleFonts.robotoMono(color: const Color(0xFFFFD54F), fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('Maliyet', style: GoogleFonts.inter(color: Colors.white38, fontSize: 10)),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('VAZGEÇ', style: GoogleFonts.robotoMono(color: Colors.white38)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(evidenceRequestProvider.notifier).requestEvidence(
                evidence.id,
                evidence.requestDurationSeconds,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${evidence.title} istendi. Sonuç ~$durationStr içinde hazır olacak.',
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                  backgroundColor: const Color(0xFF00BFA5).withOpacity(0.9),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BFA5).withOpacity(0.2),
              foregroundColor: const Color(0xFF00BFA5),
            ),
            child: Text('İSTE', style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static String _formatDuration(int seconds) {
    if (seconds < 60) return '${seconds}sn';
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    if (sec == 0) return '${min}dk';
    return '${min}dk ${sec}sn';
  }

  Widget _buildThumbnail(MedicalData evidence, String cdnBaseUrl) {
    if (evidence.type == MedicalDataType.photo) {
      return AppImage(
        path: evidence.filePath,
        cdnBaseUrl: cdnBaseUrl,
        fit: BoxFit.cover,
        errorWidget: Container(
          color: Colors.grey[800],
          child: const Icon(Icons.image_not_supported, color: Colors.white24),
        ),
      );
    } else if (evidence.type == MedicalDataType.imaging ||
               evidence.type == MedicalDataType.anatomicalImaging) {
      // Imaging turleri — resim varsa goster, yoksa ikon
      if (evidence.filePath.isNotEmpty) {
        return AppImage(
          path: evidence.filePath,
          cdnBaseUrl: cdnBaseUrl,
          fit: BoxFit.cover,
          errorWidget: Container(
            color: const Color(0xFF1B2D4A),
            child: Center(
              child: Icon(
                evidence.type == MedicalDataType.anatomicalImaging
                    ? Icons.accessibility_new
                    : Icons.medical_information,
                size: 48,
                color: const Color(0xFF00BCD4),
              ),
            ),
          ),
        );
      }
      return Container(
        color: const Color(0xFF1B2D4A),
        child: Center(
          child: Icon(
            evidence.type == MedicalDataType.anatomicalImaging
                ? Icons.accessibility_new
                : Icons.medical_information,
            size: 48,
            color: const Color(0xFF00BCD4),
          ),
        ),
      );
    } else if (evidence.type == MedicalDataType.document) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.description, size: 48, color: Colors.white54),
        ),
      );
    } else if (evidence.type == MedicalDataType.audio) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.audiotrack, size: 48, color: Colors.white54),
        ),
      );
    } else if (evidence.type == MedicalDataType.labSample) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.science, size: 48, color: Colors.cyanAccent),
        ),
      );
    } else if (evidence.type == MedicalDataType.toxicology) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.science, size: 48, color: Color(0xFFCE93D8)),
        ),
      );
    } else if (evidence.type == MedicalDataType.policeReport) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.local_police, size: 48, color: Color(0xFF64B5F6)),
        ),
      );
    } else if (evidence.type == MedicalDataType.trainingLog) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.fitness_center, size: 48, color: Color(0xFF81C784)),
        ),
      );
    } else if (evidence.type == MedicalDataType.lifestyleData) {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.self_improvement, size: 48, color: Color(0xFFFFB74D)),
        ),
      );
    } else {
      return Container(
        color: const Color(0xFF1B2D4A),
        child: const Center(
          child: Icon(Icons.help_outline, size: 48, color: Colors.white54),
        ),
      );
    }
  }
}
