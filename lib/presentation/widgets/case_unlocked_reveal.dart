import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/app_image.dart';
import '../../data/models/case.dart';
import '../providers/case_providers.dart';
import '../providers/config_provider.dart';

/// Yeni vaka açıldığında gösterilen sürprizli reveal dialog'u.
class CaseUnlockedReveal extends ConsumerStatefulWidget {
  final String caseId;

  const CaseUnlockedReveal({super.key, required this.caseId});

  static Future<void> show(BuildContext context, String caseId) async {
    HapticFeedback.mediumImpact();
    await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (_) => CaseUnlockedReveal(caseId: caseId),
    );
  }

  @override
  ConsumerState<CaseUnlockedReveal> createState() => _CaseUnlockedRevealState();
}

class _CaseUnlockedRevealState extends ConsumerState<CaseUnlockedReveal>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scale;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glow = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final caseAsync = ref.watch(caseByIdProvider(widget.caseId));
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);

    return caseAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
      data: (gameCase) {
        if (gameCase == null) {
          return const SizedBox.shrink();
        }
        final color = _difficultyColor(gameCase.difficulty);

        return ScaleTransition(
          scale: _scale,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedBuilder(
              animation: _glow,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1B2D),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(_glow.value * 0.6),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: child,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Üst banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        border: Border(
                          bottom: BorderSide(color: color.withOpacity(0.3)),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.celebration, color: color, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'YENİ VAKA AÇILDI',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.celebration, color: color, size: 20),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _difficultyLabel(gameCase.difficulty),
                            style: GoogleFonts.robotoMono(
                              fontSize: 10,
                              color: color.withOpacity(0.7),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Kapak
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (gameCase.coverImage.isNotEmpty)
                            AppImage(
                              path: gameCase.coverImage,
                              cdnBaseUrl: cdnBaseUrl,
                              fit: BoxFit.cover,
                              errorWidget: Container(
                                color: color.withOpacity(0.1),
                                child: Icon(Icons.medical_services,
                                    color: color, size: 60),
                              ),
                            )
                          else
                            Container(
                              color: color.withOpacity(0.1),
                              child: Icon(Icons.medical_services,
                                  color: color, size: 60),
                            ),
                          // Gradient
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFF0F1B2D).withOpacity(0.9),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Başlık + kısa açıklama
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Column(
                        children: [
                          Text(
                            gameCase.title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            gameCase.shortDescription,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white60,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20),

                          // Kapat butonu
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: color.withOpacity(0.2),
                                foregroundColor: color,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text(
                                'DEVAM',
                                style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
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
            ),
          ),
        );
      },
    );
  }
}

String _difficultyLabel(Difficulty d) {
  switch (d) {
    case Difficulty.tutorial:
      return 'BAŞLANGIÇ';
    case Difficulty.easy:
      return 'STAJYER';
    case Difficulty.medium:
      return 'SAĞLIKÇI';
    case Difficulty.hard:
      return 'AÇILIN BEN DOKTORUM';
    case Difficulty.expert:
      return 'HİPOKRAT';
  }
}

Color _difficultyColor(Difficulty d) {
  switch (d) {
    case Difficulty.tutorial:
      return const Color(0xFF81C784);
    case Difficulty.easy:
      return const Color(0xFF66BB6A);
    case Difficulty.medium:
      return const Color(0xFFFFB74D);
    case Difficulty.hard:
      return const Color(0xFFEF5350);
    case Difficulty.expert:
      return const Color(0xFFAB47BC);
  }
}
