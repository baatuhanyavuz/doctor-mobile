import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/widgets/app_image.dart';
import '../../data/models/case.dart';
import 'package:doctor/data/models/medical_data.dart';
import '../providers/case_providers.dart';
import '../providers/credit_providers.dart';
import '../providers/config_provider.dart';
import '../screens/store/widgets/case_purchase_dialog.dart';

/// Vaka önizleme/detay ekranı
///
/// Satın almadan önce kullanıcıya vakanın detaylarını gösterir:
/// kapak görseli, hikaye özeti, kurban bilgisi, teşhis/tıbbi veri sayıları,
/// mini oyun tipleri, zorluk, tahmini süre.
class CasePreviewScreen extends ConsumerWidget {
  final String caseId;

  const CasePreviewScreen({super.key, required this.caseId});

  static const _bgColor = Color(0xFF0D0D0D);
  static const _surface = Color(0xFF1E1E1E);
  static const _gold = Color(0xFFD4A847);
  static const _teal = Color(0xFF03DAC6);
  static const _crimson = Color(0xFFCF6679);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caseAsync = ref.watch(caseByIdProvider(caseId));
    final completedIds = ref.watch(completedCaseIdsProvider).valueOrNull ?? {};
    final purchasedIds = ref.watch(purchasedCaseIdsProvider).valueOrNull ?? {};
    final cdnBaseUrl = ref.watch(cdnBaseUrlProvider);

    return Scaffold(
      backgroundColor: _bgColor,
      body: caseAsync.when(
        data: (gameCase) {
          if (gameCase == null) {
            return const Center(
              child: Text('Vaka bulunamadı', style: TextStyle(color: Colors.white54)),
            );
          }

          final isFree = gameCase.creditPrice == null || gameCase.creditPrice == 0;
          final isOwned = completedIds.contains(gameCase.id) ||
              purchasedIds.contains(gameCase.id) ||
              isFree;
          final isCompleted = completedIds.contains(gameCase.id);

          return CustomScrollView(
            slivers: [
              // ─── Hero Image ──────────────────────────────────
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: _bgColor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 20),
                  onPressed: () => context.pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                        image: appImageProvider(gameCase.coverImage, cdnBaseUrl),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: _surface),
                      ),
                      // Gradient overlay
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xFF0D0D0D)],
                            stops: [0.4, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Content ─────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Başlık
                      Text(
                        gameCase.title.toUpperCase(),
                        style: GoogleFonts.specialElite(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 1.5,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Badges
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _Badge(
                            icon: Icons.signal_cellular_alt,
                            text: _difficultyLabel(gameCase.difficulty),
                            color: _difficultyColor(gameCase.difficulty),
                          ),
                          if (gameCase.creditPrice != null && gameCase.creditPrice! > 0)
                            _Badge(
                              icon: Icons.monetization_on_outlined,
                              text: '${gameCase.creditPrice} Kredi',
                              color: _gold,
                            )
                          else
                            _Badge(
                              icon: Icons.card_giftcard,
                              text: 'Ücretsiz',
                              color: Colors.greenAccent,
                            ),
                          if (gameCase.diagnoses.isNotEmpty)
                            _Badge(
                              icon: Icons.people_outline,
                              text: '${gameCase.diagnoses.length} Teşhis',
                              color: Colors.white54,
                            ),
                          if (gameCase.medicalData.isNotEmpty)
                            _Badge(
                              icon: Icons.local_hospital,
                              text: '${gameCase.medicalData.length} Tıbbi Veri',
                              color: Colors.white54,
                            ),
                          if (gameCase.miniGames.isNotEmpty)
                            _Badge(
                              icon: Icons.gamepad_outlined,
                              text: '${gameCase.miniGames.length} Mini Oyun',
                              color: Colors.white54,
                            ),
                          if (isCompleted)
                            _Badge(
                              icon: Icons.check_circle_outline,
                              text: 'Çözüldü',
                              color: Colors.greenAccent,
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ─── Hikaye Özeti ─────────────────────────
                      if (gameCase.introText != null && gameCase.introText!.isNotEmpty) ...[
                        _SectionTitle(icon: Icons.auto_stories, title: 'DOSYA ÖZETİ'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _gold.withOpacity(0.15)),
                          ),
                          child: Text(
                            gameCase.introText!,
                            style: GoogleFonts.merriweather(
                              fontSize: 13,
                              color: Colors.white70,
                              height: 1.7,
                            ),
                            maxLines: 8,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // ─── Kurban Bilgisi ───────────────────────
                      if (gameCase.patient.name.isNotEmpty) ...[
                        _SectionTitle(icon: Icons.person_off_outlined, title: 'KURBAN'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _crimson.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gameCase.patient.name,
                                style: GoogleFonts.specialElite(
                                  fontSize: 18,
                                  color: _crimson,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (gameCase.patient.age != null)
                                _InfoRow(label: 'Yaş', value: '${gameCase.patient.age}'),
                              if (gameCase.patient.occupation != null)
                                _InfoRow(label: 'Meslek', value: gameCase.patient.occupation!),
                              if (gameCase.patient.chiefComplaint != null)
                                _InfoRow(label: 'Ölüm Sebebi', value: gameCase.patient.chiefComplaint!),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // ─── Olay Yeri ────────────────────────────
                      if (gameCase.clinic != null && gameCase.clinic!.isNotEmpty) ...[
                        _SectionTitle(icon: Icons.location_on_outlined, title: 'OLAY YERİ'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Text(
                            gameCase.clinic!,
                            style: GoogleFonts.merriweather(
                              fontSize: 13,
                              color: Colors.white60,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // ─── Neler Var ────────────────────────────
                      _SectionTitle(icon: Icons.inventory_2_outlined, title: 'DOSYA İÇERİĞİ'),
                      const SizedBox(height: 8),
                      _ContentGrid(gameCase: gameCase),
                      const SizedBox(height: 24),

                      // ─── Bulanık Tıbbi Veri Önizleme ───────────────
                      if (gameCase.medicalData.length >= 2 && !isOwned) ...[
                        _SectionTitle(icon: Icons.visibility_off_outlined, title: 'GİZLİ KANITLAR'),
                        const SizedBox(height: 8),
                        _BlurredEvidencePreview(evidences: gameCase.medicalData),
                        const SizedBox(height: 24),
                      ],

                      // ─── Benzer Vakalar ───────────────────────
                      _SimilarCases(
                        currentCaseId: gameCase.id,
                        difficulty: gameCase.difficulty,
                        cdnBaseUrl: cdnBaseUrl,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: _gold),
        ),
        error: (err, _) => Center(
          child: Text('Hata: $err', style: const TextStyle(color: _crimson)),
        ),
      ),

      // ─── Bottom Bar (Satın Al / Dosyayı Aç) ─────────────────
      bottomNavigationBar: caseAsync.whenOrNull(
        data: (gameCase) {
          if (gameCase == null) return null;

          final isFree = gameCase.creditPrice == null || gameCase.creditPrice == 0;
          final isOwned = completedIds.contains(gameCase.id) ||
              purchasedIds.contains(gameCase.id) ||
              isFree;

          return Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            decoration: BoxDecoration(
              color: _surface,
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
            ),
            child: isOwned
                ? SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (gameCase.introText != null && gameCase.introText!.isNotEmpty) {
                          context.push('/briefing/${gameCase.id}');
                        } else {
                          context.push('/game/${gameCase.id}');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _teal.withOpacity(0.15),
                        foregroundColor: _teal,
                        side: BorderSide(color: _teal.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.folder_open),
                      label: Text(
                        'DAVAYI AÇ',
                        style: GoogleFonts.specialElite(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final purchased = await CasePurchaseDialog.show(context, gameCase);
                        if (purchased && context.mounted) {
                          ref.invalidate(purchasedCaseIdsProvider);
                          ref.invalidate(creditNotifierProvider);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _gold.withOpacity(0.15),
                        foregroundColor: _gold,
                        side: BorderSide(color: _gold.withOpacity(0.4)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.lock_open),
                      label: Text(
                        'SATIN AL — ${gameCase.creditPrice ?? 0} KREDİ',
                        style: GoogleFonts.specialElite(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  String _difficultyLabel(Difficulty d) {
    switch (d) {
      case Difficulty.tutorial: return 'EĞİTİM';
      case Difficulty.easy: return 'KOLAY';
      case Difficulty.medium: return 'ORTA';
      case Difficulty.hard: return 'ZOR';
      case Difficulty.expert: return 'UZMAN';
    }
  }

  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.tutorial: return Colors.blueAccent;
      case Difficulty.easy: return Colors.greenAccent;
      case Difficulty.medium: return Colors.orangeAccent;
      case Difficulty.hard: return _crimson;
      case Difficulty.expert: return Colors.purpleAccent;
    }
  }
}

// ─── Widgets ─────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _Badge({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: CasePreviewScreen._gold.withOpacity(0.7)),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.specialElite(
            fontSize: 14,
            color: CasePreviewScreen._gold.withOpacity(0.7),
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.robotoMono(fontSize: 11, color: Colors.white30),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.merriweather(fontSize: 12, color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentGrid extends StatelessWidget {
  final Case gameCase;

  const _ContentGrid({required this.gameCase});

  @override
  Widget build(BuildContext context) {
    final items = <_ContentItem>[];

    if (gameCase.diagnoses.isNotEmpty) {
      items.add(_ContentItem(
        icon: Icons.people_outline,
        count: gameCase.diagnoses.length,
        label: 'Teşhis',
        color: Colors.orangeAccent,
      ));
    }
    if (gameCase.medicalData.isNotEmpty) {
      items.add(_ContentItem(
        icon: Icons.local_hospital,
        count: gameCase.medicalData.length,
        label: 'Tıbbi Veri',
        color: CasePreviewScreen._teal,
      ));
    }
    if (gameCase.interviews.isNotEmpty) {
      items.add(_ContentItem(
        icon: Icons.question_answer_outlined,
        count: gameCase.interviews.length,
        label: 'Sorgulama',
        color: Colors.blueAccent,
      ));
    }
    if (gameCase.miniGames.isNotEmpty) {
      items.add(_ContentItem(
        icon: Icons.gamepad_outlined,
        count: gameCase.miniGames.length,
        label: 'Mini Oyun',
        color: Colors.purpleAccent,
      ));
    }
    if (gameCase.deductions.isNotEmpty) {
      items.add(_ContentItem(
        icon: Icons.hub_outlined,
        count: gameCase.deductions.length,
        label: 'Çıkarım',
        color: CasePreviewScreen._gold,
      ));
    }

    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.3,
      children: items.map((item) => Container(
        decoration: BoxDecoration(
          color: CasePreviewScreen._surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: item.color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: item.color.withOpacity(0.7), size: 24),
            const SizedBox(height: 6),
            Text(
              '${item.count}',
              style: GoogleFonts.specialElite(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            Text(
              item.label,
              style: GoogleFonts.robotoMono(
                fontSize: 9,
                color: Colors.white38,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}

class _ContentItem {
  final IconData icon;
  final int count;
  final String label;
  final Color color;

  _ContentItem({
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════
// BULANIK KANIT ÖNİZLEME
// ═══════════════════════════════════════════════════════

class _BlurredEvidencePreview extends StatelessWidget {
  final List<MedicalData> evidences;

  const _BlurredEvidencePreview({required this.evidences});

  @override
  Widget build(BuildContext context) {
    // İlk 2 tıbbi veriyi göster
    final preview = evidences.take(2).toList();

    return Column(
      children: preview.map((ev) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: CasePreviewScreen._surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CasePreviewScreen._crimson.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            // Bulanık ikon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: CasePreviewScreen._crimson.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _evidenceIcon(ev.type),
                color: CasePreviewScreen._crimson.withOpacity(0.5),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ev.title,
                    style: GoogleFonts.specialElite(
                      fontSize: 14,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '████████ ██████ ████ ██████████',
                    style: GoogleFonts.merriweather(
                      fontSize: 11,
                      color: Colors.white12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.lock_outline, color: CasePreviewScreen._crimson.withOpacity(0.4), size: 18),
          ],
        ),
      )).toList(),
    );
  }

  IconData _evidenceIcon(MedicalDataType type) {
    switch (type) {
      case MedicalDataType.photo: return Icons.photo_camera_outlined;
      case MedicalDataType.document: return Icons.description_outlined;
      case MedicalDataType.audio: return Icons.headphones_outlined;
      case MedicalDataType.video: return Icons.videocam_outlined;
      case MedicalDataType.phone: return Icons.phone_android_outlined;
      case MedicalDataType.labSample: return Icons.science_outlined;
      case MedicalDataType.object: return Icons.category_outlined;
      default: return Icons.help_outline;
    }
  }
}

// ═══════════════════════════════════════════════════════
// BENZER VAKALAR
// ═══════════════════════════════════════════════════════

class _SimilarCases extends ConsumerWidget {
  final String currentCaseId;
  final Difficulty difficulty;
  final String cdnBaseUrl;

  const _SimilarCases({
    required this.currentCaseId,
    required this.difficulty,
    required this.cdnBaseUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final casesAsync = ref.watch(allCasesProvider);

    return casesAsync.when(
      data: (cases) {
        // Aynı zorlukta olanları önce, sonra diğerlerini göster
        final similar = cases
            .where((c) => c.id != currentCaseId)
            .toList()
          ..sort((a, b) {
            if (a.difficulty == difficulty && b.difficulty != difficulty) return -1;
            if (a.difficulty != difficulty && b.difficulty == difficulty) return 1;
            return 0;
          });

        final show = similar.take(4).toList();
        if (show.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(icon: Icons.folder_copy_outlined, title: 'BENZER DOSYALAR'),
            const SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: show.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final c = show[index];
                  return GestureDetector(
                    onTap: () => context.push('/preview/${c.id}'),
                    child: Container(
                      width: 130,
                      decoration: BoxDecoration(
                        color: CasePreviewScreen._surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: c.difficulty == difficulty
                              ? CasePreviewScreen._gold.withOpacity(0.25)
                              : Colors.white10,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Kapak görseli
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: Image(
                                image: appImageProvider(c.coverImage, cdnBaseUrl),
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Colors.grey[900],
                                  child: const Icon(Icons.image_not_supported, color: Colors.white12, size: 24),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.title,
                                  style: GoogleFonts.specialElite(
                                    fontSize: 11,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      c.difficulty.name.toUpperCase(),
                                      style: GoogleFonts.robotoMono(
                                        fontSize: 8,
                                        color: Colors.orangeAccent.withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      c.creditPrice != null && c.creditPrice! > 0
                                          ? '${c.creditPrice} Kr'
                                          : 'Ücretsiz',
                                      style: GoogleFonts.robotoMono(
                                        fontSize: 8,
                                        color: CasePreviewScreen._gold.withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
