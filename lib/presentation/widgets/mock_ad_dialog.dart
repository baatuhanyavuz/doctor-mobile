import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Mock reklam dialog'u — gerçek reklam yerine 3 saniye geri sayım gösterir.
/// Test aşamasında 'ATLA' butonu ile hemen geçilebilir.
class MockAdDialog extends StatefulWidget {
  final String reward;
  final IconData rewardIcon;
  final Color rewardColor;

  const MockAdDialog({
    super.key,
    required this.reward,
    this.rewardIcon = Icons.card_giftcard,
    this.rewardColor = const Color(0xFFFFD54F),
  });

  /// Helper: dialog göster ve sonucu döndür (true = reklam tamamlandı)
  static Future<bool> show(
    BuildContext context, {
    required String reward,
    IconData rewardIcon = Icons.card_giftcard,
    Color rewardColor = const Color(0xFFFFD54F),
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => MockAdDialog(
        reward: reward,
        rewardIcon: rewardIcon,
        rewardColor: rewardColor,
      ),
    );
    return result ?? false;
  }

  @override
  State<MockAdDialog> createState() => _MockAdDialogState();
}

class _MockAdDialogState extends State<MockAdDialog> {
  static const _adDuration = 3;
  int _secondsLeft = _adDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDone = _secondsLeft <= 0;

    return Dialog(
      backgroundColor: const Color(0xFF0F1B2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: widget.rewardColor.withOpacity(0.4), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Reklam simülasyon banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.3),
                    Colors.indigo.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.play_circle_fill, color: Colors.white60, size: 56),
                  const SizedBox(height: 8),
                  Text(
                    'REKLAM',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(Mock — Test İçin)',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Reklam sonrası ödül
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.rewardIcon, color: widget.rewardColor, size: 22),
                const SizedBox(width: 8),
                Text(
                  'Ödül: ${widget.reward}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: widget.rewardColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Atla butonu (test için)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isDone ? () => Navigator.of(context).pop(true) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.rewardColor.withOpacity(0.2),
                  foregroundColor: widget.rewardColor,
                  disabledBackgroundColor: Colors.white10,
                  disabledForegroundColor: Colors.white24,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  isDone ? 'ÖDÜLÜ AL' : 'BEKLEYİN... ($_secondsLeft)',
                  style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'VAZGEÇ',
                style: GoogleFonts.robotoMono(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
