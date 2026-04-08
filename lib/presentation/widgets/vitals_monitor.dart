import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/consumable.dart';
import '../providers/inventory_provider.dart';
import '../providers/ppe_provider.dart';
import '../providers/vitals_provider.dart';

/// Hasta vital bulgularini gosteren monitor widget'i
///
/// Kalp hizi, kan basinci, vucut isisi, SpO2 ve solunum hizi
/// gostergeleri icerir. Degerler normal/uyari/kritik
/// renklendirilir.
class VitalsMonitor extends ConsumerWidget {
  const VitalsMonitor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vitals = ref.watch(vitalsProvider);
    final ppe = ref.watch(ppeProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Enfeksiyon durumu banner (en üstte, kalıcı)
        if (ppe.isInfected) _InfectionBanner(severity: ppe.severity),

        // Kardiyak arrest banner
        if (vitals.condition == PatientCondition.cardiacArrest)
          _CardiacArrestBanner()
        // KOD MAVİ banner (kritik durumda)
        else if (vitals.isCritical)
          _KodMaviBanner(),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1B2A),
            border: Border(
              bottom: BorderSide(
                color: vitals.isCritical
                    ? const Color(0xFFEF5350).withOpacity(0.6)
                    : const Color(0xFF00BFA5).withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Kalp hizi (pulsing animasyonlu)
              _PulsingHeartRate(
                heartRate: vitals.heartRate,
                status: vitals.heartRateStatus,
              ),
              _divider(),
              // Kan basinci
              _VitalItem(
                icon: Icons.speed,
                label: 'KB',
                value: vitals.bloodPressure,
                unit: 'mmHg',
                status: vitals.bloodPressureStatus,
              ),
              _divider(),
              // Vucut isisi
              _VitalItem(
                icon: Icons.thermostat,
                label: '',
                value: vitals.temperature.toStringAsFixed(1),
                unit: '\u00B0C',
                status: vitals.temperatureStatus,
              ),
              _divider(),
              // SpO2
              _VitalItem(
                icon: Icons.water_drop,
                label: 'SpO\u2082',
                value: '${vitals.oxygenSaturation}',
                unit: '%',
                status: vitals.oxygenStatus,
              ),
              _divider(),
              // Solunum hizi
              _VitalItem(
                icon: Icons.air,
                label: 'SH',
                value: '${vitals.respiratoryRate}',
                unit: '/dk',
                status: vitals.respiratoryRateStatus,
              ),
              _divider(),
              // Countdown timer
              _CountdownItem(
                remaining: vitals.remainingTimeFormatted,
                isUrgent: vitals.isTimeUrgent,
                isCritical: vitals.remainingSeconds <= 60,
              ),
            ],
          ),
        ),

        // Stabilizasyon butonları (warning/critical/arrest durumda)
        if (vitals.condition == PatientCondition.cardiacArrest ||
            vitals.isCritical || vitals.hasWarning)
          _StabilizationBar(isArrest: vitals.condition == PatientCondition.cardiacArrest),

        // Hasta konfor butonları (her zaman görünür)
        _ComfortBar(),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 28,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Colors.white10,
    );
  }
}

/// Pulsing animasyonlu kalp hizi gostergesi
class _PulsingHeartRate extends StatefulWidget {
  final int heartRate;
  final VitalStatus status;

  const _PulsingHeartRate({
    required this.heartRate,
    required this.status,
  });

  @override
  State<_PulsingHeartRate> createState() => _PulsingHeartRateState();
}

class _PulsingHeartRateState extends State<_PulsingHeartRate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _durationFromBpm(widget.heartRate),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant _PulsingHeartRate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.heartRate != widget.heartRate) {
      _controller.duration = _durationFromBpm(widget.heartRate);
    }
  }

  Duration _durationFromBpm(int bpm) {
    final msPerBeat = (60000 / bpm.clamp(40, 200)).round();
    return Duration(milliseconds: msPerBeat);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForStatus(widget.status);

    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(
              Icons.favorite,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(width: 4),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.heartRate}',
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                  height: 1.1,
                ),
              ),
              Text(
                'bpm',
                style: GoogleFonts.inter(
                  fontSize: 8,
                  color: color.withOpacity(0.7),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tek bir vital gostergesi
class _VitalItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final VitalStatus status;

  const _VitalItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final color = _colorForStatus(status);

    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 3),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.robotoMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                  height: 1.1,
                ),
              ),
              Text(
                label.isNotEmpty ? '$label $unit' : unit,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  color: color.withOpacity(0.7),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Enfeksiyon durumu kalıcı banner
class _InfectionBanner extends StatelessWidget {
  final InfectionSeverity severity;
  const _InfectionBanner({required this.severity});

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(severity);
    final label = _severityLabel(severity);
    final penalty = _severityPenalty(severity);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      color: color.withOpacity(0.15),
      child: Row(
        children: [
          Icon(Icons.coronavirus, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'BULAŞ: $label',
              style: GoogleFonts.robotoMono(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              penalty,
              style: GoogleFonts.robotoMono(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _severityColor(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none:
        return const Color(0xFF66BB6A);
      case InfectionSeverity.mild:
        return const Color(0xFFFFB74D);
      case InfectionSeverity.moderate:
        return const Color(0xFFFF9800);
      case InfectionSeverity.severe:
        return const Color(0xFFEF5350);
    }
  }

  String _severityLabel(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none:
        return 'YOK';
      case InfectionSeverity.mild:
        return 'HAFİF';
      case InfectionSeverity.moderate:
        return 'ORTA';
      case InfectionSeverity.severe:
        return 'AĞIR';
    }
  }

  String _severityPenalty(InfectionSeverity s) {
    switch (s) {
      case InfectionSeverity.none:
        return '';
      case InfectionSeverity.mild:
        return 'XP -%20';
      case InfectionSeverity.moderate:
        return 'XP -%50';
      case InfectionSeverity.severe:
        return 'XP -%80';
    }
  }
}

/// KOD MAVİ yanıp sönen banner
class _KodMaviBanner extends StatefulWidget {
  @override
  State<_KodMaviBanner> createState() => _KodMaviBannerState();
}

class _KodMaviBannerState extends State<_KodMaviBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 6),
          color: Color.lerp(
            const Color(0xFFEF5350),
            const Color(0xFFB71C1C),
            _controller.value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                'KOD MAVİ — HASTA KRİTİK!',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
            ],
          ),
        );
      },
    );
  }
}

/// Stabilizasyon aksiyon butonları (O₂, IV, Defibrilatör)
class _StabilizationBar extends ConsumerWidget {
  final bool isArrest;
  const _StabilizationBar({this.isArrest = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isArrest ? const Color(0xFF1A0A0A) : const Color(0xFF0D1B2A),
        border: const Border(
          bottom: BorderSide(color: Color(0x33FFFFFF), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            isArrest ? 'ARREST:' : 'ACİL:',
            style: GoogleFonts.robotoMono(
              color: const Color(0xFFEF5350),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          if (isArrest) ...[
            // Arrest durumunda öncelikle defibrilatör
            Expanded(
              flex: 2,
              child: _StabilizeButton(
                icon: Icons.electric_bolt,
                label: 'DEFİBRİLATÖR',
                color: const Color(0xFFFF1744),
                onTap: () {
                  ref.read(vitalsProvider.notifier).applyDefibrillator();
                },
              ),
            ),
            const SizedBox(width: 8),
            _StabilizeButton(
              icon: Icons.air,
              label: 'O₂',
              color: const Color(0xFF42A5F5),
              onTap: () {
                ref.read(vitalsProvider.notifier).applyOxygen();
              },
            ),
          ] else ...[
            _StabilizeButton(
              icon: Icons.air,
              label: 'O₂ Ver',
              color: const Color(0xFF42A5F5),
              onTap: () {
                ref.read(vitalsProvider.notifier).applyOxygen();
              },
            ),
            const SizedBox(width: 8),
            _StabilizeButton(
              icon: Icons.water_drop_outlined,
              label: 'IV Aç',
              color: const Color(0xFF66BB6A),
              onTap: () {
                ref.read(vitalsProvider.notifier).applyIV();
              },
            ),
            const SizedBox(width: 8),
            _StabilizeButton(
              icon: Icons.healing,
              label: 'Stabilize',
              color: const Color(0xFFFFB74D),
              onTap: () {
                ref.read(vitalsProvider.notifier).stabilize();
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _StabilizeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StabilizeButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 14),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: GoogleFonts.robotoMono(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
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

/// Kardiyak arrest yanıp sönen banner
class _CardiacArrestBanner extends StatefulWidget {
  @override
  State<_CardiacArrestBanner> createState() => _CardiacArrestBannerState();
}

class _CardiacArrestBannerState extends State<_CardiacArrestBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          color: Color.lerp(
            const Color(0xFFB71C1C),
            const Color(0xFF000000),
            _controller.value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.electric_bolt, color: Colors.yellow, size: 22),
              const SizedBox(width: 8),
              Text(
                'KARDİYAK ARREST — DEFİBRİLATÖR UYGULA!',
                style: GoogleFonts.robotoMono(
                  color: Colors.yellow,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.electric_bolt, color: Colors.yellow, size: 22),
            ],
          ),
        );
      },
    );
  }
}

/// Hasta konfor butonları (sakinleştirici, ağrı kesici, çay, battaniye)
class _ComfortBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventory = ref.watch(inventoryProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: Color(0xFF0D1B2A),
        border: Border(
          bottom: BorderSide(color: Color(0x22FFFFFF), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          _ComfortButton(
            icon: Icons.medication_liquid,
            label: 'Sakinleştirici',
            count: inventory.count(ConsumableType.sedative),
            color: const Color(0xFF9C27B0),
            onTap: () {
              if (ref.read(inventoryProvider.notifier).use(ConsumableType.sedative)) {
                ref.read(vitalsProvider.notifier).applySedative();
              }
            },
          ),
          const SizedBox(width: 6),
          _ComfortButton(
            icon: Icons.healing,
            label: 'Ağrı Kesici',
            count: inventory.count(ConsumableType.painKiller),
            color: const Color(0xFF2196F3),
            onTap: () {
              if (ref.read(inventoryProvider.notifier).use(ConsumableType.painKiller)) {
                ref.read(vitalsProvider.notifier).applyPainKiller();
              }
            },
          ),
          const SizedBox(width: 6),
          _ComfortButton(
            icon: Icons.local_cafe,
            label: 'Çay',
            count: inventory.count(ConsumableType.tea),
            color: const Color(0xFFFF9800),
            onTap: () {
              if (ref.read(inventoryProvider.notifier).use(ConsumableType.tea)) {
                ref.read(vitalsProvider.notifier).applyTea();
              }
            },
          ),
          const SizedBox(width: 6),
          _ComfortButton(
            icon: Icons.bed,
            label: 'Battaniye',
            count: inventory.count(ConsumableType.blanket),
            color: const Color(0xFF795548),
            onTap: () {
              if (ref.read(inventoryProvider.notifier).use(ConsumableType.blanket)) {
                ref.read(vitalsProvider.notifier).applyBlanket();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ComfortButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const _ComfortButton({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasStock = count > 0;
    return Expanded(
      child: Opacity(
        opacity: hasStock ? 1.0 : 0.3,
        child: GestureDetector(
          onTap: hasStock ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 12),
                    const SizedBox(width: 2),
                    Text(
                      'x$count',
                      style: GoogleFonts.robotoMono(
                        color: color,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  label,
                  style: TextStyle(color: color, fontSize: 7),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Countdown timer göstergesi
class _CountdownItem extends StatelessWidget {
  final String remaining;
  final bool isUrgent;
  final bool isCritical;

  const _CountdownItem({
    required this.remaining,
    required this.isUrgent,
    required this.isCritical,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCritical
        ? const Color(0xFFEF5350)
        : isUrgent
            ? const Color(0xFFFFB74D)
            : Colors.white54;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.timer, color: color, size: 14),
        const SizedBox(width: 3),
        Text(
          remaining,
          style: GoogleFonts.robotoMono(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

Color _colorForStatus(VitalStatus status) {
  switch (status) {
    case VitalStatus.normal:
      return const Color(0xFF66BB6A); // yesil
    case VitalStatus.warning:
      return const Color(0xFFFFB74D); // turuncu
    case VitalStatus.critical:
      return const Color(0xFFEF5350); // kirmizi
  }
}
