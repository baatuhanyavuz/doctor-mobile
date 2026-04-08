import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/network/dio_client.dart';
import '../../data/models/medical_data.dart';
import '../providers/credit_notifier.dart';
import '../providers/credit_providers.dart';
import '../providers/credit_state.dart';
import '../providers/retested_evidences_provider.dart';

/// "Testi Tekrarla" butonu
///
/// Amber/gold tema ile kredi maliyetini gosterir.
/// Tiklandiginda onay diyalogu acar, onaylanirsa backend'e istek atar
/// ve basarili olursa dogru degeri yerel state'e kaydeder.
class RetestButton extends ConsumerStatefulWidget {
  final MedicalData evidence;
  final String? caseId;
  final VoidCallback? onRetestSuccess;

  const RetestButton({
    super.key,
    required this.evidence,
    this.caseId,
    this.onRetestSuccess,
  });

  @override
  ConsumerState<RetestButton> createState() => _RetestButtonState();
}

class _RetestButtonState extends ConsumerState<RetestButton> {
  bool _isLoading = false;

  Future<void> _handleRetest() async {
    final confirmed = await _showConfirmDialog();
    if (confirmed != true || !mounted) return;

    setState(() => _isLoading = true);

    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '/api/dilemma/retest',
        data: {
          'evidenceId': widget.evidence.id,
          'caseId': widget.caseId ?? '',
        },
      );

      if (!mounted) return;

      final data = response.data;
      final correctValue = data['correctValue'] as String? ??
          widget.evidence.correctValue ??
          widget.evidence.resultValue ??
          '';
      final newBalance = data['newBalance'] as int?;

      // Retest durumunu kaydet
      ref
          .read(retestedEvidencesProvider.notifier)
          .markRetested(widget.evidence.id, correctValue);

      // Bakiyeyi guncelle
      if (newBalance != null) {
        ref.read(creditNotifierProvider.notifier).refresh();
      }

      widget.onRetestSuccess?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Test tekrarlandi. Dogru sonuc: $correctValue',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFF2E7D32),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      // Backend 402/400 gibi hatalarda kullaniciya bildir
      String errorMsg = 'Test tekrarlanamadi. Lutfen tekrar deneyin.';
      if (e.toString().contains('402') || e.toString().contains('Yetersiz')) {
        errorMsg = 'Yetersiz kredi. Magaza\'dan kredi satin alabilirsiniz.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: GoogleFonts.inter(fontSize: 13)),
          backgroundColor: const Color(0xFFD32F2F),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<bool?> _showConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            const Icon(Icons.replay, color: Color(0xFFFFB300), size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Testi Tekrarla',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bu testi tekrar yaptirmak ${widget.evidence.retestCost} kredi harcar. Devam etmek istiyor musunuz?',
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            // Mevcut bakiye bilgisi
            Consumer(
              builder: (context, ref, _) {
                final creditState = ref.watch(creditNotifierProvider);
                return creditState.maybeWhen(
                  loaded: (balance) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.account_balance_wallet,
                            size: 14, color: Color(0xFF00BFA5)),
                        const SizedBox(width: 6),
                        Text(
                          'Bakiye: ${balance.balance} Kr',
                          style: GoogleFonts.robotoMono(
                            color: balance.balance >= widget.evidence.retestCost
                                ? const Color(0xFF00BFA5)
                                : const Color(0xFFEF5350),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Vazgec',
              style: GoogleFonts.inter(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB300),
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Onayla',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cost = widget.evidence.retestCost;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _handleRetest,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB300), Color(0xFFFFA000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB300).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.black87),
                    ),
                  )
                else
                  const Icon(Icons.replay, size: 18, color: Colors.black87),
                const SizedBox(width: 8),
                Text(
                  'Testi Tekrarla',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$cost Kr',
                    style: GoogleFonts.robotoMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
