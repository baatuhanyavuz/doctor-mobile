import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/case.dart';
import '../../../providers/credit_providers.dart';

/// Vaka satin alma onay dialog'u
///
/// Vaka bilgileri, kredi fiyati, bakiye ve promo kodu gosterir.
/// Basarili satin almada `true`, iptal/hata durumunda `false` doner.
class CasePurchaseDialog extends ConsumerStatefulWidget {
  final Case gameCase;

  const CasePurchaseDialog({super.key, required this.gameCase});

  /// Dialog'u goster ve sonucu dondur
  static Future<bool> show(BuildContext context, Case gameCase) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => CasePurchaseDialog(gameCase: gameCase),
        ) ??
        false;
  }

  @override
  ConsumerState<CasePurchaseDialog> createState() =>
      _CasePurchaseDialogState();
}

class _CasePurchaseDialogState extends ConsumerState<CasePurchaseDialog> {
  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);
  static const _bgColor = Color(0xFF132038);

  bool _isLoading = false;
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _purchase() async {
    setState(() => _isLoading = true);

    final promoCode = _promoController.text.trim();
    final errorMsg = await ref.read(creditNotifierProvider.notifier).purchaseCase(
          caseId: widget.gameCase.id,
          promoCode: promoCode.isEmpty ? null : promoCode,
        );

    if (!mounted) return;

    if (errorMsg == null) {
      // Basarili - satin alinan vaka listesini yenile
      ref.invalidate(purchasedCaseIdsProvider);
      Navigator.of(context).pop(true);
    } else {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMsg,
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: _crimson.withOpacity(0.9),
          action: SnackBarAction(
            label: 'store.go_to_store'.tr(),
            textColor: _gold,
            onPressed: () {
              Navigator.of(context).pop(false);
              context.push('/store');
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final creditState = ref.watch(creditNotifierProvider);
    final currentBalance = creditState.maybeWhen(
      loaded: (b) => b.balance,
      orElse: () => 0,
    );
    final creditPrice = widget.gameCase.creditPrice ?? 0;
    final hasEnough = currentBalance >= creditPrice;

    return Dialog(
      backgroundColor: _bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _gold.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Baslik
            Icon(Icons.lock_open_rounded, color: _gold, size: 36),
            const SizedBox(height: 12),
            Text(
              'store.buy_case'.tr(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _gold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),

            // Vaka bilgileri
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.gameCase.title.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _badge(
                        widget.gameCase.difficulty.name.toUpperCase(),
                        Colors.orangeAccent,
                      ),
                      const SizedBox(width: 8),
                      _badge(
                        '$creditPrice ${'store.credit'.tr()}',
                        _gold,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Bakiye bilgisi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mevcut Bakiye:',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.monetization_on_rounded,
                        color: hasEnough ? _gold : _crimson, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$currentBalance',
                      style: GoogleFonts.robotoMono(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: hasEnough ? _gold : _crimson,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            if (!hasEnough) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _crimson.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _crimson.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: _crimson, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Yetersiz kredi! ${creditPrice - currentBalance} kredi daha lazim.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: _crimson,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Promo kodu
            TextField(
              controller: _promoController,
              style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Promo kodu (opsiyonel)',
                hintStyle: GoogleFonts.inter(
                    color: Colors.white24, fontSize: 11),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: _gold.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: _gold.withOpacity(0.6)),
                ),
                isDense: true,
              ),
            ),

            const SizedBox(height: 20),

            // Butonlar
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed:
                        _isLoading ? null : () => Navigator.of(context).pop(false),
                    child: Text(
                      'common.cancel'.tr(),
                      style: GoogleFonts.poppins(
                        color: Colors.white38,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _isLoading || !hasEnough ? null : _purchase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          hasEnough ? _gold.withOpacity(0.2) : Colors.white10,
                      foregroundColor: hasEnough ? _gold : Colors.white30,
                      side: BorderSide(
                        color: hasEnough
                            ? _gold.withOpacity(0.5)
                            : Colors.white10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: _gold),
                          )
                        : hasEnough
                            ? Text(
                                '$creditPrice KREDİ HARCA',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              )
                            : TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  context.push('/store');
                                },
                                icon: const Icon(Icons.storefront, size: 16),
                                label: Text(
                                  'store.go_to_store'.tr(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: _teal,
                                ),
                              ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
        color: color.withOpacity(0.1),
      ),
      child: Text(
        text,
        style: GoogleFonts.robotoMono(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
