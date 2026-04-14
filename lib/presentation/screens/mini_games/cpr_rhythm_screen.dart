import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// CPR Ritim Mini Oyunu
///
/// Bir bar soldan sağa gidip gelir. Ortadaki yeşil bölgeye
/// geldiğinde tıkla — tam zamanlamayla göğüs basısı yap.
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
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);

  // Oyun durumu
  int _perfectCount = 0;
  int _goodCount = 0;
  int _offCount = 0;
  int _missCount = 0;
  int _currentStreak = 0;
  int _bestStreak = 0;
  bool _isFinished = false;
  bool _isStarted = false;
  String _feedbackText = '';
  Color _feedbackColor = Colors.white54;
  Timer? _feedbackTimer;

  // Bar animasyonu
  late AnimationController _barController;
  late Animation<double> _barPosition; // 0.0 (sol) → 1.0 (sağ)

  // Buton animasyonu
  late AnimationController _buttonPulseController;
  late Animation<double> _buttonScale;

  // Nabız efekti
  late AnimationController _heartbeatController;

  // Kaçırma sayacı — bar ortadan geçtiyse ve tıklanmadıysa
  bool _canTapThisCycle = true;

  int get _targetBPM => widget.miniGame.targetBPM;
  int get _totalCompressions => widget.miniGame.compressionCount;
  int get _compressionsDone => _perfectCount + _goodCount + _offCount + _missCount;
  double get _progress =>
      _totalCompressions > 0 ? _compressionsDone / _totalCompressions : 0.0;

  /// Bar hızı: hedef BPM'e göre bir tam salınım süresi
  /// 110 BPM = ~545ms per beat → bar bir gidip gelme ~545ms
  int get _barDurationMs => (60000 / _targetBPM).round();

  @override
  void initState() {
    super.initState();

    _barController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _barDurationMs),
    );

    _barPosition = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _barController, curve: Curves.easeInOut),
    );

    _buttonPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _buttonScale = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _buttonPulseController, curve: Curves.easeInOut),
    );

    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Bar gidip-gelme ve kaçırma kontrolü
    _barController.addStatusListener(_onBarStatus);
  }

  void _onBarStatus(AnimationStatus status) {
    if (_isFinished) return;

    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      // Bar bir uça ulaştı — eğer ortadan geçip tıklanmadıysa = kaçırdı
      if (!_canTapThisCycle && _isStarted) {
        // Zaten tıklandı bu cycle'da, sorun yok
      }

      // Eğer bar ortadan geçti ama tıklanmadıysa (ileriki kontrolde)
      if (_isStarted && _canTapThisCycle) {
        // Bir önceki yarım salınımda tıklama olmadı mı kontrol et
        // Bu durumu _canTapThisCycle ile takip ediyoruz
      }

      // Yeni cycle başlat
      _canTapThisCycle = true;

      if (status == AnimationStatus.completed) {
        _barController.reverse();
      } else {
        _barController.forward();
      }
    }
  }

  void _startGame() {
    setState(() => _isStarted = true);
    _barController.forward();
    // Kaçırma kontrolü: her yarım beat'te bir kontrol
    Timer.periodic(Duration(milliseconds: _barDurationMs), (timer) {
      if (_isFinished || !mounted) {
        timer.cancel();
        return;
      }
      // Eğer bu cycle'da tıklanmadıysa miss say
      if (_canTapThisCycle && _isStarted) {
        _registerMiss();
      }
      _canTapThisCycle = true;
    });
  }

  void _registerMiss() {
    _missCount++;
    _currentStreak = 0;
    _showFeedback('KAÇIRDIN!', _red);
    HapticFeedback.heavyImpact();

    if (_compressionsDone >= _totalCompressions) {
      _finishGame();
    }
  }

  @override
  void dispose() {
    _feedbackTimer?.cancel();
    _barController.dispose();
    _buttonPulseController.dispose();
    _heartbeatController.dispose();
    super.dispose();
  }

  void _onTap() {
    if (_isFinished) return;

    if (!_isStarted) {
      _startGame();
      return;
    }

    if (!_canTapThisCycle) return; // Bu cycle'da zaten tıkladı
    _canTapThisCycle = false;

    // Buton animasyonu
    _buttonPulseController.forward().then((_) {
      if (mounted) _buttonPulseController.reverse();
    });
    _heartbeatController.forward(from: 0);
    HapticFeedback.lightImpact();

    // Bar pozisyonuna göre skor hesapla
    // 0.0 = sol uç, 0.5 = orta (perfect), 1.0 = sağ uç
    final pos = _barPosition.value;
    final distFromCenter = (pos - 0.5).abs(); // 0 = tam orta, 0.5 = uçta

    _CompressionResult result;
    if (distFromCenter <= 0.08) {
      // Tam orta — Perfect!
      result = _CompressionResult.perfect;
      _perfectCount++;
      _currentStreak++;
      _showFeedback('Harika!', _green);
    } else if (distFromCenter <= 0.18) {
      // Yakın — Good
      result = _CompressionResult.good;
      _goodCount++;
      _currentStreak++;
      _showFeedback('İyi!', _teal);
    } else {
      // Uzak — Off
      result = _CompressionResult.off;
      _offCount++;
      _currentStreak = 0;
      if (pos < 0.5) {
        _showFeedback('Erken!', _amber);
      } else {
        _showFeedback('Geç!', _amber);
      }
    }

    if (_currentStreak > _bestStreak) {
      _bestStreak = _currentStreak;
    }

    setState(() {});

    if (_compressionsDone >= _totalCompressions) {
      _finishGame();
    }
  }

  void _finishGame() {
    _barController.stop();
    setState(() => _isFinished = true);
    _calculateAndSubmit();
  }

  void _showFeedback(String text, Color color) {
    _feedbackTimer?.cancel();
    setState(() {
      _feedbackText = text;
      _feedbackColor = color;
    });
    _feedbackTimer = Timer(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _feedbackText = '');
    });
  }

  void _calculateAndSubmit() {
    int score = 0;
    score += _perfectCount * 30;
    score += _goodCount * 20;
    score += _offCount * 5;
    // Miss = 0 puan
    if (_bestStreak >= 5) score += 100;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          widget.miniGame.title.isNotEmpty ? widget.miniGame.title : 'CPR',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTapDown: (_) => _onTap(),
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Feedback metin
              SizedBox(
                height: 44,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _feedbackText.isNotEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: Text(
                      _feedbackText,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _feedbackColor,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // === ANA RİTİM BARI ===
              _buildRhythmBar(),
              const SizedBox(height: 8),

              // Açıklama
              Text(
                _isStarted ? 'Yeşil bölgeye geldiğinde TIKLA!' : 'Başlamak için dokun',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white38,
                ),
              ),
              const SizedBox(height: 24),

              // Kalp butonu
              Expanded(child: _buildHeartArea()),

              // Alt istatistik
              _buildBottomStats(),
            ],
          ),
        ),
      ),
    );
  }

  /// Soldan sağa gidip gelen ritim barı — ortası yeşil hedef bölge
  Widget _buildRhythmBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 64,
      child: AnimatedBuilder(
        animation: _barPosition,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final indicatorX = _barPosition.value * (width - 20);

              // Hedef bölge: ortanın %16'lık kısmı (perfect) ve %36'lık kısmı (good)
              final perfectLeft = width * 0.42;
              final perfectRight = width * 0.58;
              final goodLeft = width * 0.32;
              final goodRight = width * 0.68;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Arka plan bar
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 20,
                    child: Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                    ),
                  ),

                  // Good bölge (teal)
                  Positioned(
                    left: goodLeft,
                    top: 20,
                    child: Container(
                      width: goodRight - goodLeft,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _teal.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // Perfect bölge (yeşil)
                  Positioned(
                    left: perfectLeft,
                    top: 20,
                    child: Container(
                      width: perfectRight - perfectLeft,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _green.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _green.withOpacity(0.5), width: 2),
                      ),
                    ),
                  ),

                  // Ortadaki "BAS" etiketi
                  Positioned(
                    left: perfectLeft,
                    top: 0,
                    child: SizedBox(
                      width: perfectRight - perfectLeft,
                      height: 18,
                      child: Center(
                        child: Text(
                          'BAS',
                          style: GoogleFonts.robotoMono(
                            fontSize: 10,
                            color: _green.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Hareketli gösterge (cursor)
                  Positioned(
                    left: indicatorX,
                    top: 14,
                    child: Container(
                      width: 20,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _getCursorColor(),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: _getCursorColor().withOpacity(0.6),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Sol/sağ uç etiketleri
                  Positioned(
                    left: 4,
                    top: 48,
                    child: Text('Erken',
                        style: GoogleFonts.inter(fontSize: 9, color: Colors.white24)),
                  ),
                  Positioned(
                    right: 4,
                    top: 48,
                    child: Text('Geç',
                        style: GoogleFonts.inter(fontSize: 9, color: Colors.white24)),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Color _getCursorColor() {
    final pos = _barPosition.value;
    final dist = (pos - 0.5).abs();
    if (dist <= 0.08) return _green;
    if (dist <= 0.18) return _teal;
    return _red.withOpacity(0.7);
  }

  /// Büyük kalp + tıklama alanı
  Widget _buildHeartArea() {
    return Center(
      child: AnimatedBuilder(
        animation: _heartbeatController,
        builder: (context, child) {
          final scale = 1.0 + (_heartbeatController.value * 0.15);
          return Transform.scale(scale: scale, child: child);
        },
        child: AnimatedBuilder(
          animation: _buttonScale,
          builder: (context, child) {
            return Transform.scale(scale: _buttonScale.value, child: child);
          },
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _red.withOpacity(0.25),
                  _red.withOpacity(0.08),
                ],
              ),
              border: Border.all(
                color: _red.withOpacity(0.4),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _red.withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color: _red,
                  size: 50,
                ),
                const SizedBox(height: 6),
                Text(
                  _isStarted ? 'BAS!' : 'BAŞLA',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
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
          // İlerleme barı
          Row(
            children: [
              Text('Kompresyon',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white54)),
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

          // İstatistikler
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatBadge(icon: Icons.star, label: 'Harika', value: '$_perfectCount', color: _green),
              _StatBadge(icon: Icons.thumb_up, label: 'İyi', value: '$_goodCount', color: _teal),
              _StatBadge(icon: Icons.close, label: 'Kaçık', value: '${_offCount + _missCount}', color: _red),
              _StatBadge(icon: Icons.local_fire_department, label: 'Seri', value: '$_currentStreak', color: _amber),
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
        Icon(icon, color: color, size: 18),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.robotoMono(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 10),
        ),
      ],
    );
  }
}
