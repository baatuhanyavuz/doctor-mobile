import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/shift.dart';
import '../../providers/shift_provider.dart';

class ShiftCaseScreen extends ConsumerStatefulWidget {
  const ShiftCaseScreen({super.key});

  @override
  ConsumerState<ShiftCaseScreen> createState() => _ShiftCaseScreenState();
}

class _ShiftCaseScreenState extends ConsumerState<ShiftCaseScreen> {
  int _currentStepIndex = 0;
  final List<Map<String, String>> _responses = [];
  String? _selectedOptionId;
  String? _feedbackText;
  bool _showingFeedback = false;
  bool _isSubmitting = false;
  bool _isCompleted = false;
  Timer? _timer;
  int _remainingSeconds = 60;

  static const _bg = Color(0xFF0A1628);
  static const _surface = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _crimson = Color(0xFFCF6679);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(int seconds) {
    _remainingSeconds = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        if (!_isCompleted) _handleTimeout();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  @override
  Widget build(BuildContext context) {
    final shiftAsync = ref.watch(activeShiftProvider);

    return Scaffold(
      backgroundColor: _bg,
      body: shiftAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _teal)),
        error: (e, _) => Center(child: Text('Hata: $e', style: const TextStyle(color: _crimson))),
        data: (shift) {
          if (shift == null || shift.pendingCase == null) {
            return _buildNoCaseView();
          }
          return _buildCaseView(shift.pendingCase!);
        },
      ),
    );
  }

  Widget _buildNoCaseView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: _teal, size: 64),
          const SizedBox(height: 16),
          Text('Şu anda bekleyen vaka yok', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/shift'),
            style: ElevatedButton.styleFrom(backgroundColor: _teal, foregroundColor: Colors.black),
            child: Text('Nöbet Ekranına Dön', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseView(ShiftCaseInfo caseInfo) {
    if (_timer == null && !_isCompleted) {
      _startTimer(caseInfo.timeLimitSec);
    }

    final triageColor = _triageColor(caseInfo.triageLevel);
    final steps = caseInfo.steps;

    if (_isCompleted) {
      return _buildResultView(caseInfo);
    }

    if (steps.isEmpty) {
      return _buildNoCaseView();
    }

    final currentStep = _currentStepIndex < steps.length ? steps[_currentStepIndex] : null;

    return SafeArea(
      child: Column(
        children: [
          // Top bar: triage badge + timer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: triageColor.withOpacity(0.15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: triageColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _triageLabel(caseInfo.triageLevel),
                    style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    caseInfo.snippetTitle,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Timer
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _remainingSeconds <= 15
                        ? Colors.red.withOpacity(0.3)
                        : _surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _remainingSeconds <= 15 ? Colors.red : Colors.white24,
                    ),
                  ),
                  child: Text(
                    '${(_remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _remainingSeconds <= 15 ? Colors.red : _teal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Progress indicator
          LinearProgressIndicator(
            value: ((_currentStepIndex + 1) / steps.length).clamp(0.0, 1.0),
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(triageColor),
            minHeight: 3,
          ),

          // Scenario
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Text(
                caseInfo.scenario,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white70, height: 1.5),
              ),
            ),
          ),

          // Current step
          if (currentStep != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Adım ${_currentStepIndex + 1}/${steps.length}',
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white30),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                currentStep.text,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),

            // Options
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: currentStep.options.map((option) {
                  final isSelected = _selectedOptionId == option.id;
                  Color borderColor = Colors.white12;
                  Color bgColor = _surface;

                  if (_showingFeedback && isSelected) {
                    borderColor = option.isCorrect ? Colors.green : Colors.red;
                    bgColor = (option.isCorrect ? Colors.green : Colors.red).withOpacity(0.1);
                  } else if (isSelected) {
                    borderColor = _teal;
                    bgColor = _teal.withOpacity(0.1);
                  }

                  return GestureDetector(
                    onTap: _showingFeedback ? null : () => setState(() => _selectedOptionId = option.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(option.text, style: GoogleFonts.inter(fontSize: 14, color: Colors.white)),
                          if (_showingFeedback && isSelected && _feedbackText != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              _feedbackText!,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: option.isCorrect ? Colors.greenAccent : Colors.redAccent,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Confirm button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _selectedOptionId == null || _isSubmitting
                      ? null
                      : (_showingFeedback ? _goToNextStep : _confirmAnswer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showingFeedback ? _teal : triageColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    _showingFeedback
                        ? (_currentStepIndex + 1 >= steps.length ? 'SONUCU GÖR' : 'SONRAKİ ADIM')
                        : 'ONAYLA',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _confirmAnswer() {
    final shiftAsync = ref.read(activeShiftProvider);
    final caseInfo = shiftAsync.value?.pendingCase;
    if (caseInfo == null || _selectedOptionId == null) return;

    final currentStep = caseInfo.steps[_currentStepIndex];
    final selectedOption = currentStep.options.firstWhere((o) => o.id == _selectedOptionId);

    _responses.add({'stepId': currentStep.id, 'optionId': _selectedOptionId!});

    setState(() {
      _feedbackText = selectedOption.feedback;
      _showingFeedback = true;
    });
  }

  void _goToNextStep() {
    final shiftAsync = ref.read(activeShiftProvider);
    final caseInfo = shiftAsync.value?.pendingCase;
    if (caseInfo == null) return;

    if (_currentStepIndex + 1 >= caseInfo.steps.length) {
      _submitResponses();
      return;
    }

    setState(() {
      _currentStepIndex++;
      _selectedOptionId = null;
      _feedbackText = null;
      _showingFeedback = false;
    });
  }

  Future<void> _submitResponses() async {
    final shiftAsync = ref.read(activeShiftProvider);
    final caseInfo = shiftAsync.value?.pendingCase;
    if (caseInfo == null) return;

    setState(() => _isSubmitting = true);
    _timer?.cancel();

    try {
      await ref.read(activeShiftProvider.notifier).respondToCase(
        shiftCaseId: caseInfo.shiftCaseId,
        responses: _responses,
      );
      setState(() => _isCompleted = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: _crimson),
        );
      }
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  void _handleTimeout() {
    if (_isCompleted) return;
    // Zamanaşımı — otomatik submit
    _submitResponses();
  }

  Widget _buildResultView(ShiftCaseInfo caseInfo) {
    final correctCount = _responses.where((r) {
      final step = caseInfo.steps.firstWhere((s) => s.id == r['stepId'], orElse: () => const SnippetStep(id: '', text: '', options: []));
      final option = step.options.where((o) => o.id == r['optionId']).firstOrNull;
      return option?.isCorrect ?? false;
    }).length;

    final totalSteps = caseInfo.steps.length;
    final isSuccess = correctCount * 2 >= totalSteps;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.cancel,
              size: 80,
              color: isSuccess ? Colors.greenAccent : _crimson,
            ),
            const SizedBox(height: 20),
            Text(
              isSuccess ? 'BAŞARILI!' : 'BAŞARISIZ',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.greenAccent : _crimson,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$correctCount / $totalSteps doğru cevap',
              style: GoogleFonts.robotoMono(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.go('/shift'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _teal,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('NÖBETİ TAKİP ET', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _triageColor(String level) => switch (level) {
    'red' => Colors.red,
    'yellow' => Colors.amber,
    'green' => Colors.green,
    _ => Colors.amber,
  };

  String _triageLabel(String level) => switch (level) {
    'red' => 'ACİL',
    'yellow' => 'ORTA',
    'green' => 'DÜŞüK',
    _ => 'ORTA',
  };
}
