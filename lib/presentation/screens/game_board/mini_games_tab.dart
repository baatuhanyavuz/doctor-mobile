import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';

/// Mini oyunları listeleyen sekme
///
/// Her mini oyun kartı olarak gösterilir.
/// Tamamlanmış oyunlar skor ile işaretlenir.
class MiniGamesTab extends ConsumerWidget {
  final String caseId;
  final List<MiniGameDef> miniGames;

  const MiniGamesTab({
    super.key,
    required this.caseId,
    required this.miniGames,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(miniGameResultsProvider(caseId));

    // Tamamlanmış mini oyun ID'leri
    final completedIds = resultsAsync.whenOrNull(
      data: (results) => {for (final r in results) r.miniGameId: r},
    ) ?? {};

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: miniGames.length,
      itemBuilder: (context, index) {
        final mg = miniGames[index];
        final result = completedIds[mg.id];
        final isCompleted = result != null;

        return _MiniGameCard(
          miniGame: mg,
          caseId: caseId,
          isCompleted: isCompleted,
          score: result?.score,
        );
      },
    );
  }
}

class _MiniGameCard extends StatelessWidget {
  final MiniGameDef miniGame;
  final String caseId;
  final bool isCompleted;
  final int? score;

  const _MiniGameCard({
    required this.miniGame,
    required this.caseId,
    required this.isCompleted,
    this.score,
  });

  bool get _isBallistic =>
      miniGame.type == 'ballistic' || miniGame.type == 'ballistic_analysis' ||
      miniGame.type == 'imaging_analysis';

  bool get _isToxicology => miniGame.type == 'toxicology';

  IconData get _icon {
    if (_isBallistic) return Icons.gps_fixed;
    return switch (miniGame.type) {
      'toxicology' => Icons.science,
      'blood_type' => Icons.bloodtype,
      'ekg_reading' => Icons.monitor_heart,
      'drug_dose' => Icons.medication,
      'microscope' => Icons.biotech,
      'auscultation' => Icons.hearing,
      'cpr_rhythm' => Icons.favorite,
      'interrogation' || 'examination' => Icons.record_voice_over,
      _ => Icons.videogame_asset,
    };
  }

  String get _typeLabel {
    if (_isBallistic) return 'mini_games.ballistic'.tr();
    return switch (miniGame.type) {
      'toxicology' => 'Toksikoloji Analizi',
      'blood_type' => 'Kan Grubu Tespiti',
      'ekg_reading' => 'EKG Okuma',
      'drug_dose' => 'İlaç Dozu Hesaplama',
      'microscope' => 'Mikroskop Analizi',
      'auscultation' => 'Oskültasyon',
      'cpr_rhythm' => 'CPR Ritim',
      'interrogation' || 'examination' => 'mini_games.interrogation_game'.tr(),
      _ => 'mini_games.generic'.tr(),
    };
  }

  Color get _accentColor {
    if (_isBallistic) return const Color(0xFFCF6679);
    return switch (miniGame.type) {
      'toxicology' => const Color(0xFF9C27B0),
      'blood_type' => const Color(0xFFB71C1C),
      'ekg_reading' => const Color(0xFF4CAF50),
      'drug_dose' => const Color(0xFF2196F3),
      'microscope' => const Color(0xFF00BCD4),
      'auscultation' => const Color(0xFFFF9800),
      'cpr_rhythm' => const Color(0xFFE91E63),
      'interrogation' || 'examination' => const Color(0xFF03DAC6),
      _ => const Color(0xFFD4A847),
    };
  }

  void _startMiniGame(BuildContext context) {
    final route = switch (miniGame.type) {
      'ballistic' || 'ballistic_analysis' || 'imaging_analysis' => '/minigame/ballistic/$caseId',
      'toxicology' => '/minigame/toxicology/$caseId',
      'blood_type' => '/minigame/blood_type/$caseId',
      'ekg_reading' => '/minigame/ekg_reading/$caseId',
      'drug_dose' => '/minigame/drug_dose/$caseId',
      'microscope' => '/minigame/microscope/$caseId',
      'auscultation' => '/minigame/auscultation/$caseId',
      'cpr_rhythm' => '/minigame/cpr_rhythm/$caseId',
      _ => '/minigame/interrogation/$caseId',
    };
    context.push(route, extra: miniGame);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFFD4A847).withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _accentColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_icon, color: _accentColor, size: 24),
            ),
            title: Text(
              miniGame.title.isNotEmpty ? miniGame.title : _typeLabel,
              style: GoogleFonts.specialElite(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              _typeLabel,
              style: GoogleFonts.robotoMono(
                color: _accentColor.withOpacity(0.7),
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
            trailing: isCompleted
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4A847).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$score/1000',
                      style: GoogleFonts.robotoMono(
                        color: const Color(0xFFD4A847),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
          ),

          // Açıklama
          if (miniGame.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                miniGame.description,
                style: GoogleFonts.merriweather(
                  color: Colors.white54,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),

          // Süre bilgisi + Buton
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                if (miniGame.timeLimitSeconds != null) ...[
                  Icon(Icons.timer, size: 14, color: Colors.white38),
                  const SizedBox(width: 4),
                  Text(
                    '${miniGame.timeLimitSeconds}s',
                    style: GoogleFonts.robotoMono(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: isCompleted ? null : () => _startMiniGame(context),
                  icon: Icon(isCompleted ? Icons.check : Icons.play_arrow, size: 18),
                  label: Text(
                    isCompleted ? 'common.completed'.tr() : 'common.start'.tr(),
                    style: GoogleFonts.specialElite(fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted
                        ? Colors.grey[800]
                        : _accentColor.withOpacity(0.2),
                    foregroundColor: isCompleted
                        ? Colors.white38
                        : _accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: isCompleted
                            ? Colors.transparent
                            : _accentColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
