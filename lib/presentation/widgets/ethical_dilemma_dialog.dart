import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/ethical_dilemma.dart';
import '../providers/ethical_dilemma_provider.dart';

/// Etik ikilem karar noktası dialog'u.
///
/// Oyuncuya iki seçenek sunar ve seçim sonucunu gösterir.
/// Seçim geri alınamaz.
class EthicalDilemmaDialog extends ConsumerStatefulWidget {
  final EthicalDilemma dilemma;

  /// Seçim yapıldıktan sonra çağrılır (seçilen choice ile)
  final void Function(DilemmaChoice choice)? onChoiceMade;

  const EthicalDilemmaDialog({
    super.key,
    required this.dilemma,
    this.onChoiceMade,
  });

  @override
  ConsumerState<EthicalDilemmaDialog> createState() =>
      _EthicalDilemmaDialogState();
}

class _EthicalDilemmaDialogState extends ConsumerState<EthicalDilemmaDialog>
    with SingleTickerProviderStateMixin {
  DilemmaChoice? _selectedChoice;
  bool _showConsequence = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  static const _amber = Color(0xFFFFB74D);
  static const _teal = Color(0xFF00BFA5);
  static const _red = Color(0xFFEF5350);

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleChoice(DilemmaChoice choice) {
    HapticFeedback.heavyImpact();

    // Reputation güncelle
    ref.read(reputationProvider.notifier).resolveDilemma(
          widget.dilemma,
          choice,
        );

    setState(() {
      _selectedChoice = choice;
      _showConsequence = true;
    });

    widget.onChoiceMade?.call(choice);
  }

  void _closeDialog(BuildContext dialogContext) {
    Navigator.of(dialogContext, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1B2D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _amber.withOpacity(0.4), width: 2),
          boxShadow: [
            BoxShadow(
              color: _amber.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _showConsequence
                ? _buildConsequenceView(context)
                : _buildChoiceView(),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Başlık ikonu
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _pulseAnimation.value,
              child: const Icon(
                Icons.balance,
                size: 48,
                color: _amber,
              ),
            );
          },
        ),
        const SizedBox(height: 12),

        // Başlık
        Text(
          'ETİK İKİLEM',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: _amber,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.dilemma.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Durum açıklaması
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Text(
            widget.dilemma.description,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white70,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Bağlam bilgisi (varsa)
        if (widget.dilemma.contextInfo != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF64B5F6).withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline,
                    color: Color(0xFF64B5F6), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.dilemma.contextInfo!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF64B5F6),
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ] else
          const SizedBox(height: 16),

        // İki seçenek
        if (widget.dilemma.choices.length >= 2) ...[
          _ChoiceButton(
            choice: widget.dilemma.choices[0],
            color: _teal,
            icon: Icons.check_circle_outline,
            onTap: () => _handleChoice(widget.dilemma.choices[0]),
          ),
          const SizedBox(height: 12),
          Text(
            'VEYA',
            style: GoogleFonts.robotoMono(
              fontSize: 11,
              color: Colors.white24,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          _ChoiceButton(
            choice: widget.dilemma.choices[1],
            color: _red,
            icon: Icons.cancel_outlined,
            onTap: () => _handleChoice(widget.dilemma.choices[1]),
          ),
        ],
        const SizedBox(height: 16),
        Text(
          'Bu karar geri alınamaz ve itibar puanınızı etkiler.',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.white24,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildConsequenceView(BuildContext dialogContext) {
    final choice = _selectedChoice!;
    final isEthical = choice.isEthical;
    final color = isEthical ? _teal : _red;
    final reputation = ref.watch(reputationProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isEthical ? Icons.verified : Icons.warning_amber_rounded,
          size: 56,
          color: color,
        ),
        const SizedBox(height: 12),
        Text(
          'KARAR VERİLDİ',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 16),

        // Seçilen seçenek
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                choice.text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                choice.consequence,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // İtibar puanı göstergesi
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: _amber, size: 18),
              const SizedBox(width: 8),
              Text(
                'İtibar: ${reputation.score}/100',
                style: GoogleFonts.robotoMono(
                  fontSize: 13,
                  color: _amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${choice.reputationImpact >= 0 ? '+' : ''}${choice.reputationImpact})',
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  color: choice.reputationImpact >= 0 ? _teal : _red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _closeDialog(dialogContext),
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.15),
              foregroundColor: color,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'DEVAM ET',
              style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final DilemmaChoice choice;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _ChoiceButton({
    required this.choice,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  choice.text,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: color.withOpacity(0.5), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
