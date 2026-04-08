import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_providers.dart';
import '../../providers/case_providers.dart';
import '../../providers/credit_providers.dart';
import '../../providers/ppe_provider.dart';
import '../../providers/ethical_dilemma_provider.dart';
import '../../providers/shift_provider.dart';
import '../../../data/models/shift.dart';
import '../../widgets/update_checker.dart';
import '../../widgets/news_ticker.dart';
import '../../../domain/entities/user.dart';
import '../infection_detail_screen.dart';
import '../ethical_board_screen.dart';

/// Klinik — Ana Dashboard Ekranı
///
/// Kullanıcı profilini, rütbesini, istatistiklerini ve
/// ana aksiyonları gösteren medikal temalı giriş ekranı.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // ─── Medikal Renk Paleti ────────────────────────────────────
  static const _bgColor = Color(0xFF0A1628);
  static const _surfaceColor = Color(0xFF0E1D35);
  static const _cardColor = Color(0xFF132038);
  static const _gold = Color(0xFFFFD54F);
  static const _teal = Color(0xFF00BFA5);
  static const _crimson = Color(0xFF66BB6A);

  static String _formatCompact(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 10000) return '${(n / 1000).toStringAsFixed(1)}K';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }

  // ─── Rütbe Hesaplama ────────────────────────────────────────
  static String _getRank(int completedCases) {
    if (completedCases >= 20) return 'dashboard.ranks.chief'.tr();
    if (completedCases >= 10) return 'dashboard.ranks.senior'.tr();
    if (completedCases >= 5) return 'dashboard.ranks.detective'.tr();
    if (completedCases >= 2) return 'dashboard.ranks.apprentice'.tr();
    if (completedCases >= 1) return 'dashboard.ranks.trainee'.tr();
    return 'dashboard.ranks.rookie'.tr();
  }

  static IconData _getRankIcon(int completedCases) {
    if (completedCases >= 20) return Icons.workspace_premium;
    if (completedCases >= 10) return Icons.school;
    if (completedCases >= 5) return Icons.biotech;
    if (completedCases >= 2) return Icons.medical_services;
    if (completedCases >= 1) return Icons.vaccines;
    return Icons.local_hospital;
  }

  static Color _getRankColor(int completedCases) {
    if (completedCases >= 20) return _gold;
    if (completedCases >= 10) return _teal;
    if (completedCases >= 5) return Colors.orangeAccent;
    if (completedCases >= 2) return Colors.blueGrey;
    return Colors.white38;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final completedAsync = ref.watch(completedCaseIdsProvider);
    final completedCount = completedAsync.valueOrNull?.length ?? 0;

    return UpdateChecker(
      child: Scaffold(
        backgroundColor: _bgColor,
        body: authState.maybeWhen(
          authenticated: (user) => _buildDashboard(context, ref, user, completedCount),
          orElse: () => const Center(
            child: CircularProgressIndicator(color: _crimson),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, WidgetRef ref, User user, int completedCases) {
    final rank = _getRank(completedCases);
    final rankIcon = _getRankIcon(completedCases);
    final rankColor = _getRankColor(completedCases);
    final screenHeight = MediaQuery.of(context).size.height;
    final creditState = ref.watch(creditNotifierProvider);
    final creditBalance = creditState.maybeWhen(
      loaded: (b) => _formatCompact(b.balance),
      orElse: () => '--',
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0E1D35), // Medical dark blue top
            Color(0xFF0A1628), // Deep navy bottom
          ],
        ),
      ),
      child: SafeArea(
        child: RefreshIndicator(
          color: _gold,
          backgroundColor: _cardColor,
          onRefresh: () async {
            ref.invalidate(completedCaseIdsProvider);
            ref.invalidate(creditNotifierProvider);
            ref.invalidate(allCasesProvider);
            ref.invalidate(purchasedCaseIdsProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight - MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // ─── Başlık ────────────────────────────────────────
                Text(
                  'dashboard.title'.tr(),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                    color: _teal.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 60,
                  height: 2,
                  color: _teal.withOpacity(0.3),
                ),

                const SizedBox(height: 24),

                // ─── Nöbet Modu ──────────────────────────────────
                const _ShiftStatusCard(),

                const SizedBox(height: 12),

                // ─── Enfeksiyon Durumu ────────────────────────────
                _InfectionStatusCard(),

                const SizedBox(height: 12),

                // ─── İtibar Durumu ────────────────────────────────
                _ReputationCard(),

                const SizedBox(height: 24),

                // ─── Profil Kartı ──────────────────────────────────
                _ProfileCard(
                  user: user,
                  rank: rank,
                  rankIcon: rankIcon,
                  rankColor: rankColor,
                  completedCases: completedCases,
                ),

                const SizedBox(height: 16),

                // ─── Şehir Haberleri ──────────────────────────────
                const NewsTicker(),

                const SizedBox(height: 24),

                // ─── İstatistik Kartları ───────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.stars_rounded,
                        label: 'dashboard.level'.tr(),
                        value: user.level.toString(),
                        color: _gold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.bolt_rounded,
                        label: 'dashboard.total_xp'.tr(),
                        value: '${user.totalXp}',
                        color: _teal,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.task_alt_rounded,
                        label: 'dashboard.solved'.tr(),
                        value: '$completedCases',
                        color: _crimson,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.push('/store'),
                        child: _StatCard(
                          icon: Icons.monetization_on_rounded,
                          label: 'dashboard.credits'.tr(),
                          value: creditBalance,
                          color: _gold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // ─── Ana Aksiyon Butonları ─────────────────────────
                _MainActionButton(
                  icon: Icons.medical_information_rounded,
                  label: 'dashboard.examine_cases'.tr(),
                  subtitle: 'dashboard.examine_cases_desc'.tr(),
                  color: _teal,
                  onTap: () => context.push('/cases'),
                ),

                const SizedBox(height: 16),

                _MainActionButton(
                  icon: Icons.person_rounded,
                  label: 'dashboard.my_profile'.tr(),
                  subtitle: 'dashboard.my_profile_desc'.tr(),
                  color: _gold,
                  onTap: () => context.push('/profile'),
                ),

                const SizedBox(height: 16),

                _MainActionButton(
                  icon: Icons.storefront_rounded,
                  label: 'dashboard.store'.tr(),
                  subtitle: 'dashboard.store_desc'.tr(),
                  color: const Color(0xFF42A5F5),
                  onTap: () => context.push('/store'),
                ),

                const SizedBox(height: 40),

                // ─── Alt Dekorasyon ───────────────────────────────
                Opacity(
                  opacity: 0.15,
                  child: Icon(
                    Icons.local_hospital,
                    size: 80,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

// ─── Profil Kartı Widget ──────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  final User user;
  final String rank;
  final IconData rankIcon;
  final Color rankColor;
  final int completedCases;

  const _ProfileCard({
    required this.user,
    required this.rank,
    required this.rankIcon,
    required this.rankColor,
    required this.completedCases,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DashboardScreen._cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: rankColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: rankColor.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profil Fotoğrafı + İsim
          Row(
            children: [
              // Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: rankColor.withOpacity(0.5), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: rankColor.withOpacity(0.15),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: DashboardScreen._surfaceColor,
                  backgroundImage: user.photoUrl != null
                      ? NetworkImage(user.photoUrl!)
                      : null,
                  child: user.photoUrl == null
                      ? Icon(Icons.person, color: Colors.white30, size: 30)
                      : null,
                ),
              ),
              const SizedBox(width: 16),

              // İsim ve Rütbe
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    // Rütbe Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: rankColor.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(4),
                        color: rankColor.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(rankIcon, color: rankColor, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            rank,
                            style: GoogleFonts.robotoMono(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: rankColor,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // XP Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'dashboard.xp_progress'.tr(),
                    style: GoogleFonts.robotoMono(
                      fontSize: 9,
                      color: Colors.white30,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    'dashboard.level_format'.tr(args: [user.level.toString()]),
                    style: GoogleFonts.robotoMono(
                      fontSize: 9,
                      color: DashboardScreen._gold.withOpacity(0.6),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: (user.totalXp % 100) / 100.0,
                  minHeight: 4,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    DashboardScreen._gold.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── İstatistik Kartı Widget ──────────────────────────────────────
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: DashboardScreen._cardColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.robotoMono(
              fontSize: 8,
              color: Colors.white30,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Ana Aksiyon Butonu Widget ────────────────────────────────────
class _MainActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _MainActionButton({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: color.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: DashboardScreen._cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: color.withOpacity(0.5),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Enfeksiyon durumu kartı — dashboard'da gösterilir
class _InfectionStatusCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ppe = ref.watch(ppeProvider);
    if (!ppe.isInfected) return const SizedBox.shrink();

    final color = _severityColor(ppe.severity);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const InfectionDetailScreen()),
        );
      },
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          // Üst satır — ikon + başlık + şiddet badge
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.coronavirus, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ENFEKSİYON DURUMU',
                      style: GoogleFonts.robotoMono(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ppe.infectionDescription.isNotEmpty
                          ? ppe.infectionDescription
                          : 'KKD eksikliği nedeniyle enfekte oldunuz',
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _severityLabel(ppe.severity),
                  style: GoogleFonts.robotoMono(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Alt satır — iyileşme sayacı + XP cezası
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // İyileşme sayacı
                Icon(Icons.timer, color: color, size: 18),
                const SizedBox(width: 8),
                Text(
                  'İyileşme: ',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Text(
                  ppe.healingTimeFormatted,
                  style: GoogleFonts.robotoMono(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // XP cezası
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF5350).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_down, color: Color(0xFFEF5350), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'XP -%${((1 - ppe.scorePenaltyMultiplier) * 100).round()}',
                        style: GoogleFonts.robotoMono(
                          color: const Color(0xFFEF5350),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Color _severityColor(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none: return const Color(0xFF66BB6A);
      case InfectionSeverity.mild: return const Color(0xFFFFB74D);
      case InfectionSeverity.moderate: return const Color(0xFFFF9800);
      case InfectionSeverity.severe: return const Color(0xFFEF5350);
    }
  }

  String _severityLabel(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none: return 'YOK';
      case InfectionSeverity.mild: return 'HAFİF';
      case InfectionSeverity.moderate: return 'ORTA';
      case InfectionSeverity.severe: return 'AĞIR';
    }
  }
}

/// İtibar durumu kartı — dashboard'da gösterilir
class _ReputationCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reputation = ref.watch(reputationProvider);

    final color = reputation.isInDanger
        ? const Color(0xFFEF5350)
        : reputation.isLow
            ? const Color(0xFFFFB74D)
            : const Color(0xFF00BFA5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF132038),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.gavel, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'İtibar: ${reputation.reputationLevel}',
                  style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: reputation.score / 100,
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation(color),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${reputation.score}',
            style: GoogleFonts.robotoMono(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Etik kurul uyarısı
          if (reputation.ethicalBoardTriggered) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EthicalBoardScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF5350),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'KURUL',
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Nöbet Modu Durumu ─────────────────────────────────────────
class _ShiftStatusCard extends ConsumerWidget {
  const _ShiftStatusCard();

  static const _teal = Color(0xFF00BFA5);
  static const _surface = Color(0xFF132038);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftAsync = ref.watch(activeShiftProvider);

    return shiftAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => _buildStartCard(context),
      data: (shift) {
        if (shift != null && shift.isActive) {
          return _buildActiveCard(context, shift);
        }
        return _buildStartCard(context);
      },
    );
  }

  Widget _buildStartCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/shift'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _teal.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _teal.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.local_hospital, color: _teal, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nöbet Modu',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Acil vaka bildirimleri almak için nöbete başla',
                    style: GoogleFonts.inter(fontSize: 11, color: Colors.white38),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: _teal.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCard(BuildContext context, ShiftStatus shift) {
    return GestureDetector(
      onTap: () {
        if (shift.pendingCase != null) {
          context.push('/shift-case');
        } else {
          context.push('/shift');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _teal, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _teal.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.access_alarm, color: _teal, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'NÖBETTESİNİZ',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _teal,
                          letterSpacing: 1,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        shift.remainingFormatted,
                        style: GoogleFonts.robotoMono(fontSize: 13, color: _teal, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    shift.pendingCase != null
                        ? 'Acil vaka bekliyor!'
                        : '${shift.correctCases}/${shift.totalCases} vaka cozuldu',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: shift.pendingCase != null ? Colors.amber : Colors.white38,
                      fontWeight: shift.pendingCase != null ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
