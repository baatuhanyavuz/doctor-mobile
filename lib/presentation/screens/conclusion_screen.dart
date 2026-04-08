import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/utils/sound_manager.dart';
import '../../core/widgets/app_image.dart';
import '../../data/models/case.dart';
import '../providers/config_provider.dart';
import '../providers/credit_providers.dart';
import '../providers/ethical_dilemma_provider.dart';

class ConclusionScreen extends ConsumerStatefulWidget {
  final Case gameCase;

  /// Başarısız ending tipi (null = başarılı)
  final String? failureType;

  /// Tehlikeli tedavi bilgileri (failureType == 'dangerousTreatment' ise)
  final Map<String, String>? failureData;

  const ConclusionScreen({
    super.key,
    required this.gameCase,
    this.failureType,
    this.failureData,
  });

  @override
  ConsumerState<ConclusionScreen> createState() => _ConclusionScreenState();
}

class _ConclusionScreenState extends ConsumerState<ConclusionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _stampController;
  late Animation<double> _stampScale;
  late Animation<double> _stampOpacity;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _stampScale = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: Curves.bounceOut),
    );

    _stampOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _stampController, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    // Animasyonu biraz gecikmeli başlat ve sesi çal
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _stampController.forward();
        SoundManager.instance.playSfx(
          widget.failureType != null ? 'chemical_fizz' : 'judge_gavel',
        );
      }
    });
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }



  bool get _isFailed => widget.failureType != null;

  @override
  Widget build(BuildContext context) {
    if (_isFailed) return _buildFailureEnding(context);
    return _buildSuccessEnding(context);
  }

  // ─── BAŞARILI ENDİNG ────────────────────────────────────────
  Widget _buildSuccessEnding(BuildContext context) {
    final ending = widget.gameCase.endingData;
    final reputation = ref.watch(reputationProvider);
    final patientPhoto = ending?.patientImage ?? widget.gameCase.patient.photoPath;

    // İtibar eşiği kontrolü — düşük itibar farklı ending
    final isLowReputation = ending?.reputationThreshold != null &&
        reputation.score < ending!.reputationThreshold!;

    // Etik seçime bağlı alternatif anlatı kontrolü
    String? alternateNarrative;
    String? alternateFeedback;
    for (final entry in reputation.resolvedDilemmas.entries) {
      final dilemmaId = entry.key;
      final choiceId = entry.value;
      // Seçilen choice'un alternateEndingNarrative'ini bul
      final dilemma = widget.gameCase.ethicalDilemmas
          .where((d) => d.id == dilemmaId)
          .firstOrNull;
      if (dilemma != null) {
        final choice = dilemma.choices.where((c) => c.id == choiceId).firstOrNull;
        if (choice?.alternateEndingNarrative != null) {
          alternateNarrative = choice!.alternateEndingNarrative;
          alternateFeedback = choice.alternatePatientFeedback;
        }
      }
    }

    // Final anlatı seçimi (öncelik: düşük itibar > alternatif > varsayılan)
    final displayNarrative = isLowReputation
        ? (ending.lowReputationNarrative ?? ending.narrative)
        : (alternateNarrative ?? ending?.narrative ?? widget.gameCase.solution.explanation);
    final displayFeedback = isLowReputation
        ? (ending.lowReputationFeedback ?? ending.patientFeedback)
        : (alternateFeedback ?? ending?.patientFeedback ?? '');

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    ending?.title ?? 'conclusion.justice_served'.tr(),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Hasta Fotosu (İyileşme)
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.5), width: 4),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00BFA5).withOpacity(0.15),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: patientPhoto != null
                                ? AppImage(path: patientPhoto, cdnBaseUrl: ref.watch(cdnBaseUrlProvider), fit: BoxFit.cover)
                                : Container(color: const Color(0xFF132038), child: const Icon(Icons.person, size: 80, color: Colors.white24)),
                          ),
                        ),
                        // Damga Animasyonu
                        AnimatedBuilder(
                          animation: _stampController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _stampScale.value,
                              child: Opacity(
                                opacity: _stampOpacity.value,
                                child: Transform.rotate(
                                  angle: -0.2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xFF00BFA5), width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'conclusion.case_closed'.tr(),
                                      style: GoogleFonts.blackOpsOne(
                                        fontSize: 32,
                                        color: const Color(0xFF00BFA5).withOpacity(0.9),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Tedavi Süreci (Narrative)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132038),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'conclusion.solution'.tr(),
                          style: GoogleFonts.robotoMono(
                            fontSize: 14,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          displayNarrative,
                          style: GoogleFonts.inter(fontSize: 16, color: Colors.white70, height: 1.6),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // İtibar puanı göstergesi (etik ikilem varsa)
                  if (reputation.resolvedDilemmas.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB74D).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFFB74D).withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Color(0xFFFFB74D), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'İtibar Puanı: ${reputation.score}/100',
                            style: GoogleFonts.robotoMono(
                              fontSize: 13,
                              color: const Color(0xFFFFB74D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Hasta Geri Bildirimi
                  if (displayFeedback.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const Icon(Icons.format_quote, color: Colors.white24, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            displayFeedback,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color(0xFF00BFA5),
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 50),

                  // Sosyal Paylaşım — 20 Kredi ödülü
                  _ShareRewardCard(caseTitle: widget.gameCase.title, caseId: widget.gameCase.id),
                  const SizedBox(height: 20),

                  // Butonlar
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go('/'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('conclusion.main_menu'.tr()),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.go('/'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent.withOpacity(0.2),
                            foregroundColor: Colors.greenAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('conclusion.next_case'.tr()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── BAŞARISIZ ENDİNG (TEDAVİ HATASI) ─────────────────────
  Widget _buildFailureEnding(BuildContext context) {
    const failRed = Color(0xFFEF5350);
    final isPatientLost = widget.failureType == 'patientLost';
    final data = widget.failureData ?? {};
    final treatmentName = data['treatmentName'] ?? '';
    final reason = data['reason'] ?? '';
    final consequence = data['consequence'] ?? '';
    final patientPhoto = widget.gameCase.patient.photoPath;
    final correctTreatment = widget.gameCase.solution.correctTreatment;
    final educationalNote = widget.gameCase.solution.educationalNote;
    final failureTitle = isPatientLost ? 'HASTA KAYBI' : 'TEDAVİ HATASI';
    final stampText = isPatientLost ? 'EXITUS' : 'TEDAVİ HATASI';
    final reportTitle = isPatientLost ? 'EXITUS RAPORU' : 'KOMPLİKASYON RAPORU';
    final reportIcon = isPatientLost ? Icons.monitor_heart_outlined : Icons.heart_broken;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Başlık
                  Text(
                    failureTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: failRed,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Hasta Fotosu — kırmızı çerçeve + "TEDAVİ HATASI" damgası
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: failRed.withOpacity(0.6), width: 4),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: failRed.withOpacity(0.15),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: patientPhoto != null
                                ? ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Color(0x40000000),
                                      BlendMode.darken,
                                    ),
                                    child: AppImage(
                                      path: patientPhoto,
                                      cdnBaseUrl: ref.watch(cdnBaseUrlProvider),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    color: const Color(0xFF132038),
                                    child: const Icon(Icons.person, size: 80, color: Colors.white24),
                                  ),
                          ),
                        ),
                        // Kırmızı damga
                        AnimatedBuilder(
                          animation: _stampController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _stampScale.value,
                              child: Opacity(
                                opacity: _stampOpacity.value,
                                child: Transform.rotate(
                                  angle: -0.2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: failRed, width: 4),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      stampText,
                                      style: GoogleFonts.blackOpsOne(
                                        fontSize: 28,
                                        color: failRed.withOpacity(0.95),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Komplikasyon Detayı
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF132038),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: failRed.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(reportIcon, color: failRed, size: 32),
                        const SizedBox(height: 12),
                        Text(
                          reportTitle,
                          style: GoogleFonts.robotoMono(
                            fontSize: 14,
                            color: failRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Uygulanan tedavi
                        if (treatmentName.isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: failRed.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.medication, color: failRed, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Uygulanan: $treatmentName',
                                    style: GoogleFonts.inter(
                                      color: failRed,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        // Neden tehlikeli
                        if (reason.isNotEmpty) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.info_outline, color: Color(0xFFFFB74D), size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  reason,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFFFB74D),
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                        // Sonuç
                        Text(
                          consequence,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Doğru tedavi bilgisi
                  if (correctTreatment.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BFA5).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.2)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_circle_outline, color: Color(0xFF00BFA5), size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Doğru tedavi:',
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF00BFA5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            correctTreatment,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF00BFA5),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Eğitici not
                  if (educationalNote.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.school, color: Color(0xFF64B5F6), size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'Bilgi Notu',
                                style: GoogleFonts.robotoMono(
                                  color: const Color(0xFF64B5F6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            educationalNote,
                            style: GoogleFonts.inter(
                              color: Colors.white54,
                              fontSize: 13,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 40),

                  // Butonlar — Tekrar Dene + Ana Menü
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go('/'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white70,
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text('conclusion.main_menu'.tr()),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Aynı vakayı tekrar başlat
                            context.go('/game/${widget.gameCase.id}');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB74D).withOpacity(0.2),
                            foregroundColor: const Color(0xFFFFB74D),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'TEKRAR DENE',
                            style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sosyal paylaşım ödül kartı — paylaşana 20 kredi
class _ShareRewardCard extends ConsumerStatefulWidget {
  final String caseTitle;
  final String caseId;

  const _ShareRewardCard({required this.caseTitle, required this.caseId});

  @override
  ConsumerState<_ShareRewardCard> createState() => _ShareRewardCardState();
}

class _ShareRewardCardState extends ConsumerState<_ShareRewardCard> {
  bool _shared = false;
  bool _loading = false;

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context) {
    if (_shared) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _teal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _teal.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: _teal, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Paylaşım ödülü kazandın! +20 Kredi',
                style: GoogleFonts.inter(color: _teal, fontSize: 13),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _gold.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _gold.withOpacity(0.25)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: _loading ? null : _handleShare,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _loading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(strokeWidth: 2, color: _gold),
                        )
                      : const Icon(Icons.share_outlined, color: _gold, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sonucunu Paylaş',
                        style: GoogleFonts.poppins(
                          color: _gold,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Arkadaşlarınla paylaş, 20 kredi kazan!',
                        style: GoogleFonts.inter(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _gold.withOpacity(0.3)),
                  ),
                  child: Text(
                    '+20 Kr',
                    style: GoogleFonts.robotoMono(
                      color: _gold,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleShare() async {
    setState(() => _loading = true);

    try {
      final result = await Share.share(
        'Doktor: Tanı Dosyaları\'nda "${widget.caseTitle}" vakasını tedavi ettim! Sen de doktor olmaya hazır mısın?\nhttps://doctor.novapps.fun',
        subject: 'Doktor: Tanı Dosyaları',
      );

      // Sadece gerçekten paylaşıldıysa kredi ver
      if (result.status == ShareResultStatus.success) {
        final success = await ref.read(creditNotifierProvider.notifier).claimSocialShare(widget.caseId);
        if (mounted && success) {
          setState(() => _shared = true);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bu vaka için paylaşım ödülü zaten alındı.'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
