import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import '../../data/models/shift.dart';
import '../../data/repositories/shift_repository.dart';

/// Shift repository provider
final shiftRepositoryProvider = Provider<ShiftRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ShiftRepository(dio);
});

/// Aktif nöbet durumu
final activeShiftProvider = StateNotifierProvider<ShiftNotifier, AsyncValue<ShiftStatus?>>(
  (ref) => ShiftNotifier(ref),
);

/// Nöbet geçmişi
final shiftHistoryProvider = FutureProvider.autoDispose<List<ShiftHistoryItem>>((ref) async {
  final repo = ref.watch(shiftRepositoryProvider);
  return repo.getHistory();
});

class ShiftNotifier extends StateNotifier<AsyncValue<ShiftStatus?>> {
  final Ref _ref;
  Timer? _pollTimer;

  ShiftNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadActiveShift();
  }

  ShiftRepository get _repo => _ref.read(shiftRepositoryProvider);

  /// Aktif nöbeti yükle
  Future<void> _loadActiveShift() async {
    try {
      final status = await _repo.getActiveShift();
      if (!mounted) return;
      state = AsyncValue.data(status);
      if (status != null && status.isActive) {
        _startPolling();
      }
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }

  /// Nöbet başlat
  Future<ShiftStatus> startShift({
    required String shiftType,
    required String intensity,
    required int durationHours,
  }) async {
    final result = await _repo.startShift(
      shiftType: shiftType,
      intensity: intensity,
      durationHours: durationHours,
    );
    state = AsyncValue.data(result);
    _startPolling();
    return result;
  }

  /// Vakaya cevap ver
  Future<ShiftStatus> respondToCase({
    required String shiftCaseId,
    required List<Map<String, String>> responses,
  }) async {
    final result = await _repo.respondToCase(
      shiftCaseId: shiftCaseId,
      responses: responses,
    );
    state = AsyncValue.data(result);
    return result;
  }

  /// Nöbeti erken bitir
  Future<ShiftStatus> completeShift() async {
    _stopPolling();
    final result = await _repo.completeShift();
    state = AsyncValue.data(result);
    return result;
  }

  /// Nöbeti iptal et
  Future<void> cancelShift() async {
    _stopPolling();
    await _repo.cancelShift();
    state = const AsyncValue.data(null);
  }

  /// Yenile (bildirim geldiğinde çağrılır)
  Future<void> refresh() async {
    try {
      final status = await _repo.getActiveShift();
      if (!mounted) return;
      state = AsyncValue.data(status);
    } catch (e) {
      debugPrint('[Shift] Refresh error: $e');
    }
  }

  /// Periyodik polling (her 30 saniyede aktif nöbeti kontrol et)
  void _startPolling() {
    _stopPolling();
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      try {
        final status = await _repo.getActiveShift();
        if (!mounted) return;
        state = AsyncValue.data(status);
        if (status == null || !status.isActive) {
          _stopPolling();
        }
      } catch (e) {
        debugPrint('[Shift] Poll error: $e');
      }
    });
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }
}
