import 'dart:math';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';
import 'scoring_utils.dart';

/// Goruntuleme Analizi Mini Oyunu
///
/// Oyuncu tibbi goruntude anomaliyi analiz ederek
/// anomali noktasini (X, Y) ve acisini tahmin eder.
class BallisticScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const BallisticScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<BallisticScreen> createState() => _BallisticScreenState();
}

class _BallisticScreenState extends ConsumerState<BallisticScreen>
    with TickerProviderStateMixin {
  // Oyuncu tahmini
  Offset? _guessPosition;
  double _guessAngle = 0;
  bool _isSubmitting = false;
  bool _showHints = false;
  int _currentHint = 0;

  // Zamanlayıcı
  late int _remainingSeconds;
  late final AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 60;
    _timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _remainingSeconds),
    )..addListener(() {
        final elapsed = (_timerController.value * _remainingSeconds).floor();
        setState(() {
          _remainingSeconds = (widget.miniGame.timeLimitSeconds ?? 60) - elapsed;
        });
        if (_remainingSeconds <= 0 && !_isSubmitting) {
          _submitResult();
        }
      });
    _timerController.forward();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  Future<void> _submitResult() async {
    if (_isSubmitting) return;
    _timerController.stop();

    setState(() => _isSubmitting = true);

    final guessX = _guessPosition?.dx ?? 0;
    final guessY = _guessPosition?.dy ?? 0;

    try {
      // Skoru Flutter'da hesapla
      final score = ScoringUtils.calculateBallisticScore(
        guessX: guessX,
        guessY: guessY,
        guessAngle: _guessAngle,
        correctX: widget.miniGame.correctX ?? 0,
        correctY: widget.miniGame.correctY ?? 0,
        correctAngle: widget.miniGame.correctAngle ?? 0,
        tolerance: widget.miniGame.tolerance ?? 120,
      );

      final repo = ref.read(miniGameRepositoryProvider);
      final result = await repo.submitBallistic(
        caseId: widget.caseId,
        miniGameId: widget.miniGame.id,
        score: score,
      );

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => MiniGameResultDialog(
            result: result,
            onClose: () {
              Navigator.of(context).pop(); // dialog
              Navigator.of(context).pop(); // screen
            },
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('common.error'.tr(args: [e.toString()])), backgroundColor: Colors.red),
        );
        setState(() => _isSubmitting = false);
        _timerController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          widget.miniGame.title.isNotEmpty ? widget.miniGame.title : 'mini_games.ballistic_title'.tr(),
          style: GoogleFonts.poppins(fontSize: 18),
        ),
        actions: [
          // Zamanlayıcı
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _remainingSeconds <= 10
                  ? Colors.red.withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.timer,
                    size: 16,
                    color: _remainingSeconds <= 10 ? Colors.red : Colors.white70),
                const SizedBox(width: 4),
                Text(
                  '${_remainingSeconds}s',
                  style: GoogleFonts.robotoMono(
                    color: _remainingSeconds <= 10 ? Colors.red : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Açıklama
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF0E1A30),
            child: Text(
              widget.miniGame.description.isNotEmpty
                  ? widget.miniGame.description
                  : 'Tibbi goruntudeki anomaliyi analiz et ve konumunu belirle.',
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),

          // Sahne alanı — dokunarak konum seçme
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                if (_isSubmitting) return;
                setState(() {
                  _guessPosition = details.localPosition;
                });
              },
              child: Container(
                width: double.infinity,
                color: const Color(0xFF0A1628),
                child: CustomPaint(
                  painter: _BallisticScenePainter(
                    guessPosition: _guessPosition,
                    guessAngle: _guessAngle,
                    impactPoint: widget.miniGame.impactPoint != null
                        ? Offset(
                            (widget.miniGame.impactPoint!['x'] as num?)?.toDouble() ?? 0,
                            (widget.miniGame.impactPoint!['y'] as num?)?.toDouble() ?? 0,
                          )
                        : null,
                    trajectoryAngle: widget.miniGame.bulletTrajectoryAngle,
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
          ),

          // Açı ayarlama slider
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF132038),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.rotate_right, color: Colors.white54, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Olcum Acisi: ${_guessAngle.toStringAsFixed(0)}°',
                      style: GoogleFonts.robotoMono(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
                Slider(
                  value: _guessAngle,
                  min: 0,
                  max: 360,
                  divisions: 72,
                  activeColor: const Color(0xFF00BFA5),
                  inactiveColor: Colors.white12,
                  onChanged: _isSubmitting
                      ? null
                      : (v) => setState(() => _guessAngle = v),
                ),
              ],
            ),
          ),

          // İpuçları + Gönder butonu
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF0E1A30),
            child: Column(
              children: [
                // İpuçları
                if (widget.miniGame.hints.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!_showHints) {
                          _showHints = true;
                        } else if (_currentHint < widget.miniGame.hints.length - 1) {
                          _currentHint++;
                        }
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4A847).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFD4A847).withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lightbulb_outline,
                              color: Color(0xFFD4A847), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _showHints
                                  ? widget.miniGame.hints[_currentHint]
                                  : 'İpucu görmek için dokun (${widget.miniGame.hints.length} ipucu)',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFD4A847),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Gönder butonu
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: _guessPosition != null && !_isSubmitting
                        ? _submitResult
                        : null,
                    icon: _isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.gps_fixed),
                    label: Text(
                      _guessPosition == null
                          ? 'GORUNTULEMEYE DOKUNARAK KONUM SEC'
                          : 'ANALIZi GONDER',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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

/// Tibbi goruntuleme sahnesini cizen CustomPainter
class _BallisticScenePainter extends CustomPainter {
  final Offset? guessPosition;
  final double guessAngle;
  final Offset? impactPoint;
  final double? trajectoryAngle;

  _BallisticScenePainter({
    this.guessPosition,
    required this.guessAngle,
    this.impactPoint,
    this.trajectoryAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Grid çizgileri
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 0.5;

    for (var i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), gridPaint);
    }
    for (var i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), gridPaint);
    }

    // Anomali isaretcisi
    if (impactPoint != null) {
      // Normalize impact point to screen
      final normalizedImpact = Offset(
        impactPoint!.dx / 900 * size.width,
        impactPoint!.dy / 600 * size.height,
      );

      final impactPaint = Paint()
        ..color = const Color(0xFF42A5F5).withOpacity(0.8)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(normalizedImpact, 8, impactPaint);

      // Anomali isareti (carpi)
      final crossPaint = Paint()
        ..color = const Color(0xFF42A5F5)
        ..strokeWidth = 2;
      canvas.drawLine(
        normalizedImpact - const Offset(12, 12),
        normalizedImpact + const Offset(12, 12),
        crossPaint,
      );
      canvas.drawLine(
        normalizedImpact + const Offset(-12, 12),
        normalizedImpact + const Offset(12, -12),
        crossPaint,
      );

      // "ANOMALi NOKTASI" etiketi
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'mini_games.hit_point'.tr(),
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF42A5F5).withOpacity(0.7),
            fontSize: 9,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, normalizedImpact + const Offset(14, -6));

      // Olcum referans cizgisi (ipucu)
      if (trajectoryAngle != null) {
        final trajPaint = Paint()
          ..color = const Color(0xFF42A5F5).withOpacity(0.2)
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

        final angleRad = trajectoryAngle! * pi / 180;
        final dx = cos(angleRad) * 300;
        final dy = sin(angleRad) * 300;

        // Kesikli cizgi efekti
        const dashLen = 8.0;
        const gapLen = 6.0;
        final totalLen = sqrt(dx * dx + dy * dy);
        var drawn = 0.0;
        while (drawn < totalLen) {
          final startFrac = drawn / totalLen;
          final endFrac = min((drawn + dashLen) / totalLen, 1.0);
          canvas.drawLine(
            normalizedImpact + Offset(dx * startFrac, dy * startFrac),
            normalizedImpact + Offset(dx * endFrac, dy * endFrac),
            trajPaint,
          );
          drawn += dashLen + gapLen;
        }
      }
    }

    // Oyuncunun tahmini
    if (guessPosition != null) {
      // Konum secici dairesi
      final crosshairPaint = Paint()
        ..color = const Color(0xFF03DAC6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(guessPosition!, 20, crosshairPaint);
      canvas.drawCircle(guessPosition!, 3, Paint()..color = const Color(0xFF03DAC6));

      // Çapraz çizgiler
      canvas.drawLine(
        guessPosition! - const Offset(28, 0),
        guessPosition! + const Offset(28, 0),
        crosshairPaint,
      );
      canvas.drawLine(
        guessPosition! - const Offset(0, 28),
        guessPosition! + const Offset(0, 28),
        crosshairPaint,
      );

      // Açı göstergesi
      final angleRad = guessAngle * pi / 180;
      final arrowEnd = guessPosition! + Offset(cos(angleRad) * 40, sin(angleRad) * 40);
      final arrowPaint = Paint()
        ..color = const Color(0xFFD4A847)
        ..strokeWidth = 2;
      canvas.drawLine(guessPosition!, arrowEnd, arrowPaint);

      // Ok ucu
      final arrowHeadPaint = Paint()
        ..color = const Color(0xFFD4A847)
        ..style = PaintingStyle.fill;
      final headAngle1 = angleRad + 2.6;
      final headAngle2 = angleRad - 2.6;
      final path = Path()
        ..moveTo(arrowEnd.dx, arrowEnd.dy)
        ..lineTo(arrowEnd.dx + cos(headAngle1) * 10, arrowEnd.dy + sin(headAngle1) * 10)
        ..lineTo(arrowEnd.dx + cos(headAngle2) * 10, arrowEnd.dy + sin(headAngle2) * 10)
        ..close();
      canvas.drawPath(path, arrowHeadPaint);

      // Koordinat etiketi
      final coordText = TextPainter(
        text: TextSpan(
          text: '(${guessPosition!.dx.toInt()}, ${guessPosition!.dy.toInt()})',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF03DAC6).withOpacity(0.8),
            fontSize: 10,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      coordText.paint(canvas, guessPosition! + const Offset(24, 8));
    }
  }

  @override
  bool shouldRepaint(covariant _BallisticScenePainter old) =>
      guessPosition != old.guessPosition ||
      guessAngle != old.guessAngle;
}
