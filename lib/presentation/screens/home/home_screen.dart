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
import '../../widgets/shimmer_loading.dart';
import '../../widgets/energy_indicator.dart';
import '../../widgets/mock_ad_dialog.dart';
import '../../widgets/no_energy_dialog.dart';
import '../store/widgets/case_purchase_dialog.dart';
import '../onboarding/difficulty_onboarding_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // İlk açılışta onboarding'i bir kez göster
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final shown = await DifficultyOnboardingScreen.hasBeenShown();
      if (!shown && mounted) {
        context.push('/difficulty-onboarding');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final casesAsync = ref.watch(allCasesProvider);
    final completedAsync = ref.watch(completedCaseIdsProvider);
    final completedIds = completedAsync.valueOrNull ?? {};
    final purchasedAsync = ref.watch(purchasedCaseIdsProvider);
    final purchasedIds = purchasedAsync.valueOrNull ?? {};
    final startedAsync = ref.watch(startedCaseIdsProvider);
    final startedIds = startedAsync.valueOrNull ?? {};
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        title: Text(
          'home.title'.tr(),
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: EnergyIndicator(),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF00BFA5),
              size: 24,
            ),
            tooltip: 'home.profile'.tr(),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: casesAsync.when(
        data: (allCases) {
          if (allCases.isEmpty) {
            return Center(
              child: Text(
                'home.no_cases'.tr(),
                style: GoogleFonts.inter(color: Colors.white54),
              ),
            );
          }

          // Vakaları zorluğa göre grupla
          final grouped = <Difficulty, List<Case>>{};
          for (final c in allCases) {
            grouped.putIfAbsent(c.difficulty, () => []).add(c);
          }

          // Gösterim sırası
          const order = [
            Difficulty.tutorial,
            Difficulty.easy,
            Difficulty.medium,
            Difficulty.hard,
            Difficulty.expert,
          ];
          final sections = order
              .where((d) => (grouped[d]?.isNotEmpty ?? false))
              .map((d) => MapEntry(d, grouped[d]!))
              .toList();

          return RefreshIndicator(
            color: const Color(0xFF00BFA5),
            backgroundColor: const Color(0xFF132038),
            onRefresh: () async {
              ref.invalidate(allCasesProvider);
              ref.invalidate(completedCaseIdsProvider);
              ref.invalidate(purchasedCaseIdsProvider);
              ref.invalidate(creditNotifierProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              itemCount: sections.length,
              itemBuilder: (context, sectionIndex) {
                final entry = sections[sectionIndex];
                return _DifficultySection(
                  difficulty: entry.key,
                  cases: entry.value,
                  completedIds: completedIds,
                  startedIds: startedIds,
                  purchasedIds: purchasedIds,
                  cdnBaseUrl: cdnBaseUrl,
                );
              },
            ),
          );
        },
        loading: () => const HomeScreenSkeleton(),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Color(0xFFEF5350), size: 48),
              const SizedBox(height: 16),
              Text(
                'home.load_error'.tr(),
                style: GoogleFonts.inter(color: Colors.white70),
              ),
              Text(
                err.toString(),
                style: const TextStyle(color: Colors.white30, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  final Case gameCase;
  final bool isCompleted;
  final bool isStarted;
  final bool isPurchased;
  final String cdnBaseUrl;

  const _CaseCard({
    required this.gameCase,
    this.isCompleted = false,
    this.isStarted = false,
    this.isPurchased = true,
    required this.cdnBaseUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCompleted ? const Color(0xFF66BB6A).withOpacity(0.4) : Colors.white10,
          width: isCompleted ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.push('/preview/${gameCase.id}'),
        borderRadius: BorderRadius.circular(4),
        child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sol taraf: Görsel Placeholder
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: appImageProvider(gameCase.coverImage, cdnBaseUrl),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.medical_services,
                  color: isCompleted
                      ? const Color(0xFF66BB6A).withOpacity(0.5)
                      : isStarted
                          ? const Color(0xFFFFD54F).withOpacity(0.5)
                          : isPurchased
                              ? Colors.white.withOpacity(0.2)
                              : const Color(0xFF42A5F5).withOpacity(0.5),
                  size: 40,
                ),
              ),
            ),
            
            // Sağ taraf: Bilgiler
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Başlık
                    Text(
                      gameCase.title.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Zorluk ve Fiyat
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _StatusBadge(
                          text: _difficultyLabel(gameCase.difficulty),
                          color: _difficultyColor(gameCase.difficulty),
                        ),
                        if (gameCase.creditPrice != null && gameCase.creditPrice! > 0)
                          _StatusBadge(
                            text: '${gameCase.creditPrice} ${'home.credit'.tr()}',
                            color: const Color(0xFFFFD54F),
                          )
                        else
                          _StatusBadge(
                            text: 'common.free'.tr(),
                            color: Colors.green.withOpacity(0.7),
                          ),
                        if (isCompleted)
                          _StatusBadge(
                            text: 'home.solved'.tr(),
                            color: Colors.greenAccent,
                          ),
                        if (!isPurchased)
                          _StatusBadge(
                            text: 'home.locked'.tr(),
                            color: const Color(0xFFEF5350),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Özet
                    Text(
                      gameCase.shortDescription,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white54,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    
                    // Buton
                    Align(
                      alignment: Alignment.centerRight,
                      child: isPurchased
                          ? TextButton.icon(
                              onPressed: () {
                                if (gameCase.introText != null && gameCase.introText!.isNotEmpty) {
                                  context.push('/briefing/${gameCase.id}');
                                } else {
                                  context.push('/game/${gameCase.id}');
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF00BFA5),
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.person_add, size: 18),
                              label: Text(
                                'home.open_file'.tr(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : TextButton.icon(
                              onPressed: () async {
                                final purchased = await CasePurchaseDialog.show(context, gameCase);
                                if (purchased && context.mounted) {
                                  if (gameCase.introText != null && gameCase.introText!.isNotEmpty) {
                                    context.push('/briefing/${gameCase.id}');
                                  } else {
                                    context.push('/game/${gameCase.id}');
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFFFFD54F),
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: const Icon(Icons.lock_rounded, size: 18),
                              label: Text(
                                'home.buy'.tr(),
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
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
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: GoogleFonts.robotoMono(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Zorluk bölümü — Netflix tarzı yatay scroll kart listesi
class _DifficultySection extends ConsumerWidget {
  final Difficulty difficulty;
  final List<Case> cases;
  final Set<String> completedIds;
  final Set<String> startedIds;
  final Set<String> purchasedIds;
  final String cdnBaseUrl;

  const _DifficultySection({
    required this.difficulty,
    required this.cases,
    required this.completedIds,
    required this.startedIds,
    required this.purchasedIds,
    required this.cdnBaseUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _difficultyColor(difficulty);
    final label = _difficultyLabel(difficulty);
    final unlockedSet = ref.watch(unlockedCasesProvider);

    // Priority bazlı sıralama:
    // 0 = Devam eden (en başta)
    // 1 = Açık & oynanmamış
    // 2 = Kilitli
    // 3 = Tamamlanmış (en sonda)
    int priority(Case c) {
      final unlocked = unlockedSet.contains(c.id);
      final completed = completedIds.contains(c.id);
      final started = startedIds.contains(c.id);
      if (completed) return 3;
      if (started) return 0;
      if (unlocked) return 1;
      return 2;
    }

    final orderedCases = [...cases]..sort((a, b) {
      final pa = priority(a);
      final pb = priority(b);
      if (pa != pb) return pa - pb;
      // Aynı priority içinde ID'ye göre sırala
      return a.id.compareTo(b.id);
    });

    final unlockedCount = cases.where((c) => unlockedSet.contains(c.id)).length;
    final lockedCount = cases.length - unlockedCount;

    void openCategory() {
      context.push('/category/${difficulty.name}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section başlığı — tamamı tıklanabilir
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: openCategory,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
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
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${cases.length}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'TÜMÜNÜ GÖR',
                    style: GoogleFonts.robotoMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: color.withOpacity(0.8),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: color, size: 12),
                ],
              ),
            ),
          ),
        ),

        // Kaydırma ipucu (küçük puntoyla)
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 16, 4),
          child: Row(
            children: [
              Icon(Icons.swipe_left, color: Colors.white24, size: 12),
              const SizedBox(width: 4),
              Text(
                'Kartları yana kaydırın',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.white38,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),

        // Yatay scroll — TÜM vakalar sıralı (tamamlanan > açık > kilitli)
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: orderedCases.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              // Son item: "TÜMÜNÜ GÖR" kartı
              if (index == orderedCases.length) {
                return _SeeAllCard(
                  color: color,
                  count: cases.length,
                  lockedCount: lockedCount,
                  label: label,
                  onTap: openCategory,
                );
              }
              final gameCase = orderedCases[index];
              final isFree = gameCase.creditPrice == null || gameCase.creditPrice == 0;
              final isOwned = completedIds.contains(gameCase.id) ||
                  purchasedIds.contains(gameCase.id) ||
                  isFree;
              return _HorizontalCaseCard(
                gameCase: gameCase,
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
  }
}

/// Yatay scroll sonunda "TÜMÜNÜ GÖR" kartı
class _SeeAllCard extends StatelessWidget {
  final Color color;
  final int count;
  final int lockedCount;
  final String label;
  final VoidCallback onTap;

  const _SeeAllCard({
    required this.color,
    required this.count,
    this.lockedCount = 0,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.grid_view_rounded, color: color, size: 40),
            const SizedBox(height: 12),
            if (lockedCount > 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD54F).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock, color: Color(0xFFFFD54F), size: 11),
                    const SizedBox(width: 4),
                    Text(
                      '$lockedCount kilitli',
                      style: GoogleFonts.robotoMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD54F),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              'TÜMÜNÜ GÖR',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$count vaka',
              style: GoogleFonts.robotoMono(
                fontSize: 11,
                color: color.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Netflix tarzı yatay kart — sabit genişlik, görsel ağırlıklı
class _HorizontalCaseCard extends ConsumerWidget {
  final Case gameCase;
  final bool isCompleted;
  final bool isStarted;
  final bool isPurchased;
  final String cdnBaseUrl;

  const _HorizontalCaseCard({
    required this.gameCase,
    required this.isCompleted,
    required this.isStarted,
    required this.isPurchased,
    required this.cdnBaseUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = _difficultyColor(gameCase.difficulty);
    final unlockedCases = ref.watch(unlockedCasesProvider);
    final isUnlocked = unlockedCases.contains(gameCase.id);

    return GestureDetector(
      onTap: () async {
        if (!isUnlocked) {
          // Kilitli — reklam izle dialogu
          await _showUnlockDialog(context, ref);
          return;
        }

        // Tamamlanmış vakayı tekrar oynayabilir, enerji kontrolü yok
        if (!isCompleted) {
          // Enerji kontrolü
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
        width: 170,
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUnlocked ? color.withOpacity(0.2) : Colors.white12,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kapak görseli
              SizedBox(
                height: 130,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Görsel — kilitliyse grayscale + dim
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
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            isUnlocked ? Colors.transparent : Colors.black.withOpacity(0.4),
                            const Color(0xFF132038).withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),
                    // Durum badge'leri (sol üst)
                    if (isUnlocked && isCompleted)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF66BB6A),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check, color: Colors.white, size: 12),
                              const SizedBox(width: 2),
                              Text(
                                'TAMAM',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (isUnlocked && isStarted)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB74D),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'DEVAM EDİYOR',
                            style: GoogleFonts.robotoMono(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    // KİLİTLİ — büyük orta kilit ikonu
                    if (!isUnlocked)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.5), width: 2),
                          ),
                          child: const Icon(
                            Icons.lock,
                            color: Color(0xFFFFD54F),
                            size: 28,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Metinler
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
                      const Spacer(),
                      Row(
                        children: [
                          // Fiyat veya ücretsiz
                          if (gameCase.creditPrice != null && gameCase.creditPrice! > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFD54F).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${gameCase.creditPrice} Kr',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFFFD54F),
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF66BB6A).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'ÜCRETSİZ',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF66BB6A),
                                ),
                              ),
                            ),
                          const Spacer(),
                          Icon(Icons.play_circle_fill, color: color, size: 22),
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

  /// Kilitli vaka için açma dialogu
  Future<void> _showUnlockDialog(BuildContext context, WidgetRef ref) async {
    final color = _difficultyColor(gameCase.difficulty);
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
            Icon(Icons.lock, color: const Color(0xFFFFD54F), size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'KİLİTLİ VAKA',
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFD54F),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bu vakayı açmak için iki seçenek var:',
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: color, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Bu kategorideki açık vakalardan birini bitir',
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.play_circle_fill, color: Color(0xFFFFD54F), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Reklam izleyerek hemen açabilirsin',
                    style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                  ),
                ),
              ],
            ),
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
                      content: Text(
                        'Yeni vaka açıldı! 🎉',
                        style: GoogleFonts.inter(fontSize: 12),
                      ),
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

/// Zorluk seviyesine özel etiket metni
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

/// Zorluk seviyesine özel renk
Color _difficultyColor(Difficulty d) {
  switch (d) {
    case Difficulty.tutorial:
      return const Color(0xFF81C784); // Açık yeşil
    case Difficulty.easy:
      return const Color(0xFF66BB6A); // Yeşil — halk dili
    case Difficulty.medium:
      return const Color(0xFFFFB74D); // Amber — biraz üst seviye
    case Difficulty.hard:
      return const Color(0xFFEF5350); // Kırmızı — tıp mezunu seviye
    case Difficulty.expert:
      return const Color(0xFFAB47BC); // Mor — uzman seviye
  }
}
