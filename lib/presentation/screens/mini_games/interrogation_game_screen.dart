import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/mini_game.dart';
import '../../providers/mini_game_providers.dart';
import 'mini_game_result_dialog.dart';
import 'scoring_utils.dart';

/// Muayene Mini Oyunu
///
/// Oyuncu sorular secerek hastayi muayene ediyor.
/// Konfor bari cok duserse hasta rahatsizlanir ve muayene biter.
class InterrogationGameScreen extends ConsumerStatefulWidget {
  final String caseId;
  final MiniGameDef miniGame;

  const InterrogationGameScreen({
    super.key,
    required this.caseId,
    required this.miniGame,
  });

  @override
  ConsumerState<InterrogationGameScreen> createState() =>
      _InterrogationGameScreenState();
}

class _InterrogationGameScreenState
    extends ConsumerState<InterrogationGameScreen> with TickerProviderStateMixin {
  // Oyun durumu
  late int _stressLevel;
  final List<String> _chosenQuestionIds = [];
  final List<_ChatMessage> _chatHistory = [];
  bool _isSubmitting = false;
  bool _suspectShutDown = false;
  bool _isTyping = false;

  // Zamanlayıcı
  late int _remainingSeconds;
  late final AnimationController _timerController;

  // Scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _stressLevel = widget.miniGame.initialStress ?? 20;
    _remainingSeconds = widget.miniGame.timeLimitSeconds ?? 120;

    _timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _remainingSeconds),
    )..addListener(() {
        final elapsed = (_timerController.value * (widget.miniGame.timeLimitSeconds ?? 120)).floor();
        setState(() {
          _remainingSeconds = (widget.miniGame.timeLimitSeconds ?? 120) - elapsed;
        });
        if (_remainingSeconds <= 0 && !_isSubmitting) {
          _endInterrogation();
        }
      });
    _timerController.forward();

    // Giriş mesajı
    _chatHistory.add(_ChatMessage(
      text: 'Muayene basladi. Sorularinizi dikkatli secin.',
      isSystem: true,
    ));
  }

  @override
  void dispose() {
    _timerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<ExaminationQuestion> get _availableQuestions {
    return widget.miniGame.questions
        .where((q) => !_chosenQuestionIds.contains(q.id))
        .toList();
  }

  void _askQuestion(ExaminationQuestion question) {
    if (_isSubmitting || _suspectShutDown) return;

    setState(() {
      _chosenQuestionIds.add(question.id);

      // Doktor sorusu
      _chatHistory.add(_ChatMessage(text: question.text, isDetective: true));

      // Konfor guncelle
      _stressLevel = (_stressLevel + question.stressImpact).clamp(0, 100);

      _isTyping = true;
    });

    _scrollToBottom();

    // Simule edilmis hasta yanit gecikmesi
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;

        // Konfor esigini astiysa
        final threshold = widget.miniGame.stressThreshold ?? 70;
        if (_stressLevel >= 95) {
          _chatHistory.add(_ChatMessage(
            text: 'Doktor, cok agriyor, yapamayacagim...',
            isSuspect: true,
          ));
          _suspectShutDown = true;
          Future.delayed(const Duration(seconds: 1), _endInterrogation);
          return;
        }

        // Normal yanıt
        _chatHistory.add(_ChatMessage(
          text: question.response,
          isSuspect: true,
          isCritical: question.isCritical,
        ));

        // Konfor uyarisi
        if (_stressLevel >= threshold && _stressLevel < 95) {
          _chatHistory.add(_ChatMessage(
            text: 'Hasta rahatsizlaniyor... Dikkatli ol.',
            isSystem: true,
          ));
        }
      });

      _scrollToBottom();

      // Tüm sorular bittiyse otomatik bitir
      if (_availableQuestions.isEmpty) {
        Future.delayed(const Duration(seconds: 1), _endInterrogation);
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _endInterrogation() async {
    if (_isSubmitting) return;
    _timerController.stop();
    setState(() => _isSubmitting = true);

    try {
      // Skoru Flutter'da hesapla
      final score = ScoringUtils.calculateInterrogationScore(
        chosenQuestionIds: _chosenQuestionIds,
        criticalQuestions: widget.miniGame.criticalQuestions,
        optimalOrder: widget.miniGame.optimalOrder,
        finalStressLevel: _stressLevel,
        stressThreshold: widget.miniGame.stressThreshold ?? 70,
      );

      final repo = ref.read(miniGameRepositoryProvider);
      final result = await repo.submitInterrogation(
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
      }
    }
  }

  Color _stressColor() {
    if (_stressLevel < 40) return const Color(0xFF03DAC6);
    if (_stressLevel < 70) return const Color(0xFFD4A847);
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      appBar: AppBar(
        backgroundColor: const Color(0xFF132038),
        title: Text(
          widget.miniGame.suspectName ?? 'mini_games.interrogation_game'.tr(),
          style: GoogleFonts.poppins(fontSize: 18),
        ),
        actions: [
          // Zamanlayıcı
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _remainingSeconds <= 15
                  ? Colors.red.withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${_remainingSeconds}s',
              style: GoogleFonts.robotoMono(
                color: _remainingSeconds <= 15 ? Colors.red : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Hasta konfor bari
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF0E1A30),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: _stressColor(), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'interrogation.stress_level'.tr(),
                      style: GoogleFonts.robotoMono(
                          color: Colors.white54, fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      '$_stressLevel%',
                      style: GoogleFonts.robotoMono(
                        color: _stressColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _stressLevel / 100,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(_stressColor()),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          // Chat geçmişi
          Expanded(
            flex: 3,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _chatHistory.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _chatHistory.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildChatBubble(_chatHistory[index]);
              },
            ),
          ),

          // Muayene soru secenekleri
          if (!_suspectShutDown && !_isSubmitting && _availableQuestions.isNotEmpty)
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF132038),
                  border: Border(
                    top: BorderSide(color: const Color(0xFF00BFA5).withOpacity(0.3), width: 1.5),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
                      child: Row(
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 14, color: Colors.white38),
                          const SizedBox(width: 6),
                          Text(
                            'MUAYENE SORUSU SEC',
                            style: GoogleFonts.robotoMono(
                              color: Colors.white38,
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00BFA5).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${_availableQuestions.length}',
                              style: GoogleFonts.robotoMono(
                                color: const Color(0xFF00BFA5),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _endInterrogation,
                            child: Text(
                              'MUAYENEYi BiTiR',
                              style: GoogleFonts.robotoMono(
                                color: const Color(0xFF00BFA5),
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.0, 0.85, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                          itemCount: _availableQuestions.length,
                          itemBuilder: (context, index) {
                            final q = _availableQuestions[index];
                            return _buildQuestionOption(q);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bitir butonu (sorular bittiyse veya hasta rahatsizlandiysa)
          if ((_suspectShutDown || _availableQuestions.isEmpty) && !_isSubmitting)
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF132038),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _endInterrogation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'mini_games.complete_interrogation'.tr(),
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionOption(ExaminationQuestion q) {
    // Konfor etkisine gore renk
    Color stressIndicator;
    if (q.stressImpact <= 10) {
      stressIndicator = const Color(0xFF03DAC6);
    } else if (q.stressImpact <= 25) {
      stressIndicator = const Color(0xFFD4A847);
    } else {
      stressIndicator = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isTyping ? null : () => _askQuestion(q),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.15)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Konfor gostergesi
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: stressIndicator,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    q.text,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: 14, color: Colors.white.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(_ChatMessage msg) {
    if (msg.isSystem) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(8),
        child: Text(
          msg.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.robotoMono(
            color: const Color(0xFFD4A847).withOpacity(0.7),
            fontSize: 11,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    final isDetective = msg.isDetective;

    return Align(
      alignment: isDetective ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isDetective
              ? const Color(0xFF00BFA5).withOpacity(0.2)
              : const Color(0xFF1A2A44),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isDetective ? 12 : 0),
            bottomRight: Radius.circular(isDetective ? 0 : 12),
          ),
          border: msg.isCritical
              ? Border.all(color: const Color(0xFFD4A847).withOpacity(0.5))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isDetective ? 'common.doctor'.tr() : (widget.miniGame.suspectName ?? 'common.patient_fallback'.tr()),
              style: GoogleFonts.robotoMono(
                color: isDetective
                    ? const Color(0xFF00BFA5)
                    : const Color(0xFF03DAC6),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg.text,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
                height: 1.5,
              ),
            ),
            if (msg.isCritical) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 12, color: const Color(0xFFD4A847)),
                  const SizedBox(width: 4),
                  Text(
                    'ÖNEMLİ BİLGİ',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFD4A847),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2A44),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TypingDot(delay: 0),
            const SizedBox(width: 4),
            _TypingDot(delay: 200),
            const SizedBox(width: 4),
            _TypingDot(delay: 400),
          ],
        ),
      ),
    );
  }
}

/// Muayene chat mesaji veri sinifi
class _ChatMessage {
  final String text;
  final bool isDetective;
  final bool isSuspect;
  final bool isSystem;
  final bool isCritical;

  _ChatMessage({
    required this.text,
    this.isDetective = false,
    this.isSuspect = false,
    this.isSystem = false,
    this.isCritical = false,
  });
}

/// Yazıyor animasyonu noktası
class _TypingDot extends StatefulWidget {
  final int delay;
  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3 + _controller.value * 0.5),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
