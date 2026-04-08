import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/credit_providers.dart';
import 'widgets/credit_balance_widget.dart';
import 'widgets/package_card.dart';
import 'widgets/subscription_card.dart';
import 'widgets/free_credits_section.dart';
import 'widgets/transaction_history.dart';
import 'widgets/bundles_section.dart';
import 'clinic_upgrades_tab.dart';

/// Kredi magazasi ana ekrani
///
/// Kredi paketleri, abonelik planlari, ucretsiz kredi yollari
/// ve islem gecmisini tek ekranda gosterir.
class CreditStoreScreen extends ConsumerStatefulWidget {
  const CreditStoreScreen({super.key});

  @override
  ConsumerState<CreditStoreScreen> createState() => _CreditStoreScreenState();
}

class _CreditStoreScreenState extends ConsumerState<CreditStoreScreen>
    with SingleTickerProviderStateMixin {
  static const _bgColor = Color(0xFF0A1628);
  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF42A5F5);
  static const _crimson = Color(0xFF00BFA5);

  late TabController _tabController;
  int? _purchasingPackageId;
  int? _subscribingPlanId;
  final _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _purchasePackage(int packageId) async {
    // Promo kodu dialog
    final promoCode = await _showPromoDialog();

    setState(() => _purchasingPackageId = packageId);
    try {
      final success = await ref.read(creditNotifierProvider.notifier).purchasePackage(
            packageId: packageId,
            promoCode: promoCode,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'store.purchase_success'.tr() : 'store.purchase_failed'.tr(),
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: success ? _teal.withOpacity(0.9) : _crimson.withOpacity(0.9),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _purchasingPackageId = null);
    }
  }

  Future<void> _subscribe(int planId) async {
    final promoCode = await _showPromoDialog();

    setState(() => _subscribingPlanId = planId);
    try {
      final success = await ref.read(creditNotifierProvider.notifier).subscribe(
            planId: planId,
            promoCode: promoCode,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'store.subscription_started'.tr() : 'store.subscription_failed'.tr(),
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: success ? _teal.withOpacity(0.9) : _crimson.withOpacity(0.9),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _subscribingPlanId = null);
    }
  }

  Future<String?> _showPromoDialog() async {
    _promoController.clear();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF132038),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: _gold.withOpacity(0.3)),
        ),
        title: Text(
          'store.promo_code'.tr(),
          style: GoogleFonts.poppins(
            color: _gold,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),
        content: TextField(
          controller: _promoController,
          style: GoogleFonts.robotoMono(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'store.promo_hint'.tr(),
            hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 12),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _gold.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _gold),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, null),
            child: Text('common.skip'.tr(), style: TextStyle(color: Colors.white38)),
          ),
          TextButton(
            onPressed: () {
              final code = _promoController.text.trim();
              Navigator.pop(ctx, code.isEmpty ? null : code);
            },
            child: Text('common.apply'.tr(), style: TextStyle(color: _gold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeSub = ref.watch(activeSubscriptionProvider);
    final activeSubId = activeSub.valueOrNull?.planId;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white54, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'MAĞAZA',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: _gold.withOpacity(0.8),
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CreditBalanceWidget(compact: true),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _gold,
          indicatorWeight: 2,
          labelColor: _gold,
          unselectedLabelColor: Colors.white30,
          labelStyle: GoogleFonts.robotoMono(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
          isScrollable: true,
          tabs: [
            Tab(text: 'store.packages'.tr()),
            Tab(text: 'ABONELİK'),
            Tab(text: 'KAMPANYA'),
            Tab(text: 'KLİNİK'),
            Tab(text: 'ÜCRETSİZ'),
            Tab(text: 'GEÇMİŞ'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ─── Tab 1: Kredi Paketleri ────────────────────────
          _buildPackagesTab(),

          // ─── Tab 2: Abonelik Planlari ──────────────────────
          _buildSubscriptionsTab(activeSubId),

          // ─── Tab 3: Kampanyalar ────────────────────────────
          const BundlesSection(),

          // ─── Tab 4: Klinik Yükseltmeleri ────────────────────
          const ClinicUpgradesTab(),

          // ─── Tab 4: Ucretsiz Kredi ─────────────────────────
          const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: FreeCreditsSection(),
          ),

          // ─── Tab 4: Islem Gecmisi ──────────────────────────
          const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: TransactionHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    final packagesAsync = ref.watch(creditPackagesProvider);

    return packagesAsync.when(
      data: (packages) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final pkg = packages[index];
          return PackageCard(
            package: pkg,
            isLoading: _purchasingPackageId == pkg.id,
            onPurchase: () => _purchasePackage(pkg.id),
          );
        },
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(color: _gold),
      ),
      error: (err, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: _crimson, size: 40),
            const SizedBox(height: 12),
            Text(
              'store.load_packages_error'.tr(),
              style: GoogleFonts.inter(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionsTab(int? activeSubId) {
    final plansAsync = ref.watch(subscriptionPlansProvider);

    return plansAsync.when(
      data: (plans) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return SubscriptionCard(
            plan: plan,
            isActive: activeSubId != null && activeSubId == plan.id,
            isLoading: _subscribingPlanId == plan.id,
            onSubscribe: () => _subscribe(plan.id),
          );
        },
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(color: _gold),
      ),
      error: (err, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: _crimson, size: 40),
            const SizedBox(height: 12),
            Text(
              'store.load_plans_error'.tr(),
              style: GoogleFonts.inter(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
