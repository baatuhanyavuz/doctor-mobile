import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/credit_transaction.dart';
import '../../../providers/credit_providers.dart';
import 'package:easy_localization/easy_localization.dart';

/// Kredi islem gecmisi listesi
class TransactionHistory extends ConsumerWidget {
  const TransactionHistory({super.key});

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(creditTransactionsProvider);

    return txAsync.when(
      data: (transactions) {
        if (transactions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(Icons.receipt_long, color: Colors.white12, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'store.no_transactions'.tr(),
                    style: GoogleFonts.inter(
                      color: Colors.white30,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return _TransactionTile(transaction: transactions[index]);
          },
        );
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(color: _gold),
        ),
      ),
      error: (err, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Text(
            'store.load_transactions_error'.tr(),
            style: GoogleFonts.inter(color: Colors.white30),
          ),
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final CreditTransaction transaction;

  const _TransactionTile({required this.transaction});

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);

  bool get _isPositive => transaction.amount > 0;

  IconData get _icon {
    final type = transaction.transactionType;
    if (type == 'purchase') return Icons.shopping_cart;
    if (type == 'spend') return Icons.remove_shopping_cart;
    if (type == 'subscription') return Icons.workspace_premium;
    if (type == 'ad_watch') return Icons.play_circle;
    if (type == 'daily_login') return Icons.calendar_today;
    if (type == 'mystery_box') return Icons.card_giftcard;
    if (type == 'achievement') return Icons.emoji_events;
    if (type == 'referral') return Icons.people;
    if (type == 'level_up') return Icons.arrow_upward;
    if (type == 'mini_game') return Icons.sports_esports;
    if (type == 'admin_grant') return Icons.admin_panel_settings;
    return Icons.receipt;
  }

  String get _typeLabel {
    final type = transaction.transactionType;
    if (type == 'purchase') return 'store.tx_purchase'.tr();
    if (type == 'spend') return 'store.tx_spend'.tr();
    if (type == 'subscription') return 'store.tx_subscription'.tr();
    if (type == 'ad_watch') return 'store.tx_ad_watch'.tr();
    if (type == 'daily_login') return 'store.tx_daily_login'.tr();
    if (type == 'mystery_box') return 'store.tx_mystery_box'.tr();
    if (type == 'achievement') return 'store.tx_achievement'.tr();
    if (type == 'referral') return 'store.tx_referral'.tr();
    if (type == 'level_up') return 'store.tx_level_up'.tr();
    if (type == 'mini_game') return 'store.tx_mini_game'.tr();
    if (type == 'admin_grant') return 'store.tx_admin'.tr();
    return type;
  }

  @override
  Widget build(BuildContext context) {
    final color = _isPositive ? _teal : _crimson;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Icon(_icon, color: color.withOpacity(0.6), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                if (transaction.description != null &&
                    transaction.description!.isNotEmpty)
                  Text(
                    transaction.description!,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white24,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            '${_isPositive ? '+' : ''}${transaction.amount}',
            style: GoogleFonts.robotoMono(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
