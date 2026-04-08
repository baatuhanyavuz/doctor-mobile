import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/shift.dart';
import '../../providers/shift_provider.dart';

class ShiftLobbyScreen extends ConsumerStatefulWidget {
  const ShiftLobbyScreen({super.key});

  @override
  ConsumerState<ShiftLobbyScreen> createState() => _ShiftLobbyScreenState();
}

class _ShiftLobbyScreenState extends ConsumerState<ShiftLobbyScreen> {
  String _selectedType = 'day';
  String _selectedIntensity = 'normal';
  int _selectedDuration = 4;
  bool _isStarting = false;

  static const _bg = Color(0xFF0A1628);
  static const _surface = Color(0xFF132038);
  static const _teal = Color(0xFF00BFA5);
  static const _crimson = Color(0xFFCF6679);
  static const _gold = Color(0xFFFFD54F);

  @override
  Widget build(BuildContext context) {
    final shiftAsync = ref.watch(activeShiftProvider);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          'NÖBET MODU',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: shiftAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: _teal)),
        error: (e, _) => Center(child: Text('Hata: $e', style: const TextStyle(color: _crimson))),
        data: (activeShift) {
          if (activeShift != null && activeShift.isActive) {
            return _buildActiveShift(activeShift);
          }
          return _buildLobby();
        },
      ),
    );
  }

  Widget _buildLobby() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _teal.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.local_hospital, color: _teal, size: 48),
                const SizedBox(height: 12),
                Text(
                  'Nöbete Başla',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nöbet süresince rastgele aralıklarla acil vakalar gelecek. '
                  'Bildirimleri açın ve hazır olun!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Nöbet türü
          _buildSectionTitle('Nöbet Türü'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildTypeCard('day', 'Gündüz', Icons.wb_sunny, Colors.amber),
              const SizedBox(width: 8),
              _buildTypeCard('night', 'Gece', Icons.nightlight_round, Colors.indigo),
              const SizedBox(width: 8),
              _buildTypeCard('weekend', 'Hafta Sonu', Icons.weekend, Colors.deepOrange),
            ],
          ),
          const SizedBox(height: 20),

          // Yoğunluk
          _buildSectionTitle('Yoğunluk'),
          const SizedBox(height: 8),
          _buildIntensityGrid(),
          const SizedBox(height: 20),

          // Süre
          _buildSectionTitle('Nöbet Süresi'),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildDurationCard(4, '4 Saat'),
              const SizedBox(width: 8),
              _buildDurationCard(8, '8 Saat'),
              const SizedBox(width: 8),
              _buildDurationCard(12, '12 Saat'),
            ],
          ),
          const SizedBox(height: 24),

          // Özet
          _buildSummary(),
          const SizedBox(height: 16),

          // Başlat butonu
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: _isStarting ? null : _startShift,
              style: ElevatedButton.styleFrom(
                backgroundColor: _teal,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isStarting
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(
                      'NÖBETİ BAŞLAT',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // Geçmiş nöbetler
          _buildHistorySection(),
        ],
      ),
    );
  }

  Widget _buildActiveShift(ShiftStatus shift) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _teal.withOpacity(0.5), width: 2),
            ),
            child: Column(
              children: [
                const Icon(Icons.access_alarm, color: _teal, size: 56),
                const SizedBox(height: 16),
                Text(
                  'NÖBETTESİNİZ',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _teal,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Kalan: ${shift.remainingFormatted}',
                  style: GoogleFonts.robotoMono(fontSize: 20, color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatChip('Gelen', '${shift.totalCases}', Colors.white70),
                    _buildStatChip('Doğru', '${shift.correctCases}', Colors.greenAccent),
                    _buildStatChip('Yanlış', '${shift.wrongCases}', _crimson),
                    _buildStatChip('Kaçan', '${shift.missedCases}', Colors.orange),
                  ],
                ),
                if (shift.pendingCase != null) ...[
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/shift-case'),
                      icon: const Icon(Icons.warning_amber_rounded),
                      label: Text(
                        'ACİL VAKA BEKLİYOR!',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _completeShift,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _teal,
                    side: const BorderSide(color: _teal),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('NÖBETİ BİTİR', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancelShift,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _crimson,
                    side: const BorderSide(color: _crimson),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('İPTAL ET', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70, letterSpacing: 1),
    );
  }

  Widget _buildTypeCard(String value, String label, IconData icon, Color color) {
    final selected = _selectedType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.2) : _surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? color : Colors.white12),
          ),
          child: Column(
            children: [
              Icon(icon, color: selected ? color : Colors.white38, size: 28),
              const SizedBox(height: 6),
              Text(label, style: GoogleFonts.inter(fontSize: 12, color: selected ? color : Colors.white38, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntensityGrid() {
    const items = [
      ('calm', 'Sakin', '1-2 soru\n90-120dk aralık', Icons.spa, Color(0xFF4CAF50)),
      ('normal', 'Normal', '4-5 soru\n60-90dk aralık', Icons.medical_services, Color(0xFF2196F3)),
      ('intense', 'Yoğun', 'Zor sorular\n30-60dk aralık', Icons.flash_on, Color(0xFFFF9800)),
      ('chaotic', 'Kaotik', 'Tam vaka çözümü\n45-90dk aralık', Icons.local_fire_department, Color(0xFFF44336)),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.6,
      children: items.map((item) {
        final selected = _selectedIntensity == item.$1;
        return GestureDetector(
          onTap: () => setState(() => _selectedIntensity = item.$1),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selected ? item.$5.withOpacity(0.15) : _surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: selected ? item.$5 : Colors.white12, width: selected ? 2 : 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(item.$4, color: selected ? item.$5 : Colors.white38, size: 20),
                    const SizedBox(width: 6),
                    Text(item.$2, style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: selected ? item.$5 : Colors.white54,
                    )),
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.$3, style: GoogleFonts.inter(
                  fontSize: 10,
                  color: selected ? item.$5.withOpacity(0.7) : Colors.white30,
                )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDurationCard(int hours, String label) {
    final selected = _selectedDuration == hours;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedDuration = hours),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? _teal.withOpacity(0.15) : _surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: selected ? _teal : Colors.white12),
          ),
          child: Center(
            child: Text(label, style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? _teal : Colors.white38,
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final typeLabel = {'day': 'Gündüz', 'night': 'Gece', 'weekend': 'Hafta Sonu'}[_selectedType]!;
    final intensityLabel = {'calm': 'Sakin', 'normal': 'Normal', 'intense': 'Yoğun', 'chaotic': 'Kaotik'}[_selectedIntensity]!;
    final xpMultiplier = {'day': '1.0x', 'night': '1.5x', 'weekend': '1.25x'}[_selectedType]!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Tür', typeLabel),
          _buildSummaryRow('Yoğunluk', intensityLabel),
          _buildSummaryRow('Süre', '$_selectedDuration saat'),
          _buildSummaryRow('XP Çarpanı', xpMultiplier),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 13, color: Colors.white54)),
          Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: _teal)),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.robotoMono(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white38)),
      ],
    );
  }

  Widget _buildHistorySection() {
    final historyAsync = ref.watch(shiftHistoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Geçmiş Nöbetler'),
        const SizedBox(height: 8),
        historyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: _teal)),
          error: (_, __) => const SizedBox(),
          data: (history) {
            if (history.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: _surface, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text('Henüz nöbet geçmişiniz yok', style: GoogleFonts.inter(color: Colors.white30, fontSize: 13)),
                ),
              );
            }
            return Column(
              children: history.take(5).map((h) => _buildHistoryCard(h)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHistoryCard(ShiftHistoryItem item) {
    final gradeColor = {
      'S': _gold, 'A': Colors.greenAccent, 'B': _teal,
      'C': Colors.orange, 'D': _crimson, 'F': Colors.red,
    }[item.grade] ?? Colors.white38;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(item.grade ?? '-', style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold, color: gradeColor,
              )),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_typeLabel(item.shiftType)} • ${_intensityLabel(item.intensity)}',
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                Text(
                  '${item.correctCases}/${item.totalCases} doğru • ${item.totalXp} XP',
                  style: GoogleFonts.inter(fontSize: 11, color: Colors.white38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String type) => {'day': 'Gündüz', 'night': 'Gece', 'weekend': 'H.Sonu'}[type] ?? type;
  String _intensityLabel(String i) => {'calm': 'Sakin', 'normal': 'Normal', 'intense': 'Yoğun', 'chaotic': 'Kaotik'}[i] ?? i;

  Future<void> _startShift() async {
    setState(() => _isStarting = true);
    try {
      await ref.read(activeShiftProvider.notifier).startShift(
        shiftType: _selectedType,
        intensity: _selectedIntensity,
        durationHours: _selectedDuration,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: _crimson),
        );
      }
    } finally {
      if (mounted) setState(() => _isStarting = false);
    }
  }

  Future<void> _completeShift() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _surface,
        title: Text('Nöbeti Bitir', style: GoogleFonts.poppins(color: Colors.white)),
        content: Text('Nöbetinizi erken bitirmek istediğinize emin misiniz?', style: GoogleFonts.inter(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('İptal')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Bitir', style: TextStyle(color: _teal)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      final result = await ref.read(activeShiftProvider.notifier).completeShift();
      if (mounted) {
        context.push('/shift-report', extra: result);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: _crimson),
        );
      }
    }
  }

  Future<void> _cancelShift() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _surface,
        title: Text('Nöbeti İptal Et', style: GoogleFonts.poppins(color: Colors.white)),
        content: Text('İptal edilen nöbet F derecesi alır. Emin misiniz?', style: GoogleFonts.inter(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Vazgeç')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('İptal Et', style: TextStyle(color: _crimson)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(activeShiftProvider.notifier).cancelShift();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: $e'), backgroundColor: _crimson),
        );
      }
    }
  }
}
