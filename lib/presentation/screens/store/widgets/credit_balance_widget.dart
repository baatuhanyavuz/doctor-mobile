import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/credit_providers.dart';

/// Kredi bakiyesi gösteren kompakt widget
///
/// Dashboard ve mağaza ekranlarında kullanılır.
class CreditBalanceWidget extends ConsumerWidget {
  final bool compact;

  const CreditBalanceWidget({super.key, this.compact = false});

  static const _gold = Color(0xFFFFD54F);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditState = ref.watch(creditNotifierProvider);

    return creditState.when(
      initial: () => _buildChip('...'),
      loading: () => _buildChip('...'),
      loaded: (balance) => _buildChip('${balance.balance}'),
      error: (_) => _buildChip('--'),
    );
  }

  Widget _buildChip(String value) {
    if (compact) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on_rounded, color: _gold, size: 18),
          const SizedBox(width: 4),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _gold,
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _gold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.monetization_on_rounded, color: _gold, size: 20),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.robotoMono(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _gold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'KREDİ',
            style: GoogleFonts.robotoMono(
              fontSize: 9,
              color: _gold.withOpacity(0.6),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
