import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// EKG Okuma Mini Oyunu
///
/// Oyuncu EKG trasesindeki anomaliyi bulup işaretler,
/// ardından doğru teşhisi seçer.
/// Puan = konum doğruluğu (500) + teşhis doğruluğu (500) + zaman bonusu.
class EkgReadingScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const EkgReadingScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<EkgReadingScreen> createState() => _EkgReadingScreenState();
}

class _EkgReadingScreenState extends ConsumerState<EkgReadingScreen>
    with TickerProviderStateMixin {
  // --- Renk sabitleri ---
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);
  static const _ekgGreen = Color(0xFF00E676);

  // --- Oyun durumu ---
  int _remainingSeconds = 90;
  Timer? _timer;
  bool _isSubmitted = false;

  // Anomali işaretleme
  double? _markedStartX; // 0-1 normalize
  double? _markedEndX;
  bool _isMarking = false;
  bool _anomalyMarked = false;

  // Teşhis seçimi
  String? _selectedDiagnosis;

  // Sonuç
  int _locationScore = 0;
  int _diagnosisScore = 0;
  int _timeBonus = 0;

  // Scroll
  final ScrollController _scrollController = ScrollController();

  // Animasyon: monitör tarama çizgisi
  late AnimationController _scanLineController;
  // Animasyon: kalp atışı pulse
  late AnimationController _pulseController;

  // EKG trace toplam genişliği (piksel)
  static const double _ekgTotalWidth = 2400.0;
  static const double _ekgHeight = 220.0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 90;

    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scanLineController.dispose();
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isSubmitted || !mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds <= 0) {
          timer.cancel();
          _handleTimeout();
        }
      });
    });
  }

  void _handleTimeout() {
    setState(() => _isSubmitted = true);
    HapticFeedback.heavyImpact();
    _submitResult(0);
  }

  void _handleSubmit() {
    if (!_anomalyMarked || _selectedDiagnosis == null || _isSubmitted) return;
    _timer?.cancel();

    final mg = widget.miniGame;
    final correctStart = mg.ekgAnomalyStartX ?? 0.3;
    final correctEnd = mg.ekgAnomalyEndX ?? 0.5;

    // --- Konum puanı (0-500) ---
    // İşaretlenen bölge doğru bölgeyle ne kadar örtüşüyor?
    final overlapStart = max(_markedStartX!, correctStart);
    final overlapEnd = min(_markedEndX!, correctEnd);
    final overlapLength = max(0.0, overlapEnd - overlapStart);
    final correctLength = correctEnd - correctStart;
    final markedLength = _markedEndX! - _markedStartX!;

    // Overlap oranı (precision * recall ortalaması)
    double precision = markedLength > 0 ? overlapLength / markedLength : 0;
    double recall = correctLength > 0 ? overlapLength / correctLength : 0;
    double f1 = (precision + recall) > 0
        ? 2 * precision * recall / (precision + recall)
        : 0;
    _locationScore = (500 * f1).round();

    // --- Teşhis puanı (0-500) ---
    final correctDiagnosis = mg.ekgCorrectDiagnosis ?? '';
    _diagnosisScore = _selectedDiagnosis == correctDiagnosis ? 500 : 0;

    // --- Zaman bonusu (0 ile max arasında, toplam 1000'i aşmaz) ---
    final maxTime = mg.timeLimitSeconds ?? 90;
    _timeBonus = _locationScore > 0 || _diagnosisScore > 0
        ? (_remainingSeconds / maxTime * 100).round()
        : 0;

    final totalScore =
        (_locationScore + _diagnosisScore + _timeBonus).clamp(0, 1000);

    setState(() => _isSubmitted = true);

    if (totalScore >= 500) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    _submitResult(totalScore);
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'ekg_reading',
      'score': score.clamp(0, 1000),
    }).future);

    if (mounted && result != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => MiniGameResultDialog(
          result: result,
          onClose: () {
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  // --- EKG trase üzerinde dokunma/sürükleme ---
  void _onPanStart(DragStartDetails details) {
    if (_isSubmitted || _anomalyMarked) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    setState(() {
      _isMarking = true;
      final localX = details.localPosition.dx + _scrollController.offset;
      _markedStartX = (localX / _ekgTotalWidth).clamp(0.0, 1.0);
      _markedEndX = _markedStartX;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isMarking || _isSubmitted || _anomalyMarked) return;
    setState(() {
      final localX = details.localPosition.dx + _scrollController.offset;
      _markedEndX = (localX / _ekgTotalWidth).clamp(0.0, 1.0);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isMarking || _isSubmitted) return;

    setState(() {
      _isMarking = false;
      // start ve end sırasını düzelt
      if (_markedStartX != null && _markedEndX != null) {
        final s = min(_markedStartX!, _markedEndX!);
        final e = max(_markedStartX!, _markedEndX!);
        _markedStartX = s;
        _markedEndX = e;

        // Çok küçük işaretleme => iptal
        if ((e - s) < 0.02) {
          _markedStartX = null;
          _markedEndX = null;
        } else {
          _anomalyMarked = true;
          HapticFeedback.lightImpact();
        }
      }
    });
  }

  void _resetMarking() {
    if (_isSubmitted) return;
    setState(() {
      _markedStartX = null;
      _markedEndX = null;
      _anomalyMarked = false;
      _selectedDiagnosis = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mg = widget.miniGame;
    final isUrgent = _remainingSeconds < 20;
    final timerColor = isUrgent ? _red : _amber;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          mg.title.isNotEmpty ? mg.title : 'EKG Analizi',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          // Zamanlayıcı
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: timerColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: timerColor.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: timerColor, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${_remainingSeconds ~/ 60}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                  style: GoogleFonts.robotoMono(
                    color: timerColor,
                    fontSize: 16,
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
          // Üst bilgi kartı
          _buildInfoCard(mg),

          // EKG Trase alanı
          Expanded(child: _buildEkgArea(mg)),

          // Alt bölüm: talimat + teşhis + gönder
          _buildBottomSection(mg),
        ],
      ),
    );
  }

  Widget _buildInfoCard(MiniGameDef mg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _ekgGreen.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Icon(
                Icons.monitor_heart,
                color: _ekgGreen
                    .withOpacity(0.5 + _pulseController.value * 0.5),
                size: 28,
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EKG MONİTÖR',
                  style: GoogleFonts.robotoMono(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _ekgGreen,
                    letterSpacing: 2,
                  ),
                ),
                if (mg.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    mg.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white60,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEkgArea(MiniGameDef mg) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _ekgGreen.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: _ekgGreen.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Kaydırılabilir EKG trase
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: _isMarking
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              child: SizedBox(
                width: _ekgTotalWidth,
                height: _ekgHeight + 40, // alt padding
                child: AnimatedBuilder(
                  animation: _scanLineController,
                  builder: (context, child) {
                    return CustomPaint(
                      size: Size(_ekgTotalWidth, _ekgHeight + 40),
                      painter: _EkgPainter(
                        anomalyType: mg.ekgAnomalyType ?? 'st_elevation',
                        anomalyStartX: mg.ekgAnomalyStartX ?? 0.3,
                        anomalyEndX: mg.ekgAnomalyEndX ?? 0.5,
                        markedStartX: _markedStartX,
                        markedEndX: _markedEndX,
                        isSubmitted: _isSubmitted,
                        scanLineProgress: _scanLineController.value,
                        showCorrectRegion: _isSubmitted,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Sol üst: derivasyon etiketi
          Positioned(
            top: 8,
            left: 12,
            child: Text(
              'DII',
              style: GoogleFonts.robotoMono(
                color: _ekgGreen.withOpacity(0.5),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Sağ üst: hız/kalibrasyon etiketi
          Positioned(
            top: 8,
            right: 12,
            child: Text(
              '25 mm/s  10 mm/mV',
              style: GoogleFonts.robotoMono(
                color: _ekgGreen.withOpacity(0.35),
                fontSize: 10,
              ),
            ),
          ),

          // İşaretlemeyi sıfırla butonu
          if (_anomalyMarked && !_isSubmitted)
            Positioned(
              bottom: 8,
              right: 8,
              child: GestureDetector(
                onTap: _resetMarking,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _red.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: _red, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Sıfırla',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: _red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(MiniGameDef mg) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Talimat metni
          if (!_isSubmitted) ...[
            Text(
              _anomalyMarked
                  ? 'TEŞHİSİNİZ?'
                  : 'Anomaliyi bulmak için EKG trasesini kaydırın ve parmağınızla işaretleyin',
              style: GoogleFonts.poppins(
                fontSize: _anomalyMarked ? 16 : 13,
                fontWeight:
                    _anomalyMarked ? FontWeight.bold : FontWeight.w500,
                color: _anomalyMarked ? _teal : Colors.white60,
                letterSpacing: _anomalyMarked ? 1.5 : 0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
          ],

          // Teşhis seçenekleri
          if (_anomalyMarked && !_isSubmitted)
            _buildDiagnosisOptions(mg)
          else if (_isSubmitted)
            _buildResultCard(mg),

          // Gönder butonu
          if (_anomalyMarked && !_isSubmitted) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed:
                    _selectedDiagnosis == null ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedDiagnosis == null
                      ? Colors.grey.shade800
                      : _teal,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'TEŞHİSİ ONAYLA',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDiagnosisOptions(MiniGameDef mg) {
    final options = mg.ekgDiagnosisOptions;
    if (options.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = _selectedDiagnosis == option;
        return GestureDetector(
          onTap: () => setState(() => _selectedDiagnosis = option),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? _teal.withOpacity(0.15)
                  : _surfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? _teal : Colors.white12,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? _teal : Colors.white24,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    option,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResultCard(MiniGameDef mg) {
    final totalScore =
        (_locationScore + _diagnosisScore + _timeBonus).clamp(0, 1000);
    final isGood = totalScore >= 500;
    final correctDiagnosis = mg.ekgCorrectDiagnosis ?? '';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (isGood ? _green : _red).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isGood ? _green : _red).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isGood ? Icons.check_circle_outline : Icons.error_outline,
            size: 44,
            color: isGood ? _green : _red,
          ),
          const SizedBox(height: 10),
          Text(
            isGood ? 'BAŞARILI ANALİZ' : 'YETERSİZ ANALİZ',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isGood ? _green : _red,
            ),
          ),
          const SizedBox(height: 12),

          // Puan detayları
          _buildScoreRow(
            'Anomali Konumu',
            _locationScore,
            500,
            _locationScore >= 250 ? _green : _red,
          ),
          const SizedBox(height: 6),
          _buildScoreRow(
            'Teşhis',
            _diagnosisScore,
            500,
            _diagnosisScore > 0 ? _green : _red,
          ),
          const SizedBox(height: 6),
          _buildScoreRow(
            'Zaman Bonusu',
            _timeBonus,
            100,
            _amber,
          ),

          if (_diagnosisScore == 0 && correctDiagnosis.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _teal.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _teal.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: _teal, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Doğru teşhis: $correctDiagnosis',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: _teal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (_remainingSeconds <= 0) ...[
            const SizedBox(height: 12),
            Text(
              'Süre doldu! Analiz tamamlanamadı.',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: _red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, int score, int max, Color color) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white54,
            ),
          ),
        ),
        Text(
          '$score/$max',
          style: GoogleFonts.robotoMono(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// EKG CustomPainter
// ============================================================

class _EkgPainter extends CustomPainter {
  final String anomalyType;
  final double anomalyStartX;
  final double anomalyEndX;
  final double? markedStartX;
  final double? markedEndX;
  final bool isSubmitted;
  final double scanLineProgress;
  final bool showCorrectRegion;

  _EkgPainter({
    required this.anomalyType,
    required this.anomalyStartX,
    required this.anomalyEndX,
    this.markedStartX,
    this.markedEndX,
    required this.isSubmitted,
    required this.scanLineProgress,
    required this.showCorrectRegion,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height - 30; // alt padding
    final centerY = height * 0.55;

    _drawGrid(canvas, size, width, height);
    _drawMarkedRegion(canvas, width, height);
    if (showCorrectRegion) {
      _drawCorrectRegion(canvas, width, height);
    }
    _drawEkgTrace(canvas, width, height, centerY);
    _drawScanLine(canvas, width, height);
  }

  void _drawGrid(Canvas canvas, Size size, double width, double height) {
    final gridPaint = Paint()
      ..color = const Color(0xFF1A3050)
      ..strokeWidth = 0.5;

    // Dikey ince çizgiler (1mm ~ her 6.25px; 25mm/s ölçeğinde)
    const smallStep = 6.25;
    for (double x = 0; x < width; x += smallStep) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, height),
        gridPaint..color = const Color(0xFF122240),
      );
    }
    // Yatay ince çizgiler
    for (double y = 0; y < height; y += smallStep) {
      canvas.drawLine(
        Offset(0, y),
        Offset(width, y),
        gridPaint..color = const Color(0xFF122240),
      );
    }

    // Kalın çizgiler (5mm ~ her 31.25px)
    final boldPaint = Paint()
      ..color = const Color(0xFF1A3050)
      ..strokeWidth = 1.0;
    const bigStep = 31.25;
    for (double x = 0; x < width; x += bigStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, height), boldPaint);
    }
    for (double y = 0; y < height; y += bigStep) {
      canvas.drawLine(Offset(0, y), Offset(width, y), boldPaint);
    }
  }

  void _drawMarkedRegion(Canvas canvas, double width, double height) {
    if (markedStartX == null || markedEndX == null) return;
    final s = min(markedStartX!, markedEndX!);
    final e = max(markedStartX!, markedEndX!);

    final rect = Rect.fromLTRB(s * width, 0, e * width, height);
    final paint = Paint()
      ..color = (isSubmitted
              ? const Color(0xFFFFB74D)
              : const Color(0xFF00BFA5))
          .withOpacity(0.12);
    canvas.drawRect(rect, paint);

    // Kenarlıklar
    final borderPaint = Paint()
      ..color = (isSubmitted
              ? const Color(0xFFFFB74D)
              : const Color(0xFF00BFA5))
          .withOpacity(0.5)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, borderPaint);
  }

  void _drawCorrectRegion(Canvas canvas, double width, double height) {
    final rect =
        Rect.fromLTRB(anomalyStartX * width, 0, anomalyEndX * width, height);
    final paint = Paint()
      ..color = const Color(0xFF66BB6A).withOpacity(0.08);
    canvas.drawRect(rect, paint);

    final borderPaint = Paint()
      ..color = const Color(0xFF66BB6A).withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Kesikli çizgi efekti
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    // Üst ve alt kenarlar
    for (final y in [0.0, height]) {
      double x = anomalyStartX * width;
      while (x < anomalyEndX * width) {
        canvas.drawLine(
          Offset(x, y),
          Offset(min(x + dashWidth, anomalyEndX * width), y),
          borderPaint,
        );
        x += dashWidth + dashSpace;
      }
    }
    // Sol ve sağ kenarlar
    for (final x in [anomalyStartX * width, anomalyEndX * width]) {
      double y = 0;
      while (y < height) {
        canvas.drawLine(
          Offset(x, y),
          Offset(x, min(y + dashWidth, height)),
          borderPaint,
        );
        y += dashWidth + dashSpace;
      }
    }
  }

  void _drawScanLine(Canvas canvas, double width, double height) {
    if (isSubmitted) return;
    final x = scanLineProgress * width;
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00E676).withOpacity(0.0),
          const Color(0xFF00E676).withOpacity(0.15),
          const Color(0xFF00E676).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(x - 15, 0, 30, height));
    canvas.drawRect(Rect.fromLTWH(x - 15, 0, 30, height), paint);
  }

  void _drawEkgTrace(
      Canvas canvas, double width, double height, double centerY) {
    final tracePaint = Paint()
      ..color = const Color(0xFF00E676)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Anomali bölgesindeki renk değişimi
    final anomalyPaint = Paint()
      ..color = const Color(0xFFFF5252).withOpacity(0.9)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // EKG dalga formunu üret
    final points = _generateEkgPoints(width, height, centerY);

    // Trace çizimi — anomali bölgesinde renk değişimi
    for (int i = 0; i < points.length - 1; i++) {
      final normalizedX = points[i].dx / width;
      final inAnomaly =
          normalizedX >= anomalyStartX && normalizedX <= anomalyEndX;
      canvas.drawLine(
        points[i],
        points[i + 1],
        inAnomaly ? anomalyPaint : tracePaint,
      );
    }

    // Glow efekti
    final glowPaint = Paint()
      ..color = const Color(0xFF00E676).withOpacity(0.15)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], glowPaint);
    }
  }

  List<Offset> _generateEkgPoints(
      double width, double height, double centerY) {
    final points = <Offset>[];
    // Her kalp atışı döngüsü ~200 piksel genişliğinde
    const cycleWidth = 200.0;
    final numCycles = (width / cycleWidth).ceil();
    final amplitude = height * 0.18; // Normal dalga yüksekliği

    for (int cycle = 0; cycle < numCycles; cycle++) {
      final baseX = cycle * cycleWidth;
      final normalizedCycleStart = baseX / width;
      final normalizedCycleEnd = (baseX + cycleWidth) / width;

      // Bu döngü anomali bölgesinde mi?
      final inAnomaly = normalizedCycleEnd > anomalyStartX &&
          normalizedCycleStart < anomalyEndX;

      if (inAnomaly) {
        _addAnomalyCycle(
            points, baseX, cycleWidth, centerY, amplitude, anomalyType);
      } else {
        _addNormalCycle(points, baseX, cycleWidth, centerY, amplitude);
      }
    }

    return points;
  }

  void _addNormalCycle(List<Offset> points, double baseX, double cycleWidth,
      double centerY, double amplitude) {
    // Normal sinus ritmi: P - QRS - T
    const steps = 100;
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = baseX + t * cycleWidth;
      double y = centerY;

      // Baseline
      if (t < 0.08) {
        // İzoelektrik hat (baseline)
        y = centerY;
      }
      // P dalgası (0.08 - 0.18)
      else if (t < 0.18) {
        final pt = (t - 0.08) / 0.10;
        y = centerY - amplitude * 0.15 * sin(pt * pi);
      }
      // PR segment (0.18 - 0.25)
      else if (t < 0.25) {
        y = centerY;
      }
      // Q dalgası (0.25 - 0.28)
      else if (t < 0.28) {
        final pt = (t - 0.25) / 0.03;
        y = centerY + amplitude * 0.12 * sin(pt * pi);
      }
      // R dalgası (0.28 - 0.34)
      else if (t < 0.34) {
        final pt = (t - 0.28) / 0.06;
        y = centerY - amplitude * 0.85 * sin(pt * pi);
      }
      // S dalgası (0.34 - 0.38)
      else if (t < 0.38) {
        final pt = (t - 0.34) / 0.04;
        y = centerY + amplitude * 0.25 * sin(pt * pi);
      }
      // ST segment (0.38 - 0.48) — izoelektrik
      else if (t < 0.48) {
        y = centerY;
      }
      // T dalgası (0.48 - 0.62)
      else if (t < 0.62) {
        final pt = (t - 0.48) / 0.14;
        y = centerY - amplitude * 0.25 * sin(pt * pi);
      }
      // Baseline (0.62 - 1.0)
      else {
        y = centerY;
      }

      points.add(Offset(x, y));
    }
  }

  void _addAnomalyCycle(List<Offset> points, double baseX, double cycleWidth,
      double centerY, double amplitude, String type) {
    const steps = 100;

    switch (type) {
      case 'st_elevation':
        _addStElevationCycle(
            points, baseX, cycleWidth, centerY, amplitude, steps);
        break;
      case 'atrial_fibrillation':
        _addAtrialFibrillationCycle(
            points, baseX, cycleWidth, centerY, amplitude, steps);
        break;
      case 'prolonged_qt':
        _addProlongedQtCycle(
            points, baseX, cycleWidth, centerY, amplitude, steps);
        break;
      case 'ventricular_tachycardia':
        _addVentricularTachycardiaCycle(
            points, baseX, cycleWidth, centerY, amplitude, steps);
        break;
      default:
        _addNormalCycle(points, baseX, cycleWidth, centerY, amplitude);
    }
  }

  /// ST Elevasyonu: ST segmenti yukarı kalkık
  void _addStElevationCycle(List<Offset> points, double baseX,
      double cycleWidth, double centerY, double amplitude, int steps) {
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = baseX + t * cycleWidth;
      double y = centerY;

      if (t < 0.08) {
        y = centerY;
      } else if (t < 0.18) {
        final pt = (t - 0.08) / 0.10;
        y = centerY - amplitude * 0.15 * sin(pt * pi);
      } else if (t < 0.25) {
        y = centerY;
      } else if (t < 0.28) {
        final pt = (t - 0.25) / 0.03;
        y = centerY + amplitude * 0.12 * sin(pt * pi);
      } else if (t < 0.34) {
        final pt = (t - 0.28) / 0.06;
        y = centerY - amplitude * 0.85 * sin(pt * pi);
      } else if (t < 0.38) {
        // S dalgası — hızlı geri dönüş ama baseline'a değil, yüksekte kalır
        final pt = (t - 0.34) / 0.04;
        y = centerY -
            amplitude * 0.40 * (1 - sin(pt * pi * 0.5)); // yüksekte kal
      } else if (t < 0.50) {
        // ST segment — YUKARI KALKIK (elevasyon)
        final pt = (t - 0.38) / 0.12;
        // Konveks yukarı yay
        y = centerY - amplitude * 0.40 - amplitude * 0.08 * sin(pt * pi);
      } else if (t < 0.65) {
        // T dalgası — ST elevasyonla birleşik, tombstone şekli
        final pt = (t - 0.50) / 0.15;
        y = centerY -
            amplitude * 0.40 * (1 - pt) -
            amplitude * 0.20 * sin(pt * pi);
      } else {
        // Baseline'a geri dönüş
        final pt = min(1.0, (t - 0.65) / 0.08);
        y = centerY * (pt) + (centerY + amplitude * 0.02) * (1 - pt);
      }

      points.add(Offset(x, y));
    }
  }

  /// Atriyal Fibrilasyon: düzensiz ritim, P dalgası yok, f dalgaları
  void _addAtrialFibrillationCycle(List<Offset> points, double baseX,
      double cycleWidth, double centerY, double amplitude, int steps) {
    final rng = Random(baseX.toInt()); // deterministik rastgelelik

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = baseX + t * cycleWidth;
      double y = centerY;

      // Düzensiz baseline (f dalgaları — fibrilasyon dalgacıkları)
      final fibrillation = amplitude *
          0.06 *
          (sin(t * 47 * pi) +
              sin(t * 31 * pi) * 0.7 +
              sin(t * 73 * pi) * 0.4);

      // QRS kompleksi (rastgele zamanlama, düzensiz R-R aralığı)
      // Bu döngüde QRS'i farklı bir pozisyona koy
      final qrsCenter = 0.20 + rng.nextDouble() * 0.15;
      final qrsHalfWidth = 0.04;

      if ((t - qrsCenter).abs() < qrsHalfWidth) {
        final pt = (t - (qrsCenter - qrsHalfWidth)) / (qrsHalfWidth * 2);
        if (pt < 0.25) {
          y = centerY + amplitude * 0.1 * sin(pt / 0.25 * pi);
        } else if (pt < 0.6) {
          y = centerY -
              amplitude * 0.80 * sin((pt - 0.25) / 0.35 * pi);
        } else {
          y = centerY + amplitude * 0.2 * sin((pt - 0.6) / 0.4 * pi);
        }
      }
      // İkinci QRS (hızlı, düzensiz)
      else {
        final qrsCenter2 = 0.60 + rng.nextDouble() * 0.15;
        if ((t - qrsCenter2).abs() < qrsHalfWidth) {
          final pt =
              (t - (qrsCenter2 - qrsHalfWidth)) / (qrsHalfWidth * 2);
          if (pt < 0.25) {
            y = centerY + amplitude * 0.1 * sin(pt / 0.25 * pi);
          } else if (pt < 0.6) {
            y = centerY -
                amplitude * 0.70 * sin((pt - 0.25) / 0.35 * pi);
          } else {
            y = centerY +
                amplitude * 0.15 * sin((pt - 0.6) / 0.4 * pi);
          }
        } else {
          // T dalgası (küçük, düzensiz)
          final tWaveCenter = qrsCenter + 0.15;
          if ((t - tWaveCenter).abs() < 0.06) {
            final pt = (t - (tWaveCenter - 0.06)) / 0.12;
            y = centerY - amplitude * 0.12 * sin(pt * pi) + fibrillation;
          } else {
            y = centerY + fibrillation;
          }
        }
      }

      points.add(Offset(x, y));
    }
  }

  /// Uzun QT: QT aralığı genişlemiş, T dalgası geniş ve geç
  void _addProlongedQtCycle(List<Offset> points, double baseX,
      double cycleWidth, double centerY, double amplitude, int steps) {
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = baseX + t * cycleWidth;
      double y = centerY;

      if (t < 0.06) {
        y = centerY;
      } else if (t < 0.14) {
        final pt = (t - 0.06) / 0.08;
        y = centerY - amplitude * 0.12 * sin(pt * pi);
      } else if (t < 0.20) {
        y = centerY;
      } else if (t < 0.23) {
        final pt = (t - 0.20) / 0.03;
        y = centerY + amplitude * 0.10 * sin(pt * pi);
      } else if (t < 0.29) {
        final pt = (t - 0.23) / 0.06;
        y = centerY - amplitude * 0.80 * sin(pt * pi);
      } else if (t < 0.33) {
        final pt = (t - 0.29) / 0.04;
        y = centerY + amplitude * 0.20 * sin(pt * pi);
      }
      // Uzamış ST segment (0.33 - 0.55)
      else if (t < 0.55) {
        y = centerY;
      }
      // Geniş T dalgası (0.55 - 0.85) — normal: 0.48-0.62
      else if (t < 0.85) {
        final pt = (t - 0.55) / 0.30;
        // Geniş, bifazik görünümlü T dalgası
        y = centerY - amplitude * 0.30 * sin(pt * pi);
      } else {
        y = centerY;
      }

      points.add(Offset(x, y));
    }
  }

  /// Ventriküler Taşikardi: geniş QRS, hızlı rate, birbirine giren dalgalar
  void _addVentricularTachycardiaCycle(List<Offset> points, double baseX,
      double cycleWidth, double centerY, double amplitude, int steps) {
    // VT'de döngü daha kısa (hızlı), geniş QRS
    // Döngü boyunca 2-3 geniş QRS sığdır
    final rng = Random(baseX.toInt());

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = baseX + t * cycleWidth;
      double y = centerY;

      // 3 hızlı atış bu döngüye sığsın
      final beatPhase = (t * 3.0) % 1.0;

      // Geniş QRS (0.0 - 0.50 her atışın)
      if (beatPhase < 0.50) {
        final pt = beatPhase / 0.50;
        // Geniş sinüzoidal QRS (monomorphic VT)
        y = centerY -
            amplitude *
                0.75 *
                sin(pt * pi) *
                (rng.nextBool() ? 1 : -1).toDouble();
        // Alternan pattern: her atış ters yönde
        final beatIndex = (t * 3.0).floor();
        if (beatIndex.isEven) {
          y = centerY - amplitude * 0.75 * sin(pt * pi);
        } else {
          y = centerY + amplitude * 0.55 * sin(pt * pi);
        }
      }
      // Kısa izoelektrik (0.50 - 1.0) — neredeyse yok
      else {
        final pt = (beatPhase - 0.50) / 0.50;
        y = centerY + amplitude * 0.05 * sin(pt * pi * 2);
      }

      points.add(Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant _EkgPainter oldDelegate) {
    return oldDelegate.scanLineProgress != scanLineProgress ||
        oldDelegate.markedStartX != markedStartX ||
        oldDelegate.markedEndX != markedEndX ||
        oldDelegate.isSubmitted != isSubmitted;
  }
}
