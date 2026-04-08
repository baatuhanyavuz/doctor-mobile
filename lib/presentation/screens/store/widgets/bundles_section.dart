import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../data/models/case_bundle.dart';
import '../../../providers/bundle_providers.dart';
import '../../../providers/case_providers.dart';
import '../../../providers/credit_providers.dart';

/// Mağaza kampanyalar tab'ı
class BundlesSection extends ConsumerWidget {
  const BundlesSection({super.key});

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);
  static const _surface = Color(0xFF132038);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bundlesAsync = ref.watch(activeBundlesProvider);
    final casesAsync = ref.watch(allCasesProvider);

    return bundlesAsync.when(
      data: (bundles) {
        if (bundles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_offer_outlined, color: Colors.white24, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Şu an aktif kampanya yok',
                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 14),
                ),
              ],
            ),
          );
        }

        final cases = casesAsync.valueOrNull ?? [];

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bundles.length,
          itemBuilder: (context, index) {
            final bundle = bundles[index];
            return _BundleCard(
              bundle: bundle,
              caseNames: bundle.caseIds.map((id) {
                final c = cases.where((cs) => cs.id == id).firstOrNull;
                return c?.title ?? id;
              }).toList(),
              onPurchase: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: const Color(0xFF132038),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: _gold.withOpacity(0.3)),
                    ),
                    title: Text(
                      bundle.name,
                      style: GoogleFonts.poppins(color: _gold, fontSize: 18),
                    ),
                    content: Text(
                      '${bundle.bundlePrice} kredi karşılığında ${bundle.caseIds.length} vakayı satın almak istiyor musunuz?',
                      style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text('İptal', style: TextStyle(color: Colors.white38)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text('Satın Al', style: TextStyle(color: _gold)),
                      ),
                    ],
                  ),
                );
                if (confirm != true) return;

                try {
                  final dio = ref.read(dioProvider);
                  await dio.post(
                    AppConstants.creditsPurchaseBundleEndpoint,
                    data: {'bundleId': bundle.id},
                  );
                  ref.invalidate(creditNotifierProvider);
                  ref.invalidate(purchasedCaseIdsProvider);
                  ref.invalidate(activeBundlesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Kampanya satın alındı! ${bundle.caseIds.length} vaka açıldı.'),
                        backgroundColor: _teal.withOpacity(0.9),
                      ),
                    );
                  }
                } on DioException catch (e) {
                  final msg = e.response?.data is Map ? e.response?.data['message'] : 'Satın alma başarısız';
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg ?? 'Hata oluştu'),
                        backgroundColor: Colors.redAccent.withOpacity(0.9),
                      ),
                    );
                  }
                }
              },
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: _gold),
      ),
      error: (err, _) => Center(
        child: Text('Kampanyalar yüklenemedi', style: TextStyle(color: _crimson)),
      ),
    );
  }
}

class _BundleCard extends StatelessWidget {
  final CaseBundle bundle;
  final List<String> caseNames;
  final VoidCallback? onPurchase;

  const _BundleCard({required this.bundle, required this.caseNames, this.onPurchase});

  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _surface = Color(0xFF132038);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — İndirim badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _gold.withOpacity(0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.local_offer, color: _gold, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bundle.name.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _gold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                  ),
                  child: Text(
                    '%${bundle.discountPercent} İNDİRİM',
                    style: GoogleFonts.robotoMono(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description
          if (bundle.description != null && bundle.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                bundle.description!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.white54,
                  height: 1.5,
                ),
              ),
            ),

          // Case list
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              children: caseNames.map((name) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(Icons.medical_services_outlined, size: 14, color: _teal.withOpacity(0.6)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white60,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),

          // Pricing
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Orijinal fiyat (üstü çizili)
                Text(
                  '${bundle.originalPrice} Kr',
                  style: GoogleFonts.robotoMono(
                    fontSize: 14,
                    color: Colors.white30,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 12),
                // İndirimli fiyat
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _gold.withOpacity(0.3)),
                  ),
                  child: Text(
                    '${bundle.bundlePrice} Kredi',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _gold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${bundle.caseIds.length} vaka',
                  style: GoogleFonts.robotoMono(
                    fontSize: 11,
                    color: Colors.white30,
                  ),
                ),
              ],
            ),
          ),

          // Satın Al Butonu
          if (onPurchase != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: onPurchase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gold.withOpacity(0.15),
                    foregroundColor: _gold,
                    side: BorderSide(color: _gold.withOpacity(0.4)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                  label: Text(
                    'SATIN AL',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
