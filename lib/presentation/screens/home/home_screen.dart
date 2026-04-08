import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_image.dart';
import '../../providers/case_providers.dart';
import '../../providers/credit_providers.dart';
import '../../providers/config_provider.dart';
import '../../../data/models/case.dart';
import '../../widgets/shimmer_loading.dart';
import '../store/widgets/case_purchase_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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

    return Scaffold(
      // Medikal tema: Koyu lacivert arka plan
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        title: Text(
          'home.title'.tr(),
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Color(0xFF00BFA5),
              size: 26,
            ),
            tooltip: 'home.profile'.tr(),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: casesAsync.when(
        data: (cases) {
          if (cases.isEmpty) {
            return Center(
              child: Text(
                'home.no_cases'.tr(),
                style: GoogleFonts.inter(color: Colors.white54),
              ),
            );
          }
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
              padding: const EdgeInsets.all(16),
              itemCount: cases.length,
              itemBuilder: (context, index) {
                final gameCase = cases[index];
                final isFree = gameCase.creditPrice == null || gameCase.creditPrice == 0;
                final isOwned = completedIds.contains(gameCase.id) ||
                    purchasedIds.contains(gameCase.id) ||
                    isFree;
                return _CaseCard(
                  gameCase: gameCase,
                  isCompleted: completedIds.contains(gameCase.id),
                  isStarted: startedIds.contains(gameCase.id),
                  isPurchased: isOwned,
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
                          text: gameCase.difficulty.name.toUpperCase(),
                          color: Colors.orangeAccent.withOpacity(0.7),
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
