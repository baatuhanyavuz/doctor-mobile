import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/credit_package.dart';

/// Kredi paketi satın alma kartı
class PackageCard extends StatelessWidget {
  final CreditPackage package;
  final VoidCallback onPurchase;
  final bool isLoading;

  const PackageCard({
    super.key,
    required this.package,
    required this.onPurchase,
    this.isLoading = false,
  });

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _cardColor = Color(0xFF132038);

  String? get _badge {
    final name = package.name.toLowerCase();
    if (name.contains('popüler') || name.contains('popular')) return 'EN ÇOK SATILAN';
    if (name.contains('değerli') || name.contains('best')) return 'EN DEĞERLİ';
    if (name.contains('mega')) return 'MEGA FIRSAT';
    return null;
  }

  Color get _badgeColor {
    final name = package.name.toLowerCase();
    if (name.contains('popüler') || name.contains('popular')) return Colors.orangeAccent;
    if (name.contains('değerli') || name.contains('best')) return _teal;
    if (name.contains('mega')) return Colors.purpleAccent;
    return _gold;
  }

  @override
  Widget build(BuildContext context) {
    final hasBonusCredits = package.bonusCredits > 0;
    final bonusPercent = package.baseCredits > 0
        ? ((package.bonusCredits / package.baseCredits) * 100).round()
        : 0;
    final badge = _badge;
    final isFeatured = badge != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFeatured ? _badgeColor.withOpacity(0.4) : _gold.withOpacity(0.2),
          width: isFeatured ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPurchase,
          borderRadius: BorderRadius.circular(8),
          splashColor: _gold.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Kredi ikonu
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.monetization_on_rounded,
                    color: _gold,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),

                // Paket bilgileri
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              package.name.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _badgeColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: _badgeColor.withOpacity(0.4)),
                              ),
                              child: Text(
                                badge,
                                style: GoogleFonts.robotoMono(
                                  fontSize: 7,
                                  color: _badgeColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${package.totalCredits} Kredi',
                            style: GoogleFonts.robotoMono(
                              fontSize: 13,
                              color: _gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (hasBonusCredits) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: _teal.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: _teal.withOpacity(0.3)),
                              ),
                              child: Text(
                                '+%$bonusPercent BONUS',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 9,
                                  color: _teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Fiyat
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: _gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _gold.withOpacity(0.4)),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: _gold,
                          ),
                        )
                      : Text(
                          '${package.priceTl.toStringAsFixed(0)} ₺',
                          style: GoogleFonts.robotoMono(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _gold,
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
