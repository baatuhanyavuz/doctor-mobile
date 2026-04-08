import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../data/models/case.dart';
import '../../../../data/models/solution.dart';
import '../../../providers/auth_providers.dart';
import '../../../providers/config_provider.dart';
import '../../../providers/ppe_provider.dart';

class SolveTab extends ConsumerStatefulWidget {
  final Case gameCase;

  const SolveTab({super.key, required this.gameCase});

  @override
  ConsumerState<SolveTab> createState() => _SolveTabState();
}

class _SolveTabState extends ConsumerState<SolveTab> {
  String? _selectedDiagnosisId;
  String? _selectedTreatment;
  bool _isSubmitting = false;

  /// Backend'e vaka tamamlama bilgisi gönder ve XP kazan
  Future<Map<String, dynamic>?> _completeCaseOnBackend(int score) async {
    try {
      final dio = ref.read(dioProvider);

      // 1. Önce vakayı başlat (zaten başlatılmışsa backend hata döner, sorun değil)
      try {
        await dio.post(
          AppConstants.userCasesStartEndpoint,
          data: {'caseId': widget.gameCase.id},
        );
      } catch (_) {
        // Zaten başlatılmışsa devam et
      }

      // 2. Vakayı tamamla ve XP kazan
      final response = await dio.put(
        AppConstants.userCasesCompleteEndpoint,
        data: {
          'caseId': widget.gameCase.id,
          'score': score,
        },
      );

      return response.data as Map<String, dynamic>;
    } catch (e) {
      debugPrint('[SolveTab] Backend XP hatası: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('common.error'.tr(args: [e.toString()])),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      return null;
    }
  }

  /// Seçilen tedavinin tehlikeli olup olmadığını kontrol eder (sync)
  DangerousTreatment? _findDangerousTreatment() {
    if (_selectedTreatment == null) return null;
    final list = widget.gameCase.solution.dangerousTreatments;
    if (list.isEmpty) return null;
    final match = list.where((dt) => dt.treatmentName == _selectedTreatment);
    return match.isEmpty ? null : match.first;
  }

  /// Tehlikeli tedavi uyarı dialogu gösterir. true = onayladı, false = iptal
  Future<bool> _showDangerousWarning(DangerousTreatment dangerous) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEF5350), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 64,
                color: Color(0xFFEF5350),
              ),
              const SizedBox(height: 16),
              Text(
                'TEHLİKELİ TEDAVİ!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEF5350),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF5350).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFEF5350).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dangerous.treatmentName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFFFFB74D), size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            dangerous.reason,
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFFB74D),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.dangerous, color: Color(0xFFEF5350), size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            dangerous.consequence,
                            style: GoogleFonts.inter(
                              color: const Color(0xFFEF5350),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bu tedaviyi uygulamak istediğinizden emin misiniz?',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'VAZGEÇ',
                        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF5350).withOpacity(0.2),
                        foregroundColor: const Color(0xFFEF5350),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'DEVAM ET',
                        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return confirmed ?? false;
  }

  /// Tehlikeli tedavi onaylandı — başarısız ending göster
  void _handleDangerousTreatmentFailure(DangerousTreatment dangerous) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEF5350), width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nabız çizgisi ikonu
              const Icon(
                Icons.heart_broken_rounded,
                size: 72,
                color: Color(0xFFEF5350),
              ),
              const SizedBox(height: 16),
              Text(
                'HASTA KOMPLİKASYON GEÇİRDİ!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEF5350),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF5350).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFEF5350).withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.medication, color: Color(0xFFFFB74D), size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Uygulanan tedavi: ${dangerous.treatmentName}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFFB74D),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      dangerous.consequence,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Hasta bilgisi (alerji/kronik hastalık)
              if (widget.gameCase.patient.allergies.isNotEmpty ||
                  widget.gameCase.patient.chronicDiseases.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.gameCase.patient.allergies.isNotEmpty) ...[
                        Text(
                          '⚠ Hasta alerjileri: ${widget.gameCase.patient.allergies.join(", ")}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFB74D),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      if (widget.gameCase.patient.chronicDiseases.isNotEmpty)
                        Text(
                          '⚠ Kronik hastalıklar: ${widget.gameCase.patient.chronicDiseases.join(", ")}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFFB74D),
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                'Hastanın tıbbi geçmişi dikkatlice incelenmeli ve tedavi planı buna göre oluşturulmalıydı.',
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go(
                      '/conclusion/${widget.gameCase.id}?failure=dangerousTreatment',
                      extra: {
                        'treatmentName': dangerous.treatmentName,
                        'reason': dangerous.reason,
                        'consequence': dangerous.consequence,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF5350).withOpacity(0.2),
                    foregroundColor: const Color(0xFFEF5350),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'DEVAM ET',
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAccusation() async {
    try {
      if (_selectedDiagnosisId == null || _selectedTreatment == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF132038),
            title: Text('solve.missing_selection'.tr(), style: TextStyle(color: Colors.white)),
            content: Text(
              'solve.select_suspect_motive'.tr(),
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('common.ok'.tr()),
              ),
            ],
          ),
        );
        return;
      }

      // Tehlikeli tedavi kontrolu
      final dangerous = _findDangerousTreatment();
      if (dangerous != null) {
        final confirmed = await _showDangerousWarning(dangerous);
        if (!confirmed) return; // Kullanıcı iptal etti
        // Kullanıcı tehlikeli tedaviyi onayladı — başarısız ending
        _handleDangerousTreatmentFailure(dangerous);
        return;
      }

      final isCorrectSuspect = _selectedDiagnosisId == widget.gameCase.solution.correctDiagnosisId;
      final isCorrectMotive = _selectedTreatment == widget.gameCase.solution.correctTreatment;
      
      if (isCorrectSuspect && isCorrectMotive) {
        // Doğru cevap! Backend'e XP bildir
        setState(() => _isSubmitting = true);

        // Enfeksiyon cezası — XP düşür
        final ppe = ref.read(ppeProvider);
        final baseScore = widget.gameCase.solution.scoreReward;
        final score = (baseScore * ppe.scorePenaltyMultiplier).round();

        // Backend'i cagir
        final result = await _completeCaseOnBackend(score);

        setState(() => _isSubmitting = false);

        if (result != null) {
          final xpEarned = result['xpEarned'] ?? 0;
          final totalXp = result['totalXp'] ?? 0;
          final newLevel = result['newLevel'] ?? 1;
          final leveledUp = result['leveledUp'] ?? false;

          // Frontend state'i güncelle (Profil ekranında sıfır XP görünmemesi için)
          ref.read(authNotifierProvider.notifier).updateUserProgress(
            newLevel: newLevel,
            newTotalXp: totalXp,
          );

          _showXpDialog(
            xpEarned, totalXp, newLevel, leveledUp,
            infectionPenalty: ppe.isInfected ? (baseScore - score) : 0,
          );
        } else {
          // Eger null ise backend hatasi. Dialog gostererek uyar, direk conclusion'a atma.
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: const Color(0xFF132038),
                title: Text('solve.connection_error'.tr(), style: TextStyle(color: const Color(0xFFEF5350))),
                content: Text(
                  'solve.connection_error_message'.tr(),
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      context.go('/conclusion/${widget.gameCase.id}');
                    },
                    child: Text('solve.continue_anyway'.tr()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text('common.cancel'.tr()),
                  ),
                ],
              ),
            );
          }
        }
      } else if (isCorrectSuspect && !isCorrectMotive) {
        _showResultDialog(
          isSuccess: false,
          title: 'TEŞHİS DOĞRU, TEDAVİ YANLIŞ!',
          message: 'Doğru teşhisi koydunuz ama tedavi planı uygun değil. Tedavi seçeneklerini tekrar gözden geçirin.',
        );
      } else {
        _showResultDialog(
          isSuccess: false,
          title: 'YANLIŞ TEŞHİS!',
          message: 'Bu teşhis doğru değil. Tıbbi verileri tekrar inceleyin ve yeni bir değerlendirme yapın.',
        );
      }
    } catch (e, stackTrace) {
      setState(() => _isSubmitting = false);
      debugPrint('[SolveTab] Beklenmedik Hata: $e\n$stackTrace');
      
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF132038),
            title: Text('common.system_error'.tr(), style: TextStyle(color: const Color(0xFFEF5350))),
            content: Text(
              'common.unexpected_error'.tr(args: [e.toString()]),
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('common.ok'.tr()),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showXpDialog(int xpEarned, int totalXp, int newLevel, bool leveledUp, {int infectionPenalty = 0}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFFFD54F), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars_rounded, size: 64, color: Color(0xFFFFD54F)),
              const SizedBox(height: 16),
              Text(
                leveledUp ? 'SEVİYE ATLADIN!' : 'TEŞHİS DOĞRU!',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+$xpEarned XP',
                  style: GoogleFonts.robotoMono(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'common.total_xp_level'.tr(args: [totalXp.toString(), newLevel.toString()]),
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              if (leveledUp) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Seviye $newLevel\'e ulaştın!',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              if (infectionPenalty > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF5350).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFEF5350).withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.coronavirus, color: Color(0xFFEF5350), size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Enfeksiyon cezası: -$infectionPenalty XP',
                        style: const TextStyle(
                          color: Color(0xFFEF5350),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    context.go('/conclusion/${widget.gameCase.id}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.withOpacity(0.2),
                    foregroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'common.continue_btn'.tr(),
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog({required bool isSuccess, required String title, required String message}) {
    showDialog(
      context: context,
      barrierDismissible: !isSuccess, // Başarılıysa kapatılamasın (veya ana menüye dönsün)
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSuccess ? const Color(0xFF66BB6A) : const Color(0xFFEF5350),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
                size: 80,
                color: isSuccess ? const Color(0xFF66BB6A) : const Color(0xFFEF5350),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (isSuccess) {
                      // Ana menüye dön veya sonraki vakaya geç
                      Navigator.of(context).pop(); // GameScreen'den çık
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? const Color(0xFF66BB6A).withOpacity(0.2) : const Color(0xFFEF5350).withOpacity(0.2),
                    foregroundColor: isSuccess ? const Color(0xFF66BB6A) : const Color(0xFFEF5350),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    isSuccess ? 'solve.return_to_menu'.tr() : 'solve.try_again'.tr(),
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TEŞHİSİNİZ NEDİR?',
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tüm tıbbi verileri inceledikten sonra teşhisinizi belirleyin.',
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          
          // Teşhis Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: widget.gameCase.diagnoses.length,
            itemBuilder: (context, index) {
              final suspect = widget.gameCase.diagnoses[index];
              final isSelected = _selectedDiagnosisId == suspect.id;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDiagnosisId = suspect.id;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF00BFA5).withOpacity(0.2) : const Color(0xFF132038),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF00BFA5) : Colors.white10,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                          child: suspect.photoPath != null
                              ? AppImage(
                                  path: suspect.photoPath!,
                                  cdnBaseUrl: ref.watch(cdnBaseUrlProvider),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : const Icon(Icons.person, color: Colors.white24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          suspect.name,
                          style: TextStyle(
                            color: isSelected ? const Color(0xFF00BFA5) : Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 32),
          
          Text(
            'TEDAVİ PLANI',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Tedavi Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF132038),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTreatment,
                hint: const Text('Tedavi seçin...', style: TextStyle(color: Colors.grey)),
                dropdownColor: const Color(0xFF1B2D4A),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
                style: GoogleFonts.inter(color: Colors.white),
                items: widget.gameCase.solution.treatmentOptions.map((motive) {
                  return DropdownMenuItem(
                    value: motive,
                    child: Text(motive),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTreatment = value;
                  });
                },
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Teşhis Onayla Butonu
          GestureDetector(
            onTap: _isSubmitting ? null : () {
              _submitAccusation();
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: _isSubmitting
                    ? const Color(0xFF00BFA5).withOpacity(0.5)
                    : const Color(0xFF00BFA5),
                borderRadius: BorderRadius.circular(8),
                boxShadow: _isSubmitting ? [] : [
                  BoxShadow(
                    color: const Color(0xFF00BFA5).withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: _isSubmitting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'TEŞHİSİ ONAYLA',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
