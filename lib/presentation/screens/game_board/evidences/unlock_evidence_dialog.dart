import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/sound_manager.dart';

/// Kilitli veri icin sifre girme diyalogu
///
/// Keypad stili giris, sallama animasyonu (yanlis kod) ve
/// basari animasyonu (dogru kod) icerir.
class UnlockEvidenceDialog extends ConsumerStatefulWidget {
  final String evidenceId;
  final String evidenceTitle;
  final String correctCode;
  final String lockedMessage;
  final VoidCallback onUnlocked;

  const UnlockEvidenceDialog({
    super.key,
    required this.evidenceId,
    required this.evidenceTitle,
    required this.correctCode,
    required this.lockedMessage,
    required this.onUnlocked,
  });

  @override
  ConsumerState<UnlockEvidenceDialog> createState() => _UnlockEvidenceDialogState();
}

class _UnlockEvidenceDialogState extends ConsumerState<UnlockEvidenceDialog>
    with TickerProviderStateMixin {
  String _enteredCode = '';
  bool _isShaking = false;
  bool _isSuccess = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  late AnimationController _successController;
  late Animation<double> _successScaleAnimation;
  late Animation<double> _successOpacityAnimation;

  @override
  void initState() {
    super.initState();
    // Sallama animasyonu
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -12), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12, end: 12), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));

    // Basari animasyonu
    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _successScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _successController, curve: Curves.elasticOut),
    );
    _successOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _successController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _successController.dispose();
    super.dispose();
  }

  int get _codeLength => widget.correctCode.length.clamp(3, 12);

  /// Kod alfanümerik mi? (harf içeriyorsa harf keypad göster)
  bool get _isAlphaCode =>
      widget.correctCode.contains(RegExp(r'[a-zA-Z]'));

  void _onKeyTap(String key) {
    if (_isSuccess) return;
    if (_enteredCode.length >= _codeLength) return;

    HapticFeedback.lightImpact();
    SoundManager.instance.playSfx('switch_click');

    setState(() {
      _enteredCode += key;
    });

    // Kod tamamlandi mi?
    if (_enteredCode.length == _codeLength) {
      _tryUnlock();
    }
  }

  void _onBackspace() {
    if (_isSuccess) return;
    if (_enteredCode.isEmpty) return;

    HapticFeedback.selectionClick();
    setState(() {
      _enteredCode = _enteredCode.substring(0, _enteredCode.length - 1);
    });
  }

  void _tryUnlock() {
    if (_enteredCode.toUpperCase() == widget.correctCode.toUpperCase()) {
      // Dogru
      setState(() => _isSuccess = true);
      HapticFeedback.heavyImpact();
      SoundManager.instance.playSfx('string_tighten');

      _successController.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            widget.onUnlocked();
            Navigator.of(context).pop(true);
          }
        });
      });
    } else {
      // Yanlis
      setState(() => _isShaking = true);
      HapticFeedback.heavyImpact();

      _shakeController.forward(from: 0).then((_) {
        if (mounted) {
          setState(() {
            _isShaking = false;
            _enteredCode = '';
          });
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'evidences.wrong_password'.tr(),
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFFEF5350),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: _isShaking ? Offset(_shakeAnimation.value, 0) : Offset.zero,
          child: Dialog(
            backgroundColor: const Color(0xFF0D1B2A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: _isSuccess
                    ? const Color(0xFF66BB6A)
                    : const Color(0xFFFFB74D),
                width: 2,
              ),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Basari overlay
                  if (_isSuccess)
                    _buildSuccessOverlay()
                  else ...[
                    // Kilit ikonu
                    Icon(
                      Icons.lock_outline,
                      size: 40,
                      color: const Color(0xFFFFB74D),
                    ),
                    const SizedBox(height: 8),

                    // Baslik
                    Text(
                      'evidences.locked_title'.tr(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: const Color(0xFFFFB74D),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Tibbi veri adi
                    Text(
                      widget.evidenceTitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    // Ipucu mesaji
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFFFB74D).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        widget.lockedMessage,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: const Color(0xFFFFB74D).withOpacity(0.9),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Kod gosterge kutulari
                    _buildCodeDisplay(),
                    const SizedBox(height: 20),

                    // Keypad (sayısal veya alfanümerik)
                    _isAlphaCode ? _buildAlphaKeypad() : _buildKeypad(),
                    const SizedBox(height: 16),

                    // Iptal butonu
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'common.cancel'.tr(),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white54,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCodeDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_codeLength, (index) {
        final isFilled = index < _enteredCode.length;
        final isError = _isShaking;

        return Container(
          width: 36,
          height: 44,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isFilled
                ? const Color(0xFF00BFA5).withOpacity(0.15)
                : Colors.black26,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isError
                  ? const Color(0xFFEF5350)
                  : isFilled
                      ? const Color(0xFF00BFA5)
                      : Colors.white24,
              width: isFilled ? 2 : 1,
            ),
          ),
          child: Center(
            child: isFilled
                ? _isAlphaCode
                    ? Text(
                        _enteredCode[index],
                        style: GoogleFonts.robotoMono(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isError
                              ? const Color(0xFFEF5350)
                              : const Color(0xFF00BFA5),
                        ),
                      )
                    : Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isError
                              ? const Color(0xFFEF5350)
                              : const Color(0xFF00BFA5),
                          shape: BoxShape.circle,
                        ),
                      )
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '<'],
    ];

    return Column(
      children: keys.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              return _KeypadButton(
                label: key,
                onTap: () {
                  if (key == '<') {
                    _onBackspace();
                  } else if (key == 'C') {
                    setState(() => _enteredCode = '');
                  } else {
                    _onKeyTap(key);
                  }
                },
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAlphaKeypad() {
    final rows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U'],
      ['I', 'O', 'P', 'A', 'S', 'D', 'F'],
      ['G', 'H', 'J', 'K', 'L', 'Z', 'X'],
      ['C', 'V', 'B', 'N', 'M', ' ', '<'],
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Material(
                  color: key == '<' || key == ' '
                      ? const Color(0xFF132038)
                      : const Color(0xFF1B2D4A),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    onTap: () {
                      if (key == '<') {
                        _onBackspace();
                      } else if (key == ' ') {
                        setState(() => _enteredCode = '');
                      } else {
                        _onKeyTap(key);
                      }
                    },
                    borderRadius: BorderRadius.circular(6),
                    splashColor: const Color(0xFF00BFA5).withOpacity(0.3),
                    child: Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      child: key == '<'
                          ? const Icon(Icons.backspace_outlined,
                              color: Colors.white70, size: 16)
                          : key == ' '
                              ? Text('C',
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 12,
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold,
                                  ))
                              : Text(
                                  key,
                                  style: GoogleFonts.robotoMono(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuccessOverlay() {
    return AnimatedBuilder(
      animation: _successController,
      builder: (context, child) {
        return Opacity(
          opacity: _successOpacityAnimation.value,
          child: Transform.scale(
            scale: _successScaleAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF66BB6A).withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF66BB6A),
                      width: 3,
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 48,
                    color: Color(0xFF66BB6A),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'VERI ACILDI!',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF66BB6A),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.evidenceTitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Keypad butonu
class _KeypadButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _KeypadButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSpecial = label == '<' || label == 'C';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Material(
        color: isSpecial
            ? const Color(0xFF132038)
            : const Color(0xFF1B2D4A),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0xFF00BFA5).withOpacity(0.3),
          child: Container(
            width: 60,
            height: 48,
            alignment: Alignment.center,
            child: label == '<'
                ? const Icon(
                    Icons.backspace_outlined,
                    color: Colors.white70,
                    size: 20,
                  )
                : Text(
                    label,
                    style: GoogleFonts.robotoMono(
                      fontSize: isSpecial ? 14 : 20,
                      fontWeight: FontWeight.bold,
                      color: isSpecial ? Colors.white54 : Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
