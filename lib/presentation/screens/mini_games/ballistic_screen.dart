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
                    guessAngle: 0,
                    impactPoint: widget.miniGame.impactPoint != null
                        ? Offset(
                            (widget.miniGame.impactPoint!['x'] as num?)?.toDouble() ?? 450,
                            (widget.miniGame.impactPoint!['y'] as num?)?.toDouble() ?? 300,
                          )
                        : const Offset(450, 300),
                    trajectoryAngle: null,
                  ),
                  size: Size.infinite,
                ),
              ),
            ),
          ),

          // Bilgilendirici strip (açı slider kaldırıldı)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: const Color(0xFF132038),
            child: Row(
              children: [
                Icon(Icons.touch_app, color: Colors.white54, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _guessPosition == null
                        ? 'Şüpheli gölgeye dokunarak işaretleyin'
                        : 'İşaret koyuldu. Başka bir noktayı seçmek için tekrar dokunun.',
                    style: GoogleFonts.inter(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
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

    // Şematik akciğer/göğüs kafesi çizimi (placeholder tıbbi görsel)
    _drawChestXray(canvas, size);

    // Şüpheli gölgeler — oyuncunun aralarından doğru olanı seçmesi için
    _drawSuspiciousShadows(canvas, size);

    // NOT: Doğru anomali noktası (impactPoint) artık _drawSuspiciousShadows
    // içinde şüpheli gölgelerle birlikte çiziliyor — oyuncunun doğruyu
    // seçmesi için gizli ipucu olarak

    // Oyuncunun işareti (crosshair)
    if (guessPosition != null) {
      final crosshairPaint = Paint()
        ..color = const Color(0xFF03DAC6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(guessPosition!, 22, crosshairPaint);
      canvas.drawCircle(guessPosition!, 4, Paint()..color = const Color(0xFF03DAC6));

      // Çapraz çizgiler
      canvas.drawLine(
        guessPosition! - const Offset(32, 0),
        guessPosition! + const Offset(32, 0),
        crosshairPaint,
      );
      canvas.drawLine(
        guessPosition! - const Offset(0, 32),
        guessPosition! + const Offset(0, 32),
        crosshairPaint,
      );

      // "SEÇİLDİ" etiketi
      final labelText = TextPainter(
        text: TextSpan(
          text: 'SEÇİLDİ',
          style: GoogleFonts.robotoMono(
            color: const Color(0xFF03DAC6),
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      labelText.paint(canvas, guessPosition! + const Offset(26, -4));
    }
  }

  /// Şüpheli gölgeler — oyuncunun doğruyu aralarından seçmesi için
  /// Doğru anomali impactPoint'te, yanlış ipuçları rastgele yerlerde
  void _drawSuspiciousShadows(Canvas canvas, Size size) {
    // Doğru anomali (impactPoint) — biraz daha belirgin ama tek değil
    if (impactPoint != null) {
      final normalizedImpact = Offset(
        impactPoint!.dx / 900 * size.width,
        impactPoint!.dy / 600 * size.height,
      );
      _drawShadow(canvas, normalizedImpact, 18, const Color(0xFFE0E0E0), 0.55);
    }

    // Sabit yanlış anomaliler — hep aynı yerlerde (seed gibi davranır)
    final fakeSpots = [
      Offset(size.width * 0.32, size.height * 0.28),
      Offset(size.width * 0.68, size.height * 0.35),
      Offset(size.width * 0.25, size.height * 0.62),
      Offset(size.width * 0.72, size.height * 0.58),
      Offset(size.width * 0.5, size.height * 0.75),
    ];

    for (final spot in fakeSpots) {
      _drawShadow(canvas, spot, 12, const Color(0xFFBDBDBD), 0.25);
    }
  }

  /// Bir şüpheli "gölge" çiz — radial gradient-like daire
  void _drawShadow(Canvas canvas, Offset center, double radius, Color color, double opacity) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(opacity),
          color.withOpacity(opacity * 0.5),
          color.withOpacity(0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);

    // İnce çember etrafında
    final borderPaint = Paint()
      ..color = color.withOpacity(opacity * 0.3)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius * 0.7, borderPaint);
  }

  /// Şematik akciğer/göğüs kafesi — tıbbi görüntüleme görünümü için placeholder
  void _drawChestXray(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final bodyW = size.width * 0.75;
    final bodyH = size.height * 0.85;

    // Göğüs kafesi arka plan (hafif parlama)
    final bodyPaint = Paint()
      ..color = const Color(0xFF1A2F4A).withOpacity(0.4)
      ..style = PaintingStyle.fill;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, cy), width: bodyW, height: bodyH),
      const Radius.circular(80),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Sol akciğer
    final lungPaint = Paint()
      ..color = const Color(0xFF2A4A6A).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    final leftLung = Path()
      ..moveTo(cx - bodyW * 0.35, cy - bodyH * 0.3)
      ..quadraticBezierTo(cx - bodyW * 0.48, cy, cx - bodyW * 0.38, cy + bodyH * 0.3)
      ..quadraticBezierTo(cx - bodyW * 0.2, cy + bodyH * 0.25, cx - bodyW * 0.15, cy - bodyH * 0.2)
      ..quadraticBezierTo(cx - bodyW * 0.2, cy - bodyH * 0.35, cx - bodyW * 0.35, cy - bodyH * 0.3)
      ..close();
    canvas.drawPath(leftLung, lungPaint);

    // Sağ akciğer (ayna)
    final rightLung = Path()
      ..moveTo(cx + bodyW * 0.35, cy - bodyH * 0.3)
      ..quadraticBezierTo(cx + bodyW * 0.48, cy, cx + bodyW * 0.38, cy + bodyH * 0.3)
      ..quadraticBezierTo(cx + bodyW * 0.2, cy + bodyH * 0.25, cx + bodyW * 0.15, cy - bodyH * 0.2)
      ..quadraticBezierTo(cx + bodyW * 0.2, cy - bodyH * 0.35, cx + bodyW * 0.35, cy - bodyH * 0.3)
      ..close();
    canvas.drawPath(rightLung, lungPaint);

    // Kaburga çizgileri (kemik efekti)
    final ribPaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 8; i++) {
      final y = cy - bodyH * 0.35 + i * (bodyH * 0.08);
      // Sol kaburga
      final leftRib = Path()
        ..moveTo(cx - bodyW * 0.05, y)
        ..quadraticBezierTo(
          cx - bodyW * 0.3, y + 4,
          cx - bodyW * 0.42, y + 10,
        );
      canvas.drawPath(leftRib, ribPaint);
      // Sağ kaburga
      final rightRib = Path()
        ..moveTo(cx + bodyW * 0.05, y)
        ..quadraticBezierTo(
          cx + bodyW * 0.3, y + 4,
          cx + bodyW * 0.42, y + 10,
        );
      canvas.drawPath(rightRib, ribPaint);
    }

    // Omurga (merkez dikey çizgi)
    final spinePaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 3;
    canvas.drawLine(
      Offset(cx, cy - bodyH * 0.4),
      Offset(cx, cy + bodyH * 0.4),
      spinePaint,
    );

    // Kalp silueti (sol alt)
    final heartPaint = Paint()
      ..color = const Color(0xFF4A3A5A).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - bodyW * 0.08, cy + bodyH * 0.1),
        width: bodyW * 0.22,
        height: bodyH * 0.28,
      ),
      heartPaint,
    );

    // Etiket: "PA AKCİĞER GRAFİSİ"
    final labelPainter = TextPainter(
      text: TextSpan(
        text: 'PA AKCİĞER GRAFİSİ',
        style: GoogleFonts.robotoMono(
          color: Colors.white.withOpacity(0.25),
          fontSize: 11,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    labelPainter.paint(canvas, Offset(16, 16));

    // Sağ alt köşe: ölçek çizgisi
    final scalePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width - 60, size.height - 20),
      Offset(size.width - 20, size.height - 20),
      scalePaint,
    );
    final scaleText = TextPainter(
      text: TextSpan(
        text: '10 cm',
        style: GoogleFonts.robotoMono(
          color: Colors.white.withOpacity(0.3),
          fontSize: 9,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    scaleText.paint(canvas, Offset(size.width - 52, size.height - 38));
  }

  @override
  bool shouldRepaint(covariant _BallisticScenePainter old) =>
      guessPosition != old.guessPosition ||
      guessAngle != old.guessAngle;
}
