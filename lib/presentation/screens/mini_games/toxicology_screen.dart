import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// Toksikoloji Lab Mini Oyunu
///
/// Zehirlenme vakasında doğru antidotu/tedaviyi seçme.
/// Toksin şiddetine göre zamanlı baskı mekanizması.
class ToxicologyScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const ToxicologyScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<ToxicologyScreen> createState() => _ToxicologyScreenState();
}

class _ToxicologyScreenState extends ConsumerState<ToxicologyScreen>
    with TickerProviderStateMixin {
  String? _selectedOptionId;
  bool _isSubmitted = false;
  bool _isCorrect = false;
  int _remainingSeconds = 0;
  Timer? _timer;
  late AnimationController _toxinPulseController;

  static const _purple = Color(0xFF9C27B0);
  static const _green = Color(0xFF66BB6A);
  static const _red = Color(0xFFEF5350);
  static const _amber = Color(0xFFFFB74D);
  static const _teal = Color(0xFF00BFA5);

  @override
  void initState() {
    super.initState();
    _toxinPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    // Süre = timeLimitSeconds veya severity'e göre hesapla
    _remainingSeconds = widget.miniGame.timeLimitSeconds ??
        (90 - (widget.miniGame.toxinSeverity * 5)); // severity 5 = 65s
    if (_remainingSeconds < 30) _remainingSeconds = 30;

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _toxinPulseController.dispose();
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
    _submitResult(0); // Süre doldu = 0 puan
  }

  void _handleSubmit() {
    if (_selectedOptionId == null || _isSubmitted) return;

    final selectedOption = widget.miniGame.toxicologyOptions
        .firstWhere((o) => o.id == _selectedOptionId);

    setState(() {
      _isSubmitted = true;
      _isCorrect = selectedOption.isCorrect;
    });

    _timer?.cancel();

    if (_isCorrect) {
      HapticFeedback.mediumImpact();
      // Puan: kalan süre oranı * 1000
      final maxTime = widget.miniGame.timeLimitSeconds ??
          (90 - (widget.miniGame.toxinSeverity * 5));
      final timeBonus = (_remainingSeconds / maxTime * 500).round();
      _submitResult(500 + timeBonus); // 500 base + time bonus
    } else {
      HapticFeedback.heavyImpact();
      _submitResult(100); // Yanlış = düşük puan
    }
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'toxicology',
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
    final severity = mg.toxinSeverity;
    final isUrgent = _remainingSeconds < 20;
    final timerColor = isUrgent ? _red : _amber;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          mg.title,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toksin bilgi kartı
            _buildToxinInfoCard(mg),
            const SizedBox(height: 16),

            // Semptom listesi
            if (mg.toxinSymptoms.isNotEmpty) ...[
              _buildSymptomsCard(mg),
              const SizedBox(height: 16),
            ],

            // Severity göstergesi
            _buildSeverityBar(severity),
            const SizedBox(height: 24),

            // Tedavi seçenekleri
            Text(
              'ANTİDOT / TEDAVİ SEÇİN',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),

            ...mg.toxicologyOptions.map(
              (option) => _buildOptionCard(option),
            ),

            const SizedBox(height: 24),

            // Sonuç gösterimi
            if (_isSubmitted) _buildResultCard(),

            // Uygula butonu
            if (!_isSubmitted)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedOptionId == null ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedOptionId == null
                        ? Colors.grey.shade800
                        : _teal,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'TEDAVİYİ UYGULA',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
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

  Widget _buildToxinInfoCard(MiniGameDef mg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _purple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _toxinPulseController,
                builder: (context, child) {
                  return Icon(
                    Icons.science,
                    color: _purple.withOpacity(
                      0.5 + _toxinPulseController.value * 0.5,
                    ),
                    size: 28,
                  );
                },
              ),
              const SizedBox(width: 10),
              Text(
                'TOKSİKOLOJİ RAPORU',
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _purple,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (mg.toxinName != null) ...[
            Text(
              'Tespit edilen madde: ${mg.toxinName}',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (mg.toxinDescription != null)
            Text(
              mg.toxinDescription!,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          if (mg.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              mg.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSymptomsCard(MiniGameDef mg) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEMPTOMLAR',
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _amber,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: mg.toxinSymptoms.map((symptom) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _amber.withOpacity(0.2)),
                ),
                child: Text(
                  symptom,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: _amber,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSeverityBar(int severity) {
    final color = severity >= 7
        ? _red
        : severity >= 4
            ? _amber
            : _green;
    final label = severity >= 7
        ? 'KRİTİK'
        : severity >= 4
            ? 'ORTA'
            : 'DÜŞÜK';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            'Toksin Şiddeti: $label ($severity/10)',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Progress bar
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              value: severity / 10,
              backgroundColor: Colors.white10,
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(ToxicologyOption option) {
    final isSelected = _selectedOptionId == option.id;
    final showResult = _isSubmitted;
    final isCorrectOption = option.isCorrect;

    Color borderColor;
    Color bgColor;
    if (showResult) {
      if (isCorrectOption) {
        borderColor = _green;
        bgColor = _green.withOpacity(0.08);
      } else if (isSelected && !isCorrectOption) {
        borderColor = _red;
        bgColor = _red.withOpacity(0.08);
      } else {
        borderColor = Colors.white10;
        bgColor = const Color(0xFF132038);
      }
    } else {
      borderColor = isSelected ? _teal : Colors.white10;
      bgColor = isSelected
          ? _teal.withOpacity(0.08)
          : const Color(0xFF132038);
    }

    return GestureDetector(
      onTap: _isSubmitted ? null : () => setState(() => _selectedOptionId = option.id),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (showResult && isCorrectOption)
                  const Icon(Icons.check_circle, color: _green, size: 20)
                else if (showResult && isSelected && !isCorrectOption)
                  const Icon(Icons.cancel, color: _red, size: 20)
                else if (isSelected)
                  const Icon(Icons.radio_button_checked, color: _teal, size: 20)
                else
                  const Icon(Icons.radio_button_off, color: Colors.white24, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    option.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              option.description,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white60,
                height: 1.4,
              ),
            ),
            if (option.dosage != null) ...[
              const SizedBox(height: 4),
              Text(
                'Doz: ${option.dosage}',
                style: GoogleFonts.robotoMono(
                  fontSize: 11,
                  color: _teal.withOpacity(0.7),
                ),
              ),
            ],
            // Yanlış seçilmişse sonucu göster
            if (showResult &&
                isSelected &&
                !isCorrectOption &&
                option.wrongConsequence != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  option.wrongConsequence!,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: _red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ],
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
            _isCorrect ? 'DOĞRU TEDAVİ!' : 'YANLIŞ TEDAVİ!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _isCorrect ? _green : _red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isCorrect
                ? 'Doğru antidotu zamanında uyguladınız. Hasta stabilize edildi.'
                : _remainingSeconds <= 0
                    ? 'Süre doldu! Antidot zamanında uygulanamadı.'
                    : 'Seçilen tedavi uygun değil. Hastanın durumu kötüleşti.',
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
