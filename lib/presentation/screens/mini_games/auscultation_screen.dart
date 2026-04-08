import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// Oskültasyon (Stetoskop) Mini Oyunu
///
/// Oyuncu torso üzerindeki oskültasyon noktalarına dokunarak
/// kalp ve akciğer seslerini dinler, anormallikleri tespit eder
/// ve doğru tanıyı seçer.
class AuscultationScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const AuscultationScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<AuscultationScreen> createState() =>
      _AuscultationScreenState();
}

class _AuscultationScreenState extends ConsumerState<AuscultationScreen>
    with TickerProviderStateMixin {
  // Theme colors
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);

  // State
  final Map<String, bool> _examinedPoints = {};
  String? _listeningPointId;
  bool _isListening = false;
  String? _selectedDiagnosis;
  bool _isSubmitted = false;
  bool _isDiagnosisCorrect = false;
  int _remainingSeconds = 0;
  Timer? _timer;
  Timer? _listenTimer;

  // Animations
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;

  // Point definitions with normalized positions (0-1) on torso
  static const Map<String, _AuscPoint> _pointPositions = {
    'aortic': _AuscPoint(
      x: 0.40,
      y: 0.22,
      label: 'Aortik',
      region: 'cardiac',
    ),
    'pulmonic': _AuscPoint(
      x: 0.60,
      y: 0.22,
      label: 'Pulmonik',
      region: 'cardiac',
    ),
    'tricuspid': _AuscPoint(
      x: 0.52,
      y: 0.38,
      label: 'Triküspit',
      region: 'cardiac',
    ),
    'mitral': _AuscPoint(
      x: 0.40,
      y: 0.42,
      label: 'Mitral',
      region: 'cardiac',
    ),
    'right_upper_lung': _AuscPoint(
      x: 0.32,
      y: 0.18,
      label: 'Sağ Üst Akciğer',
      region: 'lung',
    ),
    'right_lower_lung': _AuscPoint(
      x: 0.30,
      y: 0.45,
      label: 'Sağ Alt Akciğer',
      region: 'lung',
    ),
    'left_upper_lung': _AuscPoint(
      x: 0.68,
      y: 0.18,
      label: 'Sol Üst Akciğer',
      region: 'lung',
    ),
    'left_lower_lung': _AuscPoint(
      x: 0.70,
      y: 0.45,
      label: 'Sol Alt Akciğer',
      region: 'lung',
    ),
  };

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();

    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 90;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _listenTimer?.cancel();
    _pulseController.dispose();
    _waveController.dispose();
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
    setState(() {
      _isSubmitted = true;
      _isDiagnosisCorrect = false;
    });
    HapticFeedback.heavyImpact();
    _submitResult(0);
  }

  List<AuscultationFinding> get _findings => widget.miniGame.auscultationFindings;

  AuscultationFinding? _findingForPoint(String pointId) {
    try {
      return _findings.firstWhere((f) => f.pointId == pointId);
    } catch (_) {
      return null;
    }
  }

  bool get _allPointsExamined {
    // All points that have findings must be examined
    for (final f in _findings) {
      if (!_examinedPoints.containsKey(f.pointId)) return false;
    }
    return true;
  }

  int get _correctAbnormalCount {
    int count = 0;
    for (final f in _findings) {
      if (f.isAbnormal && _examinedPoints.containsKey(f.pointId)) {
        count++;
      }
    }
    return count;
  }

  int get _totalAbnormalCount {
    return _findings.where((f) => f.isAbnormal).length;
  }

  void _onPointTap(String pointId) {
    if (_isSubmitted || _isListening || _examinedPoints.containsKey(pointId)) {
      return;
    }

    HapticFeedback.lightImpact();

    setState(() {
      _listeningPointId = pointId;
      _isListening = true;
    });

    // Simulate listening for 2 seconds
    _listenTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      final finding = _findingForPoint(pointId);
      setState(() {
        _isListening = false;
        _examinedPoints[pointId] = finding?.isAbnormal ?? false;
        _listeningPointId = null;
      });
      if (finding != null && finding.isAbnormal) {
        HapticFeedback.mediumImpact();
      }
    });
  }

  void _handleDiagnosisSubmit() {
    if (_selectedDiagnosis == null || _isSubmitted) return;

    final isCorrect =
        _selectedDiagnosis == widget.miniGame.auscultationCorrectDiagnosis;

    setState(() {
      _isSubmitted = true;
      _isDiagnosisCorrect = isCorrect;
    });

    _timer?.cancel();

    if (isCorrect) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    // Scoring: each correct abnormal = 150, correct diagnosis = 400, time bonus up to 200
    int score = 0;
    score += _correctAbnormalCount * 150;
    if (isCorrect) score += 400;

    // Time bonus
    final maxTime = widget.miniGame.timeLimitSeconds ?? 90;
    final timeBonus = (_remainingSeconds / maxTime * 200).round();
    score += timeBonus;

    _submitResult(score.clamp(0, 1000));
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'auscultation',
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
    final isUrgent = _remainingSeconds < 20;
    final timerColor = isUrgent ? _red : _amber;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          widget.miniGame.title.isNotEmpty
              ? widget.miniGame.title
              : 'Oskültasyon',
          style:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info card
            _buildInfoCard(),
            const SizedBox(height: 16),

            // Progress indicator
            _buildProgressBar(),
            const SizedBox(height: 16),

            // Torso with auscultation points
            _buildTorsoSection(),
            const SizedBox(height: 16),

            // Listening indicator
            if (_isListening) _buildListeningIndicator(),

            // Examined findings list
            if (_examinedPoints.isNotEmpty) ...[
              _buildFindingsList(),
              const SizedBox(height: 16),
            ],

            // Diagnosis section (appears after all points examined)
            if (_allPointsExamined && !_isSubmitted) ...[
              _buildDiagnosisSection(),
              const SizedBox(height: 24),
            ],

            // Result card
            if (_isSubmitted) ...[
              _buildResultCard(),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _teal.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _teal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hearing, color: _teal, size: 24),
              const SizedBox(width: 10),
              Text(
                'OSKÜLTASYON MUAYENESİ',
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _teal,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.miniGame.description.isNotEmpty
                ? widget.miniGame.description
                : 'Stetoskop ile hastanın göğüs bölgesini dinleyin. '
                    'Tüm oskültasyon noktalarını inceleyin ve anormal '
                    'sesleri tespit edin. Ardından doğru tanıyı seçin.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final examined = _examinedPoints.length;
    final total = _findings.length;
    final progress = total > 0 ? examined / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(Icons.hearing, color: _teal, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İncelenen Noktalar: $examined / $total',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white10,
                    color: _teal,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (_examinedPoints.values.any((v) => v))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Anormal: $_correctAbnormalCount',
                style: GoogleFonts.robotoMono(
                  fontSize: 11,
                  color: _red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTorsoSection() {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 0.75,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;

              return Stack(
                children: [
                  // Torso drawing
                  CustomPaint(
                    size: Size(width, height),
                    painter: _TorsoPainter(),
                  ),

                  // Auscultation points
                  for (final entry in _pointPositions.entries)
                    if (_findings.any((f) => f.pointId == entry.key))
                      _buildAuscultationPoint(
                        entry.key,
                        entry.value,
                        width,
                        height,
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAuscultationPoint(
    String pointId,
    _AuscPoint point,
    double width,
    double height,
  ) {
    final isExamined = _examinedPoints.containsKey(pointId);
    final isAbnormal = _examinedPoints[pointId] ?? false;
    final isCurrentlyListening = _listeningPointId == pointId;

    Color pointColor;
    if (isExamined) {
      pointColor = isAbnormal ? _red : _green;
    } else if (isCurrentlyListening) {
      pointColor = _amber;
    } else {
      pointColor = _teal;
    }

    final left = point.x * width - 20;
    final top = point.y * height - 20;

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => _onPointTap(pointId),
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final scale =
                (!isExamined && !isCurrentlyListening) ? _pulseAnimation.value : 1.0;
            return Transform.scale(
              scale: isCurrentlyListening ? 1.3 : scale,
              child: child,
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pointColor.withOpacity(isExamined ? 0.25 : 0.15),
              border: Border.all(
                color: pointColor,
                width: isCurrentlyListening ? 3 : 2,
              ),
              boxShadow: [
                if (!isExamined || isCurrentlyListening)
                  BoxShadow(
                    color: pointColor.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: Center(
              child: isExamined
                  ? Icon(
                      isAbnormal ? Icons.warning : Icons.check,
                      color: pointColor,
                      size: 18,
                    )
                  : isCurrentlyListening
                      ? _buildWaveformIcon(pointColor)
                      : Icon(
                          point.region == 'cardiac'
                              ? Icons.favorite
                              : Icons.air,
                          color: pointColor,
                          size: 16,
                        ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWaveformIcon(Color color) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = (_waveController.value + i * 0.33) % 1.0;
            final barHeight = 6 + sin(phase * pi * 2) * 6;
            return Container(
              width: 3,
              height: barHeight.abs(),
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildListeningIndicator() {
    if (_listeningPointId == null) return const SizedBox.shrink();
    final point = _pointPositions[_listeningPointId];
    if (point == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _amber.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: _waveController,
            builder: (context, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (i) {
                  final phase = (_waveController.value + i * 0.2) % 1.0;
                  final barHeight = 8 + sin(phase * pi * 2) * 10;
                  return Container(
                    width: 4,
                    height: barHeight.abs(),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: _amber,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dinleniyor...',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _amber,
                  ),
                ),
                Text(
                  point.label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _amber,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFindingsList() {
    final examinedFindings = _findings
        .where((f) => _examinedPoints.containsKey(f.pointId))
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BULGULAR',
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _teal,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          ...examinedFindings.map((f) {
            final point = _pointPositions[f.pointId];
            final label = point?.label ?? f.pointId;
            final isAbnormal = f.isAbnormal;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: (isAbnormal ? _red : _green).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (isAbnormal ? _red : _green).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isAbnormal ? Icons.warning_amber : Icons.check_circle,
                    color: isAbnormal ? _red : _green,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          isAbnormal
                              ? 'Anormal: ${_soundTypeLabel(f.soundType)}'
                              : 'Normal ses',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: isAbnormal
                                ? _red.withOpacity(0.8)
                                : _green.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (isAbnormal ? _red : _green).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isAbnormal ? 'ANORMAL' : 'NORMAL',
                      style: GoogleFonts.robotoMono(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: isAbnormal ? _red : _green,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _soundTypeLabel(String soundType) {
    switch (soundType.toLowerCase()) {
      case 'ral':
        return 'Ral (Krepitan)';
      case 'ronkus':
        return 'Ronküs';
      case 'üfürüm':
        return 'Üfürüm';
      case 'wheezing':
        return 'Wheezing';
      case 'stridor':
        return 'Stridor';
      case 'normal':
        return 'Normal';
      default:
        return soundType;
    }
  }

  Widget _buildDiagnosisSection() {
    final options = widget.miniGame.auscultationDiagnosisOptions;
    if (options.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _amber.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _amber.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.psychology, color: _amber, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Tüm noktalar incelendi. Bulgulara göre tanı koyun.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: _amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'TANI SEÇİN',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        ...options.map((option) {
          final isSelected = _selectedDiagnosis == option;
          return GestureDetector(
            onTap: () => setState(() => _selectedDiagnosis = option),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? _teal.withOpacity(0.08)
                    : _surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? _teal : Colors.white10,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? _teal : Colors.white24,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed:
                _selectedDiagnosis == null ? null : _handleDiagnosisSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedDiagnosis == null ? Colors.grey.shade800 : _teal,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'TANIYI ONAYLA',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (_isDiagnosisCorrect ? _green : _red).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (_isDiagnosisCorrect ? _green : _red).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _isDiagnosisCorrect
                ? Icons.check_circle_outline
                : Icons.error_outline,
            size: 48,
            color: _isDiagnosisCorrect ? _green : _red,
          ),
          const SizedBox(height: 12),
          Text(
            _isDiagnosisCorrect ? 'DOĞRU TANI!' : 'YANLIŞ TANI!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isDiagnosisCorrect ? _green : _red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isDiagnosisCorrect
                ? 'Oskültasyon bulgularını doğru değerlendirdiniz.'
                : _remainingSeconds <= 0
                    ? 'Süre doldu! Muayene zamanında tamamlanamadı.'
                    : 'Doğru tanı: ${widget.miniGame.auscultationCorrectDiagnosis ?? ""}',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ResultStat(
                  label: 'Anormal Tespit',
                  value: '$_correctAbnormalCount / $_totalAbnormalCount',
                  color: _correctAbnormalCount == _totalAbnormalCount
                      ? _green
                      : _amber,
                ),
                Container(width: 1, height: 30, color: Colors.white12),
                _ResultStat(
                  label: 'Tanı',
                  value: _isDiagnosisCorrect ? 'Doğru' : 'Yanlış',
                  color: _isDiagnosisCorrect ? _green : _red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Torso CustomPainter — simple medical torso outline
class _TorsoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final w = size.width;
    final h = size.height;

    // Torso outline
    final torsoPath = Path();

    // Neck
    torsoPath.moveTo(w * 0.45, h * 0.02);
    torsoPath.lineTo(w * 0.45, h * 0.06);
    torsoPath.moveTo(w * 0.55, h * 0.02);
    torsoPath.lineTo(w * 0.55, h * 0.06);

    // Neck top curve
    torsoPath.moveTo(w * 0.45, h * 0.02);
    torsoPath.quadraticBezierTo(w * 0.5, h * 0.0, w * 0.55, h * 0.02);

    // Shoulders
    torsoPath.moveTo(w * 0.45, h * 0.06);
    torsoPath.quadraticBezierTo(w * 0.35, h * 0.06, w * 0.18, h * 0.10);
    torsoPath.lineTo(w * 0.12, h * 0.14);

    torsoPath.moveTo(w * 0.55, h * 0.06);
    torsoPath.quadraticBezierTo(w * 0.65, h * 0.06, w * 0.82, h * 0.10);
    torsoPath.lineTo(w * 0.88, h * 0.14);

    // Left side (right on screen)
    torsoPath.moveTo(w * 0.12, h * 0.14);
    torsoPath.lineTo(w * 0.15, h * 0.35);
    torsoPath.quadraticBezierTo(w * 0.16, h * 0.50, w * 0.22, h * 0.60);
    torsoPath.lineTo(w * 0.30, h * 0.70);

    // Right side (left on screen)
    torsoPath.moveTo(w * 0.88, h * 0.14);
    torsoPath.lineTo(w * 0.85, h * 0.35);
    torsoPath.quadraticBezierTo(w * 0.84, h * 0.50, w * 0.78, h * 0.60);
    torsoPath.lineTo(w * 0.70, h * 0.70);

    // Bottom (waist)
    torsoPath.moveTo(w * 0.30, h * 0.70);
    torsoPath.quadraticBezierTo(w * 0.50, h * 0.72, w * 0.70, h * 0.70);

    canvas.drawPath(torsoPath, paint);

    // Rib suggestions (subtle)
    final ribPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final y = h * (0.15 + i * 0.08);
      final ribPath = Path();

      // Left rib
      ribPath.moveTo(w * 0.50, y);
      ribPath.quadraticBezierTo(
        w * 0.35,
        y + h * 0.02,
        w * 0.20,
        y + h * 0.04,
      );

      // Right rib
      ribPath.moveTo(w * 0.50, y);
      ribPath.quadraticBezierTo(
        w * 0.65,
        y + h * 0.02,
        w * 0.80,
        y + h * 0.04,
      );

      canvas.drawPath(ribPath, ribPaint);
    }

    // Sternum (center line)
    final sternumPaint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawLine(
      Offset(w * 0.50, h * 0.06),
      Offset(w * 0.50, h * 0.52),
      sternumPaint,
    );

    // Heart region hint (very subtle)
    final heartPaint = Paint()
      ..color = const Color(0xFFEF5350).withOpacity(0.04)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.45, h * 0.30),
        width: w * 0.18,
        height: h * 0.18,
      ),
      heartPaint,
    );

    // Lung region hints (very subtle)
    final lungPaint = Paint()
      ..color = const Color(0xFF00BFA5).withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Left lung
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.32, h * 0.30),
        width: w * 0.20,
        height: h * 0.30,
      ),
      lungPaint,
    );

    // Right lung
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.68, h * 0.30),
        width: w * 0.20,
        height: h * 0.30,
      ),
      lungPaint,
    );

    // Labels
    final labelPaint = TextPainter(textDirection: TextDirection.ltr);

    // "KALP" label
    labelPaint.text = TextSpan(
      text: 'KALP',
      style: TextStyle(
        color: Colors.white.withOpacity(0.08),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
    labelPaint.layout();
    labelPaint.paint(
      canvas,
      Offset(w * 0.45 - labelPaint.width / 2, h * 0.55),
    );

    // "SAĞ AKCİĞER" label
    labelPaint.text = TextSpan(
      text: 'SAĞ AC',
      style: TextStyle(
        color: Colors.white.withOpacity(0.06),
        fontSize: 9,
        letterSpacing: 1,
      ),
    );
    labelPaint.layout();
    labelPaint.paint(
      canvas,
      Offset(w * 0.28 - labelPaint.width / 2, h * 0.58),
    );

    // "SOL AKCİĞER" label
    labelPaint.text = TextSpan(
      text: 'SOL AC',
      style: TextStyle(
        color: Colors.white.withOpacity(0.06),
        fontSize: 9,
        letterSpacing: 1,
      ),
    );
    labelPaint.layout();
    labelPaint.paint(
      canvas,
      Offset(w * 0.72 - labelPaint.width / 2, h * 0.58),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Auscultation point definition
class _AuscPoint {
  final double x;
  final double y;
  final String label;
  final String region; // 'cardiac' or 'lung'

  const _AuscPoint({
    required this.x,
    required this.y,
    required this.label,
    required this.region,
  });
}

class _ResultStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ResultStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
