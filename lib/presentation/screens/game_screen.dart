import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/case_providers.dart';
import '../providers/config_provider.dart';
import '../providers/credit_providers.dart';
import '../providers/game_state_provider.dart';
import '../providers/unlocked_evidences_provider.dart';
import '../providers/vitals_provider.dart';
import '../providers/ppe_provider.dart';
import '../providers/ethical_dilemma_provider.dart';
import '../../data/models/protective_gear.dart';
import '../../data/models/ethical_dilemma.dart';
import 'game_board/evidences/evidences_tab.dart';
import 'game_board/suspects/suspects_tab.dart';
import 'game_board/interrogations/interrogation_tab.dart';
import 'game_board/solve/solve_tab.dart';
import 'game_board/detective_board_tab.dart';
import 'game_board/mini_games_tab.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/vitals_monitor.dart';
import '../widgets/ethical_dilemma_dialog.dart';
import '../../data/models/consultant.dart';
import 'consultation_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  final String caseId;

  const GameScreen({super.key, required this.caseId});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool _startDilemmaShown = false;
  bool _solveDilemmaShown = false;
  bool _tabListenerAdded = false;

  /// on_game_start etik ikilemlerini tetikle
  void _triggerStartDilemmas(List<EthicalDilemma> dilemmas) {
    if (_startDilemmaShown) return;
    _startDilemmaShown = true;

    final startDilemmas =
        dilemmas.where((d) => d.triggerPoint == 'on_game_start').toList();
    if (startDilemmas.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDilemmaChain(startDilemmas, 0);
    });
  }

  /// Sırayla dilemma göster (birden fazla olabilir)
  void _showDilemmaChain(List<EthicalDilemma> dilemmas, int index) {
    if (index >= dilemmas.length || !mounted) return;
    final dilemma = dilemmas[index];
    final reputation = ref.read(reputationProvider);
    if (reputation.isDilemmaResolved(dilemma.id)) {
      _showDilemmaChain(dilemmas, index + 1);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => EthicalDilemmaDialog(
        dilemma: dilemma,
        onChoiceMade: (choice) {
          // Kanıt açma/gizleme yan etkileri
          if (choice.unlocksEvidenceId != null) {
            ref
                .read(unlockedEvidencesProvider.notifier)
                .unlockEvidence(choice.unlocksEvidenceId!);
          }
        },
      ),
    ).then((_) {
      _showDilemmaChain(dilemmas, index + 1);
    });
  }

  /// before_solution tetikleyicisi — Solve tab'a geçerken
  void _triggerBeforeSolveDilemmas(List<EthicalDilemma> dilemmas) {
    final solveDilemmas =
        dilemmas.where((d) => d.triggerPoint == 'before_solution').toList();
    final unresolved = solveDilemmas.where(
      (d) => !ref.read(reputationProvider).isDilemmaResolved(d.id),
    ).toList();
    if (unresolved.isEmpty) return;

    _showDilemmaChain(unresolved, 0);
  }

  @override
  Widget build(BuildContext context) {
    final caseAsync = ref.watch(randomizedCaseProvider(widget.caseId));

    // GameState'i izle — backend'den yüklendiğinde mevcut provider'ları güncelle
    ref.watch(gameStateProvider(widget.caseId));
    ref.listen<GameState>(gameStateProvider(widget.caseId), (prev, next) {
      if (prev?.unlockedEvidenceIds != next.unlockedEvidenceIds) {
        final notifier = ref.read(unlockedEvidencesProvider.notifier);
        for (final id in next.unlockedEvidenceIds) {
          notifier.unlockEvidence(id);
        }
      }
    });

    return caseAsync.when(
      data: (gameCase) {
        if (gameCase == null) {
          return Scaffold(
            body: Center(child: Text('game.case_not_found'.tr())),
          );
        }

        final hasMiniGames = gameCase.miniGames.isNotEmpty;
        final hasEthicalDilemmas = gameCase.ethicalDilemmas.isNotEmpty;
        final tabCount = hasMiniGames ? 6 : 5;

        // on_game_start etik ikilemlerini tetikle
        if (hasEthicalDilemmas) {
          _triggerStartDilemmas(gameCase.ethicalDilemmas);
        }

        // Vitals baslat (hasta vital bilgileri varsa)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final notifier = ref.read(vitalsProvider.notifier);
          notifier.initFromCase(gameCase.patient.vitals);
          if (gameCase.patient.vitals != null) {
            notifier.startDegradation();
            notifier.startCountdown();
          }
        });

        // Hasta kaybı durumunu dinle → failure conclusion'a yönlendir
        ref.listen<VitalsState>(vitalsProvider, (prev, next) {
          if (prev?.condition != PatientCondition.lost &&
              next.condition == PatientCondition.lost) {
            context.go(
              '/conclusion/${gameCase.id}?failure=patientLost',
              extra: <String, String>{
                'consequence': 'Hastanın vital bulguları kritik seviyeye düştü ve müdahaleye rağmen yanıt alınamadı. Hasta kaybedildi.',
              },
            );
          }
        });

        // KKD kontrolü — bulaş riski varsa ve KKD eksikse enfeksiyon cezası
        final infectionRisk = gameCase.infectionRisk;
        if (infectionRisk != null &&
            infectionRisk.level != InfectionRiskLevel.none) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final ppe = ref.read(ppeProvider);
            if (!ppe.meetsRequirements(infectionRisk.requiredGear) &&
                !ppe.infectionPenaltyApplied) {
              // Enfeksiyon uygula (şiddet eksik KKD sayısına göre)
              ref.read(ppeProvider.notifier).applyInfection(
                infectionRisk.requiredGear,
                infectionRisk.penaltyDescription,
              );
              // Vitalleri kötüleştir + degradation hızlandır
              ref.read(vitalsProvider.notifier).deteriorate();
              ref.read(vitalsProvider.notifier).startDegradation(
                interval: const Duration(seconds: 25), // Normal 45s yerine 25s
              );
            }
          });
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) context.go('/');
          },
          child: DefaultTabController(
            length: tabCount,
            child: Builder(builder: (tabCtx) {
              // Tab değişiminde before_solution tetikleyici (sadece 1 kez ekle)
              if (!_tabListenerAdded && hasEthicalDilemmas) {
                _tabListenerAdded = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final tabController = DefaultTabController.of(tabCtx);
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) return;
                    final solveTabIndex = tabCount - 1;
                    if (tabController.index == solveTabIndex && !_solveDilemmaShown) {
                      _solveDilemmaShown = true;
                      _triggerBeforeSolveDilemmas(gameCase.ethicalDilemmas);
                    }
                  });
                });
              }
              return Scaffold(
              backgroundColor: const Color(0xFF0A1628),
              appBar: AppBar(
                backgroundColor: const Color(0xFF132038),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/'),
                ),
                title: Text(
                  gameCase.title,
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                actions: [
                  _ConsultButton(caseTitle: gameCase.title),
                  _HintButton(caseId: widget.caseId),
                ],
                bottom: TabBar(
                  indicatorColor: const Color(0xFF00BFA5),
                  labelColor: const Color(0xFF00BFA5),
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: [
                    Tab(icon: const Icon(Icons.medical_services), text: 'Tıbbi Veriler'),
                    Tab(icon: const Icon(Icons.biotech), text: 'Olası Teşhisler'),
                    Tab(icon: const Icon(Icons.question_answer), text: 'Anamnez'),
                    Tab(icon: const Icon(Icons.analytics), text: 'Teşhis Tahtası'),
                    if (hasMiniGames)
                      Tab(icon: const Icon(Icons.videogame_asset), text: 'game.analysis'.tr()),
                    Tab(icon: const Icon(Icons.local_hospital), text: 'Teşhis & Tedavi'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  // Vital bulgulari monitor cizgisi
                  if (gameCase.patient.vitals != null)
                    const VitalsMonitor(),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        EvidencesTab(evidences: gameCase.medicalData, caseId: widget.caseId),
                        SuspectsTab(suspects: gameCase.diagnoses),
                        InterrogationTab(
                          interrogations: gameCase.interviews,
                          suspects: gameCase.diagnoses,
                          cdnBaseUrl: ref.watch(cdnBaseUrlProvider),
                        ),
                        DetectiveBoardTab(
                          medicalData: gameCase.medicalData,
                          deductions: gameCase.deductions,
                          caseId: gameCase.id,
                        ),
                        if (hasMiniGames)
                          MiniGamesTab(
                            caseId: gameCase.id,
                            miniGames: gameCase.miniGames,
                          ),
                        SolveTab(gameCase: gameCase),
                      ],
                    ),
                  ),
                ],
              ),
            );
            }),
          ),
        );
      },
      loading: () => Scaffold(
        backgroundColor: const Color(0xFF0A1628),
        appBar: AppBar(
          backgroundColor: const Color(0xFF132038),
          title: Text('common.loading'.tr()),
        ),
        body: const GameScreenSkeleton(),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('common.error'.tr(args: [err.toString()]))),
      ),
    );
  }
}

/// Sağ üst köşede her zaman görünen ipucu (?) butonu
class _HintButton extends ConsumerWidget {
  final String caseId;
  const _HintButton({required this.caseId});

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _gold.withOpacity(0.15),
        border: Border.all(color: _gold.withOpacity(0.4)),
      ),
      child: IconButton(
        icon: const Icon(Icons.help_outline, color: _gold, size: 22),
        tooltip: 'Yardım Al',
        onPressed: () => _showHintDialog(context, ref),
      ),
    );
  }

  void _showHintDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _gold.withOpacity(0.3)),
        ),
        title: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: _gold, size: 24),
            const SizedBox(width: 10),
            Text(
              'YARDIM AL',
              style: GoogleFonts.poppins(
                color: _gold,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Takıldığın yerde sana yardımcı olacak bir ipucu alabilirsin.',
              style: GoogleFonts.inter(
                color: Colors.white60,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

            // Reklam izle — ücretsiz ipucu
            _HintOption(
              icon: Icons.play_circle_outline,
              title: 'Reklam İzle',
              subtitle: 'Kısa reklam izleyerek ücretsiz yardım al',
              color: _teal,
              onTap: () async {
                Navigator.pop(ctx);
                // Reklam izle → ipucu ver
                try {
                  await ref.read(creditNotifierProvider.notifier).watchAd();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('İpucu: Tıbbi verileri dikkatlice incele, gözden kaçan bir detay var!',
                          style: GoogleFonts.inter(fontSize: 12)),
                        backgroundColor: _teal.withOpacity(0.9),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                } catch (_) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reklam şu an kullanılamıyor'), backgroundColor: Colors.redAccent),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 10),

            // Kredi ile ipucu al
            _HintOption(
              icon: Icons.monetization_on_outlined,
              title: 'Kredi ile Al',
              subtitle: '10 kredi karşılığında detaylı yardım',
              color: _gold,
              onTap: () async {
                Navigator.pop(ctx);
                try {
                  await ref.read(creditNotifierProvider.notifier).purchaseHint(
                    caseId: caseId,
                    hintType: 'general',
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('İpucu: Teşhis seçeneklerini karşılaştır, semptomlarla eşleşmeyen bir detay var!',
                          style: GoogleFonts.inter(fontSize: 12)),
                        backgroundColor: _gold.withOpacity(0.9),
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('İpucu alınamadı: $e'), backgroundColor: Colors.redAccent),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HintOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _HintOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}

/// Konsültasyon butonu — uzman doktora danış
class _ConsultButton extends StatelessWidget {
  final String caseTitle;
  const _ConsultButton({required this.caseTitle});

  static const _purple = Color(0xFF9C27B0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _purple.withOpacity(0.15),
        border: Border.all(color: _purple.withOpacity(0.4)),
      ),
      child: IconButton(
        icon: const Icon(Icons.phone_in_talk, color: _purple, size: 20),
        tooltip: 'Konsültasyon',
        onPressed: () => _showConsultantPicker(context),
      ),
    );
  }

  void _showConsultantPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F1B2D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.phone_in_talk, color: _purple, size: 22),
                const SizedBox(width: 10),
                Text(
                  'KONSÜLTASYON',
                  style: GoogleFonts.poppins(
                    color: _purple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Uzman doktora danışarak ipucu alabilirsiniz (15 kredi)',
              style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
            ),
            const SizedBox(height: 12),
            ...consultants.map((c) => ListTile(
              leading: CircleAvatar(
                backgroundColor: _purple.withOpacity(0.2),
                child: const Icon(Icons.person, color: _purple, size: 20),
              ),
              title: Text(
                c.name,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                c.specialty,
                style: GoogleFonts.inter(color: _purple.withOpacity(0.7), fontSize: 11),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${c.creditCost} Kr',
                  style: GoogleFonts.robotoMono(color: _purple, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.pop(ctx);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ConsultationScreen(
                      consultant: c,
                      caseTitle: caseTitle,
                      hintText: 'Tıbbi verileri dikkatlice inceleyin, gözden kaçan bir detay olabilir.',
                    ),
                  ),
                );
              },
            )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
