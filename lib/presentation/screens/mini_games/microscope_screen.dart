import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// Mikroskop Analizi Mini Oyunu
///
/// Kan yayması veya idrar sedimentinde anormal hücreleri işaretle
/// ve doğru tanıyı seç.
class MicroscopeScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const MicroscopeScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<MicroscopeScreen> createState() => _MicroscopeScreenState();
}

class _MicroscopeScreenState extends ConsumerState<MicroscopeScreen>
    with TickerProviderStateMixin {
  bool _isSubmitted = false;
  int _remainingSeconds = 0;
  Timer? _timer;

  // Hücre verisi
  late List<_CellData> _cells;
  final Set<int> _markedCellIndices = {};
  String? _selectedDiagnosis;
  bool _showDiagnosisStep = false;

  // Zoom kontrolü
  final TransformationController _transformController =
      TransformationController();
  double _currentZoom = 1.0;

  // Animasyon
  late AnimationController _scanLineController;

  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);
  static const _purple = Color(0xFF9C27B0);
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);

  // Hücre renkleri: anormal hücre tipine göre
  static const Map<String, Color> _abnormalColors = {
    'Orak Hücre': Color(0xFFE53935),
    'Blast Hücre': Color(0xFF7B1FA2),
    'Bakteri': Color(0xFF43A047),
    'Kristal': Color(0xFFFF8F00),
    'Parazit': Color(0xFFD81B60),
    'Atipik Hücre': Color(0xFFE91E63),
  };

  // Mikroskop alanı boyutu (sanal piksel)
  static const double _fieldWidth = 800;
  static const double _fieldHeight = 800;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 90;
    _generateCells();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scanLineController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  void _generateCells() {
    final mg = widget.miniGame;
    final abnormalCount = mg.abnormalCellCount ?? 5;
    final totalCells = abnormalCount + 25 + Random(_seedFromId()).nextInt(15);

    final rng = Random(_seedFromId());
    _cells = [];

    // Normal hücreler
    for (int i = 0; i < totalCells - abnormalCount; i++) {
      _cells.add(_CellData(
        x: 40 + rng.nextDouble() * (_fieldWidth - 80),
        y: 40 + rng.nextDouble() * (_fieldHeight - 80),
        radius: 12 + rng.nextDouble() * 10,
        isAbnormal: false,
        opacity: 0.15 + rng.nextDouble() * 0.25,
        hue: rng.nextDouble() * 0.1, // küçük ton varyasyonu
      ));
    }

    // Anormal hücreler — birbirine ve normal hücrelere çok yakın olmaması
    int placed = 0;
    int attempts = 0;
    while (placed < abnormalCount && attempts < 500) {
      attempts++;
      final x = 50 + rng.nextDouble() * (_fieldWidth - 100);
      final y = 50 + rng.nextDouble() * (_fieldHeight - 100);
      final r = 14 + rng.nextDouble() * 8;

      // Minimum mesafe kontrolü
      bool tooClose = false;
      for (final c in _cells) {
        final dist = sqrt(pow(c.x - x, 2) + pow(c.y - y, 2));
        if (dist < (c.radius + r + 8)) {
          tooClose = true;
          break;
        }
      }
      if (tooClose) continue;

      _cells.add(_CellData(
        x: x,
        y: y,
        radius: r,
        isAbnormal: true,
        opacity: 0.7 + rng.nextDouble() * 0.3,
        hue: rng.nextDouble(),
      ));
      placed++;
    }

    // Karıştır
    _cells.shuffle(rng);
  }

  int _seedFromId() {
    // Tekrarlanabilir seed: miniGame.id hashCode
    return widget.miniGame.id.hashCode.abs();
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

  void _handleCellTap(int index) {
    if (_isSubmitted || _showDiagnosisStep) return;
    HapticFeedback.lightImpact();
    setState(() {
      if (_markedCellIndices.contains(index)) {
        _markedCellIndices.remove(index);
      } else {
        _markedCellIndices.add(index);
      }
    });
  }

  void _proceedToDiagnosis() {
    setState(() => _showDiagnosisStep = true);
  }

  void _handleSubmit() {
    if (_isSubmitted || _selectedDiagnosis == null) return;

    setState(() => _isSubmitted = true);
    _timer?.cancel();

    final score = _calculateScore();
    if (score >= 500) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }
    _submitResult(score);
  }

  int _calculateScore() {
    final mg = widget.miniGame;
    final maxTime = mg.timeLimitSeconds ?? 90;

    int score = 0;

    // Doğru işaretlenen anormal hücreler
    int correctMarks = 0;
    int falsePositives = 0;

    for (final idx in _markedCellIndices) {
      if (_cells[idx].isAbnormal) {
        correctMarks++;
      } else {
        falsePositives++;
      }
    }

    // Kaçırılan anormal hücreler
    final totalAbnormal = _cells.where((c) => c.isAbnormal).length;

    // Her doğru hücre = 100 puan (maks abnormalCount * 100, kalan 300'e kadar)
    final maxCellPoints = min(totalAbnormal * 100, 700);
    if (totalAbnormal > 0) {
      score += ((correctMarks / totalAbnormal) * maxCellPoints).round();
    }

    // Yanlış pozitif cezası
    score -= falsePositives * 50;

    // Doğru tanı = 300 puan
    final correctDiagnosis = mg.microscopeCorrectDiagnosis ?? '';
    if (_selectedDiagnosis == correctDiagnosis) {
      score += 300;
    }

    // Zaman bonusu (kalan puanı doldurmak için, maks ~200)
    if (_remainingSeconds > 0 && maxTime > 0) {
      score += (_remainingSeconds / maxTime * 100).round();
    }

    return score.clamp(0, 1000);
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'microscope',
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

  @override
  Widget build(BuildContext context) {
    final mg = widget.miniGame;
    final isUrgent = _remainingSeconds < 15;
    final timerColor = isUrgent ? _red : _amber;
    final isBlood = (mg.microscopeType ?? 'blood_smear') == 'blood_smear';

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          mg.title.isNotEmpty
              ? mg.title
              : isBlood
                  ? 'Kan Yayması Analizi'
                  : 'İdrar Sediment Analizi',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          _buildTimer(timerColor),
        ],
      ),
      body: Column(
        children: [
          // Üst bilgi çubuğu
          _buildInfoBar(mg),

          // Mikroskop görüntüsü
          Expanded(
            child: _showDiagnosisStep && !_isSubmitted
                ? _buildDiagnosisPanel(mg)
                : _buildMicroscopeView(),
          ),

          // Alt kontrol paneli
          _buildBottomPanel(mg),
        ],
      ),
    );
  }

  Widget _buildTimer(Color timerColor) {
    return Container(
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
    );
  }

  Widget _buildInfoBar(MiniGameDef mg) {
    final abnormalCount = mg.abnormalCellCount ?? 5;
    final markedCount = _markedCellIndices.length;
    final cellType = mg.abnormalCellType ?? 'Anormal Hücre';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _surfaceColor,
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          // Hedef hücre tipi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _purple.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.biotech, color: _purple, size: 14),
                const SizedBox(width: 6),
                Text(
                  cellType,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: _purple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // İşaretleme sayacı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _teal.withOpacity(0.3)),
            ),
            child: Text(
              'İşaretli: $markedCount / $abnormalCount',
              style: GoogleFonts.robotoMono(
                fontSize: 12,
                color: _teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Zoom göstergesi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${_currentZoom.toStringAsFixed(1)}x',
              style: GoogleFonts.robotoMono(
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMicroscopeView() {
    final mg = widget.miniGame;
    final isBlood = (mg.microscopeType ?? 'blood_smear') == 'blood_smear';

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 2),
        boxShadow: [
          BoxShadow(
            color: _teal.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Hücre görüntüleyici
            InteractiveViewer(
              transformationController: _transformController,
              minScale: 1.0,
              maxScale: 4.0,
              onInteractionUpdate: (details) {
                setState(() {
                  _currentZoom = _transformController.value.getMaxScaleOnAxis();
                });
              },
              child: GestureDetector(
                onTapUp: (details) {
                  // Ekran koordinatlarından sahne koordinatlarına dönüştür
                  final renderBox = context.findRenderObject() as RenderBox?;
                  if (renderBox == null) return;

                  final localPos = details.localPosition;
                  // InteractiveViewer transform'u hesaba kat
                  final matrix = _transformController.value;
                  final invertedMatrix = Matrix4.inverted(matrix);
                  final scenePoint = MatrixUtils.transformPoint(
                      invertedMatrix,
                      Offset(localPos.dx, localPos.dy));

                  // En yakın hücreyi bul
                  _handleTapAtPoint(scenePoint, renderBox.size);
                },
                child: CustomPaint(
                  size: const Size(_fieldWidth, _fieldHeight),
                  painter: _MicroscopePainter(
                    cells: _cells,
                    markedIndices: _markedCellIndices,
                    isBlood: isBlood,
                    isSubmitted: _isSubmitted,
                    abnormalCellType: mg.abnormalCellType ?? 'Anormal Hücre',
                  ),
                ),
              ),
            ),

            // Tarama çizgisi animasyonu
            if (!_isSubmitted)
              AnimatedBuilder(
                animation: _scanLineController,
                builder: (context, child) {
                  return Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.1,
                      child: Container(
                        height: 2,
                        margin: EdgeInsets.only(
                          top: _scanLineController.value *
                              (_fieldHeight - 2),
                        ),
                        color: _teal,
                      ),
                    ),
                  );
                },
              ),

            // Vignet efekti (daire maskeleme)
            Positioned.fill(
              child: CustomPaint(
                painter: _VignettePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTapAtPoint(Offset scenePoint, Size viewSize) {
    // Ekran boyutundan sahne boyutuna ölçekle
    final scaleX = _fieldWidth / viewSize.width;
    final scaleY = _fieldHeight / viewSize.height;
    final scale = max(scaleX, scaleY);

    final adjustedX = scenePoint.dx * scale;
    final adjustedY = scenePoint.dy * scale;

    // En yakın hücreyi bul (dokunma mesafesi dahilinde)
    double minDist = double.infinity;
    int closestIdx = -1;
    final tapRadius = 30.0 / _currentZoom; // Zoom'a göre ayarla

    for (int i = 0; i < _cells.length; i++) {
      final cell = _cells[i];
      final dist =
          sqrt(pow(cell.x - adjustedX, 2) + pow(cell.y - adjustedY, 2));
      if (dist < cell.radius + tapRadius && dist < minDist) {
        minDist = dist;
        closestIdx = i;
      }
    }

    if (closestIdx >= 0) {
      _handleCellTap(closestIdx);
    }
  }

  Widget _buildDiagnosisPanel(MiniGameDef mg) {
    final options = mg.microscopeDiagnosisOptions ?? [];

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.assignment, color: _purple, size: 24),
              const SizedBox(width: 10),
              Text(
                'TANI SEÇİMİ',
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _purple,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Bulgularınıza göre en uygun tanıyı seçin:',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected = _selectedDiagnosis == option;

                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedDiagnosis = option),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _purple.withOpacity(0.1)
                          : Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? _purple
                            : Colors.white.withOpacity(0.1),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected ? _purple : Colors.white24,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white70,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
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
      ),
    );
  }

  Widget _buildBottomPanel(MiniGameDef mg) {
    if (_isSubmitted) {
      return _buildResultSummary();
    }

    if (_showDiagnosisStep) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surfaceColor,
          border:
              Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: SizedBox(
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
              'TANIYI ONAYLA',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      );
    }

    // Hücre işaretleme aşaması
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Talimat
          Text(
            'Anormal hücreleri dokunarak işaretleyin. Yakınlaştırmak için sıkıştırın.',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white38,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _markedCellIndices.isEmpty
                  ? null
                  : _proceedToDiagnosis,
              style: ElevatedButton.styleFrom(
                backgroundColor: _markedCellIndices.isEmpty
                    ? Colors.grey.shade800
                    : _teal,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'İŞARETLEMEYİ TAMAMLA',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSummary() {
    int correctMarks = 0;
    int falsePositives = 0;
    for (final idx in _markedCellIndices) {
      if (_cells[idx].isAbnormal) {
        correctMarks++;
      } else {
        falsePositives++;
      }
    }
    final totalAbnormal = _cells.where((c) => c.isAbnormal).length;
    final missed = totalAbnormal - correctMarks;
    final correctDiag = widget.miniGame.microscopeCorrectDiagnosis ?? '';
    final diagCorrect = _selectedDiagnosis == correctDiag;
    final score = _calculateScore();
    final isGood = score >= 500;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (isGood ? _green : _red).withOpacity(0.06),
        border: Border(
          top: BorderSide(
              color: (isGood ? _green : _red).withOpacity(0.3), width: 2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGood ? Icons.check_circle_outline : Icons.error_outline,
            size: 36,
            color: isGood ? _green : _red,
          ),
          const SizedBox(height: 8),
          Text(
            isGood ? 'ANALİZ BAŞARILI' : 'ANALİZ HATALI',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isGood ? _green : _red,
            ),
          ),
          const SizedBox(height: 10),
          // Detay satırları
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _resultChip(
                  'Doğru', '$correctMarks/$totalAbnormal', _green),
              _resultChip('Yanlış Pozitif', '$falsePositives', _red),
              _resultChip('Kaçırılan', '$missed', _amber),
            ],
          ),
          const SizedBox(height: 8),
          // Tanı sonucu
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                diagCorrect ? Icons.check : Icons.close,
                color: diagCorrect ? _green : _red,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                diagCorrect ? 'Tanı doğru' : 'Tanı yanlış',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: diagCorrect ? _green : _red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!diagCorrect && correctDiag.isNotEmpty) ...[
                const SizedBox(width: 8),
                Text(
                  '(Doğru: $correctDiag)',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.white38,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultChip(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.robotoMono(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}

// ─── Hücre veri modeli ────────────────────────────────────────

class _CellData {
  final double x;
  final double y;
  final double radius;
  final bool isAbnormal;
  final double opacity;
  final double hue;

  const _CellData({
    required this.x,
    required this.y,
    required this.radius,
    required this.isAbnormal,
    required this.opacity,
    required this.hue,
  });
}

// ─── Mikroskop çizer ─────────────────────────────────────────

class _MicroscopePainter extends CustomPainter {
  final List<_CellData> cells;
  final Set<int> markedIndices;
  final bool isBlood;
  final bool isSubmitted;
  final String abnormalCellType;

  _MicroscopePainter({
    required this.cells,
    required this.markedIndices,
    required this.isBlood,
    required this.isSubmitted,
    required this.abnormalCellType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Arka plan: koyu lacivert (mikroskop görüntüsü)
    final bgPaint = Paint()
      ..color = isBlood
          ? const Color(0xFF0D1117)
          : const Color(0xFF0A0F18);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Grid çizgileri (graduasyon efekti)
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(
          Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(
          Offset(0, i), Offset(size.width, i), gridPaint);
    }

    for (int i = 0; i < cells.length; i++) {
      final cell = cells[i];
      final isMarked = markedIndices.contains(i);

      if (cell.isAbnormal) {
        _drawAbnormalCell(canvas, cell, isMarked, i);
      } else {
        _drawNormalCell(canvas, cell, isMarked);
      }

      // Sonuçta: anormal hücrelere gösterge
      if (isSubmitted && cell.isAbnormal && !isMarked) {
        _drawMissedIndicator(canvas, cell);
      }
    }
  }

  void _drawNormalCell(Canvas canvas, _CellData cell, bool isMarked) {
    // Normal hücre: gri/soluk daire
    final paint = Paint()
      ..color = (isBlood
              ? const Color(0xFF6D4C5E)
              : const Color(0xFF4A5568))
          .withOpacity(cell.opacity)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(cell.x, cell.y), cell.radius, paint);

    // Kenarlık
    final borderPaint = Paint()
      ..color = (isBlood
              ? const Color(0xFF8B6B7D)
              : const Color(0xFF5A6A7E))
          .withOpacity(cell.opacity * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(Offset(cell.x, cell.y), cell.radius, borderPaint);

    // Nukleus (küçük iç daire)
    final nucleusPaint = Paint()
      ..color = (isBlood
              ? const Color(0xFF4A2F3D)
              : const Color(0xFF2D3748))
          .withOpacity(cell.opacity * 1.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(cell.x, cell.y), cell.radius * 0.35, nucleusPaint);

    // İşaretlenmişse: yeşil halka (yanlış pozitif)
    if (isMarked) {
      _drawMarkRing(canvas, cell, isSubmitted ? const Color(0xFFEF5350) : const Color(0xFF00BFA5));
    }
  }

  void _drawAbnormalCell(
      Canvas canvas, _CellData cell, bool isMarked, int index) {
    // Tip bazlı renk
    final typeColor =
        _MicroscopeScreenState._abnormalColors[abnormalCellType] ??
            const Color(0xFFE53935);

    final paint = Paint()
      ..color = typeColor.withOpacity(cell.opacity)
      ..style = PaintingStyle.fill;

    // Anormal hücre: biraz düzensiz şekil (orak hücre vs.)
    if (abnormalCellType == 'Orak Hücre') {
      _drawSickleCell(canvas, cell, paint);
    } else if (abnormalCellType == 'Bakteri') {
      _drawBacteriaCell(canvas, cell, paint);
    } else if (abnormalCellType == 'Kristal') {
      _drawCrystalCell(canvas, cell, paint);
    } else {
      // Genel anormal hücre: daha parlak daire
      canvas.drawCircle(Offset(cell.x, cell.y), cell.radius, paint);

      // Belirgin nukleus
      final nucleusPaint = Paint()
        ..color = typeColor.withOpacity(0.9)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
          Offset(cell.x, cell.y), cell.radius * 0.5, nucleusPaint);
    }

    // Kenarlık
    final borderPaint = Paint()
      ..color = typeColor.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(Offset(cell.x, cell.y), cell.radius, borderPaint);

    // İşaretlenmişse: yeşil halka
    if (isMarked) {
      _drawMarkRing(canvas, cell, const Color(0xFF00BFA5));
    }
  }

  void _drawSickleCell(Canvas canvas, _CellData cell, Paint paint) {
    // Orak/hilal şekli
    final path = Path();
    final cx = cell.x;
    final cy = cell.y;
    final r = cell.radius;

    path.addArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      -0.5,
      3.14,
    );
    path.arcTo(
      Rect.fromCircle(center: Offset(cx + r * 0.3, cy), radius: r * 0.7),
      2.64,
      -3.14,
      false,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawBacteriaCell(Canvas canvas, _CellData cell, Paint paint) {
    // Çubuk şekli (bakteri)
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cell.x, cell.y),
        width: cell.radius * 2.5,
        height: cell.radius * 0.8,
      ),
      Radius.circular(cell.radius * 0.4),
    );
    canvas.drawRRect(rect, paint);
  }

  void _drawCrystalCell(Canvas canvas, _CellData cell, Paint paint) {
    // Altıgen kristal
    final path = Path();
    final cx = cell.x;
    final cy = cell.y;
    final r = cell.radius;

    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * pi / 180;
      final x = cx + r * cos(angle);
      final y = cy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawMarkRing(Canvas canvas, _CellData cell, Color color) {
    final markPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(
        Offset(cell.x, cell.y), cell.radius + 5, markPaint);

    // Köşe işaretleri
    final crossPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 1.5;
    final r = cell.radius + 10;
    // Artı işareti dış noktalar
    canvas.drawLine(
      Offset(cell.x - r, cell.y),
      Offset(cell.x - r + 6, cell.y),
      crossPaint,
    );
    canvas.drawLine(
      Offset(cell.x + r, cell.y),
      Offset(cell.x + r - 6, cell.y),
      crossPaint,
    );
    canvas.drawLine(
      Offset(cell.x, cell.y - r),
      Offset(cell.x, cell.y - r + 6),
      crossPaint,
    );
    canvas.drawLine(
      Offset(cell.x, cell.y + r),
      Offset(cell.x, cell.y + r - 6),
      crossPaint,
    );
  }

  void _drawMissedIndicator(Canvas canvas, _CellData cell) {
    // Kırmızı kesik çember — kaçırılan hücre
    final paint = Paint()
      ..color = const Color(0xFFEF5350).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(
        Offset(cell.x, cell.y), cell.radius + 8, paint);

    // X işareti
    final xPaint = Paint()
      ..color = const Color(0xFFEF5350).withOpacity(0.5)
      ..strokeWidth = 1.5;
    final d = cell.radius * 0.5;
    canvas.drawLine(
      Offset(cell.x - d, cell.y - d),
      Offset(cell.x + d, cell.y + d),
      xPaint,
    );
    canvas.drawLine(
      Offset(cell.x + d, cell.y - d),
      Offset(cell.x - d, cell.y + d),
      xPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MicroscopePainter oldDelegate) {
    return oldDelegate.markedIndices != markedIndices ||
        oldDelegate.isSubmitted != isSubmitted;
  }
}

// ─── Vignet efekti ────────────────────────────────────────────

class _VignettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));

    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.7,
        colors: [
          Colors.transparent,
          Colors.transparent,
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.7),
        ],
        stops: const [0.0, 0.5, 0.8, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: maxRadius),
      );

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
