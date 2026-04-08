import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/subscription_plan.dart';

/// Abonelik planı kartı
class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onSubscribe;
  final bool isLoading;
  final bool isActive;

  const SubscriptionCard({
    super.key,
    required this.plan,
    required this.onSubscribe,
    this.isLoading = false,
    this.isActive = false,
  });

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);
  static const _cardColor = Color(0xFF132038);

  @override
  Widget build(BuildContext context) {
    final isYearly = plan.period == 'yearly';
    final periodLabel = isYearly ? 'YILLIK' : 'AYLIK';
    final accentColor = isActive ? _teal : _crimson;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? _teal.withOpacity(0.5) : accentColor.withOpacity(0.2),
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık + Periyot
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.workspace_premium,
                  color: accentColor,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    plan.name.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: accentColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    periodLabel,
                    style: GoogleFonts.robotoMono(
                      fontSize: 9,
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Özellikler
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _featureRow(
                  Icons.monetization_on_rounded,
                  '${plan.creditsPerPeriod} Kredi / $periodLabel',
                  _gold,
                ),
                if (plan.bonusCredits > 0)
                  _featureRow(
                    Icons.card_giftcard,
                    '+${plan.bonusCredits} Bonus Kredi',
                    _teal,
                  ),
                if (plan.isAdFree)
                  _featureRow(Icons.block, 'store.no_ads'.tr(), Colors.white54),
                if (plan.hasBadge)
                  _featureRow(
                      Icons.military_tech, 'store.special_badge'.tr(), Colors.orangeAccent),
                if (plan.hasPriorityAccess)
                  _featureRow(Icons.flash_on, 'store.priority_access'.tr(), _teal),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Fiyat + Buton
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${plan.priceTl.toStringAsFixed(0)} ₺ / ${isYearly ? 'yıl' : 'ay'}',
                    style: GoogleFonts.robotoMono(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _gold,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: _teal.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _teal.withOpacity(0.4)),
                    ),
                    child: Text(
                      'AKTİF',
                      style: GoogleFonts.robotoMono(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _teal,
                      ),
                    ),
                  )
                else
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isLoading ? null : onSubscribe,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: accentColor.withOpacity(0.4)),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: _crimson,
                                ),
                              )
                            : Text(
                                'ABONE OL',
                                style: GoogleFonts.robotoMono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: accentColor,
                                ),
                              ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureRow(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, color: color.withOpacity(0.7), size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
