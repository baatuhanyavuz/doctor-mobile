import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// Kan Grubu Tespiti Mini Oyunu
///
/// Anti-A, Anti-B, Anti-D serumlarını kan numunelerine damlatıp
/// aglütinasyon (çökelme) gözlemle → Doğru kan grubunu belirle.
class BloodTypeScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const BloodTypeScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<BloodTypeScreen> createState() => _BloodTypeScreenState();
}

class _BloodTypeScreenState extends ConsumerState<BloodTypeScreen>
    with TickerProviderStateMixin {
  // Doğru kan grubu (MiniGameDef'ten)
  late String _correctBloodType; // "A+", "B-", "AB+", "0-" etc.
  late bool _antiAReacts;
  late bool _antiBReacts;
  late bool _antiDReacts;

  // Oyuncu etkileşimleri
  bool _droppedAntiA = false;
  bool _droppedAntiB = false;
  bool _droppedAntiD = false;
  String? _selectedAnswer;
  bool _isSubmitted = false;
  bool _isCorrect = false;

  // Zamanlayıcı
  int _remainingSeconds = 60;
  Timer? _timer;

  // Animasyonlar
  late AnimationController _agglutinationController;

  static const _teal = Color(0xFF00BFA5);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);
  static const _amber = Color(0xFFFFB74D);
  static const _bloodRed = Color(0xFFB71C1C);

  static const _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', '0+', '0-'
  ];

  @override
  void initState() {
    super.initState();

    _correctBloodType = widget.miniGame.toxinName ?? 'A+'; // bloodType field
    _parseReactions();

    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 60;

    _agglutinationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _startTimer();
  }

  void _parseReactions() {
    // Kan grubu kuralları:
    // A → Anti-A reacts
    // B → Anti-B reacts
    // AB → Anti-A + Anti-B reacts
    // 0 → None reacts
    // Rh+ → Anti-D reacts
    // Rh- → Anti-D no reaction
    final type = _correctBloodType.replaceAll('+', '').replaceAll('-', '');
    final isRhPositive = _correctBloodType.contains('+');

    _antiAReacts = type.contains('A');
    _antiBReacts = type.contains('B');
    _antiDReacts = isRhPositive;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _agglutinationController.dispose();
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
      _isCorrect = false;
    });
    HapticFeedback.heavyImpact();
    _submitResult(0);
  }

  void _dropSerum(String serum) {
    HapticFeedback.lightImpact();
    setState(() {
      switch (serum) {
        case 'Anti-A':
          _droppedAntiA = true;
          break;
        case 'Anti-B':
          _droppedAntiB = true;
          break;
        case 'Anti-D':
          _droppedAntiD = true;
          break;
      }
    });
    _agglutinationController.forward(from: 0);
  }

  void _handleSubmit() {
    if (_selectedAnswer == null || _isSubmitted) return;

    _timer?.cancel();
    final correct = _selectedAnswer == _correctBloodType;

    setState(() {
      _isSubmitted = true;
      _isCorrect = correct;
    });

    HapticFeedback.mediumImpact();

    // Puan hesapla
    int score = 0;
    if (correct) {
      score = 700;
      // Zaman bonusu
      final maxTime = widget.miniGame.timeLimitSeconds ?? 60;
      score += ((_remainingSeconds / maxTime) * 300).round();
    } else {
      score = 100;
    }

    _submitResult(score.clamp(0, 1000));
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'blood_type',
      'score': score,
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
    final isUrgent = _remainingSeconds < 15;
    final timerColor = isUrgent ? _red : _amber;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          widget.miniGame.title.isNotEmpty
              ? widget.miniGame.title
              : 'Kan Grubu Tespiti',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
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
            // Açıklama
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _bloodRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _bloodRed.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bloodtype, color: _bloodRed, size: 24),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Serumları kan numunelerine damlatın ve reaksiyonları gözlemleyin.',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3 Test Tüpü
            Row(
              children: [
                Expanded(child: _buildTestTube('Anti-A', _droppedAntiA, _antiAReacts, const Color(0xFF2196F3))),
                const SizedBox(width: 12),
                Expanded(child: _buildTestTube('Anti-B', _droppedAntiB, _antiBReacts, const Color(0xFFFFEB3B))),
                const SizedBox(width: 12),
                Expanded(child: _buildTestTube('Anti-D', _droppedAntiD, _antiDReacts, const Color(0xFF9C27B0))),
              ],
            ),
            const SizedBox(height: 20),

            // Reaksiyon Rehberi
            _buildReactionGuide(),
            const SizedBox(height: 24),

            // Kan Grubu Seçimi
            Text(
              'KAN GRUBU TEŞHİSİ',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.8,
              children: _bloodTypes.map((type) => _buildBloodTypeButton(type)).toList(),
            ),
            const SizedBox(height: 24),

            // Sonuç
            if (_isSubmitted) _buildResultCard(),

            // Onayla butonu
            if (!_isSubmitted)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedAnswer == null ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedAnswer == null ? Colors.grey.shade800 : _teal,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'KAN GRUBUNU ONAYLA',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTestTube(String serumName, bool dropped, bool reacts, Color serumColor) {
    final showResult = dropped;
    final agglutinated = dropped && reacts;

    return GestureDetector(
      onTap: (!dropped && !_isSubmitted) ? () => _dropSerum(serumName) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF132038),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dropped
                ? (agglutinated ? _red.withOpacity(0.5) : _green.withOpacity(0.5))
                : serumColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Serum damla ikonu
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dropped ? serumColor.withOpacity(0.3) : serumColor.withOpacity(0.15),
                border: Border.all(color: serumColor.withOpacity(0.5)),
              ),
              child: Icon(
                dropped ? Icons.check : Icons.water_drop,
                color: serumColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),

            // Serum adı
            Text(
              serumName,
              style: GoogleFonts.robotoMono(
                color: serumColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Kan numunesi / reaksiyon gösterimi
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dropped ? _bloodRed.withOpacity(0.8) : _bloodRed.withOpacity(0.3),
                border: Border.all(
                  color: dropped
                      ? (agglutinated ? _red : _green)
                      : Colors.white10,
                  width: 2,
                ),
              ),
              child: dropped
                  ? CustomPaint(
                      painter: _AgglutinationPainter(
                        agglutinated: agglutinated,
                        progress: 1.0,
                      ),
                    )
                  : Center(
                      child: Text(
                        'KAN',
                        style: GoogleFonts.robotoMono(
                          color: Colors.white38,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 8),

            // Sonuç metni
            if (showResult)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (agglutinated ? _red : _green).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  agglutinated ? 'ÇÖKELME +' : 'TEMİZ −',
                  style: GoogleFonts.robotoMono(
                    color: agglutinated ? _red : _green,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Text(
                'Damlatın',
                style: GoogleFonts.inter(
                  color: Colors.white24,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionGuide() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REAKSİYON REHBERİ',
            style: GoogleFonts.robotoMono(
              fontSize: 10,
              color: Colors.white38,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          _guideRow('A grubu', '✓', '−', ''),
          _guideRow('B grubu', '−', '✓', ''),
          _guideRow('AB grubu', '✓', '✓', ''),
          _guideRow('0 grubu', '−', '−', ''),
          const Divider(color: Colors.white10, height: 12),
          _guideRow('Rh+', '', '', '✓'),
          _guideRow('Rh−', '', '', '−'),
        ],
      ),
    );
  }

  Widget _guideRow(String label, String a, String b, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 75,
            child: Text(label,
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 11)),
          ),
          if (a.isNotEmpty)
            SizedBox(
              width: 60,
              child: Text('Anti-A: $a',
                  style: GoogleFonts.robotoMono(
                      color: a == '✓' ? _red : _green, fontSize: 10)),
            ),
          if (b.isNotEmpty)
            SizedBox(
              width: 60,
              child: Text('Anti-B: $b',
                  style: GoogleFonts.robotoMono(
                      color: b == '✓' ? _red : _green, fontSize: 10)),
            ),
          if (d.isNotEmpty)
            SizedBox(
              width: 60,
              child: Text('Anti-D: $d',
                  style: GoogleFonts.robotoMono(
                      color: d == '✓' ? _red : _green, fontSize: 10)),
            ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeButton(String type) {
    final isSelected = _selectedAnswer == type;
    final showCorrect = _isSubmitted && type == _correctBloodType;
    final showWrong = _isSubmitted && isSelected && !_isCorrect;

    Color borderColor;
    Color bgColor;
    if (showCorrect) {
      borderColor = _green;
      bgColor = _green.withOpacity(0.15);
    } else if (showWrong) {
      borderColor = _red;
      bgColor = _red.withOpacity(0.15);
    } else if (isSelected) {
      borderColor = _teal;
      bgColor = _teal.withOpacity(0.1);
    } else {
      borderColor = Colors.white10;
      bgColor = const Color(0xFF132038);
    }

    return GestureDetector(
      onTap: _isSubmitted ? null : () => setState(() => _selectedAnswer = type),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
        ),
        child: Center(
          child: Text(
            type,
            style: GoogleFonts.poppins(
              color: isSelected ? _teal : Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (_isCorrect ? _green : _red).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (_isCorrect ? _green : _red).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _isCorrect ? Icons.check_circle_outline : Icons.error_outline,
            size: 48,
            color: _isCorrect ? _green : _red,
          ),
          const SizedBox(height: 12),
          Text(
            _isCorrect ? 'DOĞRU!' : 'YANLIŞ!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isCorrect ? _green : _red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isCorrect
                ? 'Kan grubu doğru tespit edildi: $_correctBloodType'
                : _remainingSeconds <= 0
                    ? 'Süre doldu! Doğru cevap: $_correctBloodType'
                    : 'Doğru kan grubu: $_correctBloodType',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Aglütinasyon (çökelme) çizen CustomPainter
class _AgglutinationPainter extends CustomPainter {
  final bool agglutinated;
  final double progress;

  _AgglutinationPainter({required this.agglutinated, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rng = Random(42);

    if (agglutinated) {
      // Çökelme — küçük kümeler halinde noktalar
      final paint = Paint()..color = const Color(0xFFE53935).withOpacity(0.9);
      for (int i = 0; i < 12; i++) {
        final angle = (i / 12) * 2 * pi;
        final radius = 6.0 + rng.nextDouble() * 10;
        final dx = center.dx + cos(angle) * radius;
        final dy = center.dy + sin(angle) * radius;
        canvas.drawCircle(Offset(dx, dy), 2 + rng.nextDouble() * 2.5, paint);
      }
      // Küçük bağlantı çizgileri
      final linePaint = Paint()
        ..color = const Color(0xFFE53935).withOpacity(0.4)
        ..strokeWidth = 1;
      for (int i = 0; i < 6; i++) {
        final a1 = rng.nextDouble() * 2 * pi;
        final a2 = rng.nextDouble() * 2 * pi;
        final r1 = 5.0 + rng.nextDouble() * 12;
        final r2 = 5.0 + rng.nextDouble() * 12;
        canvas.drawLine(
          Offset(center.dx + cos(a1) * r1, center.dy + sin(a1) * r1),
          Offset(center.dx + cos(a2) * r2, center.dy + sin(a2) * r2),
          linePaint,
        );
      }
    } else {
      // Homojen — düzgün dağılmış küçük noktalar
      final paint = Paint()..color = const Color(0xFFEF9A9A).withOpacity(0.6);
      for (int i = 0; i < 15; i++) {
        final dx = center.dx + (rng.nextDouble() - 0.5) * size.width * 0.7;
        final dy = center.dy + (rng.nextDouble() - 0.5) * size.height * 0.7;
        canvas.drawCircle(Offset(dx, dy), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AgglutinationPainter old) =>
      old.agglutinated != agglutinated || old.progress != progress;
}
