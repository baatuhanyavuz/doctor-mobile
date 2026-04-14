import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_image.dart';
import '../../providers/case_providers.dart';
import '../../providers/credit_providers.dart';
import '../../providers/config_provider.dart';
import '../../providers/unlocked_cases_provider.dart';
import '../../providers/energy_provider.dart';
import '../../../data/models/case.dart';
import '../../widgets/mock_ad_dialog.dart';
import '../../widgets/no_energy_dialog.dart';
import '../store/widgets/case_purchase_dialog.dart';

/// Belirli bir zorluk seviyesindeki vakaları gösteren detay sayfası.
/// Grid düzenli, tam sayfa.
class CategoryDetailScreen extends ConsumerWidget {
  final Difficulty difficulty;

  const CategoryDetailScreen({super.key, required this.difficulty});

  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesAsync = ref.watch(allCasesProvider);
    final completedAsync = ref.watch(completedCaseIdsProvider);
    final completedIds = completedAsync.valueOrNull ?? {};
    final purchasedAsync = ref.watch(purchasedCaseIdsProvider);
    final purchasedIds = purchasedAsync.valueOrNull ?? {};
    final startedAsync = ref.watch(startedCaseIdsProvider);
    final startedIds = startedAsync.valueOrNull ?? {};
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);

    final color = _difficultyColor(difficulty);
    final label = _difficultyLabel(difficulty);
    final description = _difficultyDescription(difficulty);

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: color),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      body: casesAsync.when(
        data: (allCases) {
          final cases = allCases.where((c) => c.difficulty == difficulty).toList();

          if (cases.isEmpty) {
            return Center(
              child: Text(
                'Bu seviyede henüz vaka yok',
                style: GoogleFonts.inter(color: Colors.white54),
              ),
            );
          }

          // Progress hesapla
          final totalCount = cases.length;
          final completedCount = cases.where((c) => completedIds.contains(c.id)).length;
          final progress = totalCount == 0 ? 0.0 : completedCount / totalCount;

          return Column(
            children: [
              // Açıklama başlığı + progress bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: color.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_difficultyIcon(difficulty), color: color, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$completedCount / $totalCount tamamlandı',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                description,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${(progress * 100).toInt()}%',
                            style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white10,
                        color: color,
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              // Vaka grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: cases.length,
                  itemBuilder: (context, index) {
                    final gameCase = cases[index];
                    final isFree = gameCase.creditPrice == null || gameCase.creditPrice == 0;
                    final isOwned = completedIds.contains(gameCase.id) ||
                        purchasedIds.contains(gameCase.id) ||
                        isFree;
                    return _GridCaseCard(
                      gameCase: gameCase,
                      color: color,
                      isCompleted: completedIds.contains(gameCase.id),
                      isStarted: startedIds.contains(gameCase.id),
                      isPurchased: isOwned,
                      cdnBaseUrl: cdnBaseUrl,
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Text(
            'home.load_error'.tr(),
            style: GoogleFonts.inter(color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

/// Grid item — kompakt vaka kartı
class _GridCaseCard extends ConsumerWidget {
  final Case gameCase;
  final Color color;
  final bool isCompleted;
  final bool isStarted;
  final bool isPurchased;
  final String cdnBaseUrl;

  const _GridCaseCard({
    required this.gameCase,
    required this.color,
    required this.isCompleted,
    required this.isStarted,
    required this.isPurchased,
    required this.cdnBaseUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockedCases = ref.watch(unlockedCasesProvider);
    final isUnlocked = unlockedCases.contains(gameCase.id);

    return GestureDetector(
      onTap: () async {
        if (!isUnlocked) {
          await _showUnlockDialog(context, ref);
          return;
        }

        // Enerji kontrolü (tamamlanmış vaka tekrar oynanabilir)
        if (!isCompleted) {
          final energy = ref.read(energyProvider);
          if (!energy.hasEnergy) {
            await NoEnergyDialog.show(context);
            return;
          }
        }

        if (!isPurchased) {
          final purchased = await CasePurchaseDialog.show(context, gameCase);
          if (purchased && context.mounted) {
            if (gameCase.introText != null && gameCase.introText!.isNotEmpty) {
              context.push('/briefing/${gameCase.id}');
            } else {
              context.push('/game/${gameCase.id}');
            }
          }
          return;
        }
        if (gameCase.introText != null && gameCase.introText!.isNotEmpty) {
          context.push('/briefing/${gameCase.id}');
        } else {
          context.push('/game/${gameCase.id}');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUnlocked ? color.withOpacity(0.2) : Colors.white12,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColorFiltered(
                      colorFilter: isUnlocked
                          ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                          : const ColorFilter.matrix([
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0, 0, 0, 1, 0,
                            ]),
                      child: gameCase.coverImage.isNotEmpty
                          ? AppImage(
                              path: gameCase.coverImage,
                              cdnBaseUrl: cdnBaseUrl,
                              fit: BoxFit.cover,
                              errorWidget: Container(
                                color: color.withOpacity(0.1),
                                child: Icon(Icons.medical_services, color: color, size: 40),
                              ),
                            )
                          : Container(
                              color: color.withOpacity(0.1),
                              child: Icon(Icons.medical_services, color: color, size: 40),
                            ),
                    ),
                    // Gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            isUnlocked ? Colors.transparent : Colors.black.withOpacity(0.4),
                            const Color(0xFF132038).withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                    // KİLİTLİ — büyük orta kilit
                    if (!isUnlocked)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.5), width: 2),
                          ),
                          child: const Icon(Icons.lock, color: Color(0xFFFFD54F), size: 24),
                        ),
                      ),
                    if (isUnlocked && isCompleted)
                      Positioned(
                        top: 8, left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF66BB6A),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 12),
                        ),
                      )
                    else if (isStarted)
                      Positioned(
                        top: 8, left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB74D),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'DEVAM',
                            style: GoogleFonts.robotoMono(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    if (isUnlocked && !isPurchased)
                      Positioned(
                        top: 8, right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.attach_money, color: Color(0xFFFFD54F), size: 12),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gameCase.title,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          gameCase.shortDescription,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.white54,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          if (gameCase.creditPrice != null && gameCase.creditPrice! > 0)
                            Text(
                              '${gameCase.creditPrice} Kr',
                              style: GoogleFonts.robotoMono(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFFD54F),
                              ),
                            )
                          else
                            Text(
                              'ÜCRETSİZ',
                              style: GoogleFonts.robotoMono(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF66BB6A),
                              ),
                            ),
                          const Spacer(),
                          Icon(
                            isUnlocked ? Icons.play_circle_fill : Icons.lock,
                            color: isUnlocked ? color : const Color(0xFFFFD54F),
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showUnlockDialog(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withOpacity(0.4), width: 2),
        ),
        title: Row(
          children: [
            const Icon(Icons.lock, color: Color(0xFFFFD54F), size: 22),
            const SizedBox(width: 10),
            Text('KİLİTLİ VAKA',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFD54F),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                )),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bu vakayı açmak için iki seçenek var:',
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 14),
            Row(children: [
              Icon(Icons.check_circle_outline, color: color, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Bu kategorideki açık vakalardan birini bitir',
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 12)),
              ),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              const Icon(Icons.play_circle_fill, color: Color(0xFFFFD54F), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Reklam izleyerek hemen açabilirsin',
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 12)),
              ),
            ]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('VAZGEÇ',
                style: GoogleFonts.robotoMono(color: Colors.white38, fontSize: 11)),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.play_circle_fill, size: 18),
            label: Text('REKLAM İZLE',
                style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold, fontSize: 11)),
            onPressed: () async {
              Navigator.pop(ctx);
              final completed = await MockAdDialog.show(
                context,
                reward: 'Vaka Açılır',
                rewardIcon: Icons.lock_open,
                rewardColor: color,
              );
              if (completed) {
                final unlocked = await ref
                    .read(unlockedCasesProvider.notifier)
                    .unlockWithAd(gameCase.difficulty.name);
                if (unlocked != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Yeni vaka açıldı! 🎉',
                          style: GoogleFonts.inter(fontSize: 12)),
                      backgroundColor: color.withOpacity(0.9),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.2),
              foregroundColor: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Zorluk yardımcı metotları (home_screen'deki ile aynı) ───

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

IconData _difficultyIcon(Difficulty d) {
  switch (d) {
    case Difficulty.tutorial:
      return Icons.school;
    case Difficulty.easy:
      return Icons.medical_services_outlined;
    case Difficulty.medium:
      return Icons.local_hospital;
    case Difficulty.hard:
      return Icons.emergency;
    case Difficulty.expert:
      return Icons.biotech;
  }
}

String _difficultyDescription(Difficulty d) {
  switch (d) {
    case Difficulty.tutorial:
      return 'Oyuna giriş vakaları — temel mekanikleri öğrenin.';
    case Difficulty.easy:
      return 'Halk diliyle anlatılmış, günlük hayatta karşılaşılan vakalar.';
    case Difficulty.medium:
      return 'Orta düzey tıbbi bilgi gerektiren, biraz inceleme isteyen vakalar.';
    case Difficulty.hard:
      return 'Tıp mezunu seviyesinde vakalar — klinik karar verme gerektirir.';
    case Difficulty.expert:
      return 'Uzman seviyesinde, nadir ve karmaşık vakalar.';
  }
}
