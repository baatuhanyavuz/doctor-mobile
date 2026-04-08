import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';

/// İlaç Doz Hesaplama Mini Oyunu
///
/// Hasta bilgilerine göre doğru ilaç dozunu (mg/kg) hesapla
/// ve uygun IV damla hızını seç.
class DrugDoseScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const DrugDoseScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<DrugDoseScreen> createState() => _DrugDoseScreenState();
}

class _DrugDoseScreenState extends ConsumerState<DrugDoseScreen>
    with TickerProviderStateMixin {
  bool _isSubmitted = false;
  int _remainingSeconds = 0;
  Timer? _timer;

  // Kullanıcı girdileri
  double _selectedDoseMg = 0;
  String? _selectedIVRate;
  late double _minDose;
  late double _maxDose;

  // Animasyon
  late AnimationController _pulseController;

  static const _teal = Color(0xFF00BFA5);
  static const _amber = Color(0xFFFFB74D);
  static const _red = Color(0xFFEF5350);
  static const _green = Color(0xFF66BB6A);
  static const _blue = Color(0xFF42A5F5);
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF132038);

  // IV hız seçenekleri
  static const _ivRateOptions = [
    '25 mL/saat',
    '50 mL/saat',
    '75 mL/saat',
    '100 mL/saat',
    '125 mL/saat',
    '150 mL/saat',
    '200 mL/saat',
    '250 mL/saat',
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 120;

    // Doz aralığını hesapla
    final weight = widget.miniGame.patientWeight ?? 70;
    _parseDoseRange();
    // Başlangıç doz değeri: aralığın ortası
    _selectedDoseMg = ((_minDose + _maxDose) / 2 * weight).roundToDouble();

    _startTimer();
  }

  void _parseDoseRange() {
    // drugDoseRange: "2-4 mg/kg" formatı
    final range = widget.miniGame.drugDoseRange ?? '1-5 mg/kg';
    final cleaned = range.replaceAll(RegExp(r'[^0-9.\-]'), ' ').trim();
    final parts = cleaned.split(RegExp(r'[\s\-]+'));
    _minDose = double.tryParse(parts.isNotEmpty ? parts[0] : '0') ?? 0;
    _maxDose = double.tryParse(parts.length > 1 ? parts[1] : '10') ?? 10;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
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

  double get _mgPerKg {
    final weight = widget.miniGame.patientWeight ?? 70;
    if (weight <= 0) return 0;
    return _selectedDoseMg / weight;
  }

  bool get _isOverdose {
    final maxDaily = widget.miniGame.maxDailyDoseMg ?? double.infinity;
    return _selectedDoseMg > maxDaily || _mgPerKg > _maxDose * 1.5;
  }

  bool get _needsKidneyAdjustment {
    return widget.miniGame.kidneyAdjustmentNeeded ?? false;
  }

  bool get _isKidneyWarning {
    final gfr = widget.miniGame.patientGFR ?? 90;
    return gfr < 60 && _mgPerKg > _minDose;
  }

  void _handleSubmit() {
    if (_isSubmitted || _selectedIVRate == null) return;

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
    final correctDose = widget.miniGame.correctDoseMg ?? 0;
    final correctIV = widget.miniGame.correctIVRate ?? '';
    final tolerancePercent = widget.miniGame.doseTolerancePercent ?? 10;
    final maxTime = widget.miniGame.timeLimitSeconds ?? 120;

    int score = 0;

    // Doz puanı (0-500)
    if (correctDose > 0) {
      final diffPercent =
          ((_selectedDoseMg - correctDose).abs() / correctDose) * 100;
      if (diffPercent <= tolerancePercent) {
        score += 500; // Tolerans dahilinde tam puan
      } else if (diffPercent <= tolerancePercent * 2) {
        score += 250; // 2x tolerans dahilinde yarı puan
      } else if (diffPercent <= tolerancePercent * 3) {
        score += 100;
      }
    }

    // IV hız puanı (0-300)
    if (_selectedIVRate != null && correctIV.isNotEmpty) {
      // mL/saat sayısal değerini çıkar
      final selectedVal = _extractRate(_selectedIVRate!);
      final correctVal = _extractRate(correctIV);
      if (selectedVal == correctVal) {
        score += 300;
      } else if ((selectedVal - correctVal).abs() <= 25) {
        score += 150;
      }
    }

    // Aşırı doz cezası
    if (_isOverdose) {
      score -= 200;
    }

    // Zaman bonusu (0-200)
    if (_remainingSeconds > 0) {
      final timeBonus = (_remainingSeconds / maxTime * 200).round();
      score += timeBonus;
    }

    return score.clamp(0, 1000);
  }

  int _extractRate(String rateStr) {
    final match = RegExp(r'(\d+)').firstMatch(rateStr);
    return match != null ? int.tryParse(match.group(1)!) ?? 0 : 0;
  }

  Future<void> _submitResult(int score) async {
    final result = await ref.read(submitMiniGameProvider({
      'caseId': widget.caseId,
      'miniGameId': widget.miniGame.id,
      'miniGameType': 'drug_dose',
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
    final isUrgent = _remainingSeconds < 20;
    final timerColor = isUrgent ? _red : _amber;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _surfaceColor,
        title: Text(
          mg.title.isNotEmpty ? mg.title : 'İlaç Doz Hesaplama',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          _buildTimer(timerColor),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hasta bilgi kartı
            _buildPatientCard(mg),
            const SizedBox(height: 16),

            // İlaç bilgi kartı
            _buildDrugCard(mg),
            const SizedBox(height: 20),

            // Doz giriş bölümü
            _buildDoseInput(mg),
            const SizedBox(height: 16),

            // IV hız seçimi
            _buildIVRateSelector(),
            const SizedBox(height: 16),

            // Uyarılar
            if (_isOverdose && !_isSubmitted) _buildOverdoseWarning(),
            if (_isKidneyWarning && !_isSubmitted) ...[
              const SizedBox(height: 8),
              _buildKidneyWarning(),
            ],

            const SizedBox(height: 24),

            // Sonuç
            if (_isSubmitted) _buildResultCard(),

            // Uygula butonu
            if (!_isSubmitted)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedIVRate == null ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedIVRate == null ? Colors.grey.shade800 : _teal,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'UYGULA',
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

  Widget _buildPatientCard(MiniGameDef mg) {
    final weight = mg.patientWeight ?? 70;
    final age = mg.patientAge ?? 45;
    final gfr = mg.patientGFR ?? 90;
    final patientName = mg.patientName ?? 'Hasta';

    Color gfrColor;
    String gfrLabel;
    if (gfr >= 90) {
      gfrColor = _green;
      gfrLabel = 'Normal';
    } else if (gfr >= 60) {
      gfrColor = _amber;
      gfrLabel = 'Hafif Azalmış';
    } else if (gfr >= 30) {
      gfrColor = _red;
      gfrLabel = 'Orta Azalmış';
    } else {
      gfrColor = _red;
      gfrLabel = 'Ciddi Azalmış';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Icon(
                    Icons.person,
                    color: _blue
                        .withOpacity(0.6 + _pulseController.value * 0.4),
                    size: 28,
                  );
                },
              ),
              const SizedBox(width: 10),
              Text(
                'HASTA BİLGİLERİ',
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _blue,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            patientName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Bilgi satırları
          Row(
            children: [
              _infoChip(Icons.monitor_weight, '${weight.toStringAsFixed(1)} kg',
                  Colors.white70),
              const SizedBox(width: 12),
              _infoChip(Icons.cake, '$age yaş', Colors.white70),
            ],
          ),
          const SizedBox(height: 8),
          // GFR
          Row(
            children: [
              _infoChip(Icons.water_drop, 'GFR: ${gfr.toStringAsFixed(0)}',
                  gfrColor),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: gfrColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: gfrColor.withOpacity(0.3)),
                ),
                child: Text(
                  gfrLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: gfrColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          // Alerji
          if (mg.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: _amber.withOpacity(0.7), size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    mg.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: _amber,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color.withOpacity(0.7)),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.robotoMono(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDrugCard(MiniGameDef mg) {
    final drugName = mg.drugName ?? 'İlaç';
    final doseRange = mg.drugDoseRange ?? '-';
    final maxDaily = mg.maxDailyDoseMg;

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
              Icon(Icons.medication, color: _teal, size: 24),
              const SizedBox(width: 10),
              Text(
                'İLAÇ BİLGİLERİ',
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
            drugName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _drugInfoRow('Standart Doz:', doseRange),
          if (maxDaily != null)
            _drugInfoRow(
                'Maks. Günlük:', '${maxDaily.toStringAsFixed(0)} mg'),
          if (_needsKidneyAdjustment)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _amber.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, color: _amber, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'Böbrek yetmezliğinde doz ayarı gerekli',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: _amber,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _drugInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white54,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoseInput(MiniGameDef mg) {
    final weight = mg.patientWeight ?? 70;
    final sliderMin = _minDose * weight * 0.3;
    final sliderMax = _maxDose * weight * 2.0;

    // Uyarı rengi
    Color doseColor;
    if (_isOverdose) {
      doseColor = _red;
    } else if (_mgPerKg >= _minDose && _mgPerKg <= _maxDose) {
      doseColor = _green;
    } else if (_mgPerKg < _minDose) {
      doseColor = _amber;
    } else {
      doseColor = _red;
    }

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
            'DOZ AYARI',
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _teal,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          // Canlı mg/kg göstergesi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Toplam Doz',
                    style: GoogleFonts.inter(
                        fontSize: 11, color: Colors.white38),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_selectedDoseMg.toStringAsFixed(0)} mg',
                    style: GoogleFonts.robotoMono(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: doseColor,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: doseColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: doseColor.withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${_mgPerKg.toStringAsFixed(2)}',
                      style: GoogleFonts.robotoMono(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: doseColor,
                      ),
                    ),
                    Text(
                      'mg/kg',
                      style: GoogleFonts.robotoMono(
                        fontSize: 10,
                        color: doseColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: doseColor,
              inactiveTrackColor: doseColor.withOpacity(0.15),
              thumbColor: doseColor,
              overlayColor: doseColor.withOpacity(0.1),
              trackHeight: 6,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _selectedDoseMg.clamp(sliderMin, sliderMax),
              min: sliderMin,
              max: sliderMax,
              divisions: ((sliderMax - sliderMin) / 5).round().clamp(10, 200),
              onChanged: _isSubmitted
                  ? null
                  : (val) => setState(() => _selectedDoseMg = val),
            ),
          ),
          // Aralık etiketleri
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${sliderMin.toStringAsFixed(0)} mg',
                style: GoogleFonts.robotoMono(
                    fontSize: 10, color: Colors.white38),
              ),
              Text(
                'Önerilen: ${(_minDose * weight).toStringAsFixed(0)}-${(_maxDose * weight).toStringAsFixed(0)} mg',
                style: GoogleFonts.inter(
                    fontSize: 10, color: _teal.withOpacity(0.6)),
              ),
              Text(
                '${sliderMax.toStringAsFixed(0)} mg',
                style: GoogleFonts.robotoMono(
                    fontSize: 10, color: Colors.white38),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIVRateSelector() {
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
            'IV DAMLA HIZI',
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _teal,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ivRateOptions.map((rate) {
              final isSelected = _selectedIVRate == rate;
              return GestureDetector(
                onTap: _isSubmitted
                    ? null
                    : () => setState(() => _selectedIVRate = rate),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _teal.withOpacity(0.15)
                        : Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? _teal
                          : Colors.white.withOpacity(0.1),
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    rate,
                    style: GoogleFonts.robotoMono(
                      fontSize: 13,
                      color: isSelected ? _teal : Colors.white54,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverdoseWarning() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _red.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.dangerous, color: _red, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'UYARI: Doz aşımı! Seçilen doz güvenli aralığın üzerinde.',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: _red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKidneyWarning() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _amber.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _amber.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: _amber, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'DİKKAT: Hasta böbrek fonksiyonu düşük (GFR < 60). Doz ayarlaması gerekebilir.',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: _amber,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final score = _calculateScore();
    final isGood = score >= 500;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
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
            size: 48,
            color: isGood ? _green : _red,
          ),
          const SizedBox(height: 12),
          Text(
            isGood ? 'DOĞRU DOZ!' : 'HATALI DOZ!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isGood ? _green : _red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isGood
                ? 'Doğru dozu hesapladınız. Tedavi başarıyla uygulandı.'
                : _remainingSeconds <= 0
                    ? 'Süre doldu! İlaç zamanında uygulanamadı.'
                    : _isOverdose
                        ? 'Doz aşımı tespit edildi! Hasta tehlikede.'
                        : 'Seçilen doz veya IV hız uygun değil.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Doğru cevapları göster
          if (widget.miniGame.correctDoseMg != null ||
              (widget.miniGame.correctIVRate ?? '').isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  if (widget.miniGame.correctDoseMg != null)
                    _resultRow('Doğru Doz:',
                        '${widget.miniGame.correctDoseMg!.toStringAsFixed(0)} mg'),
                  if ((widget.miniGame.correctIVRate ?? '').isNotEmpty)
                    _resultRow('Doğru IV Hız:',
                        widget.miniGame.correctIVRate!),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              fontSize: 13,
              color: _teal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
