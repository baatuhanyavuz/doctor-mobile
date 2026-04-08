import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// CPR Ritim Mini Oyunu
///
/// Guitar Hero tarzı ritim oyunu. Oyuncu göğüs kompresyonu
/// simüle ederek doğru BPM'de (100-120/dk) ritmik basış yapar.
class CprRhythmScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const CprRhythmScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<CprRhythmScreen> createState() => _CprRhythmScreenState();
}

class _CprRhythmScreenState extends ConsumerState<CprRhythmScreen>
    with TickerProviderStateMixin {
  // Theme colors
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);

  // Game state
  final List<int> _tapTimestamps = [];
  final List<_CompressionResult> _compressions = [];
  int _currentBPM = 0;
  int _perfectCount = 0;
  int _goodCount = 0;
  int _offCount = 0;
  int _currentStreak = 0;
  int _bestStreak = 0;
  bool _isFinished = false;
  bool _isStarted = false;
  String _feedbackText = '';
  Color _feedbackColor = Colors.white54;
  Timer? _missedBeatTimer;
  Timer? _feedbackTimer;

  // Animations
  late AnimationController _buttonPulseController;
  late AnimationController _rippleController;
  late AnimationController _metronomeController;
  late AnimationController _bgPulseController;
  late Animation<double> _buttonScale;
  late Animation<double> _rippleSize;
  late Animation<double> _rippleOpacity;
  late Animation<double> _metronomeValue;

  // Derived from miniGame
  int get _targetBPM => widget.miniGame.targetBPM;
  int get _totalCompressions => widget.miniGame.compressionCount;
  int get _tolerance => widget.miniGame.bpmTolerance;

  int get _compressionsDone => _compressions.length;
  double get _progress =>
      _totalCompressions > 0 ? _compressionsDone / _totalCompressions : 0.0;

  @override
  void initState() {
    super.initState();

    _buttonPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(
          parent: _buttonPulseController, curve: Curves.easeInOut),
    );

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _rippleSize = Tween<double>(begin: 1.0, end: 2.5).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );
    _rippleOpacity = Tween<double>(begin: 0.6, end: 0.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    _metronomeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (60000 / _targetBPM).round()),
    )..repeat(reverse: true);
    _metronomeValue = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _metronomeController, curve: Curves.easeInOut),
    );

    _bgPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _missedBeatTimer?.cancel();
    _feedbackTimer?.cancel();
    _buttonPulseController.dispose();
    _rippleController.dispose();
    _metronomeController.dispose();
    _bgPulseController.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_isFinished) return;

    final now = DateTime.now().millisecondsSinceEpoch;

    if (!_isStarted) {
      setState(() => _isStarted = true);
    }

    _tapTimestamps.add(now);

    // Trigger button animation
    _buttonPulseController.forward().then((_) {
      if (mounted) _buttonPulseController.reverse();
    });

    // Trigger ripple
    _rippleController.reset();
    _rippleController.forward();

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Reset missed beat timer
    _missedBeatTimer?.cancel();
    _missedBeatTimer = Timer(const Duration(milliseconds: 750), () {
      if (!mounted || _isFinished) return;
      _showFeedback('KAÇIRDIN!', _red);
    });

    // Calculate BPM from last 2 taps
    _CompressionResult result;
    if (_tapTimestamps.length >= 2) {
      final lastInterval =
          _tapTimestamps.last - _tapTimestamps[_tapTimestamps.length - 2];
      final instantBPM =
          lastInterval > 0 ? (60000 / lastInterval).round() : 0;

      setState(() => _currentBPM = instantBPM);

      final perfectLow = _targetBPM - (_tolerance ~/ 2);
      final perfectHigh = _targetBPM + (_tolerance ~/ 2);
      final goodLow = _targetBPM - _tolerance;
      final goodHigh = _targetBPM + _tolerance;

      if (instantBPM >= perfectLow && instantBPM <= perfectHigh) {
        result = _CompressionResult.perfect;
        _perfectCount++;
        _currentStreak++;
        _showFeedback('Harika!', _green);
        _bgPulseController.forward().then((_) {
          if (mounted) _bgPulseController.reverse();
        });
      } else if (instantBPM >= goodLow && instantBPM <= goodHigh) {
        result = _CompressionResult.good;
        _goodCount++;
        _currentStreak++;
        _showFeedback('İyi!', _teal);
        _bgPulseController.forward().then((_) {
          if (mounted) _bgPulseController.reverse();
        });
      } else if (instantBPM > goodHigh) {
        result = _CompressionResult.off;
        _offCount++;
        _currentStreak = 0;
        _showFeedback('Hızlı!', _amber);
      } else {
        result = _CompressionResult.off;
        _offCount++;
        _currentStreak = 0;
        _showFeedback('Yavaş!', _red);
      }
    } else {
      // First tap — no BPM yet
      result = _CompressionResult.good;
      _goodCount++;
      _currentStreak = 1;
      _showFeedback('Devam Et!', _teal);
    }

    if (_currentStreak > _bestStreak) {
      _bestStreak = _currentStreak;
    }

    setState(() {
      _compressions.add(result);
    });

    // Check completion
    if (_compressionsDone >= _totalCompressions) {
      _missedBeatTimer?.cancel();
      setState(() => _isFinished = true);
      _calculateAndSubmit();
    }
  }

  void _showFeedback(String text, Color color) {
    _feedbackTimer?.cancel();
    setState(() {
      _feedbackText = text;
      _feedbackColor = color;
    });
    _feedbackTimer = Timer(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() => _feedbackText = '');
      }
    });
  }

  void _calculateAndSubmit() {
    // Scoring: perfect=30, good=20, off=5, streak bonus
    int score = 0;
    score += _perfectCount * 30;
    score += _goodCount * 20;
    score += _offCount * 5;

    // Streak bonus: 5+ perfect in a row = +100
    if (_bestStreak >= 5) {
      score += 100;
    }

    _submitResult(score.clamp(0, 1000));
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'cpr_rhythm',
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

  Color get _bpmColor {
    if (_currentBPM == 0) return Colors.white24;
    final goodLow = _targetBPM - _tolerance;
    final goodHigh = _targetBPM + _tolerance;
    final perfectLow = _targetBPM - (_tolerance ~/ 2);
    final perfectHigh = _targetBPM + (_tolerance ~/ 2);

    if (_currentBPM >= perfectLow && _currentBPM <= perfectHigh) return _green;
    if (_currentBPM >= goodLow && _currentBPM <= goodHigh) return _teal;
    if (_currentBPM > goodHigh) return _amber;
    return _red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          widget.miniGame.title.isNotEmpty ? widget.miniGame.title : 'CPR',
          style:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          // BPM Badge
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _bpmColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _bpmColor.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Icon(Icons.favorite, color: _bpmColor, size: 16),
                const SizedBox(width: 4),
                Text(
                  '$_currentBPM BPM',
                  style: GoogleFonts.robotoMono(
                    color: _bpmColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _bgPulseController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: _bgColor,
              gradient: _bgPulseController.isAnimating
                  ? RadialGradient(
                      center: Alignment.center,
                      radius: 1.2,
                      colors: [
                        _red.withOpacity(0.06 * _bgPulseController.value),
                        _bgColor,
                      ],
                    )
                  : null,
            ),
            child: child,
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              // BPM Display + Target Zone
              _buildBPMSection(),

              // Metronome bar
              _buildMetronomeBar(),

              const SizedBox(height: 8),

              // Feedback text
              _buildFeedbackText(),

              // Main tap area
              Expanded(child: _buildTapArea()),

              // Progress + Stats
              _buildBottomStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBPMSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // BPM Number
          Text(
            _isStarted ? '$_currentBPM' : '--',
            style: GoogleFonts.robotoMono(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _isStarted ? _bpmColor : Colors.white24,
              height: 1.0,
            ),
          ),
          Text(
            'BPM',
            style: GoogleFonts.robotoMono(
              fontSize: 14,
              color: Colors.white38,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 12),

          // Target zone indicator
          _buildTargetZoneBar(),

          const SizedBox(height: 8),

          // Target label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _green.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Hedef: ${_targetBPM - _tolerance} - ${_targetBPM + _tolerance} BPM',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetZoneBar() {
    return SizedBox(
      height: 20,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Map BPM range 60-160 to bar width
          const minBPM = 60.0;
          const maxBPM = 160.0;
          const range = maxBPM - minBPM;

          double bpmToX(double bpm) =>
              ((bpm - minBPM) / range * width).clamp(0, width);

          final goodLeft = bpmToX((_targetBPM - _tolerance).toDouble());
          final goodRight = bpmToX((_targetBPM + _tolerance).toDouble());
          final perfectLeft = bpmToX((_targetBPM - _tolerance / 2).toDouble());
          final perfectRight =
              bpmToX((_targetBPM + _tolerance / 2).toDouble());
          final currentX =
              _currentBPM > 0 ? bpmToX(_currentBPM.toDouble()) : -10.0;

          return Stack(
            children: [
              // Background bar
              Container(
                width: width,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              // Good zone
              Positioned(
                left: goodLeft,
                top: 6,
                child: Container(
                  width: (goodRight - goodLeft).clamp(0, width),
                  height: 8,
                  decoration: BoxDecoration(
                    color: _teal.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // Perfect zone
              Positioned(
                left: perfectLeft,
                top: 6,
                child: Container(
                  width: (perfectRight - perfectLeft).clamp(0, width),
                  height: 8,
                  decoration: BoxDecoration(
                    color: _green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              // Current BPM indicator
              if (_currentBPM > 0)
                Positioned(
                  left: (currentX - 6).clamp(0, width - 12),
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _bpmColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: _bpmColor.withOpacity(0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMetronomeBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _surfaceColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AnimatedBuilder(
        animation: _metronomeValue,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final indicatorX =
                  ((_metronomeValue.value + 1) / 2) * (width - 16);

              return SizedBox(
                height: 12,
                child: Stack(
                  children: [
                    // Track
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 5,
                      child: Container(
                        height: 2,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    // Center mark
                    Positioned(
                      left: width / 2 - 1,
                      top: 2,
                      child: Container(
                        width: 2,
                        height: 8,
                        color: _teal.withOpacity(0.4),
                      ),
                    ),
                    // Moving indicator
                    Positioned(
                      left: indicatorX,
                      top: 0,
                      child: Container(
                        width: 16,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _teal.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildFeedbackText() {
    return SizedBox(
      height: 40,
      child: Center(
        child: AnimatedOpacity(
          opacity: _feedbackText.isNotEmpty ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            _feedbackText,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _feedbackColor,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTapArea() {
    return GestureDetector(
      onTapDown: (_) => _onTap(),
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ripple effect
            AnimatedBuilder(
              animation: _rippleController,
              builder: (context, _) {
                if (!_rippleController.isAnimating) {
                  return const SizedBox.shrink();
                }
                return Container(
                  width: 140 * _rippleSize.value,
                  height: 140 * _rippleSize.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _bpmColor.withOpacity(_rippleOpacity.value),
                      width: 2,
                    ),
                  ),
                );
              },
            ),

            // Outer ring
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isStarted
                      ? _bpmColor.withOpacity(0.3)
                      : _teal.withOpacity(0.2),
                  width: 2,
                ),
              ),
            ),

            // Main button
            AnimatedBuilder(
              animation: _buttonScale,
              builder: (context, child) {
                return Transform.scale(
                  scale: _buttonScale.value,
                  child: child,
                );
              },
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (_isStarted ? _bpmColor : _teal).withOpacity(0.3),
                      (_isStarted ? _bpmColor : _teal).withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: (_isStarted ? _bpmColor : _teal).withOpacity(0.6),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isStarted ? _bpmColor : _teal).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: _isStarted ? _bpmColor : _teal,
                      size: 40,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isStarted ? 'BAS' : 'BAŞLA',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomStats() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: _surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        children: [
          // Progress bar
          Row(
            children: [
              Text(
                'Kompresyon',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
              const Spacer(),
              Text(
                '$_compressionsDone / $_totalCompressions',
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _teal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.white10,
              color: _teal,
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatBadge(
                icon: Icons.star,
                label: 'Harika',
                value: '$_perfectCount',
                color: _green,
              ),
              _StatBadge(
                icon: Icons.thumb_up,
                label: 'İyi',
                value: '$_goodCount',
                color: _teal,
              ),
              _StatBadge(
                icon: Icons.close,
                label: 'Kaçık',
                value: '$_offCount',
                color: _red,
              ),
              _StatBadge(
                icon: Icons.local_fire_department,
                label: 'Seri',
                value: '$_currentStreak',
                color: _amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _CompressionResult { perfect, good, off }

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 14),
              Text(
                value,
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}
