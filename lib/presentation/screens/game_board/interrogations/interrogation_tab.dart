import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/widgets/app_image.dart';
import 'package:doctor/data/models/interview.dart';
import 'package:doctor/data/models/diagnosis.dart';
import '../../../providers/solved_contradictions_provider.dart';
import 'chat_screen.dart';

class InterrogationTab extends ConsumerWidget {
  final List<Interview> interrogations;
  final List<Diagnosis> suspects;
  final String cdnBaseUrl;

  const InterrogationTab({
    super.key,
    required this.interrogations,
    required this.suspects,
    required this.cdnBaseUrl,
  });

  Diagnosis? _findSuspect(String suspectId) {
    try {
      return suspects.firstWhere((s) => s.id == suspectId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solvedIds = ref.watch(solvedContradictionEvidenceIdsProvider);

    if (interrogations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic_off, size: 64, color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text('interrogation.no_records'.tr(), style: TextStyle(color: Colors.white.withOpacity(0.5))),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: interrogations.length,
      itemBuilder: (context, index) {
        final interrogation = interrogations[index];
        final suspect = _findSuspect(interrogation.personId);
        return _InterrogationCard(
          interrogation: interrogation,
          suspect: suspect,
          cdnBaseUrl: cdnBaseUrl,
          solvedContradictionEvidenceIds: solvedIds,
        );
      },
    );
  }
}

class _InterrogationCard extends StatefulWidget {
  final Interview interrogation;
  final Diagnosis? suspect;
  final String cdnBaseUrl;
  final Set<String> solvedContradictionEvidenceIds;

  const _InterrogationCard({
    required this.interrogation,
    required this.suspect,
    required this.cdnBaseUrl,
    required this.solvedContradictionEvidenceIds,
  });

  @override
  State<_InterrogationCard> createState() => _InterrogationCardState();
}

class _InterrogationCardState extends State<_InterrogationCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _showTranscript = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() => _isPlaying = state == PlayerState.playing);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (widget.interrogation.audioPath == null) return;
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      String path = widget.interrogation.audioPath!;
      if (path.startsWith('assets/')) path = path.substring(7);
      await _audioPlayer.play(AssetSource(path));
    }
  }

  void _openInterrogationScreen() {
    if (widget.suspect == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InterrogationScreen(
          interrogation: widget.interrogation,
          suspect: widget.suspect!,
          cdnBaseUrl: widget.cdnBaseUrl,
        ),
      ),
    );
  }

  /// Bir QA'nın çelişkisi çözülmüş mü?
  bool _isContradictionSolved(QuestionAnswer qa) {
    if (!qa.isContradiction) return false;
    if (qa.contradictionEvidenceId == null) return false;
    return widget.solvedContradictionEvidenceIds.contains(qa.contradictionEvidenceId);
  }

  /// Transcript'te çelişki var mı?
  bool get _hasContradictions =>
      widget.interrogation.transcript.any((qa) => qa.isContradiction);

  /// Çözülmemiş çelişki sayısı
  int get _unsolvedContradictionCount =>
      widget.interrogation.transcript
          .where((qa) => qa.isContradiction && !_isContradictionSolved(qa))
          .length;

  Widget _buildTranscriptQA(QuestionAnswer qa) {
    final isSolved = _isContradictionSolved(qa);
    final isContra = qa.isContradiction;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Soru
          Text(
            'S: ${qa.question}',
            style: GoogleFonts.courierPrime(
              color: Colors.white54,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          // Cevap — çelişki durumuna göre stillendirilir
          if (isContra && isSolved) ...[
            // Çelişki çözüldü — yalan cevap üstü çizili, gerçek cevap yeşil
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF00BFA5).withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF00BFA5).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Eski (yalan) cevap — üstü çizili
                  Text(
                    'C: ${qa.answer}',
                    style: GoogleFonts.courierPrime(
                      color: const Color(0xFFEF5350).withOpacity(0.5),
                      fontSize: 12,
                      height: 1.5,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xFFEF5350),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Gerçek cevap
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Color(0xFF00BFA5), size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          qa.truthReveal ?? qa.answer,
                          style: GoogleFonts.courierPrime(
                            color: const Color(0xFF00BFA5),
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else if (isContra && !isSolved) ...[
            // Çelişki henüz çözülmedi — şüpheli marker
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFB74D).withOpacity(0.06),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFFFB74D).withOpacity(0.15)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.help_outline, color: Color(0xFFFFB74D), size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'C: ${qa.answer}',
                      style: GoogleFonts.courierPrime(
                        color: const Color(0xFFFFB74D),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Normal cevap
            Text(
              'C: ${qa.answer}',
              style: GoogleFonts.courierPrime(
                color: Colors.white70,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isInteractive = widget.interrogation.isInteractive;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: widget.suspect?.photoPath != null
                  ? appImageProvider(widget.suspect!.photoPath!, widget.cdnBaseUrl)
                  : null,
              backgroundColor: Colors.grey[800],
              child: widget.suspect?.photoPath == null
                  ? const Icon(Icons.person, color: Colors.white54)
                  : null,
            ),
            title: Text(
              widget.suspect?.name ?? 'interrogation.unknown_suspect'.tr(),
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              widget.interrogation.title,
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_hasContradictions)
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _unsolvedContradictionCount > 0
                          ? const Color(0xFFFFB74D).withOpacity(0.2)
                          : const Color(0xFF00BFA5).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _unsolvedContradictionCount > 0
                              ? Icons.help_outline
                              : Icons.check_circle,
                          size: 12,
                          color: _unsolvedContradictionCount > 0
                              ? const Color(0xFFFFB74D)
                              : const Color(0xFF00BFA5),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _unsolvedContradictionCount > 0 ? '?' : '✓',
                          style: TextStyle(
                            fontSize: 10,
                            color: _unsolvedContradictionCount > 0
                                ? const Color(0xFFFFB74D)
                                : const Color(0xFF00BFA5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isInteractive)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('interrogation.interactive'.tr(), style: GoogleFonts.robotoMono(color: Colors.greenAccent, fontSize: 10)),
                  ),
              ],
            ),
          ),
          
          // Content
          if (isInteractive)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _openInterrogationScreen,
                  icon: const Icon(Icons.chat),
                  label: Text('interrogation.interrogate'.tr()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.withOpacity(0.2),
                    foregroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                ),
              ),
            )
          else ...[
            // Audio controls
            if (widget.interrogation.audioPath != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _togglePlay,
                      icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, size: 40),
                      color: Colors.greenAccent,
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Transcript toggle
            if (widget.interrogation.transcript.isNotEmpty)
              TextButton.icon(
                onPressed: () => setState(() => _showTranscript = !_showTranscript),
                icon: Icon(_showTranscript ? Icons.expand_less : Icons.expand_more),
                label: Text(_showTranscript ? 'interrogation.hide_transcript'.tr() : 'interrogation.show_transcript'.tr()),
                style: TextButton.styleFrom(foregroundColor: Colors.white54),
              ),
            
            if (_showTranscript && widget.interrogation.transcript.isNotEmpty)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final qa in widget.interrogation.transcript)
                      _buildTranscriptQA(qa),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
